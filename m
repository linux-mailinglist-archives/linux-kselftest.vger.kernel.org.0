Return-Path: <linux-kselftest+bounces-41283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE12B544FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 10:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09514620E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 08:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA952D7386;
	Fri, 12 Sep 2025 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFEihX0i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4D2D6E6D;
	Fri, 12 Sep 2025 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665101; cv=none; b=jzkM2boUzRi5sUm3y5mpG8VkdHTeXPtE8aPrTQAEboCt0eKsfDhXNc1Cs1VOa25OZ+EhN/gNZ+Y9QGBw3cTvxbpfx3L52gCNpBX+mNjqoCwpak5HH2tAthjUkQS4jTttmBnCOAPkvnnNLVfEqqcCpM8KP650HfuxRFJ7UdbSOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665101; c=relaxed/simple;
	bh=spQeThlFrFG2oNH+ReAuZ4G4VATaAH+Se8jFpzGV7Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzPc3J0LCAZYVwig6jzJaSNVdwG0MBCtTg6RBOZqLVXElsi/YK5PLzFCb3/yVUQd7os0jJ/RtSRYTfKIpuqMLnaMEaTs3FMH5F0GCsuH6kn0/i0MqER082EKcCZQ9FbkZqv43sTFM5oJMf0Rd5z3CaRz/Jb3q4nIvYr4PbqQYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFEihX0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67ABC4CEF9;
	Fri, 12 Sep 2025 08:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757665100;
	bh=spQeThlFrFG2oNH+ReAuZ4G4VATaAH+Se8jFpzGV7Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFEihX0i1DmIO12katqR7FqTuZl/YsPOqi0ovNgSoz/qy5e1cIOHUlPERqyFJRI5k
	 l4GzUYAbbPlAyCDUoc3OHq2mgrH74TfGpmBWkGS2zU/crvP6NYjU3JsZmeR8pqJRj9
	 Xo5DALJaI0keshGjNbKNC0C7AS7HwNIRMY6XDZhX6S0RV1noe/LzZJrDIgmiGyi8+M
	 JmZ6yBG17tVOSSwZDLrTTbXjVa9BPkhtdJny76XfgId1JfiDpJst5Gisou+LzDQcPL
	 iO883BkolVN3hDtBL+T00WZAzdWm143nJ3x7zV/gzxsRVRGcl91Jr0Rajmv2iy0Ifr
	 cM+uZZ/GCDFPw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH v3 2/5] revocable: Add Kunit test cases
Date: Fri, 12 Sep 2025 08:17:14 +0000
Message-ID: <20250912081718.3827390-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912081718.3827390-1-tzungbi@kernel.org>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Kunit test cases for the revocable API.

The test cases cover the following scenarios:
- Basic: Verifies that a consumer can successfully access the resource
  provided via the provider.
- Revocation: Verifies that after the provider revokes the resource,
  the consumer correctly receives a NULL pointer on a subsequent access.
- Macro: Same as "Revocation" but uses the REVOCABLE().

A way to run the test:
$ ./tools/testing/kunit/kunit.py run \
        --kconfig_add CONFIG_REVOCABLE_KUNIT_TEST=y \
        revocable_test

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v3:
- No changes.

v2: https://lore.kernel.org/chrome-platform/20250820081645.847919-3-tzungbi@kernel.org
- New in the series.

 MAINTAINERS                   |   1 +
 drivers/base/Kconfig          |   8 +++
 drivers/base/Makefile         |   3 +
 drivers/base/revocable_test.c | 110 ++++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+)
 create mode 100644 drivers/base/revocable_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d11aeeb546e..74930474f1bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21882,6 +21882,7 @@ M:	Tzung-Bi Shih <tzungbi@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/base/revocable.c
+F:	drivers/base/revocable_test.c
 F:	include/linux/revocable.h
 
 RFKILL
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 064eb52ff7e2..a6488035f63d 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -244,3 +244,11 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
 	  work on.
 
 endmenu
