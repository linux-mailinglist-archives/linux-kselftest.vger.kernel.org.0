Return-Path: <linux-kselftest+bounces-44033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B15C08B72
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 07:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D103ACAD7
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 05:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166E12C028E;
	Sat, 25 Oct 2025 05:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="enxORHHk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8EE22F76F
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 05:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761370298; cv=none; b=ofX0zTxgPMw6NquSuN/CcKf0/ui4ay7uA99i90CU0lNR+lrNiE9R8Bj6AKkYVAfEqrdHYHSNVFeYSuceIyRpBrmnF7fJ5NKvj7ZfMD08HxAubLuvmAnVYMn23uoeQyme1UZhnZYYknT6gDmE/mPEsy4kVYf59FTTnOz/fi1b7zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761370298; c=relaxed/simple;
	bh=dioH+7hCvMyS5Tx1o3rs6buZVgj948rfxHcInzZDHh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEGliSzsteDYyzmIJVsrE0xIpcTTxCMs2rhtzLXeDrYRXPJ8LXs/UNfBEu4bIwJyNva1rCLccd4QO145g8l9V0nTcAYCU4DzOv5CykrskEaknHNeF2QUhnxNY0xdfLDiXz6zzv9Gc6aScqXzQTJHIijCzXtcKJd2N59B7RyyMEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=enxORHHk; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761370293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m13+M6D1mpmzJOilgH7TsH0yLWlIw5RngITMJiFHo+w=;
	b=enxORHHkmdFXXulr3CKhA2OIrlI1o9qxDprov9m4P2N0+Rvb9GSQKq9lR0ynbr05zbUZZn
	6bBRjPw/yNIr3F0NQ2yBFbhY3GTQE46OFN0/+pWUqox7/Uqw6CBSHWzHMOgw4d7+H9LR4H
	z2pp/W5X1Z2ktwk1v1aAAJFqd5bn344=
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
	harishankar.vishwanathan@gmail.com,
	colin.i.king@gmail.com,
	luis.gerhorst@fau.de,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>
Subject: [PATCH bpf-next v2 1/2] bpf: Skip bounds adjustment for conditional jumps on same register
Date: Sat, 25 Oct 2025 13:30:16 +0800
Message-ID: <20251025053017.2308823-2-kafai.wan@linux.dev>
In-Reply-To: <20251025053017.2308823-1-kafai.wan@linux.dev>
References: <20251025053017.2308823-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When conditional jumps are performed on the same register (e.g., r0 <= r0,
r0 > r0, r0 < r0) where the register holds a scalar with range, the verifier
incorrectly attempts to adjust the register's min/max bounds. This leads to
invalid range bounds and triggers a BUG warning:

verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds violation u64=[0x1, 0x0] s64=[0x1, 0x0] u32=[0x1, 0x0] s32=[0x1, 0x0] var_off=(0x0, 0x0)
WARNING: CPU: 0 PID: 92 at kernel/bpf/verifier.c:2731 reg_bounds_sanity_check+0x163/0x220
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:reg_bounds_sanity_check+0x163/0x220
Call Trace:
 <TASK>
 reg_set_min_max+0xf7/0x1d0
 check_cond_jmp_op+0x57b/0x1730
 ? print_bpf_insn+0x3d5/0xa50
 do_check_common+0x33ac/0x33c0
 ...

The root cause is in regs_refine_cond_op() where BPF_JLT/BPF_JSLT operations
adjust both min/max bounds on the same register, causing invalid bounds.

Since comparing a register with itself should not change its bounds (the
comparison result is always known: r0 == r0 is always true, r0 < r0 is
always false), the bounds adjustment is unnecessary.

Fix this by:
1. Enhance is_branch_taken() and is_scalar_branch_taken() to properly
   handle branch direction computation for same register comparisons
   across all BPF jump operations
2. For unknown branch directions (e.g., BPF_JSET), add early return in
   reg_set_min_max() to avoid bounds adjustment on the same register

The fix ensures that unnecessary bounds adjustments are skipped, preventing
the verifier bug while maintaining correct branch direction analysis.

Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Closes: https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Coremail.kaiyanm@hust.edu.cn/
Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6d175849e57a..653fa96ed0df 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16037,6 +16037,12 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
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
@@ -16172,6 +16178,25 @@ static int is_pkt_ptr_branch_taken(struct bpf_reg_state *dst_reg,
 static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
 			   u8 opcode, bool is_jmp32)
 {
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
+		default:
+			break;
+		}
+	}
+
 	if (reg_is_pkt_pointer_any(reg1) && reg_is_pkt_pointer_any(reg2) && !is_jmp32)
 		return is_pkt_ptr_branch_taken(reg1, reg2, opcode);
 
@@ -16429,6 +16454,13 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
 	if (false_reg1->type != SCALAR_VALUE || false_reg2->type != SCALAR_VALUE)
 		return 0;
 
+	/* We compute branch direction for same registers in is_branch_taken() and
+	 * is_scalar_branch_taken(). For unknown branch directions (e.g., BPF_JSET)
+	 * on the same registers, we don't need to adjusts the min/max values.
+	 */
+	if (false_reg1 == false_reg2)
+		return 0;
+
 	/* fallthrough (FALSE) branch */
 	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp32);
 	reg_bounds_sync(false_reg1);
-- 
2.43.0


