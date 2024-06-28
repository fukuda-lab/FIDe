; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }
%struct.lpm_v4_key = type { i32, i32 }
%struct.logger_value = type { i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@logger = dso_local global %struct.bpf_map_def { i32 1, i32 4, i32 12, i32 100000, i32 0 }, section "maps", align 4, !dbg !0
@blacklist = dso_local global %struct.bpf_map_def { i32 11, i32 8, i32 4, i32 8000, i32 1 }, section "maps", align 4, !dbg !27
@data = dso_local global %struct.bpf_map_def { i32 2, i32 4, i32 8, i32 1, i32 0 }, section "maps", align 4, !dbg !37
@tx_port = dso_local global %struct.bpf_map_def { i32 14, i32 4, i32 4, i32 1, i32 0 }, section "maps", align 4, !dbg !39
@__const.xdp_filter_func.str = private unnamed_addr constant [29 x i8] c"not ethernet frame, dropped\0A\00", align 1
@__const.xdp_filter_func.str.1 = private unnamed_addr constant [9 x i8] c"dropped\0A\00", align 1
@__const.xdp_filter_func.error_log = private unnamed_addr constant [38 x i8] c"Error at reading data, the first one\0A\00", align 1
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !41
@llvm.compiler.used = appending global [6 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.bpf_map_def* @blacklist to i8*), i8* bitcast (%struct.bpf_map_def* @data to i8*), i8* bitcast (%struct.bpf_map_def* @logger to i8*), i8* bitcast (%struct.bpf_map_def* @tx_port to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_filter_func to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_filter_func(%struct.xdp_md* nocapture noundef readonly %0) #0 section "xdp_filter" !dbg !146 {
  %2 = alloca %struct.lpm_v4_key, align 4
  %3 = alloca [29 x i8], align 1
  %4 = alloca [9 x i8], align 1
  %5 = alloca i32, align 4
  %6 = alloca [38 x i8], align 1
  %7 = alloca %struct.logger_value, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !159, metadata !DIExpression()), !dbg !245
  %8 = bitcast %struct.lpm_v4_key* %2 to i8*, !dbg !246
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %8) #5, !dbg !246
  call void @llvm.dbg.declare(metadata %struct.lpm_v4_key* %2, metadata !197, metadata !DIExpression()), !dbg !247
  %9 = getelementptr inbounds %struct.lpm_v4_key, %struct.lpm_v4_key* %2, i64 0, i32 0, !dbg !248
  store i32 32, i32* %9, align 4, !dbg !249, !tbaa !250
  call void @llvm.dbg.value(metadata i32 0, metadata !202, metadata !DIExpression()), !dbg !245
  %10 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !255
  %11 = load i32, i32* %10, align 4, !dbg !255, !tbaa !256
  %12 = zext i32 %11 to i64, !dbg !258
  %13 = inttoptr i64 %12 to i8*, !dbg !259
  call void @llvm.dbg.value(metadata i8* %13, metadata !160, metadata !DIExpression()), !dbg !245
  %14 = add nuw nsw i64 %12, 14, !dbg !260
  %15 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !261
  %16 = load i32, i32* %15, align 4, !dbg !261, !tbaa !262
  %17 = zext i32 %16 to i64, !dbg !263
  %18 = icmp ugt i64 %14, %17, !dbg !264
  br i1 %18, label %19, label %22, !dbg !265

19:                                               ; preds = %1
  %20 = getelementptr inbounds [29 x i8], [29 x i8]* %3, i64 0, i64 0, !dbg !266
  call void @llvm.lifetime.start.p0i8(i64 29, i8* nonnull %20) #5, !dbg !266
  call void @llvm.dbg.declare(metadata [29 x i8]* %3, metadata !206, metadata !DIExpression()), !dbg !267
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(29) %20, i8* noundef nonnull align 1 dereferenceable(29) getelementptr inbounds ([29 x i8], [29 x i8]* @__const.xdp_filter_func.str, i64 0, i64 0), i64 29, i1 false), !dbg !267
  %21 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %20, i32 noundef 29) #5, !dbg !268
  call void @llvm.lifetime.end.p0i8(i64 29, i8* nonnull %20) #5, !dbg !269
  br label %65

22:                                               ; preds = %1
  %23 = inttoptr i64 %12 to %struct.ethhdr*, !dbg !259
  call void @llvm.dbg.value(metadata %struct.ethhdr* %23, metadata !160, metadata !DIExpression()), !dbg !245
  %24 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %23, i64 0, i32 2, !dbg !270
  %25 = load i16, i16* %24, align 1, !dbg !270, !tbaa !271
  %26 = icmp eq i16 %25, 8, !dbg !274
  br i1 %26, label %27, label %63, !dbg !275

