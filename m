Return-Path: <linux-kselftest+bounces-10724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A7A8D0470
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE99D1F21288
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FC316E882;
	Mon, 27 May 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv7Ia/tb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D639616E87B;
	Mon, 27 May 2024 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819558; cv=none; b=NOT/zQIVYdnuEE57/e6mDVhvGlrOZGXr+7JJzrjAY4QPS/LXC8Hc316OqH6k4g6kES+P9h6jEFB6Uy39HYQJPHVgOADG74mmwMKGJUldXlm7+wYDC8gVLRDr3aoJnc1yoLf1Q7lhqlGscmUDIUGhEJKQ8ukoNk4jltq9OBfMg9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819558; c=relaxed/simple;
	bh=XO/vrShnhVJSCVJmwwGPzrEHmCvVitXrrdR21QErR1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llQNwi8GJameDetBAIw1m9vEKVuu5YcUyzIgOLNVfXpBGLLNoEP5p+TfAONWoXWnaijjSlIc625J2JHCKwRhTfQrT8AC1We+TRyWXR7Yf3YRR8hzOqi2tLiO9v3WiEOWm6+pJ6jRX+hVFegJsoiH1TRJ/WlE7WFLc8X1m/Pr2zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv7Ia/tb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79205C32781;
	Mon, 27 May 2024 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819558;
	bh=XO/vrShnhVJSCVJmwwGPzrEHmCvVitXrrdR21QErR1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cv7Ia/tbClocFnTqG6wnLfTvgY74iFRwQh4SfUrP75WwEMdvnq1DQ+YLYq8BaJSIO
	 6qImdV0Tcb5D5hj3wa9JyBxiSjX+NtLLzz6mrukIq0WPuzmhltdh2qNXheUkSYAOtx
	 uXfbamLeWq+VV3o/lnwgm4SjCOHvjYXmruN23TaSWVzn7SHn45O4lroz68rogop41r
	 XYm2JqKlTfiKjvQzH5/PjtOin7oT4P1op7+tQkaRHWd6MymQmz95e92D30x1pLb4RD
	 NAjd9DNREVhnOEW/Sgi9b1/e/veOGxbgy/vxqSLQEWtPwBQE8d1ugKEIph7SnXIJuj
	 ak/b9+/782Bjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/13] selftests/bpf: Fix flaky test btf_map_in_map/lookup_update
Date: Mon, 27 May 2024 10:18:39 -0400
Message-ID: <20240527141901.3854691-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141901.3854691-1-sashal@kernel.org>
References: <20240527141901.3854691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 14bb1e8c8d4ad5d9d2febb7d19c70a3cf536e1e5 ]

Recently, I frequently hit the following test failure:

  [root@arch-fb-vm1 bpf]# ./test_progs -n 33/1
  test_lookup_update:PASS:skel_open 0 nsec
  [...]
  test_lookup_update:PASS:sync_rcu 0 nsec
  test_lookup_update:FAIL:map1_leak inner_map1 leaked!
  #33/1    btf_map_in_map/lookup_update:FAIL
  #33      btf_map_in_map:FAIL

In the test, after map is closed and then after two rcu grace periods,
it is assumed that map_id is not available to user space.

But the above assumption cannot be guaranteed. After zero or one
or two rcu grace periods in different siturations, the actual
freeing-map-work is put into a workqueue. Later on, when the work
is dequeued, the map will be actually freed.
See bpf_map_put() in kernel/bpf/syscall.c.

By using workqueue, there is no ganrantee that map will be actually
freed after a couple of rcu grace periods. This patch removed
such map leak detection and then the test can pass consistently.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20240322061353.632136-1-yonghong.song@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/prog_tests/btf_map_in_map.c | 26 +------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
index 76ebe4c250f11..a434828bc7ab7 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
@@ -58,7 +58,7 @@ static void test_lookup_update(void)
 	int map1_fd, map2_fd, map3_fd, map4_fd, map5_fd, map1_id, map2_id;
 	int outer_arr_fd, outer_hash_fd, outer_arr_dyn_fd;
 	struct test_btf_map_in_map *skel;
-	int err, key = 0, val, i, fd;
+	int err, key = 0, val, i;
 
 	skel = test_btf_map_in_map__open_and_load();
 	if (CHECK(!skel, "skel_open", "failed to open&load skeleton\n"))
@@ -135,30 +135,6 @@ static void test_lookup_update(void)
 	CHECK(map1_id == 0, "map1_id", "failed to get ID 1\n");
 	CHECK(map2_id == 0, "map2_id", "failed to get ID 2\n");
 
-	test_btf_map_in_map__destroy(skel);
-	skel = NULL;
-
-	/* we need to either wait for or force synchronize_rcu(), before
-	 * checking for "still exists" condition, otherwise map could still be
-	 * resolvable by ID, causing false positives.
-	 *
-	 * Older kernels (5.8 and earlier) freed map only after two
-	 * synchronize_rcu()s, so trigger two, to be entirely sure.
-	 */
-	CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
-	CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
-
-	fd = bpf_map_get_fd_by_id(map1_id);
-	if (CHECK(fd >= 0, "map1_leak", "inner_map1 leaked!\n")) {
-		close(fd);
-		goto cleanup;
-	}
-	fd = bpf_map_get_fd_by_id(map2_id);
-	if (CHECK(fd >= 0, "map2_leak", "inner_map2 leaked!\n")) {
-		close(fd);
-		goto cleanup;
-	}
-
 cleanup:
 	test_btf_map_in_map__destroy(skel);
 }
-- 
2.43.0


