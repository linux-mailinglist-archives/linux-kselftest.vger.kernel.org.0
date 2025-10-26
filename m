Return-Path: <linux-kselftest+bounces-44070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E972CC0ADBE
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 17:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD45189C010
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 16:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D5021B91D;
	Sun, 26 Oct 2025 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LzSQOpsJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBE4207A22
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761496731; cv=none; b=oANUYbEGvwbUuJkFP03nTss/ychIBb7twRF8aDQVudHKZCzHDs+MPSpJhrgTo5Lj7ySePnlWajxuOgu7VgLdFGi2CoiT7ygz0Otq8GaiQkRRF/ag67FUNCETvTpvsnRzNAY27SoJ9tF0cEZ1Tu4FTVDR6CQOuMdNyGAGahkpJ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761496731; c=relaxed/simple;
	bh=DEw7ZOeAhejnvjJ1BDBFz3PfQdtqnj7GFeIhTc3OuG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeSts5ONfMRcLq9FajBqPKrZmqB5rLQINqE5jkLEgeReIQkeAOTKPIWwQH4smz9n28ilS1YeO1WOp3mHBdMFan6RhlHUKKs5EOJjdsx/Xqtg/gu/dxigkq5qjgzRw9pNdyJETTY2sDpQrB2gEhR2iPpjLqzai9dQcrPGrTFMLV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LzSQOpsJ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761496727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFoJR/u0IaB/0PpKtMKlYiR9B8oxdFtp8dSKC4xgXkY=;
	b=LzSQOpsJHn6rFsK+TfZWJOs4aaD/pVMhAHOY7TtByt2X/ef4VXy8Ycy/E2zHUZLDkEmcth
	wvzNb6T5mXqUyzqvrZAI6tPdjcqa09KbyDEoCvvcfZ07nZ0VqFzqa9i8GCrHdcepqmHzCg
	A77mM81A8q33C3GBRRAa0e/EGqhNbbI=
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
	memxor@gmail.com,
	harishankar.vishwanathan@gmail.com,
	colin.i.king@gmail.com,
	kafai.wan@linux.dev,
	luis.gerhorst@fau.de,
	shung-hsi.yu@suse.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Subject: [PATCH bpf-next 1/2] bpf: Fix tnum_overlap to check for zero mask first
Date: Mon, 27 Oct 2025 00:38:05 +0800
Message-ID: <20251026163806.3300636-2-kafai.wan@linux.dev>
In-Reply-To: <20251026163806.3300636-1-kafai.wan@linux.dev>
References: <20251026163806.3300636-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Syzbot reported a kernel warning due to a range invariant violation in
the BPF verifier. The issue occurs when tnum_overlap() fails to detect
that two tnums don't have any overlapping bits.

The problematic BPF program:
   0: call bpf_get_prandom_u32
   1: r6 = r0
   2: r6 &= 0xFFFFFFFFFFFFFFF0
   3: r7 = r0
   4: r7 &= 0x07
   5: r7 -= 0xFF
   6: if r6 == r7 goto <exit>

After instruction 5, R7 has the range:
   R7: u64=[0xffffffffffffff01, 0xffffffffffffff08] var_off=(0xffffffffffffff00; 0xf)

R6 and R7 don't overlap since they have no agreeing bits. However,
is_branch_taken() fails to recognize this, causing the verifier to
refine register bounds and end up with inconsistent bounds:

   6: if r6 == r7 goto <exit>
   R6: u64=[0xffffffffffffff01, 0xffffffffffffff00] var_off=(0xffffffffffffff00, 0x0)
   R7: u64=[0xffffffffffffff01, 0xffffffffffffff00] var_off=(0xffffffffffffff00, 0x0)

The root cause is that tnum_overlap() doesn't properly handle the case
where the masks have no overlapping bits.

Fix this by adding an early check for zero mask intersection in tnum_overlap().

Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Fixes: f41345f47fb2 ("bpf: Use tnums for JEQ/JNE is_branch_taken logic")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 kernel/bpf/tnum.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index f8e70e9c3998..af2f38b4f840 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -163,6 +163,8 @@ bool tnum_overlap(struct tnum a, struct tnum b)
 {
 	u64 mu;
 
+	if ((a.mask & b.mask) == 0)
+		return false;
 	mu = ~a.mask & ~b.mask;
 	return (a.value & mu) == (b.value & mu);
 }
-- 
2.43.0


