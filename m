Return-Path: <linux-kselftest+bounces-38275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD287B1AE42
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 08:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEE117ABD1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 06:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A452821CA08;
	Tue,  5 Aug 2025 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iW5gap1j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2930621B8F8;
	Tue,  5 Aug 2025 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375328; cv=none; b=pYOR7n3pVh9p5FeJbWr1SRBtups9maIbGvHXMin9xz/kgUJp2nPedRtwEkz/JtWisoj7cWpos6RxYpkH5OSPgEu022zg6YFJYVTuhruwA/U/JD5wR0gLMQZ3Kbj7c5+pupnEWWJohvUVxhEnnz7RUHkyBfyV715cnD+eJOclBUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375328; c=relaxed/simple;
	bh=m97caxu1X1PorNK+MqH+IP5t1zAlubzSAdABUDQQ34U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/hW+Wje9qKeJaDZjGr5hO8+PTJNXh/nQx4PNkCJIm/WwHZJP529Zp7hEclGUw8nYUA2QinVNiaPpY/RyPEoQMwsInSVxl5FAkDqTmOLRwdPVTvMOC2VlcRTZpGe9OY+NzRKaGcUdBdEfIMl1/Q/gYqRc/FAiQJmYYuDhOF6N/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iW5gap1j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574KjP3B029477;
	Tue, 5 Aug 2025 06:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HfhNwHkRSVaSKEM6e
	1J/vnxoAUadG1VytPuvWMsPSdM=; b=iW5gap1jZJHlCk8FPBBy+Og2TWcObnqnw
	ssO3v0yxie+WdUKcJjkdBgeMXSSp9HUbxNZN6UhbpcDP1FUEh5PkTXH8Boaft2my
	CzwIAqgwJyVHAj8JI9hdBpCRDJTHWzCjhNSFaWxwVCOXPc7NOvIrWW1yIr9esOgC
	HFGIAgaSBr6vihtiEGbibxYPDUccxKGzeyY85Ao/5pdFPPFvf0YfehFcuvFFNdvV
	s7lWCJnGC7dbMLk8OEbbI01LiCNOx0jJJLCikCgJ0rhPXrM1Xrzw6ik/2sgKdkGx
	WLGTo+ex3kkVCeR6X3w7dvxCwj4KByaV18RpMdvB/+DroHsCtvUvQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4aa0td5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 06:28:15 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5756HoJu021315;
	Tue, 5 Aug 2025 06:28:14 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4aa0td1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 06:28:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5754f5uL001542;
	Tue, 5 Aug 2025 06:28:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 489y7ks10g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 06:28:13 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5756S9xv51380488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 06:28:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D788620040;
	Tue,  5 Aug 2025 06:28:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE2D420043;
	Tue,  5 Aug 2025 06:28:02 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.39.141])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 06:28:02 +0000 (GMT)
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
Subject: [bpf-next 1/6] bpf,powerpc: Introduce bpf_jit_emit_probe_mem_store() to emit store instructions
Date: Tue,  5 Aug 2025 11:57:42 +0530
Message-ID: <20250805062747.3479221-2-skb99@linux.ibm.com>
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
X-Proofpoint-GUID: CUuaPoBERhcFskGYnC0ub0cAgoTHhzdP
X-Authority-Analysis: v=2.4 cv=dNummPZb c=1 sm=1 tr=0 ts=6891a47f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=ZRMFVuExfS53ZnwnCJ4A:9
X-Proofpoint-ORIG-GUID: JzARWKijZQTX1fZ4J85RUQnXouNe7SPW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA0NSBTYWx0ZWRfX0ENfDfgj0Yjq
 EgcNWuRtzGHzQZTZOC3aupYIkdrT8UjwrOop84pJa9XRQMmwiV2HEcyLDgeyK1t3bjpZo3sYtsF
 y1DLTObRHQ4BwNiZhZxPmVsTOzoWDDGp/Js3x2retZbU6acbuh+ZUJupG4z6X4GroucpAl6QeoO
 EwlHFoE2uXr2fsmmdUspLGvhAMRf5eamve9Yzlj6BOLtZVkKeIDX4ofYrE5rgIsLhUioqRP5grl
 PoZ4TvOBW1sXHIUHpDfcg7/jBa1GG73FSrrc1Bz+DMRQ1EMJW3HcsNC1hw8MSM2mZGN5Ef85HrX
 ZKuSgjyPPO4lqCJdlkpboE/j4llzxM9TT07a7cbylJMHER3bWCkOpURyci3XrslCu5CV1hWWO7H
 ZiSA1xgeYtfH1SZLpuYGXV8UkTc7npnu8IoqCZfdUPtb6ztT6+c1WSTM1HHIRyaJblN6JFul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=813
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050045

bpf_jit_emit_probe_mem_store() is introduced to emit instructions for
storing memory values depending on the size (byte, halfword,
word, doubleword).

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 025524378443..489de21fe3d6 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -409,6 +409,36 @@ asm (
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
-- 
2.43.5


