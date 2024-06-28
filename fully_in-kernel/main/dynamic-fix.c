#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#define INT_MAX 9223372036854775807
#define INT_MIN -9223372036854775807

struct fixed_point
{
    int32_t number;
    int32_t q;
};

static int FIXED_POINT_BITS = 16;

// int32_t to_fixed_point(struct fixed_point integer_num)
// {
//     int32_t number = integer_num.number;
//     return number * ((int32_t)1 << integer_num.q);
// }
// double fix2float(struct fixed_point integer_num)
// {
//     return ((double)integer_num.number / ((int32_t)1 << integer_num.q));
// }

// int32_t float2fix(double number)
// {
//     return (int32_t)(number * ((int32_t)1 << 8));
// }

// void calc_error(int32_t number, double float_num)
// {
//     printf("%d digits for decimal, FIXED: %.16lf, EXPECTED: %.16lf, ERR: %lf%%\n", FIXED_POINT_BITS, fix2float(number), float_num, fabs(fix2float(number) - float_num) / float_num * 100);
// }

// int32_t sign(int32_t number)
// {
//     return number & 0x80000000UL;
// }

// int32_t add(int32_t first, int32_t second)
// {
//     int sign_first = 0;
//     int sign_second = 0;
//     int sum = 0;
//     if (sign(first) == sign(second))
//     {
//         // perform addition (num1 + num2)
//         sign_first = sign(first);
//         sum = first + second;
//     }
//     return sum;
// }

int64_t low32(struct fixed_point *number)
{
    // get the lower 16 bits of the number
    return number->number & 0xFFFF;
}

int64_t high32(struct fixed_point *number)
{
    // get the higher 16 bits of the number
    return number->number >> 16;
}

struct fixed_point to_fixed_point(float number, int32_t fixed_point)
{
    struct fixed_point fixed;
    fixed.number = number * ((int32_t)1 << fixed_point);
    fixed.q = fixed_point;
    return fixed;
}

double fix2float(int32_t number)
{
    return ((double)number / ((int32_t)1 << FIXED_POINT_BITS));
}

int count_zero_64(int64_t x)
{
    int n = 64;
    unsigned y;
    if (x >> 31)
    {
        return -1;
    }

    y = x >> 32;
    if (y != 0)
    {
        n = n - 32;
        x = y;
    }
    y = x >> 16;
    if (y != 0)
    {
        n = n - 16;
        x = y;
    }
    y = x >> 8;
    if (y != 0)
    {
        n = n - 8;
        x = y;
    }
    y = x >> 4;
    if (y != 0)
    {
        n = n - 4;
        x = y;
    }
    y = x >> 2;
    if (y != 0)
    {
        n = n - 2;
        x = y;
    }
    y = x >> 1;
    if (y != 0)
        return n - 2;
    return n - x;
}

int count_zero_32(int64_t x)
{
    int n = 32;
    unsigned y;

        if (x >> 31)
    {
        return -1;
    }

    y = x >> 16;
    if (y != 0)
    {
        n = n - 16;
        x = y;
    }
    y = x >> 8;
    if (y != 0)
    {
        n = n - 8;
        x = y;
    }
    y = x >> 4;
    if (y != 0)
    {
        n = n - 4;
        x = y;
    }
    y = x >> 2;
    if (y != 0)
    {
        n = n - 2;
        x = y;
    }
    y = x >> 1;
    if (y != 0)
        return n - 2;
    return n - x;
}

void check_bit(struct fixed_point *first, struct fixed_point *second)
{
    if (first->q > second->q)
    {
        second->q = first->q;
        second->number = second->number << (first->q - second->q);

    }
    else if (first->q < second->q)
    {
        first->q = second->q;
        first->number = first->number << (second->q - first->q);
    }
}

struct fixed_point add(struct fixed_point *first, struct fixed_point *second)
{
    check_bit(first, second);
    u_int64_t sum = first->number + second->number;
    int32_t allowed_fixed_point_bits = (64 - count_zero_64(sum));
    struct fixed_point result;
    if (allowed_fixed_point_bits < first->q)
    {
        result.q = allowed_fixed_point_bits;
        result.number = (int32_t)(sum >> (first->q - allowed_fixed_point_bits));
        return result;
    }
    else
    {
        result.q = first->q;
        result.number = (int32_t)(sum);
        return result;
    }
}

struct fixed_point subtract(struct fixed_point *first, struct fixed_point *second)
{
    check_bit(first, second);
    u_int64_t sum = first->number - second->number;
    int32_t allowed_fixed_point_bits = (64 - count_zero_64(sum));
    struct fixed_point result;
    if (allowed_fixed_point_bits < first->q)
    {
        result.q = allowed_fixed_point_bits;
        result.number = (int32_t)(sum >> (first->q - allowed_fixed_point_bits));
        return result;
    }
    else
    {
        result.q = first->q;
        result.number = (int32_t)(sum);
        return result;
    }
}

