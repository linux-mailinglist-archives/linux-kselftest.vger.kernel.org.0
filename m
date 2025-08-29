Return-Path: <linux-kselftest+bounces-40322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F82B3C140
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 18:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A89B87BF336
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E63335BB6;
	Fri, 29 Aug 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YnNkMfKF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E27334712;
	Fri, 29 Aug 2025 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486372; cv=none; b=qP5M/cQ1683fntrLBE9jNpOridQGg6Dlx/xQXUQpswnEf5uu6szB+80LBsPLPQq/06P23FyTBpb31mpZv9yARvcl17DhI08ei7Io44x90HOTL/7Ue3hS6sTK4u74ZYXXbygcAv2y9tUzK9y0Lri40wuCXFEQKNA8+SVCh8a5Ieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486372; c=relaxed/simple;
	bh=YgWTc9RaRISYPKcUGGhk5+COXT2/F7WsMRbU5T5/LfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aG9tbHi+RB+MJGALMYs/UBbxZfCBeUsOGOVrqG+EQPBFEgEYiutP/8hb73nMMv2J9Walg+U0BaGZQmZAi4lD2nTge7TKoftl1S/RWQp6qKdWHEZnAwbNCZwHmGTRsWRmCY8y6FN9Msf6bviJEOwwSeoYPXXCiJ1No6yHpw1IxUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YnNkMfKF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TG5UT0012769;
	Fri, 29 Aug 2025 16:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sog56zDGLDmOUB1u4
	YLxO3l9gHEU+E7YRqDDNZnW0mc=; b=YnNkMfKFNmvPDdUBk5YIXSZLR1Qwq9AfN
	zHRMnzdk2fnnXGPscPV2/hJn2lVlhQbwP0pGWaG7WWw5bfOKxOyce0XaCXdOJbWR
	1kMQo6JkSH6xORzkM85WsX1aj5L0/NmMPGwIJkptlgFyzLD/+sCGMOkj6bTlSWbj
	vtps+bWIEGpQ2AOx1tniEBgaRZamKd5F/jDK5VsFfe3bhCABXW2rU/ejmW9DAzIY
	hvzssAWdubq7yzdRroSc7JvwtKk0Y2CRIgDdwEULYncqzcP0o32jnFV2KNMtEcx/
	FKZ0McRqNSkP9/RUeK9+0J98DeWnubRsKBhoulhdFeK7yvTiDgqJQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5aw0qj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 16:52:14 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57TGmj8K028213;
	Fri, 29 Aug 2025 16:52:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5aw0qhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 16:52:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57TGLoO1029982;
	Fri, 29 Aug 2025 16:52:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qsfn2m1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 16:52:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57TGq8kQ39584250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 16:52:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E01432004D;
	Fri, 29 Aug 2025 16:52:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BC5120067;
	Fri, 29 Aug 2025 16:51:56 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.115.92])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Aug 2025 16:51:55 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org
Subject: [PATCH bpf-next v2 1/5] powerpc64/bpf: Implement PROBE_MEM32 pseudo instructions
Date: Fri, 29 Aug 2025 22:21:31 +0530
Message-ID: <20250829165135.1273071-2-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250829165135.1273071-1-skb99@linux.ibm.com>
References: <20250829165135.1273071-1-skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N_Xe4opC0_p-Si8z8jZ05S0_L5bjNHsq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfXyH87Mp+rqttH
 z5MMvV7nfp835ci4iWMVRhBB3PylFh3GxPqWTo3IgujL5ZmIPPB9w6Ws0XCD3Pr+Vc9sryf16sp
 kKbe3eCQP9n0Y7hTmPVp+cW7rUxUWmJqZfrq6urlGwv5jKkBFfjnjcxnGzoa/EUS/j9K8AiF8Sz
 PkYxJIOeC2d2T/GQPRtLbgMoQSXFlWn3LNR9pTANOy46r6i+qDJ1VoYn1OZAWMet9ZFYM3ZdK71
 lqfZcOuUiE3YAHhQOoi5hFka5X2JXH5ahUTglLKzslCDgbIIL0yzqyClTdqx9/JvvexJOg3uOen
 Z1PrS0sHge6kfsuKUnth5nTRnuylE+AtHVEOk6s8ofAsModiEC7SCgnVSS0CiNGMjHsD7llWc3f
 LvJqFrI+
