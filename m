Return-Path: <linux-kselftest+bounces-48201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF53CF31E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 12:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FCFF30210EF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 11:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37412319619;
	Mon,  5 Jan 2026 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cHk/za8b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429EF31A54A;
	Mon,  5 Jan 2026 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610470; cv=none; b=hTfG3sKqtRNTEx/wyllxJR3Di9x/jwL2Jje955gvEX5oUK3LYz175S0aHMYx07Zd3U8TeGSUsQTxGB2n+Z7YnZSf2AaGaTrY1PD5HXp64Cr/xaO/8UHCDbURwmzM5O4AGnPIfAbkwwAMhxDrnpXOMTt376eXvcYO3yTU5JVfmUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610470; c=relaxed/simple;
	bh=MqjdVdkKaUm1LXo8BXJHQMlT6vzqATPPCpqfOOlYdRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+79XEhbnMyNx6NKhgQjKk0N1tBKHJ/Fx++oumeKRe/CQId3FkaHTTlvjkVAqIEGCc2vvJygtwhLVgy/gb0T1Zma/irynk8tJ4Ny+2x44Pkk7FumOtBaOjpP33dVXUQMQwQDLyxNFUKJiy+zvuwL28cOkc3MOQ5mbSG1LNgUKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cHk/za8b; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604LMujJ020721;
	Mon, 5 Jan 2026 10:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oELxnmOGoZA7NMRFk
	o1gjMFUS0erHG3/oMRsIrRf/Sk=; b=cHk/za8b46wa4PXdDHinlnyYwosmhKYtL
	a2/4Klje3XhqMV8/XrUV5B8Gb2OEM3oif2KNk76wXdUAJVjJRXs4PAZUF05Xkoq0
	ecBpoVdVuQB2lQRb/gWDBa+nky6Aw9dKTL/oz7RnpZokFs9DO0FI0trsm+nji6y3
	ed/kvsr6UZiswuNtWZw3hkLWD9FERd6F3H6DU1BzOh89PEAFoc5SUIMKqN15sXFs
	RN9Saa494Oian0BSayV6MBxioX7NZWFyFGuY+gV9Q3Ibs1beOkZyQc04b6RVZnVY
	6LG8vHoal++89f8HtYAA2R5OGukOLxlzQvsKFJvJQ4ClYJVz9OlAw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu5xs4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:52:48 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 605AgUGD005433;
	Mon, 5 Jan 2026 10:52:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu5xs4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:52:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 605AdmCZ014511;
	Mon, 5 Jan 2026 10:52:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeemn8x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:52:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 605AqhGY62259544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Jan 2026 10:52:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE93420040;
	Mon,  5 Jan 2026 10:52:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E788420049;
	Mon,  5 Jan 2026 10:52:36 +0000 (GMT)
Received: from abhi.. (unknown [9.124.213.127])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Jan 2026 10:52:36 +0000 (GMT)
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
Subject: [PATCH 2/6] powerpc64/bpf: Tailcall handling with trampolines
Date: Mon,  5 Jan 2026 16:22:08 +0530
Message-ID: <20260105105212.136645-3-adubey@linux.ibm.com>
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
X-Proofpoint-GUID: oC44ZUBBUuDlwQj2SFPA2Q6q-5-12fUR
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695b9800 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=vfcL6nHFD5ed_ebL8FkA:9
X-Proofpoint-ORIG-GUID: DSRSrrc2IQlsxKvIz-MPgwF59IZVlWb2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA5NSBTYWx0ZWRfX4sONKJqhI0Mo
 BT3bq+2ldmDKk+EoGjCkkFMVs21iP4Qy7kLIgRJA2vA3wDB19yHFyw0z8RKdSwnf7Oj4AimXNy/
 Dx3URNsOOc5UL3+zd13lRVXu/M7ZCi/pijj01opjNHa9NPEvWq8zd0+o9EMwp2bcqL5/heEqNTm
 VJG5hMoNzKwm0YsQNtXScyWaYiirJgT+bgIwULaGrEtmHQr8H7mXMyjgyDKrmHYoTFqpa/FhMPZ
 xtZNDbQZrwTZ7rra14y5HP6yiKd2bodFbBrre1qVr7k3YseybELxb2OnIR4+L0KHCS4PxDTdtTW
 D8z8T/n032HimVFfFw/Q8yV0kpoDX7zy3hAT3MeZAw3AOCsPuSysVeg6LftVHgyEFkC5HVdHkXN
 khbetUDVlMWCYksjeTkuLGIVX7p1cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2512120000 definitions=main-2601050095

