Return-Path: <linux-kselftest+bounces-40762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 470DCB43810
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 12:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242651B25DB3
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6912FD7B4;
	Thu,  4 Sep 2025 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eLnEGrYO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A32FA0E8;
	Thu,  4 Sep 2025 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980578; cv=none; b=lPRNMH4SCbiI8Q8y6Y8TSXgjJGV6dLANwuys3KRtSS/XYp5+tYKv1CvtM0xXmxInl8x/Zn1YeVFn2ms3FnoLctpp+Nb/VHj3jgr9pBuOasYjDLwHEOdUlcQ9hd8lQxWTLHhQcapPo31ekfMUylXg/MiTEeVTGx3I4XS09VjmSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980578; c=relaxed/simple;
	bh=uRIKl91GysIis0F+aWmzyHMJLYRMQWpZfTRWW43Qf7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qc/sD/MZp9oIG01xy8xSNo9xp6/Lr6YFqECfDLZGo3atGUlINuE1sdSUhjAcJh9IA2aXXiok7PWF5tiRbp04iAy1zTU0s3Mi/FfyienjcCC2vQuJfPOjlHNdtsUboI9cQulqiVF8lQ6tIA8gWbAYVb6k/1Q44QHxdHUkZuILESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eLnEGrYO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Ms8gs001199;
	Thu, 4 Sep 2025 10:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SO75t8E32ZyWyF9md
	P6KV1AdkCGIcYvhJZLy2lWIr6s=; b=eLnEGrYOq0muF4kZmF13uM0XeNBCFLHNc
	JHWmZdPGgGLaHMKxsoMhQO1c5u1WviUuO8qBpKDNi2W15+Hcz4u4RERy0hpMIKh1
	rLThpeu4uCV/viI2TzQVqALxAOn1qkhGFgOyork3ID5HA6ZRq/kSt7WUZ7lzJEt7
	1y0O4sUCrZKpBRrAFaD9aEbh1KkKG0NB6zvERLbLw3rfsEeHyqKz7Zz71hKvRqG6
	2+HYnEyXzrcrwrc5lBSrQxdaRqrVLjLqKWjPBqtoZQt+HZjfTD9n6VgV+kpVaEcN
	kJdsMmm47IyMtqbi3hsXsUG3KlUYrrNl5o3FvFbC8+7EPskzXXrCA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshf573x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 10:09:05 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 584A94LA011517;
	Thu, 4 Sep 2025 10:09:04 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshf573u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 10:09:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584711Qi017222;
	Thu, 4 Sep 2025 10:09:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vc10v2vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 10:09:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584A90V346596466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 10:09:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62BF72007B;
	Thu,  4 Sep 2025 10:09:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E008B20067;
	Thu,  4 Sep 2025 10:08:55 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.in.ibm.com (unknown [9.109.219.153])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 10:08:55 +0000 (GMT)
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
Subject: [PATCH bpf-next v3 4/4] powerpc64/bpf: Implement PROBE_ATOMIC instructions
Date: Thu,  4 Sep 2025 15:38:35 +0530
Message-ID: <20250904100835.1100423-5-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250904100835.1100423-1-skb99@linux.ibm.com>
References: <20250904100835.1100423-1-skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xo9cL5xBECnU35L6Fv5kpH-1kX0VkmW9
X-Authority-Analysis: v=2.4 cv=do3bC0g4 c=1 sm=1 tr=0 ts=68b96541 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=A3AlPsS74hsQCGrZRX4A:9
X-Proofpoint-ORIG-GUID: y3DJb659C20TPRkMeHBu-52wcY6O0bLO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA0MCBTYWx0ZWRfX2Pz6il/Zb9VI
 wjnoqg/yXP40uJES/vFDwJeruCJ+N1rZTVP5Us8hXhJzdDFFnjYURXyXWEA5WZXvg7OgUL7umHl
 L7dZtvbkJY684ir09zUuwqSKFsPHNO2crrmH+GLfJLkKJbWFnoXSTVHc3nQQCgOj3AiWwc8IMa9
 jo3zhyWs6UqRVTrcgg0Zb1hCl9GcP+MR6joNVj5B50YN1qTmnsRwirJZn2HICz3BzPVUaInsW9X
 resTTJGqKsFZjz6ZZuwU4TUjlnybx38Fog8DIRq5SGoFZzomtysVMFpugxyMjGeRMs9Ndh3K8yT
 C+u/p46HabZJuoNrXLHMVmWCRAfljoFnADJq9Kh6Fxr3DYTkJygdT/dYMGEpFCm1j8/7n/TwLDZ
 JNj5Go5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020040

powerpc supports BPF atomic operations using a loop around
Load-And-Reserve(LDARX/LWARX) and Store-Conditional(STDCX/STWCX)
instructions gated by sync instructions to enforce full ordering.

To implement arena_atomics, arena vm start address is added to the
dst_reg to be used for both the LDARX/LWARX and STDCX/STWCX instructions.
Further, an exception table entry is added for LDARX/LWARX
instruction to land after the loop on fault. At the end of sequence,
dst_reg is restored by subtracting arena vm start address.

bpf_jit_supports_insn() is introduced to selectively enable instruction
support as in other architectures like x86 and arm64.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c   | 16 ++++++++++++++++
 arch/powerpc/net/bpf_jit_comp64.c | 26 ++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index cfa84cab0a18..88ad5ba7b87f 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -450,6 +450,22 @@ bool bpf_jit_supports_far_kfunc_call(void)
 	return IS_ENABLED(CONFIG_PPC64);
 }
 
+bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
+{
+	if (!in_arena)
+		return true;
+	switch (insn->code) {
+	case BPF_STX | BPF_ATOMIC | BPF_H:
+	case BPF_STX | BPF_ATOMIC | BPF_B:
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
+		if (bpf_atomic_is_load_store(insn))
+			return false;
+		return IS_ENABLED(CONFIG_PPC64);
+	}
+	return true;
+}
+
 void *arch_alloc_bpf_trampoline(unsigned int size)
 {
 	return bpf_prog_pack_alloc(size, bpf_jit_fill_ill_insns);
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index cb4d1e954961..1fe37128c876 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1163,6 +1163,32 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 
 			break;
 
+		/*
+		 * BPF_STX PROBE_ATOMIC (arena atomic ops)
+		 */
+		case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
+		case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
+			EMIT(PPC_RAW_ADD(dst_reg, dst_reg, bpf_to_ppc(ARENA_VM_START)));
+			ret = bpf_jit_emit_atomic_ops(image, ctx, &insn[i],
+						      &jmp_off, &tmp_idx, &addrs[i + 1]);
+			if (ret) {
+				if (ret == -EOPNOTSUPP) {
+					pr_err_ratelimited(
+						"eBPF filter atomic op code %02x (@%d) unsupported\n",
+						code, i);
+				}
+				return ret;
+			}
+			/* LDARX/LWARX should land here on exception. */
+			ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx,
+						    tmp_idx, jmp_off, dst_reg, code);
+			if (ret)
+				return ret;
+
+			/* Retrieve the dst_reg */
+			EMIT(PPC_RAW_SUB(dst_reg, dst_reg, bpf_to_ppc(ARENA_VM_START)));
+			break;
+
 		/*
 		 * BPF_STX ATOMIC (atomic ops)
 		 */
-- 
2.43.5