X-Proofpoint-ORIG-GUID: 5xilHA6ckvZDHplRH7G1EM-VmscAQgxw
X-Authority-Analysis: v=2.4 cv=SNNCVPvH c=1 sm=1 tr=0 ts=68b1dabe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=CBn9msP3JWrqCmtcpI4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230021

Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
instructions.  They are similar to PROBE_MEM instructions with the
following differences:
- PROBE_MEM32 supports store.
- PROBE_MEM32 relies on the verifier to clear upper 32-bit of the
src/dst register
- PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in _R26
in the prologue). Due to bpf_arena constructions such _R26 + reg +
off16 access is guaranteed to be within arena virtual range, so no
address check at run-time.
- PROBE_MEM32 allows STX and ST. If they fault the store is a nop. When
LDX faults the destination register is zeroed.

To support these on powerpc, we do tmp1 = _R26 + src/dst reg and then use
tmp1 as the new src/dst register. This allows us to reuse most of the
code for normal [LDX | STX | ST].

Additionally, bpf_jit_emit_probe_mem_store() is introduced to emit
instructions for storing memory values depending on the size (byte,
halfword, word, doubleword).

Stack layout is adjusted to introduce a new NVR (_R26) and to make
BPF_PPC_STACKFRAME quadword aligned (local_tmp_var is increased by
8 bytes).

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        |   5 +-
 arch/powerpc/net/bpf_jit_comp.c   |  10 +-
 arch/powerpc/net/bpf_jit_comp32.c |   2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 162 ++++++++++++++++++++++++++----
 4 files changed, 155 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 4c26912c2e3c..2d095a873305 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -161,9 +161,10 @@ struct codegen_context {
 	unsigned int seen;
 	unsigned int idx;
 	unsigned int stack_size;
-	int b2p[MAX_BPF_JIT_REG + 2];
+	int b2p[MAX_BPF_JIT_REG + 3];
 	unsigned int exentry_idx;
 	unsigned int alt_exit_addr;
+	u64 arena_vm_start;
 };
 
 #define bpf_to_ppc(r)	(ctx->b2p[r])
@@ -201,7 +202,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
 
 int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass,
 			  struct codegen_context *ctx, int insn_idx,
-			  int jmp_off, int dst_reg);
+			  int jmp_off, int dst_reg, u32 code);
 
 #endif
 
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index c0684733e9d6..7d070232159f 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -204,6 +204,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 
 	/* Make sure that the stack is quadword aligned. */
 	cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
+	cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux->arena);
 
 	/* Scouting faux-generate pass 0 */
 	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
@@ -326,7 +327,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
  */
 int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass,
 			  struct codegen_context *ctx, int insn_idx, int jmp_off,
