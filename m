Return-Path: <linux-kselftest+bounces-48199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8797DCF3188
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A9273054379
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 10:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D2A3161AA;
	Mon,  5 Jan 2026 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J1YxI8Va"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3123168F2;
	Mon,  5 Jan 2026 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610414; cv=none; b=QAxuD3i3OrNEI6jUqiFiFCxh/blGBh7DdS/91smpJAqjHYFbEOY3PEmLGT9LPU487cI46+Y8KNF3EGuG50/kn5IkkcNADvL7AZUfwRykNDMewko1hzkmK5297hLsHJF4tNWQmvUO85UCgDeiuFR6HSRKP8hH4AbyCCM51NE98ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610414; c=relaxed/simple;
	bh=70ZsFIqBdRKJuYFjeHJbJKo32FL+Ckf1UULhaWKLoTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKTQTK3yETRUmuLDudZNsHyneXO5L0uGiQ7YGyKdkJpdNHC9KEwlxJDRNacwWPu4wh3ukMbkQvsW2H+ukuiLYIJT4+i3YUXamizmvxUom2VUR0MVgYAVgKi5JVDPuKwDAsM0g+zbkBewlET8JjFX3DvdyksRDtM4nZZNQd7lQpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J1YxI8Va; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604NPsu2016119;
	Mon, 5 Jan 2026 10:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A7Gf/k
	/vc3DEKJhPZHuVcE8mdIGmWo71nev2g6/ii8s=; b=J1YxI8Va7uF9MtXQ5+Vtof
	nofKO70/Sv6omNq0oJOBa6pndzqgnspR3g7lsmvgX08Og8yljce6ppzK0rvvJ2WZ
	oSwLNpTXUc9vyPwphbg3rxIJ0SULP92G1fmXPNRYMPSxxHYaPTvjl1qWGvwQKpre
	4tzdZXzNSfXgdB202KuhlYWrlR6dUBWrOufM7hF4kha8gecFaT07HY/GOfTJwHrZ
	JVJlNvV6+9Ue09KOnBR/cLqX0AtB33Hh5C/o8QNhguKevvx2wC5TXYJZkzEUMcDQ
	2X+UyDOLFdyu3UtMKfHC6u+HjAown5qBIvXi91FLnkMR35wEV6KZcv8GI8nyey1Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhjxep1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:52:56 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 605AqtaZ004600;
	Mon, 5 Jan 2026 10:52:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhjxeny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:52:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 605ABkfV023511;
	Mon, 5 Jan 2026 10:52:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bg3rm1vw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:52:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 605Aqo4W13369606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Jan 2026 10:52:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88D712004B;
	Mon,  5 Jan 2026 10:52:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8E1920040;
	Mon,  5 Jan 2026 10:52:44 +0000 (GMT)
Received: from abhi.. (unknown [9.124.213.127])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Jan 2026 10:52:44 +0000 (GMT)
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
Subject: [PATCH 3/6] powerpc/bpf: use BPF_PPC_STACK_SAVE to spill trampoline NVRs
Date: Mon,  5 Jan 2026 16:22:09 +0530
Message-ID: <20260105105212.136645-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260105105212.136645-1-adubey@linux.ibm.com>
References: <20260105105212.136645-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P4s3RyAu c=1 sm=1 tr=0 ts=695b9808 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=M2TuCUmZdyp0mqlJdecA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FjQ5vILT0664H1imdvC6YBdywT-tZgbg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA5NSBTYWx0ZWRfX2+9gxk17nLan
 oYCnzLdctkB7oSyuWYeIQEUVa3R8JvZrX3SKabKYJRBl0dquzbrTW6Umo2Jz8SUcGb8dOL/2WAR
 ASM4MbwoY06hFByM29cUL9DYMXbIIWLC69c+WzDXOpzVDU8GQ8nbj9uDmfoy1OzQLq1pUeZnQUx
 QwR+BvktbskDzmUur9jl9VnAKTUfnJYG7dOkv6F4mt1LPFBb++pa6lRKeVBc3dTiXrcumKbSAQP
 5bY/Lr4hdzf4Dv/S8GBzqfzW9TL95AyXdPtaYC+aQAb/98guXnxl0X1B9ZPkiaR/UdxZ5PELs3v
 v21UBIAsBvhTetWakg6hI3VfbKTCzw2Gxbh7LcqDYfHZyjZtwFvPksKJajho9LEla+9knYM2cIT
 OnV/e3rOTQ1kSAuYsGZXbu45a4IU9RFeHFrOKRRqm7QWyYRPJI/2LUWaSo41wNLBd83CBPbOyYN
 gtqNm+JfXxfRp+JwHLQ==
X-Proofpoint-GUID: YiDoRGGScWVrF20A9dn9vuEzpMfhiYIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601050095

From: Abhishek Dubey <adubey@linux.ibm.com>

In the previous patch, we introduced BPF_PPC_STACK_SAVE
into the trampoline frame to make its layout consistent
with a conventional stack frame.

The trampoline JIT currently uses NVRs R25 and R26 and
allocates dedicated stack slots to save them. This
dedicated space can be eliminated by reusing the
BPF_PPC_STACK_SAVE area instead, reducing overall stack
footprint.

