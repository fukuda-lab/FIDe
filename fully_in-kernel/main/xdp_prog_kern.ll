; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [11 x i32]*, %struct.lpm_v4_key*, i32*, [1 x i32]*, [10000 x i32]* }
%struct.lpm_v4_key = type { i32, i32 }
%struct.anon.0 = type { [2 x i32]*, i32*, %struct.data_value*, [1 x i32]* }
%struct.data_value = type { i32, i32, i32, i32 }
%struct.anon.1 = type { [1 x i32]*, i32*, %struct.logger_value*, [100000 x i32]* }
%struct.logger_value = type { i32, i32, %struct.fixed_point }
%struct.fixed_point = type { i32, i32 }
%struct.anon.2 = type { [2 x i32]*, i32*, %struct.loc_ts*, [1 x i32]* }
%struct.loc_ts = type { %struct.bpf_spin_lock, i64 }
%struct.bpf_spin_lock = type { i32 }
%struct.anon.4 = type { [14 x i32]*, i32*, i32*, [1 x i32]* }
%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.bpf_map = type opaque
%struct.bpf_map.3 = type opaque

@__const.xdp_filter_func.error_log = private unnamed_addr constant [29 x i8] c"Issue with packet size, ETH\0A\00", align 1
@__const.xdp_filter_func.error_log.1 = private unnamed_addr constant [30 x i8] c"Issue with packet size, IPv4\0A\00", align 1
@blacklist = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@__const.xdp_filter_func.error_log.2 = private unnamed_addr constant [25 x i8] c"IP listed on blocklist.\0A\00", align 1
@data = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !74
@__const.xdp_filter_func.error_log.3 = private unnamed_addr constant [38 x i8] c"Error at reading data, the first one\0A\00", align 1
@logger = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !45
@loc_ts = dso_local global %struct.anon.2 zeroinitializer, section ".maps", align 8, !dbg !93
@__const.xdp_filter_func.error_log.4 = private unnamed_addr constant [29 x i8] c"Error at reading time stamp\0A\00", align 1
@count = internal unnamed_addr global i32 0, align 4, !dbg !226
@avg = internal unnamed_addr global %struct.fixed_point zeroinitializer, align 8, !dbg !126
@entropy_all = internal unnamed_addr global %struct.fixed_point zeroinitializer, align 8, !dbg !124
@tx_port = dso_local global %struct.anon.4 zeroinitializer, section ".maps", align 8, !dbg !112
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !39
@__const.calc_log.array = private unnamed_addr constant [256 x i64] [i64 0, i64 94364, i64 188362, i64 281996, i64 375269, i64 468184, i64 560744, i64 652952, i64 744809, i64 836319, i64 927485, i64 1018308, i64 1108792, i64 1198939, i64 1288751, i64 1378232, i64 1467382, i64 1556206, i64 1644705, i64 1732881, i64 1820738, i64 1908276, i64 1995500, i64 2082410, i64 2169009, i64 2255299, i64 2341283, i64 2426962, i64 2512339, i64 2597416, i64 2682195, i64 2766679, i64 2850868, i64 2934765, i64 3018373, i64 3101693, i64 3184727, i64 3267477, i64 3349946, i64 3432134, i64 3514044, i64 3595678, i64 3677037, i64 3758124, i64 3838940, i64 3919487, i64 3999767, i64 4079782, i64 4159533, i64 4239022, i64 4318251, i64 4397221, i64 4475935, i64 4554393, i64 4632598, i64 4710551, i64 4788254, i64 4865708, i64 4942915, i64 5019877, i64 5096595, i64 5173070, i64 5249304, i64 5325299, i64 5401057, i64 5476578, i64 5551863, i64 5626916, i64 5701736, i64 5776326, i64 5850687, i64 5924820, i64 5998727, i64 6072408, i64 6145866, i64 6219102, i64 6292117, i64 6364912, i64 6437489, i64 6509849, i64 6581994, i64 6653924, i64 6725640, i64 6797145, i64 6868440, i64 6939525, i64 7010401, i64 7081071, i64 7151535, i64 7221795, i64 7291851, i64 7361705, i64 7431358, i64 7500811, i64 7570066, i64 7639123, i64 7707983, i64 7776648, i64 7845119, i64 7913396, i64 7981482, i64 8049377, i64 8117081, i64 8184597, i64 8251925, i64 8319066, i64 8386022, i64 8452793, i64 8519380, i64 8585784, i64 8652007, i64 8718049, i64 8783912, i64 8849595, i64 8915101, i64 8980430, i64 9045583, i64 9110562, i64 9175366, i64 9239997, i64 9304456, i64 9368744, i64 9432862, i64 9496810, i64 9560590, i64 9624202, i64 9687648, i64 9750927, i64 9814042, i64 9876992, i64 9939779, i64 10002404, i64 10064867, i64 10127169, i64 10189311, i64 10251295, i64 10313119, i64 10374787, i64 10436297, i64 10497652, i64 10558851, i64 10619897, i64 10680788, i64 10741527, i64 10802114, i64 10862549, i64 10922834, i64 10982970, i64 11042956, i64 11102794, i64 11162484, i64 11222027, i64 11281425, i64 11340677, i64 11399784, i64 11458747, i64 11517567, i64 11576245, i64 11634780, i64 11693174, i64 11751428, i64 11809542, i64 11867516, i64 11925353, i64 11983051, i64 12040612, i64 12098036, i64 12155325, i64 12212478, i64 12269497, i64 12326381, i64 12383133, i64 12439751, i64 12496238, i64 12552593, i64 12608817, i64 12664910, i64 12720874, i64 12776709, i64 12832415, i64 12887994, i64 12943445, i64 12998769, i64 13053968, i64 13109040, i64 13163988, i64 13218811, i64 13273510, i64 13328086, i64 13382539, i64 13436870, i64 13491079, i64 13545167, i64 13599135, i64 13652982, i64 13706710, i64 13760319, i64 13813810, i64 13867182, i64 13920437, i64 13973575, i64 14026597, i64 14079503, i64 14132293, i64 14184969, i64 14237530, i64 14289977, i64 14342311, i64 14394532, i64 14446641, i64 14498637, i64 14550522, i64 14602296, i64 14653960, i64 14705514, i64 14756958, i64 14808293, i64 14859519, i64 14910637, i64 14961647, i64 15012550, i64 15063347, i64 15114037, i64 15164620, i64 15215099, i64 15265472, i64 15315741, i64 15365906, i64 15415967, i64 15465924, i64 15515779, i64 15565531, i64 15615181, i64 15664729, i64 15714177, i64 15763523, i64 15812769, i64 15861915, i64 15910961, i64 15959909, i64 16008757, i64 16057507, i64 16106159, i64 16154714, i64 16203171, i64 16251532, i64 16299796, i64 16347964, i64 16396036, i64 16444013, i64 16491895, i64 16539683, i64 16587376, i64 16634976, i64 16682482, i64 16729895], align 8
@llvm.compiler.used = appending global [7 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon* @blacklist to i8*), i8* bitcast (%struct.anon.0* @data to i8*), i8* bitcast (%struct.anon.2* @loc_ts to i8*), i8* bitcast (%struct.anon.1* @logger to i8*), i8* bitcast (%struct.anon.4* @tx_port to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_filter_func to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_filter_func(%struct.xdp_md* nocapture noundef readonly %0) #0 section "xdp" !dbg !263 {
  %2 = alloca %struct.lpm_v4_key, align 4
  %3 = alloca [29 x i8], align 1
  %4 = alloca [30 x i8], align 1
  %5 = alloca [25 x i8], align 1
  %6 = alloca i32, align 4
  %7 = alloca [38 x i8], align 1
  %8 = alloca %struct.logger_value, align 4
  %9 = alloca [29 x i8], align 1
  %10 = alloca %struct.data_value, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !276, metadata !DIExpression()), !dbg !358
  %11 = tail call i64 inttoptr (i64 5 to i64 ()*)() #7, !dbg !359
  call void @llvm.dbg.value(metadata i64 %11, metadata !277, metadata !DIExpression()), !dbg !358
  %12 = bitcast %struct.lpm_v4_key* %2 to i8*, !dbg !360
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %12) #7, !dbg !360
  call void @llvm.dbg.declare(metadata %struct.lpm_v4_key* %2, metadata !314, metadata !DIExpression()), !dbg !361
  %13 = getelementptr inbounds %struct.lpm_v4_key, %struct.lpm_v4_key* %2, i64 0, i32 0, !dbg !362
  store i32 32, i32* %13, align 4, !dbg !363, !tbaa !364
  %14 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !369
  %15 = load i32, i32* %14, align 4, !dbg !369, !tbaa !370
  %16 = zext i32 %15 to i64, !dbg !372
  %17 = inttoptr i64 %16 to i8*, !dbg !373
  call void @llvm.dbg.value(metadata i8* %17, metadata !278, metadata !DIExpression()), !dbg !358
  %18 = add nuw nsw i64 %16, 14, !dbg !374
  %19 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !375
  %20 = load i32, i32* %19, align 4, !dbg !375, !tbaa !376
  %21 = zext i32 %20 to i64, !dbg !377
  %22 = icmp ugt i64 %18, %21, !dbg !378
  br i1 %22, label %23, label %26, !dbg !379

23:                                               ; preds = %1
  %24 = getelementptr inbounds [29 x i8], [29 x i8]* %3, i64 0, i64 0, !dbg !380
  call void @llvm.lifetime.start.p0i8(i64 29, i8* nonnull %24) #7, !dbg !380
  call void @llvm.dbg.declare(metadata [29 x i8]* %3, metadata !315, metadata !DIExpression()), !dbg !381
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(29) %24, i8* noundef nonnull align 1 dereferenceable(29) getelementptr inbounds ([29 x i8], [29 x i8]* @__const.xdp_filter_func.error_log, i64 0, i64 0), i64 29, i1 false), !dbg !381
  %25 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef nonnull %24, i32 noundef 29) #7, !dbg !382
  call void @llvm.lifetime.end.p0i8(i64 29, i8* nonnull %24) #7, !dbg !383
  br label %183

26:                                               ; preds = %1
  %27 = inttoptr i64 %16 to %struct.ethhdr*, !dbg !373
  call void @llvm.dbg.value(metadata %struct.ethhdr* %27, metadata !278, metadata !DIExpression()), !dbg !358
  %28 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %27, i64 0, i32 2, !dbg !384
  %29 = load i16, i16* %28, align 1, !dbg !384, !tbaa !385
  %30 = icmp eq i16 %29, 8, !dbg !388
  br i1 %30, label %31, label %180, !dbg !389

31:                                               ; preds = %26
  call void @llvm.dbg.value(metadata i8* %17, metadata !291, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !358
  %32 = add nuw nsw i64 %16, 34, !dbg !390
  %33 = icmp ugt i64 %32, %21, !dbg !391
  br i1 %33, label %34, label %37, !dbg !392

34:                                               ; preds = %31
  %35 = getelementptr inbounds [30 x i8], [30 x i8]* %4, i64 0, i64 0, !dbg !393
  call void @llvm.lifetime.start.p0i8(i64 30, i8* nonnull %35) #7, !dbg !393
  call void @llvm.dbg.declare(metadata [30 x i8]* %4, metadata !321, metadata !DIExpression()), !dbg !394
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(30) %35, i8* noundef nonnull align 1 dereferenceable(30) getelementptr inbounds ([30 x i8], [30 x i8]* @__const.xdp_filter_func.error_log.1, i64 0, i64 0), i64 30, i1 false), !dbg !394
  %36 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef nonnull %35, i32 noundef 30) #7, !dbg !395
  call void @llvm.lifetime.end.p0i8(i64 30, i8* nonnull %35) #7, !dbg !396
  br label %183

37:                                               ; preds = %31
  call void @llvm.dbg.value(metadata i8* %17, metadata !291, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !358
  %38 = getelementptr i8, i8* %17, i64 26, !dbg !397
  %39 = bitcast i8* %38 to i32*, !dbg !397
  %40 = load i32, i32* %39, align 4, !dbg !397, !tbaa !398
  %41 = getelementptr inbounds %struct.lpm_v4_key, %struct.lpm_v4_key* %2, i64 0, i32 1, !dbg !400
  store i32 %40, i32* %41, align 4, !dbg !401, !tbaa !402
  %42 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon* @blacklist to i8*), i8* noundef nonnull %12) #7, !dbg !403
  call void @llvm.dbg.value(metadata i8* %42, metadata !329, metadata !DIExpression()), !dbg !404
  %43 = icmp eq i8* %42, null, !dbg !405
  br i1 %43, label %47, label %44, !dbg !406

44:                                               ; preds = %37
  %45 = getelementptr inbounds [25 x i8], [25 x i8]* %5, i64 0, i64 0, !dbg !407
  call void @llvm.lifetime.start.p0i8(i64 25, i8* nonnull %45) #7, !dbg !407
  call void @llvm.dbg.declare(metadata [25 x i8]* %5, metadata !330, metadata !DIExpression()), !dbg !408
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(25) %45, i8* noundef nonnull align 1 dereferenceable(25) getelementptr inbounds ([25 x i8], [25 x i8]* @__const.xdp_filter_func.error_log.2, i64 0, i64 0), i64 25, i1 false), !dbg !408
  %46 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef nonnull %45, i32 noundef 25) #7, !dbg !409
  call void @llvm.lifetime.end.p0i8(i64 25, i8* nonnull %45) #7, !dbg !410
  br label %183

47:                                               ; preds = %37
  %48 = bitcast i32* %6 to i8*, !dbg !411
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %48) #7, !dbg !411
  call void @llvm.dbg.value(metadata i32 0, metadata !336, metadata !DIExpression()), !dbg !404
  store i32 0, i32* %6, align 4, !dbg !412, !tbaa !413
  call void @llvm.dbg.value(metadata i32* %6, metadata !336, metadata !DIExpression(DW_OP_deref)), !dbg !404
  %49 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.0* @data to i8*), i8* noundef nonnull %48) #7, !dbg !414
  call void @llvm.dbg.value(metadata i8* %49, metadata !337, metadata !DIExpression()), !dbg !404
  %50 = icmp eq i8* %49, null, !dbg !415
  br i1 %50, label %65, label %51, !dbg !416

51:                                               ; preds = %47
  %52 = getelementptr inbounds i8, i8* %49, i64 4, !dbg !417
  %53 = bitcast i8* %52 to i32*, !dbg !417
  %54 = atomicrmw add i32* %53, i32 1 seq_cst, align 4, !dbg !417
  %55 = load i32, i32* %53, align 4, !dbg !419, !tbaa !421
  %56 = getelementptr inbounds i8, i8* %49, i64 12, !dbg !423
  %57 = bitcast i8* %56 to i32*, !dbg !423
  %58 = load i32, i32* %57, align 4, !dbg !423, !tbaa !424
  %59 = add nsw i32 %58, -1, !dbg !425
  %60 = shl nsw i32 -1, %59, !dbg !426
  %61 = xor i32 %60, -1, !dbg !426
  %62 = icmp sgt i32 %55, %61, !dbg !427
  br i1 %62, label %63, label %68, !dbg !428

63:                                               ; preds = %51
  %64 = atomicrmw add i32* %57, i32 1 seq_cst, align 4, !dbg !429
  br label %68, !dbg !431

65:                                               ; preds = %47
  %66 = getelementptr inbounds [38 x i8], [38 x i8]* %7, i64 0, i64 0, !dbg !432
  call void @llvm.lifetime.start.p0i8(i64 38, i8* nonnull %66) #7, !dbg !432
  call void @llvm.dbg.declare(metadata [38 x i8]* %7, metadata !338, metadata !DIExpression()), !dbg !433
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(38) %66, i8* noundef nonnull align 1 dereferenceable(38) getelementptr inbounds ([38 x i8], [38 x i8]* @__const.xdp_filter_func.error_log.3, i64 0, i64 0), i64 38, i1 false), !dbg !433
  %67 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef nonnull %66, i32 noundef 38) #7, !dbg !434
  call void @llvm.lifetime.end.p0i8(i64 38, i8* nonnull %66) #7, !dbg !435
  br label %179

68:                                               ; preds = %51, %63
  %69 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.1* @logger to i8*), i8* noundef %38) #7, !dbg !436
  call void @llvm.dbg.value(metadata i8* %69, metadata !344, metadata !DIExpression()), !dbg !404
  %70 = icmp eq i8* %69, null, !dbg !437
  br i1 %70, label %75, label %71, !dbg !438

71:                                               ; preds = %68
  call void @llvm.dbg.value(metadata i8* %69, metadata !344, metadata !DIExpression()), !dbg !404
  %72 = getelementptr inbounds i8, i8* %69, i64 4, !dbg !439
  %73 = bitcast i8* %72 to i32*, !dbg !439
  %74 = atomicrmw add i32* %73, i32 1 seq_cst, align 4, !dbg !439
  br label %82, !dbg !441

75:                                               ; preds = %68
  %76 = bitcast %struct.logger_value* %8 to i8*, !dbg !442
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %76) #7, !dbg !442
  call void @llvm.dbg.declare(metadata %struct.logger_value* %8, metadata !345, metadata !DIExpression()), !dbg !443
  %77 = getelementptr inbounds %struct.logger_value, %struct.logger_value* %8, i64 0, i32 0, !dbg !444
  store i32 0, i32* %77, align 4, !dbg !445, !tbaa !446
  %78 = getelementptr inbounds %struct.logger_value, %struct.logger_value* %8, i64 0, i32 1, !dbg !449
  store i32 1, i32* %78, align 4, !dbg !450, !tbaa !451
  %79 = getelementptr inbounds %struct.logger_value, %struct.logger_value* %8, i64 0, i32 2, i32 1, !dbg !452
  store i32 16, i32* %79, align 4, !dbg !453, !tbaa !454
  %80 = getelementptr inbounds %struct.logger_value, %struct.logger_value* %8, i64 0, i32 2, i32 0, !dbg !455
  store i32 0, i32* %80, align 4, !dbg !456, !tbaa !457
  %81 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* noundef bitcast (%struct.anon.1* @logger to i8*), i8* noundef %38, i8* noundef nonnull %76, i64 noundef 0) #7, !dbg !458
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %76) #7, !dbg !459
  br label %82

82:                                               ; preds = %75, %71
  call void @llvm.dbg.value(metadata i32* %6, metadata !336, metadata !DIExpression(DW_OP_deref)), !dbg !404
  %83 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.2* @loc_ts to i8*), i8* noundef nonnull %48) #7, !dbg !460
  call void @llvm.dbg.value(metadata i8* %83, metadata !348, metadata !DIExpression()), !dbg !404
  %84 = icmp eq i8* %83, null, !dbg !461
  br i1 %84, label %85, label %88, !dbg !462

85:                                               ; preds = %82
  %86 = getelementptr inbounds [29 x i8], [29 x i8]* %9, i64 0, i64 0, !dbg !463
  call void @llvm.lifetime.start.p0i8(i64 29, i8* nonnull %86) #7, !dbg !463
  call void @llvm.dbg.declare(metadata [29 x i8]* %9, metadata !349, metadata !DIExpression()), !dbg !464
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(29) %86, i8* noundef nonnull align 1 dereferenceable(29) getelementptr inbounds ([29 x i8], [29 x i8]* @__const.xdp_filter_func.error_log.4, i64 0, i64 0), i64 29, i1 false), !dbg !464
  %87 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef nonnull %86, i32 noundef 29) #7, !dbg !465
  call void @llvm.lifetime.end.p0i8(i64 29, i8* nonnull %86) #7, !dbg !466
  br label %179

88:                                               ; preds = %82
  %89 = getelementptr inbounds i8, i8* %83, i64 8, !dbg !467
  %90 = bitcast i8* %89 to i64*, !dbg !467
  %91 = load i64, i64* %90, align 8, !dbg !467, !tbaa !468
  %92 = add nsw i64 %91, 1000000000, !dbg !472
  %93 = icmp sgt i64 %11, %92, !dbg !473
  br i1 %93, label %94, label %178, !dbg !474

