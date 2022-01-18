Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05B44930DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 23:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350026AbiARWfW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 17:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350037AbiARWfR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 17:35:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1268C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 14:35:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 127-20020a250f85000000b00611ab6484abso888365ybp.23
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 14:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9euHJ6TDFEqcdVPB9gK81BFOEuHcGCU4e/Eqxz2GLQ4=;
        b=VOt6H4xQKm9zTbGfh3r/4jKJhYSPHgdcgm7hpoNw40/rjMgXsBDwhqSRDuujObUp6w
         hXcbafhxwLmsoKse2T6RYs3IiymIMWPTidrRlUxSfYIRbFYCwoBQAZBIEbdG1DPBZMoC
         Y64dmhlUESApB29YoI8QXRtVhmvd329LEXKOFq2cup0XbAdgypgziRjy0juhH2unmTDH
         08MLVM/pI4UdgcTr1CRPdGJ/5s9xHotY9ZziDzdfz1MbqFt9U9IBgrfa7PFk8yJWRvWJ
         s1v9VuFHRiAqjy1DMh1vznD8NVYsy9UHYXEYSgVgX7irfCefrJ97uEeBmqm4cWuylEHM
         mK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9euHJ6TDFEqcdVPB9gK81BFOEuHcGCU4e/Eqxz2GLQ4=;
        b=KanAjkk/5o6h7FbkKaf/Ys6yZ19P35aY86R1DiVaiwu95XvkghFIgsZPF2afSijAyD
         c8hH6OcPGA+vt2zQ99XZbij67uUtK0jsS87q0JnjsfI1mb63eBJT71aAHtFhV+0G+/RX
         W7LkQZNCZ/mrechEeKxaFlWbNWTh7jTR8Ph+hnst+44miN+9roezw20ta7WsFLEUJWd7
         VRUq52Gxbn0NEZlYty1O7LocH08S+uBtmX4rfd7j2BNlntlTVcGzE4R7RSUifpnifklY
         ItWUa0jlVvTyeCNf5TnrsWq0TbDBVflcW9uLMsxPLMogLixXbXAQrsVyzaOhnCOFLjoF
         89YQ==
X-Gm-Message-State: AOAM530d+oH81tzzsTrFT06rXZ3kUhj4NskXcj/4vl53zfoV7GcGr2pS
        zi0+tK/6wAj/XOIc21G/8F4rK2G9NVAyAw==
X-Google-Smtp-Source: ABdhPJzaXDoKztxeBvMsEnavwba72jKRst0Ky/6neca/cX0N9F3RbihVSiMEnSfppCJ1+VGDmUTaNsZcxYlT3w==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7fc9:5977:ab73:1d36])
 (user=dlatypov job=sendgmr) by 2002:a25:a06:: with SMTP id
 6mr35615792ybk.5.1642545315903; Tue, 18 Jan 2022 14:35:15 -0800 (PST)
Date:   Tue, 18 Jan 2022 14:35:02 -0800
In-Reply-To: <20220118223506.1701553-1-dlatypov@google.com>
Message-Id: <20220118223506.1701553-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 1/5] kunit: make KUNIT_EXPECT_EQ() use KUNIT_EXPECT_EQ_MSG(), etc.
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There's quite a few macros in play for KUnit assertions.

The current macro chain looks like:
  KUNIT_EXPECT_EQ => KUNIT_BINARY_EQ_ASSERTION => KUNIT_BINARY_EQ_MSG_ASSERTION
  KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION
  KUNIT_ASSERT_EQ => KUNIT_BINARY_EQ_ASSERTION => KUNIT_BINARY_EQ_MSG_ASSERTION
  KUNIT_ASSERT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION

After this change:
  KUNIT_EXPECT_EQ => KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION
  KUNIT_ASSERT_EQ => KUNIT_ASSERT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION
and we can drop the intermediate KUNIT_BINARY_EQ_ASSERTION.

