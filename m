Return-Path: <linux-kselftest+bounces-48923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8E3D1E804
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 12:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5ABD301E6E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 11:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B187D395DBF;
	Wed, 14 Jan 2026 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aBxUDYRC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D3238946E;
	Wed, 14 Jan 2026 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391174; cv=none; b=mm5m39bvjEHk3ABV7S+OL91mCG6rLOuoVzz35Yx2BW4razLvzNW2SpRGwD/9e+xgAHyMMjvGUxldgq0l700vhCBt/GfIhUDj9Wiaib2dsGGPXXGAbm2/JkFfynsWgVXK5A9Tr6F8W6J8wYomNhj/m0OYv/z3vHn51dQx/S/nIPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391174; c=relaxed/simple;
	bh=NKE3sgZj5OUww0WKMLWZQX1nBW/XxdZKqirXNsXcPRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zl6q/JIR28h4HiyluWVHbwfRoYe9HUsTYzqZe1rfg23ItCEpge7nwtpk3b+bd9pWUOdosprICY5wjs3RzgFb6Rl2zmxwHo+MXAwk2J06mW5fux2F+NQu3JkVsajxGgz+j4C3PeB0opdIKATWcfy556eQeLMD8c/VjUbIsoR1os0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aBxUDYRC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60E5lWfp014533;
	Wed, 14 Jan 2026 11:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=c8eQyPKRkd8c6VjdL
	eEJNDRNEf6o7S8YixflG/EnmM4=; b=aBxUDYRCXlC8u2/A7SYkVASiqkCKVCKan
	b90kL9HSFcIACCwZn3dVcIUMaAAtna5BN7EVMUUpy7nXil8wQVzDKZlC+Wvcg8dF
	zNBEefgk2Myd+Amaa3KAo743mygOnUJLDRGBfNQf+4ONcJpBRMr2qO92xSECqbQD
	iV/PLxLuhAlkJypAam1ldPd5Ra7tbYbcjOn6NnOcaFI2xpyRcVMVOF/dfe0xCsFa
	wzPqjAMJcOhLDbhXXe8kfxyjdVSokw6x89rMao1Bt9ClWFnjuxAYShDEL5hmDoFY
	ZZOm1bxEEQl1bq8oReCdxxW2IwPz2s5Fka/wG63jVui32dQWJ7ttA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeeq1609-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 11:45:29 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60EBbs0V014054;
	Wed, 14 Jan 2026 11:45:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeeq1604-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 11:45:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60E861nE030153;
	Wed, 14 Jan 2026 11:45:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3ajskpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 11:45:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60EBjNwp36438300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 11:45:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A06F20043;
	Wed, 14 Jan 2026 11:45:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B27020040;
	Wed, 14 Jan 2026 11:45:17 +0000 (GMT)
Received: from abhi.. (unknown [9.124.217.65])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jan 2026 11:45:16 +0000 (GMT)
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
Subject: [PATCH v2 1/6] powerpc64/bpf: Move tail_call_cnt to bottom of stack frame
Date: Wed, 14 Jan 2026 17:14:45 +0530
Message-ID: <20260114114450.30405-2-adubey@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=DI6CIiNb c=1 sm=1 tr=0 ts=696781d9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Rb3EU3fDdKp9F2ZL6qEA:9
X-Proofpoint-GUID: duOXHOgd6VJMcHvJXhnqevS465Fy2KGf
X-Proofpoint-ORIG-GUID: cNXRZn3RtYxd44cGYlgZnjNCbQ-82IKv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfX4CtxT/ZD5X2s
 tcdTVzLp+Sr/51KXX4z2mBk4D9/pFaY8f/44K+lWNpxHFtaM/awMceJuwpCkuYjAeiHkmwpxYNe
 UCuhUF4gQqQxlnR3gOLHb6OSytuj6P/c9dhG8bdn14zQztIc4nMf/jaWOZcMcD7WL+VZC26MLfU
 7gMhrFSvm+KVvvIz1z3y9Qm9/CPpsCbmtBTcHFuTL+F4ulnjs7LWzZPZ38BGj6i+t9yCUwNYGSU
 po6YeHmkyuKWdp2fmuqsXxHYLey1tXVuRKMovVI3A7KWS/CcsJmN+mXsK8yM12SqVMl3Y59AQ7K
 9ZtAkOJChw8nXpQ3VpybM45D+bVgHFdyEnMr9kKGczyOQOmN4ELsRi0Jg2ib2332IhykUWBsTj6
 K0+4metr3Qdv2gdsRWnC7+lBoT4yQUKTjYh5PLXHOt3xzgFGO4KBllcwcQkYuzZTuNsmFZky6nh
 dkP6gSOX635PVHrQ68w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601140093

From: Abhishek Dubey <adubey@linux.ibm.com>

In the conventional stack frame, the position of tail_call_cnt
is after the NVR save area (BPF_PPC_STACK_SAVE). Whereas, the
offset of tail_call_cnt in the trampoline frame is after the
stack alignment padding. BPF JIT logic could become complex
when dealing with frame-sensitive offset calculation of
tail_call_cnt. Having the same offset in both frames is the
desired objective.

The trampoline frame does not have a BPF_PPC_STACK_SAVE area.
Introducing it leads to under-utilization of extra memory meant
only for the offset alignment of tail_call_cnt.
Another challenge is the variable alignment padding sitting at
the bottom of the trampoline frame, which requires additional
handling to compute tail_call_cnt offset.

