Return-Path: <linux-kselftest+bounces-49125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6139D2DD60
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8C4E306D733
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DD43090E8;
	Fri, 16 Jan 2026 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n241nB2t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F6F3090CD;
	Fri, 16 Jan 2026 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551131; cv=none; b=m9vBte+ZMO8j8cwemqk1j1gqsFy55Bs64mkg4L0KJJk4tp3kxq7bQWD7xxZgOOZYVkD0x33DiHlnqPU4HJGCwCcTfHvKfbnxnJCh/8fz54v+i/DOaPD9m40pL5UuFjStIabHfaMis2slpNBVqgcR+JEHG8XZRN0oOzPxbxHjWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551131; c=relaxed/simple;
	bh=7tBqV9j7P8G1fB3I5YNIZFvB/n4tcIoLisJnBZeapCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3oOLVLiXs/VbGuultlcsvSErQb82HDbIsD3ELdXJOGeLG1mdRFWQ4dDCbXqfrFtAyUTBZw9YJxsP4RmGveLmlT4s0BayjmeEX4cYHFzlCT5eqs1l7tLcgpYP/l6j8omWnBcz2/cA59NSuy74LKE2DWqUaNa5P+fEFe4UWKcJWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n241nB2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009A6C19424;
	Fri, 16 Jan 2026 08:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551131;
	bh=7tBqV9j7P8G1fB3I5YNIZFvB/n4tcIoLisJnBZeapCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n241nB2ttxCxrTSV8LZ0ESEcnklduNofHgJzhiXHXavGZ3qhkEm5hcHf5bAEvuSIe
	 XcDMpTloo7zXoccWfEydTeOZF7M2pSGbI06ztsTrpFbD/R48qhSWzfa5sl6e9hihFT
	 6xOY7c+jORvIm49DozmuVy6hfSVyf2nRmhJ1gQ312suLbkM5Eicz0OAuj17KkKvgkp
	 3OXgxq4IyCW4Up2LhXQtq0fqIl7WsIgPRKb6VYfyE1MiYsS8WDsNQ+SxaNWDW7zm2R
	 g7GVXABlbBhKOq1d9w1cxcJ6Tsuf1gZ9xVA2ZLCyHWqMNt3HiYonccZRpg9acVjCGL
	 ZXpTyISb4DZyQ==
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
Subject: [PATCH 21/23] selftests: revocable: Add test case for DEFINE_REVOCABLE()
Date: Fri, 16 Jan 2026 08:10:34 +0000
Message-ID: <20260116081036.352286-22-tzungbi@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260116081036.352286-1-tzungbi@kernel.org>
References: <20260116081036.352286-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftest case to verify DEFINE_REVOCABLE() can successfully access
the resource.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 .../drivers/base/revocable/revocable_test.c   | 12 ++++++
 .../revocable/test_modules/revocable_test.c   | 37 +++++++++++++++----
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/base/revocable/revocable_test.c b/tools/testing/selftests/drivers/base/revocable/revocable_test.c
index f024164e9273..723e5ea9ec84 100644
--- a/tools/testing/selftests/drivers/base/revocable/revocable_test.c
+++ b/tools/testing/selftests/drivers/base/revocable/revocable_test.c
@@ -14,6 +14,9 @@
  *
  * - Try Access Macro: Same as "Revocation" but uses the
  *   REVOCABLE_TRY_ACCESS_WITH() and REVOCABLE_TRY_ACCESS_SCOPED().
+ *
+ * - Define Macro: Verifies DEFINE_REVOCABLE() can successfully access the
+ *   resource.
  */
 
 #include <fcntl.h>
@@ -26,6 +29,7 @@
 #define TEST_DATA "12345678"
 #define TEST_MAGIC_OFFSET 0x1234
 #define TEST_MAGIC_OFFSET2 0x5678
+#define TEST_MAGIC_OFFSET3 0x9abc
 
 FIXTURE(revocable_fixture) {
 	int pfd;
@@ -133,4 +137,12 @@ TEST_F(revocable_fixture, try_access_macro2) {
 	EXPECT_STREQ("(null)", data);
 }
 
+TEST_F(revocable_fixture, define_macro) {
+	char data[16];
+
+	READ_TEST_DATA(self->cfd, TEST_MAGIC_OFFSET3, data,
+		       "failed to read test data");
+	EXPECT_STREQ(TEST_DATA, data);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/drivers/base/revocable/test_modules/revocable_test.c b/tools/testing/selftests/drivers/base/revocable/test_modules/revocable_test.c
index 1b0692eb75f3..d3bd0ce3a645 100644
--- a/tools/testing/selftests/drivers/base/revocable/test_modules/revocable_test.c
+++ b/tools/testing/selftests/drivers/base/revocable/test_modules/revocable_test.c
@@ -13,6 +13,7 @@
 #define TEST_CMD_RESOURCE_GONE "resource_gone"
 #define TEST_MAGIC_OFFSET 0x1234
 #define TEST_MAGIC_OFFSET2 0x5678
+#define TEST_MAGIC_OFFSET3 0x9abc
 
 static struct dentry *debugfs_dir;
 
@@ -22,15 +23,27 @@ struct revocable_test_provider_priv {
 	char res[16];
 };
 
+struct revocable_test_consumer_priv {
+	struct revocable_provider *rp;
+	struct revocable *rev;
+};
+
 static int revocable_test_consumer_open(struct inode *inode, struct file *filp)
 {
-	struct revocable *rev;
 	struct revocable_provider *rp = inode->i_private;
+	struct revocable_test_consumer_priv *priv;
 
-	rev = revocable_alloc(rp);
-	if (!rev)
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
-	filp->private_data = rev;
+
+	priv->rp = rp;
+	priv->rev = revocable_alloc(rp);
+	if (!priv->rev) {
+		kfree(priv);
+		return -ENOMEM;
+	}
+	filp->private_data = priv;
 
 	return 0;
 }
@@ -38,9 +51,10 @@ static int revocable_test_consumer_open(struct inode *inode, struct file *filp)
 static int revocable_test_consumer_release(struct inode *inode,
 					   struct file *filp)
 {
-	struct revocable *rev = filp->private_data;
+	struct revocable_test_consumer_priv *priv = filp->private_data;
 
-	revocable_free(rev);
+	revocable_free(priv->rev);
+	kfree(priv);
 	return 0;
 }
 
@@ -51,7 +65,8 @@ static ssize_t revocable_test_consumer_read(struct file *filp,
 	char *res;
 	char data[16];
 	size_t len;
-	struct revocable *rev = filp->private_data;
+	struct revocable_test_consumer_priv *priv = filp->private_data;
+	struct revocable *rev = priv->rev;
 
 	switch (*offset) {
 	case 0:
@@ -69,6 +84,14 @@ static ssize_t revocable_test_consumer_read(struct file *filp,
 		REVOCABLE_TRY_ACCESS_SCOPED(rev, res)
 			snprintf(data, sizeof(data), "%s", res ?: "(null)");
 		break;
+	case TEST_MAGIC_OFFSET3:
+		{
+			DEFINE_REVOCABLE(rev_on_stack, priv->rp);
+
+			REVOCABLE_TRY_ACCESS_WITH(rev_on_stack, res);
+			snprintf(data, sizeof(data), "%s", res ?: "(null)");
+		}
+		break;
 	default:
 		return 0;
 	}
-- 
2.52.0.457.g6b5491de43-goog