27:                                               ; preds = %22
  call void @llvm.dbg.value(metadata i8* %13, metadata !174, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !245
  %28 = add nuw nsw i64 %12, 34, !dbg !276
  %29 = icmp ugt i64 %28, %17, !dbg !277
  br i1 %29, label %30, label %33, !dbg !278

30:                                               ; preds = %27
  %31 = getelementptr inbounds [9 x i8], [9 x i8]* %4, i64 0, i64 0, !dbg !279
  call void @llvm.lifetime.start.p0i8(i64 9, i8* nonnull %31) #5, !dbg !279
  call void @llvm.dbg.declare(metadata [9 x i8]* %4, metadata !212, metadata !DIExpression()), !dbg !280
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(9) %31, i8* noundef nonnull align 1 dereferenceable(9) getelementptr inbounds ([9 x i8], [9 x i8]* @__const.xdp_filter_func.str.1, i64 0, i64 0), i64 9, i1 false), !dbg !280
  %32 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %31, i32 noundef 9) #5, !dbg !281
  call void @llvm.lifetime.end.p0i8(i64 9, i8* nonnull %31) #5, !dbg !282
  br label %65

33:                                               ; preds = %27
  call void @llvm.dbg.value(metadata i8* %13, metadata !174, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !245
  %34 = getelementptr i8, i8* %13, i64 26, !dbg !283
  %35 = bitcast i8* %34 to i32*, !dbg !283
  %36 = load i32, i32* %35, align 4, !dbg !283, !tbaa !284
  %37 = getelementptr inbounds %struct.lpm_v4_key, %struct.lpm_v4_key* %2, i64 0, i32 1, !dbg !286
  store i32 %36, i32* %37, align 4, !dbg !287, !tbaa !288
  %38 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @blacklist to i8*), i8* noundef nonnull %8) #5, !dbg !289
  call void @llvm.dbg.value(metadata i8* %38, metadata !220, metadata !DIExpression()), !dbg !290
  %39 = icmp eq i8* %38, null, !dbg !291
  call void @llvm.dbg.value(metadata i1 %39, metadata !202, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !245
  %40 = bitcast i32* %5 to i8*, !dbg !293
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %40) #5, !dbg !293
  call void @llvm.dbg.value(metadata i32 0, metadata !222, metadata !DIExpression()), !dbg !290
  store i32 0, i32* %5, align 4, !dbg !294, !tbaa !295
  call void @llvm.dbg.value(metadata i32* %5, metadata !222, metadata !DIExpression(DW_OP_deref)), !dbg !290
  %41 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @data to i8*), i8* noundef nonnull %40) #5, !dbg !296
  call void @llvm.dbg.value(metadata i8* %41, metadata !223, metadata !DIExpression()), !dbg !290
  %42 = icmp eq i8* %41, null, !dbg !297
  br i1 %42, label %59, label %43, !dbg !298

43:                                               ; preds = %33
  call void @llvm.dbg.value(metadata i8* %41, metadata !223, metadata !DIExpression()), !dbg !290
  %44 = getelementptr inbounds i8, i8* %41, i64 4, !dbg !299
  %45 = bitcast i8* %44 to i32*, !dbg !299
  %46 = atomicrmw add i32* %45, i32 1 seq_cst, align 4, !dbg !299
  %47 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @logger to i8*), i8* noundef %34) #5, !dbg !301
  call void @llvm.dbg.value(metadata i8* %47, metadata !235, metadata !DIExpression()), !dbg !290
  %48 = icmp eq i8* %47, null, !dbg !302
  br i1 %48, label %53, label %49, !dbg !303

49:                                               ; preds = %43
  call void @llvm.dbg.value(metadata i8* %47, metadata !235, metadata !DIExpression()), !dbg !290
  %50 = getelementptr inbounds i8, i8* %47, i64 4, !dbg !304
  %51 = bitcast i8* %50 to i32*, !dbg !304
  %52 = atomicrmw add i32* %51, i32 1 seq_cst, align 4, !dbg !304
  br label %62, !dbg !306

