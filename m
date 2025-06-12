Return-Path: <linux-kselftest+bounces-34799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B61AD6B58
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 10:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9B11893439
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 08:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E511DE4CD;
	Thu, 12 Jun 2025 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFGHLVzd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13361AB6F1
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718170; cv=none; b=VCg+3QyxqWWp5+Hj9qTUCwjyeTZRtFWf1tPUYgrPJi5c1wB5Hb+ahh23NV0H2Ybm1j2n75yuEf/+LjrdSJXfhKp9egeXJEaz2Y+uHI0Hy/q1SmkeWwbYoYs3G6zUvfJRHWLGz1/z1/QrRj9r3jMveJr3kiKScRb7lUL96O3SGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718170; c=relaxed/simple;
	bh=evORccHYl0GxEoXm8jQC2ZEEVf+krB5Z/xCnbYCZvmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f93Dqs7FO8UWHTPxrnbo5HZCgx643SAxRD9YkdwgrvPsiMqfZnzS4zCFDr2zNqZ7qXT/PPcrJS0l+gnXyKanEYYCsBbOjMtgur3BSiBF6yhJItJs+hJYJjiKclh6jBzTu4nOitmg5P3rqzWJowBJT1tPRUzHuSNQG4czr57sXkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFGHLVzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34313C4CEEA;
	Thu, 12 Jun 2025 08:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749718170;
	bh=evORccHYl0GxEoXm8jQC2ZEEVf+krB5Z/xCnbYCZvmc=;
	h=From:To:Cc:Subject:Date:From;
	b=RFGHLVzd4mwjs3ZKK07/eoHFTUPFvaUsFV2xxwJqWJOTisTTivQXvv6E30J0/2Gs4
	 nBC6BnKoUTcztyHffSSW7gHSu8C6cW6EawOxkgKmLT/ddUNinatdS2B9E67p/2C9KK
	 b3RMlBevk+2oiMKh1PjuUjRr+PDF1qIQjUeTPo6PiCVnMZbazH8mHeMu1VATg+8IZV
	 3pm/B6MN165XII/MJfM3Zj6PIVU+ra5gGy0bq/mkorwUWHCAmJHOoxel2r6bHKlXMw
	 38tzZpQLSvxudcYbCew50DvHakOZ0q6Og/Y8ezKLPXZFpUTawxR5wWUd2JEP0SHFzC
	 roghnm5d26c0w==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: brendan.higgins@linux.dev,
	davidgow@google.com
Cc: rmoar@google.com,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	tzungbi@kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2] kunit: Add test for static stub
Date: Thu, 12 Jun 2025 08:48:34 +0000
Message-ID: <20250612084834.587576-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__kunit_activate_static_stub() works effectively as
kunit_deactivate_static_stub() if `replacement_addr` is NULL.

Add a test case to catch the issue discovered in 772e50a76ee6 ("kunit: Fix
wrong parameter to kunit_deactivate_static_stub()").

For running the test:

$ ./tools/testing/kunit/kunit.py run \
        --arch=x86_64 \
        kunit_stub

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
(https://lore.kernel.org/linux-kselftest/20250522054912.2948008-1-tzungbi@kernel.org/)
- Update the commit message to point to commit 772e50a76ee6.
- Rebase to v6.16-rc1.

 lib/kunit/kunit-test.c | 46 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index d9c781c859fd..f8f567196ca9 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -8,6 +8,7 @@
 #include "linux/gfp_types.h"
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
+#include <kunit/static_stub.h>
 
 #include <linux/device.h>
 #include <kunit/device.h>
@@ -868,10 +869,53 @@ static struct kunit_suite kunit_current_test_suite = {
 	.test_cases = kunit_current_test_cases,
 };
 
+static void kunit_stub_test(struct kunit *test)
+{
+	struct kunit fake_test;
+	const unsigned long fake_real_fn_addr = 0x1234;
+	const unsigned long fake_replacement_addr = 0x5678;
+	struct kunit_resource *res;
+	struct {
+		void *real_fn_addr;
+		void *replacement_addr;
+	} *stub_ctx;
+
+	kunit_init_test(&fake_test, "kunit_stub_fake_test", NULL);
+	KUNIT_ASSERT_EQ(test, fake_test.status, KUNIT_SUCCESS);
+	KUNIT_ASSERT_EQ(test, list_count_nodes(&fake_test.resources), 0);
+
+	__kunit_activate_static_stub(&fake_test, (void *)fake_real_fn_addr,
+				     (void *)fake_replacement_addr);
+	KUNIT_ASSERT_EQ(test, fake_test.status, KUNIT_SUCCESS);
+	KUNIT_ASSERT_EQ(test, list_count_nodes(&fake_test.resources), 1);
+
+	res = list_first_entry(&fake_test.resources, struct kunit_resource, node);
+	KUNIT_EXPECT_NOT_NULL(test, res);
+
+	stub_ctx = res->data;
+	KUNIT_EXPECT_NOT_NULL(test, stub_ctx);
+	KUNIT_EXPECT_EQ(test, (unsigned long)stub_ctx->real_fn_addr, fake_real_fn_addr);
+	KUNIT_EXPECT_EQ(test, (unsigned long)stub_ctx->replacement_addr, fake_replacement_addr);
+
+	__kunit_activate_static_stub(&fake_test, (void *)fake_real_fn_addr, NULL);
+	KUNIT_ASSERT_EQ(test, fake_test.status, KUNIT_SUCCESS);
+	KUNIT_ASSERT_EQ(test, list_count_nodes(&fake_test.resources), 0);
+}
+
+static struct kunit_case kunit_stub_test_cases[] = {
+	KUNIT_CASE(kunit_stub_test),
+	{}
+};
+
+static struct kunit_suite kunit_stub_test_suite = {
+	.name = "kunit_stub",
+	.test_cases = kunit_stub_test_cases,
+};
+
 kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
 		  &kunit_log_test_suite, &kunit_status_test_suite,
 		  &kunit_current_test_suite, &kunit_device_test_suite,
-		  &kunit_fault_test_suite);
+		  &kunit_fault_test_suite, &kunit_stub_test_suite);
 
 MODULE_DESCRIPTION("KUnit test for core test infrastructure");
 MODULE_LICENSE("GPL v2");
-- 
2.50.0.rc1.591.g9c95f17f64-goog


