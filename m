Return-Path: <linux-kselftest+bounces-49101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBBAD2DB16
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2F9830C26BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497582EDD57;
	Fri, 16 Jan 2026 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzNaGfMs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CADE2EA16A;
	Fri, 16 Jan 2026 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550604; cv=none; b=UOLp9GZdaKKIJnXnf2EGZL2IcTJoaWxeoSo6IOaurkn34+PgMizYdTCwsC3jD6fJhVNvAz5EDIHBAahHe/zaxHCnUugugbWSqAv7wTwfF0oTGFsTKMWUvhdlIw55MAQqZbncRZzKi8id1OxXDyXTtzCDD18yc3bXsExaf9e5N6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550604; c=relaxed/simple;
	bh=34BVjBvX5lK3lNQk7gr0ARLP4Kd8ezVIdxO/YL4kztc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvSUDNoD5e6MXjlG/VMLzFhIh0kDpgnK6f01R1uSIlfuuoxOGSV0HFpV6444EI8sgbjtXhZRuiR4D81RaZzVBZ3aOsxmKStAQ4Weu80p28Zncknw54fJyxQxUL6fKJ6eqMlyzDHofdtjFxPSy0PE5KVBvSkHTPqfSSK9XJpzS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzNaGfMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024D0C19424;
	Fri, 16 Jan 2026 08:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768550603;
	bh=34BVjBvX5lK3lNQk7gr0ARLP4Kd8ezVIdxO/YL4kztc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzNaGfMsj1eX/guULntLgkaQeqRjgljFyoQuYxesbL89YA+/tWCPtG82wBEhUJWc1
	 zlXUYKEazeLJqmC92xxzo6J3ZxXLImi/Io1GtC7eM+Qj7Eby2DflGfv2EashoJawRL
	 6LBva/RlqIZsQeIB1KjZyHPVRd+3D+aC0e564G3XtokNQn7nFf0cQUeE1y/Yvh9v1z
	 uK/fmP49XAotNxlqILPSFRBEeLWbzg0ieBLTJ41IsWsUFRWcQ52SWSE7WRpU8MiyK/
	 tVAKPDlx06Fy1RdIdKtQ9geS0eH1TafruYjgCt52dCEcIWZyH6+WqX6ZdL97n6vE1G
	 beZUUWyzFcE2A==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	linux-gpio@vger.kernel.org
Subject: [PATCH v7 2/3] revocable: Add Kunit test cases
Date: Fri, 16 Jan 2026 08:02:34 +0000
Message-ID: <20260116080235.350305-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260116080235.350305-1-tzungbi@kernel.org>
References: <20260116080235.350305-1-tzungbi@kernel.org>
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
- Try Access Macro: Same as "Revocation" but uses the
  REVOCABLE_TRY_ACCESS_WITH() and REVOCABLE_TRY_ACCESS_SCOPED().

A way to run the test:
$ ./tools/testing/kunit/kunit.py run \
        --kconfig_add CONFIG_REVOCABLE_KUNIT_TEST=y \
        revocable_test

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v7:
- "2025" -> "2026" in copyright.
- Rename the test name "macro" -> "try_access_macro".

v6: https://lore.kernel.org/chrome-platform/20251106152330.11733-3-tzungbi@kernel.org
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
index fd683c62012a..8e237833a17a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22522,6 +22522,7 @@ M:	Tzung-Bi Shih <tzungbi@kernel.org>
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
index 000000000000..28d46ce1ba0c
--- /dev/null
+++ b/drivers/base/revocable_test.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2026 Google LLC
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
+ * - Try Access Macro: Same as "Revocation" but uses the
+ *   REVOCABLE_TRY_ACCESS_WITH() and REVOCABLE_TRY_ACCESS_SCOPED().
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
+static void revocable_test_try_access_macro(struct kunit *test)
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
+static void revocable_test_try_access_macro2(struct kunit *test)
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
+	KUNIT_CASE(revocable_test_try_access_macro),
+	KUNIT_CASE(revocable_test_try_access_macro2),
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
2.52.0.457.g6b5491de43-goog


