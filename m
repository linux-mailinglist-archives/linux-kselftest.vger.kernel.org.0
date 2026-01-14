Return-Path: <linux-kselftest+bounces-48924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B64D1E89F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 12:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E00BA3067F5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 11:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FC9396B81;
	Wed, 14 Jan 2026 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cDWmPANQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78594396B6E;
	Wed, 14 Jan 2026 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391177; cv=none; b=bqmG4ORfKrdwIaOMtM+BFCFy5d9PELy6awUa4y4S8qKt4IkDa30T4KE3U0CiVFm4VcRrj7GWvVnFl5t2ApY6OL4tA9SD3JpL0Difqlomoac0ETFiJ3RvAZ2XuG6DXKe/yQuQwnHlD4dEC+SLOUEsfa8z6RahyooPG42l/b1pd1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391177; c=relaxed/simple;
	bh=IMv6UmyPHA/NZcSIkxk3yn+ujdh6Ok1Cl08vKSOlN5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlmwGPHWqlKcu1bHDXt6vNBFA9pBchrTn8kaURqc7wedbBIFa7VRJGgShkrazlnVCptIsQbLomcnJ2+KhEeIpWwlkGXRpVXitQ7pU5kwFjC1Sf8UScq7tcNdG7w4UDU34rhQYhZk0DeQL9gQ6kZgKhDMzS/+MbnO56Z0oAhxEx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cDWmPANQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60E9atH2027468;
	Wed, 14 Jan 2026 11:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ahiomznzEkOpa4WVW
	ml1SafgPWOLVG69UuUQ4udIaAU=; b=cDWmPANQ+3AH6WRJJBvFM4kGaGW1LIBBd
	/DaFsJzMgeXGE4edxerQVTue6xFY7eOwN7zXre6Wk0ea73EwFmoaiJlETewSkOVr
	X9BSgCWY5dIIVqHwDjhtj4HovZDrbpJA8PI3xLObOPGLsPWTPi9PAqRKhjRUSyrn
	U9D4quO0fkpCuOh5K3QFzV66IIfHbQ9Ok020yVNRGj+wKy8oZGP36tW6c/LyCwDu
	yo1g+D1kBZ7cNf5KKC6cNxefJk/dcWpZeU6rlPKDTu8gEcJLkEfovOLrn6DU7nkU
	mtY5BVIdE5k44DZP6Wn8fiQcWqr/voJxoHSfmmnGxwVgVUqkjezOg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6h8xgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 11:45:44 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60EBji7C010497;
	Wed, 14 Jan 2026 11:45:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6h8xgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 11:45:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60EBKNgE029743;
	Wed, 14 Jan 2026 11:45:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3ajskq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 11:45:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60EBjdQA24379876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 11:45:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 525EA20043;
	Wed, 14 Jan 2026 11:45:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE04220040;
	Wed, 14 Jan 2026 11:45:32 +0000 (GMT)
Received: from abhi.. (unknown [9.124.217.65])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jan 2026 11:45:32 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v2 2/6] powerpc64/bpf: Support tailcalls with subprogs
Date: Wed, 14 Jan 2026 17:14:46 +0530
Message-ID: <20260114114450.30405-3-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260114114450.30405-1-adubey@linux.ibm.com>
References: <20260114114450.30405-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fqc1pdcJsBmUjo_Vq3js5Wb5bV5Uf0jK
X-Proofpoint-ORIG-GUID: V5sq_PHPvX459JuqANG2H2X6SN6_3mgS
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=696781e8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=hRgTkoRQdUDsKxgB9FcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfX8FqpTjiJCaxb
 rhtl6LeNQv2Lh/yDse/lU3h0ssEdjEahzEiOkDVqMWRQw9IBd8ef4zepcR/ByVqr7aQjfyn6RPa
 BVa5A38QEjKH1h6kesG/77JXmAkO6jRIlrBlxrw7caI3okRpHzUiLPHqqxL/1dp4zBvzPCj9wkU
 S0umLjFYVso2d7iw+aZLLaszSJTPXYtHWJsBKoaHS9FFh7T92astYWB228Qb35DzEtGib89XTXr
 n3Ins5/ur5OC1OeyQ64oOzSHxnSnUwO4p6UT0M2uySgFGDCjNa5bEJ81lFAfwVhruVIBwxpAr4l
 US+DpnGCUsesa6TXSZhUhRS4RaBhzc+I5HWvBSrVV/67/uV6k6NKDIy/1eZ6BwKTMArXR0QOmEm
 thu9SIm4FihmmRPsKum15PoH2536I2lLy80AEatCpHozQHrmZk5lUM9KIHbMuRCoip+C3/Al7U8
 InvulGMOGpY8iuCIgQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601140093

