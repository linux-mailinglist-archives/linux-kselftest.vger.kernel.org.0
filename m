Return-Path: <linux-kselftest+bounces-10710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECF38D034D
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 16:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B592A22A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CCD16132B;
	Mon, 27 May 2024 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSQQsqrs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1238170851;
	Mon, 27 May 2024 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819265; cv=none; b=cTZcv1U6QYzZ4KdWww+xLnQaKU6IEi139lsEMjAvQBbBWolRfnqeQ0xeX5vH7Iv7NRj2yTYNg80f277HOXEY/S4juX18LG+s8dP3d5TfzBdivJAMl21kTiOZySauQ1raRUNGeVzrnMES8RlPMtzQMKZzB29uH3JACYWdS38F2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819265; c=relaxed/simple;
	bh=KYbDoBIOVemCSPjQliXQl6JYCRrMwP9/hPqHjp4Cy2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNvytass/qthYl4FFH3g9IalPyUXc/sL5CztmuCeE9nLUVV3774kEq6wFCmfxBZhv06jRELPoMuDRnc4iRcoXAyk/XFJ9V+sDuvJJUzefKkJycaJMsxXROtcAEIerrV+bJ+zdDhIkIA2qA/74G5BM4B5S+1gi1sejHQb4R13lfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSQQsqrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACE9C2BBFC;
	Mon, 27 May 2024 14:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819264;
	bh=KYbDoBIOVemCSPjQliXQl6JYCRrMwP9/hPqHjp4Cy2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OSQQsqrszT1NtC6d0pQCb3f7oJsm9EgPPmpqPmOJn73gD9pvtOe/qSCF2sCoyEYJp
	 lRG7L52Ar3SRdnGiQHoyo1JCI/O+/U/t3nHkfkTrfKEJxO1Fyo0hQgiVKGdhBpxHyd
	 w+oY1zyPU5Kke9f//wUWKrgZ5XLZ849ElkCQIgBcrZA2BKxGvr7i1R/+re3zW8odPk
	 4Aq91hxdLX+jaB3OB1goDI+GRb5ighLZe/juIim4Yc2AzERT+KKPthh6/FUTC9yLnv
	 bIRSKWQ/UWyRlSKorkLC9YDtiTXpSMAXQf0ZOE7OHAESekKmdG79R+6DraWCZZfzQm
	 FclNesH+BPttg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 03/30] selftests/bpf: Fix flaky test btf_map_in_map/lookup_update
Date: Mon, 27 May 2024 10:13:12 -0400
Message-ID: <20240527141406.3852821-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141406.3852821-1-sashal@kernel.org>
References: <20240527141406.3852821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
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
index a8b53b8736f01..f66ceccd7029c 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
@@ -25,7 +25,7 @@ static void test_lookup_update(void)
 	int map1_fd, map2_fd, map3_fd, map4_fd, map5_fd, map1_id, map2_id;
 	int outer_arr_fd, outer_hash_fd, outer_arr_dyn_fd;
 	struct test_btf_map_in_map *skel;
-	int err, key = 0, val, i, fd;
+	int err, key = 0, val, i;
 
 	skel = test_btf_map_in_map__open_and_load();
 	if (CHECK(!skel, "skel_open", "failed to open&load skeleton\n"))
@@ -102,30 +102,6 @@ static void test_lookup_update(void)
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


