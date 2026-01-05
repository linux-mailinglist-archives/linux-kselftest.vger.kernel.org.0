Return-Path: <linux-kselftest+bounces-48200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7F7CF31B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 12:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAC95316B4E9
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 10:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692133101CD;
	Mon,  5 Jan 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q2BP2/si"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3FA319606;
	Mon,  5 Jan 2026 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610445; cv=none; b=m9YQB7wWVXd3rew2Vl02Qah3zsn1hlA4MxYAUypzbDwYxr6W6kZvEgY/VWSb6pIsZHrwtYlRkJFGbKwDFMefOFPFsYCjw8rONISQej4AIQN1bkSe4sWzMi6u0fVZy4dT6lnFnrr+wVkbSny7VqsbgfFH84HwzofNM6x01uBvnhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610445; c=relaxed/simple;
	bh=Kce6HvTDmAbb5YmvD1yfmA+DaTSrS2gscSGSNwUAXVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOOUyrv0+UXkyMfUP4ztogJQcEWF4AUOwCvFjP120SfPxE+oiHvwoEYGFId35i/vxO9W5rmoIiYYM0jtZYvaYrzD5Efzbfu1FJnleKtt9c7G2A8Nh6L+AiW72/T+72pUxOxjnUleatEhRrf3v2CpLBw1qog36s1VxzXWojsb0xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q2BP2/si; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604IkMXQ017255;
	Mon, 5 Jan 2026 10:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4a8GXlB0hIJi+ZqSu
	KSoS6yEsvz6r4jZx+42LoHxxEY=; b=q2BP2/si+bRzOzXtLtjQGBs50P2Lvx778
	nNq23tmodvoKnJZvTt7TEqj/WHlRbK9dBJ4mTgACLJMyq5N30sSDikRsciYl7ZJo
	46TkWNdL1+0yXkWBOB3gK+i8uMvp6BA4Tjsf6o5IfpdjWM/iM4HEb9o4Ox40Ybtj
	PkdyauTCOhUuHng50obXWuVuNKFm11SOiJuewhREeJTH9vzTGcI2QdHox74EAuDU
	PE2y7kE32lHsfb5YQiOgSu28mzKCyZ5jIhlClT52OkGoyn7Gi+it83/zsLO9NyiH
	Sqsd0fskBT5bkhgNHTijO/T7zechlCMiFHJv844QCyCNUEdY7Y19A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu5xs72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:53:22 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 605Aotts022664;
	Mon, 5 Jan 2026 10:53:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu5xs70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:53:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 605AdmCl014511;
	Mon, 5 Jan 2026 10:53:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeemn90k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:53:20 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 605ArGud56230150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Jan 2026 10:53:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B1F420049;
	Mon,  5 Jan 2026 10:53:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F2B020040;
	Mon,  5 Jan 2026 10:53:10 +0000 (GMT)
Received: from abhi.. (unknown [9.124.213.127])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Jan 2026 10:53:10 +0000 (GMT)
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
Subject: [PATCH 6/6] powerpc64/bpf: Additional NVR handling for bpf_throw
Date: Mon,  5 Jan 2026 16:22:12 +0530
Message-ID: <20260105105212.136645-7-adubey@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695b9822 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=49GENK-6fEsES3x69YYA:9
X-Proofpoint-ORIG-GUID: 4_UlJfNwuW3c3BE7I9RGgLB1eAGa3mjR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA5NSBTYWx0ZWRfX2N7RUlbM3ADW
 IImIXUOI57HUj3Nf54mlmDiH9MdzPuudWy9elfn7kaC21SbwqJbmflSevdNob2QVyBDdR2hBY6M
 I/uzCaSiJVu8ztjSOkHFNSBJ0ifBW5tZWc72WbcauZuW0LOHWLNJV0LOc5LEqg/Ki5jQ8jVNvWQ
 JSY/gcg1z4P9zOXu6CnEIlGzGF/qFgwhWwQUf80m50sPeCqiSl3R3yMWg89MvqCZHQuPJoDZcO8
 2bzfj+iNpYfs6FcylYohE0hmIu/4gk0XyyGnmhq05vbwkUmFr80TCKKsPFQO8xYpCJ0s6AZaQOu
 8yMWor4B5Kcyd+hUAS3EmzS8MKuaf6RHIbWjEUYdRHxEnTd9rPf1+ikVjup/ck/wZCbUB89fYzc
 n8M/ofaw/br0lgre2fzaQ/+44jdpQTeo+uHrlPbuZOuQtCDLzPr/uHbYOfabYE9cRTSmjYF+1hE
 /mdl3hlMzlq/0hfQKhw==