From: Abhishek Dubey <adubey@linux.ibm.com>

Enabling tailcalls with subprog combinations by referencing
method. The actual tailcall count is always maintained in the
tail_call_info variable present in the frame of main function
(also called entry function). The tail_call_info variables in
the frames of all other subprog contains reference to the
tail_call_info present in frame of main function.

Dynamic resolution interprets the tail_call_info either as
value or reference depending on the context of active frame
while tailcall is invoked.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        | 12 +++++-
 arch/powerpc/net/bpf_jit_comp.c   | 10 ++++-
 arch/powerpc/net/bpf_jit_comp64.c | 68 +++++++++++++++++++++++--------
 3 files changed, 70 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 45d419c0ee73..5d735bc5e6bd 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -51,6 +51,12 @@
 		EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | (offset & 0xfffc));					\
 	} while (0)
 
+/* Same as PPC_BCC_SHORT, except valid dest is known prior to call. */
+#define PPC_COND_BRANCH(cond, dest)                                           \
+	do {								      \
+		long offset = (long)(dest) - CTX_NIA(ctx);		      \
+		EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | (offset & 0xfffc));    \
+	} while (0)
 /*
  * Sign-extended 32-bit immediate load
  *
@@ -75,6 +81,8 @@
 
 /* for tailcall counter */
 #define BPF_PPC_TAILCALL        8
+/* for gpr non volatile registers BPG_REG_6 to 10 */
+#define BPF_PPC_STACK_SAVE      (6*8)
 
 /* If dummy pass (!image), account for maximum possible instructions */
 #define PPC_LI64(d, i)		do {					      \
@@ -170,6 +178,7 @@ struct codegen_context {
 	unsigned int alt_exit_addr;
 	u64 arena_vm_start;
 	u64 user_vm_start;
+	bool is_subprog;
 };
 
 #define bpf_to_ppc(r)	(ctx->b2p[r])
@@ -204,11 +213,10 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
 void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx);
 void bpf_jit_realloc_regs(struct codegen_context *ctx);
 int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
-
 int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass,
 			  struct codegen_context *ctx, int insn_idx,
 			  int jmp_off, int dst_reg, u32 code);
-
+int bpf_jit_stack_tailcallinfo_offset(struct codegen_context *ctx);
 #endif
 
 #endif
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 5e976730b2f5..069a8822c30d 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -206,6 +206,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
 	cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux->arena);
 	cgctx.user_vm_start = bpf_arena_get_user_vm_start(fp->aux->arena);
+	cgctx.is_subprog = bpf_is_subprog(fp);
 
 	/* Scouting faux-generate pass 0 */
 	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
@@ -435,6 +436,11 @@ void bpf_jit_free(struct bpf_prog *fp)
 	bpf_prog_unlock_free(fp);
 }
 