53:                                               ; preds = %43
  %54 = bitcast %struct.logger_value* %7 to i8*, !dbg !307
  call void @llvm.lifetime.start.p0i8(i64 12, i8* nonnull %54) #5, !dbg !307
  call void @llvm.dbg.declare(metadata %struct.logger_value* %7, metadata !242, metadata !DIExpression()), !dbg !308
  %55 = getelementptr inbounds %struct.logger_value, %struct.logger_value* %7, i64 0, i32 0, !dbg !309
  store i32 0, i32* %55, align 4, !dbg !310, !tbaa !311
  %56 = getelementptr inbounds %struct.logger_value, %struct.logger_value* %7, i64 0, i32 1, !dbg !313
  store i32 1, i32* %56, align 4, !dbg !314, !tbaa !315
  %57 = getelementptr inbounds %struct.logger_value, %struct.logger_value* %7, i64 0, i32 2, !dbg !316
  store i32 0, i32* %57, align 4, !dbg !317, !tbaa !318
  %58 = call i32 inttoptr (i64 2 to i32 (i8*, i8*, i8*, i64)*)(i8* noundef bitcast (%struct.bpf_map_def* @logger to i8*), i8* noundef %34, i8* noundef nonnull %54, i64 noundef 0) #5, !dbg !319
  call void @llvm.lifetime.end.p0i8(i64 12, i8* nonnull %54) #5, !dbg !320
  br label %62

59:                                               ; preds = %33
  %60 = getelementptr inbounds [38 x i8], [38 x i8]* %6, i64 0, i64 0, !dbg !321
  call void @llvm.lifetime.start.p0i8(i64 38, i8* nonnull %60) #5, !dbg !321
  call void @llvm.dbg.declare(metadata [38 x i8]* %6, metadata !229, metadata !DIExpression()), !dbg !322
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(38) %60, i8* noundef nonnull align 1 dereferenceable(38) getelementptr inbounds ([38 x i8], [38 x i8]* @__const.xdp_filter_func.error_log, i64 0, i64 0), i64 38, i1 false), !dbg !322
  %61 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %60, i32 noundef 38) #5, !dbg !323
  call void @llvm.lifetime.end.p0i8(i64 38, i8* nonnull %60) #5, !dbg !324
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %40) #5, !dbg !325
  br label %65

62:                                               ; preds = %49, %53
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %40) #5, !dbg !325
  call void @llvm.dbg.value(metadata i1 %39, metadata !202, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !245
  br i1 %39, label %63, label %65, !dbg !326

63:                                               ; preds = %22, %62
  %64 = call i32 inttoptr (i64 51 to i32 (i8*, i32, i64)*)(i8* noundef bitcast (%struct.bpf_map_def* @tx_port to i8*), i32 noundef 0, i64 noundef 0) #5, !dbg !327
  br label %65, !dbg !328

65:                                               ; preds = %59, %62, %63, %30, %19
  %66 = phi i32 [ 0, %19 ], [ 0, %30 ], [ %64, %63 ], [ 0, %59 ], [ 1, %62 ]
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %8) #5, !dbg !329
  ret i32 %66, !dbg !329
}

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #4

