Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38B837FE33
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 21:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhEMThU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 15:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhEMThU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 15:37:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F30C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 12:36:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g1-20020a25b1010000b02904f93e3a9c89so10446227ybj.23
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cg7LEB8jQNZq3myTn8tFgqiZzcPO7JbaemmMCDGoUaE=;
        b=P7DkNhZXPNATPQ3LyKbTzcUPPVgge/+RxDvs6NLJ6CE3huLBWo+UOVkZiZjDOBB+7/
         6m2KQJGaR8iIX6Sq57KEgrxjj1/xUIIA52a8HPi60gDSc8hyw06WIr/2ov79OFhRcd/u
         9tiZwMjYOh5bdzgadKkmlKFhXYSe0lIcFdcyk7jnX77hjWBLAWG1bFgBvTZOLitx3MZq
         sEBFmnGIP88RV+HLXW57SqoGXq6vQzUk4naQjeaFmCfePesEVWdgzlKb1OsG2RAL3YjE
         TLxqGyV9pA4huJy+lF72QdHwanu4OCLUpWkO5CdyJ5IAzE6hNYqwVWcnwFA1lr6LElAd
         sHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cg7LEB8jQNZq3myTn8tFgqiZzcPO7JbaemmMCDGoUaE=;
        b=XJ1j4ATMXyRyxlWJAeKFjuBa6Nhmw96eWdRKLyoRfBq2DiY49DcysizPdqhsFyE/rg
         6Rc4xmSBKtqQ/D6jr4itF6HhbwMAPPRGcdqce6Y67z13K6aUGMRfAfMEx/af2oPlycTC
         iWyBgJ5LrDN6/i+UFtX9tH3ipOnZrJq1FaKtSvn4jz8U4y4kiVddr4fLUKvZ2LsgVSna
         sUyhGWhBpw3KsFwdEUF/ISrNzIqOri1L464PRFXn4glIPy5g+lxE8qEtBqgS8UakifDe
         aqFVGsf5/IQDrjpUqZ9ZJEbhXrTv8iEr2g3SMqLY8FOIf+qYRJjmLaCzDJyqT/OlKAPA
         NeoQ==
X-Gm-Message-State: AOAM530pWuO4PRCY2IxGdgUkzC6AH6fA5jT8HLcetzbGbOgH2oyd0G47
        g2aA5SriF7Il9cDiDbrXbCLR4+ywolRbSA==
X-Google-Smtp-Source: ABdhPJxwmEorznVMeSvDGCzECjTRb26j8WjtHruBIq5AqEixaMnBVukDup9agmpnFnethp0uqnlQPDUofJsuhQ==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:5f61:8ca4:879b:809e])
 (user=davidgow job=sendgmr) by 2002:a25:1855:: with SMTP id
 82mr58263387yby.305.1620934569116; Thu, 13 May 2021 12:36:09 -0700 (PDT)
Date:   Thu, 13 May 2021 12:31:58 -0700
In-Reply-To: <20210513193204.816681-1-davidgow@google.com>
Message-Id: <20210513193204.816681-4-davidgow@google.com>
Mime-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 04/10] device property: Remove some casts in property-entry-test
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With some of the stricter type checking in KUnit's EXPECT macros
removed, several casts in property-entry-test are no longer required.

Remove the unnecessary casts, making the conditions clearer.

Signed-off-by: David Gow <davidgow@google.com>
---

This should be a no-op functionality wise, and while it depends on the
first couple of patches in this series, it's otherwise independent from
the others. I think this makes the test more readable, but if you
particularly dislike it, I'm happy to drop it.

 drivers/base/test/property-entry-test.c | 56 ++++++++++++-------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/base/test/property-entry-test.c b/drivers/base/test/property-entry-test.c
index 1106fedcceed..6071d5bc128c 100644
--- a/drivers/base/test/property-entry-test.c
+++ b/drivers/base/test/property-entry-test.c
@@ -32,11 +32,11 @@ static void pe_test_uints(struct kunit *test)
 
 	error = fwnode_property_read_u8(node, "prop-u8", &val_u8);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u8, 8);
+	KUNIT_EXPECT_EQ(test, val_u8, 8);
 
 	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u8[0], 8);
+	KUNIT_EXPECT_EQ(test, array_u8[0], 8);
 
 	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 2);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -49,14 +49,14 @@ static void pe_test_uints(struct kunit *test)
 
 	error = fwnode_property_read_u16(node, "prop-u16", &val_u16);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u16, 16);
+	KUNIT_EXPECT_EQ(test, val_u16, 16);
 
 	error = fwnode_property_count_u16(node, "prop-u16");
 	KUNIT_EXPECT_EQ(test, error, 1);
 
 	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u16[0], 16);
+	KUNIT_EXPECT_EQ(test, array_u16[0], 16);
 
 	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 2);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -69,14 +69,14 @@ static void pe_test_uints(struct kunit *test)
 
 	error = fwnode_property_read_u32(node, "prop-u32", &val_u32);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u32, 32);
+	KUNIT_EXPECT_EQ(test, val_u32, 32);
 
 	error = fwnode_property_count_u32(node, "prop-u32");
 	KUNIT_EXPECT_EQ(test, error, 1);
 
 	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u32[0], 32);