From: Abhishek Dubey <adubey@linux.ibm.com>

The trampoline mechanism sets up its own stack frame and
an additional dummy frame. We need to have additional JIT
instructions handling tailcall dereferencing in the
trampoline's context.

We don't add the two stack frames pointed above, rather
add space for conventional 'non-volatile register save area'
and tail_call_info in trampoline's frame for ppc64. This
makes the trampoline's frame consistent with layout of all
other frames.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 48 ++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 069a8822c30d..4aaa0a287a45 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -606,15 +606,42 @@ static int invoke_bpf_mod_ret(u32 *image, u32 *ro_image, struct codegen_context
 	return 0;
 }
 
-static void bpf_trampoline_setup_tail_call_cnt(u32 *image, struct codegen_context *ctx,
-					       int func_frame_offset, int r4_off)
+/*
+ * Refer the label 'Generated stack layout' in this file for actual stack
+ * layout during trampoline invocation.
+ *
+ * Refer __arch_prepare_bpf_trampoline() for stack component details.
+ *
+ * The tailcall count/reference is present in caller's stack frame. Its required
+ * to copy the content of tail_call_info before calling the actual function
+ * to which the trampoline is attached.
+ *
+ */
+
+static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_context *ctx,
+					       int func_frame_offset,
+					       int bpf_dummy_frame_size, int r4_off)
 {
 	if (IS_ENABLED(CONFIG_PPC64)) {
 		/* See bpf_jit_stack_tailcallinfo_offset() */
-		int tailcallcnt_offset = 7 * 8;
+		int tailcallinfo_offset = BPF_PPC_STACK_SAVE + SZL;
+		/*
+		 * func_frame_offset =
+		 * 	bpf_dummy_frame_size + trampoline_frame_size
+		 */
+		EMIT(PPC_RAW_LD(_R4, _R1, func_frame_offset));
+		EMIT(PPC_RAW_LD(_R3, _R4, -tailcallinfo_offset));
+
+		/*
+		 * Setting the tail_call_info in trampoline's frame
+		 * depending on if previous frame had value or reference.
+		 */
+		EMIT(PPC_RAW_CMPLWI(_R3, MAX_TAIL_CALL_CNT));
+		PPC_COND_BRANCH(COND_GT, CTX_NIA(ctx) + 8);
+		EMIT(PPC_RAW_ADDI(_R3, _R4, bpf_jit_stack_tailcallinfo_offset(ctx)));
+		EMIT(PPC_RAW_STL(_R3, _R1, func_frame_offset
+				- bpf_dummy_frame_size - tailcallinfo_offset));
 
-		EMIT(PPC_RAW_LL(_R3, _R1, func_frame_offset - tailcallcnt_offset));
-		EMIT(PPC_RAW_STL(_R3, _R1, -tailcallcnt_offset));
 	} else {
 		/* See bpf_jit_stack_offsetof() and BPF_PPC_TC */
 		EMIT(PPC_RAW_LL(_R4, _R1, r4_off));
@@ -721,6 +748,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *                              [ r0 save (32-bit)  ]   |
 	 * dummy frame for unwind       [ back chain 1      ] --
 	 *                              [ padding           ] align stack frame
+	 *                              [ r26..r31          ] nvr save : BPF_PPC_STACK_SAVE
+	 *                              [ tail_call_info    ] non optional - 64-bit powerpc
 	 *       r4_off                 [ r4 (tailcallcnt)  ] optional - 32-bit powerpc
 	 *       alt_lr_off             [ real lr (ool stub)] optional - actual lr
 	 *                              [ r26               ]
@@ -801,6 +830,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	/* Room for 64-bit tail_call_cnt */
+	bpf_frame_size += SZL;
+
+	/* Room for nvr save area */
+	bpf_frame_size += BPF_PPC_STACK_SAVE;
+
 	/* Padding to align stack frame, if any */
 	bpf_frame_size = round_up(bpf_frame_size, SZL * 2);
 
@@ -902,7 +937,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 		/* Replicate tail_call_cnt before calling the original BPF prog */
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
-			bpf_trampoline_setup_tail_call_cnt(image, ctx, func_frame_offset, r4_off);
+			bpf_trampoline_setup_tail_call_info(image, ctx, func_frame_offset,
+							   bpf_dummy_frame_size, r4_off);
 
 		/* Restore args */
 		bpf_trampoline_restore_args_stack(image, ctx, func_frame_offset, nr_regs, regs_off);
-- 
2.48.1


