# FIDe
FIDe is a fully in-kernel anomaly detection/mitigation framework based on eBPF. The framework enables high-speed traffic monitoring and anomaly detection in generic Linux machines with NICs supporting native XDP. Further details on this framework is available on our paper [Dynamic Fixed-point Values in eBPF: a Case for Fully In-kernel Anomaly Detection](https://dl.acm.org/doi/abs/10.1145/3674213.3674219). 

If you use any components of our framework, please consider citing our work.
>Osaki, Atsuya, Poisson, Manuel, Makino, Seiki, Shiiba, Ryusei, Fukuda, Kensuke, Okoshi, Tadashi, & Nakazawa, Jin. (2024, August). Dynamic Fixed-point Values in eBPF: a Case for Fully In-kernel Anomaly Detection. In Proceedings of the Asian Internet Engineering Conference 2024 (pp. 46-54).

## Components of this Repository
The below list is the main components of this repository.
1. fully_in-kernel directory
2. user+ebpf directory
3. fixed-point.h header file

The 2 directories contain 2 different versions of the anomaly detection/mitigation framework. 
fully_in-kernel directory composes the fully in-kernel version, and the user+ebpf directory composes the version that perform traffic analysis in the user space.

fixed-point.h file contains the arithmetic operations of the dynamic fixed-point values, which allows arithmetic operations of fractional numbers inside eBPF programs. Refer to our paper for more details. To use this library, place this "fixed-point.h" header file inside the directory of your project and reference it as a headerfile inside your eBPF program.

## To build the framework
The basic introduction of XDP is well composed by the people at XDP-Project, inside the [xdp-tutorial](https://github.com/xdp-project/xdp-tutorial) repository. Dependency of FIDe can also be fulfilled by following the introduction of xdp-tutorial, found [here](https://github.com/xdp-project/xdp-tutorial/blob/master/setup_dependencies.org).

When that is done, move to the directory of the framework (fully_in-kernel/ or user+ebpf/) and then inside main/ directory. Run `make` there, then the libraries and eBPF programs will be compiled. Use xdp-loader from xdp-tutorial to load the eBPF program to the kernel space.