-			  int dst_reg)
+			  int dst_reg, u32 code)
 {
 	off_t offset;
 	unsigned long pc;
@@ -355,6 +356,9 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass
 		(ctx->exentry_idx * BPF_FIXUP_LEN * 4);
 
 	fixup[0] = PPC_RAW_LI(dst_reg, 0);
+	if (BPF_CLASS(code) == BPF_ST || BPF_CLASS(code) == BPF_STX)
+		fixup[0] = PPC_RAW_NOP();
+
 	if (IS_ENABLED(CONFIG_PPC32))
 		fixup[1] = PPC_RAW_LI(dst_reg - 1, 0); /* clear higher 32-bit register too */
 
@@ -579,7 +583,7 @@ static void bpf_trampoline_setup_tail_call_cnt(u32 *image, struct codegen_contex
 {
 	if (IS_ENABLED(CONFIG_PPC64)) {
 		/* See bpf_jit_stack_tailcallcnt() */
-		int tailcallcnt_offset = 6 * 8;
+		int tailcallcnt_offset = 7 * 8;
 
 		EMIT(PPC_RAW_LL(_R3, _R1, func_frame_offset - tailcallcnt_offset));
 		EMIT(PPC_RAW_STL(_R3, _R1, -tailcallcnt_offset));
@@ -594,7 +598,7 @@ static void bpf_trampoline_restore_tail_call_cnt(u32 *image, struct codegen_cont
 {
 	if (IS_ENABLED(CONFIG_PPC64)) {
 		/* See bpf_jit_stack_tailcallcnt() */
-		int tailcallcnt_offset = 6 * 8;
+		int tailcallcnt_offset = 7 * 8;
 
 		EMIT(PPC_RAW_LL(_R3, _R1, -tailcallcnt_offset));
 		EMIT(PPC_RAW_STL(_R3, _R1, func_frame_offset - tailcallcnt_offset));
diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 0aace304dfe1..3087e744fb25 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -1087,7 +1087,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 				}
 
 				ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx, insn_idx,
-							    jmp_off, dst_reg);
+							    jmp_off, dst_reg, code);
 				if (ret)
 					return ret;
 			}
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 025524378443..569619f1b31c 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -25,18 +25,18 @@
  * with our redzone usage.
  *
  *		[	prev sp		] <-------------
- *		[   nv gpr save area	] 5*8		|
+ *		[   nv gpr save area	] 6*8		|
  *		[    tail_call_cnt	] 8		|
- *		[    local_tmp_var	] 16		|
+ *		[    local_tmp_var	] 24		|
  * fp (r31) -->	[   ebpf stack space	] upto 512	|
  *		[     frame header	] 32/112	|
  * sp (r1) --->	[    stack pointer	] --------------
  */
 
 /* for gpr non volatile registers BPG_REG_6 to 10 */
-#define BPF_PPC_STACK_SAVE	(5*8)
+#define BPF_PPC_STACK_SAVE	(6*8)
 /* for bpf JIT code internal usage */
-#define BPF_PPC_STACK_LOCALS	24
+#define BPF_PPC_STACK_LOCALS	32
 /* stack frame excluding BPF stack, ensure this is quadword aligned */
 #define BPF_PPC_STACKFRAME	(STACK_FRAME_MIN_SIZE + \
 				 BPF_PPC_STACK_LOCALS + BPF_PPC_STACK_SAVE)
@@ -44,6 +44,7 @@
 /* BPF register usage */
 #define TMP_REG_1	(MAX_BPF_JIT_REG + 0)
 #define TMP_REG_2	(MAX_BPF_JIT_REG + 1)
+#define ARENA_VM_START  (MAX_BPF_JIT_REG + 2)
 
 /* BPF to ppc register mappings */
 void bpf_jit_init_reg_mapping(struct codegen_context *ctx)
@@ -67,10 +68,12 @@ void bpf_jit_init_reg_mapping(struct codegen_context *ctx)
 	ctx->b2p[BPF_REG_AX] = _R12;
 	ctx->b2p[TMP_REG_1] = _R9;
 	ctx->b2p[TMP_REG_2] = _R10;
+	/* non volatile register for kern_vm_start address */
+	ctx->b2p[ARENA_VM_START] = _R26;
 }
 
-/* PPC NVR range -- update this if we ever use NVRs below r27 */
-#define BPF_PPC_NVR_MIN		_R27
+/* PPC NVR range -- update this if we ever use NVRs below r26 */
+#define BPF_PPC_NVR_MIN		_R26
 
 static inline bool bpf_has_stack_frame(struct codegen_context *ctx)
 {
@@ -89,9 +92,9 @@ static inline bool bpf_has_stack_frame(struct codegen_context *ctx)
  *		[	prev sp		] <-------------
  *		[	  ...       	] 		|
  * sp (r1) --->	[    stack pointer	] --------------
- *		[   nv gpr save area	] 5*8
+ *		[   nv gpr save area	] 6*8
  *		[    tail_call_cnt	] 8
- *		[    local_tmp_var	] 16
+ *		[    local_tmp_var	] 24
  *		[   unused red zone	] 224
  */
 static int bpf_jit_stack_local(struct codegen_context *ctx)
@@ -99,12 +102,12 @@ static int bpf_jit_stack_local(struct codegen_context *ctx)
 	if (bpf_has_stack_frame(ctx))
 		return STACK_FRAME_MIN_SIZE + ctx->stack_size;
 	else
-		return -(BPF_PPC_STACK_SAVE + 24);
+		return -(BPF_PPC_STACK_SAVE + 32);
 }
 
 static int bpf_jit_stack_tailcallcnt(struct codegen_context *ctx)
 {
-	return bpf_jit_stack_local(ctx) + 16;
+	return bpf_jit_stack_local(ctx) + 24;
 }
 
 static int bpf_jit_stack_offsetof(struct codegen_context *ctx, int reg)
@@ -170,10 +173,17 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 		if (bpf_is_seen_register(ctx, bpf_to_ppc(i)))
 			EMIT(PPC_RAW_STD(bpf_to_ppc(i), _R1, bpf_jit_stack_offsetof(ctx, bpf_to_ppc(i))));
 
+	if (ctx->arena_vm_start)
+		EMIT(PPC_RAW_STD(bpf_to_ppc(ARENA_VM_START), _R1,
+				 bpf_jit_stack_offsetof(ctx, bpf_to_ppc(ARENA_VM_START))));
+
 	/* Setup frame pointer to point to the bpf stack area */
 	if (bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP)))
 		EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), _R1,
 				STACK_FRAME_MIN_SIZE + ctx->stack_size));