This change does this for all the other macros as well.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h | 168 +++++++------------------------------------
 1 file changed, 26 insertions(+), 142 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 5964af750d93..b032dd6816d2 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -840,9 +840,6 @@ void kunit_do_failed_assertion(struct kunit *test,
 			      fmt,					       \
 			      ##__VA_ARGS__)
 
-#define KUNIT_TRUE_ASSERTION(test, assert_type, condition) \
-	KUNIT_TRUE_MSG_ASSERTION(test, assert_type, condition, NULL)
-
 #define KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)      \
 	KUNIT_UNARY_ASSERTION(test,					       \
 			      assert_type,				       \
@@ -851,9 +848,6 @@ void kunit_do_failed_assertion(struct kunit *test,
 			      fmt,					       \
 			      ##__VA_ARGS__)
 
-#define KUNIT_FALSE_ASSERTION(test, assert_type, condition) \
-	KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, NULL)
-
 /*
  * A factory macro for defining the assertions and expectations for the basic
  * comparisons defined for the built in types.
@@ -1000,13 +994,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_EQ_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
-				      assert_type,			       \
-				      left,				       \
-				      right,				       \
-				      NULL)
-
 #define KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
 					  assert_type,			       \
 					  left,				       \
@@ -1022,13 +1009,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_PTR_EQ_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
 #define KUNIT_BINARY_NE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
 	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
 				    kunit_binary_assert,		       \
@@ -1039,13 +1019,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_NE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
-				      assert_type,			       \
-				      left,				       \
-				      right,				       \
-				      NULL)
-
 #define KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
 					  assert_type,			       \
 					  left,				       \
@@ -1061,13 +1034,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_PTR_NE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
 #define KUNIT_BINARY_LT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
 	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
 				    kunit_binary_assert,		       \
@@ -1078,13 +1044,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_LT_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
-				      assert_type,			       \
-				      left,				       \
-				      right,				       \
-				      NULL)
-
 #define KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
 					  assert_type,			       \
 					  left,				       \
@@ -1100,13 +1059,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_PTR_LT_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
 #define KUNIT_BINARY_LE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
 	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
 				    kunit_binary_assert,		       \
@@ -1117,13 +1069,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_LE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
-				      assert_type,			       \
-				      left,				       \
-				      right,				       \
-				      NULL)
-
 #define KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
 					  assert_type,			       \
 					  left,				       \
@@ -1139,13 +1084,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_PTR_LE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
 #define KUNIT_BINARY_GT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
 	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
 				    kunit_binary_assert,		       \
@@ -1156,13 +1094,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_GT_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
-				      assert_type,			       \
-				      left,				       \
-				      right,				       \
-				      NULL)
-
 #define KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
 					  assert_type,			       \
 					  left,				       \
@@ -1178,13 +1109,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_PTR_GT_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
 #define KUNIT_BINARY_GE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
 	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
 				    kunit_binary_assert,		       \
@@ -1195,13 +1119,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_GE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
-				      assert_type,			       \
-				      left,				       \
-				      right,				       \
-				      NULL)
-
 #define KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
 					  assert_type,			       \
 					  left,				       \
@@ -1217,13 +1134,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_PTR_GE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
 #define KUNIT_BINARY_STR_ASSERTION(test,				       \
 				   assert_type,				       \
 				   left,				       \
@@ -1260,13 +1170,6 @@ do {									       \
 				   fmt,					       \
 				   ##__VA_ARGS__)
 
-#define KUNIT_BINARY_STR_EQ_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
 #define KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
 					  assert_type,			       \
 					  left,				       \
@@ -1279,13 +1182,6 @@ do {									       \
 				   fmt,					       \
 				   ##__VA_ARGS__)
 
-#define KUNIT_BINARY_STR_NE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
 #define KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
 						assert_type,		       \
 						ptr,			       \
@@ -1304,12 +1200,6 @@ do {									       \
 			##__VA_ARGS__);					       \
 } while (0)
 
-#define KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, assert_type, ptr)	       \
-	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
-						assert_type,		       \
-						ptr,			       \
-						NULL)
-
 /**
  * KUNIT_EXPECT_TRUE() - Causes a test failure when the expression is not true.
  * @test: The test context object.
@@ -1322,7 +1212,7 @@ do {									       \
  * *expectation failure*.
  */
 #define KUNIT_EXPECT_TRUE(test, condition) \
-	KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
+	KUNIT_EXPECT_TRUE_MSG(test, condition, NULL)
 
 #define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)		       \
 	KUNIT_TRUE_MSG_ASSERTION(test,					       \
@@ -1341,7 +1231,7 @@ do {									       \
  * KUNIT_EXPECT_TRUE() for more information.
  */
 #define KUNIT_EXPECT_FALSE(test, condition) \
-	KUNIT_FALSE_ASSERTION(test, KUNIT_EXPECTATION, condition)
+	KUNIT_EXPECT_FALSE_MSG(test, condition, NULL)
 
 #define KUNIT_EXPECT_FALSE_MSG(test, condition, fmt, ...)		       \
 	KUNIT_FALSE_MSG_ASSERTION(test,					       \
@@ -1362,7 +1252,7 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_EQ(test, left, right) \
-	KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
@@ -1384,10 +1274,7 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_PTR_EQ(test, left, right)				       \
-	KUNIT_BINARY_PTR_EQ_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right)
+	KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
@@ -1409,7 +1296,7 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_NE(test, left, right) \
-	KUNIT_BINARY_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_NE_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_NE_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
@@ -1431,10 +1318,7 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_PTR_NE(test, left, right)				       \
-	KUNIT_BINARY_PTR_NE_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right)
+	KUNIT_EXPECT_PTR_NE_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
@@ -1456,7 +1340,7 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_LT(test, left, right) \
-	KUNIT_BINARY_LT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_LT_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_LT_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
@@ -1478,7 +1362,7 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_LE(test, left, right) \
-	KUNIT_BINARY_LE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_LE_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_LE_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
@@ -1500,7 +1384,7 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_GT(test, left, right) \
-	KUNIT_BINARY_GT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_GT_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_GT_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
@@ -1522,7 +1406,7 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_GE(test, left, right) \
-	KUNIT_BINARY_GE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_GE_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_GE_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
@@ -1544,7 +1428,7 @@ do {									       \
  * for more information.
  */
 #define KUNIT_EXPECT_STREQ(test, left, right) \
-	KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_STREQ_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_STREQ_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
@@ -1566,7 +1450,7 @@ do {									       \
  * for more information.
  */
 #define KUNIT_EXPECT_STRNEQ(test, left, right) \
-	KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_STRNEQ_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
@@ -1587,7 +1471,7 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ptr) \
-	KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_EXPECTATION, ptr)
+	KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
 
 #define KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
 	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
@@ -1611,7 +1495,7 @@ do {									       \
  * this is otherwise known as an *assertion failure*.
  */
 #define KUNIT_ASSERT_TRUE(test, condition) \
-	KUNIT_TRUE_ASSERTION(test, KUNIT_ASSERTION, condition)
+	KUNIT_ASSERT_TRUE_MSG(test, condition, NULL)
 
 #define KUNIT_ASSERT_TRUE_MSG(test, condition, fmt, ...)		       \
 	KUNIT_TRUE_MSG_ASSERTION(test,					       \
@@ -1630,7 +1514,7 @@ do {									       \
  * (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_FALSE(test, condition) \
-	KUNIT_FALSE_ASSERTION(test, KUNIT_ASSERTION, condition)
+	KUNIT_ASSERT_FALSE_MSG(test, condition, NULL)
 
 #define KUNIT_ASSERT_FALSE_MSG(test, condition, fmt, ...)		       \
 	KUNIT_FALSE_MSG_ASSERTION(test,					       \
@@ -1650,7 +1534,7 @@ do {									       \
  * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_EQ(test, left, right) \
-	KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_EQ_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
@@ -1671,7 +1555,7 @@ do {									       \
  * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_PTR_EQ(test, left, right) \
-	KUNIT_BINARY_PTR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
@@ -1692,7 +1576,7 @@ do {									       \
  * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_NE(test, left, right) \
-	KUNIT_BINARY_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_NE_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_NE_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
@@ -1714,7 +1598,7 @@ do {									       \
  * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_PTR_NE(test, left, right) \
-	KUNIT_BINARY_PTR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_PTR_NE_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
@@ -1735,7 +1619,7 @@ do {									       \
  * is not met.
  */
 #define KUNIT_ASSERT_LT(test, left, right) \
-	KUNIT_BINARY_LT_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_LT_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_LT_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
@@ -1756,7 +1640,7 @@ do {									       \
  * KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_LE(test, left, right) \
-	KUNIT_BINARY_LE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_LE_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_LE_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
@@ -1778,7 +1662,7 @@ do {									       \
  * is not met.
  */
 #define KUNIT_ASSERT_GT(test, left, right) \
-	KUNIT_BINARY_GT_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_GT_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_GT_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
@@ -1800,7 +1684,7 @@ do {									       \
  * is not met.
  */
 #define KUNIT_ASSERT_GE(test, left, right) \
-	KUNIT_BINARY_GE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_GE_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_GE_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
@@ -1821,7 +1705,7 @@ do {									       \
  * assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_STREQ(test, left, right) \
-	KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_STREQ_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_STREQ_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
@@ -1843,7 +1727,7 @@ do {									       \
  * for more information.
  */
 #define KUNIT_ASSERT_STRNEQ(test, left, right) \
-	KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_STRNEQ_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
@@ -1864,7 +1748,7 @@ do {									       \
  * KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr) \
-	KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_ASSERTION, ptr)
+	KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
 
 #define KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
 	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
-- 
2.34.1.703.g22d0c6ccf7-goog

