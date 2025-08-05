Return-Path: <linux-kselftest+bounces-38276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3C0B1AE49
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 08:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A147A23F0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 06:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7441B21B8F8;
	Tue,  5 Aug 2025 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nbQ4CISm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F821ABCF;
	Tue,  5 Aug 2025 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375338; cv=none; b=bI/pofXql/Vm6MLft50Uv+1AAIyB8J8Llc8rGCfVcZpADeeXmdKcEJLjsQYdTHSQEALRMnXzJI6pJP4QeSq6Mj0C+gVcasnCc+vtx9iF6TQ29hAfL3Dulz/ZaJj368Zm1I0CUDwEBxFyGadjFjwmEpSB6ZajWcG7J2sxiQD8Gm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375338; c=relaxed/simple;
	bh=ZabHjDmh4i7YIgeLrgzszFYG9JKkJVtEY/t5VL9A/F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zi/Cit66sZl9yCSrNETmrwtYuRAzi0aT3cCbb5ChHYpK+xU5c04Ql64dXhgYeutYSEjU2qJcEgIa/gqTf924vsp+HyqiMRhReDhnFLVmTIeh93rJOIr2aufecg8opABabkAgseHULWKjpEOCRhY8Z7/JJPlfZxCGoEmAJL5Sexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nbQ4CISm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574La2f0025639;
	Tue, 5 Aug 2025 06:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E8Lc0Ngip1RoqiiEB
	ln8K6ixMv54+IdkKqHJ/sDtX0c=; b=nbQ4CISmRuvmlL++WWK6DnKKQA/98W2Zo
	9J6ULHV9xnsvDtbpouP17tYY1FHbdKEB90wctKUKaMz6KFIfT/A1CNuavK5l6NXQ
	LPYeVySYNU4vYFRwxRJZ3agacA7V/5aNGHCuXZmnilMR+PtZ+6QZNcz0f6/oujP/
	RmpXNSWRCi6OPjl8lPbm6N1WCljQaWAlfNQobqZ2rLMet1BFPlhTnWXiXtBdgueh
	B+NduDB0z9kO4QW4qyzMbUgX9pACb69PoK8a0fy4bDtFPkO3ZSgDkz3uY6+WpzCk
	cf53nnFswg4sXSczO7qmVIqmkkbogKAsKAawWhEduraeE3B51Fu9g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ab3mrhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 06:28:30 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5756PKxN002595;
	Tue, 5 Aug 2025 06:28:29 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ab3mrh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 06:28:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5753wBFt009562;
	Tue, 5 Aug 2025 06:28:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489x0p16ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 06:28:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5756SOEk45416816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 06:28:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8C012004B;
	Tue,  5 Aug 2025 06:28:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C38B220040;
	Tue,  5 Aug 2025 06:28:17 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.39.141])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 06:28:17 +0000 (GMT)
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
Subject: [bpf-next 3/6] bpf,powerpc: Implement bpf_addr_space_cast instruction
Date: Tue,  5 Aug 2025 11:57:44 +0530
Message-ID: <20250805062747.3479221-4-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250805062747.3479221-1-skb99@linux.ibm.com>
References: <20250805062747.3479221-1-skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z+jsHGRA c=1 sm=1 tr=0 ts=6891a48e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=VdvQuQQzA1H2XN5x8tMA:9
X-Proofpoint-ORIG-GUID: FzqfjKF2M8R6OUL78a6u6CShx5cAoO1k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA0NSBTYWx0ZWRfX9VFCofYbje0H
 yrHoH402ZdAlD3kgNyY9KLTjutJk1UmoFDWEznDMd3tggsdeIQ5Dn9Z3JR7lmmSBaD/jMusme/m
 QeVw6lCpstXoVvVsi0G783MWVRHk0R4Vtq+/MoHBzS3xswzHREsEwDNM94TyZUG7vU5DpOH3iFM
 ozJf7ZjThxPN4Z1NCuil40X7+9BiPmcUlCgz+QsMyYyEtjV3ZFZtaOYLVS1HNHqY2Q357xsnP5c
 uspGCJogwP6JmYEmpFVFF9Oii+gm05H7HfSDV6FiiLj1nbTDXEEbzAkZl3LhABpk8H7VodGXg0p
 lxGoTFpnyk2r7YyQdRWDhUY/LfLOcI0Z1tEBqlGc+oh0jIljR8UG91hHEsa3VLMujXoxChGqkLO
 oRBNOHulnRWPQJqs2+Q83H/v10t9g0jtRKdeLCxUgSKpyMYSelVVtpHSOkNe+L688KC24myT
X-Proofpoint-GUID: s1Y8E__poHMixCbnWQNZaThpAmQFgGu2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 mlxlogscore=742 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050045

LLVM generates bpf_addr_space_cast instruction while translating
pointers between native (zero) address space and
__attribute__((address_space(N))). The addr_space=0 is reserved as
bpf_arena address space.

rY = addr_space_cast(rX, 0, 1) is processed by the verifier and
converted to normal 32-bit move: wX = wY.

rY = addr_space_cast(rX, 1, 0) : used to convert a bpf arena pointer to
a pointer in the userspace vma. This has to be converted by the JIT.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        |  1 +
 arch/powerpc/net/bpf_jit_comp.c   |  6 ++++++
 arch/powerpc/net/bpf_jit_comp64.c | 11 +++++++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 2d095a873305..748e30e8b5b4 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -165,6 +165,7 @@ struct codegen_context {
 	unsigned int exentry_idx;
 	unsigned int alt_exit_addr;
 	u64 arena_vm_start;
+	u64 user_vm_start;
 };
 
 #define bpf_to_ppc(r)	(ctx->b2p[r])
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 35bfdf4d8785..2b3f90930c27 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -205,6 +205,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	/* Make sure that the stack is quadword aligned. */
 	cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
 	cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux->arena);
+	cgctx.user_vm_start = bpf_arena_get_user_vm_start(fp->aux->arena);
 
 	/* Scouting faux-generate pass 0 */
 	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
@@ -441,6 +442,11 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena(void)
+{
+	return IS_ENABLED(CONFIG_PPC64);
+}
+
 bool bpf_jit_supports_far_kfunc_call(void)
 {
 	return IS_ENABLED(CONFIG_PPC64);
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 16e62766c757..d4fe4dacf2d6 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -812,6 +812,17 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		 */
 		case BPF_ALU | BPF_MOV | BPF_X: /* (u32) dst = src */
 		case BPF_ALU64 | BPF_MOV | BPF_X: /* dst = src */
+
+			if (insn_is_cast_user(&insn[i])) {
+				EMIT(PPC_RAW_RLDICL(tmp1_reg, src_reg, 0, 32));
+				PPC_LI64(dst_reg, (ctx->user_vm_start & 0xffffffff00000000UL));
+				EMIT(PPC_RAW_CMPDI(tmp1_reg, 0));
+				PPC_BCC_SHORT(COND_EQ, (ctx->idx + 2) * 4);
+				EMIT(PPC_RAW_OR(tmp1_reg, dst_reg, tmp1_reg));
+				EMIT(PPC_RAW_MR(dst_reg, tmp1_reg));
+				break;
+			}
+
 			if (imm == 1) {
 				/* special mov32 for zext */
 				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 0, 31));
-- 
2.43.5


