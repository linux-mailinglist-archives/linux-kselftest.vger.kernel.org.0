Return-Path: <linux-kselftest+bounces-32886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5115AB486C
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 02:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C241A7B09DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 00:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA6615A85A;
	Tue, 13 May 2025 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFUI/QYe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D98155A59;
	Tue, 13 May 2025 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747096046; cv=none; b=Z6ZG84lsCGxrMIF/LuLqWi+EHxxWaMWlaIr0aUjXHsBqE68FyqmkWxEwVHm1iu1dMGr+PsEi+w33jTD+0azVUv+ZYdSuQJ/W8+ndQ7FJePc0qcro79A77FVxx34vdIrQGeYVGMn8BLRQeNNCLu9mESQ8mOZGwhEk1oMC7TBYnGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747096046; c=relaxed/simple;
	bh=M92/gov+YRjIS6VM2BRObVBgAlR9lw1xuX3y69/FgHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XR/r5f/1Rw359lEUk54ecS5kJ7ssvlC3WeYarL760NE20eKiBT4frx9Qr3ug1UAkl4SJsA5jd+hRJPAkFjQr3VxvNCtaYAQReu4pU5gSPH1Bgw3Co/ccnsq7K8vUqaQE7/BKtTr8O2UymdVdsoSWnF/DStDbhoJLsyGWXMMxUYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFUI/QYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA7EC4CEEE;
	Tue, 13 May 2025 00:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747096045;
	bh=M92/gov+YRjIS6VM2BRObVBgAlR9lw1xuX3y69/FgHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TFUI/QYeXvnLV1j1ziIYgAjnNmTfT37e+HvuxaYLy3iKGlkp70GFZglavMkpdwr7N
	 ofWw+Sze4MkTYLXAzI+i955ustgk2/vvqCE7OIlrcP7rfJu790BgE/YgrlFjpExHG4
	 vhEkXlWt0Fr4rx09/Segf6ZE2FdQE+/6rBsDKwRyNWjcCt+j7XAQXMDiQmzbK0Pf+q
	 CtHHoSNXqE77P+jTRI3/BMzxYJkHjow7HAsyXjnH0jWVMwZTzTvg/GSl3Cu73Ej5O0
	 gX7kSvQwG5aLugFO7NTc/o4631ilxefS9Y/qJKqBzURm9DQmF5XInOzraGRB4HeCfA
	 ux1tAg94iO1rQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/6] mm/damon/tests/core-kunit: add a test for damos_set_filters_default_reject()
Date: Mon, 12 May 2025 17:27:13 -0700
Message-Id: <20250513002715.40126-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250513002715.40126-1-sj@kernel.org>
References: <20250513002715.40126-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filters' default reject behavior is not very simple.  Actually
there was a mistake[1] during the development.  Add a kunit test for
validating the behavior.

[1] https://lore.kernel.org/20250227002913.19359-1-sj@kernel.org

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 70 +++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index be0fea9ee5fc..298c67557fae 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -510,6 +510,75 @@ static void damon_test_feed_loop_next_input(struct kunit *test)
 			damon_feed_loop_next_input(last_input, 2000));
 }
 
+static void damon_test_set_filters_default_reject(struct kunit *test)
+{
+	struct damos scheme;
+	struct damos_filter *target_filter, *anon_filter;
+
+	INIT_LIST_HEAD(&scheme.filters);
+	INIT_LIST_HEAD(&scheme.ops_filters);
+
+	damos_set_filters_default_reject(&scheme);
+	/*
+	 * No filter is installed.  Allow by default on both core and ops layer
+	 * filtering stages, since there are no filters at all.
+	 */
+	KUNIT_EXPECT_EQ(test, scheme.core_filters_default_reject, false);
+	KUNIT_EXPECT_EQ(test, scheme.ops_filters_default_reject, false);
+
+	target_filter = damos_new_filter(DAMOS_FILTER_TYPE_TARGET, true, true);
+	damos_add_filter(&scheme, target_filter);
+	damos_set_filters_default_reject(&scheme);
+	/*
+	 * A core-handled allow-filter is installed.
+	 * Rejct by default on core layer filtering stage due to the last
+	 * core-layer-filter's behavior.
+	 * Allow by default on ops layer filtering stage due to the absence of
+	 * ops layer filters.
+	 */
+	KUNIT_EXPECT_EQ(test, scheme.core_filters_default_reject, true);
+	KUNIT_EXPECT_EQ(test, scheme.ops_filters_default_reject, false);
+
+	target_filter->allow = false;
+	damos_set_filters_default_reject(&scheme);
+	/*
+	 * A core-handled reject-filter is installed.
+	 * Allow by default on core layer filtering stage due to the last
+	 * core-layer-filter's behavior.
+	 * Allow by default on ops layer filtering stage due to the absence of
+	 * ops layer filters.
+	 */
+	KUNIT_EXPECT_EQ(test, scheme.core_filters_default_reject, false);
+	KUNIT_EXPECT_EQ(test, scheme.ops_filters_default_reject, false);
+
+	anon_filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true, true);
+	damos_add_filter(&scheme, anon_filter);
+
+	damos_set_filters_default_reject(&scheme);
+	/*
+	 * A core-handled reject-filter and ops-handled allow-filter are installed.
+	 * Allow by default on core layer filtering stage due to the existence
+	 * of the ops-handled filter.
+	 * Reject by default on ops layer filtering stage due to the last
+	 * ops-layer-filter's behavior.
+	 */
+	KUNIT_EXPECT_EQ(test, scheme.core_filters_default_reject, false);
+	KUNIT_EXPECT_EQ(test, scheme.ops_filters_default_reject, true);
+
+	target_filter->allow = true;
+	damos_set_filters_default_reject(&scheme);
+	/*
+	 * A core-handled allow-filter and ops-handled allow-filter are
+	 * installed.
+	 * Allow by default on core layer filtering stage due to the existence
+	 * of the ops-handled filter.
+	 * Reject by default on ops layer filtering stage due to the last
+	 * ops-layer-filter's behavior.
+	 */
+	KUNIT_EXPECT_EQ(test, scheme.core_filters_default_reject, false);
+	KUNIT_EXPECT_EQ(test, scheme.ops_filters_default_reject, true);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -527,6 +596,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
+	KUNIT_CASE(damon_test_set_filters_default_reject),
 	{},
 };
 
-- 
2.39.5