X-Proofpoint-GUID: BZd-Rfx6MedGH2tL0nj2PfN_tUuzlzgE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601050095

From: Abhishek Dubey <adubey@linux.ibm.com>

The bpf_throw() function never returns, if it has
clobbered any callee-saved register, those will
remain clobbered. The prologue must take care of
saving all callee-saved registers in the frame of
exception boundary program. Later these additional
non volatile registers R14-R25 along with other
NVRs are restored back in the epilogue of exception
callback.

To achieve above objective the frame size is
determined dynamically to accommodate additional
non volatile registers in exception boundary's frame.
For non-exception boundary program, the frame size
remains optimal. The additional instructions to
save & restore r14-r25 registers are emitted only during
exception boundary and exception callback respectively.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 70 +++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 5ec8e3654098..21f04eb57605 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -29,19 +29,33 @@
  *                  main's frame in sub-prog's frame.
  *
  *		[	prev sp		] <-------------
- *		[   nv gpr save area	] 6*8		|
+ *		[   nv gpr save area	] 6*8 + (12*8)	|
  *		[    tail_call_info	] 8		|
  *		[    local_tmp_var	] 24		|
  * fp (r31) -->	[   ebpf stack space	] upto 512	|
  *		[     frame header	] 32/112	|
  * sp (r1) --->	[    stack pointer	] --------------
+ *
+ * Additional (12*8) in 'nv gpr save area' only in case of
+ * exception boundary.
  */
 
 /* for bpf JIT code internal usage */
 #define BPF_PPC_STACK_LOCALS	32
+/*
+ * for additional non volatile registers(r14-r25) to be saved
+ * at exception boundary
+ */
+#define BPF_PPC_EXC_STACK_SAVE	(12*8)
 /* stack frame excluding BPF stack, ensure this is quadword aligned */
 #define BPF_PPC_STACKFRAME	(STACK_FRAME_MIN_SIZE + \
 				 BPF_PPC_STACK_LOCALS + BPF_PPC_STACK_SAVE)
+/*
+ * same as BPF_PPC_STACKFRAME with save area for additional
+ * non volatile registers saved at exception boundary.
+ * This is quad-word aligned.
+ */
+#define BPF_PPC_EXC_STACKFRAME	BPF_PPC_STACKFRAME + BPF_PPC_EXC_STACK_SAVE
 
 /* BPF register usage */
 #define TMP_REG_1	(MAX_BPF_JIT_REG + 0)
@@ -96,17 +110,23 @@ static inline bool bpf_has_stack_frame(struct codegen_context *ctx)
  *		[	prev sp		] <-------------
  *		[	  ...       	] 		|
  * sp (r1) --->	[    stack pointer	] --------------
- *		[   nv gpr save area	] 6*8
+ *		[   nv gpr save area	] 6*8 + (12*8)
  *		[    tail_call_info	] 8
  *		[    local_tmp_var	] 24
  *		[   unused red zone	] 224
+ *
+ * Additional (12*8) in 'nv gpr save area' only in case of
+ * exception boundary.
  */
 static int bpf_jit_stack_local(struct codegen_context *ctx)
 {
 	if (bpf_has_stack_frame(ctx))
 		return STACK_FRAME_MIN_SIZE + ctx->stack_size;
 	else
-		return -(BPF_PPC_STACK_SAVE + 32);
+		return -(BPF_PPC_STACK_SAVE
+			+ (ctx->exception_boundary || ctx->exception_cb ?
+				BPF_PPC_EXC_STACK_SAVE : 0)
+			+ 32) /* tail_call_info + local_tmp_var */;
 }
 
 int bpf_jit_stack_tailcallinfo_offset(struct codegen_context *ctx)
