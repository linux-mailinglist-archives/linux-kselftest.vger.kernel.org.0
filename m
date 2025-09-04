Return-Path: <linux-kselftest+bounces-40761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB60B43802
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 12:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBEA587274
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE782FB982;
	Thu,  4 Sep 2025 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HmRD9huR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7914D2FB617;
	Thu,  4 Sep 2025 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980569; cv=none; b=YvTtPnguGrNDt4r66i4FzE7WVtvp6E/Lr142+wCrDFEkrXDezKwpYZ+0FFygcpHfkkGhOWpokIzR+Uj6kzpt6cSzBBmTRbHbjWlccY0Cchs2MYaFoMyghIb90kgLsReeVz7wRizmqwzqeQHjzmhjTqzVa3MnuY/dt9pZkn6x0zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980569; c=relaxed/simple;
	bh=YHAMu6/HlQVwC0YoIiF0tw5GwjmHS71RF1r+KC32kkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEYeqeb4kyWtlW0LraZ9UzcA5RW6maqfhJYqMgqJh7AKRcwsTsUUM9i1VQYG2c42mEF5wgLQzeY6rstBcP5+yMbePRHlpWd+3Y9VdBdTT0gfGECwlEuXClTEoeOWFSgE+cJtc+cWWNIyHksu2mzfYPXrO8kp8VSqh0QFQPzbd+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HmRD9huR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5845GWWr000630;
	Thu, 4 Sep 2025 10:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nq8JSKiiPFTsIFHiD
	YqjP1PPXZwW5GQOluTo+j7V/Co=; b=HmRD9huR1pqLhViI8/ywMiYgQ4O5d9+Mg
	TjZ/4wTrDAqaQtuO6h7hv+LPFWGwVmLKPHf7bBsr6G1Nt4y0j/K26tmMnSnOGnAU
	4QW7bMyaBAuC9VWIBBK6UwXTRTZAw1Th4e020HCMRc2AiCoNDdZbLonjPsITVY1k
	2kt4cU+pOF/cG23JKzXMedGSJXYQJLYkqoLwU3+tQkZNDfXRT39eppqtRiDyOnhY
	GS6ZEobPeFYFjqtEz7H9mVJCB9uTZoeVhys7FGS35s+Cf12H6gIb3DtVF4WGWAWN
	L4DhFUl9T4j+WxKcDkPN690gLXQ8ThFE6ok15YrueE8FnPtks7Mow==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usur9j8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 10:09:01 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5849xWYv012543;
	Thu, 4 Sep 2025 10:09:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usur9j8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 10:09:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5848D3QD019404;
	Thu, 4 Sep 2025 10:08:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4n3ugy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 10:08:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584A8t8X43712804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 10:08:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98B3C2007A;
	Thu,  4 Sep 2025 10:08:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E74920067;
	Thu,  4 Sep 2025 10:08:51 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.in.ibm.com (unknown [9.109.219.153])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 10:08:50 +0000 (GMT)
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
Subject: [PATCH bpf-next v3 3/4] powerpc64/bpf: Introduce bpf_jit_emit_atomic_ops() to emit atomic instructions
Date: Thu,  4 Sep 2025 15:38:34 +0530
Message-ID: <20250904100835.1100423-4-skb99@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfXx6RM82/7Wg9t
 yZU9II2K/TpZ9D+otIccFJAx9geBnNxE1ZfuO6lZ6atQWKRFqqaVlwuDZX7p7gkPRjg8wbqAsjU
 ezz+14lDIJXQxO4NpW8DPv7npHPs1yBJLWn16/2x0Koysg8yljtXU++QG1j0USSY7wij/xIoVXj
 RJ+Syq+W/2newa6CRv12tB9/FB2tpCvj5aYdCyDHslOfVsWmoBH8iRs7B/aAy0KXganfb3kYPOO
 +Bk/HdblVdK2zzl2ZCfFefaWGRFu/DZ+LKfsV6DBG0b4aqo0VyH+iZAHEHdHmsmyC5jAPeG1Anh
 8OwLXPMTrlFph/QEaiuyJP1pJRbUBGJyHEKr5mjNI49ZcKfAoipr4lKmdpOZRefFCm+VCzPql2X
 SduiJBoo
X-Proofpoint-GUID: t0oIgLrgz744OdEGuEPHSqxriJgOmKhX
X-Proofpoint-ORIG-GUID: GcQ4UGKz4Z29fYzi6LnqofN_iL_X6J0s
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68b9653d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=mLi99PhJ1kaOFlELNpEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

The existing code for emitting bpf atomic instruction sequences for
atomic operations such as XCHG, CMPXCHG, ADD, AND, OR, and XOR has been
refactored into a reusable function, bpf_jit_emit_ppc_atomic_op().
It also computes the jump offset and tracks the instruction index for jited
LDARX/LWARX to be used in case it causes a fault.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 203 +++++++++++++++++-------------
 1 file changed, 115 insertions(+), 88 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 76efb47f02a6..cb4d1e954961 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -423,6 +423,111 @@ asm (
 "		blr				;"
 );
 
