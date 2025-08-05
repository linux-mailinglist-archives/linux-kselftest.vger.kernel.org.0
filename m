Return-Path: <linux-kselftest+bounces-38279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18897B1AE55
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 08:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93D53BB1F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 06:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A67225417;
	Tue,  5 Aug 2025 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R7uyQpbS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3F921C9E5;
	Tue,  5 Aug 2025 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375352; cv=none; b=m6u16cqUXdViFbv1uQa8bIS+7eKT2WrO5gcWH590jbwZ16IylW/fYrQdhUBYbhho9pBlTRVRdyeZLszahGEu8r7OI9mmyrnsZJl8jnNu1Biqzu11h3RCuiwMKCq/6bGy6aumv9nuSdgil4DA3Zpqi2OcRwinESNzF8NukV2Zj0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375352; c=relaxed/simple;
	bh=MVvPvZCE3I713bYs8EBca4lo70Y5VkoX2XvvlNdG3LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZwgUMF6XRVIfxH2wYOQejSKIhdb0X48IL/ht9l3RBEu5CHNa7+Uqgn8qkCqajo+f9fTTnGE0pgKqksefgqdCLl5322xTsH7Wnx9H9LyCfrx9fKzdCi76yFf001sXZx8rCqr92jVOwV3kVCBme1345N9AQ5CRqjZSska8K0qzKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R7uyQpbS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574L1ZVx014654;
	Tue, 5 Aug 2025 06:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FAc975URBeDhQ2ZGa
	Ba4r6rkYNEci9eNQVanL1mGVvg=; b=R7uyQpbSfScbGqYvykgLCtO5dHVOvnAd9
	FcdlT8Tv1Ah0vYfnco53NW3Yxomv5JCSk8ncxlHnqpvgqnYHT0W8Z03ejSCXPEST
	kebY0iDYbkyAMMH8r6dha/BUrDLX0KrLFQ4tnCyvBrn/UNUFGSo+tAy3zURjf/4D
	7dTyzI/d2NUFhf96anckFqAARCBL7CJ/MsLTs/2HnqXZJaArE4yaRzoTBQkD7WzA
	M4qcpk5W725p2FN4ee3eS4bFhp29WmTBL7FgzB42XqG6v1d13UKQ9NUBF3iU5FcT
	S9hdELmRMNBWr19S0/ZXTnAMpwL3hADb2lBcHMtsPLpIz2CXKmQIw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48983t55vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 06:28:37 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5756SaKh019111;
	Tue, 5 Aug 2025 06:28:36 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48983t55va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 06:28:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5753JJaL009807;
	Tue, 5 Aug 2025 06:28:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 489w0thbtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 06:28:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5756SWek33358368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 06:28:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA11820043;
	Tue,  5 Aug 2025 06:28:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3291320040;
	Tue,  5 Aug 2025 06:28:25 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.39.141])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 06:28:24 +0000 (GMT)
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
Subject: [bpf-next 4/6] bpf,powerpc: Introduce bpf_jit_emit_atomic_ops() to emit atomic instructions
Date: Tue,  5 Aug 2025 11:57:45 +0530
Message-ID: <20250805062747.3479221-5-skb99@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA0NSBTYWx0ZWRfXwiJSf2dWPA2n
 2Iv/EQoxRlLW23TjNZ0uDp6JwW6KZePtFViAxhd5mt4bcRvYZRMFSJPErJS6dszQ6nQHfWtXGQ3
 lDMydrDdFweplrZSzAiFbIlOYz/uVS1MhTy4N2ybUo2QwZDzHe7Abd99vDvO8E3FalZvAXF3Ja7
 hgibLd7fKp2XUMajCCe2lQLxiKXu3brJXpf/828GQoiKrMiznM/o1jJcmAACv55tkmCRhGeg/nB
 x7Sth7L1eb8HcdWG0ubziEmwnvjzhoNbZn1Jxj/624phGxAUZeZXDYlf1l0CTpoMoqKe+EebRXo
 fIbDXgGny0ypovrRrQn/MSJT25aUhWS6d617KVb0KH7O4QzjAJZMw97WgbaYHTF3CvtMqw+BFGB
 0WCem9zn2GtKsi6lr6C4o970Js3dMVUxB0eANGlNi8jGi4RrrhacCoaE8dR4eOamGoYeI6ss
X-Proofpoint-GUID: y1IvXRs28EEz1D4IoEQyuqPzy5m9abLt
X-Proofpoint-ORIG-GUID: 5m-gE2FuSQ8KJqOr79Xa4f8uo9KsfHfl
X-Authority-Analysis: v=2.4 cv=AZSxH2XG c=1 sm=1 tr=0 ts=6891a495 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=mLi99PhJ1kaOFlELNpEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050045

The existing code for emitting bpf atomic instruction sequences for
atomic operations such as XCHG, CMPXCHG, ADD, AND, OR, and XOR has been
refactored into a reusable function, bpf_jit_emit_ppc_atomic_op().
It also computes the jump offset and tracks the instruction index for jited
LDARX/LWARX to be used in case it causes a fault.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 203 +++++++++++++++++-------------
 1 file changed, 115 insertions(+), 88 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index d4fe4dacf2d6..6a85cd847075 100644
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
@@ -1081,93 +1186,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
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


