Return-Path: <linux-kselftest+bounces-44632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CECC2A30F
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 07:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182743AF850
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 06:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C310296BC2;
	Mon,  3 Nov 2025 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NRgkAqeN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613AF291C07
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Nov 2025 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151548; cv=none; b=LxGC0Dgc5ASkrJHCsZ8FxTwfsyYfLC+4jFJKVT13rbVr8ei5RX/H+5iTKxOs6RbVj4b2NODOZA6bXDjSXdP+1eEsl5JRBlMIgdbUQlBqglwoxhRHI8ndyRG1MVKo+8JTyvzFWQ5InssrcI6agiEbYyxrg7RilHU0uJ9Ys2mSZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151548; c=relaxed/simple;
	bh=5dlvQW3j7tlnksTc3f5p9ccCcZfH17m5aZYZ739FeZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv27NqGd86BmOprQa/yxgwUQVY99YIZ8yoEyzfQOIZwQ8QOlACdgMsrJ5vrpOQaZHKrvWI17OTrwD7IGVE4KQYHZJKgtsoOEZAvoM9sV5ZhCKFQX5WXiY5tUP6eum+aTMKnZFgQ3TEwKwdZ4QA4IOOaIq1aDKMrqb4h0M11pas0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NRgkAqeN; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762151544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2vFbOtEevYdcE9ma7oHwHbSng62XKE11/lNPHm5Qupo=;
	b=NRgkAqeNQr5IFlJm9OkTHolDNS+eeyQTDwFdBFYgOZYi00U8LJhyl0SAkSQo0ttnm64RI0
	L8zrP3f/zkMc6Koqegkg48HO3eWwC4ZHyaAfo4xjPTIksQNg+wpZzESuCjDhxJ8BdIfr7s
	fO8setXvIGke2KoW5XZTMqyo6lLiT/Q=
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
	kafai.wan@linux.dev,
	harishankar.vishwanathan@gmail.com,
	colin.i.king@gmail.com,
	luis.gerhorst@fau.de,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Kaiyan Mei <M202472210@hust.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>
Subject: [PATCH bpf-next v4 1/2] bpf: Skip bounds adjustment for conditional jumps on same scalar register
Date: Mon,  3 Nov 2025 14:31:07 +0800
Message-ID: <20251103063108.1111764-2-kafai.wan@linux.dev>
In-Reply-To: <20251103063108.1111764-1-kafai.wan@linux.dev>
References: <20251103063108.1111764-1-kafai.wan@linux.dev>
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
 kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 542e23fb19c7..e4928846e763 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15993,6 +15993,30 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
 	s64 smin2 = is_jmp32 ? (s64)reg2->s32_min_value : reg2->smin_value;
 	s64 smax2 = is_jmp32 ? (s64)reg2->s32_max_value : reg2->smax_value;
 
+	if (reg1 == reg2) {
+		switch (opcode) {
+		case BPF_JGE:
+		case BPF_JLE:
+		case BPF_JSGE:
+		case BPF_JSLE:
+		case BPF_JEQ:
+			return 1;
+		case BPF_JGT:
+		case BPF_JLT:
+		case BPF_JSGT:
+		case BPF_JSLT:
+		case BPF_JNE:
+			return 0;
+		case BPF_JSET:
+			if (tnum_is_const(t1))
+				return t1.value != 0;
+			else
+				return (smin1 <= 0 && smax1 >= 0) ? -1 : 1;
+		default:
+			return -1;
+		}
+	}
+
 	switch (opcode) {
 	case BPF_JEQ:
 		/* constants, umin/umax and smin/smax checks would be
@@ -16439,6 +16463,13 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
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


