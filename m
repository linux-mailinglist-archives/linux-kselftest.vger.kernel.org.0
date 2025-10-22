Return-Path: <linux-kselftest+bounces-43769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06240BFD5AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 18:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25B219A400F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF8727A123;
	Wed, 22 Oct 2025 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wVgrFwGg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A90200C2
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151584; cv=none; b=biambesKCa4SFKc683l4zpqjoVosLYMd+mRpgqZfIB6FnkC3nkvETdVpgKg6dsOK5XXLrOxpz/MUOxc/eWTecqkfy6qmWFjDq9rAhe34NRbhYp/+iNk3KRsX3w0o5G/kRRfdbqLInh+Tz4cjqhjQR7fKfEVZvAPLvWOY4yvoVTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151584; c=relaxed/simple;
	bh=Og7Afz0y84kh3PCRyhT21PX40s4Ey/kKnquD3IaHpcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWGkTS6QILOnTsGSJyzdKiFRzdxSkpcVXZSrlhbnafTx97nzSqEUIxcpGFuz0in54WYvhBiVq5i+NBJ5xx+ut3cwY59XNk+X3lGTPBp+SyuVrk7okTaamXLiRFm2ivtBYgi+WcKVB8V7qMR3X79XZinJXVpTZCU5Rc8G74ye6TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wVgrFwGg; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761151579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5YHSfe0I86BaZgDlDp2zuQzKHrMTOgU+I9FSbZgluc=;
	b=wVgrFwGgZ+tEI3kAVhwc6vBfvjSjkn2u09FLM914n/wy+QJPl3diG65eLbfKKqw0bEzKOu
	tzrqsYC2Y6WVPj/AFimVgPRzB1DDKBzncG1Rz8hUlp7Wdm7JCMKC0KnnAgB57gdrlSjGtp
	/oTE+DDIyPGHCc2nf2vi/24CwKlxc+U=
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
	luis.gerhorst@fau.de,
	colin.i.king@gmail.com,
	harishankar.vishwanathan@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>
Subject: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for conditional jumps on same register
Date: Thu, 23 Oct 2025 00:44:56 +0800
Message-ID: <20251022164457.1203756-2-kafai.wan@linux.dev>
In-Reply-To: <20251022164457.1203756-1-kafai.wan@linux.dev>
References: <20251022164457.1203756-1-kafai.wan@linux.dev>
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
WARNING: CPU: 0 PID: 93 at kernel/bpf/verifier.c:2731 reg_bounds_sanity_check+0x163/0x220
Modules linked in:
CPU: 0 UID: 0 PID: 93 Comm: repro-x-3 Tainted: G        W           6.18.0-rc1-ge7586577b75f-dirty #218 PREEMPT(full)
Tainted: [W]=WARN
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:reg_bounds_sanity_check+0x163/0x220
Call Trace:
 <TASK>
 reg_set_min_max.part.0+0x1b1/0x360
 check_cond_jmp_op+0x1195/0x1a60
 do_check_common+0x33ac/0x33c0
 ...

The issue occurs in reg_set_min_max() function where bounds adjustment logic
is applied even when both registers being compared are the same. Comparing a
register with itself should not change its bounds since the comparison result
is always known (e.g., r0 == r0 is always true, r0 < r0 is always false).

Fix this by adding an early return in reg_set_min_max() when false_reg1 and
false_reg2 point to the same register, skipping the unnecessary bounds
adjustment that leads to the verifier bug.

Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Closes: https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Coremail.kaiyanm@hust.edu.cn/
Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6d175849e57a..420ad512d1af 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16429,6 +16429,10 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
 	if (false_reg1->type != SCALAR_VALUE || false_reg2->type != SCALAR_VALUE)
 		return 0;
 
+	/* If conditional jumps on the same register, skip the adjustment */
+	if (false_reg1 == false_reg2)
+		return 0;
+
 	/* fallthrough (FALSE) branch */
 	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp32);
 	reg_bounds_sync(false_reg1);
-- 
2.43.0


