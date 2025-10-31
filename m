Return-Path: <linux-kselftest+bounces-44526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9419C25E22
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F05244EB58A
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 15:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7162E612E;
	Fri, 31 Oct 2025 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a0SzaL7M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54212E62B1
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925454; cv=none; b=DpPem710hjbX+SqwcNCqYuT3ZpWOzV2kA3zla0cjindyN7k4irR93mvYw3RQdg3l3QB7eFVkPFoSZdTpDwqm+UZSIkaTLvs+xPo3RfepxAxesyUGIOvO2Uw2GH4IkhvIk3g3qhoc8WcqpWzxxhQ2e4H8yirPF6GOeUS6mT9Kgc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925454; c=relaxed/simple;
	bh=4qW3H4YDZKKCIzAYcQbuiWYayHfB3PHRabpaBlHaPXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHiJgokbgv3XqQlBpqqvkwzEv9W+EAP08V9Nz1FNE5IIBfPVtcWsK5VUUlrfY5HsizUUiJXORGC9qd6/Kb3m+kt1H+Gf9F1SJ2u8SeeQU/u7otGnnCqpX4ZhB7m1mclfAqCi8BFMj0RRyJnuPHua7fAELtbkgSsN6jYpHU626Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a0SzaL7M; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761925450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFChiLWBtCj3iwiMOwhYTxg52eMmJua5aLRvXZolD6k=;
	b=a0SzaL7MwCT1VeDY0z8mvnhou/T3u4G0FN/Hk2evImfiBkAxXfFDkgNxWTLU8sUT4/RbCN
	rpnwHtky5FZ6givEStKX5jUdYD0YvifWyyEi+l+8YLcPVtkHQnQ4R0Ia1Eclvsc82yrJow
	8euGu3YxrbQXeQd6q6BelEUKifZprlc=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	paul.chaignon@gmail.com,
	m.shachnai@gmail.com,
	henriette.herzog@rub.de,
	kafai.wan@linux.dev,
	luis.gerhorst@fau.de,
	harishankar.vishwanathan@gmail.com,
	colin.i.king@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Kaiyan Mei <M202472210@hust.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>
Subject: [PATCH bpf-next v3 1/2] bpf: Skip bounds adjustment for conditional jumps on same scalar register
Date: Fri, 31 Oct 2025 23:41:06 +0800
Message-ID: <20251031154107.403054-2-kafai.wan@linux.dev>
In-Reply-To: <20251031154107.403054-1-kafai.wan@linux.dev>
References: <20251031154107.403054-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When conditional jumps are performed on the same scalar register
(e.g., r0 <= r0, r0 > r0, r0 < r0), the BPF verifier incorrectly
attempts to adjust the register's min/max bounds. This leads to
invalid range bounds and triggers a BUG warning.

The problematic BPF program:
   0: call bpf_get_prandom_u32
   1: w8 = 0x80000000
   2: r0 &= r8
   3: if r0 > r0 goto <exit>

The instruction 3 triggers kernel warning:
   3: if r0 > r0 goto <exit>
   true_reg1: range bounds violation u64=[0x1, 0x0] s64=[0x1, 0x0] u32=[0x1, 0x0] s32=[0x1, 0x0] var_off=(0x0, 0x0)
   true_reg2: const tnum out of sync with range bounds u64=[0x0, 0xffffffffffffffff] s64=[0x8000000000000000, 0x7fffffffffffffff] var_off=(0x0, 0x0)

Comparing a register with itself should not change its bounds and
for most comparison operations, comparing a register with itself has
a known result (e.g., r0 == r0 is always true, r0 < r0 is always false).

Fix this by:
1. Enhance is_scalar_branch_taken() to properly handle branch direction
   computation for same register comparisons across all BPF jump operations
2. Adds early return in reg_set_min_max() to avoid bounds adjustment
   for unknown branch directions (e.g., BPF_JSET) on the same register

The fix ensures that unnecessary bounds adjustments are skipped, preventing
the verifier bug while maintaining correct branch direction analysis.

Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Closes: https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Coremail.kaiyanm@hust.edu.cn/
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 kernel/bpf/verifier.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 542e23fb19c7..a571263f4ebe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15995,6 +15995,8 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
 
 	switch (opcode) {
 	case BPF_JEQ:
+		if (reg1 == reg2)
+			return 1;
 		/* constants, umin/umax and smin/smax checks would be
 		 * redundant in this case because they all should match
 		 */
@@ -16021,6 +16023,8 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
 		}
 		break;
 	case BPF_JNE:
+		if (reg1 == reg2)
+			return 0;
 		/* constants, umin/umax and smin/smax checks would be
 		 * redundant in this case because they all should match
 		 */
@@ -16047,6 +16051,12 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
 		}
 		break;
 	case BPF_JSET:
+		if (reg1 == reg2) {
+			if (tnum_is_const(t1))
+				return t1.value != 0;
+			else
+				return (smin1 <= 0 && smax1 >= 0) ? -1 : 1;
+		}
 		if (!is_reg_const(reg2, is_jmp32)) {
 			swap(reg1, reg2);
 			swap(t1, t2);
@@ -16059,48 +16069,64 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
 			return 0;
 		break;
 	case BPF_JGT:
+		if (reg1 == reg2)
+			return 0;
 		if (umin1 > umax2)
 			return 1;
 		else if (umax1 <= umin2)
 			return 0;
 		break;
 	case BPF_JSGT:
+		if (reg1 == reg2)
+			return 0;
 		if (smin1 > smax2)
 			return 1;
 		else if (smax1 <= smin2)
 			return 0;
 		break;
 	case BPF_JLT:
+		if (reg1 == reg2)
+			return 0;
 		if (umax1 < umin2)
 			return 1;
 		else if (umin1 >= umax2)
 			return 0;
 		break;
 	case BPF_JSLT:
+		if (reg1 == reg2)
+			return 0;
 		if (smax1 < smin2)
 			return 1;
 		else if (smin1 >= smax2)
 			return 0;
 		break;
 	case BPF_JGE:
+		if (reg1 == reg2)
+			return 1;
 		if (umin1 >= umax2)
 			return 1;
 		else if (umax1 < umin2)
 			return 0;
 		break;
 	case BPF_JSGE:
+		if (reg1 == reg2)
+			return 1;
 		if (smin1 >= smax2)
 			return 1;
 		else if (smax1 < smin2)
 			return 0;
 		break;
 	case BPF_JLE:
+		if (reg1 == reg2)
+			return 1;
 		if (umax1 <= umin2)
 			return 1;
 		else if (umin1 > umax2)
 			return 0;
 		break;
 	case BPF_JSLE:
+		if (reg1 == reg2)
+			return 1;
 		if (smax1 <= smin2)
 			return 1;
 		else if (smin1 > smax2)
@@ -16439,6 +16465,13 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
 	if (false_reg1->type != SCALAR_VALUE || false_reg2->type != SCALAR_VALUE)
 		return 0;
 
+	/* We compute branch direction for same SCALAR_VALUE registers in
+	 * is_scalar_branch_taken(). For unknown branch directions (e.g., BPF_JSET)
+	 * on the same registers, we don't need to adjust the min/max values.
+	 */
+	if (false_reg1 == false_reg2)
+		return 0;
+
 	/* fallthrough (FALSE) branch */
 	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp32);
 	reg_bounds_sync(false_reg1);
-- 
2.43.0


