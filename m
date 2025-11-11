Return-Path: <linux-kselftest+bounces-45346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F0AC4F78C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FEC64EAC52
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D337C29DB64;
	Tue, 11 Nov 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYYohash"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ABC29C33D;
	Tue, 11 Nov 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886667; cv=none; b=b9y6sGrobeEe9D3B9TwJyxQX5M/Jhg3ZGMTN9RSkwmBn84z2htVmsFxOs7E2tPKsCtEZrRls2c3VA/1B8+3Wy+PBJSAchGWssWtu+MlUp/rbOCLvURT1y1iDl4yCSk+e1BLQELkz6czzgUcAJDYoEgfdJpjT06xqPuC7vxlg2hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886667; c=relaxed/simple;
	bh=mAIWfi16gggHF11DCFY7/6hV5ak1nSb/ROSHyLfYfYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tO6yIBxQ3nSjOdZDbeq5y6YFjluq18UhOXRWuetBTjF99Ucf/u6VkKfwfcj7rpG3tcRocEAI/KZqcycZlw+OJSMRlHo44LP/cPnm0Kw4YF+WKizOj5GSaSprFbji6EWyRZ95kC3Oaa3RLJvNKyNyYZNf114J+XtkyjzkNyL/vS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYYohash; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BA9C19422;
	Tue, 11 Nov 2025 18:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762886667;
	bh=mAIWfi16gggHF11DCFY7/6hV5ak1nSb/ROSHyLfYfYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sYYohashKZ1/+G8G79TC/s7dyeb+R17yDQBEiIyO38hKCeCuABCKapiAFcY9lPOW7
	 Y3BVent0s5UOfWvMA1QJRxOjO9zRF7p0eq7kVcU57eEUlt/ePtO+284MaB+Eg/kMon
	 Uye/3APygEp66bcPIs2FCk59DcJD667MzfJCgKb7+PJ6zWl0FzUy7ptD1sa5fwLbF+
	 vPwGB2odoTsf9nIDr411XlxADvGfUynsRC4jtL3LWWlioGtj+lfjtLS9ssqKMvy1GF
	 zn/SXHcSZp5K3kShaIVT//2Xzl7RfYnOnqX2BZmZqD8SWcTAut9RSkmR1GIVQtesTU
	 VTjfiql/oepEA==
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
Subject: [PATCH 01/11] mm/damon/tests/core-kunit: remove dynamic allocs on damos_test_commit_filter()
Date: Tue, 11 Nov 2025 10:44:00 -0800
Message-ID: <20251111184415.141757-2-sj@kernel.org>
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

damos_test_commit_filter() is dynamically allocating test-purpose DAMOS
filters.  Allocation failure checks are making the code longer,
complicated, and difficult to extend for more test cases.  Refactor the
code to remove the dynamic allocation.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 96a4cd489b39..ae97886137dc 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -499,23 +499,20 @@ static void damos_test_new_filter(struct kunit *test)
 
 static void damos_test_commit_filter(struct kunit *test)
 {
-	struct damos_filter *src_filter, *dst_filter;
-
-	src_filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true, true);
-	if (!src_filter)
-		kunit_skip(test, "src filter alloc fail");
-	dst_filter = damos_new_filter(DAMOS_FILTER_TYPE_ACTIVE, false, false);
-	if (!dst_filter) {
-		damos_destroy_filter(src_filter);
-		kunit_skip(test, "dst filter alloc fail");
-	}
-	damos_commit_filter(dst_filter, src_filter);
-	KUNIT_EXPECT_EQ(test, dst_filter->type, src_filter->type);
-	KUNIT_EXPECT_EQ(test, dst_filter->matching, src_filter->matching);
-	KUNIT_EXPECT_EQ(test, dst_filter->allow, src_filter->allow);
+	struct damos_filter src_filter = {
+		.type = DAMOS_FILTER_TYPE_ANON,
+		.matching = true,
+		.allow = true};
+	struct damos_filter dst_filter = {
+		.type = DAMOS_FILTER_TYPE_ACTIVE,
+		.matching = false,
+		.allow = false,
+	};
 
-	damos_destroy_filter(src_filter);
-	damos_destroy_filter(dst_filter);
+	damos_commit_filter(&dst_filter, &src_filter);
+	KUNIT_EXPECT_EQ(test, dst_filter.type, src_filter.type);
+	KUNIT_EXPECT_EQ(test, dst_filter.matching, src_filter.matching);
+	KUNIT_EXPECT_EQ(test, dst_filter.allow, src_filter.allow);
 }
 
 static void damos_test_filter_out(struct kunit *test)
-- 
2.47.3