+
+	if (ctx->arena_vm_start)
+		PPC_LI64(bpf_to_ppc(ARENA_VM_START), ctx->arena_vm_start);
 }
 
 static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx)
@@ -185,6 +195,10 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
 		if (bpf_is_seen_register(ctx, bpf_to_ppc(i)))
 			EMIT(PPC_RAW_LD(bpf_to_ppc(i), _R1, bpf_jit_stack_offsetof(ctx, bpf_to_ppc(i))));
 
+	if (ctx->arena_vm_start)
+		EMIT(PPC_RAW_LD(bpf_to_ppc(ARENA_VM_START), _R1,
+				bpf_jit_stack_offsetof(ctx, bpf_to_ppc(ARENA_VM_START))));
+
 	/* Tear down our stack frame */
 	if (bpf_has_stack_frame(ctx)) {
 		EMIT(PPC_RAW_ADDI(_R1, _R1, BPF_PPC_STACKFRAME + ctx->stack_size));
@@ -396,11 +410,11 @@ void bpf_stf_barrier(void);
 asm (
 "		.global bpf_stf_barrier		;"
 "	bpf_stf_barrier:			;"
-"		std	21,-64(1)		;"
-"		std	22,-56(1)		;"
+"		std	21,-80(1)		;"
+"		std	22,-72(1)		;"
 "		sync				;"
-"		ld	21,-64(1)		;"
-"		ld	22,-56(1)		;"
+"		ld	21,-80(1)		;"
+"		ld	22,-72(1)		;"
 "		ori	31,31,0			;"
 "		.rept 14			;"
 "		b	1f			;"
@@ -409,6 +423,36 @@ asm (
 "		blr				;"
 );
 
+static int bpf_jit_emit_probe_mem_store(struct codegen_context *ctx, u32 src_reg, s16 off,
+					u32 code, u32 *image)
+{
+	u32 tmp1_reg = bpf_to_ppc(TMP_REG_1);
+	u32 tmp2_reg = bpf_to_ppc(TMP_REG_2);
+
+	switch (BPF_SIZE(code)) {
+	case BPF_B:
+		EMIT(PPC_RAW_STB(src_reg, tmp1_reg, off));
+		break;
+	case BPF_H:
+		EMIT(PPC_RAW_STH(src_reg, tmp1_reg, off));
+		break;
+	case BPF_W:
+		EMIT(PPC_RAW_STW(src_reg, tmp1_reg, off));
+		break;
+	case BPF_DW:
+		if (off % 4) {
+			EMIT(PPC_RAW_LI(tmp2_reg, off));
+			EMIT(PPC_RAW_STDX(src_reg, tmp1_reg, tmp2_reg));
+		} else {
+			EMIT(PPC_RAW_STD(src_reg, tmp1_reg, off));
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int emit_atomic_ld_st(const struct bpf_insn insn, struct codegen_context *ctx, u32 *image)
 {
 	u32 code = insn.code;
@@ -960,6 +1004,50 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			}
 			break;
 
+		case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
+		case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
+		case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
+		case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
+
+			EMIT(PPC_RAW_ADD(tmp1_reg, dst_reg, bpf_to_ppc(ARENA_VM_START)));
+
+			ret = bpf_jit_emit_probe_mem_store(ctx, src_reg, off, code, image);
+			if (ret)
+				return ret;
+
+			ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx,
+						    ctx->idx - 1, 4, -1, code);
+			if (ret)
+				return ret;
+
+			break;
+
+		case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
+		case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
+		case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
+		case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
+
+			EMIT(PPC_RAW_ADD(tmp1_reg, dst_reg, bpf_to_ppc(ARENA_VM_START)));
+
+			if (BPF_SIZE(code) == BPF_W || BPF_SIZE(code) == BPF_DW) {
+				PPC_LI32(tmp2_reg, imm);
+				src_reg = tmp2_reg;
+			} else {
+				EMIT(PPC_RAW_LI(tmp2_reg, imm));
+				src_reg = tmp2_reg;
+			}
+
+			ret = bpf_jit_emit_probe_mem_store(ctx, src_reg, off, code, image);
+			if (ret)
+				return ret;
+
+			ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx,
+						    ctx->idx - 1, 4, -1, code);
+			if (ret)
+				return ret;
+
+			break;
+
 		/*
 		 * BPF_STX ATOMIC (atomic ops)
 		 */
@@ -1112,9 +1200,10 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 				 * Check if 'off' is word aligned for BPF_DW, because
 				 * we might generate two instructions.
 				 */
-				if ((BPF_SIZE(code) == BPF_DW ||
-				    (BPF_SIZE(code) == BPF_B && BPF_MODE(code) == BPF_PROBE_MEMSX)) &&
-						(off & 3))
+				if ((BPF_SIZE(code) == BPF_DW && (off & 3)) ||
+				    (BPF_SIZE(code) == BPF_B &&
+				     BPF_MODE(code) == BPF_PROBE_MEMSX) ||
+				    (BPF_SIZE(code) == BPF_B && BPF_MODE(code) == BPF_MEMSX))
 					PPC_JMP((ctx->idx + 3) * 4);
 				else
 					PPC_JMP((ctx->idx + 2) * 4);
@@ -1160,12 +1249,49 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 
 			if (BPF_MODE(code) == BPF_PROBE_MEM) {
 				ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx,
-							    ctx->idx - 1, 4, dst_reg);
+							    ctx->idx - 1, 4, dst_reg, code);
 				if (ret)
 					return ret;
 			}
 			break;
 
+		/* dst = *(u64 *)(ul) (src + ARENA_VM_START + off) */
+		case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
+		case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
+		case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
+		case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
+
+			EMIT(PPC_RAW_ADD(tmp1_reg, src_reg, bpf_to_ppc(ARENA_VM_START)));
+
+			switch (size) {
+			case BPF_B:
+				EMIT(PPC_RAW_LBZ(dst_reg, tmp1_reg, off));
+				break;
+			case BPF_H:
+				EMIT(PPC_RAW_LHZ(dst_reg, tmp1_reg, off));
+				break;
+			case BPF_W:
+				EMIT(PPC_RAW_LWZ(dst_reg, tmp1_reg, off));
+				break;
+			case BPF_DW:
+				if (off % 4) {
+					EMIT(PPC_RAW_LI(tmp2_reg, off));
+					EMIT(PPC_RAW_LDX(dst_reg, tmp1_reg, tmp2_reg));
+				} else {
+					EMIT(PPC_RAW_LD(dst_reg, tmp1_reg, off));
+				}
+				break;
+			}
+
+			if (size != BPF_DW && insn_is_zext(&insn[i + 1]))
+				addrs[++i] = ctx->idx * 4;
+
+			ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx,
+						    ctx->idx - 1, 4, dst_reg, code);
+			if (ret)
+				return ret;
+			break;
+
 		/*
 		 * Doubleword load
 		 * 16 byte instruction that uses two 'struct bpf_insn'
-- 
2.43.5


