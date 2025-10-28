Return-Path: <linux-kselftest+bounces-44188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F42C156ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 16:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E4CF506AEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDE4342CBC;
	Tue, 28 Oct 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jLzo1Wps"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E0342173
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664825; cv=none; b=STIIBOFcKoF+nHS+YEj4PAg/KCBQQGHmmklCf25kMEv04qrv+4lneO76uFP/jQeEQKnqqYDvulVnI+xCTAT3ZJ7gR8JeFrUFDauX4D3uGmnsxHOo8EKw+AY2Wow5AHv6MDU4J1GC76nY3EyoeTXULfmVvsVWW+1gyLLizCda7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664825; c=relaxed/simple;
	bh=e6HN/dKZ+u/7a8MHlTVFNNkvjRiIo/c13bcuG1xwNJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCaUPCJ6TZ/C6Vk7kkOPh0txgP6FKGDx+F3THa7KYa7OUn6IGks/wtXk2nU/v5bzUUqrBnUbAXKZbcOY03sxxcAh2IzGgklSO3jiZKiK/Vdmb0F3Zvckc4BQ6mFkzeLoLwlzShUxKXuvd3ZGF4/JjdAxG19vXPaZOPI/3e2dth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jLzo1Wps; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761664820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iwl7rDXJIzJ2WczqQvEPGztzATA3rpnK5twYsIF3gag=;
	b=jLzo1Wpsk75CWojoi00GapRaZEz7bp8J9YWi4T7MOrR7LTBGbBtktHriZwi+oHKCTGimjY
	MwpeeETfswZHR2WSyUN2Rsmlvp83ggfpvfcpDe9ZV9Ic4D/wMtUdT9H/FKWEV7lavfrFnq
	K456k+rBInD3/3X/98cRS/Ch5s4Opgc=
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
	shung-hsi.yu@suse.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v2 1/2] bpf: Fix tnum_overlap to check for zero mask intersection
Date: Tue, 28 Oct 2025 23:19:37 +0800
Message-ID: <20251028151938.3872003-2-kafai.wan@linux.dev>
In-Reply-To: <20251028151938.3872003-1-kafai.wan@linux.dev>
References: <20251028151938.3872003-1-kafai.wan@linux.dev>
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
refine register bounds and trigger range bounds violation:

   6: if r6 == r7 goto <exit>
   true_reg1: u64=[0xffffffffffffff01, 0xffffffffffffff00] var_off=(0xffffffffffffff00, 0x0)
   true_reg2: u64=[0xffffffffffffff01, 0xffffffffffffff00] var_off=(0xffffffffffffff00, 0x0)

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
index f8e70e9c3998..1a75b7c9a73a 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -163,6 +163,8 @@ bool tnum_overlap(struct tnum a, struct tnum b)
 {
 	u64 mu;
 
+	if (a.mask && b.mask && !(a.mask & b.mask))
+		return false;
 	mu = ~a.mask & ~b.mask;
 	return (a.value & mu) == (b.value & mu);
 }
-- 
2.43.0


