Return-Path: <linux-kselftest+bounces-40325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B6EB3C149
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 18:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06BA1CC44B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99A833EB0C;
	Fri, 29 Aug 2025 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LEBuRd14"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0739879CD;
	Fri, 29 Aug 2025 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486406; cv=none; b=JyXpvdbOj1A4Hy60zKqn7SLPMT7U0f6KhGP0cnwGBj2xAfP5uLS3/MJ7luUA7WrbLf4CkREKlqCe/z+C6E3pA7Vgihp4CU/WiPCJuzdLlY6tPmwB5nI059hO625ZUffH9rHFCKU9qEaRTCrmHrqcLju/ubs+cVgvGxqdUtamAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486406; c=relaxed/simple;
	bh=Apq2EUTqIm9H2LVUovIpzZr3gu+jmOhkPwR4lUaqO+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qi8wy5HygsqaCNPyAGmqUMVxkqHe37DH0JJ5qvv4XEUnL6Jx5rV5uGdwpha6KOeLBiFeZGrL/HOEfICJoRV9SG4LZqmp+Jnnu0Cc3tDoqt5yiqjnISo0oKGV8YyUXAu2dJ/MR6ADu/OeNWZtd4nAbGnUSyqqWinPpP1Mzx04o+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LEBuRd14; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T9IRrC020847;
	Fri, 29 Aug 2025 16:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=x/jB12xFw5RluKVHq
	9ZunPozyBFjcsDnMzg9TwLzyws=; b=LEBuRd14SLWfpwUYLdIeRrjxmb5t9mhiY
	vMNzihNCcPb8PNsv7bC+xLJodUuaiJTVO/rSbN4pGvex3uWLbsvkZYUh6JLO4Uv4
	ms4lVwayx1kEQT9fe3iEsF4ygAnjgDIbK9EV5G5nX820DhONuUpu68mQ+Tn8Vk+1
	RLL7f2h/uzdbG2alDYoRiMLbFYlkwJZCNemqHnRWMHZik7DkFFlhj9URwuU5Uirn
	gekQdF79I6X9Lys5d977JG0KA64F+SFY5sCk8YUyPDfkgcpqQT3YC1gziT42FoMw
	Ymzz4Xooy6Y5YXeiSzABkineFXQPVtOksIkdOfrs51n5k3RWMcZ+w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5hqgeb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 16:52:51 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57TGqoO4017235;
	Fri, 29 Aug 2025 16:52:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5hqgeb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 16:52:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57TFBaAb002520;
	Fri, 29 Aug 2025 16:52:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qryq2q6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 16:52:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57TGqkO044761472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 16:52:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E308C2004B;
	Fri, 29 Aug 2025 16:52:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 006EB20040;
	Fri, 29 Aug 2025 16:52:34 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.115.92])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Aug 2025 16:52:33 +0000 (GMT)
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
Subject: [PATCH bpf-next v2 4/5] powerpc64/bpf: Implement PROBE_ATOMIC instructions
Date: Fri, 29 Aug 2025 22:21:34 +0530
Message-ID: <20250829165135.1273071-5-skb99@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX30oyvMQx4kR9
 4/kjfuXKqzrAgx3E6pCsqZhDNqP97j6Bsrxmqk06TuDbVvueaOXV//W94RUVbZ09pHFuJyZijd0
 CT/oW8gN8lxnlJp6zVclUk0dz59sIr/qiYu5/X3FU6D81QQO8MBchuvYp7q4fLIJBVuJ/kY7gXc
 59STubPrhOtWsZ2iWdFo7yHhfCQJ0LRkRIUVGhnWuDrRkJwI9egFAL78P6Odj3YNTK6MFWLRRlt
 QMRgsoVDf1G2/MMcorGTc0vWlwBGdP7PrbqFmaOUHZC6PGqbVtyy8rPh+Fl/ETi6NimhGqOZaEr
 uQirV3ai4DJk7SiI6Y8i/8H8rDDvnRsOjko6RBturRotoFvOuvSLSJv+ZiMqhzwolKiJDJfM0oc
 Y2ZuoCXC
X-Proofpoint-ORIG-GUID: IBO8xZK8AzIwnId52vpmyAULqXYAFSpr
X-Proofpoint-GUID: KlE1hyIQaQDV0pSgVNEV3JuNC_ULirB_
X-Authority-Analysis: v=2.4 cv=Ndbm13D4 c=1 sm=1 tr=0 ts=68b1dae3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=I9DJoMOgBESJXZyRRMQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

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