+
+# Kunit test cases
+config REVOCABLE_KUNIT_TEST
+	tristate "Kunit tests for revocable" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Kunit tests for the revocable API.
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index bdf854694e39..4185aaa9bbb9 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -35,3 +35,6 @@ ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
 # define_trace.h needs to know how to find our header
 CFLAGS_trace.o		:= -I$(src)
 obj-$(CONFIG_TRACING)	+= trace.o
+
+# Kunit test cases
+obj-$(CONFIG_REVOCABLE_KUNIT_TEST)	+= revocable_test.o
diff --git a/drivers/base/revocable_test.c b/drivers/base/revocable_test.c
new file mode 100644
index 000000000000..d1ec7e47cd1d
--- /dev/null
+++ b/drivers/base/revocable_test.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Google LLC
+ *
+ * Kunit tests for the revocable API.
+ *
+ * The test cases cover the following scenarios:
+ *
+ * - Basic: Verifies that a consumer can successfully access the resource
+ *   provided via the provider.
+ *
+ * - Revocation: Verifies that after the provider revokes the resource,
+ *   the consumer correctly receives a NULL pointer on a subsequent access.
+ *
+ * - Macro: Same as "Revocation" but uses the REVOCABLE().
+ */
+
+#include <kunit/test.h>
+#include <linux/revocable.h>
+
+static void revocable_test_basic(struct kunit *test)
+{
+	struct revocable_provider *rp;
+	struct revocable *rev;
+	void *real_res = (void *)0x12345678, *res;
+
+	rp = revocable_provider_alloc(real_res);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rp);
+
+	rev = revocable_alloc(rp);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rev);
+
+	res = revocable_try_access(rev);
+	KUNIT_EXPECT_PTR_EQ(test, res, real_res);
+	revocable_release(rev);
+
+	revocable_free(rev);
+	revocable_provider_free(rp);
+}
+
+static void revocable_test_revocation(struct kunit *test)
+{
+	struct revocable_provider *rp;
+	struct revocable *rev;
+	void *real_res = (void *)0x12345678, *res;
+
+	rp = revocable_provider_alloc(real_res);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rp);
+
+	rev = revocable_alloc(rp);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rev);
+
+	res = revocable_try_access(rev);
+	KUNIT_EXPECT_PTR_EQ(test, res, real_res);
+	revocable_release(rev);
+
+	revocable_provider_free(rp);
+
+	res = revocable_try_access(rev);
+	KUNIT_EXPECT_PTR_EQ(test, res, NULL);
+	revocable_release(rev);
+
+	revocable_free(rev);
+}
+
+static void revocable_test_macro(struct kunit *test)
+{
+	struct revocable_provider *rp;
+	struct revocable *rev;
+	void *real_res = (void *)0x12345678, *res;
+	bool accessed;
+
+	rp = revocable_provider_alloc(real_res);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rp);
+
+	rev = revocable_alloc(rp);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rev);
+
+	accessed = false;
+	REVOCABLE(rev, res) {
+		KUNIT_EXPECT_PTR_EQ(test, res, real_res);
+		accessed = true;
+	}
+	KUNIT_EXPECT_TRUE(test, accessed);
+
+	revocable_provider_free(rp);
+
+	accessed = false;
+	REVOCABLE(rev, res) {
+		KUNIT_EXPECT_PTR_EQ(test, res, NULL);
+		accessed = true;
+	}
+	KUNIT_EXPECT_TRUE(test, accessed);
+
+	revocable_free(rev);
+}
+
+static struct kunit_case revocable_test_cases[] = {
+	KUNIT_CASE(revocable_test_basic),
+	KUNIT_CASE(revocable_test_revocation),
+	KUNIT_CASE(revocable_test_macro),
+	{}
+};
+
+static struct kunit_suite revocable_test_suite = {
+	.name = "revocable_test",
+	.test_cases = revocable_test_cases,
+};
+
+kunit_test_suite(revocable_test_suite);
-- 
2.51.0.384.g4c02a37b29-goog


