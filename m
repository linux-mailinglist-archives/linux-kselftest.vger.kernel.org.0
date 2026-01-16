Return-Path: <linux-kselftest+bounces-49124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E894BD2DD42
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D45A3069038
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37648307AF4;
	Fri, 16 Jan 2026 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLPh054z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF02FFF9C;
	Fri, 16 Jan 2026 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551129; cv=none; b=qGcacqFnylIvJLBgSTPtfwxKAcxCHVOVo3tJCw104EHQcG6IGDGNOa6CnSs9JH90uvXZafl4ByXIWRlMxKHU4ZDOAp6DW9uRHRbrqCQ9gMbttP0mkjb5l+lCWcbWSjyQm4zOJAqDV+c0Tc2AOxMhtLHV7OwPTAB9l4HHG4iPL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551129; c=relaxed/simple;
	bh=3wWqog/hH+uf26p1Ea1XMOzG0f11uU/kA8DJrrsfFEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ba5lXnkeV1C4cHuLc5G8HPXfDtdfZHz8CBu30I0vEimrlYEr42wcwZfEir/j8YM9IKiszZWExixrReXkzQ4sWtvSHv9OgaUtzJnD+I35PxHqQVS0G9F4wK8jsmH19w6v6x9rwx99AkCCIxlJXAyezKIJY4HfCcI1RE+7RQRSmGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLPh054z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF097C19421;
	Fri, 16 Jan 2026 08:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551128;
	bh=3wWqog/hH+uf26p1Ea1XMOzG0f11uU/kA8DJrrsfFEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLPh054zT8+E3J2ETrOGD8c98u4RKLVaGM40R9u4/eaum+07wsXMKQ3lFTiCjDHzy
	 9CJ326fQ+LcCiDnZf9oBwbDDh3eGJpIGiRagW1hhokeoXSCJlZj3TEoySn+kemsxLl
	 Eq8zrFrZNXvkgp5LbFbX8HIFbQZ3qQ1R2rGAbMs49cKwkFSOJJDYaWo9Qe2Etox/jo
	 BM+RobkCZB8NocYEBwKA7wZCRzvd5XymiVB8ZK5+dqpWcpyjN4bu+/o0yCaMq1NCJs
	 CtDB2xiO9o5Bhsulokc8cA0arIpq46J75Rydmsye0KdtKkLmpbVOQwKDdxwHKjcIO5
	 Rbe67sweQkz5Q==
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
Subject: [PATCH 20/23] revocable: Add Kunit test case for DEFINE_REVOCABLE()
Date: Fri, 16 Jan 2026 08:10:33 +0000
Message-ID: <20260116081036.352286-21-tzungbi@kernel.org>
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

Add Kunit test case to verify DEFINE_REVOCABLE() can successfully access
the resource and drop the reference count.

A way to run the test:
$ ./tools/testing/kunit/kunit.py run \
        --kconfig_add CONFIG_REVOCABLE_KUNIT_TEST=y \
        revocable_test

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/base/revocable_test.c | 54 +++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/base/revocable_test.c b/drivers/base/revocable_test.c
index 28d46ce1ba0c..e0efffe6e04f 100644
--- a/drivers/base/revocable_test.c
+++ b/drivers/base/revocable_test.c
@@ -14,10 +14,15 @@
  *
  * - Try Access Macro: Same as "Revocation" but uses the
  *   REVOCABLE_TRY_ACCESS_WITH() and REVOCABLE_TRY_ACCESS_SCOPED().
+ *
+ * - Define Macro: Verifies DEFINE_REVOCABLE() can successfully access the
+ *   resource and drop the reference count.
  */
 
 #include <kunit/test.h>
+#include <linux/kref.h>
 #include <linux/revocable.h>
+#include <linux/srcu.h>
 
 static void revocable_test_basic(struct kunit *test)
 {
@@ -123,11 +128,60 @@ static void revocable_test_try_access_macro2(struct kunit *test)
 	revocable_free(rev);
 }
 
+static void revocable_test_define_macro(struct kunit *test)
+{
+	/* To access the opaque struct */
+	struct {
+		struct srcu_struct srcu;
+		void *res;
+		struct kref kref;
+	} *_rp;
+	struct revocable_provider *rp;
+	void *real_res = (void *)0x12345678, *res;
+
+	rp = revocable_provider_alloc(real_res);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rp);
+
+	_rp = (void *)rp;
+	KUNIT_EXPECT_EQ(test, kref_read(&_rp->kref), 1);
+
+	{
+		DEFINE_REVOCABLE(rev, rp);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rev);
+		KUNIT_EXPECT_EQ(test, kref_read(&_rp->kref), 2);
+
+		REVOCABLE_TRY_ACCESS_WITH(rev, res);
+		KUNIT_EXPECT_PTR_EQ(test, res, real_res);
+	}
+	KUNIT_EXPECT_EQ(test, kref_read(&_rp->kref), 1);
+
+	{
+		bool accessed = false;
+
+		DEFINE_REVOCABLE(rev, rp);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rev);
+		KUNIT_EXPECT_EQ(test, kref_read(&_rp->kref), 2);
+
+		REVOCABLE_TRY_ACCESS_SCOPED(rev, res) {
+			KUNIT_EXPECT_PTR_EQ(test, res, real_res);
+			accessed = true;
+		}
+		KUNIT_EXPECT_TRUE(test, accessed);
+
+		revocable_provider_revoke(rp);
+		KUNIT_EXPECT_EQ(test, kref_read(&_rp->kref), 1);
+
+		REVOCABLE_TRY_ACCESS_WITH(rev, res);
+		KUNIT_EXPECT_PTR_EQ(test, res, NULL);
+	}
+}
+
 static struct kunit_case revocable_test_cases[] = {
 	KUNIT_CASE(revocable_test_basic),
 	KUNIT_CASE(revocable_test_revocation),
 	KUNIT_CASE(revocable_test_try_access_macro),
 	KUNIT_CASE(revocable_test_try_access_macro2),
+	KUNIT_CASE(revocable_test_define_macro),
 	{}
 };
 
-- 
2.52.0.457.g6b5491de43-goog


