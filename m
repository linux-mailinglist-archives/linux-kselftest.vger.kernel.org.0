Return-Path: <linux-kselftest+bounces-48196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BBCCF3122
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 11:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D7543003857
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0873164B8;
	Mon,  5 Jan 2026 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xek50DoO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36FD3161A6;
	Mon,  5 Jan 2026 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610404; cv=none; b=S0iFgqHW04wryWMULKsINui3TvTpCwxZRF88QmQeSw5exOuCENPoe0TL5RqzNQE3pcj0DOLZEjkCDI2uOd2msL5/8M+0BkcZ03rDnPhaCqRyUMQefUN4po/hxrOI/XAzIaWywyTxtl+ZS2KBFd75F/DaTEHzzLuN+uT5vT1457g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610404; c=relaxed/simple;
	bh=Pf6uq9Sk3kzC39d7Q4RTA3JzF0t3R8suCXTkzOTbqgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngTVOGMbrMTYDbKQZ/7vekBwS8em7g01y9uaBYcVQii3bbzshVjBi/VYcAJmsy8hfC18IZobvoYr8XC6NX5UKcPTnLx2PZE56gg7XvgNNgcxWlz0nl1gaMdF/02dnEMBu20E7JtzdWxp32CWyBM+UJTgbty/GslruDHGFn6+WGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xek50DoO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 605ACpi3012994;
	Mon, 5 Jan 2026 10:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zv5IYtFTVrb5C5g07
	3T1pvBbb4HNP4RHEYsB7V1X9gI=; b=Xek50DoOgHY+RkzFYKl1UfJ78Sc56taQE
	fipbFX7frH+vSPvv3ONSHQCWxd8OW7DFs+MeUtoMj7mPe3lD9D04lBMnXVnXCshp
	G9yJ7ipHc7V9Krv+7+q4h5rGsdRxYgkvOGPG9+5t3eA6fS/TOXMjCM3sk4qByuLX
	1/0umV1Zq0vHMBHbIEF5NxMfIVrYipNhfPy+HexZtytiBWPiTKS4gFCJ69XZ+QfY
	9CikwikLUQUVcKF0Xt+0mCgUXLcR9Zde05ou3tD4UPUlcgmm1T0HztwQTe21obdH
	DLj/635yl5FoOwHsadKlrtbmBinZ15nYMaP8gyC0P7FaqNlKq+XrQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrte673-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:52:38 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 605Aqb7F010937;
	Mon, 5 Jan 2026 10:52:37 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrte671-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:52:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 605AFxdL015233;
	Mon, 5 Jan 2026 10:52:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfdes5djq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:52:36 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 605AqXEK48038354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Jan 2026 10:52:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0737720040;
	Mon,  5 Jan 2026 10:52:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F124A20049;
	Mon,  5 Jan 2026 10:52:26 +0000 (GMT)
Received: from abhi.. (unknown [9.124.213.127])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Jan 2026 10:52:26 +0000 (GMT)
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
Subject: [PATCH 1/6] powerpc64/bpf: Support tailcalls with subprogs
Date: Mon,  5 Jan 2026 16:22:07 +0530
Message-ID: <20260105105212.136645-2-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260105105212.136645-1-adubey@linux.ibm.com>
References: <20260105105212.136645-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695b97f6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=kwRpZc0szV6nT_PZ_DcA:9
X-Proofpoint-GUID: lF21zfAvmDGrwsYBVwLpxdNGAqGXBLP-
X-Proofpoint-ORIG-GUID: 7TdGhl2ur51Ib35N2yxIsvsi8Vu6YzC9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA5NSBTYWx0ZWRfX4710Hz/rHE7G
 H7H19ND+7Uc0qhAcuGTAYLyV+/xY7kg3k97+W1/45LO0uxuePBrHNVenco7QeWwPurP8lF1D8AZ
 soZWaj3N7hGBy8snaNVB+iIHFDvpQmGrVpHd+GpUiaJlzLOtzYxuwm0CIFDQBLVCfiupqDPwI3V
 vTiBQqxzHDD5j0AtPsqlF1oOiLhGeW5wfZkx0LPKl0UhJHzJZUOLrUOikeZJaf7Vguzg/f8IS4Q
 7hXXPnQme+u7mb60Buc1FFP0jA27Dw2WHbYEKhp+Ew0LplspH+MOQxqSNrbk5xzewn3/39LS1kB
 wpI1jlmFpAAR2rX5iKduOTuRqts8pI/5MKvrU5ukY/cMxXguPDQ7fzjFTntPZDC25PBfE7gprKn
 Ht3iDoR8Ou8XsOUl30XAioU4O3nKa9/xUKqtXwtdbChPUv/xIx+qY32p+sECkDAYTQtJXQ/4Lx7
 TjF51T1IkSS+q3Zc/lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601050095

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

Following is selftest run:

#./test_progs -t tailcalls
#425/1   tailcalls/tailcall_1:OK
#425/2   tailcalls/tailcall_2:OK
#425/3   tailcalls/tailcall_3:OK
#425/4   tailcalls/tailcall_4:OK
#425/5   tailcalls/tailcall_5:OK
#425/6   tailcalls/tailcall_6:OK
#425/7   tailcalls/tailcall_bpf2bpf_1:OK
#425/8   tailcalls/tailcall_bpf2bpf_2:OK
#425/9   tailcalls/tailcall_bpf2bpf_3:OK
#425/10  tailcalls/tailcall_bpf2bpf_4:OK
#425/11  tailcalls/tailcall_bpf2bpf_5:OK
#425/12  tailcalls/tailcall_bpf2bpf_6:OK
#425/13  tailcalls/tailcall_bpf2bpf_fentry:OK
#425/14  tailcalls/tailcall_bpf2bpf_fexit:OK
#425/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
#425/16  tailcalls/tailcall_bpf2bpf_fentry_entry:OK
#425/17  tailcalls/tailcall_poke:OK
#425/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
#425/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
#425/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
#425/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
#425/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
#425/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
#425/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
#425/25  tailcalls/tailcall_freplace:OK
#425/26  tailcalls/tailcall_bpf2bpf_freplace:OK
#425/27  tailcalls/tailcall_failure:OK
#425/28  tailcalls/reject_tail_call_spin_lock:OK
#425/29  tailcalls/reject_tail_call_rcu_lock:OK
#425/30  tailcalls/reject_tail_call_preempt_lock:OK
#425/31  tailcalls/reject_tail_call_ref:OK
#425     tailcalls:OK
Summary: 1/31 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        | 14 ++++++-
 arch/powerpc/net/bpf_jit_comp.c   | 10 ++++-
 arch/powerpc/net/bpf_jit_comp64.c | 67 +++++++++++++++++++++++--------
 3 files changed, 71 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 8334cd667bba..98e8b1f9c2f9 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -51,6 +51,12 @@
 		EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | (offset & 0xfffc));					\
 	} while (0)
 
+/* Same as PPC_BCC_SHORT, except valid dest is known prior to call. */
+#define PPC_COND_BRANCH(cond, dest)                                           \
+	do {								      \
+		long offset = (long)(dest) - CTX_NIA(ctx);		      \
+                EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | (offset & 0xfffc));    \
+	} while (0)
 /*
  * Sign-extended 32-bit immediate load
  *
@@ -72,6 +78,10 @@
 	} } while (0)
 
 #ifdef CONFIG_PPC64
+
+/* for gpr non volatile registers BPG_REG_6 to 10 */
+#define BPF_PPC_STACK_SAVE      (6*8)
+
 /* If dummy pass (!image), account for maximum possible instructions */
 #define PPC_LI64(d, i)		do {					      \
 	if (!image)							      \
@@ -166,6 +176,7 @@ struct codegen_context {
 	unsigned int alt_exit_addr;
 	u64 arena_vm_start;
 	u64 user_vm_start;
+	bool is_subprog;
 };
 
 #define bpf_to_ppc(r)	(ctx->b2p[r])
@@ -200,11 +211,10 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
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
index 1fe37128c876..37c547b49da8 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -24,17 +24,19 @@
  * Ensure the top half (upto local_tmp_var) stays consistent
  * with our redzone usage.
  *
+ * tail_call_info - stores tailcall count value in main program's
+ *                  frame, stores reference to tail_call_info of
+ *                  main's frame in sub-prog's frame.
+ *
  *		[	prev sp		] <-------------
  *		[   nv gpr save area	] 6*8		|
- *		[    tail_call_cnt	] 8		|
+ *		[    tail_call_info	] 8		|
  *		[    local_tmp_var	] 24		|
  * fp (r31) -->	[   ebpf stack space	] upto 512	|
  *		[     frame header	] 32/112	|
  * sp (r1) --->	[    stack pointer	] --------------
  */
 
-/* for gpr non volatile registers BPG_REG_6 to 10 */
-#define BPF_PPC_STACK_SAVE	(6*8)
 /* for bpf JIT code internal usage */
 #define BPF_PPC_STACK_LOCALS	32
 /* stack frame excluding BPF stack, ensure this is quadword aligned */
@@ -93,7 +95,7 @@ static inline bool bpf_has_stack_frame(struct codegen_context *ctx)
  *		[	  ...       	] 		|
  * sp (r1) --->	[    stack pointer	] --------------
  *		[   nv gpr save area	] 6*8
- *		[    tail_call_cnt	] 8
+ *		[    tail_call_info	] 8
  *		[    local_tmp_var	] 24
  *		[   unused red zone	] 224
  */
@@ -105,7 +107,7 @@ static int bpf_jit_stack_local(struct codegen_context *ctx)
 		return -(BPF_PPC_STACK_SAVE + 32);
 }
 
-static int bpf_jit_stack_tailcallcnt(struct codegen_context *ctx)
+int bpf_jit_stack_tailcallinfo_offset(struct codegen_context *ctx)
 {
 	return bpf_jit_stack_local(ctx) + 24;
 }
@@ -138,17 +140,31 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
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
 		EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, -(BPF_PPC_STACK_SAVE + 8)));
 	} else {
-		EMIT(PPC_RAW_NOP());
-		EMIT(PPC_RAW_NOP());
+		/*
+		 * if tail_call_info < MAX_TAIL_CALL_CNT
+		 * 	main prog calling first subprog -> copy reference
+		 * else
+		 * 	subsequent subprog calling another subprog -> directly copy content
+		 */
+		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, 0));
+		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2), -(BPF_PPC_STACK_SAVE+8)));
+		EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+		PPC_COND_BRANCH(COND_GT, CTX_NIA(ctx) + 8);
+		EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2), -(BPF_PPC_STACK_SAVE + 8)));
+		EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, -(BPF_PPC_STACK_SAVE + 8)));
 	}
 
 	if (bpf_has_stack_frame(ctx)) {
@@ -343,19 +359,38 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
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