This patch addresses the above issues by moving tail_call_cnt
to the bottom of the stack frame at offset 0 for both types
of frames. This saves additional bytes required by BPF_PPC_STACK_SAVE
in trampoline frame, and a common offset computation for
tail_call_cnt serves both frames.

The changes in this patch are required by the third patch in the
series, where the 'reference to tail_call_info' of the main frame
is copied into the trampoline frame from the previous frame.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        |  4 ++++
 arch/powerpc/net/bpf_jit_comp64.c | 31 ++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 8334cd667bba..45d419c0ee73 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -72,6 +72,10 @@
 	} } while (0)
 
 #ifdef CONFIG_PPC64
+
+/* for tailcall counter */
+#define BPF_PPC_TAILCALL        8
+
 /* If dummy pass (!image), account for maximum possible instructions */
 #define PPC_LI64(d, i)		do {					      \
 	if (!image)							      \
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 1fe37128c876..39061cd742c1 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -20,13 +20,15 @@
 #include "bpf_jit.h"
 
 /*
- * Stack layout:
+ * Stack layout 1:
+ * Layout when setting up our own stack frame.
+ * Note: r1 at bottom, component offsets positive wrt r1.
  * Ensure the top half (upto local_tmp_var) stays consistent
  * with our redzone usage.
  *
  *		[	prev sp		] <-------------
- *		[   nv gpr save area	] 6*8		|
  *		[    tail_call_cnt	] 8		|
+ *		[   nv gpr save area	] 6*8		|
  *		[    local_tmp_var	] 24		|
  * fp (r31) -->	[   ebpf stack space	] upto 512	|
  *		[     frame header	] 32/112	|
@@ -36,10 +38,12 @@
 /* for gpr non volatile registers BPG_REG_6 to 10 */
 #define BPF_PPC_STACK_SAVE	(6*8)
 /* for bpf JIT code internal usage */
-#define BPF_PPC_STACK_LOCALS	32
+#define BPF_PPC_STACK_LOCALS	24
 /* stack frame excluding BPF stack, ensure this is quadword aligned */
 #define BPF_PPC_STACKFRAME	(STACK_FRAME_MIN_SIZE + \
-				 BPF_PPC_STACK_LOCALS + BPF_PPC_STACK_SAVE)
+				 BPF_PPC_STACK_LOCALS + \
+				 BPF_PPC_STACK_SAVE   + \
+				 BPF_PPC_TAILCALL)
 
 /* BPF register usage */
 #define TMP_REG_1	(MAX_BPF_JIT_REG + 0)
@@ -87,27 +91,32 @@ static inline bool bpf_has_stack_frame(struct codegen_context *ctx)
 }
 
 /*
+ * Stack layout 2:
  * When not setting up our own stackframe, the redzone (288 bytes) usage is:
+ * Note: r1 from prev frame. Component offset negative wrt r1.
  *
  *		[	prev sp		] <-------------
  *		[	  ...       	] 		|
  * sp (r1) --->	[    stack pointer	] --------------
- *		[   nv gpr save area	] 6*8
  *		[    tail_call_cnt	] 8
+ *		[   nv gpr save area	] 6*8
  *		[    local_tmp_var	] 24
  *		[   unused red zone	] 224
  */
 static int bpf_jit_stack_local(struct codegen_context *ctx)
 {
-	if (bpf_has_stack_frame(ctx))
+	if (bpf_has_stack_frame(ctx)) {
+		/* Stack layout 1 */
 		return STACK_FRAME_MIN_SIZE + ctx->stack_size;
-	else
-		return -(BPF_PPC_STACK_SAVE + 32);
+	} else {
+		/* Stack layout 2 */
+		return -(BPF_PPC_TAILCALL + BPF_PPC_STACK_SAVE + BPF_PPC_STACK_LOCALS);
+	}
 }
 
 static int bpf_jit_stack_tailcallcnt(struct codegen_context *ctx)
 {
-	return bpf_jit_stack_local(ctx) + 24;
+	return bpf_jit_stack_local(ctx) + BPF_PPC_STACK_LOCALS + BPF_PPC_STACK_SAVE;
 }
 
 static int bpf_jit_stack_offsetof(struct codegen_context *ctx, int reg)
@@ -115,7 +124,7 @@ static int bpf_jit_stack_offsetof(struct codegen_context *ctx, int reg)
 	if (reg >= BPF_PPC_NVR_MIN && reg < 32)
 		return (bpf_has_stack_frame(ctx) ?
 			(BPF_PPC_STACKFRAME + ctx->stack_size) : 0)
-				- (8 * (32 - reg));
+				- (8 * (32 - reg)) - BPF_PPC_TAILCALL;
 
 	pr_err("BPF JIT is asking about unknown registers");
 	BUG();
@@ -145,7 +154,7 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 	if (ctx->seen & SEEN_TAILCALL) {
 		EMIT(PPC_RAW_LI(bpf_to_ppc(TMP_REG_1), 0));
 		/* this goes in the redzone */
-		EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, -(BPF_PPC_STACK_SAVE + 8)));
+		EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, -(BPF_PPC_TAILCALL)));
 	} else {
 		EMIT(PPC_RAW_NOP());
 		EMIT(PPC_RAW_NOP());
-- 
2.48.1


