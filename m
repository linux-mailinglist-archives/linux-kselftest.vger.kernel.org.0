Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A651D7B1EAB
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 15:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjI1Nim (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 09:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjI1Nim (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 09:38:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8DC193
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695908320; x=1727444320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q5ocypWNOmyvpafBUolDnPt1gZ4bbwGpzhISkqe5CC4=;
  b=LOiMymVN3WyL/2/egYBIIADMOvyBjbK4Hfu8NYyR2L4Kz/gqm4Du7PaV
   rSddhOFX3Ge8sacgIED93C7rbZJHo50jHPa31jK71DcDdsAVpoweQt9OU
   hQ6d/Kknx4sEC9PtO7xgogjmKVAyTelckpiwnVxKUMMOMxZcSztxufk4w
   6+FJwYR7Xn0c1YhSun5wE0q2XgCjpg8IT0wJMOtBXky+YplIq2XQrI4pb
   7KLHnDYgGDG7fcVHmxMkiQItfGCV2aobPe5oYZ/u44+adpIZ9Jm3omGv8
   Pbs6kgmaPSTMbKJ5FfP9KvjgAeJBgUqClaiKjpmkA0+nS0b6h/oxw/WRf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="361438873"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="361438873"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 06:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="778905401"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="778905401"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.152.119])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 06:38:38 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH 2/2] kunit: Improve format of the PTR_EQ|NE|NULL assertion
Date:   Thu, 28 Sep 2023 15:38:21 +0200
Message-Id: <20230928133821.1467-2-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230928133821.1467-1-michal.wajdeczko@intel.com>
References: <20230928133821.1467-1-michal.wajdeczko@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Diagnostic message for failed KUNIT_ASSERT|EXPECT_PTR_EQ|NE|NULL
shows only raw pointer value, like in this example:

[ ] # example_all_expect_macros_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:127
[ ] Expected myptr == ((void *)0), but
[ ]     myptr == fffffffffffffff4
[ ]     ((void *)0) == 0000000000000000

but we can improve this by detecting whether pointer was NULL or
error, and use friendly error pointer format if possible:

[ ] # example_all_expect_macros_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:127
[ ] Expected myptr == ((void *)0), but
[ ]     myptr is -ENOMEM
[ ]     ((void *)0) is NULL

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 lib/kunit/assert.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 96ef236d3ca3..f490aad02c46 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -153,12 +153,28 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 			  binary_assert->text->left_text,
 			  binary_assert->text->operation,
 			  binary_assert->text->right_text);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px\n",
-			  binary_assert->text->left_text,
-			  binary_assert->left_value);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px",
-			  binary_assert->text->right_text,
-			  binary_assert->right_value);
+	if (!binary_assert->left_value)
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is NULL\n",
+				  binary_assert->text->left_text);
+	else if (IS_ERR(binary_assert->left_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is %pe\n",
+				  binary_assert->text->left_text,
+				  binary_assert->left_value);
+	else
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px\n",
+				  binary_assert->text->left_text,
+				  binary_assert->left_value);
+	if (!binary_assert->right_value)
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is NULL\n",
+				  binary_assert->text->right_text);
+	else if (IS_ERR(binary_assert->right_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is %pe\n",
+				  binary_assert->text->right_text,
+				  binary_assert->right_value);
+	else
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px\n",
+				  binary_assert->text->right_text,
+				  binary_assert->right_value);
 	kunit_assert_print_msg(message, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
-- 
2.25.1

