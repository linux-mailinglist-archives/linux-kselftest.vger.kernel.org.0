Return-Path: <linux-kselftest+bounces-45355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 156B6C4F7B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BE6189C862
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0122C21CB;
	Tue, 11 Nov 2025 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivB+mUEJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E440E2C15A2;
	Tue, 11 Nov 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886670; cv=none; b=lN2ntf8TqIzETdSdYSHqOdSinXZfD+yIN752izTnlONQUe2JcnsE3n3hnuPK6HOISoElX/bAr+SVACLawhQRsDtVye9DjpUQhFLTXTeRMy6ug1PO6AxODr7Rh8YTCUP3s2Q114jj7I5Jg56qN72eEEPX1WhLUPOzZdSlXqIORyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886670; c=relaxed/simple;
	bh=UHTTCWbBxKg4HVFBjTI+3bp4LAWv9VnyN7HpL47+onk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByzalPf45X/QgpFko/2Q4RdWg2ftFNQh2qPn0njDoYnbSuI3SJmioktYZvoWtHxhy8iTk4C+cMvhZ1tP14R6YwwlYu+YdxhQLynvdK2Ta2oqt4tc6lT1IOKrgxeVlKo42OT1Trjz1xcxWFvUGqnIYMG5nCxJ+E8dH0lEboanEeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivB+mUEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D23FC116D0;
	Tue, 11 Nov 2025 18:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762886669;
	bh=UHTTCWbBxKg4HVFBjTI+3bp4LAWv9VnyN7HpL47+onk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivB+mUEJg/v+GWvlW7Q7nRX8JRqQEfRVL0BwPVv9S1vkR6mhVZO/vgmOG9bWe6nQK
	 tQKRPeqjBXg5Zbor+Vn+l3o/rVu1HkdRN6hgT9YM7sNvfcATE99rKvba+BmemfCHeO
	 SHunCl44MO+uvxRsip0iaPF9XNuCLpuNdSyAEb6kGbHMSy0yGpwkVyd4bLaOq9lOBG
	 R742RGGAY3sSUhywxeUgdHnpPjM/miRf1TtzPG6WzMHGOBpuYm+OvrN2/LO7KNpGYK
	 xkSeqg13Uet2qerkEo8vZWhhTda5LWSSABDZrFHoEwT74wP1qn5YtRkRiiZIwxYgwT
	 cqOpD5atP/lOg==
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
Subject: [PATCH 10/11] mm/damon/tests/core-kunit: add damos_commit() test
Date: Tue, 11 Nov 2025 10:44:09 -0800
Message-ID: <20251111184415.141757-11-sj@kernel.org>
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

Add a new unit test for damos_commit().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 92 +++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 10f2aefc71ff..c71c10f9e059 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -873,6 +873,97 @@ static void damos_test_commit_filter(struct kunit *test)
 			});
 }
 
+static void damos_test_help_initailize_scheme(struct damos *scheme)
+{
+	INIT_LIST_HEAD(&scheme->quota.goals);
+	INIT_LIST_HEAD(&scheme->filters);
+	INIT_LIST_HEAD(&scheme->ops_filters);
+}
+
+static void damos_test_commit_for(struct kunit *test, struct damos *dst,
+		struct damos *src)
+{
+	int err;
+
+	damos_test_help_initailize_scheme(dst);
+	damos_test_help_initailize_scheme(src);
+
+	err = damos_commit(dst, src);
+	if (err)
+		kunit_skip(test, "damos_commit fail");
+
+	KUNIT_EXPECT_EQ(test, dst->pattern.min_sz_region,
+			src->pattern.min_sz_region);
+	KUNIT_EXPECT_EQ(test, dst->pattern.max_sz_region,
+			src->pattern.max_sz_region);
+	KUNIT_EXPECT_EQ(test, dst->pattern.min_nr_accesses,
+			src->pattern.min_nr_accesses);
+	KUNIT_EXPECT_EQ(test, dst->pattern.max_nr_accesses,
+			src->pattern.max_nr_accesses);
+	KUNIT_EXPECT_EQ(test, dst->pattern.min_age_region,
+			src->pattern.min_age_region);
+	KUNIT_EXPECT_EQ(test, dst->pattern.max_age_region,
+			src->pattern.max_age_region);
+
+	KUNIT_EXPECT_EQ(test, dst->action, src->action);
+	KUNIT_EXPECT_EQ(test, dst->apply_interval_us, src->apply_interval_us);
+
+	KUNIT_EXPECT_EQ(test, dst->wmarks.metric, src->wmarks.metric);
+	KUNIT_EXPECT_EQ(test, dst->wmarks.interval, src->wmarks.interval);
+	KUNIT_EXPECT_EQ(test, dst->wmarks.high, src->wmarks.high);
+	KUNIT_EXPECT_EQ(test, dst->wmarks.mid, src->wmarks.mid);
+	KUNIT_EXPECT_EQ(test, dst->wmarks.low, src->wmarks.low);
+
+	switch (src->action) {
+	case DAMOS_MIGRATE_COLD:
+	case DAMOS_MIGRATE_HOT:
+		KUNIT_EXPECT_EQ(test, dst->target_nid, src->target_nid);
+		break;
+	default:
+		break;
+	}
+}
+
+static void damos_test_commit(struct kunit *test)
+{
+	damos_test_commit_for(test,
+			&(struct damos){
+				.pattern = (struct damos_access_pattern){
+					1, 2, 3, 4, 5, 6},
+				.action = DAMOS_PAGEOUT,
+				.apply_interval_us = 1000000,
+				.wmarks = (struct damos_watermarks){
+					DAMOS_WMARK_FREE_MEM_RATE,
+					900, 100, 50},
+			},
+			&(struct damos){
+				.pattern = (struct damos_access_pattern){
+					2, 3, 4, 5, 6, 7},
+				.action = DAMOS_PAGEOUT,
+				.apply_interval_us = 2000000,
+				.wmarks = (struct damos_watermarks){
+					DAMOS_WMARK_FREE_MEM_RATE,
+					800, 50, 30},
+			});
+	damos_test_commit_for(test,
+			&(struct damos){
+				.pattern = (struct damos_access_pattern){
+					1, 2, 3, 4, 5, 6},
+				.action = DAMOS_PAGEOUT,
+				.apply_interval_us = 1000000,
+				.wmarks = (struct damos_watermarks){
+					DAMOS_WMARK_FREE_MEM_RATE,
+					900, 100, 50},
+			},
+			&(struct damos){
+				.pattern = (struct damos_access_pattern){
+					2, 3, 4, 5, 6, 7},
+				.action = DAMOS_MIGRATE_HOT,
+				.apply_interval_us = 2000000,
+				.target_nid = 5,
+			});
+}
+
 static void damos_test_filter_out(struct kunit *test)
 {
 	struct damon_target *t;
@@ -1078,6 +1169,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_commit_quota),
 	KUNIT_CASE(damos_test_commit_dests),
 	KUNIT_CASE(damos_test_commit_filter),
+	KUNIT_CASE(damos_test_commit),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
 	KUNIT_CASE(damon_test_set_filters_default_reject),
-- 
2.47.3