struct fixed_point multi(struct fixed_point *first, struct fixed_point *second)
{
    int32_t high_f = high32(first);
    int32_t low_f = low32(first);
    int32_t high_s = high32(second);
    int32_t low_s = low32(second);

    check_bit(first, second);
    int fixed_point_bits = first->q;
    u_int64_t temp = high_f * high_s;

    if (temp > ((u_int64_t)1 << (32 - fixed_point_bits - 1)))
    {
        fixed_point_bits = 31 - (64 - count_zero_64(temp));
    }
    int32_t q = 0;
    int prod = 0;
    if (fixed_point_bits >= 16)
    {
        q = fixed_point_bits - 16;
        prod = ((int32_t)temp << fixed_point_bits) + (low_f * high_s >> q) + (high_f * low_s >> q) + (low_f * low_s >> 32 - fixed_point_bits);
    }
    else
    {
        q = 16 - fixed_point_bits;
        prod = ((int32_t)temp << fixed_point_bits) + (low_f * high_s << q) + (high_f * low_s << q) + (low_f * low_s >> 32 - fixed_point_bits);
    }
    struct fixed_point result;
    result.number = prod;
    result.q = fixed_point_bits;
    return result;
}

struct fixed_point divide(struct fixed_point *first, struct fixed_point *second)
{
    check_bit(first, second);
    u_int64_t sum = (((int64_t)first->number << 32) / second->number) >> (32 - first->q);
    printf("%d\n", (int32_t)(sum >> first->q));
    int32_t allowed_fixed_point_bits = (64 - count_zero_64(sum));
    struct fixed_point result;
    if (allowed_fixed_point_bits < first->q)
    {
        result.q = allowed_fixed_point_bits;
        result.number = (int32_t)(sum >> (first->q - allowed_fixed_point_bits));
        return result;
    }
    else
    {
        result.q = first->q;
        result.number = (int32_t)(sum);
        return result;
    }
}

struct fixed_point calc_log(struct fixed_point *number)
{
    unsigned long array[256] = {0, 94364, 188362, 281996, 375269, 468184, 560744, 652952, 744809, 836319, 927485, 1018308, 1108792, 1198939, 1288751, 1378232, 1467382, 1556206, 1644705, 1732881, 1820738, 1908276, 1995500, 2082410, 2169009, 2255299, 2341283, 2426962, 2512339, 2597416, 2682195, 2766679, 2850868, 2934765, 3018373, 3101693, 3184727, 3267477, 3349946, 3432134, 3514044, 3595678, 3677037, 3758124, 3838940, 3919487, 3999767, 4079782, 4159533, 4239022, 4318251, 4397221, 4475935, 4554393, 4632598, 4710551, 4788254, 4865708, 4942915, 5019877, 5096595, 5173070, 5249304, 5325299, 5401057, 5476578, 5551863, 5626916, 5701736, 5776326, 5850687, 5924820, 5998727, 6072408, 6145866, 6219102, 6292117, 6364912, 6437489, 6509849, 6581994, 6653924, 6725640, 6797145, 6868440, 6939525, 7010401, 7081071, 7151535, 7221795, 7291851, 7361705, 7431358, 7500811, 7570066, 7639123, 7707983, 7776648, 7845119, 7913396, 7981482, 8049377, 8117081, 8184597, 8251925, 8319066, 8386022, 8452793, 8519380, 8585784, 8652007, 8718049, 8783912, 8849595, 8915101, 8980430, 9045583, 9110562, 9175366, 9239997, 9304456, 9368744, 9432862, 9496810, 9560590, 9624202, 9687648, 9750927, 9814042, 9876992, 9939779, 10002404, 10064867, 10127169, 10189311, 10251295, 10313119, 10374787, 10436297, 10497652, 10558851, 10619897, 10680788, 10741527, 10802114, 10862549, 10922834, 10982970, 11042956, 11102794, 11162484, 11222027, 11281425, 11340677, 11399784, 11458747, 11517567, 11576245, 11634780, 11693174, 11751428, 11809542, 11867516, 11925353, 11983051, 12040612, 12098036, 12155325, 12212478, 12269497, 12326381, 12383133, 12439751, 12496238, 12552593, 12608817, 12664910, 12720874, 12776709, 12832415, 12887994, 12943445, 12998769, 13053968, 13109040, 13163988, 13218811, 13273510, 13328086, 13382539, 13436870, 13491079, 13545167, 13599135, 13652982, 13706710, 13760319, 13813810, 13867182, 13920437, 13973575, 14026597, 14079503, 14132293, 14184969, 14237530, 14289977, 14342311, 14394532, 14446641, 14498637, 14550522, 14602296, 14653960, 14705514, 14756958, 14808293, 14859519, 14910637, 14961647, 15012550, 15063347, 15114037, 15164620, 15215099, 15265472, 15315741, 15365906, 15415967, 15465924, 15515779, 15565531, 15615181, 15664729, 15714177, 15763523, 15812769, 15861915, 15910961, 15959909, 16008757, 16057507, 16106159, 16154714, 16203171, 16251532, 16299796, 16347964, 16396036, 16444013, 16491895, 16539683, 16587376, 16634976, 16682482, 16729895};
    int32_t leading_zero = count_zero_32(number->number);
    if (leading_zero >= 0 && leading_zero < 32) // if return value is positive (negative indicates error)
    {
        // printf("%f\n", ((fix2float((number << (leading_zero + 1)) >> (INTEGER_BITS)))));
        // return to_fixed_point(INTEGER_BITS - 1 - leading_zero) + (unsigned long long)(float2fix(array[(unsigned char)((number << (leading_zero + 1)) >> 56)]));        //return to_fixed_point(INTEGER_BITS - 1 - leading_zero) + (unsigned long long)(float2fix(array[(unsigned char)((number << (leading_zero + 1)) >> 56)]));
        // int32_t allowed_fixed_point_bits = (32 - count_zero_32(leading_zero));
        struct fixed_point result;
        result.q = 8;
        result.number = (unsigned long long)(array[(unsigned char)((number->number << (leading_zero + 1)) >> 56)]);
        result.number = ((31 - number->q - leading_zero) << 24) +  (unsigned long)(array[(unsigned char)((number->number << (leading_zero + 1)) >> 24)]) >> (24 - number->q);
        return result;
        // return to_fixed_point(INTEGER_BITS - 1 - leading_zero) + (unsigned long long)(arry[(unsigned char)((number << (leading_zero + 1)) >> 56)]);
    }
    else
    {
        struct fixed_point result;
        result.q = 8;
        result.number = 0;
        return result;
    }
}

