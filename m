Return-Path: <linux-kselftest+bounces-42132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A024BB94DE1
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 09:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A59148213E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35D63191D8;
	Tue, 23 Sep 2025 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD533MAz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DEB3191CC;
	Tue, 23 Sep 2025 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614042; cv=none; b=trkfuhqX2obzYM0mAyhzKkrgcfKZX67P2JV1X1+cRkg8MNmOxndvOJPQjYf3Frd1GA1vJjrX+NrEjpnH3nrXA4Jsj9vBdg3Ge8nd03h9xXeKp0QWfay2vzE4pMoImyPUBd3fVyzK/cchQ7atct1GPCNlPyEweGU9zYWElnpzLkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614042; c=relaxed/simple;
	bh=H10ykew0yVfEGneDBcMJZat6GG4/AuWSFOqJiH/83Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mt6AFnn3eqLCOQTwv1NbUab4d8wVOwoG7AoqgJxIvd9Qow5haDNiTRhEUVj2EukgRUAvwD1Np3pKNBtxRSu0BFv5Y/KMh3dwo/HYzf+3Px1gw3p3Jg8bO4Jvsbwkng1WRT8DcdGCG1SiJIBsa60y5xTpiu1LeuYVhF/smPIbo4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eD533MAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5B4C4CEF5;
	Tue, 23 Sep 2025 07:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758614042;
	bh=H10ykew0yVfEGneDBcMJZat6GG4/AuWSFOqJiH/83Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eD533MAzEJiQl0x4pA2YGuqMKtgVqX+yJMmqasZdauSpnnWLVAehydC+f2Iw1JUT7
	 7ZRXWfiW8DkLiRFH+L7fAPMFVbtuJCp5surdTZTI8ikxsXzgL7KRCdTZoNxbJK7+77
	 FS3om4hqB9JTFXPJdSMC0PYYk7tMvhK34jDGAuHikib0hsi5JA09CQbVkmMQm5PqWO
	 xC4JsrKFudME2IWf11uU46WWYyuI0lCTH5xhQiJfOWZuq8xmObzTA4EOVL/0i12sZb
	 hgYW6snshDc2mrF9/jKWpqwgM+Hvgt+yenWGgFXdc93yJ2xR1D5Kwti02gYUyE3AQp
	 bsa3gHKGAuvuw==
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
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 2/7] revocable: Add Kunit test cases
Date: Tue, 23 Sep 2025 07:52:57 +0000
Message-ID: <20250923075302.591026-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
In-Reply-To: <20250923075302.591026-1-tzungbi@kernel.org>
References: <20250923075302.591026-1-tzungbi@kernel.org>
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
v4:
- REVOCABLE() -> REVOCABLE_TRY_ACCESS_WITH().
- revocable_release() -> revocable_withdraw_access().

v3: https://lore.kernel.org/chrome-platform/20250912081718.3827390-3-tzungbi@kernel.org
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
index 15d45289fda6..1f12100d1ab7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21957,6 +21957,7 @@ M:	Tzung-Bi Shih <tzungbi@kernel.org>
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
index 000000000000..1c3e08ba0505
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
+ * - Macro: Same as "Revocation" but uses the REVOCABLE_TRY_ACCESS_WITH().
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
+	revocable_withdraw_access(rev);
+
+	revocable_free(rev);
+	revocable_provider_revoke(rp);
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
+	revocable_withdraw_access(rev);
+
+	revocable_provider_revoke(rp);
+
+	res = revocable_try_access(rev);
+	KUNIT_EXPECT_PTR_EQ(test, res, NULL);
+	revocable_withdraw_access(rev);
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
+	REVOCABLE_TRY_ACCESS_WITH(rev, res) {
+		KUNIT_EXPECT_PTR_EQ(test, res, real_res);
+		accessed = true;
+	}
+	KUNIT_EXPECT_TRUE(test, accessed);
+
+	revocable_provider_revoke(rp);
+
+	accessed = false;
+	REVOCABLE_TRY_ACCESS_WITH(rev, res) {
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
2.51.0.534.gc79095c0ca-goog