94:                                               ; preds = %88
  %95 = bitcast i8* %83 to %struct.bpf_spin_lock*, !dbg !475
  %96 = call i64 inttoptr (i64 93 to i64 (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* noundef nonnull %95) #7, !dbg !476
  %97 = load i64, i64* %90, align 8, !dbg !477, !tbaa !468
  %98 = icmp eq i64 %97, 0, !dbg !479
  br i1 %98, label %99, label %101, !dbg !480

99:                                               ; preds = %94
  store i64 %11, i64* %90, align 8, !dbg !481, !tbaa !468
  %100 = call i64 inttoptr (i64 94 to i64 (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* noundef nonnull %95) #7, !dbg !483
  br label %178, !dbg !484

101:                                              ; preds = %94
  %102 = add nsw i64 %97, 1000000000, !dbg !485
  %103 = icmp sgt i64 %11, %102, !dbg !487
  br i1 %103, label %104, label %176, !dbg !488

104:                                              ; preds = %101
  store i64 %11, i64* %90, align 8, !dbg !489, !tbaa !468
  %105 = call i64 inttoptr (i64 94 to i64 (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* noundef nonnull %95) #7, !dbg !491
  %106 = bitcast %struct.data_value* %10 to i8*, !dbg !492
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %106) #7, !dbg !492
  call void @llvm.dbg.declare(metadata %struct.data_value* %10, metadata !352, metadata !DIExpression()), !dbg !493
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 4 dereferenceable(16) %106, i8* noundef nonnull align 4 dereferenceable(16) %49, i64 16, i1 false), !dbg !494
  call void @llvm.dbg.value(metadata %struct.data_value* %10, metadata !355, metadata !DIExpression()), !dbg !495
  %107 = call i64 inttoptr (i64 164 to i64 (i8*, i8*, i8*, i64)*)(i8* noundef bitcast (%struct.anon.1* @logger to i8*), i8* noundef bitcast (i32 (%struct.bpf_map*, i8*, i8*, i8*)* @calc_entropy to i8*), i8* noundef nonnull %106, i64 noundef 0) #7, !dbg !496
  %108 = load i32, i32* @count, align 4, !dbg !497, !tbaa !413
  %109 = load i32, i32* %57, align 4, !dbg !498, !tbaa !424
  call void @llvm.dbg.value(metadata i32 %108, metadata !499, metadata !DIExpression()), !dbg !506
  call void @llvm.dbg.value(metadata i32 %109, metadata !504, metadata !DIExpression()), !dbg !506
  %110 = shl i32 %109, %108, !dbg !508
  call void @llvm.dbg.value(metadata i32 %110, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !506
  call void @llvm.dbg.value(metadata i32 %110, metadata !356, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !495
  call void @llvm.dbg.value(metadata i32 %108, metadata !356, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !495
  call void @llvm.dbg.value(metadata i32 %108, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !506
  call void @llvm.dbg.value(metadata %struct.fixed_point* @entropy_all, metadata !509, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !515, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata %struct.fixed_point* @entropy_all, metadata !521, metadata !DIExpression()) #7, !dbg !527
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !526, metadata !DIExpression()) #7, !dbg !527
  %111 = load i32, i32* getelementptr inbounds (%struct.fixed_point, %struct.fixed_point* @entropy_all, i64 0, i32 1), align 4, !dbg !529, !tbaa !531, !noalias !532
  %112 = icmp sgt i32 %111, %108, !dbg !535
  %113 = call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %112) #7
  %114 = xor i1 %113, true, !dbg !536
  %115 = icmp slt i32 %111, %108
  %116 = select i1 %114, i1 %115, i1 false, !dbg !536
  br i1 %116, label %117, label %118, !dbg !536

117:                                              ; preds = %104
  store i32 %108, i32* getelementptr inbounds (%struct.fixed_point, %struct.fixed_point* @entropy_all, i64 0, i32 1), align 4, !dbg !537, !tbaa !531, !noalias !532
  br label %118, !dbg !540

118:                                              ; preds = %117, %104
  %119 = phi i32 [ %108, %117 ], [ %111, %104 ], !dbg !541
  %120 = load i32, i32* getelementptr inbounds (%struct.fixed_point, %struct.fixed_point* @entropy_all, i64 0, i32 0), align 8, !dbg !542, !tbaa !543, !noalias !532
  %121 = zext i32 %120 to i64, !dbg !544
  %122 = shl nuw i64 %121, 32, !dbg !545
  call void @llvm.dbg.value(metadata i32 %110, metadata !356, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !495
  call void @llvm.dbg.value(metadata i32 %110, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !506
  %123 = sext i32 %110 to i64, !dbg !546
  %124 = udiv i64 %122, %123, !dbg !547
  %125 = sub nsw i32 32, %119, !dbg !548
  %126 = zext i32 %125 to i64, !dbg !549
  %127 = lshr i64 %124, %126, !dbg !549
  call void @llvm.dbg.value(metadata i64 %127, metadata !516, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata i64 %127, metadata !550, metadata !DIExpression()) #7, !dbg !557
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !557
  %128 = icmp ult i64 %127, 2147483648, !dbg !559
  br i1 %128, label %129, label %160, !dbg !561

129:                                              ; preds = %118
  call void @llvm.dbg.value(metadata i64 %127, metadata !556, metadata !DIExpression(DW_OP_constu, 32, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !557
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !557
  call void @llvm.dbg.value(metadata i64 %127, metadata !550, metadata !DIExpression()) #7, !dbg !557
  %130 = lshr i64 %127, 16, !dbg !562
  %131 = trunc i64 %130 to i32, !dbg !563
  call void @llvm.dbg.value(metadata i32 %131, metadata !556, metadata !DIExpression()) #7, !dbg !557
  %132 = icmp eq i32 %131, 0, !dbg !564
  %133 = select i1 %132, i64 %127, i64 %130, !dbg !566
  %134 = select i1 %132, i32 64, i32 48, !dbg !566
  call void @llvm.dbg.value(metadata i32 %134, metadata !555, metadata !DIExpression()) #7, !dbg !557
  call void @llvm.dbg.value(metadata i64 %133, metadata !550, metadata !DIExpression()) #7, !dbg !557
  %135 = lshr i64 %133, 8, !dbg !567
  %136 = trunc i64 %135 to i32, !dbg !568
  call void @llvm.dbg.value(metadata i32 %136, metadata !556, metadata !DIExpression()) #7, !dbg !557
  %137 = icmp eq i32 %136, 0, !dbg !569
  %138 = add nsw i32 %134, -8, !dbg !571
  %139 = select i1 %137, i64 %133, i64 %135, !dbg !571
  %140 = select i1 %137, i32 %134, i32 %138, !dbg !571
  call void @llvm.dbg.value(metadata i32 %140, metadata !555, metadata !DIExpression()) #7, !dbg !557
  call void @llvm.dbg.value(metadata i64 %139, metadata !550, metadata !DIExpression()) #7, !dbg !557
  %141 = lshr i64 %139, 4, !dbg !572
  %142 = trunc i64 %141 to i32, !dbg !573
  call void @llvm.dbg.value(metadata i32 %142, metadata !556, metadata !DIExpression()) #7, !dbg !557
  %143 = icmp eq i32 %142, 0, !dbg !574
  %144 = add nsw i32 %140, -4, !dbg !576
  %145 = select i1 %143, i64 %139, i64 %141, !dbg !576
  %146 = select i1 %143, i32 %140, i32 %144, !dbg !576
  call void @llvm.dbg.value(metadata i32 %146, metadata !555, metadata !DIExpression()) #7, !dbg !557
  call void @llvm.dbg.value(metadata i64 %145, metadata !550, metadata !DIExpression()) #7, !dbg !557
  %147 = lshr i64 %145, 2, !dbg !577
  %148 = trunc i64 %147 to i32, !dbg !578
  call void @llvm.dbg.value(metadata i32 %148, metadata !556, metadata !DIExpression()) #7, !dbg !557
  %149 = icmp eq i32 %148, 0, !dbg !579
  %150 = add nsw i32 %146, -2, !dbg !581
  %151 = select i1 %149, i64 %145, i64 %147, !dbg !581
  %152 = select i1 %149, i32 %146, i32 %150, !dbg !581
  call void @llvm.dbg.value(metadata i32 %152, metadata !555, metadata !DIExpression()) #7, !dbg !557
  call void @llvm.dbg.value(metadata i64 %151, metadata !550, metadata !DIExpression()) #7, !dbg !557
  call void @llvm.dbg.value(metadata i64 %151, metadata !556, metadata !DIExpression(DW_OP_constu, 1, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !557
  %153 = and i64 %151, 8589934590, !dbg !582
  %154 = icmp eq i64 %153, 0, !dbg !582
  br i1 %154, label %157, label %155, !dbg !584

155:                                              ; preds = %129
  %156 = add nsw i32 %152, -2, !dbg !585
  br label %160, !dbg !586

157:                                              ; preds = %129
  %158 = trunc i64 %151 to i32, !dbg !587
  %159 = sub nsw i32 %152, %158, !dbg !587
  br label %160, !dbg !588

160:                                              ; preds = %157, %155, %118
  %161 = phi i32 [ %156, %155 ], [ %159, %157 ], [ -1, %118 ], !dbg !557
  %162 = sub nsw i32 64, %161, !dbg !589
  call void @llvm.dbg.value(metadata i32 %162, metadata !517, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !518, metadata !DIExpression()) #7, !dbg !590
  %163 = icmp sgt i32 %119, %162, !dbg !591
  %164 = sub nsw i32 %119, %162, !dbg !593
  %165 = select i1 %163, i32 %162, i32 %119, !dbg !593
  %166 = select i1 %163, i32 %164, i32 0, !dbg !593
  %167 = zext i32 %166 to i64, !dbg !593
  %168 = lshr i64 %127, %167, !dbg !593
  %169 = zext i32 %165 to i64, !dbg !594
  %170 = shl nuw i64 %169, 32, !dbg !594
  %171 = and i64 %168, 4294967295, !dbg !594
  %172 = or i64 %171, %170, !dbg !594
  store i64 %172, i64* bitcast (%struct.fixed_point* @avg to i64*), align 8, !dbg !594
  %173 = call i64 inttoptr (i64 164 to i64 (i8*, i8*, i8*, i64)*)(i8* noundef bitcast (%struct.anon.1* @logger to i8*), i8* noundef bitcast (i32 (%struct.bpf_map.3*, i8*, i8*, i8*)* @detection to i8*), i8* noundef nonnull %106, i64 noundef 0) #7, !dbg !595
  %174 = load i32, i32* %53, align 4, !dbg !596, !tbaa !421
  %175 = bitcast i8* %49 to i32*, !dbg !597
  store i32 %174, i32* %175, align 4, !dbg !598, !tbaa !599
  store i32 0, i32* %53, align 4, !dbg !600, !tbaa !421
  store i32 4, i32* %57, align 4, !dbg !601, !tbaa !424
  store i32 0, i32* @count, align 4, !dbg !602, !tbaa !413
  store i32 0, i32* getelementptr inbounds (%struct.fixed_point, %struct.fixed_point* @entropy_all, i64 0, i32 0), align 8, !dbg !603, !tbaa !543
  store i32 16, i32* getelementptr inbounds (%struct.fixed_point, %struct.fixed_point* @entropy_all, i64 0, i32 1), align 4, !dbg !604, !tbaa !531
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %106) #7, !dbg !605
  br label %178, !dbg !606

176:                                              ; preds = %101
  %177 = call i64 inttoptr (i64 94 to i64 (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* noundef nonnull %95) #7, !dbg !607
  br label %178, !dbg !609

178:                                              ; preds = %99, %176, %160, %88
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %48) #7, !dbg !610
  br label %180

179:                                              ; preds = %65, %85
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %48) #7, !dbg !610
  br label %183

180:                                              ; preds = %178, %26
  call void @llvm.dbg.label(metadata !357), !dbg !611
  %181 = call i64 inttoptr (i64 51 to i64 (i8*, i64, i64)*)(i8* noundef bitcast (%struct.anon.4* @tx_port to i8*), i64 noundef 0, i64 noundef 0) #7, !dbg !612
  %182 = trunc i64 %181 to i32, !dbg !612
  br label %183, !dbg !613

183:                                              ; preds = %179, %44, %180, %34, %23
  %184 = phi i32 [ 2, %23 ], [ 2, %34 ], [ 2, %179 ], [ %182, %180 ], [ 1, %44 ], !dbg !358
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %12) #7, !dbg !614
  ret i32 %184, !dbg !614
}

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: mustprogress nounwind willreturn
define internal i32 @calc_entropy(%struct.bpf_map* nocapture noundef readnone %0, i8* nocapture noundef readnone %1, i8* nocapture noundef %2, i8* nocapture noundef readonly %3) #4 !dbg !615 {
  call void @llvm.dbg.value(metadata %struct.bpf_map* %0, metadata !621, metadata !DIExpression()), !dbg !639
  call void @llvm.dbg.value(metadata i8* %1, metadata !622, metadata !DIExpression()), !dbg !639
  call void @llvm.dbg.value(metadata i8* %2, metadata !623, metadata !DIExpression()), !dbg !639
  call void @llvm.dbg.value(metadata i8* %3, metadata !624, metadata !DIExpression()), !dbg !639
  call void @llvm.dbg.value(metadata i8* %3, metadata !625, metadata !DIExpression()), !dbg !639
  call void @llvm.dbg.value(metadata i8* %2, metadata !626, metadata !DIExpression()), !dbg !639
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !627, metadata !DIExpression()), !dbg !640
  %5 = getelementptr inbounds i8, i8* %2, i64 4, !dbg !641
  %6 = bitcast i8* %5 to i32*, !dbg !641
  %7 = load i32, i32* %6, align 4, !dbg !641, !tbaa !451
  %8 = getelementptr inbounds i8, i8* %3, i64 12, !dbg !642
  %9 = bitcast i8* %8 to i32*, !dbg !642
  %10 = load i32, i32* %9, align 4, !dbg !642, !tbaa !424
  call void @llvm.dbg.value(metadata i32 %7, metadata !499, metadata !DIExpression()), !dbg !643
  call void @llvm.dbg.value(metadata i32 %10, metadata !504, metadata !DIExpression()), !dbg !643
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !505, metadata !DIExpression()), !dbg !645
  %11 = shl i32 %10, %7, !dbg !646
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !628, metadata !DIExpression()), !dbg !647
  %12 = bitcast i8* %2 to i32*, !dbg !648
  %13 = load i32, i32* %12, align 4, !dbg !648, !tbaa !446
  call void @llvm.dbg.value(metadata i32 %13, metadata !499, metadata !DIExpression()), !dbg !649
  call void @llvm.dbg.value(metadata i32 %10, metadata !504, metadata !DIExpression()), !dbg !649
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !505, metadata !DIExpression()), !dbg !651
  %14 = shl i32 %10, %13, !dbg !652
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !629, metadata !DIExpression()), !dbg !653
  %15 = bitcast i8* %3 to i32*, !dbg !654
  %16 = load i32, i32* %15, align 4, !dbg !654, !tbaa !599
  call void @llvm.dbg.value(metadata i32 %16, metadata !499, metadata !DIExpression()), !dbg !655
  call void @llvm.dbg.value(metadata i32 %10, metadata !504, metadata !DIExpression()), !dbg !655
  %17 = shl i32 %10, %16, !dbg !657
  call void @llvm.dbg.value(metadata i32 %17, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !655
  call void @llvm.dbg.value(metadata i32 %17, metadata !630, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !639
  call void @llvm.dbg.value(metadata i32 %16, metadata !630, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !639
  call void @llvm.dbg.value(metadata i32 %16, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !655
  call void @llvm.dbg.value(metadata i32 1, metadata !499, metadata !DIExpression()), !dbg !658
  call void @llvm.dbg.value(metadata i32 %10, metadata !504, metadata !DIExpression()), !dbg !658
  %18 = shl i32 %10, 1, !dbg !660
  call void @llvm.dbg.value(metadata i32 %18, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !658
  call void @llvm.dbg.value(metadata i32 %18, metadata !631, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !639
  call void @llvm.dbg.value(metadata i32 1, metadata !631, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !639
  call void @llvm.dbg.value(metadata i32 1, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !658
  call void @llvm.dbg.value(metadata i32 10, metadata !499, metadata !DIExpression()), !dbg !661
  call void @llvm.dbg.value(metadata i32 %10, metadata !504, metadata !DIExpression()), !dbg !661
  %19 = shl i32 %10, 10, !dbg !663
  call void @llvm.dbg.value(metadata i32 %19, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !661
  call void @llvm.dbg.value(metadata i32 %19, metadata !632, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !639
  call void @llvm.dbg.value(metadata i32 10, metadata !632, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !639
  call void @llvm.dbg.value(metadata i32 10, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !661
  %20 = icmp eq i32 %13, 0, !dbg !664
  br i1 %20, label %23, label %21, !dbg !666

21:                                               ; preds = %4
  %22 = icmp eq i32 %7, 0, !dbg !667
  br i1 %22, label %75, label %130, !dbg !668

23:                                               ; preds = %4
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !509, metadata !DIExpression()) #7, !dbg !669
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !515, metadata !DIExpression()) #7, !dbg !669
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !521, metadata !DIExpression()) #7, !dbg !674
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !526, metadata !DIExpression()) #7, !dbg !674
  %24 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 false) #7
  %25 = select i1 %24, i32 1, i32 10, !dbg !676
  call void @llvm.dbg.value(metadata i32 %25, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !658
  call void @llvm.dbg.value(metadata i32 %25, metadata !631, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !639
  call void @llvm.dbg.value(metadata i32 %25, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !661
  call void @llvm.dbg.value(metadata i32 %25, metadata !632, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !639
  call void @llvm.dbg.value(metadata i32 %18, metadata !631, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !639
  call void @llvm.dbg.value(metadata i32 %18, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !658
  %26 = zext i32 %18 to i64, !dbg !677
  %27 = shl nuw i64 %26, 32, !dbg !678
  call void @llvm.dbg.value(metadata i32 %19, metadata !632, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !639
  call void @llvm.dbg.value(metadata i32 %19, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !661
  %28 = sext i32 %19 to i64, !dbg !679
  %29 = udiv i64 %27, %28, !dbg !680
  %30 = sub nuw nsw i32 32, %25, !dbg !681
  %31 = zext i32 %30 to i64, !dbg !682
  %32 = lshr i64 %29, %31, !dbg !682
  call void @llvm.dbg.value(metadata i64 %32, metadata !516, metadata !DIExpression()) #7, !dbg !669
  call void @llvm.dbg.value(metadata i64 %32, metadata !550, metadata !DIExpression()) #7, !dbg !683
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !683
  %33 = icmp ult i64 %32, 2147483648, !dbg !685
  br i1 %33, label %34, label %65, !dbg !686

34:                                               ; preds = %23
  call void @llvm.dbg.value(metadata i64 %32, metadata !556, metadata !DIExpression(DW_OP_constu, 32, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !683
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !683
  call void @llvm.dbg.value(metadata i64 %32, metadata !550, metadata !DIExpression()) #7, !dbg !683
  %35 = lshr i64 %32, 16, !dbg !687
  %36 = trunc i64 %35 to i32, !dbg !688
  call void @llvm.dbg.value(metadata i32 %36, metadata !556, metadata !DIExpression()) #7, !dbg !683
  %37 = icmp eq i32 %36, 0, !dbg !689
  %38 = select i1 %37, i64 %32, i64 %35, !dbg !690
  %39 = select i1 %37, i32 64, i32 48, !dbg !690
  call void @llvm.dbg.value(metadata i32 %39, metadata !555, metadata !DIExpression()) #7, !dbg !683
  call void @llvm.dbg.value(metadata i64 %38, metadata !550, metadata !DIExpression()) #7, !dbg !683
  %40 = lshr i64 %38, 8, !dbg !691
  %41 = trunc i64 %40 to i32, !dbg !692
  call void @llvm.dbg.value(metadata i32 %41, metadata !556, metadata !DIExpression()) #7, !dbg !683
  %42 = icmp eq i32 %41, 0, !dbg !693
  %43 = add nsw i32 %39, -8, !dbg !694
  %44 = select i1 %42, i64 %38, i64 %40, !dbg !694
  %45 = select i1 %42, i32 %39, i32 %43, !dbg !694
  call void @llvm.dbg.value(metadata i32 %45, metadata !555, metadata !DIExpression()) #7, !dbg !683
  call void @llvm.dbg.value(metadata i64 %44, metadata !550, metadata !DIExpression()) #7, !dbg !683
  %46 = lshr i64 %44, 4, !dbg !695
  %47 = trunc i64 %46 to i32, !dbg !696
  call void @llvm.dbg.value(metadata i32 %47, metadata !556, metadata !DIExpression()) #7, !dbg !683
  %48 = icmp eq i32 %47, 0, !dbg !697
  %49 = add nsw i32 %45, -4, !dbg !698
  %50 = select i1 %48, i64 %44, i64 %46, !dbg !698
  %51 = select i1 %48, i32 %45, i32 %49, !dbg !698
  call void @llvm.dbg.value(metadata i32 %51, metadata !555, metadata !DIExpression()) #7, !dbg !683
  call void @llvm.dbg.value(metadata i64 %50, metadata !550, metadata !DIExpression()) #7, !dbg !683
  %52 = lshr i64 %50, 2, !dbg !699
  %53 = trunc i64 %52 to i32, !dbg !700
  call void @llvm.dbg.value(metadata i32 %53, metadata !556, metadata !DIExpression()) #7, !dbg !683
  %54 = icmp eq i32 %53, 0, !dbg !701
  %55 = add nsw i32 %51, -2, !dbg !702
  %56 = select i1 %54, i64 %50, i64 %52, !dbg !702
  %57 = select i1 %54, i32 %51, i32 %55, !dbg !702
  call void @llvm.dbg.value(metadata i32 %57, metadata !555, metadata !DIExpression()) #7, !dbg !683
  call void @llvm.dbg.value(metadata i64 %56, metadata !550, metadata !DIExpression()) #7, !dbg !683
  call void @llvm.dbg.value(metadata i64 %56, metadata !556, metadata !DIExpression(DW_OP_constu, 1, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !683
  %58 = and i64 %56, 8589934590, !dbg !703
  %59 = icmp eq i64 %58, 0, !dbg !703
  br i1 %59, label %62, label %60, !dbg !704

60:                                               ; preds = %34
  %61 = add nsw i32 %57, -2, !dbg !705
  br label %65, !dbg !706

62:                                               ; preds = %34
  %63 = trunc i64 %56 to i32, !dbg !707
  %64 = sub nsw i32 %57, %63, !dbg !707
  br label %65, !dbg !708

65:                                               ; preds = %62, %60, %23
  %66 = phi i32 [ %61, %60 ], [ %64, %62 ], [ -1, %23 ], !dbg !683
  %67 = sub nsw i32 64, %66, !dbg !709
  call void @llvm.dbg.value(metadata i32 %67, metadata !517, metadata !DIExpression()) #7, !dbg !669
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !518, metadata !DIExpression()) #7, !dbg !710
  %68 = icmp ugt i32 %25, %67, !dbg !711
  %69 = select i1 %68, i32 %67, i32 %25, !dbg !712
  %70 = tail call i32 @llvm.usub.sat.i32(i32 %25, i32 %67), !dbg !712
  %71 = zext i32 %70 to i64, !dbg !712
  %72 = lshr i64 %32, %71, !dbg !712
  %73 = trunc i64 %72 to i32, !dbg !713
  call void @llvm.dbg.value(metadata i32 %25, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !658
  call void @llvm.dbg.value(metadata i32 %25, metadata !631, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !639
  call void @llvm.dbg.value(metadata i32 %25, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !661
  call void @llvm.dbg.value(metadata i32 %25, metadata !632, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !639
  %74 = icmp eq i32 %7, 0, !dbg !714
  br i1 %74, label %78, label %130, !dbg !716

75:                                               ; preds = %21
  call void @llvm.dbg.value(metadata i32 %25, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !658
  call void @llvm.dbg.value(metadata i32 %25, metadata !631, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !639
  call void @llvm.dbg.value(metadata i32 %25, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !661
  call void @llvm.dbg.value(metadata i32 %25, metadata !632, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !639
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !509, metadata !DIExpression()) #7, !dbg !717
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !515, metadata !DIExpression()) #7, !dbg !717
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !521, metadata !DIExpression()) #7, !dbg !720
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !526, metadata !DIExpression()) #7, !dbg !720
  %76 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 false) #7
  br i1 %76, label %78, label %77, !dbg !722

77:                                               ; preds = %75
  br label %78, !dbg !723

78:                                               ; preds = %65, %75, %77
  %79 = phi i32 [ %73, %65 ], [ %14, %75 ], [ %14, %77 ], !dbg !639
  %80 = phi i32 [ %69, %65 ], [ %13, %75 ], [ %13, %77 ]
  %81 = phi i32 [ %25, %65 ], [ 1, %75 ], [ 10, %77 ], !dbg !724
  call void @llvm.dbg.value(metadata i32 %18, metadata !631, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !639
  call void @llvm.dbg.value(metadata i32 %18, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !658
  %82 = zext i32 %18 to i64, !dbg !725
  %83 = shl nuw i64 %82, 32, !dbg !726
  call void @llvm.dbg.value(metadata i32 %19, metadata !632, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !639
  call void @llvm.dbg.value(metadata i32 %19, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !661
  %84 = sext i32 %19 to i64, !dbg !727
  %85 = udiv i64 %83, %84, !dbg !728
  %86 = sub nuw nsw i32 32, %81, !dbg !729
  %87 = zext i32 %86 to i64, !dbg !730
  %88 = lshr i64 %85, %87, !dbg !730
  call void @llvm.dbg.value(metadata i64 %88, metadata !516, metadata !DIExpression()) #7, !dbg !717
  call void @llvm.dbg.value(metadata i64 %88, metadata !550, metadata !DIExpression()) #7, !dbg !731
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !731
  %89 = icmp ult i64 %88, 2147483648, !dbg !733
  br i1 %89, label %90, label %121, !dbg !734

90:                                               ; preds = %78
  call void @llvm.dbg.value(metadata i64 %88, metadata !556, metadata !DIExpression(DW_OP_constu, 32, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !731
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !731
  call void @llvm.dbg.value(metadata i64 %88, metadata !550, metadata !DIExpression()) #7, !dbg !731
  %91 = lshr i64 %88, 16, !dbg !735
  %92 = trunc i64 %91 to i32, !dbg !736
  call void @llvm.dbg.value(metadata i32 %92, metadata !556, metadata !DIExpression()) #7, !dbg !731
  %93 = icmp eq i32 %92, 0, !dbg !737
  %94 = select i1 %93, i64 %88, i64 %91, !dbg !738
  %95 = select i1 %93, i32 64, i32 48, !dbg !738
  call void @llvm.dbg.value(metadata i32 %95, metadata !555, metadata !DIExpression()) #7, !dbg !731
  call void @llvm.dbg.value(metadata i64 %94, metadata !550, metadata !DIExpression()) #7, !dbg !731
  %96 = lshr i64 %94, 8, !dbg !739
  %97 = trunc i64 %96 to i32, !dbg !740
  call void @llvm.dbg.value(metadata i32 %97, metadata !556, metadata !DIExpression()) #7, !dbg !731
  %98 = icmp eq i32 %97, 0, !dbg !741
  %99 = add nsw i32 %95, -8, !dbg !742
  %100 = select i1 %98, i64 %94, i64 %96, !dbg !742
  %101 = select i1 %98, i32 %95, i32 %99, !dbg !742
  call void @llvm.dbg.value(metadata i32 %101, metadata !555, metadata !DIExpression()) #7, !dbg !731
  call void @llvm.dbg.value(metadata i64 %100, metadata !550, metadata !DIExpression()) #7, !dbg !731
  %102 = lshr i64 %100, 4, !dbg !743
  %103 = trunc i64 %102 to i32, !dbg !744
  call void @llvm.dbg.value(metadata i32 %103, metadata !556, metadata !DIExpression()) #7, !dbg !731
  %104 = icmp eq i32 %103, 0, !dbg !745
  %105 = add nsw i32 %101, -4, !dbg !746
  %106 = select i1 %104, i64 %100, i64 %102, !dbg !746
  %107 = select i1 %104, i32 %101, i32 %105, !dbg !746
  call void @llvm.dbg.value(metadata i32 %107, metadata !555, metadata !DIExpression()) #7, !dbg !731
  call void @llvm.dbg.value(metadata i64 %106, metadata !550, metadata !DIExpression()) #7, !dbg !731
  %108 = lshr i64 %106, 2, !dbg !747
  %109 = trunc i64 %108 to i32, !dbg !748
  call void @llvm.dbg.value(metadata i32 %109, metadata !556, metadata !DIExpression()) #7, !dbg !731
  %110 = icmp eq i32 %109, 0, !dbg !749
  %111 = add nsw i32 %107, -2, !dbg !750
  %112 = select i1 %110, i64 %106, i64 %108, !dbg !750
  %113 = select i1 %110, i32 %107, i32 %111, !dbg !750
  call void @llvm.dbg.value(metadata i32 %113, metadata !555, metadata !DIExpression()) #7, !dbg !731
  call void @llvm.dbg.value(metadata i64 %112, metadata !550, metadata !DIExpression()) #7, !dbg !731
  call void @llvm.dbg.value(metadata i64 %112, metadata !556, metadata !DIExpression(DW_OP_constu, 1, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !731
  %114 = and i64 %112, 8589934590, !dbg !751
  %115 = icmp eq i64 %114, 0, !dbg !751
  br i1 %115, label %118, label %116, !dbg !752

116:                                              ; preds = %90
  %117 = add nsw i32 %113, -2, !dbg !753
  br label %121, !dbg !754

118:                                              ; preds = %90
  %119 = trunc i64 %112 to i32, !dbg !755
  %120 = sub nsw i32 %113, %119, !dbg !755
  br label %121, !dbg !756

121:                                              ; preds = %118, %116, %78
  %122 = phi i32 [ %117, %116 ], [ %120, %118 ], [ -1, %78 ], !dbg !731
  %123 = sub nsw i32 64, %122, !dbg !757
  call void @llvm.dbg.value(metadata i32 %123, metadata !517, metadata !DIExpression()) #7, !dbg !717
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !518, metadata !DIExpression()) #7, !dbg !758
  %124 = icmp ugt i32 %81, %123, !dbg !759
  %125 = select i1 %124, i32 %123, i32 %81, !dbg !760
  %126 = tail call i32 @llvm.usub.sat.i32(i32 %81, i32 %123), !dbg !760
  %127 = zext i32 %126 to i64, !dbg !760
  %128 = lshr i64 %88, %127, !dbg !760
  %129 = trunc i64 %128 to i32, !dbg !761
  br label %130, !dbg !762

130:                                              ; preds = %65, %121, %21
  %131 = phi i32 [ %79, %121 ], [ %73, %65 ], [ %14, %21 ], !dbg !639
  %132 = phi i32 [ %129, %121 ], [ %11, %65 ], [ %11, %21 ], !dbg !639
  %133 = phi i32 [ %80, %121 ], [ %69, %65 ], [ %13, %21 ], !dbg !639
  %134 = phi i32 [ %125, %121 ], [ %7, %65 ], [ %7, %21 ], !dbg !639
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !633, metadata !DIExpression()), !dbg !763
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !509, metadata !DIExpression()) #7, !dbg !764
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !515, metadata !DIExpression()) #7, !dbg !764
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !521, metadata !DIExpression()) #7, !dbg !766
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !526, metadata !DIExpression()) #7, !dbg !766
  %135 = icmp sgt i32 %133, %16, !dbg !768
  %136 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %135) #7
  br i1 %136, label %139, label %137, !dbg !769

137:                                              ; preds = %130
  %138 = icmp slt i32 %133, %16, !dbg !770
  br i1 %138, label %139, label %141, !dbg !771

139:                                              ; preds = %137, %130
  %140 = phi i32 [ %133, %130 ], [ %16, %137 ], !dbg !639
  br label %141, !dbg !772

141:                                              ; preds = %139, %137
  %142 = phi i32 [ %140, %139 ], [ %133, %137 ], !dbg !713
  %143 = zext i32 %131 to i64, !dbg !773
  %144 = shl nuw i64 %143, 32, !dbg !774
  call void @llvm.dbg.value(metadata i32 %17, metadata !630, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !639
  call void @llvm.dbg.value(metadata i32 %17, metadata !505, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !655
  %145 = sext i32 %17 to i64, !dbg !775
  %146 = udiv i64 %144, %145, !dbg !776
  %147 = sub nsw i32 32, %142, !dbg !777
  %148 = zext i32 %147 to i64, !dbg !778
  %149 = lshr i64 %146, %148, !dbg !778
  call void @llvm.dbg.value(metadata i64 %149, metadata !516, metadata !DIExpression()) #7, !dbg !764
  call void @llvm.dbg.value(metadata i64 %149, metadata !550, metadata !DIExpression()) #7, !dbg !779
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !779
  %150 = icmp ult i64 %149, 2147483648, !dbg !781
  br i1 %150, label %151, label %182, !dbg !782

151:                                              ; preds = %141
  call void @llvm.dbg.value(metadata i64 %149, metadata !556, metadata !DIExpression(DW_OP_constu, 32, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !779
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !779
  call void @llvm.dbg.value(metadata i64 %149, metadata !550, metadata !DIExpression()) #7, !dbg !779
  %152 = lshr i64 %149, 16, !dbg !783
  %153 = trunc i64 %152 to i32, !dbg !784
  call void @llvm.dbg.value(metadata i32 %153, metadata !556, metadata !DIExpression()) #7, !dbg !779
  %154 = icmp eq i32 %153, 0, !dbg !785
  %155 = select i1 %154, i64 %149, i64 %152, !dbg !786
  %156 = select i1 %154, i32 64, i32 48, !dbg !786
  call void @llvm.dbg.value(metadata i32 %156, metadata !555, metadata !DIExpression()) #7, !dbg !779
  call void @llvm.dbg.value(metadata i64 %155, metadata !550, metadata !DIExpression()) #7, !dbg !779
  %157 = lshr i64 %155, 8, !dbg !787
  %158 = trunc i64 %157 to i32, !dbg !788
  call void @llvm.dbg.value(metadata i32 %158, metadata !556, metadata !DIExpression()) #7, !dbg !779
  %159 = icmp eq i32 %158, 0, !dbg !789
  %160 = add nsw i32 %156, -8, !dbg !790
  %161 = select i1 %159, i64 %155, i64 %157, !dbg !790
  %162 = select i1 %159, i32 %156, i32 %160, !dbg !790
  call void @llvm.dbg.value(metadata i32 %162, metadata !555, metadata !DIExpression()) #7, !dbg !779
  call void @llvm.dbg.value(metadata i64 %161, metadata !550, metadata !DIExpression()) #7, !dbg !779
  %163 = lshr i64 %161, 4, !dbg !791
  %164 = trunc i64 %163 to i32, !dbg !792
  call void @llvm.dbg.value(metadata i32 %164, metadata !556, metadata !DIExpression()) #7, !dbg !779
  %165 = icmp eq i32 %164, 0, !dbg !793
  %166 = add nsw i32 %162, -4, !dbg !794
  %167 = select i1 %165, i64 %161, i64 %163, !dbg !794
  %168 = select i1 %165, i32 %162, i32 %166, !dbg !794
  call void @llvm.dbg.value(metadata i32 %168, metadata !555, metadata !DIExpression()) #7, !dbg !779
  call void @llvm.dbg.value(metadata i64 %167, metadata !550, metadata !DIExpression()) #7, !dbg !779
  %169 = lshr i64 %167, 2, !dbg !795
  %170 = trunc i64 %169 to i32, !dbg !796
  call void @llvm.dbg.value(metadata i32 %170, metadata !556, metadata !DIExpression()) #7, !dbg !779
  %171 = icmp eq i32 %170, 0, !dbg !797
  %172 = add nsw i32 %168, -2, !dbg !798
  %173 = select i1 %171, i64 %167, i64 %169, !dbg !798
  %174 = select i1 %171, i32 %168, i32 %172, !dbg !798
  call void @llvm.dbg.value(metadata i32 %174, metadata !555, metadata !DIExpression()) #7, !dbg !779
  call void @llvm.dbg.value(metadata i64 %173, metadata !550, metadata !DIExpression()) #7, !dbg !779
  call void @llvm.dbg.value(metadata i64 %173, metadata !556, metadata !DIExpression(DW_OP_constu, 1, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !779
  %175 = and i64 %173, 8589934590, !dbg !799
  %176 = icmp eq i64 %175, 0, !dbg !799
  br i1 %176, label %179, label %177, !dbg !800

177:                                              ; preds = %151
  %178 = add nsw i32 %174, -2, !dbg !801
  br label %182, !dbg !802

179:                                              ; preds = %151
  %180 = trunc i64 %173 to i32, !dbg !803
  %181 = sub nsw i32 %174, %180, !dbg !803
  br label %182, !dbg !804

182:                                              ; preds = %179, %177, %141
  %183 = phi i32 [ %178, %177 ], [ %181, %179 ], [ -1, %141 ], !dbg !779
  %184 = sub nsw i32 64, %183, !dbg !805
  call void @llvm.dbg.value(metadata i32 %184, metadata !517, metadata !DIExpression()) #7, !dbg !764
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !518, metadata !DIExpression()) #7, !dbg !806
  %185 = icmp sgt i32 %142, %184, !dbg !807
  %186 = sub nsw i32 %142, %184, !dbg !808
  %187 = select i1 %185, i32 %184, i32 %142, !dbg !808
  %188 = select i1 %185, i32 %186, i32 0, !dbg !808
  %189 = zext i32 %188 to i64, !dbg !808
  %190 = lshr i64 %149, %189, !dbg !808
  %191 = trunc i64 %190 to i32, !dbg !809
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !810, metadata !DIExpression()), !dbg !825
  call void @llvm.dbg.declare(metadata [256 x i64]* @__const.calc_log.array, metadata !815, metadata !DIExpression()), !dbg !827
  %192 = shl i64 %190, 32, !dbg !828
  %193 = ashr exact i64 %192, 32, !dbg !828
  call void @llvm.dbg.value(metadata i64 %193, metadata !829, metadata !DIExpression()), !dbg !834
  call void @llvm.dbg.value(metadata i32 32, metadata !832, metadata !DIExpression()), !dbg !834
  %194 = icmp sgt i32 %191, -1, !dbg !836
  br i1 %194, label %195, label %242, !dbg !838

195:                                              ; preds = %182
  %196 = lshr i64 %193, 16, !dbg !839
  call void @llvm.dbg.value(metadata i32 %191, metadata !833, metadata !DIExpression(DW_OP_constu, 16, DW_OP_shra, DW_OP_stack_value)), !dbg !834
  %197 = icmp ult i32 %191, 65536, !dbg !840
  %198 = select i1 %197, i64 %193, i64 %196, !dbg !842
  %199 = select i1 %197, i32 32, i32 16, !dbg !842
  call void @llvm.dbg.value(metadata i32 %199, metadata !832, metadata !DIExpression()), !dbg !834
  call void @llvm.dbg.value(metadata i64 %198, metadata !829, metadata !DIExpression()), !dbg !834
  %200 = lshr i64 %198, 8, !dbg !843
  %201 = trunc i64 %200 to i32, !dbg !844
  call void @llvm.dbg.value(metadata i32 %201, metadata !833, metadata !DIExpression()), !dbg !834
  %202 = icmp eq i32 %201, 0, !dbg !845
  %203 = add nsw i32 %199, -8, !dbg !847
  %204 = select i1 %202, i64 %198, i64 %200, !dbg !847
  %205 = select i1 %202, i32 %199, i32 %203, !dbg !847
  call void @llvm.dbg.value(metadata i32 %205, metadata !832, metadata !DIExpression()), !dbg !834
  call void @llvm.dbg.value(metadata i64 %204, metadata !829, metadata !DIExpression()), !dbg !834
  %206 = lshr i64 %204, 4, !dbg !848
  %207 = trunc i64 %206 to i32, !dbg !849
  call void @llvm.dbg.value(metadata i32 %207, metadata !833, metadata !DIExpression()), !dbg !834
  %208 = icmp eq i32 %207, 0, !dbg !850
  %209 = add nsw i32 %205, -4, !dbg !852
  %210 = select i1 %208, i64 %204, i64 %206, !dbg !852
  %211 = select i1 %208, i32 %205, i32 %209, !dbg !852
  call void @llvm.dbg.value(metadata i32 %211, metadata !832, metadata !DIExpression()), !dbg !834
  call void @llvm.dbg.value(metadata i64 %210, metadata !829, metadata !DIExpression()), !dbg !834
  %212 = lshr i64 %210, 2, !dbg !853
  %213 = trunc i64 %212 to i32, !dbg !854
  call void @llvm.dbg.value(metadata i32 %213, metadata !833, metadata !DIExpression()), !dbg !834
  %214 = icmp eq i32 %213, 0, !dbg !855
  %215 = add nsw i32 %211, -2, !dbg !857
  %216 = select i1 %214, i64 %210, i64 %212, !dbg !857
  %217 = select i1 %214, i32 %211, i32 %215, !dbg !857
  call void @llvm.dbg.value(metadata i32 %217, metadata !832, metadata !DIExpression()), !dbg !834
  call void @llvm.dbg.value(metadata i64 %216, metadata !829, metadata !DIExpression()), !dbg !834
  call void @llvm.dbg.value(metadata i64 %216, metadata !833, metadata !DIExpression(DW_OP_constu, 1, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !834
  %218 = and i64 %216, 8589934590, !dbg !858
  %219 = icmp eq i64 %218, 0, !dbg !858
  br i1 %219, label %222, label %220, !dbg !860

220:                                              ; preds = %195
  %221 = add nsw i32 %217, -2, !dbg !861
  br label %226, !dbg !862

222:                                              ; preds = %195
  %223 = trunc i64 %216 to i32, !dbg !863
  %224 = sub nsw i32 %217, %223, !dbg !863
  call void @llvm.dbg.value(metadata i32 %224, metadata !819, metadata !DIExpression()), !dbg !825
  %225 = icmp ult i32 %224, 32, !dbg !862
  br i1 %225, label %226, label %242, !dbg !862

226:                                              ; preds = %222, %220
  %227 = phi i32 [ %221, %220 ], [ %224, %222 ]
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !820, metadata !DIExpression()), !dbg !864
  %228 = add i32 %227, %187, !dbg !865
  %229 = shl i32 %228, 24, !dbg !866
  %230 = add i32 %229, -520093696, !dbg !866
  %231 = add nuw nsw i32 %227, 1, !dbg !867
  %232 = shl i32 %191, %231, !dbg !868
  %233 = lshr i32 %232, 24, !dbg !869
  %234 = zext i32 %233 to i64, !dbg !870
  %235 = getelementptr inbounds [256 x i64], [256 x i64]* @__const.calc_log.array, i64 0, i64 %234, !dbg !871
  %236 = load i64, i64* %235, align 8, !dbg !871, !tbaa !872, !noalias !874
  %237 = sub nsw i32 24, %187, !dbg !877
  %238 = zext i32 %237 to i64, !dbg !878
  %239 = lshr i64 %236, %238, !dbg !878
  %240 = trunc i64 %239 to i32, !dbg !879
  %241 = sub i32 %230, %240, !dbg !879
  br label %242, !dbg !880

242:                                              ; preds = %182, %222, %226
  %243 = phi i32 [ %241, %226 ], [ 0, %222 ], [ 0, %182 ]
  %244 = icmp slt i32 %131, %132, !dbg !881
  br i1 %244, label %412, label %245, !dbg !882

245:                                              ; preds = %242
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !634, metadata !DIExpression()), !dbg !883
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !509, metadata !DIExpression()) #7, !dbg !884
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !515, metadata !DIExpression()) #7, !dbg !884
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !521, metadata !DIExpression()) #7, !dbg !886
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !526, metadata !DIExpression()) #7, !dbg !886
  %246 = icmp sgt i32 %134, %142, !dbg !888
  %247 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %246) #7
  br i1 %247, label %250, label %248, !dbg !889

248:                                              ; preds = %245
  %249 = icmp slt i32 %134, %142, !dbg !890
  br i1 %249, label %250, label %252, !dbg !891

250:                                              ; preds = %248, %245
  %251 = phi i32 [ %134, %245 ], [ %142, %248 ], !dbg !892
  br label %252, !dbg !893

252:                                              ; preds = %250, %248
  %253 = phi i32 [ %134, %248 ], [ %251, %250 ], !dbg !894
  %254 = zext i32 %132 to i64, !dbg !895
  %255 = shl nuw i64 %254, 32, !dbg !896
  %256 = sext i32 %131 to i64, !dbg !897
  %257 = udiv i64 %255, %256, !dbg !898
  %258 = sub nsw i32 32, %253, !dbg !899
  %259 = zext i32 %258 to i64, !dbg !900
  %260 = lshr i64 %257, %259, !dbg !900
  call void @llvm.dbg.value(metadata i64 %260, metadata !516, metadata !DIExpression()) #7, !dbg !884
  call void @llvm.dbg.value(metadata i64 %260, metadata !550, metadata !DIExpression()) #7, !dbg !901
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !901
  %261 = icmp ult i64 %260, 2147483648, !dbg !903
  br i1 %261, label %262, label %293, !dbg !904

262:                                              ; preds = %252
  call void @llvm.dbg.value(metadata i64 %260, metadata !556, metadata !DIExpression(DW_OP_constu, 32, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !901
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !901
  call void @llvm.dbg.value(metadata i64 %260, metadata !550, metadata !DIExpression()) #7, !dbg !901
  %263 = lshr i64 %260, 16, !dbg !905
  %264 = trunc i64 %263 to i32, !dbg !906
  call void @llvm.dbg.value(metadata i32 %264, metadata !556, metadata !DIExpression()) #7, !dbg !901
  %265 = icmp eq i32 %264, 0, !dbg !907
  %266 = select i1 %265, i64 %260, i64 %263, !dbg !908
  %267 = select i1 %265, i32 64, i32 48, !dbg !908
  call void @llvm.dbg.value(metadata i32 %267, metadata !555, metadata !DIExpression()) #7, !dbg !901
  call void @llvm.dbg.value(metadata i64 %266, metadata !550, metadata !DIExpression()) #7, !dbg !901
  %268 = lshr i64 %266, 8, !dbg !909
  %269 = trunc i64 %268 to i32, !dbg !910
  call void @llvm.dbg.value(metadata i32 %269, metadata !556, metadata !DIExpression()) #7, !dbg !901
  %270 = icmp eq i32 %269, 0, !dbg !911
  %271 = add nsw i32 %267, -8, !dbg !912
  %272 = select i1 %270, i64 %266, i64 %268, !dbg !912
  %273 = select i1 %270, i32 %267, i32 %271, !dbg !912
  call void @llvm.dbg.value(metadata i32 %273, metadata !555, metadata !DIExpression()) #7, !dbg !901
  call void @llvm.dbg.value(metadata i64 %272, metadata !550, metadata !DIExpression()) #7, !dbg !901
  %274 = lshr i64 %272, 4, !dbg !913
  %275 = trunc i64 %274 to i32, !dbg !914
  call void @llvm.dbg.value(metadata i32 %275, metadata !556, metadata !DIExpression()) #7, !dbg !901
  %276 = icmp eq i32 %275, 0, !dbg !915
  %277 = add nsw i32 %273, -4, !dbg !916
  %278 = select i1 %276, i64 %272, i64 %274, !dbg !916
  %279 = select i1 %276, i32 %273, i32 %277, !dbg !916
  call void @llvm.dbg.value(metadata i32 %279, metadata !555, metadata !DIExpression()) #7, !dbg !901
  call void @llvm.dbg.value(metadata i64 %278, metadata !550, metadata !DIExpression()) #7, !dbg !901
  %280 = lshr i64 %278, 2, !dbg !917
  %281 = trunc i64 %280 to i32, !dbg !918
  call void @llvm.dbg.value(metadata i32 %281, metadata !556, metadata !DIExpression()) #7, !dbg !901
  %282 = icmp eq i32 %281, 0, !dbg !919
  %283 = add nsw i32 %279, -2, !dbg !920
  %284 = select i1 %282, i64 %278, i64 %280, !dbg !920
  %285 = select i1 %282, i32 %279, i32 %283, !dbg !920
  call void @llvm.dbg.value(metadata i32 %285, metadata !555, metadata !DIExpression()) #7, !dbg !901
  call void @llvm.dbg.value(metadata i64 %284, metadata !550, metadata !DIExpression()) #7, !dbg !901
  call void @llvm.dbg.value(metadata i64 %284, metadata !556, metadata !DIExpression(DW_OP_constu, 1, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !901
  %286 = and i64 %284, 8589934590, !dbg !921
  %287 = icmp eq i64 %286, 0, !dbg !921
  br i1 %287, label %290, label %288, !dbg !922

288:                                              ; preds = %262
  %289 = add nsw i32 %285, -2, !dbg !923
  br label %293, !dbg !924

290:                                              ; preds = %262
  %291 = trunc i64 %284 to i32, !dbg !925
  %292 = sub nsw i32 %285, %291, !dbg !925
  br label %293, !dbg !926

293:                                              ; preds = %290, %288, %252
  %294 = phi i32 [ %289, %288 ], [ %292, %290 ], [ -1, %252 ], !dbg !901
  %295 = sub nsw i32 64, %294, !dbg !927
  call void @llvm.dbg.value(metadata i32 %295, metadata !517, metadata !DIExpression()) #7, !dbg !884
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !518, metadata !DIExpression()) #7, !dbg !928
  %296 = icmp sgt i32 %253, %295, !dbg !929
  %297 = sub nsw i32 %253, %295, !dbg !930
  %298 = select i1 %296, i32 %295, i32 %253, !dbg !930
  %299 = select i1 %296, i32 %297, i32 0, !dbg !930
  %300 = zext i32 %299 to i64, !dbg !930
  %301 = lshr i64 %260, %300, !dbg !930
  %302 = trunc i64 %301 to i32, !dbg !931
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !810, metadata !DIExpression()), !dbg !932
  call void @llvm.dbg.declare(metadata [256 x i64]* @__const.calc_log.array, metadata !815, metadata !DIExpression()), !dbg !934
  %303 = shl i64 %301, 32, !dbg !935
  %304 = ashr exact i64 %303, 32, !dbg !935
  call void @llvm.dbg.value(metadata i64 %304, metadata !829, metadata !DIExpression()), !dbg !936
  call void @llvm.dbg.value(metadata i32 32, metadata !832, metadata !DIExpression()), !dbg !936
  %305 = icmp sgt i32 %302, -1, !dbg !938
  br i1 %305, label %306, label %355, !dbg !939

306:                                              ; preds = %293
  %307 = lshr i64 %304, 16, !dbg !940
  call void @llvm.dbg.value(metadata i32 %302, metadata !833, metadata !DIExpression(DW_OP_constu, 16, DW_OP_shra, DW_OP_stack_value)), !dbg !936
  %308 = icmp ult i32 %302, 65536, !dbg !941
  %309 = select i1 %308, i64 %304, i64 %307, !dbg !942
  %310 = select i1 %308, i32 32, i32 16, !dbg !942
  call void @llvm.dbg.value(metadata i32 %310, metadata !832, metadata !DIExpression()), !dbg !936
  call void @llvm.dbg.value(metadata i64 %309, metadata !829, metadata !DIExpression()), !dbg !936
  %311 = lshr i64 %309, 8, !dbg !943
  %312 = trunc i64 %311 to i32, !dbg !944
  call void @llvm.dbg.value(metadata i32 %312, metadata !833, metadata !DIExpression()), !dbg !936
  %313 = icmp eq i32 %312, 0, !dbg !945
  %314 = add nsw i32 %310, -8, !dbg !946
  %315 = select i1 %313, i64 %309, i64 %311, !dbg !946
  %316 = select i1 %313, i32 %310, i32 %314, !dbg !946
  call void @llvm.dbg.value(metadata i32 %316, metadata !832, metadata !DIExpression()), !dbg !936
  call void @llvm.dbg.value(metadata i64 %315, metadata !829, metadata !DIExpression()), !dbg !936
  %317 = lshr i64 %315, 4, !dbg !947
  %318 = trunc i64 %317 to i32, !dbg !948
  call void @llvm.dbg.value(metadata i32 %318, metadata !833, metadata !DIExpression()), !dbg !936
  %319 = icmp eq i32 %318, 0, !dbg !949
  %320 = add nsw i32 %316, -4, !dbg !950
  %321 = select i1 %319, i64 %315, i64 %317, !dbg !950
  %322 = select i1 %319, i32 %316, i32 %320, !dbg !950
  call void @llvm.dbg.value(metadata i32 %322, metadata !832, metadata !DIExpression()), !dbg !936
  call void @llvm.dbg.value(metadata i64 %321, metadata !829, metadata !DIExpression()), !dbg !936
  %323 = lshr i64 %321, 2, !dbg !951
  %324 = trunc i64 %323 to i32, !dbg !952
  call void @llvm.dbg.value(metadata i32 %324, metadata !833, metadata !DIExpression()), !dbg !936
  %325 = icmp eq i32 %324, 0, !dbg !953
  %326 = add nsw i32 %322, -2, !dbg !954
  %327 = select i1 %325, i64 %321, i64 %323, !dbg !954
  %328 = select i1 %325, i32 %322, i32 %326, !dbg !954
  call void @llvm.dbg.value(metadata i32 %328, metadata !832, metadata !DIExpression()), !dbg !936
  call void @llvm.dbg.value(metadata i64 %327, metadata !829, metadata !DIExpression()), !dbg !936
  call void @llvm.dbg.value(metadata i64 %327, metadata !833, metadata !DIExpression(DW_OP_constu, 1, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !936
  %329 = and i64 %327, 8589934590, !dbg !955
  %330 = icmp eq i64 %329, 0, !dbg !955
  br i1 %330, label %333, label %331, !dbg !956

331:                                              ; preds = %306
  %332 = add nsw i32 %328, -2, !dbg !957
  br label %337, !dbg !958

333:                                              ; preds = %306
  %334 = trunc i64 %327 to i32, !dbg !959
  %335 = sub nsw i32 %328, %334, !dbg !959
  call void @llvm.dbg.value(metadata i32 %335, metadata !819, metadata !DIExpression()), !dbg !932
  %336 = icmp ult i32 %335, 32, !dbg !958
  br i1 %336, label %337, label %355, !dbg !958

337:                                              ; preds = %333, %331
  %338 = phi i32 [ %332, %331 ], [ %335, %333 ]
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !820, metadata !DIExpression()), !dbg !960
  %339 = add i32 %338, %298, !dbg !961
  %340 = mul i32 %339, -16777216, !dbg !962
  %341 = add i32 %340, 520093696, !dbg !962
  %342 = add nuw nsw i32 %338, 1, !dbg !963
  %343 = shl i32 %302, %342, !dbg !964
  %344 = lshr i32 %343, 24, !dbg !965
  %345 = zext i32 %344 to i64, !dbg !966
  %346 = getelementptr inbounds [256 x i64], [256 x i64]* @__const.calc_log.array, i64 0, i64 %345, !dbg !967
  %347 = load i64, i64* %346, align 8, !dbg !967, !tbaa !872, !noalias !968
  %348 = sub nsw i32 24, %298, !dbg !971
  %349 = zext i32 %348 to i64, !dbg !972
  %350 = lshr i64 %347, %349, !dbg !972
  %351 = trunc i64 %350 to i32, !dbg !973
  %352 = add i32 %341, %351, !dbg !973
  %353 = zext i32 %352 to i64, !dbg !974
  %354 = or i64 %353, 34359738368, !dbg !974
  br label %355, !dbg !974

355:                                              ; preds = %293, %333, %337
  %356 = phi i64 [ %354, %337 ], [ 34359738368, %333 ], [ 34359738368, %293 ]
  %357 = trunc i64 %356 to i32, !dbg !975
  %358 = lshr i64 %356, 32, !dbg !975
  %359 = trunc i64 %358 to i32, !dbg !975
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !976, metadata !DIExpression()) #7, !dbg !981
  call void @llvm.dbg.value(metadata i32 %357, metadata !979, metadata !DIExpression(DW_OP_constu, 31, DW_OP_shra, DW_OP_stack_value)) #7, !dbg !981
  %360 = tail call i32 @llvm.abs.i32(i32 %357, i1 true) #7, !dbg !983
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !984, metadata !DIExpression()) #7, !dbg !991
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !987, metadata !DIExpression()) #7, !dbg !991
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !521, metadata !DIExpression()) #7, !dbg !993
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !526, metadata !DIExpression()) #7, !dbg !993
  %361 = icmp slt i32 %359, 8, !dbg !995
  %362 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %361) #7
  br i1 %362, label %365, label %363, !dbg !996

363:                                              ; preds = %355
  %364 = icmp sgt i32 %359, 8, !dbg !997
  br i1 %364, label %365, label %367, !dbg !998

365:                                              ; preds = %363, %355
  %366 = phi i32 [ 8, %355 ], [ %359, %363 ], !dbg !639
  br label %367, !dbg !999

367:                                              ; preds = %365, %363
  %368 = phi i32 [ %366, %365 ], [ 8, %363 ], !dbg !1000
  %369 = add nsw i32 %360, %243, !dbg !1001
  %370 = sext i32 %369 to i64, !dbg !1002
  call void @llvm.dbg.value(metadata i64 %370, metadata !988, metadata !DIExpression()) #7, !dbg !991
  call void @llvm.dbg.value(metadata i64 %370, metadata !550, metadata !DIExpression()) #7, !dbg !1003
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !1003
  %371 = icmp sgt i32 %369, -1, !dbg !1005
  br i1 %371, label %372, label %402, !dbg !1006

372:                                              ; preds = %367
  call void @llvm.dbg.value(metadata i64 %370, metadata !556, metadata !DIExpression(DW_OP_constu, 32, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !1003
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !1003
  call void @llvm.dbg.value(metadata i64 %370, metadata !550, metadata !DIExpression()) #7, !dbg !1003
  %373 = lshr i64 %370, 16, !dbg !1007
  call void @llvm.dbg.value(metadata i32 %369, metadata !556, metadata !DIExpression(DW_OP_constu, 16, DW_OP_shra, DW_OP_stack_value)) #7, !dbg !1003
  %374 = icmp ult i32 %369, 65536, !dbg !1008
  %375 = select i1 %374, i64 %370, i64 %373, !dbg !1009
  %376 = select i1 %374, i32 64, i32 48, !dbg !1009
  call void @llvm.dbg.value(metadata i32 %376, metadata !555, metadata !DIExpression()) #7, !dbg !1003
  call void @llvm.dbg.value(metadata i64 %375, metadata !550, metadata !DIExpression()) #7, !dbg !1003
  %377 = lshr i64 %375, 8, !dbg !1010
  %378 = trunc i64 %377 to i32, !dbg !1011
  call void @llvm.dbg.value(metadata i32 %378, metadata !556, metadata !DIExpression()) #7, !dbg !1003
  %379 = icmp eq i32 %378, 0, !dbg !1012
  %380 = add nsw i32 %376, -8, !dbg !1013
  %381 = select i1 %379, i64 %375, i64 %377, !dbg !1013
  %382 = select i1 %379, i32 %376, i32 %380, !dbg !1013
  call void @llvm.dbg.value(metadata i32 %382, metadata !555, metadata !DIExpression()) #7, !dbg !1003
  call void @llvm.dbg.value(metadata i64 %381, metadata !550, metadata !DIExpression()) #7, !dbg !1003
  %383 = lshr i64 %381, 4, !dbg !1014
  %384 = trunc i64 %383 to i32, !dbg !1015
  call void @llvm.dbg.value(metadata i32 %384, metadata !556, metadata !DIExpression()) #7, !dbg !1003
  %385 = icmp eq i32 %384, 0, !dbg !1016
  %386 = add nsw i32 %382, -4, !dbg !1017
  %387 = select i1 %385, i64 %381, i64 %383, !dbg !1017
  %388 = select i1 %385, i32 %382, i32 %386, !dbg !1017
  call void @llvm.dbg.value(metadata i32 %388, metadata !555, metadata !DIExpression()) #7, !dbg !1003
  call void @llvm.dbg.value(metadata i64 %387, metadata !550, metadata !DIExpression()) #7, !dbg !1003
  %389 = lshr i64 %387, 2, !dbg !1018
  %390 = trunc i64 %389 to i32, !dbg !1019
  call void @llvm.dbg.value(metadata i32 %390, metadata !556, metadata !DIExpression()) #7, !dbg !1003
  %391 = icmp eq i32 %390, 0, !dbg !1020
  %392 = add nsw i32 %388, -2, !dbg !1021
  %393 = select i1 %391, i64 %387, i64 %389, !dbg !1021
  %394 = select i1 %391, i32 %388, i32 %392, !dbg !1021
  call void @llvm.dbg.value(metadata i32 %394, metadata !555, metadata !DIExpression()) #7, !dbg !1003
  call void @llvm.dbg.value(metadata i64 %393, metadata !550, metadata !DIExpression()) #7, !dbg !1003
  call void @llvm.dbg.value(metadata i64 %393, metadata !556, metadata !DIExpression(DW_OP_constu, 1, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !1003
  %395 = and i64 %393, 8589934590, !dbg !1022
  %396 = icmp eq i64 %395, 0, !dbg !1022
  br i1 %396, label %399, label %397, !dbg !1023

397:                                              ; preds = %372
  %398 = add nsw i32 %394, -2, !dbg !1024
  br label %402, !dbg !1025

399:                                              ; preds = %372
  %400 = trunc i64 %393 to i32, !dbg !1026
  %401 = sub nsw i32 %394, %400, !dbg !1026
  br label %402, !dbg !1027

402:                                              ; preds = %399, %397, %367
  %403 = phi i32 [ %398, %397 ], [ %401, %399 ], [ -1, %367 ], !dbg !1003
  %404 = sub nsw i32 64, %403, !dbg !1028
  call void @llvm.dbg.value(metadata i32 %404, metadata !989, metadata !DIExpression()) #7, !dbg !991
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !990, metadata !DIExpression()) #7, !dbg !1029
  %405 = icmp sgt i32 %368, %404, !dbg !1030
  %406 = sub nsw i32 %368, %404, !dbg !1032
  %407 = zext i32 %406 to i64, !dbg !1032
  %408 = lshr i64 %370, %407, !dbg !1032
  %409 = trunc i64 %408 to i32, !dbg !1032
  %410 = select i1 %405, i32 %404, i32 %368, !dbg !1032
  %411 = select i1 %405, i32 %409, i32 %369, !dbg !1032
  br label %576, !dbg !1033

412:                                              ; preds = %242
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !637, metadata !DIExpression()), !dbg !1034
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !509, metadata !DIExpression()) #7, !dbg !1035
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !515, metadata !DIExpression()) #7, !dbg !1035
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !521, metadata !DIExpression()) #7, !dbg !1037
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !526, metadata !DIExpression()) #7, !dbg !1037
  %413 = icmp sgt i32 %142, %134, !dbg !1039
  %414 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %413) #7
  %415 = xor i1 %414, true, !dbg !1040
  %416 = icmp slt i32 %142, %134
  %417 = select i1 %415, i1 %416, i1 false, !dbg !1040
  %418 = sub nsw i32 32, %134, !dbg !1040
  %419 = zext i32 %418 to i64, !dbg !1040
  %420 = select i1 %417, i64 %419, i64 %148, !dbg !1040
  %421 = select i1 %417, i32 %134, i32 %142, !dbg !1040
  %422 = sext i32 %132 to i64, !dbg !1041
  %423 = udiv i64 %144, %422, !dbg !1042
  %424 = lshr i64 %423, %420, !dbg !1043
  call void @llvm.dbg.value(metadata i64 %424, metadata !516, metadata !DIExpression()) #7, !dbg !1035
  call void @llvm.dbg.value(metadata i64 %424, metadata !550, metadata !DIExpression()) #7, !dbg !1044
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !1044
  %425 = icmp ult i64 %424, 2147483648, !dbg !1046
  br i1 %425, label %426, label %457, !dbg !1047

426:                                              ; preds = %412
  call void @llvm.dbg.value(metadata i64 %424, metadata !556, metadata !DIExpression(DW_OP_constu, 32, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !1044
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !1044
  call void @llvm.dbg.value(metadata i64 %424, metadata !550, metadata !DIExpression()) #7, !dbg !1044
  %427 = lshr i64 %424, 16, !dbg !1048
  %428 = trunc i64 %427 to i32, !dbg !1049
  call void @llvm.dbg.value(metadata i32 %428, metadata !556, metadata !DIExpression()) #7, !dbg !1044
  %429 = icmp eq i32 %428, 0, !dbg !1050
  %430 = select i1 %429, i64 %424, i64 %427, !dbg !1051
  %431 = select i1 %429, i32 64, i32 48, !dbg !1051
  call void @llvm.dbg.value(metadata i32 %431, metadata !555, metadata !DIExpression()) #7, !dbg !1044
  call void @llvm.dbg.value(metadata i64 %430, metadata !550, metadata !DIExpression()) #7, !dbg !1044
  %432 = lshr i64 %430, 8, !dbg !1052
  %433 = trunc i64 %432 to i32, !dbg !1053
  call void @llvm.dbg.value(metadata i32 %433, metadata !556, metadata !DIExpression()) #7, !dbg !1044
  %434 = icmp eq i32 %433, 0, !dbg !1054
  %435 = add nsw i32 %431, -8, !dbg !1055
  %436 = select i1 %434, i64 %430, i64 %432, !dbg !1055
  %437 = select i1 %434, i32 %431, i32 %435, !dbg !1055
  call void @llvm.dbg.value(metadata i32 %437, metadata !555, metadata !DIExpression()) #7, !dbg !1044
  call void @llvm.dbg.value(metadata i64 %436, metadata !550, metadata !DIExpression()) #7, !dbg !1044
  %438 = lshr i64 %436, 4, !dbg !1056
  %439 = trunc i64 %438 to i32, !dbg !1057
  call void @llvm.dbg.value(metadata i32 %439, metadata !556, metadata !DIExpression()) #7, !dbg !1044
  %440 = icmp eq i32 %439, 0, !dbg !1058
  %441 = add nsw i32 %437, -4, !dbg !1059
  %442 = select i1 %440, i64 %436, i64 %438, !dbg !1059
  %443 = select i1 %440, i32 %437, i32 %441, !dbg !1059
  call void @llvm.dbg.value(metadata i32 %443, metadata !555, metadata !DIExpression()) #7, !dbg !1044
  call void @llvm.dbg.value(metadata i64 %442, metadata !550, metadata !DIExpression()) #7, !dbg !1044
  %444 = lshr i64 %442, 2, !dbg !1060
  %445 = trunc i64 %444 to i32, !dbg !1061
  call void @llvm.dbg.value(metadata i32 %445, metadata !556, metadata !DIExpression()) #7, !dbg !1044
  %446 = icmp eq i32 %445, 0, !dbg !1062
  %447 = add nsw i32 %443, -2, !dbg !1063
  %448 = select i1 %446, i64 %442, i64 %444, !dbg !1063
  %449 = select i1 %446, i32 %443, i32 %447, !dbg !1063
  call void @llvm.dbg.value(metadata i32 %449, metadata !555, metadata !DIExpression()) #7, !dbg !1044
  call void @llvm.dbg.value(metadata i64 %448, metadata !550, metadata !DIExpression()) #7, !dbg !1044
  call void @llvm.dbg.value(metadata i64 %448, metadata !556, metadata !DIExpression(DW_OP_constu, 1, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !1044
  %450 = and i64 %448, 8589934590, !dbg !1064
  %451 = icmp eq i64 %450, 0, !dbg !1064
  br i1 %451, label %454, label %452, !dbg !1065

452:                                              ; preds = %426
  %453 = add nsw i32 %449, -2, !dbg !1066
  br label %457, !dbg !1067

454:                                              ; preds = %426
  %455 = trunc i64 %448 to i32, !dbg !1068
  %456 = sub nsw i32 %449, %455, !dbg !1068
  br label %457, !dbg !1069

457:                                              ; preds = %454, %452, %412
  %458 = phi i32 [ %453, %452 ], [ %456, %454 ], [ -1, %412 ], !dbg !1044
  %459 = sub nsw i32 64, %458, !dbg !1070
  call void @llvm.dbg.value(metadata i32 %459, metadata !517, metadata !DIExpression()) #7, !dbg !1035
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !518, metadata !DIExpression()) #7, !dbg !1071
  %460 = icmp sgt i32 %421, %459, !dbg !1072
  %461 = sub nsw i32 %421, %459, !dbg !1073
  %462 = select i1 %460, i32 %459, i32 %421, !dbg !1073
  %463 = select i1 %460, i32 %461, i32 0, !dbg !1073
  %464 = zext i32 %463 to i64, !dbg !1073
  %465 = lshr i64 %424, %464, !dbg !1073
  %466 = trunc i64 %465 to i32, !dbg !1074
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !810, metadata !DIExpression()), !dbg !1075
  call void @llvm.dbg.declare(metadata [256 x i64]* @__const.calc_log.array, metadata !815, metadata !DIExpression()), !dbg !1077
  %467 = shl i64 %465, 32, !dbg !1078
  %468 = ashr exact i64 %467, 32, !dbg !1078
  call void @llvm.dbg.value(metadata i64 %468, metadata !829, metadata !DIExpression()), !dbg !1079
  call void @llvm.dbg.value(metadata i32 32, metadata !832, metadata !DIExpression()), !dbg !1079
  %469 = icmp sgt i32 %466, -1, !dbg !1081
  br i1 %469, label %470, label %519, !dbg !1082

470:                                              ; preds = %457
  %471 = lshr i64 %468, 16, !dbg !1083
  call void @llvm.dbg.value(metadata i32 %466, metadata !833, metadata !DIExpression(DW_OP_constu, 16, DW_OP_shra, DW_OP_stack_value)), !dbg !1079
  %472 = icmp ult i32 %466, 65536, !dbg !1084
  %473 = select i1 %472, i64 %468, i64 %471, !dbg !1085
  %474 = select i1 %472, i32 32, i32 16, !dbg !1085
  call void @llvm.dbg.value(metadata i32 %474, metadata !832, metadata !DIExpression()), !dbg !1079
  call void @llvm.dbg.value(metadata i64 %473, metadata !829, metadata !DIExpression()), !dbg !1079
  %475 = lshr i64 %473, 8, !dbg !1086
  %476 = trunc i64 %475 to i32, !dbg !1087
  call void @llvm.dbg.value(metadata i32 %476, metadata !833, metadata !DIExpression()), !dbg !1079
  %477 = icmp eq i32 %476, 0, !dbg !1088
  %478 = add nsw i32 %474, -8, !dbg !1089
  %479 = select i1 %477, i64 %473, i64 %475, !dbg !1089
  %480 = select i1 %477, i32 %474, i32 %478, !dbg !1089
  call void @llvm.dbg.value(metadata i32 %480, metadata !832, metadata !DIExpression()), !dbg !1079
  call void @llvm.dbg.value(metadata i64 %479, metadata !829, metadata !DIExpression()), !dbg !1079
  %481 = lshr i64 %479, 4, !dbg !1090
  %482 = trunc i64 %481 to i32, !dbg !1091
  call void @llvm.dbg.value(metadata i32 %482, metadata !833, metadata !DIExpression()), !dbg !1079
  %483 = icmp eq i32 %482, 0, !dbg !1092
  %484 = add nsw i32 %480, -4, !dbg !1093
  %485 = select i1 %483, i64 %479, i64 %481, !dbg !1093
  %486 = select i1 %483, i32 %480, i32 %484, !dbg !1093
  call void @llvm.dbg.value(metadata i32 %486, metadata !832, metadata !DIExpression()), !dbg !1079
  call void @llvm.dbg.value(metadata i64 %485, metadata !829, metadata !DIExpression()), !dbg !1079
  %487 = lshr i64 %485, 2, !dbg !1094
  %488 = trunc i64 %487 to i32, !dbg !1095
  call void @llvm.dbg.value(metadata i32 %488, metadata !833, metadata !DIExpression()), !dbg !1079
  %489 = icmp eq i32 %488, 0, !dbg !1096
  %490 = add nsw i32 %486, -2, !dbg !1097
  %491 = select i1 %489, i64 %485, i64 %487, !dbg !1097
  %492 = select i1 %489, i32 %486, i32 %490, !dbg !1097
  call void @llvm.dbg.value(metadata i32 %492, metadata !832, metadata !DIExpression()), !dbg !1079
  call void @llvm.dbg.value(metadata i64 %491, metadata !829, metadata !DIExpression()), !dbg !1079
  call void @llvm.dbg.value(metadata i64 %491, metadata !833, metadata !DIExpression(DW_OP_constu, 1, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1079
  %493 = and i64 %491, 8589934590, !dbg !1098
  %494 = icmp eq i64 %493, 0, !dbg !1098
  br i1 %494, label %497, label %495, !dbg !1099

495:                                              ; preds = %470
  %496 = add nsw i32 %492, -2, !dbg !1100
  br label %501, !dbg !1101

497:                                              ; preds = %470
  %498 = trunc i64 %491 to i32, !dbg !1102
  %499 = sub nsw i32 %492, %498, !dbg !1102
  call void @llvm.dbg.value(metadata i32 %499, metadata !819, metadata !DIExpression()), !dbg !1075
  %500 = icmp ult i32 %499, 32, !dbg !1101
  br i1 %500, label %501, label %519, !dbg !1101

501:                                              ; preds = %497, %495
  %502 = phi i32 [ %496, %495 ], [ %499, %497 ]
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !820, metadata !DIExpression()), !dbg !1103
  %503 = add i32 %502, %462, !dbg !1104
  %504 = mul i32 %503, -16777216, !dbg !1105
  %505 = add i32 %504, 520093696, !dbg !1105
  %506 = add nuw nsw i32 %502, 1, !dbg !1106
  %507 = shl i32 %466, %506, !dbg !1107
  %508 = lshr i32 %507, 24, !dbg !1108
  %509 = zext i32 %508 to i64, !dbg !1109
  %510 = getelementptr inbounds [256 x i64], [256 x i64]* @__const.calc_log.array, i64 0, i64 %509, !dbg !1110
  %511 = load i64, i64* %510, align 8, !dbg !1110, !tbaa !872, !noalias !1111
  %512 = sub nsw i32 24, %462, !dbg !1114
  %513 = zext i32 %512 to i64, !dbg !1115
  %514 = lshr i64 %511, %513, !dbg !1115
  %515 = trunc i64 %514 to i32, !dbg !1116
  %516 = add i32 %505, %515, !dbg !1116
  %517 = zext i32 %516 to i64, !dbg !1117
  %518 = or i64 %517, 34359738368, !dbg !1117
  br label %519, !dbg !1117

519:                                              ; preds = %457, %497, %501
  %520 = phi i64 [ %518, %501 ], [ 34359738368, %497 ], [ 34359738368, %457 ]
  %521 = trunc i64 %520 to i32, !dbg !1118
  %522 = lshr i64 %520, 32, !dbg !1118
  %523 = trunc i64 %522 to i32, !dbg !1118
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !976, metadata !DIExpression()) #7, !dbg !1119
  call void @llvm.dbg.value(metadata i32 %521, metadata !979, metadata !DIExpression(DW_OP_constu, 31, DW_OP_shra, DW_OP_stack_value)) #7, !dbg !1119
  %524 = tail call i32 @llvm.abs.i32(i32 %521, i1 true) #7, !dbg !1121
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !984, metadata !DIExpression()) #7, !dbg !1122
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !987, metadata !DIExpression()) #7, !dbg !1122
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !521, metadata !DIExpression()) #7, !dbg !1124
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !526, metadata !DIExpression()) #7, !dbg !1124
  %525 = icmp slt i32 %523, 8, !dbg !1126
  %526 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %525) #7
  br i1 %526, label %529, label %527, !dbg !1127

527:                                              ; preds = %519
  %528 = icmp sgt i32 %523, 8, !dbg !1128
  br i1 %528, label %529, label %531, !dbg !1129

529:                                              ; preds = %527, %519
  %530 = phi i32 [ 8, %519 ], [ %523, %527 ], !dbg !639
  br label %531, !dbg !1130

531:                                              ; preds = %529, %527
  %532 = phi i32 [ %530, %529 ], [ 8, %527 ], !dbg !1000
  %533 = add nsw i32 %524, %243, !dbg !1131
  %534 = sext i32 %533 to i64, !dbg !1132
  call void @llvm.dbg.value(metadata i64 %534, metadata !988, metadata !DIExpression()) #7, !dbg !1122
  call void @llvm.dbg.value(metadata i64 %534, metadata !550, metadata !DIExpression()) #7, !dbg !1133
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !1133
  %535 = icmp sgt i32 %533, -1, !dbg !1135
  br i1 %535, label %536, label %566, !dbg !1136

536:                                              ; preds = %531
  call void @llvm.dbg.value(metadata i64 %534, metadata !556, metadata !DIExpression(DW_OP_constu, 32, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !1133
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !1133
  call void @llvm.dbg.value(metadata i64 %534, metadata !550, metadata !DIExpression()) #7, !dbg !1133
  %537 = lshr i64 %534, 16, !dbg !1137
  call void @llvm.dbg.value(metadata i32 %533, metadata !556, metadata !DIExpression(DW_OP_constu, 16, DW_OP_shra, DW_OP_stack_value)) #7, !dbg !1133
  %538 = icmp ult i32 %533, 65536, !dbg !1138
  %539 = select i1 %538, i64 %534, i64 %537, !dbg !1139
  %540 = select i1 %538, i32 64, i32 48, !dbg !1139
  call void @llvm.dbg.value(metadata i32 %540, metadata !555, metadata !DIExpression()) #7, !dbg !1133
  call void @llvm.dbg.value(metadata i64 %539, metadata !550, metadata !DIExpression()) #7, !dbg !1133
  %541 = lshr i64 %539, 8, !dbg !1140
  %542 = trunc i64 %541 to i32, !dbg !1141
  call void @llvm.dbg.value(metadata i32 %542, metadata !556, metadata !DIExpression()) #7, !dbg !1133
  %543 = icmp eq i32 %542, 0, !dbg !1142
  %544 = add nsw i32 %540, -8, !dbg !1143
  %545 = select i1 %543, i64 %539, i64 %541, !dbg !1143
  %546 = select i1 %543, i32 %540, i32 %544, !dbg !1143
  call void @llvm.dbg.value(metadata i32 %546, metadata !555, metadata !DIExpression()) #7, !dbg !1133
  call void @llvm.dbg.value(metadata i64 %545, metadata !550, metadata !DIExpression()) #7, !dbg !1133
  %547 = lshr i64 %545, 4, !dbg !1144
  %548 = trunc i64 %547 to i32, !dbg !1145
  call void @llvm.dbg.value(metadata i32 %548, metadata !556, metadata !DIExpression()) #7, !dbg !1133
  %549 = icmp eq i32 %548, 0, !dbg !1146
  %550 = add nsw i32 %546, -4, !dbg !1147
  %551 = select i1 %549, i64 %545, i64 %547, !dbg !1147
  %552 = select i1 %549, i32 %546, i32 %550, !dbg !1147
  call void @llvm.dbg.value(metadata i32 %552, metadata !555, metadata !DIExpression()) #7, !dbg !1133
  call void @llvm.dbg.value(metadata i64 %551, metadata !550, metadata !DIExpression()) #7, !dbg !1133
  %553 = lshr i64 %551, 2, !dbg !1148
  %554 = trunc i64 %553 to i32, !dbg !1149
  call void @llvm.dbg.value(metadata i32 %554, metadata !556, metadata !DIExpression()) #7, !dbg !1133
  %555 = icmp eq i32 %554, 0, !dbg !1150
  %556 = add nsw i32 %552, -2, !dbg !1151
  %557 = select i1 %555, i64 %551, i64 %553, !dbg !1151
  %558 = select i1 %555, i32 %552, i32 %556, !dbg !1151
  call void @llvm.dbg.value(metadata i32 %558, metadata !555, metadata !DIExpression()) #7, !dbg !1133
  call void @llvm.dbg.value(metadata i64 %557, metadata !550, metadata !DIExpression()) #7, !dbg !1133
  call void @llvm.dbg.value(metadata i64 %557, metadata !556, metadata !DIExpression(DW_OP_constu, 1, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !1133
  %559 = and i64 %557, 8589934590, !dbg !1152
  %560 = icmp eq i64 %559, 0, !dbg !1152
  br i1 %560, label %563, label %561, !dbg !1153

561:                                              ; preds = %536
  %562 = add nsw i32 %558, -2, !dbg !1154
  br label %566, !dbg !1155

563:                                              ; preds = %536
  %564 = trunc i64 %557 to i32, !dbg !1156
  %565 = sub nsw i32 %558, %564, !dbg !1156
  br label %566, !dbg !1157

566:                                              ; preds = %563, %561, %531
  %567 = phi i32 [ %562, %561 ], [ %565, %563 ], [ -1, %531 ], !dbg !1133
  %568 = sub nsw i32 64, %567, !dbg !1158
  call void @llvm.dbg.value(metadata i32 %568, metadata !989, metadata !DIExpression()) #7, !dbg !1122
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !990, metadata !DIExpression()) #7, !dbg !1159
  %569 = icmp sgt i32 %532, %568, !dbg !1160
  %570 = sub nsw i32 %532, %568, !dbg !1161
  %571 = zext i32 %570 to i64, !dbg !1161
  %572 = lshr i64 %534, %571, !dbg !1161
  %573 = trunc i64 %572 to i32, !dbg !1161
  %574 = select i1 %569, i32 %568, i32 %532, !dbg !1161
  %575 = select i1 %569, i32 %573, i32 %533, !dbg !1161
  br label %576

576:                                              ; preds = %566, %402
  %577 = phi i32 [ %575, %566 ], [ %411, %402 ], !dbg !1162
  %578 = phi i32 [ %574, %566 ], [ %410, %402 ], !dbg !1162
  call void @llvm.dbg.value(metadata i8* %2, metadata !626, metadata !DIExpression()), !dbg !639
  %579 = getelementptr inbounds i8, i8* %2, i64 8, !dbg !1163
  %580 = bitcast i8* %579 to i32*, !dbg !1163
  store i32 %577, i32* %580, align 4, !dbg !1163
  %581 = getelementptr inbounds i8, i8* %2, i64 12, !dbg !1163
  %582 = bitcast i8* %581 to i32*, !dbg !1163
  store i32 %578, i32* %582, align 4, !dbg !1163
  call void @llvm.dbg.value(metadata %struct.fixed_point* @entropy_all, metadata !984, metadata !DIExpression()) #7, !dbg !1164
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !987, metadata !DIExpression()) #7, !dbg !1164
  call void @llvm.dbg.value(metadata %struct.fixed_point* @entropy_all, metadata !521, metadata !DIExpression()) #7, !dbg !1166
  call void @llvm.dbg.value(metadata %struct.fixed_point* undef, metadata !526, metadata !DIExpression()) #7, !dbg !1166
  %583 = load i32, i32* getelementptr inbounds (%struct.fixed_point, %struct.fixed_point* @entropy_all, i64 0, i32 1), align 4, !dbg !1168, !tbaa !531, !noalias !1169
  %584 = icmp sgt i32 %583, %578, !dbg !1172
  %585 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %584) #7
  %586 = xor i1 %585, true, !dbg !1173
  %587 = icmp slt i32 %583, %578
  %588 = select i1 %586, i1 %587, i1 false, !dbg !1173
  %589 = select i1 %588, i32 %578, i32 %583, !dbg !1173
  %590 = load i32, i32* getelementptr inbounds (%struct.fixed_point, %struct.fixed_point* @entropy_all, i64 0, i32 0), align 8, !dbg !1174, !tbaa !543, !noalias !1169
  %591 = add nsw i32 %577, %590, !dbg !1175
  %592 = sext i32 %591 to i64, !dbg !1176
  call void @llvm.dbg.value(metadata i64 %592, metadata !988, metadata !DIExpression()) #7, !dbg !1164
  call void @llvm.dbg.value(metadata i64 %592, metadata !550, metadata !DIExpression()) #7, !dbg !1177
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !1177
  %593 = icmp sgt i32 %591, -1, !dbg !1179
  br i1 %593, label %594, label %624, !dbg !1180

594:                                              ; preds = %576
  call void @llvm.dbg.value(metadata i64 %592, metadata !556, metadata !DIExpression(DW_OP_constu, 32, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !1177
  call void @llvm.dbg.value(metadata i32 64, metadata !555, metadata !DIExpression()) #7, !dbg !1177
  call void @llvm.dbg.value(metadata i64 %592, metadata !550, metadata !DIExpression()) #7, !dbg !1177
  %595 = lshr i64 %592, 16, !dbg !1181
  call void @llvm.dbg.value(metadata i32 %591, metadata !556, metadata !DIExpression(DW_OP_constu, 16, DW_OP_shra, DW_OP_stack_value)) #7, !dbg !1177
  %596 = icmp ult i32 %591, 65536, !dbg !1182
  %597 = select i1 %596, i64 %592, i64 %595, !dbg !1183
  %598 = select i1 %596, i32 64, i32 48, !dbg !1183
  call void @llvm.dbg.value(metadata i32 %598, metadata !555, metadata !DIExpression()) #7, !dbg !1177
  call void @llvm.dbg.value(metadata i64 %597, metadata !550, metadata !DIExpression()) #7, !dbg !1177
  %599 = lshr i64 %597, 8, !dbg !1184
  %600 = trunc i64 %599 to i32, !dbg !1185
  call void @llvm.dbg.value(metadata i32 %600, metadata !556, metadata !DIExpression()) #7, !dbg !1177
  %601 = icmp eq i32 %600, 0, !dbg !1186
  %602 = add nsw i32 %598, -8, !dbg !1187
  %603 = select i1 %601, i64 %597, i64 %599, !dbg !1187
  %604 = select i1 %601, i32 %598, i32 %602, !dbg !1187
  call void @llvm.dbg.value(metadata i32 %604, metadata !555, metadata !DIExpression()) #7, !dbg !1177
  call void @llvm.dbg.value(metadata i64 %603, metadata !550, metadata !DIExpression()) #7, !dbg !1177
  %605 = lshr i64 %603, 4, !dbg !1188
  %606 = trunc i64 %605 to i32, !dbg !1189
  call void @llvm.dbg.value(metadata i32 %606, metadata !556, metadata !DIExpression()) #7, !dbg !1177
  %607 = icmp eq i32 %606, 0, !dbg !1190
  %608 = add nsw i32 %604, -4, !dbg !1191
  %609 = select i1 %607, i64 %603, i64 %605, !dbg !1191
  %610 = select i1 %607, i32 %604, i32 %608, !dbg !1191
  call void @llvm.dbg.value(metadata i32 %610, metadata !555, metadata !DIExpression()) #7, !dbg !1177
  call void @llvm.dbg.value(metadata i64 %609, metadata !550, metadata !DIExpression()) #7, !dbg !1177
  %611 = lshr i64 %609, 2, !dbg !1192
  %612 = trunc i64 %611 to i32, !dbg !1193
  call void @llvm.dbg.value(metadata i32 %612, metadata !556, metadata !DIExpression()) #7, !dbg !1177
  %613 = icmp eq i32 %612, 0, !dbg !1194
  %614 = add nsw i32 %610, -2, !dbg !1195
  %615 = select i1 %613, i64 %609, i64 %611, !dbg !1195
  %616 = select i1 %613, i32 %610, i32 %614, !dbg !1195
  call void @llvm.dbg.value(metadata i32 %616, metadata !555, metadata !DIExpression()) #7, !dbg !1177
  call void @llvm.dbg.value(metadata i64 %615, metadata !550, metadata !DIExpression()) #7, !dbg !1177
  call void @llvm.dbg.value(metadata i64 %615, metadata !556, metadata !DIExpression(DW_OP_constu, 1, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #7, !dbg !1177
  %617 = and i64 %615, 8589934590, !dbg !1196
  %618 = icmp eq i64 %617, 0, !dbg !1196
  br i1 %618, label %621, label %619, !dbg !1197

619:                                              ; preds = %594
  %620 = add nsw i32 %616, -2, !dbg !1198
  br label %624, !dbg !1199

621:                                              ; preds = %594
  %622 = trunc i64 %615 to i32, !dbg !1200
  %623 = sub nsw i32 %616, %622, !dbg !1200
  br label %624, !dbg !1201

624:                                              ; preds = %621, %619, %576
  %625 = phi i32 [ %620, %619 ], [ %623, %621 ], [ -1, %576 ], !dbg !1177
  %626 = sub nsw i32 64, %625, !dbg !1202
  call void @llvm.dbg.value(metadata i32 %626, metadata !989, metadata !DIExpression()) #7, !dbg !1164
  call void @llvm.dbg.declare(metadata %struct.fixed_point* undef, metadata !990, metadata !DIExpression()) #7, !dbg !1203
  %627 = icmp sgt i32 %589, %626, !dbg !1204
  %628 = sub nsw i32 %589, %626, !dbg !1205
  %629 = zext i32 %628 to i64, !dbg !1205
  %630 = lshr i64 %592, %629, !dbg !1205
  %631 = trunc i64 %630 to i32, !dbg !1205
  %632 = select i1 %627, i32 %626, i32 %589, !dbg !1205
  %633 = select i1 %627, i32 %631, i32 %591, !dbg !1205
  %634 = zext i32 %632 to i64, !dbg !1206
  %635 = shl nuw i64 %634, 32, !dbg !1206
  %636 = zext i32 %633 to i64, !dbg !1206
  %637 = or i64 %635, %636, !dbg !1206
  store i64 %637, i64* bitcast (%struct.fixed_point* @entropy_all to i64*), align 8, !dbg !1206
  %638 = load i32, i32* @count, align 4, !dbg !1207, !tbaa !413
  %639 = add nsw i32 %638, 1, !dbg !1207
  store i32 %639, i32* @count, align 4, !dbg !1207, !tbaa !413
  ret i32 0, !dbg !1208
}

; Function Attrs: nounwind
define internal i32 @detection(%struct.bpf_map.3* noundef %0, i8* noundef %1, i8* nocapture noundef %2, i8* nocapture noundef readonly %3) #0 !dbg !1209 {
  call void @llvm.dbg.value(metadata %struct.bpf_map.3* %0, metadata !1215, metadata !DIExpression()), !dbg !1226
  call void @llvm.dbg.value(metadata i8* %1, metadata !1216, metadata !DIExpression()), !dbg !1226
  call void @llvm.dbg.value(metadata i8* %2, metadata !1217, metadata !DIExpression()), !dbg !1226
  call void @llvm.dbg.value(metadata i8* %3, metadata !1218, metadata !DIExpression()), !dbg !1226
  call void @llvm.dbg.value(metadata i8* %3, metadata !1219, metadata !DIExpression()), !dbg !1226
  call void @llvm.dbg.value(metadata i8* %2, metadata !1220, metadata !DIExpression()), !dbg !1226
  %5 = getelementptr inbounds i8, i8* %2, i64 8, !dbg !1227
  %6 = bitcast i8* %5 to i32*, !dbg !1229
  %7 = load i32, i32* %6, align 4, !dbg !1229, !tbaa !457
  %8 = icmp eq i32 %7, 0, !dbg !1230
  br i1 %8, label %9, label %14, !dbg !1231

9:                                                ; preds = %4
  call void @llvm.dbg.value(metadata i8* %2, metadata !1220, metadata !DIExpression()), !dbg !1226
  %10 = getelementptr inbounds i8, i8* %2, i64 4, !dbg !1232
  %11 = bitcast i8* %10 to i32*, !dbg !1232
  %12 = load i32, i32* %11, align 4, !dbg !1232, !tbaa !451
  %13 = bitcast i8* %2 to i32*, !dbg !1234
  store i32 %12, i32* %13, align 4, !dbg !1235, !tbaa !446
  store i32 0, i32* %11, align 4, !dbg !1236, !tbaa !451
  br label %35, !dbg !1237

14:                                               ; preds = %4
  call void @llvm.dbg.value(metadata i8* %3, metadata !1219, metadata !DIExpression()), !dbg !1226
  call void @llvm.dbg.value(metadata i8* %5, metadata !1238, metadata !DIExpression()) #7, !dbg !1245
  call void @llvm.dbg.value(metadata %struct.fixed_point* @avg, metadata !1241, metadata !DIExpression()) #7, !dbg !1245
  call void @llvm.dbg.value(metadata i8* %5, metadata !521, metadata !DIExpression()) #7, !dbg !1247
  call void @llvm.dbg.value(metadata %struct.fixed_point* @avg, metadata !526, metadata !DIExpression()) #7, !dbg !1247
  %15 = getelementptr inbounds i8, i8* %2, i64 12, !dbg !1249
  %16 = bitcast i8* %15 to i32*, !dbg !1249
  %17 = load i32, i32* %16, align 4, !dbg !1249, !tbaa !531, !noalias !1250
  %18 = load i32, i32* getelementptr inbounds (%struct.fixed_point, %struct.fixed_point* @avg, i64 0, i32 1), align 4, !dbg !1253, !tbaa !531, !noalias !1250
  %19 = icmp sgt i32 %17, %18, !dbg !1254
  %20 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %19) #7
  br i1 %20, label %21, label %22, !dbg !1255

21:                                               ; preds = %14
  store i32 %17, i32* getelementptr inbounds (%struct.fixed_point, %struct.fixed_point* @avg, i64 0, i32 1), align 4, !dbg !1256, !tbaa !531, !noalias !1250
  br label %25, !dbg !1258

22:                                               ; preds = %14
  %23 = icmp slt i32 %17, %18, !dbg !1259
  br i1 %23, label %24, label %25, !dbg !1260

24:                                               ; preds = %22
  store i32 %18, i32* %16, align 4, !dbg !1261, !tbaa !531, !noalias !1250
  br label %25, !dbg !1262

25:                                               ; preds = %21, %24, %22
  call void @llvm.dbg.value(metadata !DIArgList(i32 undef, i32 undef), metadata !1242, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_minus, DW_OP_LLVM_convert, 32, DW_ATE_signed, DW_OP_LLVM_convert, 64, DW_ATE_signed, DW_OP_stack_value)) #7, !dbg !1245
  call void @llvm.dbg.value(metadata !DIArgList(i32 64, i32 undef), metadata !1243, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_minus, DW_OP_stack_value)) #7, !dbg !1245
  call void @llvm.dbg.value(metadata i32 undef, metadata !1244, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !1245
  call void @llvm.dbg.value(metadata i32 undef, metadata !1221, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !1226
  call void @llvm.dbg.value(metadata i32 undef, metadata !1221, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !1226
  call void @llvm.dbg.value(metadata i32 undef, metadata !1244, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !1245
  call void @llvm.dbg.value(metadata i32 undef, metadata !1221, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !1226
  call void @llvm.dbg.value(metadata i32 undef, metadata !1244, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !1245
  call void @llvm.dbg.value(metadata !DIArgList(i32 undef, i32 undef), metadata !1222, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_constu, 32, DW_OP_shl, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_or, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 0, 32)), !dbg !1226
  call void @llvm.dbg.value(metadata !DIArgList(i32 undef, i32 undef), metadata !1222, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_constu, 32, DW_OP_shl, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_or, DW_OP_constu, 32, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 32, 32)), !dbg !1226
  %26 = getelementptr inbounds i8, i8* %2, i64 4, !dbg !1263
  %27 = bitcast i8* %26 to i32*, !dbg !1263
  %28 = load i32, i32* %27, align 4, !dbg !1263, !tbaa !451
  %29 = icmp eq i32 %28, 0, !dbg !1265
  br i1 %29, label %30, label %33, !dbg !1266

30:                                               ; preds = %25
  %31 = bitcast %struct.bpf_map.3* %0 to i8*, !dbg !1267
  %32 = tail call i64 inttoptr (i64 3 to i64 (i8*, i8*)*)(i8* noundef %31, i8* noundef %1) #7, !dbg !1269
  br label %35, !dbg !1270

33:                                               ; preds = %25
  %34 = bitcast i8* %2 to i32*, !dbg !1271
  store i32 %28, i32* %34, align 4, !dbg !1272, !tbaa !446
  store i32 0, i32* %27, align 4, !dbg !1273, !tbaa !451
  br label %35, !dbg !1274

35:                                               ; preds = %30, %33, %9
  ret i32 0, !dbg !1275
}

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #5

; Function Attrs: nounwind readnone
declare i1 @llvm.bpf.passthrough.i1.i1(i32, i1) #6

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.abs.i32(i32, i1 immarg) #5

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.usub.sat.i32(i32, i32) #5

attributes #0 = { nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #3 = { argmemonly mustprogress nofree nounwind willreturn }
attributes #4 = { mustprogress nounwind willreturn "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #5 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #6 = { nounwind readnone }
attributes #7 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!258, !259, !260, !261}
!llvm.ident = !{!262}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "blacklist", scope: !2, file: !3, line: 65, type: !238, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !20, globals: !38, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/nii2/ebpf_pfilt/kex/main", checksumkind: CSK_MD5, checksum: "d245a541c10371275efbffbfb0e9a4dd")
!4 = !{!5, !14}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 5436, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "", checksumkind: CSK_MD5, checksum: "3810ac036d82ed3898d498c10e871015")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2)
!12 = !DIEnumerator(name: "XDP_TX", value: 3)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 1168, baseType: !7, size: 32, elements: !15)
!15 = !{!16, !17, !18, !19}
!16 = !DIEnumerator(name: "BPF_ANY", value: 0)
!17 = !DIEnumerator(name: "BPF_NOEXIST", value: 1)
!18 = !DIEnumerator(name: "BPF_EXIST", value: 2)
!19 = !DIEnumerator(name: "BPF_F_LOCK", value: 4)
!20 = !{!21, !22, !23, !26, !27, !28, !33, !37}
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!22 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !24, line: 24, baseType: !25)
!24 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!25 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!26 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!27 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!28 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !29, line: 26, baseType: !30)
!29 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h", directory: "", checksumkind: CSK_MD5, checksum: "55bcbdc3159515ebd91d351a70d505f4")
!30 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !31, line: 41, baseType: !32)
!31 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "d108b5f93a74c50510d7d9bc0ab36df9")
!32 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!33 = !DIDerivedType(tag: DW_TAG_typedef, name: "u_int64_t", file: !34, line: 161, baseType: !35)
!34 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/sys/types.h", directory: "", checksumkind: CSK_MD5, checksum: "e62424071ad3f1b4d088c139fd9ccfd1")
!35 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !31, line: 48, baseType: !36)
!36 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!38 = !{!39, !45, !0, !74, !93, !112, !124, !126, !128, !185, !187, !194, !201, !208, !213, !219, !221, !226, !228, !233}
!39 = !DIGlobalVariableExpression(var: !40, expr: !DIExpression())
!40 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 332, type: !41, isLocal: false, isDefinition: true)
!41 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 32, elements: !43)
!42 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!43 = !{!44}
!44 = !DISubrange(count: 4)
!45 = !DIGlobalVariableExpression(var: !46, expr: !DIExpression())
!46 = distinct !DIGlobalVariable(name: "logger", scope: !2, file: !3, line: 56, type: !47, isLocal: false, isDefinition: true)
!47 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 50, size: 256, elements: !48)
!48 = !{!49, !54, !57, !69}
!49 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !47, file: !3, line: 52, baseType: !50, size: 64)
!50 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !51, size: 64)
!51 = !DICompositeType(tag: DW_TAG_array_type, baseType: !32, size: 32, elements: !52)
!52 = !{!53}
!53 = !DISubrange(count: 1)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !47, file: !3, line: 53, baseType: !55, size: 64, offset: 64)
!55 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !56, size: 64)
!56 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !24, line: 27, baseType: !7)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !47, file: !3, line: 54, baseType: !58, size: 64, offset: 128)
!58 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !59, size: 64)
!59 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "logger_value", file: !3, line: 30, size: 128, elements: !60)
!60 = !{!61, !62, !63}
!61 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !59, file: !3, line: 32, baseType: !28, size: 32)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "cur", scope: !59, file: !3, line: 33, baseType: !28, size: 32, offset: 32)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "entropy", scope: !59, file: !3, line: 34, baseType: !64, size: 64, offset: 64)
!64 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fixed_point", file: !65, line: 155, size: 64, elements: !66)
!65 = !DIFile(filename: "./fixed-point.h", directory: "/home/nii2/ebpf_pfilt/kex/main", checksumkind: CSK_MD5, checksum: "86a1e70feabf3d9f20ceafccd1b1b258")
!66 = !{!67, !68}
!67 = !DIDerivedType(tag: DW_TAG_member, name: "number", scope: !64, file: !65, line: 157, baseType: !28, size: 32)
!68 = !DIDerivedType(tag: DW_TAG_member, name: "q", scope: !64, file: !65, line: 158, baseType: !28, size: 32, offset: 32)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !47, file: !3, line: 55, baseType: !70, size: 64, offset: 192)
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64)
!71 = !DICompositeType(tag: DW_TAG_array_type, baseType: !32, size: 3200000, elements: !72)
!72 = !{!73}
!73 = !DISubrange(count: 100000)
!74 = !DIGlobalVariableExpression(var: !75, expr: !DIExpression())
!75 = distinct !DIGlobalVariable(name: "data", scope: !2, file: !3, line: 73, type: !76, isLocal: false, isDefinition: true)
!76 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 67, size: 256, elements: !77)
!77 = !{!78, !83, !84, !92}
!78 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !76, file: !3, line: 69, baseType: !79, size: 64)
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 64)
!80 = !DICompositeType(tag: DW_TAG_array_type, baseType: !32, size: 64, elements: !81)
!81 = !{!82}
!82 = !DISubrange(count: 2)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !76, file: !3, line: 70, baseType: !55, size: 64, offset: 64)
!84 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !76, file: !3, line: 71, baseType: !85, size: 64, offset: 128)
!85 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !86, size: 64)
!86 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "data_value", file: !3, line: 37, size: 128, elements: !87)
!87 = !{!88, !89, !90, !91}
!88 = !DIDerivedType(tag: DW_TAG_member, name: "prev_interval_pkt", scope: !86, file: !3, line: 39, baseType: !28, size: 32)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "cur_interval_pkt", scope: !86, file: !3, line: 40, baseType: !28, size: 32, offset: 32)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "threshold", scope: !86, file: !3, line: 41, baseType: !28, size: 32, offset: 64)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "int_bits", scope: !86, file: !3, line: 42, baseType: !28, size: 32, offset: 96)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !76, file: !3, line: 72, baseType: !50, size: 64, offset: 192)
!93 = !DIGlobalVariableExpression(var: !94, expr: !DIExpression())
!94 = distinct !DIGlobalVariable(name: "loc_ts", scope: !2, file: !3, line: 81, type: !95, isLocal: false, isDefinition: true)
!95 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 75, size: 256, elements: !96)
!96 = !{!97, !98, !99, !111}
!97 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !95, file: !3, line: 77, baseType: !79, size: 64)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !95, file: !3, line: 78, baseType: !55, size: 64, offset: 64)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !95, file: !3, line: 79, baseType: !100, size: 64, offset: 128)
!100 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !101, size: 64)
!101 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "loc_ts", file: !3, line: 44, size: 128, elements: !102)
!102 = !{!103, !107}
!103 = !DIDerivedType(tag: DW_TAG_member, name: "lock", scope: !101, file: !3, line: 46, baseType: !104, size: 32)
!104 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_spin_lock", file: !6, line: 6186, size: 32, elements: !105)
!105 = !{!106}
!106 = !DIDerivedType(tag: DW_TAG_member, name: "val", scope: !104, file: !6, line: 6187, baseType: !56, size: 32)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp", scope: !101, file: !3, line: 47, baseType: !108, size: 64, offset: 64)
!108 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !29, line: 27, baseType: !109)
!109 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !31, line: 47, baseType: !110)
!110 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!111 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !95, file: !3, line: 80, baseType: !50, size: 64, offset: 192)
!112 = !DIGlobalVariableExpression(var: !113, expr: !DIExpression())
!113 = distinct !DIGlobalVariable(name: "tx_port", scope: !2, file: !3, line: 88, type: !114, isLocal: false, isDefinition: true)
!114 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 83, size: 256, elements: !115)
!115 = !{!116, !121, !122, !123}
!116 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !114, file: !3, line: 84, baseType: !117, size: 64)
!117 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !118, size: 64)
!118 = !DICompositeType(tag: DW_TAG_array_type, baseType: !32, size: 448, elements: !119)
!119 = !{!120}
!120 = !DISubrange(count: 14)
!121 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !114, file: !3, line: 85, baseType: !55, size: 64, offset: 64)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !114, file: !3, line: 86, baseType: !55, size: 64, offset: 128)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !114, file: !3, line: 87, baseType: !50, size: 64, offset: 192)
!124 = !DIGlobalVariableExpression(var: !125, expr: !DIExpression())
!125 = distinct !DIGlobalVariable(name: "entropy_all", scope: !2, file: !3, line: 91, type: !64, isLocal: true, isDefinition: true)
!126 = !DIGlobalVariableExpression(var: !127, expr: !DIExpression())
!127 = distinct !DIGlobalVariable(name: "avg", scope: !2, file: !3, line: 92, type: !64, isLocal: true, isDefinition: true)
!128 = !DIGlobalVariableExpression(var: !129, expr: !DIExpression())
!129 = distinct !DIGlobalVariable(name: "stdin", scope: !2, file: !130, line: 143, type: !131, isLocal: false, isDefinition: false)
!130 = !DIFile(filename: "/usr/include/stdio.h", directory: "", checksumkind: CSK_MD5, checksum: "f31eefcc3f15835fc5a4023a625cf609")
!131 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !132, size: 64)
!132 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !133, line: 7, baseType: !134)
!133 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/FILE.h", directory: "", checksumkind: CSK_MD5, checksum: "571f9fb6223c42439075fdde11a0de5d")
!134 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !135, line: 49, size: 1728, elements: !136)
!135 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h", directory: "", checksumkind: CSK_MD5, checksum: "1bad07471b7974df4ecc1d1c2ca207e6")
!136 = !{!137, !138, !140, !141, !142, !143, !144, !145, !146, !147, !148, !149, !150, !153, !155, !156, !157, !159, !160, !162, !164, !167, !169, !172, !175, !176, !177, !180, !181}
!137 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !134, file: !135, line: 51, baseType: !32, size: 32)
!138 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !134, file: !135, line: 54, baseType: !139, size: 64, offset: 64)
!139 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !42, size: 64)
!140 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !134, file: !135, line: 55, baseType: !139, size: 64, offset: 128)
!141 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !134, file: !135, line: 56, baseType: !139, size: 64, offset: 192)
!142 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !134, file: !135, line: 57, baseType: !139, size: 64, offset: 256)
!143 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !134, file: !135, line: 58, baseType: !139, size: 64, offset: 320)
!144 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !134, file: !135, line: 59, baseType: !139, size: 64, offset: 384)
!145 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !134, file: !135, line: 60, baseType: !139, size: 64, offset: 448)
!146 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !134, file: !135, line: 61, baseType: !139, size: 64, offset: 512)
!147 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !134, file: !135, line: 64, baseType: !139, size: 64, offset: 576)
!148 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !134, file: !135, line: 65, baseType: !139, size: 64, offset: 640)
!149 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !134, file: !135, line: 66, baseType: !139, size: 64, offset: 704)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !134, file: !135, line: 68, baseType: !151, size: 64, offset: 768)
!151 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !152, size: 64)
!152 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !135, line: 36, flags: DIFlagFwdDecl)
!153 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !134, file: !135, line: 70, baseType: !154, size: 64, offset: 832)
!154 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !134, size: 64)
!155 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !134, file: !135, line: 72, baseType: !32, size: 32, offset: 896)
!156 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !134, file: !135, line: 73, baseType: !32, size: 32, offset: 928)
!157 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !134, file: !135, line: 74, baseType: !158, size: 64, offset: 960)
!158 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !31, line: 152, baseType: !22)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !134, file: !135, line: 77, baseType: !25, size: 16, offset: 1024)
!160 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !134, file: !135, line: 78, baseType: !161, size: 8, offset: 1040)
!161 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!162 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !134, file: !135, line: 79, baseType: !163, size: 8, offset: 1048)
!163 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 8, elements: !52)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !134, file: !135, line: 81, baseType: !165, size: 64, offset: 1088)
!165 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !166, size: 64)
!166 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !135, line: 43, baseType: null)
!167 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !134, file: !135, line: 89, baseType: !168, size: 64, offset: 1152)
!168 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !31, line: 153, baseType: !109)
!169 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !134, file: !135, line: 91, baseType: !170, size: 64, offset: 1216)
!170 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !171, size: 64)
!171 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !135, line: 37, flags: DIFlagFwdDecl)
!172 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !134, file: !135, line: 92, baseType: !173, size: 64, offset: 1280)
!173 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !174, size: 64)
!174 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !135, line: 38, flags: DIFlagFwdDecl)
!175 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !134, file: !135, line: 93, baseType: !154, size: 64, offset: 1344)
!176 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !134, file: !135, line: 94, baseType: !21, size: 64, offset: 1408)
!177 = !DIDerivedType(tag: DW_TAG_member, name: "__pad5", scope: !134, file: !135, line: 95, baseType: !178, size: 64, offset: 1472)
!178 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !179, line: 46, baseType: !26)
!179 = !DIFile(filename: "/usr/lib/llvm-14/lib/clang/14.0.0/include/stddef.h", directory: "", checksumkind: CSK_MD5, checksum: "2499dd2361b915724b073282bea3a7bc")
!180 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !134, file: !135, line: 96, baseType: !32, size: 32, offset: 1536)
!181 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !134, file: !135, line: 98, baseType: !182, size: 160, offset: 1568)
!182 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 160, elements: !183)
!183 = !{!184}
!184 = !DISubrange(count: 20)
!185 = !DIGlobalVariableExpression(var: !186, expr: !DIExpression())
!186 = distinct !DIGlobalVariable(name: "stdout", scope: !2, file: !130, line: 144, type: !131, isLocal: false, isDefinition: false)
!187 = !DIGlobalVariableExpression(var: !188, expr: !DIExpression())
!188 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !189, line: 114, type: !190, isLocal: true, isDefinition: true)
!189 = !DIFile(filename: "./../lib/libbpf/src/bpf_helper_defs.h", directory: "/home/nii2/ebpf_pfilt/kex/main", checksumkind: CSK_MD5, checksum: "7422ca06c9dc86eba2f268a57d8acf2f")
!190 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !191, size: 64)
!191 = !DISubroutineType(types: !192)
!192 = !{!193}
!193 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !24, line: 31, baseType: !36)
!194 = !DIGlobalVariableExpression(var: !195, expr: !DIExpression())
!195 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !189, line: 177, type: !196, isLocal: true, isDefinition: true)
!196 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !197, size: 64)
!197 = !DISubroutineType(types: !198)
!198 = !{!22, !199, !56, null}
!199 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !200, size: 64)
!200 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !42)
!201 = !DIGlobalVariableExpression(var: !202, expr: !DIExpression())
!202 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !189, line: 56, type: !203, isLocal: true, isDefinition: true)
!203 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !204, size: 64)
!204 = !DISubroutineType(types: !205)
!205 = !{!21, !21, !206}
!206 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !207, size: 64)
!207 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!208 = !DIGlobalVariableExpression(var: !209, expr: !DIExpression())
!209 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !189, line: 78, type: !210, isLocal: true, isDefinition: true)
!210 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !211, size: 64)
!211 = !DISubroutineType(types: !212)
!212 = !{!22, !21, !206, !206, !193}
!213 = !DIGlobalVariableExpression(var: !214, expr: !DIExpression())
!214 = distinct !DIGlobalVariable(name: "bpf_spin_lock", scope: !2, file: !189, line: 2404, type: !215, isLocal: true, isDefinition: true)
!215 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !216, size: 64)
!216 = !DISubroutineType(types: !217)
!217 = !{!22, !218}
!218 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !104, size: 64)
!219 = !DIGlobalVariableExpression(var: !220, expr: !DIExpression())
!220 = distinct !DIGlobalVariable(name: "bpf_spin_unlock", scope: !2, file: !189, line: 2415, type: !215, isLocal: true, isDefinition: true)
!221 = !DIGlobalVariableExpression(var: !222, expr: !DIExpression())
!222 = distinct !DIGlobalVariable(name: "bpf_for_each_map_elem", scope: !2, file: !189, line: 3909, type: !223, isLocal: true, isDefinition: true)
!223 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !224, size: 64)
!224 = !DISubroutineType(types: !225)
!225 = !{!22, !21, !21, !21, !193}
!226 = !DIGlobalVariableExpression(var: !227, expr: !DIExpression())
!227 = distinct !DIGlobalVariable(name: "count", scope: !2, file: !3, line: 90, type: !32, isLocal: true, isDefinition: true)
!228 = !DIGlobalVariableExpression(var: !229, expr: !DIExpression())
!229 = distinct !DIGlobalVariable(name: "bpf_map_delete_elem", scope: !2, file: !189, line: 88, type: !230, isLocal: true, isDefinition: true)
!230 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !231, size: 64)
!231 = !DISubroutineType(types: !232)
!232 = !{!22, !21, !206}
!233 = !DIGlobalVariableExpression(var: !234, expr: !DIExpression())
!234 = distinct !DIGlobalVariable(name: "bpf_redirect_map", scope: !2, file: !189, line: 1323, type: !235, isLocal: true, isDefinition: true)
!235 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !236, size: 64)
!236 = !DISubroutineType(types: !237)
!237 = !{!22, !21, !193, !193}
!238 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 58, size: 320, elements: !239)
!239 = !{!240, !245, !251, !252, !253}
!240 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !238, file: !3, line: 60, baseType: !241, size: 64)
!241 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !242, size: 64)
!242 = !DICompositeType(tag: DW_TAG_array_type, baseType: !32, size: 352, elements: !243)
!243 = !{!244}
!244 = !DISubrange(count: 11)
!245 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !238, file: !3, line: 61, baseType: !246, size: 64, offset: 64)
!246 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !247, size: 64)
!247 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "lpm_v4_key", file: !3, line: 24, size: 64, elements: !248)
!248 = !{!249, !250}
!249 = !DIDerivedType(tag: DW_TAG_member, name: "prefixlen", scope: !247, file: !3, line: 26, baseType: !56, size: 32)
!250 = !DIDerivedType(tag: DW_TAG_member, name: "address", scope: !247, file: !3, line: 27, baseType: !56, size: 32, offset: 32)
!251 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !238, file: !3, line: 62, baseType: !55, size: 64, offset: 128)
!252 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !238, file: !3, line: 63, baseType: !50, size: 64, offset: 192)
!253 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !238, file: !3, line: 64, baseType: !254, size: 64, offset: 256)
!254 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !255, size: 64)
!255 = !DICompositeType(tag: DW_TAG_array_type, baseType: !32, size: 320000, elements: !256)
!256 = !{!257}
!257 = !DISubrange(count: 10000)
!258 = !{i32 7, !"Dwarf Version", i32 5}
!259 = !{i32 2, !"Debug Info Version", i32 3}
!260 = !{i32 1, !"wchar_size", i32 4}
!261 = !{i32 7, !"frame-pointer", i32 2}
!262 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!263 = distinct !DISubprogram(name: "xdp_filter_func", scope: !3, file: !3, line: 189, type: !264, scopeLine: 190, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !275)
!264 = !DISubroutineType(types: !265)
!265 = !{!32, !266}
!266 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !267, size: 64)
!267 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 5447, size: 192, elements: !268)
!268 = !{!269, !270, !271, !272, !273, !274}
!269 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !267, file: !6, line: 5448, baseType: !56, size: 32)
!270 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !267, file: !6, line: 5449, baseType: !56, size: 32, offset: 32)
!271 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !267, file: !6, line: 5450, baseType: !56, size: 32, offset: 64)
!272 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !267, file: !6, line: 5452, baseType: !56, size: 32, offset: 96)
!273 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !267, file: !6, line: 5453, baseType: !56, size: 32, offset: 128)
!274 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !267, file: !6, line: 5455, baseType: !56, size: 32, offset: 160)
!275 = !{!276, !277, !278, !291, !314, !315, !321, !329, !330, !336, !337, !338, !344, !345, !348, !349, !352, !355, !356, !357}
!276 = !DILocalVariable(name: "ctx", arg: 1, scope: !263, file: !3, line: 189, type: !266)
!277 = !DILocalVariable(name: "ts", scope: !263, file: !3, line: 191, type: !108)
!278 = !DILocalVariable(name: "eth", scope: !263, file: !3, line: 192, type: !279)
!279 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !280, size: 64)
!280 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !281, line: 168, size: 112, elements: !282)
!281 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "", checksumkind: CSK_MD5, checksum: "ab0320da726e75d904811ce344979934")
!282 = !{!283, !287, !288}
!283 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !280, file: !281, line: 169, baseType: !284, size: 48)
!284 = !DICompositeType(tag: DW_TAG_array_type, baseType: !27, size: 48, elements: !285)
!285 = !{!286}
!286 = !DISubrange(count: 6)
!287 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !280, file: !281, line: 170, baseType: !284, size: 48, offset: 48)
!288 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !280, file: !281, line: 171, baseType: !289, size: 16, offset: 96)
!289 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !290, line: 25, baseType: !23)
!290 = !DIFile(filename: "/usr/include/linux/types.h", directory: "", checksumkind: CSK_MD5, checksum: "52ec79a38e49ac7d1dc9e146ba88a7b1")
!291 = !DILocalVariable(name: "ip", scope: !263, file: !3, line: 193, type: !292)
!292 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !293, size: 64)
!293 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !294, line: 44, size: 160, elements: !295)
!294 = !DIFile(filename: "/usr/include/netinet/ip.h", directory: "", checksumkind: CSK_MD5, checksum: "777a3c26c651c3cea644451d8391a76c")
!295 = !{!296, !297, !298, !302, !305, !306, !307, !308, !309, !310, !313}
!296 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !293, file: !294, line: 47, baseType: !7, size: 4, flags: DIFlagBitField, extraData: i64 0)
!297 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !293, file: !294, line: 48, baseType: !7, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!298 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !293, file: !294, line: 55, baseType: !299, size: 8, offset: 8)
!299 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !300, line: 24, baseType: !301)
!300 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "2bf2ae53c58c01b1a1b9383b5195125c")
!301 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !31, line: 38, baseType: !27)
!302 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !293, file: !294, line: 56, baseType: !303, size: 16, offset: 16)
!303 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !300, line: 25, baseType: !304)
!304 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !31, line: 40, baseType: !25)
!305 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !293, file: !294, line: 57, baseType: !303, size: 16, offset: 32)
!306 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !293, file: !294, line: 58, baseType: !303, size: 16, offset: 48)
!307 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !293, file: !294, line: 59, baseType: !299, size: 8, offset: 64)
!308 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !293, file: !294, line: 60, baseType: !299, size: 8, offset: 72)
!309 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !293, file: !294, line: 61, baseType: !303, size: 16, offset: 80)
!310 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !293, file: !294, line: 62, baseType: !311, size: 32, offset: 96)
!311 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !300, line: 26, baseType: !312)
!312 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !31, line: 42, baseType: !7)
!313 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !293, file: !294, line: 63, baseType: !311, size: 32, offset: 128)
!314 = !DILocalVariable(name: "filter_key", scope: !263, file: !3, line: 194, type: !247)
!315 = !DILocalVariable(name: "error_log", scope: !316, file: !3, line: 202, type: !318)
!316 = distinct !DILexicalBlock(scope: !317, file: !3, line: 201, column: 9)
!317 = distinct !DILexicalBlock(scope: !263, file: !3, line: 200, column: 13)
!318 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 232, elements: !319)
!319 = !{!320}
!320 = !DISubrange(count: 29)
!321 = !DILocalVariable(name: "error_log", scope: !322, file: !3, line: 215, type: !326)
!322 = distinct !DILexicalBlock(scope: !323, file: !3, line: 214, column: 17)
!323 = distinct !DILexicalBlock(scope: !324, file: !3, line: 213, column: 21)
!324 = distinct !DILexicalBlock(scope: !325, file: !3, line: 209, column: 9)
!325 = distinct !DILexicalBlock(scope: !263, file: !3, line: 208, column: 13)
!326 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 240, elements: !327)
!327 = !{!328}
!328 = !DISubrange(count: 30)
!329 = !DILocalVariable(name: "rule", scope: !324, file: !3, line: 229, type: !55)
!330 = !DILocalVariable(name: "error_log", scope: !331, file: !3, line: 232, type: !333)
!331 = distinct !DILexicalBlock(scope: !332, file: !3, line: 231, column: 17)
!332 = distinct !DILexicalBlock(scope: !324, file: !3, line: 230, column: 21)
!333 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 200, elements: !334)
!334 = !{!335}
!335 = !DISubrange(count: 25)
!336 = !DILocalVariable(name: "key", scope: !324, file: !3, line: 238, type: !32)
!337 = !DILocalVariable(name: "tmp", scope: !324, file: !3, line: 239, type: !85)
!338 = !DILocalVariable(name: "error_log", scope: !339, file: !3, line: 252, type: !341)
!339 = distinct !DILexicalBlock(scope: !340, file: !3, line: 251, column: 17)
!340 = distinct !DILexicalBlock(scope: !324, file: !3, line: 240, column: 21)
!341 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 304, elements: !342)
!342 = !{!343}
!343 = !DISubrange(count: 38)
!344 = !DILocalVariable(name: "value", scope: !324, file: !3, line: 258, type: !58)
!345 = !DILocalVariable(name: "new_value", scope: !346, file: !3, line: 268, type: !59)
!346 = distinct !DILexicalBlock(scope: !347, file: !3, line: 266, column: 17)
!347 = distinct !DILexicalBlock(scope: !324, file: !3, line: 259, column: 21)
!348 = !DILocalVariable(name: "lts", scope: !324, file: !3, line: 276, type: !100)
!349 = !DILocalVariable(name: "error_log", scope: !350, file: !3, line: 279, type: !318)
!350 = distinct !DILexicalBlock(scope: !351, file: !3, line: 278, column: 17)
!351 = distinct !DILexicalBlock(scope: !324, file: !3, line: 277, column: 21)
!352 = !DILocalVariable(name: "t", scope: !353, file: !3, line: 304, type: !86)
!353 = distinct !DILexicalBlock(scope: !354, file: !3, line: 285, column: 17)
!354 = distinct !DILexicalBlock(scope: !324, file: !3, line: 284, column: 21)
!355 = !DILocalVariable(name: "d", scope: !353, file: !3, line: 305, type: !85)
!356 = !DILocalVariable(name: "cnt", scope: !353, file: !3, line: 307, type: !64)
!357 = !DILabel(scope: !263, name: "END", file: !3, line: 328)
!358 = !DILocation(line: 0, scope: !263)
!359 = !DILocation(line: 191, column: 22, scope: !263)
!360 = !DILocation(line: 194, column: 9, scope: !263)
!361 = !DILocation(line: 194, column: 27, scope: !263)
!362 = !DILocation(line: 195, column: 20, scope: !263)
!363 = !DILocation(line: 195, column: 30, scope: !263)
!364 = !{!365, !366, i64 0}
!365 = !{!"lpm_v4_key", !366, i64 0, !366, i64 4}
!366 = !{!"int", !367, i64 0}
!367 = !{!"omnipotent char", !368, i64 0}
!368 = !{!"Simple C/C++ TBAA"}
!369 = !DILocation(line: 198, column: 34, scope: !263)
!370 = !{!371, !366, i64 0}
!371 = !{!"xdp_md", !366, i64 0, !366, i64 4, !366, i64 8, !366, i64 12, !366, i64 16, !366, i64 20}
!372 = !DILocation(line: 198, column: 23, scope: !263)
!373 = !DILocation(line: 198, column: 15, scope: !263)
!374 = !DILocation(line: 200, column: 23, scope: !317)
!375 = !DILocation(line: 200, column: 45, scope: !317)
!376 = !{!371, !366, i64 4}
!377 = !DILocation(line: 200, column: 40, scope: !317)
!378 = !DILocation(line: 200, column: 38, scope: !317)
!379 = !DILocation(line: 200, column: 13, scope: !263)
!380 = !DILocation(line: 202, column: 17, scope: !316)
!381 = !DILocation(line: 202, column: 22, scope: !316)
!382 = !DILocation(line: 203, column: 17, scope: !316)
!383 = !DILocation(line: 205, column: 9, scope: !317)
!384 = !DILocation(line: 208, column: 18, scope: !325)
!385 = !{!386, !387, i64 12}
!386 = !{!"ethhdr", !367, i64 0, !367, i64 6, !387, i64 12}
!387 = !{!"short", !367, i64 0}
!388 = !DILocation(line: 208, column: 26, scope: !325)
!389 = !DILocation(line: 208, column: 13, scope: !263)
!390 = !DILocation(line: 213, column: 46, scope: !323)
!391 = !DILocation(line: 213, column: 60, scope: !323)
!392 = !DILocation(line: 213, column: 21, scope: !324)
!393 = !DILocation(line: 215, column: 4, scope: !322)
!394 = !DILocation(line: 215, column: 9, scope: !322)
!395 = !DILocation(line: 216, column: 25, scope: !322)
!396 = !DILocation(line: 218, column: 17, scope: !323)
!397 = !DILocation(line: 228, column: 42, scope: !324)
!398 = !{!399, !366, i64 12}
!399 = !{!"iphdr", !366, i64 0, !366, i64 0, !367, i64 1, !387, i64 2, !387, i64 4, !387, i64 6, !367, i64 8, !367, i64 9, !387, i64 10, !366, i64 12, !366, i64 16}
!400 = !DILocation(line: 228, column: 28, scope: !324)
!401 = !DILocation(line: 228, column: 36, scope: !324)
!402 = !{!365, !366, i64 4}
!403 = !DILocation(line: 229, column: 31, scope: !324)
!404 = !DILocation(line: 0, scope: !324)
!405 = !DILocation(line: 230, column: 21, scope: !332)
!406 = !DILocation(line: 230, column: 21, scope: !324)
!407 = !DILocation(line: 232, column: 25, scope: !331)
!408 = !DILocation(line: 232, column: 30, scope: !331)
!409 = !DILocation(line: 233, column: 25, scope: !331)
!410 = !DILocation(line: 235, column: 17, scope: !332)
!411 = !DILocation(line: 238, column: 17, scope: !324)
!412 = !DILocation(line: 238, column: 21, scope: !324)
!413 = !{!366, !366, i64 0}
!414 = !DILocation(line: 239, column: 42, scope: !324)
!415 = !DILocation(line: 240, column: 21, scope: !340)
!416 = !DILocation(line: 240, column: 21, scope: !324)
!417 = !DILocation(line: 243, column: 25, scope: !418)
!418 = distinct !DILexicalBlock(scope: !340, file: !3, line: 241, column: 17)
!419 = !DILocation(line: 244, column: 34, scope: !420)
!420 = distinct !DILexicalBlock(scope: !418, file: !3, line: 244, column: 29)
!421 = !{!422, !366, i64 4}
!422 = !{!"data_value", !366, i64 0, !366, i64 4, !366, i64 8, !366, i64 12}
!423 = !DILocation(line: 244, column: 65, scope: !420)
!424 = !{!422, !366, i64 12}
!425 = !DILocation(line: 244, column: 74, scope: !420)
!426 = !DILocation(line: 244, column: 80, scope: !420)
!427 = !DILocation(line: 244, column: 51, scope: !420)
!428 = !DILocation(line: 244, column: 29, scope: !418)
!429 = !DILocation(line: 247, column: 33, scope: !430)
!430 = distinct !DILexicalBlock(scope: !420, file: !3, line: 245, column: 25)
!431 = !DILocation(line: 248, column: 25, scope: !430)
!432 = !DILocation(line: 252, column: 25, scope: !339)
!433 = !DILocation(line: 252, column: 30, scope: !339)
!434 = !DILocation(line: 253, column: 25, scope: !339)
!435 = !DILocation(line: 255, column: 17, scope: !340)
!436 = !DILocation(line: 258, column: 46, scope: !324)
!437 = !DILocation(line: 259, column: 21, scope: !347)
!438 = !DILocation(line: 259, column: 21, scope: !324)
!439 = !DILocation(line: 262, column: 25, scope: !440)
!440 = distinct !DILexicalBlock(scope: !347, file: !3, line: 260, column: 17)
!441 = !DILocation(line: 264, column: 17, scope: !440)
!442 = !DILocation(line: 268, column: 25, scope: !346)
!443 = !DILocation(line: 268, column: 45, scope: !346)
!444 = !DILocation(line: 269, column: 35, scope: !346)
!445 = !DILocation(line: 269, column: 40, scope: !346)
!446 = !{!447, !366, i64 0}
!447 = !{!"logger_value", !366, i64 0, !366, i64 4, !448, i64 8}
!448 = !{!"fixed_point", !366, i64 0, !366, i64 4}
!449 = !DILocation(line: 270, column: 35, scope: !346)
!450 = !DILocation(line: 270, column: 39, scope: !346)
!451 = !{!447, !366, i64 4}
!452 = !DILocation(line: 271, column: 43, scope: !346)
!453 = !DILocation(line: 271, column: 45, scope: !346)
!454 = !{!447, !366, i64 12}
!455 = !DILocation(line: 272, column: 43, scope: !346)
!456 = !DILocation(line: 272, column: 50, scope: !346)
!457 = !{!447, !366, i64 8}
!458 = !DILocation(line: 273, column: 25, scope: !346)
!459 = !DILocation(line: 274, column: 17, scope: !347)
!460 = !DILocation(line: 276, column: 38, scope: !324)
!461 = !DILocation(line: 277, column: 22, scope: !351)
!462 = !DILocation(line: 277, column: 21, scope: !324)
!463 = !DILocation(line: 279, column: 25, scope: !350)
!464 = !DILocation(line: 279, column: 30, scope: !350)
!465 = !DILocation(line: 280, column: 25, scope: !350)
!466 = !DILocation(line: 282, column: 17, scope: !351)
!467 = !DILocation(line: 284, column: 31, scope: !354)
!468 = !{!469, !471, i64 8}
!469 = !{!"loc_ts", !470, i64 0, !471, i64 8}
!470 = !{!"bpf_spin_lock", !366, i64 0}
!471 = !{!"long long", !367, i64 0}
!472 = !DILocation(line: 284, column: 41, scope: !354)
!473 = !DILocation(line: 284, column: 24, scope: !354)
!474 = !DILocation(line: 284, column: 21, scope: !324)
!475 = !DILocation(line: 287, column: 45, scope: !353)
!476 = !DILocation(line: 287, column: 25, scope: !353)
!477 = !DILocation(line: 288, column: 13, scope: !478)
!478 = distinct !DILexicalBlock(scope: !353, file: !3, line: 288, column: 8)
!479 = !DILocation(line: 288, column: 23, scope: !478)
!480 = !DILocation(line: 288, column: 8, scope: !353)
!481 = !DILocation(line: 290, column: 20, scope: !482)
!482 = distinct !DILexicalBlock(scope: !478, file: !3, line: 289, column: 18)
!483 = !DILocation(line: 291, column: 33, scope: !482)
!484 = !DILocation(line: 292, column: 5, scope: !482)
!485 = !DILocation(line: 294, column: 49, scope: !486)
!486 = distinct !DILexicalBlock(scope: !478, file: !3, line: 294, column: 29)
!487 = !DILocation(line: 294, column: 32, scope: !486)
!488 = !DILocation(line: 294, column: 29, scope: !478)
!489 = !DILocation(line: 296, column: 20, scope: !490)
!490 = distinct !DILexicalBlock(scope: !486, file: !3, line: 295, column: 18)
!491 = !DILocation(line: 302, column: 4, scope: !353)
!492 = !DILocation(line: 304, column: 25, scope: !353)
!493 = !DILocation(line: 304, column: 43, scope: !353)
!494 = !DILocation(line: 305, column: 48, scope: !353)
!495 = !DILocation(line: 0, scope: !353)
!496 = !DILocation(line: 306, column: 25, scope: !353)
!497 = !DILocation(line: 307, column: 65, scope: !353)
!498 = !DILocation(line: 307, column: 77, scope: !353)
!499 = !DILocalVariable(name: "fixed_point", arg: 1, scope: !500, file: !65, line: 174, type: !28)
!500 = distinct !DISubprogram(name: "to_fixed_point", scope: !65, file: !65, line: 174, type: !501, scopeLine: 175, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !503)
!501 = !DISubroutineType(types: !502)
!502 = !{!64, !28, !28}
!503 = !{!499, !504, !505}
!504 = !DILocalVariable(name: "q", arg: 2, scope: !500, file: !65, line: 174, type: !28)
!505 = !DILocalVariable(name: "fixed", scope: !500, file: !65, line: 176, type: !64)
!506 = !DILocation(line: 0, scope: !500, inlinedAt: !507)
!507 = distinct !DILocation(line: 307, column: 50, scope: !353)
!508 = !DILocation(line: 177, column: 22, scope: !500, inlinedAt: !507)
!509 = !DILocalVariable(name: "first", arg: 1, scope: !510, file: !65, line: 354, type: !513)
!510 = distinct !DISubprogram(name: "divide", scope: !65, file: !65, line: 354, type: !511, scopeLine: 355, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !514)
!511 = !DISubroutineType(types: !512)
!512 = !{!64, !513, !513}
!513 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !64, size: 64)
!514 = !{!509, !515, !516, !517, !518}
!515 = !DILocalVariable(name: "second", arg: 2, scope: !510, file: !65, line: 354, type: !513)
!516 = !DILocalVariable(name: "sum", scope: !510, file: !65, line: 357, type: !33)
!517 = !DILocalVariable(name: "allowed_fixed_point_bits", scope: !510, file: !65, line: 358, type: !28)
!518 = !DILocalVariable(name: "result", scope: !510, file: !65, line: 359, type: !64)
!519 = !DILocation(line: 0, scope: !510, inlinedAt: !520)
!520 = distinct !DILocation(line: 308, column: 31, scope: !353)
!521 = !DILocalVariable(name: "first", arg: 1, scope: !522, file: !65, line: 266, type: !513)
!522 = distinct !DISubprogram(name: "check_bit", scope: !65, file: !65, line: 266, type: !523, scopeLine: 267, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !525)
!523 = !DISubroutineType(types: !524)
!524 = !{null, !513, !513}
!525 = !{!521, !526}
!526 = !DILocalVariable(name: "second", arg: 2, scope: !522, file: !65, line: 266, type: !513)
!527 = !DILocation(line: 0, scope: !522, inlinedAt: !528)
!528 = distinct !DILocation(line: 356, column: 5, scope: !510, inlinedAt: !520)
!529 = !DILocation(line: 268, column: 16, scope: !530, inlinedAt: !528)
!530 = distinct !DILexicalBlock(scope: !522, file: !65, line: 268, column: 9)
!531 = !{!448, !366, i64 4}
!532 = !{!533}
!533 = distinct !{!533, !534, !"divide: argument 0"}
!534 = distinct !{!534, !"divide"}
!535 = !DILocation(line: 268, column: 18, scope: !530, inlinedAt: !528)
!536 = !DILocation(line: 268, column: 9, scope: !522, inlinedAt: !528)
!537 = !DILocation(line: 276, column: 18, scope: !538, inlinedAt: !528)
!538 = distinct !DILexicalBlock(scope: !539, file: !65, line: 275, column: 5)
!539 = distinct !DILexicalBlock(scope: !530, file: !65, line: 274, column: 14)
!540 = !DILocation(line: 278, column: 5, scope: !538, inlinedAt: !528)
!541 = !DILocation(line: 357, column: 89, scope: !510, inlinedAt: !520)
!542 = !DILocation(line: 357, column: 41, scope: !510, inlinedAt: !520)
!543 = !{!448, !366, i64 0}
!544 = !DILocation(line: 357, column: 23, scope: !510, inlinedAt: !520)
!545 = !DILocation(line: 357, column: 48, scope: !510, inlinedAt: !520)
!546 = !DILocation(line: 357, column: 57, scope: !510, inlinedAt: !520)
!547 = !DILocation(line: 357, column: 55, scope: !510, inlinedAt: !520)
!548 = !DILocation(line: 357, column: 80, scope: !510, inlinedAt: !520)
!549 = !DILocation(line: 357, column: 73, scope: !510, inlinedAt: !520)
!550 = !DILocalVariable(name: "x", arg: 1, scope: !551, file: !65, line: 182, type: !108)
!551 = distinct !DISubprogram(name: "count_zero_64", scope: !65, file: !65, line: 182, type: !552, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !554)
!552 = !DISubroutineType(types: !553)
!553 = !{!32, !108}
!554 = !{!550, !555, !556}
!555 = !DILocalVariable(name: "n", scope: !551, file: !65, line: 184, type: !32)
!556 = !DILocalVariable(name: "y", scope: !551, file: !65, line: 185, type: !7)
!557 = !DILocation(line: 0, scope: !551, inlinedAt: !558)
!558 = distinct !DILocation(line: 358, column: 46, scope: !510, inlinedAt: !520)
!559 = !DILocation(line: 186, column: 11, scope: !560, inlinedAt: !558)
!560 = distinct !DILexicalBlock(scope: !551, file: !65, line: 186, column: 9)
!561 = !DILocation(line: 186, column: 9, scope: !551, inlinedAt: !558)
!562 = !DILocation(line: 197, column: 11, scope: !551, inlinedAt: !558)
!563 = !DILocation(line: 197, column: 9, scope: !551, inlinedAt: !558)
!564 = !DILocation(line: 198, column: 11, scope: !565, inlinedAt: !558)
!565 = distinct !DILexicalBlock(scope: !551, file: !65, line: 198, column: 9)
!566 = !DILocation(line: 198, column: 9, scope: !551, inlinedAt: !558)
!567 = !DILocation(line: 203, column: 11, scope: !551, inlinedAt: !558)
!568 = !DILocation(line: 203, column: 9, scope: !551, inlinedAt: !558)
!569 = !DILocation(line: 204, column: 11, scope: !570, inlinedAt: !558)
!570 = distinct !DILexicalBlock(scope: !551, file: !65, line: 204, column: 9)
!571 = !DILocation(line: 204, column: 9, scope: !551, inlinedAt: !558)
!572 = !DILocation(line: 209, column: 11, scope: !551, inlinedAt: !558)
!573 = !DILocation(line: 209, column: 9, scope: !551, inlinedAt: !558)
!574 = !DILocation(line: 210, column: 11, scope: !575, inlinedAt: !558)
!575 = distinct !DILexicalBlock(scope: !551, file: !65, line: 210, column: 9)
!576 = !DILocation(line: 210, column: 9, scope: !551, inlinedAt: !558)
!577 = !DILocation(line: 215, column: 11, scope: !551, inlinedAt: !558)
!578 = !DILocation(line: 215, column: 9, scope: !551, inlinedAt: !558)
!579 = !DILocation(line: 216, column: 11, scope: !580, inlinedAt: !558)
!580 = distinct !DILexicalBlock(scope: !551, file: !65, line: 216, column: 9)
!581 = !DILocation(line: 216, column: 9, scope: !551, inlinedAt: !558)
!582 = !DILocation(line: 222, column: 11, scope: !583, inlinedAt: !558)
!583 = distinct !DILexicalBlock(scope: !551, file: !65, line: 222, column: 9)
!584 = !DILocation(line: 222, column: 9, scope: !551, inlinedAt: !558)
!585 = !DILocation(line: 223, column: 18, scope: !583, inlinedAt: !558)
!586 = !DILocation(line: 223, column: 9, scope: !583, inlinedAt: !558)
!587 = !DILocation(line: 224, column: 12, scope: !551, inlinedAt: !558)
!588 = !DILocation(line: 224, column: 5, scope: !551, inlinedAt: !558)
!589 = !DILocation(line: 358, column: 44, scope: !510, inlinedAt: !520)
!590 = !DILocation(line: 359, column: 24, scope: !510, inlinedAt: !520)
!591 = !DILocation(line: 360, column: 34, scope: !592, inlinedAt: !520)
!592 = distinct !DILexicalBlock(scope: !510, file: !65, line: 360, column: 9)
!593 = !DILocation(line: 360, column: 9, scope: !510, inlinedAt: !520)
!594 = !DILocation(line: 308, column: 31, scope: !353)
!595 = !DILocation(line: 315, column: 25, scope: !353)
!596 = !DILocation(line: 318, column: 55, scope: !353)
!597 = !DILocation(line: 318, column: 30, scope: !353)
!598 = !DILocation(line: 318, column: 48, scope: !353)
!599 = !{!422, !366, i64 0}
!600 = !DILocation(line: 319, column: 47, scope: !353)
!601 = !DILocation(line: 320, column: 39, scope: !353)
!602 = !DILocation(line: 321, column: 24, scope: !353)
!603 = !DILocation(line: 322, column: 44, scope: !353)
!604 = !DILocation(line: 323, column: 39, scope: !353)
!605 = !DILocation(line: 324, column: 17, scope: !354)
!606 = !DILocation(line: 324, column: 17, scope: !353)
!607 = !DILocation(line: 299, column: 5, scope: !608)
!608 = distinct !DILexicalBlock(scope: !486, file: !3, line: 298, column: 4)
!609 = !DILocation(line: 300, column: 5, scope: !608)
!610 = !DILocation(line: 325, column: 9, scope: !325)
!611 = !DILocation(line: 328, column: 2, scope: !263)
!612 = !DILocation(line: 330, column: 16, scope: !263)
!613 = !DILocation(line: 330, column: 9, scope: !263)
!614 = !DILocation(line: 331, column: 1, scope: !263)
!615 = distinct !DISubprogram(name: "calc_entropy", scope: !3, file: !3, line: 94, type: !616, scopeLine: 95, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !620)
!616 = !DISubroutineType(types: !617)
!617 = !{!32, !618, !206, !21, !21}
!618 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !619, size: 64)
!619 = !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map", file: !3, line: 94, flags: DIFlagFwdDecl)
!620 = !{!621, !622, !623, !624, !625, !626, !627, !628, !629, !630, !631, !632, !633, !634, !637}
!621 = !DILocalVariable(name: "map", arg: 1, scope: !615, file: !3, line: 94, type: !618)
!622 = !DILocalVariable(name: "key", arg: 2, scope: !615, file: !3, line: 94, type: !206)
!623 = !DILocalVariable(name: "value", arg: 3, scope: !615, file: !3, line: 94, type: !21)
!624 = !DILocalVariable(name: "ctx", arg: 4, scope: !615, file: !3, line: 94, type: !21)
!625 = !DILocalVariable(name: "tmp", scope: !615, file: !3, line: 96, type: !85)
!626 = !DILocalVariable(name: "logger_value", scope: !615, file: !3, line: 98, type: !58)
!627 = !DILocalVariable(name: "cur", scope: !615, file: !3, line: 99, type: !64)
!628 = !DILocalVariable(name: "prev", scope: !615, file: !3, line: 100, type: !64)
!629 = !DILocalVariable(name: "entropy", scope: !615, file: !3, line: 101, type: !64)
!630 = !DILocalVariable(name: "prev_invl", scope: !615, file: !3, line: 104, type: !64)
!631 = !DILocalVariable(name: "tmp_one", scope: !615, file: !3, line: 106, type: !64)
!632 = !DILocalVariable(name: "tmp_ten", scope: !615, file: !3, line: 107, type: !64)
!633 = !DILocalVariable(name: "first", scope: !615, file: !3, line: 123, type: !64)
!634 = !DILocalVariable(name: "second", scope: !635, file: !3, line: 128, type: !64)
!635 = distinct !DILexicalBlock(scope: !636, file: !3, line: 127, column: 9)
!636 = distinct !DILexicalBlock(scope: !615, file: !3, line: 126, column: 13)
!637 = !DILocalVariable(name: "second", scope: !638, file: !3, line: 135, type: !64)
!638 = distinct !DILexicalBlock(scope: !636, file: !3, line: 134, column: 9)
!639 = !DILocation(line: 0, scope: !615)
!640 = !DILocation(line: 99, column: 28, scope: !615)
!641 = !DILocation(line: 99, column: 63, scope: !615)
!642 = !DILocation(line: 99, column: 73, scope: !615)
!643 = !DILocation(line: 0, scope: !500, inlinedAt: !644)
!644 = distinct !DILocation(line: 99, column: 34, scope: !615)
!645 = !DILocation(line: 176, column: 24, scope: !500, inlinedAt: !644)
!646 = !DILocation(line: 177, column: 22, scope: !500, inlinedAt: !644)
!647 = !DILocation(line: 100, column: 28, scope: !615)
!648 = !DILocation(line: 100, column: 64, scope: !615)
!649 = !DILocation(line: 0, scope: !500, inlinedAt: !650)
!650 = distinct !DILocation(line: 100, column: 35, scope: !615)
!651 = !DILocation(line: 176, column: 24, scope: !500, inlinedAt: !650)
!652 = !DILocation(line: 177, column: 22, scope: !500, inlinedAt: !650)
!653 = !DILocation(line: 101, column: 28, scope: !615)
!654 = !DILocation(line: 104, column: 60, scope: !615)
!655 = !DILocation(line: 0, scope: !500, inlinedAt: !656)
!656 = distinct !DILocation(line: 104, column: 40, scope: !615)
!657 = !DILocation(line: 177, column: 22, scope: !500, inlinedAt: !656)
!658 = !DILocation(line: 0, scope: !500, inlinedAt: !659)
!659 = distinct !DILocation(line: 106, column: 38, scope: !615)
!660 = !DILocation(line: 177, column: 22, scope: !500, inlinedAt: !659)
!661 = !DILocation(line: 0, scope: !500, inlinedAt: !662)
!662 = distinct !DILocation(line: 107, column: 38, scope: !615)
!663 = !DILocation(line: 177, column: 22, scope: !500, inlinedAt: !662)
!664 = !DILocation(line: 109, column: 32, scope: !665)
!665 = distinct !DILexicalBlock(scope: !615, file: !3, line: 109, column: 13)
!666 = !DILocation(line: 109, column: 37, scope: !665)
!667 = !DILocation(line: 109, column: 58, scope: !665)
!668 = !DILocation(line: 109, column: 13, scope: !615)
!669 = !DILocation(line: 0, scope: !510, inlinedAt: !670)
!670 = distinct !DILocation(line: 113, column: 24, scope: !671)
!671 = distinct !DILexicalBlock(scope: !672, file: !3, line: 112, column: 13)
!672 = distinct !DILexicalBlock(scope: !673, file: !3, line: 111, column: 17)
!673 = distinct !DILexicalBlock(scope: !665, file: !3, line: 110, column: 9)
!674 = !DILocation(line: 0, scope: !522, inlinedAt: !675)
!675 = distinct !DILocation(line: 356, column: 5, scope: !510, inlinedAt: !670)
!676 = !DILocation(line: 268, column: 9, scope: !522, inlinedAt: !675)
!677 = !DILocation(line: 357, column: 23, scope: !510, inlinedAt: !670)
!678 = !DILocation(line: 357, column: 48, scope: !510, inlinedAt: !670)
!679 = !DILocation(line: 357, column: 57, scope: !510, inlinedAt: !670)
!680 = !DILocation(line: 357, column: 55, scope: !510, inlinedAt: !670)
!681 = !DILocation(line: 357, column: 80, scope: !510, inlinedAt: !670)
!682 = !DILocation(line: 357, column: 73, scope: !510, inlinedAt: !670)
!683 = !DILocation(line: 0, scope: !551, inlinedAt: !684)
!684 = distinct !DILocation(line: 358, column: 46, scope: !510, inlinedAt: !670)
!685 = !DILocation(line: 186, column: 11, scope: !560, inlinedAt: !684)
!686 = !DILocation(line: 186, column: 9, scope: !551, inlinedAt: !684)
!687 = !DILocation(line: 197, column: 11, scope: !551, inlinedAt: !684)
!688 = !DILocation(line: 197, column: 9, scope: !551, inlinedAt: !684)
!689 = !DILocation(line: 198, column: 11, scope: !565, inlinedAt: !684)
!690 = !DILocation(line: 198, column: 9, scope: !551, inlinedAt: !684)
!691 = !DILocation(line: 203, column: 11, scope: !551, inlinedAt: !684)
!692 = !DILocation(line: 203, column: 9, scope: !551, inlinedAt: !684)
!693 = !DILocation(line: 204, column: 11, scope: !570, inlinedAt: !684)
!694 = !DILocation(line: 204, column: 9, scope: !551, inlinedAt: !684)
!695 = !DILocation(line: 209, column: 11, scope: !551, inlinedAt: !684)
!696 = !DILocation(line: 209, column: 9, scope: !551, inlinedAt: !684)
!697 = !DILocation(line: 210, column: 11, scope: !575, inlinedAt: !684)
!698 = !DILocation(line: 210, column: 9, scope: !551, inlinedAt: !684)
!699 = !DILocation(line: 215, column: 11, scope: !551, inlinedAt: !684)
!700 = !DILocation(line: 215, column: 9, scope: !551, inlinedAt: !684)
!701 = !DILocation(line: 216, column: 11, scope: !580, inlinedAt: !684)
!702 = !DILocation(line: 216, column: 9, scope: !551, inlinedAt: !684)
!703 = !DILocation(line: 222, column: 11, scope: !583, inlinedAt: !684)
!704 = !DILocation(line: 222, column: 9, scope: !551, inlinedAt: !684)
!705 = !DILocation(line: 223, column: 18, scope: !583, inlinedAt: !684)
!706 = !DILocation(line: 223, column: 9, scope: !583, inlinedAt: !684)
!707 = !DILocation(line: 224, column: 12, scope: !551, inlinedAt: !684)
!708 = !DILocation(line: 224, column: 5, scope: !551, inlinedAt: !684)
!709 = !DILocation(line: 358, column: 44, scope: !510, inlinedAt: !670)
!710 = !DILocation(line: 359, column: 24, scope: !510, inlinedAt: !670)
!711 = !DILocation(line: 360, column: 34, scope: !592, inlinedAt: !670)
!712 = !DILocation(line: 360, column: 9, scope: !510, inlinedAt: !670)
!713 = !DILocation(line: 113, column: 24, scope: !671)
!714 = !DILocation(line: 116, column: 35, scope: !715)
!715 = distinct !DILexicalBlock(scope: !673, file: !3, line: 116, column: 17)
!716 = !DILocation(line: 116, column: 17, scope: !673)
!717 = !DILocation(line: 0, scope: !510, inlinedAt: !718)
!718 = distinct !DILocation(line: 118, column: 23, scope: !719)
!719 = distinct !DILexicalBlock(scope: !715, file: !3, line: 117, column: 13)
!720 = !DILocation(line: 0, scope: !522, inlinedAt: !721)
!721 = distinct !DILocation(line: 356, column: 5, scope: !510, inlinedAt: !718)
!722 = !DILocation(line: 268, column: 9, scope: !522, inlinedAt: !721)
!723 = !DILocation(line: 274, column: 14, scope: !530, inlinedAt: !721)
!724 = !DILocation(line: 357, column: 89, scope: !510, inlinedAt: !718)
!725 = !DILocation(line: 357, column: 23, scope: !510, inlinedAt: !718)
!726 = !DILocation(line: 357, column: 48, scope: !510, inlinedAt: !718)
!727 = !DILocation(line: 357, column: 57, scope: !510, inlinedAt: !718)
!728 = !DILocation(line: 357, column: 55, scope: !510, inlinedAt: !718)
!729 = !DILocation(line: 357, column: 80, scope: !510, inlinedAt: !718)
!730 = !DILocation(line: 357, column: 73, scope: !510, inlinedAt: !718)
!731 = !DILocation(line: 0, scope: !551, inlinedAt: !732)
!732 = distinct !DILocation(line: 358, column: 46, scope: !510, inlinedAt: !718)
!733 = !DILocation(line: 186, column: 11, scope: !560, inlinedAt: !732)
!734 = !DILocation(line: 186, column: 9, scope: !551, inlinedAt: !732)
!735 = !DILocation(line: 197, column: 11, scope: !551, inlinedAt: !732)
!736 = !DILocation(line: 197, column: 9, scope: !551, inlinedAt: !732)
!737 = !DILocation(line: 198, column: 11, scope: !565, inlinedAt: !732)
!738 = !DILocation(line: 198, column: 9, scope: !551, inlinedAt: !732)
!739 = !DILocation(line: 203, column: 11, scope: !551, inlinedAt: !732)
!740 = !DILocation(line: 203, column: 9, scope: !551, inlinedAt: !732)
!741 = !DILocation(line: 204, column: 11, scope: !570, inlinedAt: !732)
!742 = !DILocation(line: 204, column: 9, scope: !551, inlinedAt: !732)
!743 = !DILocation(line: 209, column: 11, scope: !551, inlinedAt: !732)
!744 = !DILocation(line: 209, column: 9, scope: !551, inlinedAt: !732)
!745 = !DILocation(line: 210, column: 11, scope: !575, inlinedAt: !732)
!746 = !DILocation(line: 210, column: 9, scope: !551, inlinedAt: !732)
!747 = !DILocation(line: 215, column: 11, scope: !551, inlinedAt: !732)
!748 = !DILocation(line: 215, column: 9, scope: !551, inlinedAt: !732)
!749 = !DILocation(line: 216, column: 11, scope: !580, inlinedAt: !732)
!750 = !DILocation(line: 216, column: 9, scope: !551, inlinedAt: !732)
!751 = !DILocation(line: 222, column: 11, scope: !583, inlinedAt: !732)
!752 = !DILocation(line: 222, column: 9, scope: !551, inlinedAt: !732)
!753 = !DILocation(line: 223, column: 18, scope: !583, inlinedAt: !732)
!754 = !DILocation(line: 223, column: 9, scope: !583, inlinedAt: !732)
!755 = !DILocation(line: 224, column: 12, scope: !551, inlinedAt: !732)
!756 = !DILocation(line: 224, column: 5, scope: !551, inlinedAt: !732)
!757 = !DILocation(line: 358, column: 44, scope: !510, inlinedAt: !718)
!758 = !DILocation(line: 359, column: 24, scope: !510, inlinedAt: !718)
!759 = !DILocation(line: 360, column: 34, scope: !592, inlinedAt: !718)
!760 = !DILocation(line: 360, column: 9, scope: !510, inlinedAt: !718)
!761 = !DILocation(line: 118, column: 23, scope: !719)
!762 = !DILocation(line: 119, column: 13, scope: !719)
!763 = !DILocation(line: 123, column: 28, scope: !615)
!764 = !DILocation(line: 0, scope: !510, inlinedAt: !765)
!765 = distinct !DILocation(line: 123, column: 36, scope: !615)
!766 = !DILocation(line: 0, scope: !522, inlinedAt: !767)
!767 = distinct !DILocation(line: 356, column: 5, scope: !510, inlinedAt: !765)
!768 = !DILocation(line: 268, column: 18, scope: !530, inlinedAt: !767)
!769 = !DILocation(line: 268, column: 9, scope: !522, inlinedAt: !767)
!770 = !DILocation(line: 274, column: 23, scope: !539, inlinedAt: !767)
!771 = !DILocation(line: 274, column: 14, scope: !530, inlinedAt: !767)
!772 = !DILocation(line: 279, column: 1, scope: !522, inlinedAt: !767)
!773 = !DILocation(line: 357, column: 23, scope: !510, inlinedAt: !765)
!774 = !DILocation(line: 357, column: 48, scope: !510, inlinedAt: !765)
!775 = !DILocation(line: 357, column: 57, scope: !510, inlinedAt: !765)
!776 = !DILocation(line: 357, column: 55, scope: !510, inlinedAt: !765)
!777 = !DILocation(line: 357, column: 80, scope: !510, inlinedAt: !765)
!778 = !DILocation(line: 357, column: 73, scope: !510, inlinedAt: !765)
!779 = !DILocation(line: 0, scope: !551, inlinedAt: !780)
!780 = distinct !DILocation(line: 358, column: 46, scope: !510, inlinedAt: !765)
!781 = !DILocation(line: 186, column: 11, scope: !560, inlinedAt: !780)
!782 = !DILocation(line: 186, column: 9, scope: !551, inlinedAt: !780)
!783 = !DILocation(line: 197, column: 11, scope: !551, inlinedAt: !780)
!784 = !DILocation(line: 197, column: 9, scope: !551, inlinedAt: !780)
!785 = !DILocation(line: 198, column: 11, scope: !565, inlinedAt: !780)
!786 = !DILocation(line: 198, column: 9, scope: !551, inlinedAt: !780)
!787 = !DILocation(line: 203, column: 11, scope: !551, inlinedAt: !780)
!788 = !DILocation(line: 203, column: 9, scope: !551, inlinedAt: !780)
!789 = !DILocation(line: 204, column: 11, scope: !570, inlinedAt: !780)
!790 = !DILocation(line: 204, column: 9, scope: !551, inlinedAt: !780)
!791 = !DILocation(line: 209, column: 11, scope: !551, inlinedAt: !780)
!792 = !DILocation(line: 209, column: 9, scope: !551, inlinedAt: !780)
!793 = !DILocation(line: 210, column: 11, scope: !575, inlinedAt: !780)
!794 = !DILocation(line: 210, column: 9, scope: !551, inlinedAt: !780)
!795 = !DILocation(line: 215, column: 11, scope: !551, inlinedAt: !780)
!796 = !DILocation(line: 215, column: 9, scope: !551, inlinedAt: !780)
!797 = !DILocation(line: 216, column: 11, scope: !580, inlinedAt: !780)
!798 = !DILocation(line: 216, column: 9, scope: !551, inlinedAt: !780)
!799 = !DILocation(line: 222, column: 11, scope: !583, inlinedAt: !780)
!800 = !DILocation(line: 222, column: 9, scope: !551, inlinedAt: !780)
!801 = !DILocation(line: 223, column: 18, scope: !583, inlinedAt: !780)
!802 = !DILocation(line: 223, column: 9, scope: !583, inlinedAt: !780)
!803 = !DILocation(line: 224, column: 12, scope: !551, inlinedAt: !780)
!804 = !DILocation(line: 224, column: 5, scope: !551, inlinedAt: !780)
!805 = !DILocation(line: 358, column: 44, scope: !510, inlinedAt: !765)
!806 = !DILocation(line: 359, column: 24, scope: !510, inlinedAt: !765)
!807 = !DILocation(line: 360, column: 34, scope: !592, inlinedAt: !765)
!808 = !DILocation(line: 360, column: 9, scope: !510, inlinedAt: !765)
!809 = !DILocation(line: 0, scope: !592, inlinedAt: !765)
!810 = !DILocalVariable(name: "number", arg: 1, scope: !811, file: !65, line: 374, type: !513)
!811 = distinct !DISubprogram(name: "calc_log", scope: !65, file: !65, line: 374, type: !812, scopeLine: 375, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !814)
!812 = !DISubroutineType(types: !813)
!813 = !{!64, !513}
!814 = !{!810, !815, !819, !820, !823}
!815 = !DILocalVariable(name: "array", scope: !811, file: !65, line: 376, type: !816)
!816 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, size: 16384, elements: !817)
!817 = !{!818}
!818 = !DISubrange(count: 256)
!819 = !DILocalVariable(name: "leading_zero", scope: !811, file: !65, line: 377, type: !28)
!820 = !DILocalVariable(name: "result", scope: !821, file: !65, line: 380, type: !64)
!821 = distinct !DILexicalBlock(scope: !822, file: !65, line: 379, column: 5)
!822 = distinct !DILexicalBlock(scope: !811, file: !65, line: 378, column: 9)
!823 = !DILocalVariable(name: "result", scope: !824, file: !65, line: 387, type: !64)
!824 = distinct !DILexicalBlock(scope: !822, file: !65, line: 386, column: 5)
!825 = !DILocation(line: 0, scope: !811, inlinedAt: !826)
!826 = distinct !DILocation(line: 124, column: 17, scope: !615)
!827 = !DILocation(line: 376, column: 19, scope: !811, inlinedAt: !826)
!828 = !DILocation(line: 377, column: 42, scope: !811, inlinedAt: !826)
!829 = !DILocalVariable(name: "x", arg: 1, scope: !830, file: !65, line: 227, type: !108)
!830 = distinct !DISubprogram(name: "count_zero_32", scope: !65, file: !65, line: 227, type: !552, scopeLine: 228, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !831)
!831 = !{!829, !832, !833}
!832 = !DILocalVariable(name: "n", scope: !830, file: !65, line: 229, type: !32)
!833 = !DILocalVariable(name: "y", scope: !830, file: !65, line: 230, type: !7)
!834 = !DILocation(line: 0, scope: !830, inlinedAt: !835)
!835 = distinct !DILocation(line: 377, column: 28, scope: !811, inlinedAt: !826)
!836 = !DILocation(line: 231, column: 11, scope: !837, inlinedAt: !835)
!837 = distinct !DILexicalBlock(scope: !830, file: !65, line: 231, column: 9)
!838 = !DILocation(line: 231, column: 9, scope: !830, inlinedAt: !835)
!839 = !DILocation(line: 236, column: 11, scope: !830, inlinedAt: !835)
!840 = !DILocation(line: 237, column: 11, scope: !841, inlinedAt: !835)
!841 = distinct !DILexicalBlock(scope: !830, file: !65, line: 237, column: 9)
!842 = !DILocation(line: 237, column: 9, scope: !830, inlinedAt: !835)
!843 = !DILocation(line: 242, column: 11, scope: !830, inlinedAt: !835)
!844 = !DILocation(line: 242, column: 9, scope: !830, inlinedAt: !835)
!845 = !DILocation(line: 243, column: 11, scope: !846, inlinedAt: !835)
!846 = distinct !DILexicalBlock(scope: !830, file: !65, line: 243, column: 9)
!847 = !DILocation(line: 243, column: 9, scope: !830, inlinedAt: !835)
!848 = !DILocation(line: 248, column: 11, scope: !830, inlinedAt: !835)
!849 = !DILocation(line: 248, column: 9, scope: !830, inlinedAt: !835)
!850 = !DILocation(line: 249, column: 11, scope: !851, inlinedAt: !835)
!851 = distinct !DILexicalBlock(scope: !830, file: !65, line: 249, column: 9)
!852 = !DILocation(line: 249, column: 9, scope: !830, inlinedAt: !835)
!853 = !DILocation(line: 254, column: 11, scope: !830, inlinedAt: !835)
!854 = !DILocation(line: 254, column: 9, scope: !830, inlinedAt: !835)
!855 = !DILocation(line: 255, column: 11, scope: !856, inlinedAt: !835)
!856 = distinct !DILexicalBlock(scope: !830, file: !65, line: 255, column: 9)
!857 = !DILocation(line: 255, column: 9, scope: !830, inlinedAt: !835)
!858 = !DILocation(line: 261, column: 11, scope: !859, inlinedAt: !835)
!859 = distinct !DILexicalBlock(scope: !830, file: !65, line: 261, column: 9)
!860 = !DILocation(line: 261, column: 9, scope: !830, inlinedAt: !835)
!861 = !DILocation(line: 262, column: 18, scope: !859, inlinedAt: !835)
!862 = !DILocation(line: 378, column: 27, scope: !822, inlinedAt: !826)
!863 = !DILocation(line: 263, column: 12, scope: !830, inlinedAt: !835)
!864 = !DILocation(line: 380, column: 28, scope: !821, inlinedAt: !826)
!865 = !DILocation(line: 382, column: 42, scope: !821, inlinedAt: !826)
!866 = !DILocation(line: 382, column: 58, scope: !821, inlinedAt: !826)
!867 = !DILocation(line: 382, column: 139, scope: !821, inlinedAt: !826)
!868 = !DILocation(line: 382, column: 122, scope: !821, inlinedAt: !826)
!869 = !DILocation(line: 382, column: 145, scope: !821, inlinedAt: !826)
!870 = !DILocation(line: 382, column: 90, scope: !821, inlinedAt: !826)
!871 = !DILocation(line: 382, column: 84, scope: !821, inlinedAt: !826)
!872 = !{!873, !873, i64 0}
!873 = !{!"long", !367, i64 0}
!874 = !{!875}
!875 = distinct !{!875, !876, !"calc_log: argument 0"}
!876 = distinct !{!876, !"calc_log"}
!877 = !DILocation(line: 382, column: 161, scope: !821, inlinedAt: !826)
!878 = !DILocation(line: 382, column: 154, scope: !821, inlinedAt: !826)
!879 = !DILocation(line: 382, column: 25, scope: !821, inlinedAt: !826)
!880 = !DILocation(line: 383, column: 9, scope: !821, inlinedAt: !826)
!881 = !DILocation(line: 126, column: 25, scope: !636)
!882 = !DILocation(line: 126, column: 13, scope: !615)
!883 = !DILocation(line: 128, column: 36, scope: !635)
!884 = !DILocation(line: 0, scope: !510, inlinedAt: !885)
!885 = distinct !DILocation(line: 128, column: 45, scope: !635)
!886 = !DILocation(line: 0, scope: !522, inlinedAt: !887)
!887 = distinct !DILocation(line: 356, column: 5, scope: !510, inlinedAt: !885)
!888 = !DILocation(line: 268, column: 18, scope: !530, inlinedAt: !887)
!889 = !DILocation(line: 268, column: 9, scope: !522, inlinedAt: !887)
!890 = !DILocation(line: 274, column: 23, scope: !539, inlinedAt: !887)
!891 = !DILocation(line: 274, column: 14, scope: !530, inlinedAt: !887)
!892 = !DILocation(line: 0, scope: !530, inlinedAt: !887)
!893 = !DILocation(line: 279, column: 1, scope: !522, inlinedAt: !887)
!894 = !DILocation(line: 357, column: 89, scope: !510, inlinedAt: !885)
!895 = !DILocation(line: 357, column: 23, scope: !510, inlinedAt: !885)
!896 = !DILocation(line: 357, column: 48, scope: !510, inlinedAt: !885)
!897 = !DILocation(line: 357, column: 57, scope: !510, inlinedAt: !885)
!898 = !DILocation(line: 357, column: 55, scope: !510, inlinedAt: !885)
!899 = !DILocation(line: 357, column: 80, scope: !510, inlinedAt: !885)
!900 = !DILocation(line: 357, column: 73, scope: !510, inlinedAt: !885)
!901 = !DILocation(line: 0, scope: !551, inlinedAt: !902)
!902 = distinct !DILocation(line: 358, column: 46, scope: !510, inlinedAt: !885)
!903 = !DILocation(line: 186, column: 11, scope: !560, inlinedAt: !902)
!904 = !DILocation(line: 186, column: 9, scope: !551, inlinedAt: !902)
!905 = !DILocation(line: 197, column: 11, scope: !551, inlinedAt: !902)
!906 = !DILocation(line: 197, column: 9, scope: !551, inlinedAt: !902)
!907 = !DILocation(line: 198, column: 11, scope: !565, inlinedAt: !902)
!908 = !DILocation(line: 198, column: 9, scope: !551, inlinedAt: !902)
!909 = !DILocation(line: 203, column: 11, scope: !551, inlinedAt: !902)
!910 = !DILocation(line: 203, column: 9, scope: !551, inlinedAt: !902)
!911 = !DILocation(line: 204, column: 11, scope: !570, inlinedAt: !902)
!912 = !DILocation(line: 204, column: 9, scope: !551, inlinedAt: !902)
!913 = !DILocation(line: 209, column: 11, scope: !551, inlinedAt: !902)
!914 = !DILocation(line: 209, column: 9, scope: !551, inlinedAt: !902)
!915 = !DILocation(line: 210, column: 11, scope: !575, inlinedAt: !902)
!916 = !DILocation(line: 210, column: 9, scope: !551, inlinedAt: !902)
!917 = !DILocation(line: 215, column: 11, scope: !551, inlinedAt: !902)
!918 = !DILocation(line: 215, column: 9, scope: !551, inlinedAt: !902)
!919 = !DILocation(line: 216, column: 11, scope: !580, inlinedAt: !902)
!920 = !DILocation(line: 216, column: 9, scope: !551, inlinedAt: !902)
!921 = !DILocation(line: 222, column: 11, scope: !583, inlinedAt: !902)
!922 = !DILocation(line: 222, column: 9, scope: !551, inlinedAt: !902)
!923 = !DILocation(line: 223, column: 18, scope: !583, inlinedAt: !902)
!924 = !DILocation(line: 223, column: 9, scope: !583, inlinedAt: !902)
!925 = !DILocation(line: 224, column: 12, scope: !551, inlinedAt: !902)
!926 = !DILocation(line: 224, column: 5, scope: !551, inlinedAt: !902)
!927 = !DILocation(line: 358, column: 44, scope: !510, inlinedAt: !885)
!928 = !DILocation(line: 359, column: 24, scope: !510, inlinedAt: !885)
!929 = !DILocation(line: 360, column: 34, scope: !592, inlinedAt: !885)
!930 = !DILocation(line: 360, column: 9, scope: !510, inlinedAt: !885)
!931 = !DILocation(line: 0, scope: !592, inlinedAt: !885)
!932 = !DILocation(line: 0, scope: !811, inlinedAt: !933)
!933 = distinct !DILocation(line: 129, column: 26, scope: !635)
!934 = !DILocation(line: 376, column: 19, scope: !811, inlinedAt: !933)
!935 = !DILocation(line: 377, column: 42, scope: !811, inlinedAt: !933)
!936 = !DILocation(line: 0, scope: !830, inlinedAt: !937)
!937 = distinct !DILocation(line: 377, column: 28, scope: !811, inlinedAt: !933)
!938 = !DILocation(line: 231, column: 11, scope: !837, inlinedAt: !937)
!939 = !DILocation(line: 231, column: 9, scope: !830, inlinedAt: !937)
!940 = !DILocation(line: 236, column: 11, scope: !830, inlinedAt: !937)
!941 = !DILocation(line: 237, column: 11, scope: !841, inlinedAt: !937)
!942 = !DILocation(line: 237, column: 9, scope: !830, inlinedAt: !937)
!943 = !DILocation(line: 242, column: 11, scope: !830, inlinedAt: !937)
!944 = !DILocation(line: 242, column: 9, scope: !830, inlinedAt: !937)
!945 = !DILocation(line: 243, column: 11, scope: !846, inlinedAt: !937)
!946 = !DILocation(line: 243, column: 9, scope: !830, inlinedAt: !937)
!947 = !DILocation(line: 248, column: 11, scope: !830, inlinedAt: !937)
!948 = !DILocation(line: 248, column: 9, scope: !830, inlinedAt: !937)
!949 = !DILocation(line: 249, column: 11, scope: !851, inlinedAt: !937)
!950 = !DILocation(line: 249, column: 9, scope: !830, inlinedAt: !937)
!951 = !DILocation(line: 254, column: 11, scope: !830, inlinedAt: !937)
!952 = !DILocation(line: 254, column: 9, scope: !830, inlinedAt: !937)
!953 = !DILocation(line: 255, column: 11, scope: !856, inlinedAt: !937)
!954 = !DILocation(line: 255, column: 9, scope: !830, inlinedAt: !937)
!955 = !DILocation(line: 261, column: 11, scope: !859, inlinedAt: !937)
!956 = !DILocation(line: 261, column: 9, scope: !830, inlinedAt: !937)
!957 = !DILocation(line: 262, column: 18, scope: !859, inlinedAt: !937)
!958 = !DILocation(line: 378, column: 27, scope: !822, inlinedAt: !933)
!959 = !DILocation(line: 263, column: 12, scope: !830, inlinedAt: !937)
!960 = !DILocation(line: 380, column: 28, scope: !821, inlinedAt: !933)
!961 = !DILocation(line: 382, column: 42, scope: !821, inlinedAt: !933)
!962 = !DILocation(line: 382, column: 58, scope: !821, inlinedAt: !933)
!963 = !DILocation(line: 382, column: 139, scope: !821, inlinedAt: !933)
!964 = !DILocation(line: 382, column: 122, scope: !821, inlinedAt: !933)
!965 = !DILocation(line: 382, column: 145, scope: !821, inlinedAt: !933)
!966 = !DILocation(line: 382, column: 90, scope: !821, inlinedAt: !933)
!967 = !DILocation(line: 382, column: 84, scope: !821, inlinedAt: !933)
!968 = !{!969}
!969 = distinct !{!969, !970, !"calc_log: argument 0"}
!970 = distinct !{!970, !"calc_log"}
!971 = !DILocation(line: 382, column: 161, scope: !821, inlinedAt: !933)
!972 = !DILocation(line: 382, column: 154, scope: !821, inlinedAt: !933)
!973 = !DILocation(line: 382, column: 25, scope: !821, inlinedAt: !933)
!974 = !DILocation(line: 383, column: 9, scope: !821, inlinedAt: !933)
!975 = !DILocation(line: 129, column: 26, scope: !635)
!976 = !DILocalVariable(name: "number", arg: 1, scope: !977, file: !65, line: 394, type: !513)
!977 = distinct !DISubprogram(name: "abs_val", scope: !65, file: !65, line: 394, type: !812, scopeLine: 395, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !978)
!978 = !{!976, !979}
!979 = !DILocalVariable(name: "mask", scope: !977, file: !65, line: 396, type: !980)
!980 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !28)
!981 = !DILocation(line: 0, scope: !977, inlinedAt: !982)
!982 = distinct !DILocation(line: 130, column: 26, scope: !635)
!983 = !DILocation(line: 397, column: 46, scope: !977, inlinedAt: !982)
!984 = !DILocalVariable(name: "first", arg: 1, scope: !985, file: !65, line: 281, type: !513)
!985 = distinct !DISubprogram(name: "add", scope: !65, file: !65, line: 281, type: !511, scopeLine: 282, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !986)
!986 = !{!984, !987, !988, !989, !990}
!987 = !DILocalVariable(name: "second", arg: 2, scope: !985, file: !65, line: 281, type: !513)
!988 = !DILocalVariable(name: "sum", scope: !985, file: !65, line: 284, type: !33)
!989 = !DILocalVariable(name: "allowed_fixed_point_bits", scope: !985, file: !65, line: 285, type: !28)
!990 = !DILocalVariable(name: "result", scope: !985, file: !65, line: 286, type: !64)
!991 = !DILocation(line: 0, scope: !985, inlinedAt: !992)
!992 = distinct !DILocation(line: 131, column: 27, scope: !635)
!993 = !DILocation(line: 0, scope: !522, inlinedAt: !994)
!994 = distinct !DILocation(line: 283, column: 5, scope: !985, inlinedAt: !992)
!995 = !DILocation(line: 268, column: 18, scope: !530, inlinedAt: !994)
!996 = !DILocation(line: 268, column: 9, scope: !522, inlinedAt: !994)
!997 = !DILocation(line: 274, column: 23, scope: !539, inlinedAt: !994)
!998 = !DILocation(line: 274, column: 14, scope: !530, inlinedAt: !994)
!999 = !DILocation(line: 279, column: 1, scope: !522, inlinedAt: !994)
!1000 = !DILocation(line: 124, column: 17, scope: !615)
!1001 = !DILocation(line: 284, column: 35, scope: !985, inlinedAt: !992)
!1002 = !DILocation(line: 284, column: 21, scope: !985, inlinedAt: !992)
!1003 = !DILocation(line: 0, scope: !551, inlinedAt: !1004)
!1004 = distinct !DILocation(line: 285, column: 46, scope: !985, inlinedAt: !992)
!1005 = !DILocation(line: 186, column: 11, scope: !560, inlinedAt: !1004)
!1006 = !DILocation(line: 186, column: 9, scope: !551, inlinedAt: !1004)
!1007 = !DILocation(line: 197, column: 11, scope: !551, inlinedAt: !1004)
!1008 = !DILocation(line: 198, column: 11, scope: !565, inlinedAt: !1004)
!1009 = !DILocation(line: 198, column: 9, scope: !551, inlinedAt: !1004)
!1010 = !DILocation(line: 203, column: 11, scope: !551, inlinedAt: !1004)
!1011 = !DILocation(line: 203, column: 9, scope: !551, inlinedAt: !1004)
!1012 = !DILocation(line: 204, column: 11, scope: !570, inlinedAt: !1004)
!1013 = !DILocation(line: 204, column: 9, scope: !551, inlinedAt: !1004)
!1014 = !DILocation(line: 209, column: 11, scope: !551, inlinedAt: !1004)
!1015 = !DILocation(line: 209, column: 9, scope: !551, inlinedAt: !1004)
!1016 = !DILocation(line: 210, column: 11, scope: !575, inlinedAt: !1004)
!1017 = !DILocation(line: 210, column: 9, scope: !551, inlinedAt: !1004)
!1018 = !DILocation(line: 215, column: 11, scope: !551, inlinedAt: !1004)
!1019 = !DILocation(line: 215, column: 9, scope: !551, inlinedAt: !1004)
!1020 = !DILocation(line: 216, column: 11, scope: !580, inlinedAt: !1004)
!1021 = !DILocation(line: 216, column: 9, scope: !551, inlinedAt: !1004)
!1022 = !DILocation(line: 222, column: 11, scope: !583, inlinedAt: !1004)
!1023 = !DILocation(line: 222, column: 9, scope: !551, inlinedAt: !1004)
!1024 = !DILocation(line: 223, column: 18, scope: !583, inlinedAt: !1004)
!1025 = !DILocation(line: 223, column: 9, scope: !583, inlinedAt: !1004)
!1026 = !DILocation(line: 224, column: 12, scope: !551, inlinedAt: !1004)
!1027 = !DILocation(line: 224, column: 5, scope: !551, inlinedAt: !1004)
!1028 = !DILocation(line: 285, column: 44, scope: !985, inlinedAt: !992)
!1029 = !DILocation(line: 286, column: 24, scope: !985, inlinedAt: !992)
!1030 = !DILocation(line: 287, column: 34, scope: !1031, inlinedAt: !992)
!1031 = distinct !DILexicalBlock(scope: !985, file: !65, line: 287, column: 9)
!1032 = !DILocation(line: 287, column: 9, scope: !985, inlinedAt: !992)
!1033 = !DILocation(line: 132, column: 9, scope: !635)
!1034 = !DILocation(line: 135, column: 36, scope: !638)
!1035 = !DILocation(line: 0, scope: !510, inlinedAt: !1036)
!1036 = distinct !DILocation(line: 135, column: 45, scope: !638)
!1037 = !DILocation(line: 0, scope: !522, inlinedAt: !1038)
!1038 = distinct !DILocation(line: 356, column: 5, scope: !510, inlinedAt: !1036)
!1039 = !DILocation(line: 268, column: 18, scope: !530, inlinedAt: !1038)
!1040 = !DILocation(line: 268, column: 9, scope: !522, inlinedAt: !1038)
!1041 = !DILocation(line: 357, column: 57, scope: !510, inlinedAt: !1036)
!1042 = !DILocation(line: 357, column: 55, scope: !510, inlinedAt: !1036)
!1043 = !DILocation(line: 357, column: 73, scope: !510, inlinedAt: !1036)
!1044 = !DILocation(line: 0, scope: !551, inlinedAt: !1045)
!1045 = distinct !DILocation(line: 358, column: 46, scope: !510, inlinedAt: !1036)
!1046 = !DILocation(line: 186, column: 11, scope: !560, inlinedAt: !1045)
!1047 = !DILocation(line: 186, column: 9, scope: !551, inlinedAt: !1045)
!1048 = !DILocation(line: 197, column: 11, scope: !551, inlinedAt: !1045)
!1049 = !DILocation(line: 197, column: 9, scope: !551, inlinedAt: !1045)
!1050 = !DILocation(line: 198, column: 11, scope: !565, inlinedAt: !1045)
!1051 = !DILocation(line: 198, column: 9, scope: !551, inlinedAt: !1045)
!1052 = !DILocation(line: 203, column: 11, scope: !551, inlinedAt: !1045)
!1053 = !DILocation(line: 203, column: 9, scope: !551, inlinedAt: !1045)
!1054 = !DILocation(line: 204, column: 11, scope: !570, inlinedAt: !1045)
!1055 = !DILocation(line: 204, column: 9, scope: !551, inlinedAt: !1045)
!1056 = !DILocation(line: 209, column: 11, scope: !551, inlinedAt: !1045)
!1057 = !DILocation(line: 209, column: 9, scope: !551, inlinedAt: !1045)
!1058 = !DILocation(line: 210, column: 11, scope: !575, inlinedAt: !1045)
!1059 = !DILocation(line: 210, column: 9, scope: !551, inlinedAt: !1045)
!1060 = !DILocation(line: 215, column: 11, scope: !551, inlinedAt: !1045)
!1061 = !DILocation(line: 215, column: 9, scope: !551, inlinedAt: !1045)
!1062 = !DILocation(line: 216, column: 11, scope: !580, inlinedAt: !1045)
!1063 = !DILocation(line: 216, column: 9, scope: !551, inlinedAt: !1045)
!1064 = !DILocation(line: 222, column: 11, scope: !583, inlinedAt: !1045)
!1065 = !DILocation(line: 222, column: 9, scope: !551, inlinedAt: !1045)
!1066 = !DILocation(line: 223, column: 18, scope: !583, inlinedAt: !1045)
!1067 = !DILocation(line: 223, column: 9, scope: !583, inlinedAt: !1045)
!1068 = !DILocation(line: 224, column: 12, scope: !551, inlinedAt: !1045)
!1069 = !DILocation(line: 224, column: 5, scope: !551, inlinedAt: !1045)
!1070 = !DILocation(line: 358, column: 44, scope: !510, inlinedAt: !1036)
!1071 = !DILocation(line: 359, column: 24, scope: !510, inlinedAt: !1036)
!1072 = !DILocation(line: 360, column: 34, scope: !592, inlinedAt: !1036)
!1073 = !DILocation(line: 360, column: 9, scope: !510, inlinedAt: !1036)
!1074 = !DILocation(line: 0, scope: !592, inlinedAt: !1036)
!1075 = !DILocation(line: 0, scope: !811, inlinedAt: !1076)
!1076 = distinct !DILocation(line: 136, column: 26, scope: !638)
!1077 = !DILocation(line: 376, column: 19, scope: !811, inlinedAt: !1076)
!1078 = !DILocation(line: 377, column: 42, scope: !811, inlinedAt: !1076)
!1079 = !DILocation(line: 0, scope: !830, inlinedAt: !1080)
!1080 = distinct !DILocation(line: 377, column: 28, scope: !811, inlinedAt: !1076)
!1081 = !DILocation(line: 231, column: 11, scope: !837, inlinedAt: !1080)
!1082 = !DILocation(line: 231, column: 9, scope: !830, inlinedAt: !1080)
!1083 = !DILocation(line: 236, column: 11, scope: !830, inlinedAt: !1080)
!1084 = !DILocation(line: 237, column: 11, scope: !841, inlinedAt: !1080)
!1085 = !DILocation(line: 237, column: 9, scope: !830, inlinedAt: !1080)
!1086 = !DILocation(line: 242, column: 11, scope: !830, inlinedAt: !1080)
!1087 = !DILocation(line: 242, column: 9, scope: !830, inlinedAt: !1080)
!1088 = !DILocation(line: 243, column: 11, scope: !846, inlinedAt: !1080)
!1089 = !DILocation(line: 243, column: 9, scope: !830, inlinedAt: !1080)
!1090 = !DILocation(line: 248, column: 11, scope: !830, inlinedAt: !1080)
!1091 = !DILocation(line: 248, column: 9, scope: !830, inlinedAt: !1080)
!1092 = !DILocation(line: 249, column: 11, scope: !851, inlinedAt: !1080)
!1093 = !DILocation(line: 249, column: 9, scope: !830, inlinedAt: !1080)
!1094 = !DILocation(line: 254, column: 11, scope: !830, inlinedAt: !1080)
!1095 = !DILocation(line: 254, column: 9, scope: !830, inlinedAt: !1080)
!1096 = !DILocation(line: 255, column: 11, scope: !856, inlinedAt: !1080)
!1097 = !DILocation(line: 255, column: 9, scope: !830, inlinedAt: !1080)
!1098 = !DILocation(line: 261, column: 11, scope: !859, inlinedAt: !1080)
!1099 = !DILocation(line: 261, column: 9, scope: !830, inlinedAt: !1080)
!1100 = !DILocation(line: 262, column: 18, scope: !859, inlinedAt: !1080)
!1101 = !DILocation(line: 378, column: 27, scope: !822, inlinedAt: !1076)
!1102 = !DILocation(line: 263, column: 12, scope: !830, inlinedAt: !1080)
!1103 = !DILocation(line: 380, column: 28, scope: !821, inlinedAt: !1076)
!1104 = !DILocation(line: 382, column: 42, scope: !821, inlinedAt: !1076)
!1105 = !DILocation(line: 382, column: 58, scope: !821, inlinedAt: !1076)
!1106 = !DILocation(line: 382, column: 139, scope: !821, inlinedAt: !1076)
!1107 = !DILocation(line: 382, column: 122, scope: !821, inlinedAt: !1076)
!1108 = !DILocation(line: 382, column: 145, scope: !821, inlinedAt: !1076)
!1109 = !DILocation(line: 382, column: 90, scope: !821, inlinedAt: !1076)
!1110 = !DILocation(line: 382, column: 84, scope: !821, inlinedAt: !1076)
!1111 = !{!1112}
!1112 = distinct !{!1112, !1113, !"calc_log: argument 0"}
!1113 = distinct !{!1113, !"calc_log"}
!1114 = !DILocation(line: 382, column: 161, scope: !821, inlinedAt: !1076)
!1115 = !DILocation(line: 382, column: 154, scope: !821, inlinedAt: !1076)
!1116 = !DILocation(line: 382, column: 25, scope: !821, inlinedAt: !1076)
!1117 = !DILocation(line: 383, column: 9, scope: !821, inlinedAt: !1076)
!1118 = !DILocation(line: 136, column: 26, scope: !638)
!1119 = !DILocation(line: 0, scope: !977, inlinedAt: !1120)
!1120 = distinct !DILocation(line: 137, column: 26, scope: !638)
!1121 = !DILocation(line: 397, column: 46, scope: !977, inlinedAt: !1120)
!1122 = !DILocation(line: 0, scope: !985, inlinedAt: !1123)
!1123 = distinct !DILocation(line: 138, column: 27, scope: !638)
!1124 = !DILocation(line: 0, scope: !522, inlinedAt: !1125)
!1125 = distinct !DILocation(line: 283, column: 5, scope: !985, inlinedAt: !1123)
!1126 = !DILocation(line: 268, column: 18, scope: !530, inlinedAt: !1125)
!1127 = !DILocation(line: 268, column: 9, scope: !522, inlinedAt: !1125)
!1128 = !DILocation(line: 274, column: 23, scope: !539, inlinedAt: !1125)
!1129 = !DILocation(line: 274, column: 14, scope: !530, inlinedAt: !1125)
!1130 = !DILocation(line: 279, column: 1, scope: !522, inlinedAt: !1125)
!1131 = !DILocation(line: 284, column: 35, scope: !985, inlinedAt: !1123)
!1132 = !DILocation(line: 284, column: 21, scope: !985, inlinedAt: !1123)
!1133 = !DILocation(line: 0, scope: !551, inlinedAt: !1134)
!1134 = distinct !DILocation(line: 285, column: 46, scope: !985, inlinedAt: !1123)
!1135 = !DILocation(line: 186, column: 11, scope: !560, inlinedAt: !1134)
!1136 = !DILocation(line: 186, column: 9, scope: !551, inlinedAt: !1134)
!1137 = !DILocation(line: 197, column: 11, scope: !551, inlinedAt: !1134)
!1138 = !DILocation(line: 198, column: 11, scope: !565, inlinedAt: !1134)
!1139 = !DILocation(line: 198, column: 9, scope: !551, inlinedAt: !1134)
!1140 = !DILocation(line: 203, column: 11, scope: !551, inlinedAt: !1134)
!1141 = !DILocation(line: 203, column: 9, scope: !551, inlinedAt: !1134)
!1142 = !DILocation(line: 204, column: 11, scope: !570, inlinedAt: !1134)
!1143 = !DILocation(line: 204, column: 9, scope: !551, inlinedAt: !1134)
!1144 = !DILocation(line: 209, column: 11, scope: !551, inlinedAt: !1134)
!1145 = !DILocation(line: 209, column: 9, scope: !551, inlinedAt: !1134)
!1146 = !DILocation(line: 210, column: 11, scope: !575, inlinedAt: !1134)
!1147 = !DILocation(line: 210, column: 9, scope: !551, inlinedAt: !1134)
!1148 = !DILocation(line: 215, column: 11, scope: !551, inlinedAt: !1134)
!1149 = !DILocation(line: 215, column: 9, scope: !551, inlinedAt: !1134)
!1150 = !DILocation(line: 216, column: 11, scope: !580, inlinedAt: !1134)
!1151 = !DILocation(line: 216, column: 9, scope: !551, inlinedAt: !1134)
!1152 = !DILocation(line: 222, column: 11, scope: !583, inlinedAt: !1134)
!1153 = !DILocation(line: 222, column: 9, scope: !551, inlinedAt: !1134)
!1154 = !DILocation(line: 223, column: 18, scope: !583, inlinedAt: !1134)
!1155 = !DILocation(line: 223, column: 9, scope: !583, inlinedAt: !1134)
!1156 = !DILocation(line: 224, column: 12, scope: !551, inlinedAt: !1134)
!1157 = !DILocation(line: 224, column: 5, scope: !551, inlinedAt: !1134)
!1158 = !DILocation(line: 285, column: 44, scope: !985, inlinedAt: !1123)
!1159 = !DILocation(line: 286, column: 24, scope: !985, inlinedAt: !1123)
!1160 = !DILocation(line: 287, column: 34, scope: !1031, inlinedAt: !1123)
!1161 = !DILocation(line: 287, column: 9, scope: !985, inlinedAt: !1123)
!1162 = !DILocation(line: 0, scope: !636)
!1163 = !DILocation(line: 141, column: 33, scope: !615)
!1164 = !DILocation(line: 0, scope: !985, inlinedAt: !1165)
!1165 = distinct !DILocation(line: 142, column: 23, scope: !615)
!1166 = !DILocation(line: 0, scope: !522, inlinedAt: !1167)
!1167 = distinct !DILocation(line: 283, column: 5, scope: !985, inlinedAt: !1165)
!1168 = !DILocation(line: 268, column: 16, scope: !530, inlinedAt: !1167)
!1169 = !{!1170}
!1170 = distinct !{!1170, !1171, !"add: argument 0"}
!1171 = distinct !{!1171, !"add"}
!1172 = !DILocation(line: 268, column: 18, scope: !530, inlinedAt: !1167)
!1173 = !DILocation(line: 268, column: 9, scope: !522, inlinedAt: !1167)
!1174 = !DILocation(line: 284, column: 28, scope: !985, inlinedAt: !1165)
!1175 = !DILocation(line: 284, column: 35, scope: !985, inlinedAt: !1165)
!1176 = !DILocation(line: 284, column: 21, scope: !985, inlinedAt: !1165)
!1177 = !DILocation(line: 0, scope: !551, inlinedAt: !1178)
!1178 = distinct !DILocation(line: 285, column: 46, scope: !985, inlinedAt: !1165)
!1179 = !DILocation(line: 186, column: 11, scope: !560, inlinedAt: !1178)
!1180 = !DILocation(line: 186, column: 9, scope: !551, inlinedAt: !1178)
!1181 = !DILocation(line: 197, column: 11, scope: !551, inlinedAt: !1178)
!1182 = !DILocation(line: 198, column: 11, scope: !565, inlinedAt: !1178)
!1183 = !DILocation(line: 198, column: 9, scope: !551, inlinedAt: !1178)
!1184 = !DILocation(line: 203, column: 11, scope: !551, inlinedAt: !1178)
!1185 = !DILocation(line: 203, column: 9, scope: !551, inlinedAt: !1178)
!1186 = !DILocation(line: 204, column: 11, scope: !570, inlinedAt: !1178)
!1187 = !DILocation(line: 204, column: 9, scope: !551, inlinedAt: !1178)
!1188 = !DILocation(line: 209, column: 11, scope: !551, inlinedAt: !1178)
!1189 = !DILocation(line: 209, column: 9, scope: !551, inlinedAt: !1178)
!1190 = !DILocation(line: 210, column: 11, scope: !575, inlinedAt: !1178)
!1191 = !DILocation(line: 210, column: 9, scope: !551, inlinedAt: !1178)
!1192 = !DILocation(line: 215, column: 11, scope: !551, inlinedAt: !1178)
!1193 = !DILocation(line: 215, column: 9, scope: !551, inlinedAt: !1178)
!1194 = !DILocation(line: 216, column: 11, scope: !580, inlinedAt: !1178)
!1195 = !DILocation(line: 216, column: 9, scope: !551, inlinedAt: !1178)
!1196 = !DILocation(line: 222, column: 11, scope: !583, inlinedAt: !1178)
!1197 = !DILocation(line: 222, column: 9, scope: !551, inlinedAt: !1178)
!1198 = !DILocation(line: 223, column: 18, scope: !583, inlinedAt: !1178)
!1199 = !DILocation(line: 223, column: 9, scope: !583, inlinedAt: !1178)
!1200 = !DILocation(line: 224, column: 12, scope: !551, inlinedAt: !1178)
!1201 = !DILocation(line: 224, column: 5, scope: !551, inlinedAt: !1178)
!1202 = !DILocation(line: 285, column: 44, scope: !985, inlinedAt: !1165)
!1203 = !DILocation(line: 286, column: 24, scope: !985, inlinedAt: !1165)
!1204 = !DILocation(line: 287, column: 34, scope: !1031, inlinedAt: !1165)
!1205 = !DILocation(line: 287, column: 9, scope: !985, inlinedAt: !1165)
!1206 = !DILocation(line: 142, column: 23, scope: !615)
!1207 = !DILocation(line: 143, column: 14, scope: !615)
!1208 = !DILocation(line: 144, column: 9, scope: !615)
!1209 = distinct !DISubprogram(name: "detection", scope: !3, file: !3, line: 148, type: !1210, scopeLine: 149, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !1214)
!1210 = !DISubroutineType(types: !1211)
!1211 = !{!32, !1212, !206, !21, !21}
!1212 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1213, size: 64)
!1213 = !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map", file: !3, line: 148, flags: DIFlagFwdDecl)
!1214 = !{!1215, !1216, !1217, !1218, !1219, !1220, !1221, !1222, !1223}
!1215 = !DILocalVariable(name: "map", arg: 1, scope: !1209, file: !3, line: 148, type: !1212)
!1216 = !DILocalVariable(name: "key", arg: 2, scope: !1209, file: !3, line: 148, type: !206)
!1217 = !DILocalVariable(name: "value", arg: 3, scope: !1209, file: !3, line: 148, type: !21)
!1218 = !DILocalVariable(name: "ctx", arg: 4, scope: !1209, file: !3, line: 148, type: !21)
!1219 = !DILocalVariable(name: "tmp", scope: !1209, file: !3, line: 150, type: !85)
!1220 = !DILocalVariable(name: "logger_value", scope: !1209, file: !3, line: 151, type: !58)
!1221 = !DILocalVariable(name: "diff", scope: !1209, file: !3, line: 159, type: !64)
!1222 = !DILocalVariable(name: "d", scope: !1209, file: !3, line: 160, type: !64)
!1223 = !DILocalVariable(name: "filter_key", scope: !1224, file: !3, line: 166, type: !247)
!1224 = distinct !DILexicalBlock(scope: !1225, file: !3, line: 164, column: 9)
!1225 = distinct !DILexicalBlock(scope: !1209, file: !3, line: 163, column: 13)
!1226 = !DILocation(line: 0, scope: !1209)
!1227 = !DILocation(line: 153, column: 27, scope: !1228)
!1228 = distinct !DILexicalBlock(scope: !1209, file: !3, line: 153, column: 13)
!1229 = !DILocation(line: 153, column: 35, scope: !1228)
!1230 = !DILocation(line: 153, column: 42, scope: !1228)
!1231 = !DILocation(line: 153, column: 13, scope: !1209)
!1232 = !DILocation(line: 154, column: 52, scope: !1233)
!1233 = distinct !DILexicalBlock(scope: !1228, file: !3, line: 153, column: 48)
!1234 = !DILocation(line: 154, column: 31, scope: !1233)
!1235 = !DILocation(line: 154, column: 36, scope: !1233)
!1236 = !DILocation(line: 155, column: 35, scope: !1233)
!1237 = !DILocation(line: 156, column: 17, scope: !1233)
!1238 = !DILocalVariable(name: "first", arg: 1, scope: !1239, file: !65, line: 301, type: !513)
!1239 = distinct !DISubprogram(name: "subtract", scope: !65, file: !65, line: 301, type: !511, scopeLine: 302, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !1240)
!1240 = !{!1238, !1241, !1242, !1243, !1244}
!1241 = !DILocalVariable(name: "second", arg: 2, scope: !1239, file: !65, line: 301, type: !513)
!1242 = !DILocalVariable(name: "sum", scope: !1239, file: !65, line: 304, type: !33)
!1243 = !DILocalVariable(name: "allowed_fixed_point_bits", scope: !1239, file: !65, line: 305, type: !28)
!1244 = !DILocalVariable(name: "result", scope: !1239, file: !65, line: 306, type: !64)
!1245 = !DILocation(line: 0, scope: !1239, inlinedAt: !1246)
!1246 = distinct !DILocation(line: 159, column: 35, scope: !1209)
!1247 = !DILocation(line: 0, scope: !522, inlinedAt: !1248)
!1248 = distinct !DILocation(line: 303, column: 5, scope: !1239, inlinedAt: !1246)
!1249 = !DILocation(line: 268, column: 16, scope: !530, inlinedAt: !1248)
!1250 = !{!1251}
!1251 = distinct !{!1251, !1252, !"subtract: argument 0"}
!1252 = distinct !{!1252, !"subtract"}
!1253 = !DILocation(line: 268, column: 28, scope: !530, inlinedAt: !1248)
!1254 = !DILocation(line: 268, column: 18, scope: !530, inlinedAt: !1248)
!1255 = !DILocation(line: 268, column: 9, scope: !522, inlinedAt: !1248)
!1256 = !DILocation(line: 270, column: 19, scope: !1257, inlinedAt: !1248)
!1257 = distinct !DILexicalBlock(scope: !530, file: !65, line: 269, column: 5)
!1258 = !DILocation(line: 273, column: 5, scope: !1257, inlinedAt: !1248)
!1259 = !DILocation(line: 274, column: 23, scope: !539, inlinedAt: !1248)
!1260 = !DILocation(line: 274, column: 14, scope: !530, inlinedAt: !1248)
!1261 = !DILocation(line: 276, column: 18, scope: !538, inlinedAt: !1248)
!1262 = !DILocation(line: 278, column: 5, scope: !538, inlinedAt: !1248)
!1263 = !DILocation(line: 176, column: 27, scope: !1264)
!1264 = distinct !DILexicalBlock(scope: !1209, file: !3, line: 176, column: 13)
!1265 = !DILocation(line: 176, column: 31, scope: !1264)
!1266 = !DILocation(line: 176, column: 13, scope: !1209)
!1267 = !DILocation(line: 178, column: 37, scope: !1268)
!1268 = distinct !DILexicalBlock(scope: !1264, file: !3, line: 177, column: 9)
!1269 = !DILocation(line: 178, column: 17, scope: !1268)
!1270 = !DILocation(line: 179, column: 17, scope: !1268)
!1271 = !DILocation(line: 182, column: 23, scope: !1209)
!1272 = !DILocation(line: 182, column: 28, scope: !1209)
!1273 = !DILocation(line: 183, column: 27, scope: !1209)
!1274 = !DILocation(line: 185, column: 9, scope: !1209)
!1275 = !DILocation(line: 186, column: 1, scope: !1209)
