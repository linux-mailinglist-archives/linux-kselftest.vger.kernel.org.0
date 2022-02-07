Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566DD4AC8B0
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 19:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiBGSgx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 13:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbiBGSdN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 13:33:13 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8454C0401DF
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 10:33:12 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a8so44677284ejc.8
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 10:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=760cUhZxPNwETk5wV5EY2nvw4jOkyadVdKCIRfo19SI=;
        b=JyS9GZHnjT9bhoYUISD8JLhKUztSrq34E7LzMSEG+Fku+syoufX3e03dE7yrNoZbHa
         A1oG97ObiGt8mcyfXCRapvZiT7ZXfd5Zc0fGUwBwgQzHelrmGtN0Oje6Z4mFu4973Z/M
         rc4IEWwsZlXBbBubVfzLHMO6Yzblc/tLKJO7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=760cUhZxPNwETk5wV5EY2nvw4jOkyadVdKCIRfo19SI=;
        b=mXEnROKniaOOH2lNAAHYQe+WkLXRqbS6zIr3B/c/bheDGkP+rR28ND27rjIrA+4xII
         MGValtjSfaJ/dcXRSHw/skyewzYWR2Des4TDHilg8wb4sK6Y0kPiezseTeZyO1qBGaiI
         P14bL3Ku7ejOcs0VT6yhXQ38UPBmMcRDwkUCli7NjTvsN1s/Z+11KLVt4Yx2vZRBealM
         A5LhujeJequb0EYP5b1/LF3kANorhh0Z5z2HOXDfjXhlgXUVXDWNZOENIcnhikTHY5rl
         Rz1TN6S+5cbFWqadfczv39UR98SaQsIIiTc6idFo3XQaBNOTzgtYldzHasFVqu3whVzd
         qtnw==
X-Gm-Message-State: AOAM531CMV98QTj98etnYOGWkSB6KFYYKnmsZsXDSH2GDf+G3c6F/rrA
        f4szEVE+irkt+dpMzxmi1skNkw==
X-Google-Smtp-Source: ABdhPJzPwW4MN9dFpmeUEHuglwyLi2U4ixfmt41b+Do0yf9A75RFLPmmngIHe2tP9bljAVGBr/Bzhw==
X-Received: by 2002:a17:907:1627:: with SMTP id hb39mr784326ejc.407.1644258791316;
        Mon, 07 Feb 2022 10:33:11 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id k15sm3045173eji.64.2022.02.07.10.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 10:33:10 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 1/6] kunit: Introduce _NULL and _NOT_NULL macros
Date:   Mon,  7 Feb 2022 19:33:03 +0100
Message-Id: <20220207183308.1829495-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Today, when we want to check if a pointer is NULL and not ERR we have
two options:

EXPECT_TRUE(test, ptr == NULL);

or

EXPECT_PTR_NE(test, ptr, (struct mystruct *)NULL);

Create a new set of macros that take care of NULL checks.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/kunit/test.h | 91 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index b26400731c02..a84bf065e64b 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1395,6 +1395,51 @@ do {									       \
 					  ##__VA_ARGS__)
 
 /**
+ * KUNIT_EXPECT_NULL() - Expects that @ptr is null.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an expectation that the value that @ptr evaluates to is null. This is
+ * semantically equivalent to KUNIT_EXPECT_PTR_EQ(@test, NULL, ptr).
+ * See KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_EXPECT_NULL(test, ptr)				               \
+	KUNIT_BINARY_PTR_EQ_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      (typeof(ptr))NULL,		       \
+				      ptr)
+
+#define KUNIT_EXPECT_NULL_MSG(test, ptr, fmt, ...)	                       \
+	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
+					  KUNIT_EXPECTATION,		       \
+					  (typeof(ptr))NULL,		       \
+					  ptr,				       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+/**
+ * KUNIT_EXPECT_NOT_NULL() - Expects that @ptr is not null.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an expectation that the value that @ptr evaluates to is not null. This
+ * is semantically equivalent to KUNIT_EXPECT_PTR_NE(@test, NULL, ptr).
+ * See KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_EXPECT_NOT_NULL(test, ptr)			               \
+	KUNIT_BINARY_PTR_NE_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      (typeof(ptr))NULL,		       \
+				      ptr)
+
+#define KUNIT_EXPECT_NOT_NULL_MSG(test, ptr, fmt, ...)	                       \
+	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
+					  KUNIT_EXPECTATION,		       \
+					  (typeof(ptr))NULL,		       \
+					  ptr,				       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+
+			   /**
  * KUNIT_EXPECT_NE() - An expectation that @left and @right are not equal.
  * @test: The test context object.
  * @left: an arbitrary expression that evaluates to a primitive C type.
@@ -1678,6 +1723,52 @@ do {									       \
 					  fmt,				       \
 					  ##__VA_ARGS__)
 
+/**
+ * KUNIT_ASSERT_NULL() - Asserts that pointers @ptr is null.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an assertion that the values that @ptr evaluates to is null. This is
+ * the same as KUNIT_EXPECT_NULL(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_NULL(test, ptr) \
+	KUNIT_BINARY_PTR_EQ_ASSERTION(test,				       \
+				      KUNIT_ASSERTION,			       \
+				      (typeof(ptr))NULL,		       \
+				      ptr)
+
+#define KUNIT_ASSERT_NULL_MSG(test, ptr, fmt, ...) \
+	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
+					  KUNIT_ASSERTION,		       \
+					  (typeof(ptr))NULL,                   \
+					  ptr,			               \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_NOT_NULL() - Asserts that pointers @ptr is not null.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an assertion that the values that @ptr evaluates to is not null. This
+ * is the same as KUNIT_EXPECT_NOT_NULL(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_NOT_NULL(test, ptr) \
+	KUNIT_BINARY_PTR_NE_ASSERTION(test,                                    \
+				      KUNIT_ASSERTION,                         \
+				      (typeof(ptr))NULL,                       \
+				      ptr)
+
+#define KUNIT_ASSERT_NOT_NULL_MSG(test, ptr, fmt, ...)		               \
+	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
+					  KUNIT_ASSERTION,		       \
+					  (typeof(ptr))NULL,                   \
+					  ptr,			               \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+
 /**
  * KUNIT_ASSERT_NE() - An assertion that @left and @right are not equal.
  * @test: The test context object.
-- 
2.35.0.263.gb82422642f-goog

