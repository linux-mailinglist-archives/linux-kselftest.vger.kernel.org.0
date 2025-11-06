Return-Path: <linux-kselftest+bounces-44990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFF7C3C0C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 16:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE543BE6DF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7B227A130;
	Thu,  6 Nov 2025 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUHWfvhJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D25E2777E4;
	Thu,  6 Nov 2025 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442631; cv=none; b=XWGIrEF+PUmXpiY19Yo8n+dph+WMxA09Z5ExAqJd5V9AtR00WWwAGJ/Ar6w5x2Cg9tOnILs5YJIoYcUuJXW5Q6gzP7FW3LpIi0PuoUr1jXAMmePaztaUZ/H4Ix2ih0Ft5kHLL1F7egyxV2oVGP0iaTRu+nwICC5h3vxJ+sp8vRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442631; c=relaxed/simple;
	bh=1RdwYUxlYqkBhYT1iXd6V26u2hwNBSDEOxGo1X2Twbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbQF0bW6gZ+Oyw5/oXbEwgRRT9MAjNTztvBBdtabI8H2bP3fwi6lendUoi6QsRUuthHrxr3tOryT6RZBgfcSGRMbAqKUK68z0cWGDqgPzQvBkJJ72B1ngTWpwPO+ebrL8VTMk1QkLVGNpl0dvHDkDyJPolO4q6TWnYIvDpl7Ito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUHWfvhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73AEC4CEF7;
	Thu,  6 Nov 2025 15:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762442630;
	bh=1RdwYUxlYqkBhYT1iXd6V26u2hwNBSDEOxGo1X2Twbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUHWfvhJ0ja1VzysQ5UXBO8RTn+HFHkht4N5C0CNtzU0Z9VOjvIb6Xv0hwi9RE3HD
	 QIUgPug/B3pXKgrCC/j2uHz8/yEtixqU+T3kdM5FTLX00wLvJleaVSPOnbdruyrrFI
	 3qGkpNPAZlVbEwKiWOZzS11NPGFXTZc1GsRgHlqJRzzBhaAkSGa67dpMWfNudC4sNd
	 O7Uzgyr4HakQFyxWz9AnGFjDLiSzFgooejaLCIGDTA7xj8zKliHg8LfbpIsOovU9xY
	 9SJpzuA9qSlkQ5CFYTOJarLkJgt+VzimfwXAilulva+di8sEIl2zMxN3ZQZgSiCC6q
	 Aeqs1XNqteJug==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 2/3] revocable: Add Kunit test cases
Date: Thu,  6 Nov 2025 23:23:29 +0800
Message-ID: <20251106152330.11733-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106152330.11733-1-tzungbi@kernel.org>
References: <20251106152330.11733-1-tzungbi@kernel.org>
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
- Macro: Same as "Revocation" but uses the REVOCABLE_TRY_ACCESS_WITH()
  and REVOCABLE_TRY_ACCESS_SCOPED().

A way to run the test:
$ ./tools/testing/kunit/kunit.py run \
        --kconfig_add CONFIG_REVOCABLE_KUNIT_TEST=y \
        revocable_test

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v6:
- Rename REVOCABLE_TRY_ACCESS_WITH() -> REVOCABLE_TRY_ACCESS_SCOPED().
- Add tests for new REVOCABLE_TRY_ACCESS_WITH().

v5: https://lore.kernel.org/chrome-platform/20251016054204.1523139-3-tzungbi@kernel.org
- No changes.

v4: https://lore.kernel.org/chrome-platform/20250923075302.591026-3-tzungbi@kernel.org
- REVOCABLE() -> REVOCABLE_TRY_ACCESS_WITH().
- revocable_release() -> revocable_withdraw_access().

v3: https://lore.kernel.org/chrome-platform/20250912081718.3827390-3-tzungbi@kernel.org
- No changes.

v2: https://lore.kernel.org/chrome-platform/20250820081645.847919-3-tzungbi@kernel.org
- New in the series.

 MAINTAINERS                   |   1 +
 drivers/base/Kconfig          |   8 ++
 drivers/base/Makefile         |   3 +
 drivers/base/revocable_test.c | 139 ++++++++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+)
 create mode 100644 drivers/base/revocable_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 811ea5f53d2a..63b96b786e7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22157,6 +22157,7 @@ M:	Tzung-Bi Shih <tzungbi@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/base/revocable.c
+F:	drivers/base/revocable_test.c
 F:	include/linux/revocable.h
 
 RFKILL
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 1786d87b29e2..8f7d7b9d81ac 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -250,3 +250,11 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
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
index 000000000000..cc1a9bbe8718
--- /dev/null
+++ b/drivers/base/revocable_test.c
@@ -0,0 +1,139 @@
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
+ * - Macro: Same as "Revocation" but uses the REVOCABLE_TRY_ACCESS_WITH()
+ *   and REVOCABLE_TRY_ACCESS_SCOPED().
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
+
+	rp = revocable_provider_alloc(real_res);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rp);
+
+	rev = revocable_alloc(rp);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rev);
+
+	{
+		REVOCABLE_TRY_ACCESS_WITH(rev, res);
+		KUNIT_EXPECT_PTR_EQ(test, res, real_res);
+	}
+
+	revocable_provider_revoke(rp);
+
+	{
+		REVOCABLE_TRY_ACCESS_WITH(rev, res);
+		KUNIT_EXPECT_PTR_EQ(test, res, NULL);
+	}
+
+	revocable_free(rev);
+}
+
+static void revocable_test_macro2(struct kunit *test)
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
+	REVOCABLE_TRY_ACCESS_SCOPED(rev, res) {
+		KUNIT_EXPECT_PTR_EQ(test, res, real_res);
+		accessed = true;
+	}
+	KUNIT_EXPECT_TRUE(test, accessed);
+
+	revocable_provider_revoke(rp);
+
+	accessed = false;
+	REVOCABLE_TRY_ACCESS_SCOPED(rev, res) {
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
+	KUNIT_CASE(revocable_test_macro2),
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
2.48.1


