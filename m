Return-Path: <linux-kselftest+bounces-43282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871D8BE189C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 07:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4AC519C6468
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 05:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880A6244EA1;
	Thu, 16 Oct 2025 05:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWOmFgv9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5849E23ABB9;
	Thu, 16 Oct 2025 05:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593382; cv=none; b=PxJqmXXqz5J9OgUJNxzLkjMvsrJcl46/kBewWrRqQaznRc3EGZs27wprAPWUNxYQl4P3WQbhQ1iAYrF2n508w3xjNmCTx42kelIbHMks9Jp7K2XTmV0l0wnbosOCNk78It6+M7LNqH44x9BuCxEl9cUoeT7WhRQKQA1U77a7TCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593382; c=relaxed/simple;
	bh=Nj/qXhVShqIQkLxR4oWGDNi4Z/Jn2cjhmgEx0jHFZU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQFXg4DcRanQEFvsF4yacylijFOoMxFGLKTVZnLgrLq3XhIGrAsb2Vadw2aFB/h5XpCl11L9NNSdLAWyoYeFAunGA/2PeZbKSxWSvVqfVGVAVXZ7Mym4qL8PwyhxbJeRy5J0OVBrT/XCK7OHpTcz8VvpYF3MHP+GgeUIEj8K1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWOmFgv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5600AC4CEF1;
	Thu, 16 Oct 2025 05:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760593380;
	bh=Nj/qXhVShqIQkLxR4oWGDNi4Z/Jn2cjhmgEx0jHFZU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pWOmFgv9EJZX21GRtghKojpDiHAuVyldd3pHAXVWhHGzphtJ0MJs+nEimlFNejpeJ
	 OqkaiQuRoo6kJCf0mZDnzlGpAFEhyfWn42KEJO/6Ln0kdaNSp7702ZMKxYSsG5klrj
	 qBZ03GcTCA2u9NGKV8SRReVkmKVJQyem4vmhXc+7uhyUUEq1y4ufQZEwREYOjFOuBz
	 oa3ms/hCkp6/Cl9YbmmSN3iR99e8uFWTWQided0RLA17ubep/RBIKAnU5QBX+tETpP
	 KhZ6gyFUAC4ggTHHu1QvBS3/oI3ALc/akKUnrr9XlkqXm8EMim4eItztWIOCVc5F2B
	 9VvRDy8HxAJug==
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
Subject: [PATCH v5 3/7] selftests: revocable: Add kselftest cases
Date: Thu, 16 Oct 2025 05:42:00 +0000
Message-ID: <20251016054204.1523139-4-tzungbi@kernel.org>
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

Add kselftest cases for the revocable API.

The test consists of three parts:
- A kernel module (revocable_test.ko) that creates a debugfs interface
  with `/provider` and `/consumer` files.
- A user-space C program (revocable_test) that uses the kselftest
  harness to interact with the debugfs files.
- An orchestrating shell script (test-revocable.sh) that loads the
  module, runs the C program, and unloads the module.

The test cases cover the following scenarios:
- Basic: Verifies that a consumer can successfully access the resource
  provided via the provider.
- Revocation: Verifies that after the provider revokes the resource,
  the consumer correctly receives a NULL pointer on a subsequent access.
- Macro: Same as "Revocation" but uses the REVOCABLE().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v5:
- No changes.

v4: https://lore.kernel.org/chrome-platform/20250923075302.591026-4-tzungbi@kernel.org
- REVOCABLE() -> REVOCABLE_TRY_ACCESS_WITH().
- revocable_release() -> revocable_withdraw_access().

v3: https://lore.kernel.org/chrome-platform/20250912081718.3827390-4-tzungbi@kernel.org
- No changes.

v2: https://lore.kernel.org/chrome-platform/20250820081645.847919-4-tzungbi@kernel.org
- New in the series.

A way to run the kselftest (for my reference):
- Update kernel to the DUT.
- `mkdir build` and copy the kernel config to build/.
- `make O=build LLVM=1 -j32` (for generated headers and built-in symbols).
- `make O=build LLVM=1 KDIR=$(pwd) -C tools/testing/selftests/
     TARGETS=drivers/base/revocable gen_tar`.
