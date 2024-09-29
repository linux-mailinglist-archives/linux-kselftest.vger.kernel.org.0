Return-Path: <linux-kselftest+bounces-18540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A619892CA
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 04:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3018B1C21A83
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 02:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EAEF9CF;
	Sun, 29 Sep 2024 02:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jfRGgLvd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F76AD2F
	for <linux-kselftest@vger.kernel.org>; Sun, 29 Sep 2024 02:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727578592; cv=none; b=f348fDmFJAcKBm3rjcN886ubkuY9/k0Fp9TQYOtsy+wsKALv0wIAE/kwT3N1aSWtaiTnYdqWik6BSV7u5kFtQMwqZpHUiKzuR+Ex1bjg/KMhx2W+5bp/eYu76M6FFgq8/hOBg9zxdBddyM9gTfxq5Lwj27wYUz9hcej97g5su3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727578592; c=relaxed/simple;
	bh=ZNrn55PWsk8wtnGQc04faZ4pr+YeNKSQfg0MCQQXexw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aLFag5Ey6QPUIteRfTev0ARThZoiE28Z+rx4Z/DwjuE0MOCMFmqMAtZEwStmqRR5dToAHGycyUZ+MvJXdpfQKH95FqOO6pPCj7Trfmh8rj9++390d65ctx2YxFg2fRbQ2uGKjJHfjsG/cAkmMELkkXqt248vW4Nt3U4/TkAhfVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=jfRGgLvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE42C4CEC3;
	Sun, 29 Sep 2024 02:56:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jfRGgLvd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727578589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ww6kKCFc3caUgpbqEUifZRElNQcYesR9JFOgX/FcPhs=;
	b=jfRGgLvdjWNrNCusDzWyjx0dMMw4AHu9XC/0h2rq5WLWNqxk8L3ky/2ZNGR/czkoQdsM3n
	Q52M6CTXfC8lc6zaopoo9JOq2d2cguC4k/UrfED/UeKQENphRHdrJowI4YDabQMju7nW7O
	9nAQW0OHdYMg+DFSLuqvc/EMQv1YdAk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id db73b4a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 29 Sep 2024 02:56:29 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Florian Weimer <fweimer@redhat.com>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>
Subject: [PATCH] selftests: vDSO: align getrandom states to cache line
Date: Sun, 29 Sep 2024 04:55:49 +0200
Message-ID: <20240929025620.2056732-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This prevents false sharing, which makes a large difference on machines
with several NUMA nodes, such as on a dual socket Intel(R) Xeon(R) Gold
6338 CPU @ 2.00GHz, where the "bench-multi" test goes from 2.7s down to
1.9s. While this is just test code, it also forms the basis of how folks
will wind up implementing this in libraries, so we should implement this
simple cache alignment improvement here.

Suggested-by: Florian Weimer <fweimer@redhat.com>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 72a1d9b43a84..e5e83dbec589 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -59,10 +59,12 @@ static void *vgetrandom_get_state(void)
 		size_t page_size = getpagesize();
 		size_t new_cap;
 		size_t alloc_size, num = sysconf(_SC_NPROCESSORS_ONLN); /* Just a decent heuristic. */
+		size_t state_size_aligned, cache_line_size = sysconf(_SC_LEVEL1_DCACHE_LINESIZE) ?: 1;
 		void *new_block, *new_states;
 
-		alloc_size = (num * vgrnd.params.size_of_opaque_state + page_size - 1) & (~(page_size - 1));
-		num = (page_size / vgrnd.params.size_of_opaque_state) * (alloc_size / page_size);
+		state_size_aligned = (vgrnd.params.size_of_opaque_state + cache_line_size - 1) & (~(cache_line_size - 1));
+		alloc_size = (num * state_size_aligned + page_size - 1) & (~(page_size - 1));
+		num = (page_size / state_size_aligned) * (alloc_size / page_size);
 		new_block = mmap(0, alloc_size, vgrnd.params.mmap_prot, vgrnd.params.mmap_flags, -1, 0);
 		if (new_block == MAP_FAILED)
 			goto out;
@@ -78,7 +80,7 @@ static void *vgetrandom_get_state(void)
 			if (((uintptr_t)new_block & (page_size - 1)) + vgrnd.params.size_of_opaque_state > page_size)
 				new_block = (void *)(((uintptr_t)new_block + page_size - 1) & (~(page_size - 1)));
 			vgrnd.states[i] = new_block;
-			new_block += vgrnd.params.size_of_opaque_state;
+			new_block += state_size_aligned;
 		}
 		vgrnd.len = num;
 		goto success;
-- 
2.46.0