+bool bpf_jit_supports_subprog_tailcalls(void)
+{
+	return IS_ENABLED(CONFIG_PPC64);
+}
+
 bool bpf_jit_supports_kfunc_call(void)
 {
 	return true;
@@ -604,7 +610,7 @@ static void bpf_trampoline_setup_tail_call_cnt(u32 *image, struct codegen_contex
 					       int func_frame_offset, int r4_off)
 {
 	if (IS_ENABLED(CONFIG_PPC64)) {
-		/* See bpf_jit_stack_tailcallcnt() */
+		/* See bpf_jit_stack_tailcallinfo_offset() */
 		int tailcallcnt_offset = 7 * 8;
 
 		EMIT(PPC_RAW_LL(_R3, _R1, func_frame_offset - tailcallcnt_offset));
@@ -619,7 +625,7 @@ static void bpf_trampoline_restore_tail_call_cnt(u32 *image, struct codegen_cont
 						 int func_frame_offset, int r4_off)
 {
 	if (IS_ENABLED(CONFIG_PPC64)) {
-		/* See bpf_jit_stack_tailcallcnt() */
+		/* See bpf_jit_stack_tailcallinfo_offset() */
 		int tailcallcnt_offset = 7 * 8;
 
 		EMIT(PPC_RAW_LL(_R3, _R1, -tailcallcnt_offset));
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 39061cd742c1..cebf81fbd59f 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -26,8 +26,12 @@
  * Ensure the top half (upto local_tmp_var) stays consistent
  * with our redzone usage.
  *
+ * tail_call_info - stores tailcall count value in main program's
+ *                  frame, stores reference to tail_call_info of
+ *                  main's frame in sub-prog's frame.
+ *
  *		[	prev sp		] <-------------
- *		[    tail_call_cnt	] 8		|
+ *		[    tail_call_info	] 8		|
  *		[   nv gpr save area	] 6*8		|
  *		[    local_tmp_var	] 24		|
  * fp (r31) -->	[   ebpf stack space	] upto 512	|
@@ -35,8 +39,6 @@
  * sp (r1) --->	[    stack pointer	] --------------
  */
 
-/* for gpr non volatile registers BPG_REG_6 to 10 */
-#define BPF_PPC_STACK_SAVE	(6*8)
 /* for bpf JIT code internal usage */
 #define BPF_PPC_STACK_LOCALS	24
 /* stack frame excluding BPF stack, ensure this is quadword aligned */
@@ -98,7 +100,7 @@ static inline bool bpf_has_stack_frame(struct codegen_context *ctx)
  *		[	prev sp		] <-------------
  *		[	  ...       	] 		|
  * sp (r1) --->	[    stack pointer	] --------------
- *		[    tail_call_cnt	] 8
+ *		[    tail_call_info	] 8
  *		[   nv gpr save area	] 6*8
  *		[    local_tmp_var	] 24
  *		[   unused red zone	] 224
@@ -114,7 +116,7 @@ static int bpf_jit_stack_local(struct codegen_context *ctx)
 	}
 }
 
-static int bpf_jit_stack_tailcallcnt(struct codegen_context *ctx)
+int bpf_jit_stack_tailcallinfo_offset(struct codegen_context *ctx)
 {
 	return bpf_jit_stack_local(ctx) + BPF_PPC_STACK_LOCALS + BPF_PPC_STACK_SAVE;
 }
@@ -147,17 +149,32 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 #endif
 
 	/*
-	 * Initialize tail_call_cnt if we do tail calls.
-	 * Otherwise, put in NOPs so that it can be skipped when we are
-	 * invoked through a tail call.
+	 * Tail call count(tcc) is saved & updated only in main
+	 * program's frame and the address of tcc in main program's
+	 * frame (tcc_ptr) is saved in subprogs frame.
+	 *
+	 * Offset of tail_call_info on any frame will be interpreted
+	 * as either tcc_ptr or tcc value depending on whether it is
+	 * greater than MAX_TAIL_CALL_CNT or not.
 	 */
-	if (ctx->seen & SEEN_TAILCALL) {
+	if (!ctx->is_subprog) {
 		EMIT(PPC_RAW_LI(bpf_to_ppc(TMP_REG_1), 0));
 		/* this goes in the redzone */
 		EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, -(BPF_PPC_TAILCALL)));
 	} else {
-		EMIT(PPC_RAW_NOP());
-		EMIT(PPC_RAW_NOP());
+		/*
+		 * if tail_call_info < MAX_TAIL_CALL_CNT
+		 *     main prog calling first subprog -> copy reference
+		 * else
+		 *     subsequent subprog calling another subprog -> directly copy content
+		 */
+		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, 0));
+		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2), -(BPF_PPC_TAILCALL)));
+		EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+		PPC_COND_BRANCH(COND_GT, CTX_NIA(ctx) + 8);
+		EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2),
+							-(BPF_PPC_TAILCALL)));
+		EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, -(BPF_PPC_TAILCALL)));
 	}
 
 	if (bpf_has_stack_frame(ctx)) {
@@ -352,19 +369,38 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	EMIT(PPC_RAW_CMPLW(b2p_index, bpf_to_ppc(TMP_REG_1)));
 	PPC_BCC_SHORT(COND_GE, out);
 
+	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
+	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+	PPC_COND_BRANCH(COND_LE, CTX_NIA(ctx) + 8);
+
+	/* dereference TMP_REG_1 */
+	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), 0));
+
 	/*
-	 * if (tail_call_cnt >= MAX_TAIL_CALL_CNT)
+	 * if (tail_call_info == MAX_TAIL_CALL_CNT)
 	 *   goto out;
 	 */
-	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R1, bpf_jit_stack_tailcallcnt(ctx)));
 	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
-	PPC_BCC_SHORT(COND_GE, out);
+	PPC_COND_BRANCH(COND_EQ, out);
 
 	/*
-	 * tail_call_cnt++;
+	 * tail_call_info++; <- Actual value of tcc here
 	 */
 	EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), 1));
-	EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, bpf_jit_stack_tailcallcnt(ctx)));
+
+	/*
+	 * Before writing updated tail_call_info, distinguish if current frame
+	 * is storing a reference to tail_call_info or actual tcc value in
+	 * tail_call_info.
+	 */
+	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
+	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
+	PPC_COND_BRANCH(COND_GT, CTX_NIA(ctx) + 8);
+
+	/* First get address of tail_call_info */
+	EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_2), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
+	/* Writeback updated value to tail_call_info */
+	EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2), 0));
 
 	/* prog = array->ptrs[index]; */
 	EMIT(PPC_RAW_MULI(bpf_to_ppc(TMP_REG_1), b2p_index, 8));
-- 
2.48.1


