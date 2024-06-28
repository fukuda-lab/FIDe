# DomeX
DomeX is a fully in-kernel DDoS detection/mitigation framework that bases off of eBPF and XDP.

fully_in-kernel directory composes the fully in-kernel version, and the user+ebpf directory composes the version that performs traffic analysis in the user space.

fixed-point.h file contains the arithmetic operations of the dynamic fixed-point values, that can be used inside eBPF programs.