+static int bpf_jit_emit_atomic_ops(u32 *image, struct codegen_context *ctx,
+				   const struct bpf_insn *insn, u32 *jmp_off,
+				   u32 *tmp_idx, u32 *addrp)
+{
+	u32 tmp1_reg = bpf_to_ppc(TMP_REG_1);
+	u32 tmp2_reg = bpf_to_ppc(TMP_REG_2);
+	u32 size = BPF_SIZE(insn->code);
+	u32 src_reg = bpf_to_ppc(insn->src_reg);
+	u32 dst_reg = bpf_to_ppc(insn->dst_reg);
+	s32 imm = insn->imm;
+
+	u32 save_reg = tmp2_reg;
+	u32 ret_reg = src_reg;
+	u32 fixup_idx;
+
+	/* Get offset into TMP_REG_1 */
+	EMIT(PPC_RAW_LI(tmp1_reg, insn->off));
+       /*
+	* Enforce full ordering for operations with BPF_FETCH by emitting a 'sync'
+	* before and after the operation.
+	*
+	* This is a requirement in the Linux Kernel Memory Model.
+	* See __cmpxchg_u64() in asm/cmpxchg.h as an example.
+	*/
+	if ((imm & BPF_FETCH) && IS_ENABLED(CONFIG_SMP))
+		EMIT(PPC_RAW_SYNC());
+
+	*tmp_idx = ctx->idx;
+
+	/* load value from memory into TMP_REG_2 */
+	if (size == BPF_DW)
+		EMIT(PPC_RAW_LDARX(tmp2_reg, tmp1_reg, dst_reg, 0));
+	else
+		EMIT(PPC_RAW_LWARX(tmp2_reg, tmp1_reg, dst_reg, 0));
+	/* Save old value in _R0 */
+	if (imm & BPF_FETCH)
+		EMIT(PPC_RAW_MR(_R0, tmp2_reg));
+
+	switch (imm) {
+	case BPF_ADD:
+	case BPF_ADD | BPF_FETCH:
+		EMIT(PPC_RAW_ADD(tmp2_reg, tmp2_reg, src_reg));
+		break;
+	case BPF_AND:
+	case BPF_AND | BPF_FETCH:
+		EMIT(PPC_RAW_AND(tmp2_reg, tmp2_reg, src_reg));
+		break;
+	case BPF_OR:
+	case BPF_OR | BPF_FETCH:
+		EMIT(PPC_RAW_OR(tmp2_reg, tmp2_reg, src_reg));
+		break;
+	case BPF_XOR:
+	case BPF_XOR | BPF_FETCH:
+		EMIT(PPC_RAW_XOR(tmp2_reg, tmp2_reg, src_reg));
+		break;
+	case BPF_CMPXCHG:
+	       /*
+		* Return old value in BPF_REG_0 for BPF_CMPXCHG &
+		* in src_reg for other cases.
+		*/
+		ret_reg = bpf_to_ppc(BPF_REG_0);
+
+		/* Compare with old value in BPF_R0 */
+		if (size == BPF_DW)
+			EMIT(PPC_RAW_CMPD(bpf_to_ppc(BPF_REG_0), tmp2_reg));
+		else
+			EMIT(PPC_RAW_CMPW(bpf_to_ppc(BPF_REG_0), tmp2_reg));
+		/* Don't set if different from old value */
+		PPC_BCC_SHORT(COND_NE, (ctx->idx + 3) * 4);
+		fallthrough;
+	case BPF_XCHG:
+		save_reg = src_reg;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	/* store new value */
+	if (size == BPF_DW)
+		EMIT(PPC_RAW_STDCX(save_reg, tmp1_reg, dst_reg));
+	else
+		EMIT(PPC_RAW_STWCX(save_reg, tmp1_reg, dst_reg));
+	/* we're done if this succeeded */
+	PPC_BCC_SHORT(COND_NE, *tmp_idx * 4);
+	fixup_idx = ctx->idx;
+
+	if (imm & BPF_FETCH) {
+		/* Emit 'sync' to enforce full ordering */
+		if (IS_ENABLED(CONFIG_SMP))
+			EMIT(PPC_RAW_SYNC());
+		EMIT(PPC_RAW_MR(ret_reg, _R0));
+		/*
+		 * Skip unnecessary zero-extension for 32-bit cmpxchg.
+		 * For context, see commit 39491867ace5.
+		 */
+		if (size != BPF_DW && imm == BPF_CMPXCHG &&
+		    insn_is_zext(insn + 1))
+			*addrp = ctx->idx * 4;
+	}
+
+	*jmp_off = (fixup_idx - *tmp_idx) * 4;
+
+	return 0;
+}
+
 static int bpf_jit_emit_probe_mem_store(struct codegen_context *ctx, u32 src_reg, s16 off,
 					u32 code, u32 *image)
 {
@@ -538,7 +643,6 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		u32 size = BPF_SIZE(code);
 		u32 tmp1_reg = bpf_to_ppc(TMP_REG_1);
 		u32 tmp2_reg = bpf_to_ppc(TMP_REG_2);
-		u32 save_reg, ret_reg;
 		s16 off = insn[i].off;
 		s32 imm = insn[i].imm;
 		bool func_addr_fixed;
@@ -546,6 +650,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		u64 imm64;
 		u32 true_cond;
 		u32 tmp_idx;
+		u32 jmp_off;
 
 		/*
 		 * addrs[] maps a BPF bytecode address into a real offset from
@@ -1080,93 +1185,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 				return -EOPNOTSUPP;
 			}
 
-			save_reg = tmp2_reg;
-			ret_reg = src_reg;
-
-			/* Get offset into TMP_REG_1 */
-			EMIT(PPC_RAW_LI(tmp1_reg, off));
-			/*
-			 * Enforce full ordering for operations with BPF_FETCH by emitting a 'sync'
-			 * before and after the operation.
-			 *
-			 * This is a requirement in the Linux Kernel Memory Model.
-			 * See __cmpxchg_u64() in asm/cmpxchg.h as an example.
-			 */
-			if ((imm & BPF_FETCH) && IS_ENABLED(CONFIG_SMP))
-				EMIT(PPC_RAW_SYNC());
-			tmp_idx = ctx->idx * 4;
-			/* load value from memory into TMP_REG_2 */
-			if (size == BPF_DW)
-				EMIT(PPC_RAW_LDARX(tmp2_reg, tmp1_reg, dst_reg, 0));
-			else
-				EMIT(PPC_RAW_LWARX(tmp2_reg, tmp1_reg, dst_reg, 0));
-
-			/* Save old value in _R0 */
-			if (imm & BPF_FETCH)
-				EMIT(PPC_RAW_MR(_R0, tmp2_reg));
-
-			switch (imm) {
-			case BPF_ADD:
-			case BPF_ADD | BPF_FETCH:
-				EMIT(PPC_RAW_ADD(tmp2_reg, tmp2_reg, src_reg));
-				break;
-			case BPF_AND:
-			case BPF_AND | BPF_FETCH:
-				EMIT(PPC_RAW_AND(tmp2_reg, tmp2_reg, src_reg));
-				break;
-			case BPF_OR:
-			case BPF_OR | BPF_FETCH:
-				EMIT(PPC_RAW_OR(tmp2_reg, tmp2_reg, src_reg));
-				break;
-			case BPF_XOR:
-			case BPF_XOR | BPF_FETCH:
-				EMIT(PPC_RAW_XOR(tmp2_reg, tmp2_reg, src_reg));
-				break;
-			case BPF_CMPXCHG:
-				/*
-				 * Return old value in BPF_REG_0 for BPF_CMPXCHG &
-				 * in src_reg for other cases.
-				 */
-				ret_reg = bpf_to_ppc(BPF_REG_0);
-
-				/* Compare with old value in BPF_R0 */
-				if (size == BPF_DW)
-					EMIT(PPC_RAW_CMPD(bpf_to_ppc(BPF_REG_0), tmp2_reg));
-				else
-					EMIT(PPC_RAW_CMPW(bpf_to_ppc(BPF_REG_0), tmp2_reg));
-				/* Don't set if different from old value */
-				PPC_BCC_SHORT(COND_NE, (ctx->idx + 3) * 4);
-				fallthrough;
-			case BPF_XCHG:
-				save_reg = src_reg;
-				break;
-			default:
-				pr_err_ratelimited(
-					"eBPF filter atomic op code %02x (@%d) unsupported\n",
-					code, i);
-				return -EOPNOTSUPP;
-			}
-
-			/* store new value */
-			if (size == BPF_DW)
-				EMIT(PPC_RAW_STDCX(save_reg, tmp1_reg, dst_reg));
-			else
-				EMIT(PPC_RAW_STWCX(save_reg, tmp1_reg, dst_reg));
-			/* we're done if this succeeded */
-			PPC_BCC_SHORT(COND_NE, tmp_idx);
-
-			if (imm & BPF_FETCH) {
-				/* Emit 'sync' to enforce full ordering */
-				if (IS_ENABLED(CONFIG_SMP))
-					EMIT(PPC_RAW_SYNC());
-				EMIT(PPC_RAW_MR(ret_reg, _R0));
-				/*
-				 * Skip unnecessary zero-extension for 32-bit cmpxchg.
-				 * For context, see commit 39491867ace5.
-				 */
-				if (size != BPF_DW && imm == BPF_CMPXCHG &&
-				    insn_is_zext(&insn[i + 1]))
-					addrs[++i] = ctx->idx * 4;
+			ret = bpf_jit_emit_atomic_ops(image, ctx, &insn[i],
+						      &jmp_off, &tmp_idx, &addrs[i + 1]);
+			if (ret) {
+				if (ret == -EOPNOTSUPP) {
+					pr_err_ratelimited(
+						"eBPF filter atomic op code %02x (@%d) unsupported\n",
+						code, i);
+				}
+				return ret;
 			}
 			break;
 
-- 
2.43.5


