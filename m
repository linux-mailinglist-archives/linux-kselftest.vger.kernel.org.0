Return-Path: <linux-kselftest+bounces-33493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C446EAC0437
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 07:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFDD188DF94
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 05:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B501AA791;
	Thu, 22 May 2025 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmwAnj8r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009811A8404
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893004; cv=none; b=iL0DZWmo+uJQ3XcBkUxSW1Gckai3Do0z1H9tG2c2dHv1lSPk0zGM4PQWHuYRKvPfp5cVomr3/VnQZ5VphXJW+PMVID2dO/RTdkSVBej2jMgjW9721FYUPVriSg3/lG0RkzY87ioQ1IMrYjyejVWYIHTTx63uVdiG9MJW48Q0Ir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893004; c=relaxed/simple;
	bh=S/epYHhnDA6M0Se0425eF6Z6a6if+DK2+Wca1JHfGr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6CN3hx+Pf6yW5llrsGF/7LJcqyVADioeT+I2mO6LUc65s/jODrh93C3yTR3N3I/a91T8+xvhz9rMvD0Lr17yF/tv7Tk8z6BA/go6OjF60ex6apDBM0J0Obb7OyaTSfke7FkBYiXifr/MxuoKjfTMXJiRDP8MNUk8nRcj8y+DFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmwAnj8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AA6C4CEE4;
	Thu, 22 May 2025 05:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747893003;
	bh=S/epYHhnDA6M0Se0425eF6Z6a6if+DK2+Wca1JHfGr4=;
	h=From:To:Cc:Subject:Date:From;
	b=gmwAnj8rpBp2NdCTk6VJZMNWWtt5DfUf5+A1nvU9J1HLDVfXmRZINlWkNobe1waq7
	 aZOl/JrggZ6AwDZYq8avxaIcT29Sc19n+QXk5cJ99gBlrLl0n/UaPcR38e24pjBlEr
	 1cmKk/or2TBdB8Gr2ctTBYk2S3yFio5VVGXg585637jPjHuqTo8lUULUPNRlL4IrQg
	 tozmXd57QbfGnPyTiNR0soRmkXtCzw0dzk5AuPNn+0UrpaJL0UQVIiT/Nx6jLRMvVm
	 EmmeLX8kUBfAFD/U1IEVVHxIQ4pDklDcj2V5rBtcqWwOA2587tSkbEFEtCuwhaH8IA
	 PkxRKfzrj9dJQ==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: brendan.higgins@linux.dev,
	davidgow@google.com
Cc: rmoar@google.com,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	tzungbi@kernel.org
Subject: [PATCH] kunit: Add test for static stub
Date: Thu, 22 May 2025 05:49:11 +0000
Message-ID: <20250522054912.2948008-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__kunit_activate_static_stub() works effectively as
kunit_deactivate_static_stub() if `replacement_addr` is NULL.  Add a
test case for that.

For running the test:

$ ./tools/testing/kunit/kunit.py run \
        --arch=x86_64 \
        kunit_stub

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
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
2.49.0.1143.g0be31eac6b-goog