- Copy build/kselftest/kselftest_install/kselftest-packages/kselftest.tar.gz
  to the DUT, extract, and execute the run_kselftest.sh.

 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/base/revocable/Makefile |   7 +
 .../drivers/base/revocable/revocable_test.c   | 116 +++++++++++
 .../drivers/base/revocable/test-revocable.sh  |  39 ++++
 .../base/revocable/test_modules/Makefile      |  10 +
 .../revocable/test_modules/revocable_test.c   | 188 ++++++++++++++++++
 7 files changed, 362 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/base/revocable/Makefile
 create mode 100644 tools/testing/selftests/drivers/base/revocable/revocable_test.c
 create mode 100755 tools/testing/selftests/drivers/base/revocable/test-revocable.sh
 create mode 100644 tools/testing/selftests/drivers/base/revocable/test_modules/Makefile
 create mode 100644 tools/testing/selftests/drivers/base/revocable/test_modules/revocable_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7207538f31f4..235a1d6e3718 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22027,6 +22027,7 @@ S:	Maintained
 F:	drivers/base/revocable.c
 F:	drivers/base/revocable_test.c
 F:	include/linux/revocable.h
+F:	tools/testing/selftests/drivers/base/revocable/
 
 RFKILL
 M:	Johannes Berg <johannes@sipsolutions.net>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c46ebdb9b8ef..1136a8f12ef5 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -17,6 +17,7 @@ TARGETS += damon
 TARGETS += devices/error_logs
 TARGETS += devices/probe
 TARGETS += dmabuf-heaps
+TARGETS += drivers/base/revocable
 TARGETS += drivers/dma-buf
 TARGETS += drivers/ntsync
 TARGETS += drivers/s390x/uvdevice
