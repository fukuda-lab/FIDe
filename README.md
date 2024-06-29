# FIDe
FIDe is an fully in-kernel anomaly detection/mitigation framework based on eBPF.

fully_in-kernel directory composes the fully in-kernel version, and the user+ebpf directory composes the version that performs traffic analysis in the user space.

fixed-point.h file contains the arithmetic operations of the dynamic fixed-point values, that can be used inside eBPF programs.
