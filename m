Return-Path: <linux-kselftest+bounces-44608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E2BC28545
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207261A22D16
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1C8309DA0;
	Sat,  1 Nov 2025 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9873RHW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F593090FE;
	Sat,  1 Nov 2025 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021243; cv=none; b=geL6ISFVdqpznwZ+kbhEPvlIPxGNKiI7OmVN7Jhp8mI8k3dh/AfTIP/BhZnSTO2WwjoVCFXcrX2V0tseF/wEmmKKwqWZspKu4qAGp+PmjxNU2zeMjbNKtceAO0wc1WeXJlnsIL/XpNurv1mduCr0mISgiJKvqvAn2Hj+aAFh2kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021243; c=relaxed/simple;
	bh=tPpDN39ZJmNW8xL/EnZ9l/LC9JHHUFC5Pgu2gGvkODE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USivZbzIXCC4aiTxK+RbO0/1YoHqKjTeIMwiCWS+SKr2wzAwyCszLRN5+p8K6z22mdTL9SZCHx16Xa+dzwI1BUKmSEcdH/v1xdj56Oy2TFsweQw0snPbmJXKvFVw4U34Lxffz9AQAVoQQzSbdwZMEKPIoxYWF4Ic80PJOEURoc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9873RHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EF4C4CEFB;
	Sat,  1 Nov 2025 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021243;
	bh=tPpDN39ZJmNW8xL/EnZ9l/LC9JHHUFC5Pgu2gGvkODE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S9873RHWW7uv7XCyR9LzUDjbqDMeEfGYpvU15+SUHHYroxynxEdpPSD5v09jmvz3j
	 aYhlJTfu++ETY8+P+/u3etiwe0zaiuDfKD7yjZ8yq/fYP1w20RnuNt0nCArm1cYu0c
	 xf4+3fBTXG5yuUWlrG8j9K7h4CdwGu2cd/8oEBuHfPaQMAj+dPDiYons/irjRS9KSC
	 FOD62F5D6A7WbHAWYYlQlmp63QoAeUWdF/TS1b5C88qOTDI81+Ix5Ou2Ukj0ExOHtd
	 d7pmx+GCnHLlxdMMGxldqSxAZK2VW0XAjYU66qmAcR90/oVla+yuPKlmWJtTbeMy6S
	 p3DBsuqAREXdw==
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
Subject: [PATCH 22/22] mm/damon/tests/core-kunit: remove unused ctx in damon_test_split_regions_of()
Date: Sat,  1 Nov 2025 11:20:16 -0700
Message-ID: <20251101182021.74868-23-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251101182021.74868-1-sj@kernel.org>
References: <20251101182021.74868-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_split_regions_of() dynamically allocates a 'struct damon_ctx'
object, but it is not really being used in the code other than handling
the allocation failure and deallocating it at the end of the function.
Remove the unnecessary allocation and deallocation of the object.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 726f593930e7..96a4cd489b39 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -267,20 +267,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
 
 static void damon_test_split_regions_of(struct kunit *test)
 {
-	struct damon_ctx *c = damon_new_ctx();
 	struct damon_target *t;
 	struct damon_region *r;
 
-	if (!c)
-		kunit_skip("ctx alloc fail");
 	t = damon_new_target();
-	if (!t) {
-		damon_destroy_ctx(c);
+	if (!t)
 		kunit_skip(test, "target alloc fail");
-	}
 	r = damon_new_region(0, 22);
 	if (!r) {
-		damon_destroy_ctx(c);
 		damon_free_target(t);
 		kunit_skip(test, "region alloc fail");
 	}
@@ -290,13 +284,10 @@ static void damon_test_split_regions_of(struct kunit *test)
 	damon_free_target(t);
 
 	t = damon_new_target();
-	if (!t) {
-		damon_destroy_ctx(c);
+	if (!t)
 		kunit_skip(test, "second target alloc fail");
-	}
 	r = damon_new_region(0, 220);
 	if (!r) {
-		damon_destroy_ctx(c);
 		damon_free_target(t);
 		kunit_skip(test, "second region alloc fail");
 	}
@@ -304,7 +295,6 @@ static void damon_test_split_regions_of(struct kunit *test)
 	damon_split_regions_of(t, 4, DAMON_MIN_REGION);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
 	damon_free_target(t);
-	damon_destroy_ctx(c);
 }
 
 static void damon_test_ops_registration(struct kunit *test)
-- 
2.47.3

