Return-Path: <linux-kselftest+bounces-43281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11CEBE1893
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 07:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B32B480416
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 05:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5F423E350;
	Thu, 16 Oct 2025 05:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNdC3TDw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82023D7F2;
	Thu, 16 Oct 2025 05:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593378; cv=none; b=cOeO/D3QDe9S0eQRk19QjYDU4ZDz5f66wphmVydLxPlJ6/QgmEBX69xvs3HrNinSwi/4i6mDewzX9pl3+W8Q18nBlzxaH+PiZX4T4zbSp/0JSIrseKH9tIbY1HfgrjTOocaMqfdT8Xf0VUnoe39mF0eBTvrNEMVrWObcVVQJzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593378; c=relaxed/simple;
	bh=ul0VQspZhYdpEYWb1FJ2kj/iE20/cXl7bZTbEN6NO2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPU11XC3CRqntRxs/kbIbYI35dxFEcP1gGuSNU0GSlxO8HANzW3trHTqIF3BvJUeRNWzDYPTJUj8zgd4kjqjMgo0wYgACA2dtHRYbwRVhBrtIxGD+ium3GGjJtmQ0VAr/ladGSamAu5VPBj0QdrMhoVi5F/qcCExq7gki2CitCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNdC3TDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D59EC4CEFE;
	Thu, 16 Oct 2025 05:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760593378;
	bh=ul0VQspZhYdpEYWb1FJ2kj/iE20/cXl7bZTbEN6NO2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cNdC3TDwm+MzVUM9hW9cW01rpKoWrjYOZ5+GdaIPoncDzNfwgelneWQxqzBOXtp7b
	 DHLuDMmVkEW8dz36bUlDLT/D3RGMHo31CUrULcbxSJZLHh2f291AjiP0JhXjAEvyxM
	 JEpfoGjXoldR7Bnwxb7HPfIuW4kMP4a2pEHvEHpO5G+ifpsaf069xGkKlmNwGfvmRq
	 /3Obl+y8gOoUbcnmThVq5upAWM7B+95lL9xh70QItWVad16S69uyesF7BRiawGatiV
	 cMWs+HVZJbFS0pTH2zH92P+lajoPBduGuDKKI45FMlmsG2/0UTkGs7GShmF1ptT8Sa
	 gVkf+SmYSiTjQ==
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
Subject: [PATCH v5 2/7] revocable: Add Kunit test cases
Date: Thu, 16 Oct 2025 05:41:59 +0000
Message-ID: <20251016054204.1523139-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
In-Reply-To: <20251016054204.1523139-1-tzungbi@kernel.org>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
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
v5:
- No changes.

v4: https://lore.kernel.org/chrome-platform/20250923075302.591026-3-tzungbi@kernel.org
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
index 7d00ff431af9..7207538f31f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22025,6 +22025,7 @@ M:	Tzung-Bi Shih <tzungbi@kernel.org>
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
2.51.0.788.g6d19910ace-goog