diff --git a/tools/testing/selftests/drivers/base/revocable/Makefile b/tools/testing/selftests/drivers/base/revocable/Makefile
new file mode 100644
index 000000000000..afa5ca0fa452
--- /dev/null
+++ b/tools/testing/selftests/drivers/base/revocable/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_GEN_MODS_DIR := test_modules
+TEST_GEN_PROGS_EXTENDED := revocable_test
+TEST_PROGS := test-revocable.sh
+
+include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/base/revocable/revocable_test.c b/tools/testing/selftests/drivers/base/revocable/revocable_test.c
new file mode 100644
index 000000000000..3c0feb7a8944
--- /dev/null
+++ b/tools/testing/selftests/drivers/base/revocable/revocable_test.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Google LLC
+ *
+ * A selftest for the revocable API.
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
+#include <fcntl.h>
+#include <unistd.h>
+
+#include "../../../kselftest_harness.h"
+
+#define DEBUGFS_PATH "/sys/kernel/debug/revocable_test"
+#define TEST_CMD_RESOURCE_GONE "resource_gone"
+#define TEST_DATA "12345678"
+#define TEST_MAGIC_OFFSET 0x1234
+
+FIXTURE(revocable_fixture) {
+	int pfd;
+	int cfd;
+};
+
+FIXTURE_SETUP(revocable_fixture) {
+	int ret;
+
+	self->pfd = open(DEBUGFS_PATH "/provider", O_WRONLY);
+	ASSERT_NE(-1, self->pfd)
+		TH_LOG("failed to open provider fd");
+
+	ret = write(self->pfd, TEST_DATA, strlen(TEST_DATA));
+	ASSERT_NE(-1, ret) {
+		close(self->pfd);
+		TH_LOG("failed to write test data");
+	}
+
+	self->cfd = open(DEBUGFS_PATH "/consumer", O_RDONLY);
+	ASSERT_NE(-1, self->cfd)
+		TH_LOG("failed to open consumer fd");
+}
+
+FIXTURE_TEARDOWN(revocable_fixture) {
+	close(self->cfd);
+	close(self->pfd);
+}
+
+/*
+ * ASSERT_* is only available in TEST or TEST_F block.  Use
+ * macro for the helper.
+ */
+#define READ_TEST_DATA(_fd, _offset, _data, _msg)			\
+	do {								\
+		int ret;						\
+									\
+		ret = lseek(_fd, _offset, SEEK_SET);			\
+		ASSERT_NE(-1, ret)					\
+			TH_LOG("failed to lseek");			\
+									\
+		ret = read(_fd, _data, sizeof(_data) - 1);		\
+		ASSERT_NE(-1, ret)					\
+			TH_LOG(_msg);					\
+		data[ret] = '\0';					\
+	} while (0)
+
+TEST_F(revocable_fixture, basic) {
+	char data[16];
+
+	READ_TEST_DATA(self->cfd, 0, data, "failed to read test data");
+	EXPECT_STREQ(TEST_DATA, data);
+}
+
+TEST_F(revocable_fixture, revocation) {
+	char data[16];
+	int ret;
+
+	READ_TEST_DATA(self->cfd, 0, data, "failed to read test data");
+	EXPECT_STREQ(TEST_DATA, data);
+
+	ret = write(self->pfd, TEST_CMD_RESOURCE_GONE,
+		    strlen(TEST_CMD_RESOURCE_GONE));
+	ASSERT_NE(-1, ret)
+		TH_LOG("failed to write resource gone cmd");
+
+	READ_TEST_DATA(self->cfd, 0, data,
+		       "failed to read test data after resource gone");
+	EXPECT_STREQ("(null)", data);
+}
+
+TEST_F(revocable_fixture, macro) {
+	char data[16];
+	int ret;
+
+	READ_TEST_DATA(self->cfd, TEST_MAGIC_OFFSET, data,
+		       "failed to read test data");
+	EXPECT_STREQ(TEST_DATA, data);
+
+	ret = write(self->pfd, TEST_CMD_RESOURCE_GONE,
+		    strlen(TEST_CMD_RESOURCE_GONE));
+	ASSERT_NE(-1, ret)
+		TH_LOG("failed to write resource gone cmd");
+
+	READ_TEST_DATA(self->cfd, TEST_MAGIC_OFFSET, data,
+		       "failed to read test data after resource gone");
+	EXPECT_STREQ("(null)", data);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/drivers/base/revocable/test-revocable.sh b/tools/testing/selftests/drivers/base/revocable/test-revocable.sh
new file mode 100755
index 000000000000..3a34be28001a
--- /dev/null
+++ b/tools/testing/selftests/drivers/base/revocable/test-revocable.sh
@@ -0,0 +1,39 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+mod_name="revocable_test"
+ksft_fail=1
+ksft_skip=4
+
+if [ "$(id -u)" -ne 0 ]; then
+	echo "$0: Must be run as root"
+	exit "$ksft_skip"
+fi
+
+if ! which insmod > /dev/null 2>&1; then
+	echo "$0: Need insmod"
+	exit "$ksft_skip"
+fi
+
+if ! which rmmod > /dev/null 2>&1; then
+	echo "$0: Need rmmod"
+	exit "$ksft_skip"
+fi
+
+insmod test_modules/"${mod_name}".ko
+
+if [ ! -d /sys/kernel/debug/revocable_test/ ]; then
+	mount -t debugfs none /sys/kernel/debug/
+
+	if [ ! -d /sys/kernel/debug/revocable_test/ ]; then
+		echo "$0: Error mounting debugfs"
+		exit "$ksft_fail"
+	fi
+fi
+
+./revocable_test
+ret=$?
+
+rmmod "${mod_name}"
+
+exit "${ret}"
diff --git a/tools/testing/selftests/drivers/base/revocable/test_modules/Makefile b/tools/testing/selftests/drivers/base/revocable/test_modules/Makefile
new file mode 100644
index 000000000000..f29e4f909402
--- /dev/null
+++ b/tools/testing/selftests/drivers/base/revocable/test_modules/Makefile
@@ -0,0 +1,10 @@
+TESTMODS_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= /lib/modules/$(shell uname -r)/build
+
+obj-m += revocable_test.o
+
+all:
+	$(Q)$(MAKE) -C $(KDIR) M=$(TESTMODS_DIR)
+
+clean:
+	$(Q)$(MAKE) -C $(KDIR) M=$(TESTMODS_DIR) clean
diff --git a/tools/testing/selftests/drivers/base/revocable/test_modules/revocable_test.c b/tools/testing/selftests/drivers/base/revocable/test_modules/revocable_test.c
new file mode 100644
index 000000000000..c90ec150a6c8
--- /dev/null
+++ b/tools/testing/selftests/drivers/base/revocable/test_modules/revocable_test.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Google LLC
+ *
+ * A kernel module for testing the revocable API.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/revocable.h>
+#include <linux/slab.h>
+
+#define TEST_CMD_RESOURCE_GONE "resource_gone"
+#define TEST_MAGIC_OFFSET 0x1234
+
+static struct dentry *debugfs_dir;
+
+struct revocable_test_provider_priv {
+	struct revocable_provider *rp;
+	struct dentry *dentry;
+	char res[16];
+};
+
+static int revocable_test_consumer_open(struct inode *inode, struct file *filp)
+{
+	struct revocable *rev;
+	struct revocable_provider *rp = inode->i_private;
+
+	rev = revocable_alloc(rp);
+	if (!rev)
+		return -ENOMEM;
+	filp->private_data = rev;
+
+	return 0;
+}
+
+static int revocable_test_consumer_release(struct inode *inode,
+					   struct file *filp)
+{
+	struct revocable *rev = filp->private_data;
+
+	revocable_free(rev);
+	return 0;
+}
+
+static ssize_t revocable_test_consumer_read(struct file *filp,
+					    char __user *buf,
+					    size_t count, loff_t *offset)
+{
+	char *res;
+	char data[16];
+	size_t len;
+	struct revocable *rev = filp->private_data;
+
+	switch (*offset) {
+	case 0:
+		res = revocable_try_access(rev);
+		snprintf(data, sizeof(data), "%s", res ?: "(null)");
+		revocable_withdraw_access(rev);
+		break;
+	case TEST_MAGIC_OFFSET:
+		REVOCABLE_TRY_ACCESS_WITH(rev, res)
+			snprintf(data, sizeof(data), "%s", res ?: "(null)");
+		break;
+	default:
+		return 0;
+	}
+
+	len = min_t(size_t, strlen(data), count);
+	if (copy_to_user(buf, data, len))
+		return -EFAULT;
+
+	*offset = len;
+	return len;
+}
+
+static const struct file_operations revocable_test_consumer_fops = {
+	.open = revocable_test_consumer_open,
+	.release = revocable_test_consumer_release,
+	.read = revocable_test_consumer_read,
+	.llseek = default_llseek,
+};
+
+static int revocable_test_provider_open(struct inode *inode, struct file *filp)
+{
+	struct revocable_test_provider_priv *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	filp->private_data = priv;
+
+	return 0;
+}
+
+static int revocable_test_provider_release(struct inode *inode,
+					   struct file *filp)
+{
+	struct revocable_test_provider_priv *priv = filp->private_data;
+
+	debugfs_remove(priv->dentry);
+	if (priv->rp)
+		revocable_provider_revoke(priv->rp);
+	kfree(priv);
+
+	return 0;
+}
+
+static ssize_t revocable_test_provider_write(struct file *filp,
+					     const char __user *buf,
+					     size_t count, loff_t *offset)
+{
+	size_t copied;
+	char data[64];
+	struct revocable_test_provider_priv *priv = filp->private_data;
+
+	copied = strncpy_from_user(data, buf, sizeof(data));
+	if (copied < 0)
+		return copied;
+	if (copied == sizeof(data))
+		data[sizeof(data) - 1] = '\0';
+
+	/*
+	 * Note: The test can't just close the FD for signaling the
+	 * resource gone.  Subsequent file operations on the opening
+	 * FD of debugfs return -EIO after calling debugfs_remove().
+	 * See also debugfs_file_get().
+	 *
+	 * Here is a side command channel for signaling the resource
+	 * gone.
+	 */
+	if (!strcmp(data, TEST_CMD_RESOURCE_GONE)) {
+		revocable_provider_revoke(priv->rp);
+		priv->rp = NULL;
+	} else {
+		if (priv->res[0] != '\0')
+			return 0;
+
+		strscpy(priv->res, data);
+
+		priv->rp = revocable_provider_alloc(&priv->res);
+		if (!priv->rp)
+			return -ENOMEM;
+
+		priv->dentry = debugfs_create_file("consumer", 0400,
+						   debugfs_dir, priv->rp,
+						   &revocable_test_consumer_fops);
+		if (!priv->dentry) {
+			revocable_provider_revoke(priv->rp);
+			return -ENOMEM;
+		}
+	}
+
+	return copied;
+}
+
+static const struct file_operations revocable_test_provider_fops = {
+	.open = revocable_test_provider_open,
+	.release = revocable_test_provider_release,
+	.write = revocable_test_provider_write,
+};
+
+static int __init revocable_test_init(void)
+{
+	debugfs_dir = debugfs_create_dir("revocable_test", NULL);
+	if (!debugfs_dir)
+		return -ENOMEM;
+
+	if (!debugfs_create_file("provider", 0200, debugfs_dir, NULL,
+				 &revocable_test_provider_fops)) {
+		debugfs_remove_recursive(debugfs_dir);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void __exit revocable_test_exit(void)
+{
+	debugfs_remove_recursive(debugfs_dir);
+}
+
+module_init(revocable_test_init);
+module_exit(revocable_test_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tzung-Bi Shih <tzungbi@kernel.org>");
+MODULE_DESCRIPTION("Revocable Kselftest");
-- 
2.51.0.788.g6d19910ace-goog


