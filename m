Return-Path: <linux-kselftest+bounces-45353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C98AFC4F7B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAD11896378
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1712C11E6;
	Tue, 11 Nov 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I91ZQq0a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE212C0F96;
	Tue, 11 Nov 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886669; cv=none; b=XSL8Wl1jCL0rPNbIFSREIoLBhhl6fBxHTVBMEOcw0HL166jXVOTOsqk+J8endih8ZNVcyKY0ecu2kJNjPoSwNZpYH+qo2Y8Y/VQ1EhNLXJq28aJaDlKviYawlsGg0/gdPq2n2/2lcvRNFOSMVHjGy9WnhSwu6bsZjv1Ib2hGeJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886669; c=relaxed/simple;
	bh=tky6fX2wXCCUx0aD3orGzGNV89HCs2127JlHIOUkDvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=al9Kqaz0vId33X4GBQU1uYKiOEsaWH8by35fTVxNLdiRJDIwRSPLRRCrMckrbACUTAbwYqU1EYyWk96XCm7jXmLnOiwa7cse3Gk/hHOWbIMwMdBR+yqy8To2OgdsLZ/9e7Q6VhE/rYKoJIFwsKPFDa4ciJdcKx9Cb78Hjuru6/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I91ZQq0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538D4C19421;
	Tue, 11 Nov 2025 18:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762886669;
	bh=tky6fX2wXCCUx0aD3orGzGNV89HCs2127JlHIOUkDvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I91ZQq0aHC7IVWjDDARNcxlvg91DU4DWeMAdsQXq9P7alYjccpLNYouaHhVTC3Rko
	 uiyyFpj15TE3NrN9Y9/wxvdmxnT0nKTkvoqPC1c48dhBEKFWhTgnWqRhMNa2fqC5e5
	 7z4VIffRy5a55tWJbJVgPBGJfpF5GQNkYR9TYz0piB4hVprmVQ2LNsbYt1yhrgv505
	 qVWHuIy8hVsDq+EH0zc4aVXFH48Cn/RTEfQcyaTNO869zYfoBfp7KGHZhun+fDCtKl
	 RsXUJHJK6x3Z20TmoCSoogD8jykZ4UtA12nw7xkcflLLQSvGB6nAlS8Aui4vJai0b8
	 lehFzSoWk9TTQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/11] mm/damon/tests/core-kunit: add damos_commit_dests() test
Date: Tue, 11 Nov 2025 10:44:08 -0800
Message-ID: <20251111184415.141757-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111184415.141757-1-sj@kernel.org>
References: <20251111184415.141757-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new unit test for damos_commit_dests().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 97 +++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 546e1a09d801..10f2aefc71ff 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -692,6 +692,102 @@ static void damos_test_commit_quota(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dst.weight_age, src.weight_age);
 }
 
+static int damos_test_help_dests_setup(struct damos_migrate_dests *dests,
+		unsigned int *node_id_arr, unsigned int *weight_arr,
+		size_t nr_dests)
+{
+	size_t i;
+
+	dests->node_id_arr = kmalloc_array(nr_dests,
+			sizeof(*dests->node_id_arr), GFP_KERNEL);
+	if (!dests->node_id_arr)
+		return -ENOMEM;
+	dests->weight_arr = kmalloc_array(nr_dests,
+			sizeof(*dests->weight_arr), GFP_KERNEL);
+	if (!dests->weight_arr) {
+		kfree(dests->node_id_arr);
+		dests->node_id_arr = NULL;
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < nr_dests; i++) {
+		dests->node_id_arr[i] = node_id_arr[i];
+		dests->weight_arr[i] = weight_arr[i];
+	}
+	dests->nr_dests = nr_dests;
+	return 0;
+}
+
+static void damos_test_help_dests_free(struct damos_migrate_dests *dests)
+{
+	kfree(dests->node_id_arr);
+	kfree(dests->weight_arr);
+}
+
+static void damos_test_commit_dests_for(struct kunit *test,
+		unsigned int *dst_node_id_arr, unsigned int *dst_weight_arr,
+		size_t dst_nr_dests,
+		unsigned int *src_node_id_arr, unsigned int *src_weight_arr,
+		size_t src_nr_dests)
+{
+	struct damos_migrate_dests dst = {}, src = {};
+	int i, err;
+	bool skip = true;
+
+	err = damos_test_help_dests_setup(&dst, dst_node_id_arr,
+			dst_weight_arr, dst_nr_dests);
+	if (err)
+		kunit_skip(test, "dests setup fail");
+	err = damos_test_help_dests_setup(&src, src_node_id_arr,
+			src_weight_arr, src_nr_dests);
+	if (err) {
+		damos_test_help_dests_free(&dst);
+		kunit_skip(test, "src setup fail");
+	}
+	err = damos_commit_dests(&dst, &src);
+	if (err)
+		goto out;
+	skip = false;
+
+	KUNIT_EXPECT_EQ(test, dst.nr_dests, src_nr_dests);
+	for (i = 0; i < dst.nr_dests; i++) {
+		KUNIT_EXPECT_EQ(test, dst.node_id_arr[i], src_node_id_arr[i]);
+		KUNIT_EXPECT_EQ(test, dst.weight_arr[i], src_weight_arr[i]);
+	}
+
+out:
+	damos_test_help_dests_free(&dst);
+	damos_test_help_dests_free(&src);
+	if (skip)
+		kunit_skip(test, "skip");
+}
+
+static void damos_test_commit_dests(struct kunit *test)
+{
+	damos_test_commit_dests_for(test,
+			(unsigned int[]){1, 2, 3}, (unsigned int[]){2, 3, 4},
+			3,
+			(unsigned int[]){4, 5, 6}, (unsigned int[]){5, 6, 7},
+			3);
+	damos_test_commit_dests_for(test,
+			(unsigned int[]){1, 2}, (unsigned int[]){2, 3},
+			2,
+			(unsigned int[]){4, 5, 6}, (unsigned int[]){5, 6, 7},
+			3);
+	damos_test_commit_dests_for(test,
+			NULL, NULL, 0,
+			(unsigned int[]){4, 5, 6}, (unsigned int[]){5, 6, 7},
+			3);
+	damos_test_commit_dests_for(test,
+			(unsigned int[]){1, 2, 3}, (unsigned int[]){2, 3, 4},
+			3,
+			(unsigned int[]){4, 5}, (unsigned int[]){5, 6}, 2);
+	damos_test_commit_dests_for(test,
+			(unsigned int[]){1, 2, 3}, (unsigned int[]){2, 3, 4},
+			3,
+			NULL, NULL, 0);
+}
+
 static void damos_test_commit_filter_for(struct kunit *test,
 		struct damos_filter *dst, struct damos_filter *src)
 {
@@ -980,6 +1076,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_commit_quota_goal),
 	KUNIT_CASE(damos_test_commit_quota_goals),
 	KUNIT_CASE(damos_test_commit_quota),
+	KUNIT_CASE(damos_test_commit_dests),
 	KUNIT_CASE(damos_test_commit_filter),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
-- 
2.47.3