+	KUNIT_EXPECT_EQ(test, array_u32[0], 32);
 
 	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 2);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -89,14 +89,14 @@ static void pe_test_uints(struct kunit *test)
 
 	error = fwnode_property_read_u64(node, "prop-u64", &val_u64);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u64, 64);
+	KUNIT_EXPECT_EQ(test, val_u64, 64);
 
 	error = fwnode_property_count_u64(node, "prop-u64");
 	KUNIT_EXPECT_EQ(test, error, 1);
 
 	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u64[0], 64);
+	KUNIT_EXPECT_EQ(test, array_u64[0], 64);
 
 	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 2);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -140,19 +140,19 @@ static void pe_test_uint_arrays(struct kunit *test)
 
 	error = fwnode_property_read_u8(node, "prop-u8", &val_u8);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u8, 8);
+	KUNIT_EXPECT_EQ(test, val_u8, 8);
 
 	error = fwnode_property_count_u8(node, "prop-u8");
 	KUNIT_EXPECT_EQ(test, error, 10);
 
 	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u8[0], 8);
+	KUNIT_EXPECT_EQ(test, array_u8[0], 8);
 
 	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 2);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u8[0], 8);
-	KUNIT_EXPECT_EQ(test, (int)array_u8[1], 9);
+	KUNIT_EXPECT_EQ(test, array_u8[0], 8);
+	KUNIT_EXPECT_EQ(test, array_u8[1], 9);
 
 	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 17);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -165,19 +165,19 @@ static void pe_test_uint_arrays(struct kunit *test)
 
 	error = fwnode_property_read_u16(node, "prop-u16", &val_u16);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u16, 16);
+	KUNIT_EXPECT_EQ(test, val_u16, 16);
 
 	error = fwnode_property_count_u16(node, "prop-u16");
 	KUNIT_EXPECT_EQ(test, error, 10);
 
 	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u16[0], 16);
+	KUNIT_EXPECT_EQ(test, array_u16[0], 16);
 
 	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 2);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u16[0], 16);
-	KUNIT_EXPECT_EQ(test, (int)array_u16[1], 17);
+	KUNIT_EXPECT_EQ(test, array_u16[0], 16);
+	KUNIT_EXPECT_EQ(test, array_u16[1], 17);
 
 	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 17);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -190,19 +190,19 @@ static void pe_test_uint_arrays(struct kunit *test)
 
 	error = fwnode_property_read_u32(node, "prop-u32", &val_u32);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u32, 32);
+	KUNIT_EXPECT_EQ(test, val_u32, 32);
 
 	error = fwnode_property_count_u32(node, "prop-u32");
 	KUNIT_EXPECT_EQ(test, error, 10);
 
 	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u32[0], 32);
+	KUNIT_EXPECT_EQ(test, array_u32[0], 32);
 
 	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 2);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u32[0], 32);
-	KUNIT_EXPECT_EQ(test, (int)array_u32[1], 33);
+	KUNIT_EXPECT_EQ(test, array_u32[0], 32);
+	KUNIT_EXPECT_EQ(test, array_u32[1], 33);
 
 	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 17);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -215,19 +215,19 @@ static void pe_test_uint_arrays(struct kunit *test)
 
 	error = fwnode_property_read_u64(node, "prop-u64", &val_u64);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u64, 64);
+	KUNIT_EXPECT_EQ(test, val_u64, 64);
 
 	error = fwnode_property_count_u64(node, "prop-u64");
 	KUNIT_EXPECT_EQ(test, error, 10);
 
 	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u64[0], 64);
+	KUNIT_EXPECT_EQ(test, array_u64[0], 64);
 
 	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 2);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u64[0], 64);
-	KUNIT_EXPECT_EQ(test, (int)array_u64[1], 65);
+	KUNIT_EXPECT_EQ(test, array_u64[0], 64);
+	KUNIT_EXPECT_EQ(test, array_u64[1], 65);
 
 	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 17);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -358,13 +358,13 @@ static void pe_test_move_inline_u8(struct kunit *test)
 
 	KUNIT_EXPECT_TRUE(test, copy[0].is_inline);
 	data_ptr = (u8 *)&copy[0].value;
-	KUNIT_EXPECT_EQ(test, (int)data_ptr[0], 1);
-	KUNIT_EXPECT_EQ(test, (int)data_ptr[1], 2);
+	KUNIT_EXPECT_EQ(test, data_ptr[0], 1);
+	KUNIT_EXPECT_EQ(test, data_ptr[1], 2);
 
 	KUNIT_EXPECT_FALSE(test, copy[1].is_inline);
 	data_ptr = copy[1].pointer;
-	KUNIT_EXPECT_EQ(test, (int)data_ptr[0], 5);
-	KUNIT_EXPECT_EQ(test, (int)data_ptr[1], 6);
+	KUNIT_EXPECT_EQ(test, data_ptr[0], 5);
+	KUNIT_EXPECT_EQ(test, data_ptr[1], 6);
 
 	property_entries_free(copy);
 }
-- 
2.31.1.751.gd2f1c929bd-goog