The BPF_PPC_STACK_SAVE area corresponds to the register
range R26–R31. By remapping registers in the trampoline
JIT code (R25 → R26 and R26 → R27), we can spill these
registers into the existing save area and utilize the stack
more efficiently.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 4aaa0a287a45..b09d294084d4 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -512,7 +512,7 @@ static int invoke_bpf_prog(u32 *image, u32 *ro_image, struct codegen_context *ct
 
 	/* __bpf_prog_enter(p, &bpf_tramp_run_ctx) */
 	PPC_LI_ADDR(_R3, p);
-	EMIT(PPC_RAW_MR(_R25, _R3));
+	EMIT(PPC_RAW_MR(_R26, _R3));
 	EMIT(PPC_RAW_ADDI(_R4, _R1, run_ctx_off));
 	ret = bpf_jit_emit_func_call_rel(image, ro_image, ctx,
 					 (unsigned long)bpf_trampoline_enter(p));
@@ -520,7 +520,7 @@ static int invoke_bpf_prog(u32 *image, u32 *ro_image, struct codegen_context *ct
 		return ret;
 
 	/* Remember prog start time returned by __bpf_prog_enter */
-	EMIT(PPC_RAW_MR(_R26, _R3));
+	EMIT(PPC_RAW_MR(_R27, _R3));
 
 	/*
 	 * if (__bpf_prog_enter(p) == 0)
@@ -543,7 +543,7 @@ static int invoke_bpf_prog(u32 *image, u32 *ro_image, struct codegen_context *ct
 		image[ctx->idx] = ppc_inst_val(branch_insn);
 		ctx->idx++;
 	} else {
-		EMIT(PPC_RAW_LL(_R12, _R25, offsetof(struct bpf_prog, bpf_func)));
+		EMIT(PPC_RAW_LL(_R12, _R26, offsetof(struct bpf_prog, bpf_func)));
 		EMIT(PPC_RAW_MTCTR(_R12));
 		EMIT(PPC_RAW_BCTRL());
 	}
@@ -560,8 +560,8 @@ static int invoke_bpf_prog(u32 *image, u32 *ro_image, struct codegen_context *ct
 	}
 
 	/* __bpf_prog_exit(p, start_time, &bpf_tramp_run_ctx) */
-	EMIT(PPC_RAW_MR(_R3, _R25));
-	EMIT(PPC_RAW_MR(_R4, _R26));
+	EMIT(PPC_RAW_MR(_R3, _R26));
+	EMIT(PPC_RAW_MR(_R4, _R27));
 	EMIT(PPC_RAW_ADDI(_R5, _R1, run_ctx_off));
 	ret = bpf_jit_emit_func_call_rel(image, ro_image, ctx,
 					 (unsigned long)bpf_trampoline_exit(p));
@@ -748,12 +748,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *                              [ r0 save (32-bit)  ]   |
 	 * dummy frame for unwind       [ back chain 1      ] --
 	 *                              [ padding           ] align stack frame
-	 *                              [ r26..r31          ] nvr save : BPF_PPC_STACK_SAVE
+	 *       nvr_off                [ r26..r31          ] nvr save : BPF_PPC_STACK_SAVE
 	 *                              [ tail_call_info    ] non optional - 64-bit powerpc
 	 *       r4_off                 [ r4 (tailcallcnt)  ] optional - 32-bit powerpc
 	 *       alt_lr_off             [ real lr (ool stub)] optional - actual lr
-	 *                              [ r26               ]
-	 *       nvr_off                [ r25               ] nvr save area
 	 *       retval_off             [ return value      ]
 	 *                              [ reg argN          ]
 	 *                              [ ...               ]
@@ -811,10 +809,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	if (save_ret)
 		bpf_frame_size += SZL;
 
-	/* Room for nvr save area */
-	nvr_off = bpf_frame_size;
-	bpf_frame_size += 2 * SZL;
-
 	/* Optional save area for actual LR in case of ool ftrace */
 	if (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE)) {
 		alt_lr_off = bpf_frame_size;
@@ -834,6 +828,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	bpf_frame_size += SZL;
 
 	/* Room for nvr save area */
+	nvr_off = bpf_frame_size;
 	bpf_frame_size += BPF_PPC_STACK_SAVE;
 
 	/* Padding to align stack frame, if any */
@@ -897,8 +892,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	EMIT(PPC_RAW_STL(_R3, _R1, nregs_off));
 
 	/* Save nv regs */
-	EMIT(PPC_RAW_STL(_R25, _R1, nvr_off));
-	EMIT(PPC_RAW_STL(_R26, _R1, nvr_off + SZL));
+	EMIT(PPC_RAW_STL(_R26, _R1, nvr_off));
+	EMIT(PPC_RAW_STL(_R27, _R1, nvr_off + SZL));
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		PPC_LI_ADDR(_R3, (unsigned long)im);
@@ -999,8 +994,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		EMIT(PPC_RAW_LL(_R3, _R1, retval_off));
 
 	/* Restore nv regs */
-	EMIT(PPC_RAW_LL(_R26, _R1, nvr_off + SZL));
-	EMIT(PPC_RAW_LL(_R25, _R1, nvr_off));
+	EMIT(PPC_RAW_LL(_R27, _R1, nvr_off + SZL));
+	EMIT(PPC_RAW_LL(_R26, _R1, nvr_off));
 
 	/* Epilogue */
 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && !IS_ENABLED(CONFIG_PPC_KERNEL_PCREL))
-- 
2.48.1