attributes #0 = { nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #3 = { argmemonly mustprogress nofree nounwind willreturn }
attributes #4 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!141, !142, !143, !144}
!llvm.ident = !{!145}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "logger", scope: !2, file: !3, line: 40, type: !29, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !20, globals: !26, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/nii2/ebpf_pfilt/domex", checksumkind: CSK_MD5, checksum: "1bb12d3862e00664787cda87c5afeecd")
!4 = !{!5, !14}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 5433, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "", checksumkind: CSK_MD5, checksum: "03bc76f18af37c3e4503ca6e7a7f78a9")
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
!20 = !{!21, !22, !23}
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!22 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !24, line: 24, baseType: !25)
!24 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!25 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!26 = !{!0, !27, !37, !39, !41, !47, !111, !113, !122, !129, !136}
!27 = !DIGlobalVariableExpression(var: !28, expr: !DIExpression())
!28 = distinct !DIGlobalVariable(name: "blacklist", scope: !2, file: !3, line: 51, type: !29, isLocal: false, isDefinition: true)
!29 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !30, line: 33, size: 160, elements: !31)
!30 = !DIFile(filename: "./libbpf/src/bpf_helpers.h", directory: "/home/nii2/ebpf_pfilt/domex", checksumkind: CSK_MD5, checksum: "9e37b5f46a8fb7f5ed35ab69309bf15d")
!31 = !{!32, !33, !34, !35, !36}
!32 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !29, file: !30, line: 34, baseType: !7, size: 32)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !29, file: !30, line: 35, baseType: !7, size: 32, offset: 32)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !29, file: !30, line: 36, baseType: !7, size: 32, offset: 64)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !29, file: !30, line: 37, baseType: !7, size: 32, offset: 96)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !29, file: !30, line: 38, baseType: !7, size: 32, offset: 128)
!37 = !DIGlobalVariableExpression(var: !38, expr: !DIExpression())
!38 = distinct !DIGlobalVariable(name: "data", scope: !2, file: !3, line: 59, type: !29, isLocal: false, isDefinition: true)
!39 = !DIGlobalVariableExpression(var: !40, expr: !DIExpression())
!40 = distinct !DIGlobalVariable(name: "tx_port", scope: !2, file: !3, line: 66, type: !29, isLocal: false, isDefinition: true)
!41 = !DIGlobalVariableExpression(var: !42, expr: !DIExpression())
!42 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 163, type: !43, isLocal: false, isDefinition: true)
!43 = !DICompositeType(tag: DW_TAG_array_type, baseType: !44, size: 32, elements: !45)
!44 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!45 = !{!46}
!46 = !DISubrange(count: 4)
!47 = !DIGlobalVariableExpression(var: !48, expr: !DIExpression())
!48 = distinct !DIGlobalVariable(name: "stdin", scope: !2, file: !49, line: 143, type: !50, isLocal: false, isDefinition: false)
!49 = !DIFile(filename: "/usr/include/stdio.h", directory: "", checksumkind: CSK_MD5, checksum: "f31eefcc3f15835fc5a4023a625cf609")
!50 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !51, size: 64)
!51 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !52, line: 7, baseType: !53)
!52 = !DIFile(filename: "/usr/include/bits/types/FILE.h", directory: "", checksumkind: CSK_MD5, checksum: "571f9fb6223c42439075fdde11a0de5d")
!53 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !54, line: 49, size: 1728, elements: !55)
!54 = !DIFile(filename: "/usr/include/bits/types/struct_FILE.h", directory: "", checksumkind: CSK_MD5, checksum: "1bad07471b7974df4ecc1d1c2ca207e6")
!55 = !{!56, !58, !60, !61, !62, !63, !64, !65, !66, !67, !68, !69, !70, !73, !75, !76, !77, !80, !81, !83, !87, !90, !94, !97, !100, !101, !102, !106, !107}
!56 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !53, file: !54, line: 51, baseType: !57, size: 32)
!57 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !53, file: !54, line: 54, baseType: !59, size: 64, offset: 64)
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !44, size: 64)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !53, file: !54, line: 55, baseType: !59, size: 64, offset: 128)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !53, file: !54, line: 56, baseType: !59, size: 64, offset: 192)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !53, file: !54, line: 57, baseType: !59, size: 64, offset: 256)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !53, file: !54, line: 58, baseType: !59, size: 64, offset: 320)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !53, file: !54, line: 59, baseType: !59, size: 64, offset: 384)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !53, file: !54, line: 60, baseType: !59, size: 64, offset: 448)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !53, file: !54, line: 61, baseType: !59, size: 64, offset: 512)
!67 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !53, file: !54, line: 64, baseType: !59, size: 64, offset: 576)
!68 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !53, file: !54, line: 65, baseType: !59, size: 64, offset: 640)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !53, file: !54, line: 66, baseType: !59, size: 64, offset: 704)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !53, file: !54, line: 68, baseType: !71, size: 64, offset: 768)
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !72, size: 64)
!72 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !54, line: 36, flags: DIFlagFwdDecl)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !53, file: !54, line: 70, baseType: !74, size: 64, offset: 832)
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !53, file: !54, line: 72, baseType: !57, size: 32, offset: 896)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !53, file: !54, line: 73, baseType: !57, size: 32, offset: 928)
!77 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !53, file: !54, line: 74, baseType: !78, size: 64, offset: 960)
!78 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !79, line: 152, baseType: !22)
!79 = !DIFile(filename: "/usr/include/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "d108b5f93a74c50510d7d9bc0ab36df9")
!80 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !53, file: !54, line: 77, baseType: !25, size: 16, offset: 1024)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !53, file: !54, line: 78, baseType: !82, size: 8, offset: 1040)
!82 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !53, file: !54, line: 79, baseType: !84, size: 8, offset: 1048)
!84 = !DICompositeType(tag: DW_TAG_array_type, baseType: !44, size: 8, elements: !85)
!85 = !{!86}
!86 = !DISubrange(count: 1)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !53, file: !54, line: 81, baseType: !88, size: 64, offset: 1088)
!88 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !89, size: 64)
!89 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !54, line: 43, baseType: null)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !53, file: !54, line: 89, baseType: !91, size: 64, offset: 1152)
!91 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !79, line: 153, baseType: !92)
!92 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !79, line: 47, baseType: !93)
!93 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !53, file: !54, line: 91, baseType: !95, size: 64, offset: 1216)
!95 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !96, size: 64)
!96 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !54, line: 37, flags: DIFlagFwdDecl)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !53, file: !54, line: 92, baseType: !98, size: 64, offset: 1280)
!98 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !99, size: 64)
!99 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !54, line: 38, flags: DIFlagFwdDecl)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !53, file: !54, line: 93, baseType: !74, size: 64, offset: 1344)
!101 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !53, file: !54, line: 94, baseType: !21, size: 64, offset: 1408)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "__pad5", scope: !53, file: !54, line: 95, baseType: !103, size: 64, offset: 1472)
!103 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !104, line: 46, baseType: !105)
!104 = !DIFile(filename: "/usr/lib/llvm-14/lib/clang/14.0.0/include/stddef.h", directory: "", checksumkind: CSK_MD5, checksum: "2499dd2361b915724b073282bea3a7bc")
!105 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !53, file: !54, line: 96, baseType: !57, size: 32, offset: 1536)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !53, file: !54, line: 98, baseType: !108, size: 160, offset: 1568)
!108 = !DICompositeType(tag: DW_TAG_array_type, baseType: !44, size: 160, elements: !109)
!109 = !{!110}
!110 = !DISubrange(count: 20)
!111 = !DIGlobalVariableExpression(var: !112, expr: !DIExpression())
!112 = distinct !DIGlobalVariable(name: "stdout", scope: !2, file: !49, line: 144, type: !50, isLocal: false, isDefinition: false)
!113 = !DIGlobalVariableExpression(var: !114, expr: !DIExpression())
!114 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !115, line: 152, type: !116, isLocal: true, isDefinition: true)
!115 = !DIFile(filename: "./libbpf/src/bpf_helper_defs.h", directory: "/home/nii2/ebpf_pfilt/domex", checksumkind: CSK_MD5, checksum: "2601bcf9d7985cb46bfbd904b60f5aaf")
!116 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !117, size: 64)
!117 = !DISubroutineType(types: !118)
!118 = !{!57, !119, !121, null}
!119 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !120, size: 64)
!120 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !44)
!121 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !24, line: 27, baseType: !7)
!122 = !DIGlobalVariableExpression(var: !123, expr: !DIExpression())
!123 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !115, line: 33, type: !124, isLocal: true, isDefinition: true)
!124 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !125, size: 64)
!125 = !DISubroutineType(types: !126)
!126 = !{!21, !21, !127}
!127 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !128, size: 64)
!128 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!129 = !DIGlobalVariableExpression(var: !130, expr: !DIExpression())
!130 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !115, line: 55, type: !131, isLocal: true, isDefinition: true)
!131 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !132, size: 64)
!132 = !DISubroutineType(types: !133)
!133 = !{!57, !21, !127, !127, !134}
!134 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !24, line: 31, baseType: !135)
!135 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!136 = !DIGlobalVariableExpression(var: !137, expr: !DIExpression())
!137 = distinct !DIGlobalVariable(name: "bpf_redirect_map", scope: !2, file: !115, line: 1254, type: !138, isLocal: true, isDefinition: true)
!138 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !139, size: 64)
!139 = !DISubroutineType(types: !140)
!140 = !{!57, !21, !121, !134}
!141 = !{i32 7, !"Dwarf Version", i32 5}
!142 = !{i32 2, !"Debug Info Version", i32 3}
!143 = !{i32 1, !"wchar_size", i32 4}
!144 = !{i32 7, !"frame-pointer", i32 2}
!145 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!146 = distinct !DISubprogram(name: "xdp_filter_func", scope: !3, file: !3, line: 75, type: !147, scopeLine: 76, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !158)
!147 = !DISubroutineType(types: !148)
!148 = !{!57, !149}
!149 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !150, size: 64)
!150 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 5444, size: 192, elements: !151)
!151 = !{!152, !153, !154, !155, !156, !157}
!152 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !150, file: !6, line: 5445, baseType: !121, size: 32)
!153 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !150, file: !6, line: 5446, baseType: !121, size: 32, offset: 32)
!154 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !150, file: !6, line: 5447, baseType: !121, size: 32, offset: 64)
!155 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !150, file: !6, line: 5449, baseType: !121, size: 32, offset: 96)
!156 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !150, file: !6, line: 5450, baseType: !121, size: 32, offset: 128)
!157 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !150, file: !6, line: 5452, baseType: !121, size: 32, offset: 160)
!158 = !{!159, !160, !174, !197, !202, !206, !212, !220, !222, !223, !229, !235, !242}
!159 = !DILocalVariable(name: "ctx", arg: 1, scope: !146, file: !3, line: 75, type: !149)
!160 = !DILocalVariable(name: "eth", scope: !146, file: !3, line: 80, type: !161)
!161 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !162, size: 64)
!162 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !163, line: 168, size: 112, elements: !164)
!163 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "", checksumkind: CSK_MD5, checksum: "ab0320da726e75d904811ce344979934")
!164 = !{!165, !170, !171}
!165 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !162, file: !163, line: 169, baseType: !166, size: 48)
!166 = !DICompositeType(tag: DW_TAG_array_type, baseType: !167, size: 48, elements: !168)
!167 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!168 = !{!169}
!169 = !DISubrange(count: 6)
!170 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !162, file: !163, line: 170, baseType: !166, size: 48, offset: 48)
!171 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !162, file: !163, line: 171, baseType: !172, size: 16, offset: 96)
!172 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !173, line: 25, baseType: !23)
!173 = !DIFile(filename: "/usr/include/linux/types.h", directory: "", checksumkind: CSK_MD5, checksum: "52ec79a38e49ac7d1dc9e146ba88a7b1")
!174 = !DILocalVariable(name: "ip", scope: !146, file: !3, line: 81, type: !175)
!175 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !176, size: 64)
!176 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !177, line: 44, size: 160, elements: !178)
!177 = !DIFile(filename: "/usr/include/netinet/ip.h", directory: "", checksumkind: CSK_MD5, checksum: "777a3c26c651c3cea644451d8391a76c")
!178 = !{!179, !180, !181, !185, !188, !189, !190, !191, !192, !193, !196}
!179 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !176, file: !177, line: 47, baseType: !7, size: 4, flags: DIFlagBitField, extraData: i64 0)
!180 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !176, file: !177, line: 48, baseType: !7, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!181 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !176, file: !177, line: 55, baseType: !182, size: 8, offset: 8)
!182 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !183, line: 24, baseType: !184)
!183 = !DIFile(filename: "/usr/include/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "2bf2ae53c58c01b1a1b9383b5195125c")
!184 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !79, line: 38, baseType: !167)
!185 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !176, file: !177, line: 56, baseType: !186, size: 16, offset: 16)
!186 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !183, line: 25, baseType: !187)
!187 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !79, line: 40, baseType: !25)
!188 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !176, file: !177, line: 57, baseType: !186, size: 16, offset: 32)
!189 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !176, file: !177, line: 58, baseType: !186, size: 16, offset: 48)
!190 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !176, file: !177, line: 59, baseType: !182, size: 8, offset: 64)
!191 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !176, file: !177, line: 60, baseType: !182, size: 8, offset: 72)
!192 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !176, file: !177, line: 61, baseType: !186, size: 16, offset: 80)
!193 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !176, file: !177, line: 62, baseType: !194, size: 32, offset: 96)
!194 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !183, line: 26, baseType: !195)
!195 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !79, line: 42, baseType: !7)
!196 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !176, file: !177, line: 63, baseType: !194, size: 32, offset: 128)
!197 = !DILocalVariable(name: "key", scope: !146, file: !3, line: 82, type: !198)
!198 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "lpm_v4_key", file: !3, line: 19, size: 64, elements: !199)
!199 = !{!200, !201}
!200 = !DIDerivedType(tag: DW_TAG_member, name: "prefixlen", scope: !198, file: !3, line: 21, baseType: !121, size: 32)
!201 = !DIDerivedType(tag: DW_TAG_member, name: "address", scope: !198, file: !3, line: 22, baseType: !121, size: 32, offset: 32)
!202 = !DILocalVariable(name: "drop_flag", scope: !146, file: !3, line: 84, type: !203)
!203 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !204, line: 26, baseType: !205)
!204 = !DIFile(filename: "/usr/include/bits/stdint-intn.h", directory: "", checksumkind: CSK_MD5, checksum: "55bcbdc3159515ebd91d351a70d505f4")
!205 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !79, line: 41, baseType: !57)
!206 = !DILocalVariable(name: "str", scope: !207, file: !3, line: 91, type: !209)
!207 = distinct !DILexicalBlock(scope: !208, file: !3, line: 90, column: 9)
!208 = distinct !DILexicalBlock(scope: !146, file: !3, line: 89, column: 13)
!209 = !DICompositeType(tag: DW_TAG_array_type, baseType: !44, size: 232, elements: !210)
!210 = !{!211}
!211 = !DISubrange(count: 29)
!212 = !DILocalVariable(name: "str", scope: !213, file: !3, line: 104, type: !217)
!213 = distinct !DILexicalBlock(scope: !214, file: !3, line: 103, column: 17)
!214 = distinct !DILexicalBlock(scope: !215, file: !3, line: 102, column: 21)
!215 = distinct !DILexicalBlock(scope: !216, file: !3, line: 98, column: 9)
!216 = distinct !DILexicalBlock(scope: !146, file: !3, line: 97, column: 13)
!217 = !DICompositeType(tag: DW_TAG_array_type, baseType: !44, size: 72, elements: !218)
!218 = !{!219}
!219 = !DISubrange(count: 9)
!220 = !DILocalVariable(name: "rule", scope: !215, file: !3, line: 111, type: !221)
!221 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !121, size: 64)
!222 = !DILocalVariable(name: "key", scope: !215, file: !3, line: 124, type: !57)
!223 = !DILocalVariable(name: "tmp", scope: !215, file: !3, line: 125, type: !224)
!224 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !225, size: 64)
!225 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "data_value", file: !3, line: 32, size: 64, elements: !226)
!226 = !{!227, !228}
!227 = !DIDerivedType(tag: DW_TAG_member, name: "prev_interval_pkt", scope: !225, file: !3, line: 34, baseType: !203, size: 32)
!228 = !DIDerivedType(tag: DW_TAG_member, name: "cur_interval_pkt", scope: !225, file: !3, line: 35, baseType: !203, size: 32, offset: 32)
!229 = !DILocalVariable(name: "error_log", scope: !230, file: !3, line: 134, type: !232)
!230 = distinct !DILexicalBlock(scope: !231, file: !3, line: 133, column: 17)
!231 = distinct !DILexicalBlock(scope: !215, file: !3, line: 126, column: 21)
!232 = !DICompositeType(tag: DW_TAG_array_type, baseType: !44, size: 304, elements: !233)
!233 = !{!234}
!234 = !DISubrange(count: 38)
!235 = !DILocalVariable(name: "value", scope: !215, file: !3, line: 140, type: !236)
!236 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !237, size: 64)
!237 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "logger_value", file: !3, line: 25, size: 96, elements: !238)
!238 = !{!239, !240, !241}
!239 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !237, file: !3, line: 27, baseType: !203, size: 32)
!240 = !DIDerivedType(tag: DW_TAG_member, name: "cur", scope: !237, file: !3, line: 28, baseType: !203, size: 32, offset: 32)
!241 = !DIDerivedType(tag: DW_TAG_member, name: "entropy", scope: !237, file: !3, line: 29, baseType: !203, size: 32, offset: 64)
!242 = !DILocalVariable(name: "new_value", scope: !243, file: !3, line: 149, type: !237)
!243 = distinct !DILexicalBlock(scope: !244, file: !3, line: 148, column: 17)
!244 = distinct !DILexicalBlock(scope: !215, file: !3, line: 141, column: 21)
!245 = !DILocation(line: 0, scope: !146)
!246 = !DILocation(line: 82, column: 9, scope: !146)
!247 = !DILocation(line: 82, column: 27, scope: !146)
!248 = !DILocation(line: 83, column: 13, scope: !146)
!249 = !DILocation(line: 83, column: 23, scope: !146)
!250 = !{!251, !252, i64 0}
!251 = !{!"lpm_v4_key", !252, i64 0, !252, i64 4}
!252 = !{!"int", !253, i64 0}
!253 = !{!"omnipotent char", !254, i64 0}
!254 = !{!"Simple C/C++ TBAA"}
!255 = !DILocation(line: 87, column: 34, scope: !146)
!256 = !{!257, !252, i64 0}
!257 = !{!"xdp_md", !252, i64 0, !252, i64 4, !252, i64 8, !252, i64 12, !252, i64 16, !252, i64 20}
!258 = !DILocation(line: 87, column: 23, scope: !146)
!259 = !DILocation(line: 87, column: 15, scope: !146)
!260 = !DILocation(line: 89, column: 23, scope: !208)
!261 = !DILocation(line: 89, column: 45, scope: !208)
!262 = !{!257, !252, i64 4}
!263 = !DILocation(line: 89, column: 40, scope: !208)
!264 = !DILocation(line: 89, column: 38, scope: !208)
!265 = !DILocation(line: 89, column: 13, scope: !146)
!266 = !DILocation(line: 91, column: 17, scope: !207)
!267 = !DILocation(line: 91, column: 22, scope: !207)
!268 = !DILocation(line: 92, column: 17, scope: !207)
!269 = !DILocation(line: 94, column: 9, scope: !208)
!270 = !DILocation(line: 97, column: 18, scope: !216)
!271 = !{!272, !273, i64 12}
!272 = !{!"ethhdr", !253, i64 0, !253, i64 6, !273, i64 12}
!273 = !{!"short", !253, i64 0}
!274 = !DILocation(line: 97, column: 26, scope: !216)
!275 = !DILocation(line: 97, column: 13, scope: !146)
!276 = !DILocation(line: 102, column: 46, scope: !214)
!277 = !DILocation(line: 102, column: 60, scope: !214)
!278 = !DILocation(line: 102, column: 21, scope: !215)
!279 = !DILocation(line: 104, column: 4, scope: !213)
!280 = !DILocation(line: 104, column: 9, scope: !213)
!281 = !DILocation(line: 105, column: 4, scope: !213)
!282 = !DILocation(line: 107, column: 17, scope: !214)
!283 = !DILocation(line: 109, column: 35, scope: !215)
!284 = !{!285, !252, i64 12}
!285 = !{!"iphdr", !252, i64 0, !252, i64 0, !253, i64 1, !273, i64 2, !273, i64 4, !273, i64 6, !253, i64 8, !253, i64 9, !273, i64 10, !252, i64 12, !252, i64 16}
!286 = !DILocation(line: 109, column: 21, scope: !215)
!287 = !DILocation(line: 109, column: 29, scope: !215)
!288 = !{!251, !252, i64 4}
!289 = !DILocation(line: 111, column: 31, scope: !215)
!290 = !DILocation(line: 0, scope: !215)
!291 = !DILocation(line: 112, column: 21, scope: !292)
!292 = distinct !DILexicalBlock(scope: !215, file: !3, line: 112, column: 21)
!293 = !DILocation(line: 124, column: 17, scope: !215)
!294 = !DILocation(line: 124, column: 21, scope: !215)
!295 = !{!252, !252, i64 0}
!296 = !DILocation(line: 125, column: 42, scope: !215)
!297 = !DILocation(line: 126, column: 21, scope: !231)
!298 = !DILocation(line: 126, column: 21, scope: !215)
!299 = !DILocation(line: 129, column: 25, scope: !300)
!300 = distinct !DILexicalBlock(scope: !231, file: !3, line: 127, column: 17)
!301 = !DILocation(line: 140, column: 46, scope: !215)
!302 = !DILocation(line: 141, column: 21, scope: !244)
!303 = !DILocation(line: 141, column: 21, scope: !215)
!304 = !DILocation(line: 144, column: 25, scope: !305)
!305 = distinct !DILexicalBlock(scope: !244, file: !3, line: 142, column: 17)
!306 = !DILocation(line: 146, column: 17, scope: !305)
!307 = !DILocation(line: 149, column: 25, scope: !243)
!308 = !DILocation(line: 149, column: 45, scope: !243)
!309 = !DILocation(line: 150, column: 35, scope: !243)
!310 = !DILocation(line: 150, column: 40, scope: !243)
!311 = !{!312, !252, i64 0}
!312 = !{!"logger_value", !252, i64 0, !252, i64 4, !252, i64 8}
!313 = !DILocation(line: 151, column: 35, scope: !243)
!314 = !DILocation(line: 151, column: 39, scope: !243)
!315 = !{!312, !252, i64 4}
!316 = !DILocation(line: 152, column: 35, scope: !243)
!317 = !DILocation(line: 152, column: 43, scope: !243)
!318 = !{!312, !252, i64 8}
!319 = !DILocation(line: 153, column: 25, scope: !243)
!320 = !DILocation(line: 154, column: 17, scope: !244)
!321 = !DILocation(line: 134, column: 25, scope: !230)
!322 = !DILocation(line: 134, column: 30, scope: !230)
!323 = !DILocation(line: 135, column: 25, scope: !230)
!324 = !DILocation(line: 137, column: 17, scope: !231)
!325 = !DILocation(line: 155, column: 1, scope: !216)
!326 = !DILocation(line: 156, column: 13, scope: !146)
!327 = !DILocation(line: 160, column: 9, scope: !146)
!328 = !DILocation(line: 160, column: 2, scope: !146)
!329 = !DILocation(line: 161, column: 1, scope: !146)
