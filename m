Return-Path: <linux-kselftest+bounces-45356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C8AC4F7BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE801189FE2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75D02C327A;
	Tue, 11 Nov 2025 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNPTrLvs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833202C2369;
	Tue, 11 Nov 2025 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886670; cv=none; b=gI1tnyqhbjFHOiPNC9nPDhwQJcOf2FZw959/IBNv3n1Tpy8AZPXQAzUOdXk5IVxpqWBOq+YnzZzgohu0w1my8KR34/EPXIGIqVWgrzYIa+AJUXwpeXI4zv1XK+sqRfgVa0uAL8+NW/eTX3AL5WwsbKf+cn6xAqFLwzY34hlDHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886670; c=relaxed/simple;
	bh=m/GX1of/o0JwmQB22uABGhbz8AVH+G+y5IyrNLPgTaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8eVoNo7GVNzLKYFGs7LqAfUNxa5NvAHx1f12vTWUB4USqdmMUZURcnHdz3QLXp8Ip7br3OTBlp+d9Is46cZwWscgp8RnbabG1S1HtdGND4MPnOpBM11uJumMnpNn9VYlUxrNbL1f0zAwQ5t8HjkFZadA00C08ny6csxsK9Hgkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNPTrLvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B0FC2BCB0;
	Tue, 11 Nov 2025 18:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762886670;
	bh=m/GX1of/o0JwmQB22uABGhbz8AVH+G+y5IyrNLPgTaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNPTrLvs9YPxmIT6K0ECp8GD35K01XGC/S34VT/9Wej8jKHlX0asTUZSAxO3VSoKg
	 34behRhWEUos0wj4lYps20hRlOSRHQTvmS30ugkz5TkUL7qrEYyTsveSy31dBN5yAa
	 Sm/wkBIY0eYDWjuDoyOPYGMKHWbErVsUEWTrAgDJVe0KdBDgMKRpfnZE1Cd8DnO9Ze
	 n6VVw0LB9GW1+5i8gwGKg40k36uRDBmgEDvZtNLA1MzpZ8GJ4nOCE+//jsud4X/gVa
	 Jqq9stjJXqb1n7xE5s+hpLu2mzMUkWMFBsQzO8XWJWdHNQZ9DZoZQa1UcDn+F3Tb++
	 dXoG050dSrRCQ==
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
Subject: [PATCH 11/11] mm/damon/tests/core-kunit: add damon_commit_target_regions() test
Date: Tue, 11 Nov 2025 10:44:10 -0800
Message-ID: <20251111184415.141757-12-sj@kernel.org>
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

Add a new test for damon_commit_target_regions().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 65 +++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index c71c10f9e059..0d2d8cda8631 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -964,6 +964,70 @@ static void damos_test_commit(struct kunit *test)
 			});
 }
 
+static struct damon_target *damon_test_help_setup_target(
+		unsigned long region_start_end[][2], int nr_regions)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	int i;
+
+	t = damon_new_target();
+	if (!t)
+		return NULL;
+	for (i = 0; i < nr_regions; i++) {
+		r = damon_new_region(region_start_end[i][0],
+				region_start_end[i][1]);
+		if (!r) {
+			damon_free_target(t);
+			return NULL;
+		}
+		damon_add_region(r, t);
+	}
+	return t;
+}
+
+static void damon_test_commit_target_regions_for(struct kunit *test,
+		unsigned long dst_start_end[][2], int nr_dst_regions,
+		unsigned long src_start_end[][2], int nr_src_regions,
+		unsigned long expect_start_end[][2], int nr_expect_regions)
+{
+	struct damon_target *dst_target, *src_target;
+	struct damon_region *r;
+	int i;
+
+	dst_target = damon_test_help_setup_target(dst_start_end, nr_dst_regions);
+	if (!dst_target)
+		kunit_skip(test, "dst target setup fail");
+	src_target = damon_test_help_setup_target(src_start_end, nr_src_regions);
+	if (!src_target) {
+		damon_free_target(dst_target);
+		kunit_skip(test, "src target setup fail");
+	}
+	damon_commit_target_regions(dst_target, src_target, 1);
+	i = 0;
+	damon_for_each_region(r, dst_target) {
+		KUNIT_EXPECT_EQ(test, r->ar.start, expect_start_end[i][0]);
+		KUNIT_EXPECT_EQ(test, r->ar.end, expect_start_end[i][1]);
+		i++;
+	}
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(dst_target), nr_expect_regions);
+	KUNIT_EXPECT_EQ(test, i, nr_expect_regions);
+	damon_free_target(dst_target);
+	damon_free_target(src_target);
+}
+
+static void damon_test_commit_target_regions(struct kunit *test)
+{
+	damon_test_commit_target_regions_for(test,
+			(unsigned long[][2]) {{3, 8}, {8, 10}}, 2,
+			(unsigned long[][2]) {{4, 6}}, 1,
+			(unsigned long[][2]) {{4, 6}}, 1);
+	damon_test_commit_target_regions_for(test,
+			(unsigned long[][2]) {{3, 8}, {8, 10}}, 2,
+			(unsigned long[][2]) {}, 0,
+			(unsigned long[][2]) {{3, 8}, {8, 10}}, 2);
+}
+
 static void damos_test_filter_out(struct kunit *test)
 {
 	struct damon_target *t;
@@ -1170,6 +1234,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_commit_dests),
 	KUNIT_CASE(damos_test_commit_filter),
 	KUNIT_CASE(damos_test_commit),
+	KUNIT_CASE(damon_test_commit_target_regions),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
 	KUNIT_CASE(damon_test_set_filters_default_reject),
-- 
2.47.3