@@ -116,10 +136,20 @@ int bpf_jit_stack_tailcallinfo_offset(struct codegen_context *ctx)
 
 static int bpf_jit_stack_offsetof(struct codegen_context *ctx, int reg)
 {
-	if (reg >= BPF_PPC_NVR_MIN && reg < 32)
+	int min_valid_nvreg = BPF_PPC_NVR_MIN;
+	/* Default frame size for all cases except exception boundary */
+	int frame_nvr_size = BPF_PPC_STACKFRAME;
+
+	/* Consider all nv regs for handling exceptions */
+	if (ctx->exception_boundary || ctx->exception_cb) {
+		min_valid_nvreg = _R14;
+		frame_nvr_size = BPF_PPC_EXC_STACKFRAME;
+	}
+
+	if (reg >= min_valid_nvreg && reg < 32)
 		return (bpf_has_stack_frame(ctx) ?
-			(BPF_PPC_STACKFRAME + ctx->stack_size) : 0)
-				- (8 * (32 - reg));
+			frame_nvr_size + ctx->stack_size : 0)
+			- (8 * (32 - reg));
 
 	pr_err("BPF JIT is asking about unknown registers");
 	BUG();
@@ -179,7 +209,20 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 			EMIT(PPC_RAW_STD(_R0, _R1, PPC_LR_STKOFF));
 		}
 
-		EMIT(PPC_RAW_STDU(_R1, _R1, -(BPF_PPC_STACKFRAME + ctx->stack_size)));
+		int stack_expand = ctx->exception_boundary || ctx->exception_cb ?
+					BPF_PPC_EXC_STACKFRAME : BPF_PPC_STACKFRAME;
+		EMIT(PPC_RAW_STDU(_R1, _R1, -(stack_expand + ctx->stack_size)));
+	}
+
+	/*
+	 * Program acting as exception boundary pushes R14..R25 in addition to
+	 * BPF callee-saved non volatile registers. Exception callback uses
+	 * the boundary program's stack frame, recover additionally saved
+	 * registers in epilogue of exception callback.
+	 */
+	if (ctx->exception_boundary) {
+		for (i = _R14; i <= _R25; i++)
+			EMIT(PPC_RAW_STD(i, _R1, bpf_jit_stack_offsetof(ctx, i)));
 	}
 
 	if (!ctx->exception_cb) {
@@ -227,6 +270,14 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
 				bpf_jit_stack_offsetof(ctx, bpf_to_ppc(ARENA_VM_START))));
 
 	if (ctx->exception_cb) {
+		/*
+		 * Recover additionally saved non volatile registers from stack
+		 * frame of exception boundary program.
+		 */
+		for (i = _R14; i <= _R25; i++) {
+			EMIT(PPC_RAW_LD(i, _R1, bpf_jit_stack_offsetof(ctx, i)));
+		}
+
 		/*
 		 * LR value from boundary-frame is received as second parameter
 		 * in exception callback.
@@ -236,7 +287,10 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
 
 	/* Tear down our stack frame */
 	if (bpf_has_stack_frame(ctx)) {
-		EMIT(PPC_RAW_ADDI(_R1, _R1, BPF_PPC_STACKFRAME + ctx->stack_size));
+		int stack_shrink = ctx->exception_cb || ctx->exception_boundary ?
+					BPF_PPC_EXC_STACKFRAME : BPF_PPC_STACKFRAME;
+		EMIT(PPC_RAW_ADDI(_R1, _R1, stack_shrink + ctx->stack_size));
+
 		if (ctx->seen & SEEN_FUNC || ctx->exception_cb) {
 			EMIT(PPC_RAW_LD(_R0, _R1, PPC_LR_STKOFF));
 			EMIT(PPC_RAW_MTLR(_R0));
-- 
2.48.1