struct fixed_point abs_val(struct fixed_point *number)
{
    int32_t const mask = number->number >> (31);
    number->number = (number->number + mask) ^ mask;
    return *number;
}

int main()
{
    // int k = -10;
    // printf("%d\n", sign(k));
    // k = 10;
    // printf("%d\n", sign(k));

    // float a_f = 1.7;
    // float b_f = 2.69;
    // int32_t a = float2fix(a_f);
    // int32_t b = float2fix(b_f);
    // int32_t c = add(a, b);
    // printf("a: %lf, b: %lf, c: %lf\n", fix2float(a), fix2float(b), fix2float(a_f + b_f));
    // calc_error(c, a_f + b_f);
    float c = 1506.4567;
    float d = 0.23;

    struct fixed_point i = to_fixed_point(c, 16);
    struct fixed_point j = to_fixed_point(d, 16);
    // printf("LOW-LOW: %lld\n", (low32(i) * low32(j)) ); //58015 *  37629
    // printf("LOW-HIGH: %lld\n", (low32(i) * high32(j)) ); //58015 * 6
    // printf("HIGH-LOW: %lld\n", (high32(i) * low32(j)) ); //11 * 37629
    // printf("HIGH-HIGH: %lld\n", (high32(i) * high32(j)) ); // 11 * 6

    // printf("%lld\n", (u_int64_t)((low32(i) * low32(j)) >> FIXED_POINT_BITS) + (low32(i) * high32(j)) + (high32(i) * low32(j)) + ((high32(i) * high32(j)) << 16) > ((u_int64_t)1 << 31));

    // u_int64_t res = ((high32(i) * high32(j)));

    // if (res > ((u_int64_t)1 << (FIXED_POINT_BITS - 1))){
    //     FIXED_POINT_BITS = 31 - (64 - count_zero_64(res));
    //     printf("FIXED_POINT_BITS: %d\n", FIXED_POINT_BITS);
    // }

    // int32_t a = ((low32(i) * low32(j)) >> (32 - FIXED_POINT_BITS)) + (low32(i) * high32(j)) + (high32(i) * low32(j)) + ((high32(i) * high32(j)) <<  FIXED_POINT_BITS);
    // printf("%f %f\n", c * d , fix2float(a));

    struct fixed_point b = multi(&i, &j);
    printf("%f %f\n", c * d, fix2float(b.number));
    b = add(&i, &j);
    printf("%f %f\n", c + d, fix2float(b.number));
    b = divide(&i, &j);
    printf("%f %f\n", c / d, fix2float(b.number));
    b = calc_log(&i);
    printf("log: %f\n", fix2float(b.number));
    return 0;
}
