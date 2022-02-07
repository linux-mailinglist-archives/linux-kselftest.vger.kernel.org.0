Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9064ACA81
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 21:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiBGUaG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 15:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242109AbiBGU1V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 15:27:21 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE03C0401E2
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 12:27:17 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id d10so45662465eje.10
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 12:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gw9IRN9hr1+gfksXu4AOlVdfj3U7WJgk2YL6BR1ySok=;
        b=BgHPAL5th9Ch5l0fc1Gr2Ijkg+qehOnv6fneQTN1u8C+W0oGmWyQUmYyIqCzrRcxfS
         OXyZl4pH4FFlrn3BHq16Ohz7/ZB3JA4X4qswdDRcwNvazRup+M+ILeSBkvIh/0HdV3NK
         Mo9Guctt5YxFJ4fhxRX8KmJ05b8tT1FKb1H1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gw9IRN9hr1+gfksXu4AOlVdfj3U7WJgk2YL6BR1ySok=;
        b=KTwWeE35nWFUsBzphIrNEb6W4dGuNgc7sX4azxTHUNRJcBqcxLXrppleXg2w4qlI47
         zqkIIiloIHNYumLsjm5OQRpi0Y+dGlpbWkfD0f4/WtumiJp1F6zfixtyhRwan1ti/nfa
         e7gfNf/Venr7LbdcL+so1eKfHiP8a/iK7bGGatF0i9TCFYrA2lqDDWckM3eODXvRgZIh
         Ml93YhiarFY96bJUezR+KMYhTTsTy+jeANlErC5mhNPPac/ad6cFRApDFMoAemY2+99m
         DEkq/XDxCyXq+M9EJnbtlLG6nH8yqC5Ourl41nlmQanWtPj2ahf1n99kJGu2fdxngXXf
         OxxQ==
X-Gm-Message-State: AOAM532vb7jATi0xrYDPxV7N8pSvgGIZ61R3EGBWUJBLHGubUO2ZbuNK
        7gxmqiEH6SDAug55mOrBkn6/+g==
X-Google-Smtp-Source: ABdhPJz7mSHKxdktleBGVP818vyVYO4cXcyZ/K6mRBH6j//YStLaHUnXaRQk6evqgLUw+IGiIyTDbQ==
X-Received: by 2002:a17:906:8696:: with SMTP id g22mr1078583ejx.436.1644265636538;
        Mon, 07 Feb 2022 12:27:16 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id t8sm787893eji.94.2022.02.07.12.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:27:16 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 1/6] kunit: Introduce _NULL and _NOT_NULL macros
Date:   Mon,  7 Feb 2022 21:27:09 +0100
Message-Id: <20220207202714.1890024-1-ribalda@chromium.org>
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
 include/kunit/test.h | 88 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 00b9ff7783ab..5970d3a0e4af 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1218,6 +1218,50 @@ do {									       \
 				   fmt,					       \
 				   ##__VA_ARGS__)
 
+/**
+ * KUNIT_EXPECT_NULL() - Expects that @ptr is null.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an expectation that the value that @ptr evaluates to is null. This is
+ * semantically equivalent to KUNIT_EXPECT_PTR_EQ(@test, NULL, ptr).
+ * See KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_EXPECT_NULL(test, ptr)				               \
+	KUNIT_EXPECT_PTR_EQ_MSG(test,					       \
+				(typeof(ptr))NULL,			       \
+				ptr,					       \
+				NULL)
+
+#define KUNIT_EXPECT_NULL_MSG(test, ptr, fmt, ...)	                       \
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   (typeof(ptr))NULL, ==, ptr,		       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
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
+	KUNIT_EXPECT_PTR_NE_MSG(test,					       \
+				(typeof(ptr))NULL,			       \
+				ptr,					       \
+				NULL)
+
+#define KUNIT_EXPECT_NOT_NULL_MSG(test, ptr, fmt, ...)	                       \
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   (typeof(ptr))NULL, !=, ptr,		       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
 /**
  * KUNIT_EXPECT_NOT_ERR_OR_NULL() - Expects that @ptr is not null and not err.
  * @test: The test context object.
@@ -1485,6 +1529,50 @@ do {									       \
 				   fmt,					       \
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
+	KUNIT_ASSERT_PTR_EQ_MSG(test,					       \
+				(typeof(ptr))NULL,			       \
+				ptr,					       \
+				NULL)
+
+#define KUNIT_ASSERT_NULL_MSG(test, ptr, fmt, ...) \
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   (typeof(ptr))NULL, ==, ptr,		       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
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
+	KUNIT_ASSERT_PTR_NE_MSG(test,					       \
+				(typeof(ptr))NULL,			       \
+				ptr,					       \
+				NULL)
+
+#define KUNIT_ASSERT_NOT_NULL_MSG(test, ptr, fmt, ...) \
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   (typeof(ptr))NULL, !=, ptr,		       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
 /**
  * KUNIT_ASSERT_NOT_ERR_OR_NULL() - Assertion that @ptr is not null and not err.
  * @test: The test context object.
-- 
2.35.0.263.gb82422642f-goog

