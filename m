Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8584930DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 23:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350032AbiARWfX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 17:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350030AbiARWfW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 17:35:22 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A6AC06173E
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 14:35:21 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id o6-20020a05620a22c600b0047a9959171aso459576qki.12
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 14:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4VNPvZxnGHUZEXxO/dpbXF1/h9rplsbHGL38CqpfiLw=;
        b=Ayvk/+dx63ukGVhqHlu9C4zhZiOnozyAJKZZneLeJrpJpl89tXiuNsWxUEx/CZJdWr
         RF96AMj+pCiw1STpkwP/TU/g0/PdGRyWECLGDndNsQ1DBOMb2n08YHmE6CjsZRzfqRuf
         /SOPDCU1JEwpwOgGgxHNgTMqVgXihr/XvcwgP0sqYV4kLyUIfQ/3BIhIc+Df0GQWKq/Q
         d30wUjW/3TcBC19XYJfguaRTPWaXA6TyI61xUGir9e2yFF0smpMlUDIh7OzogjlS11lR
         ++PWdb7x9aWHv9mTY4PaMVUf68oymfvAvLVUFUIF0Yn3lgsW5fWyUwoa+uEou2mgV6Yw
         cfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4VNPvZxnGHUZEXxO/dpbXF1/h9rplsbHGL38CqpfiLw=;
        b=JNlOFY78MaNKdmPtrOjXhRR8cLgFQOxxesE3wEWZUm9N3WbuiO42xMbRFDcoOxDxOr
         koeakYKf3FmHT62KXaP0vH16dcBiF6x8cQ1F012OmLIYq7dUoZESBPPjVp+nXGAO7zmK
         fUtpqpPj+KXxSt5JeSMibJieCcwMB4Ol8TO0LI+8qXDx3FS8tqiSgO9KXDTSHWQFqEJg
         imqoGDx0lhVFjJo6T39G/I+QYWjLAu6cqyvXX8DY+Reucc0apxs0j5tYc4PDUD9KHX0i
         oSgHlsaPelIQknFatp0aqk73Mxs8vO8geN9jfyv5XknlbKL1BITEZRkxn4zWMpoovaTH
         wOZg==
X-Gm-Message-State: AOAM532dudq+luDgl9qVrlS5J9i2qj6C5Ol67nbsoOMPy3KvyhgHHYHa
        +ptLRYn2DwoFtQXogTzXGfTSH3p3qmPcdw==
X-Google-Smtp-Source: ABdhPJwBiVKYAgk0yHJUUkdjCgjbxyuKCQVVbjpX/sfCq6eWdowOuXdBzbBKCkuQekmSMIgK2Ep520hF72X6vg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7fc9:5977:ab73:1d36])
 (user=dlatypov job=sendgmr) by 2002:ac8:5d8b:: with SMTP id
 d11mr10480922qtx.114.1642545320817; Tue, 18 Jan 2022 14:35:20 -0800 (PST)
Date:   Tue, 18 Jan 2022 14:35:04 -0800
In-Reply-To: <20220118223506.1701553-1-dlatypov@google.com>
Message-Id: <20220118223506.1701553-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 3/5] kunit: reduce layering in string assertion macros
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The current macro chain looks like:
KUNIT_EXPECT_STREQ => KUNIT_EXPECT_STREQ_MSG => KUNIT_BINARY_STR_EQ_MSG_ASSERTION => KUNIT_BINARY_STR_ASSERTION.
KUNIT_ASSERT_STREQ => KUNIT_ASSERT_STREQ_MSG => KUNIT_BINARY_STR_EQ_MSG_ASSERTION => KUNIT_BINARY_STR_ASSERTION.
<ditto for STR_NE>

After this change:
KUNIT_EXPECT_STREQ => KUNIT_EXPECT_STREQ_MSG => KUNIT_BINARY_STR_ASSERTION.
KUNIT_ASSERT_STREQ => KUNIT_ASSERT_STREQ_MSG => KUNIT_BINARY_STR_ASSERTION.
<ditto for STR_NE>

All the intermediate macro did was pass in "==" or "!=", so it seems
better to just drop them at the cost of a bit more copy-paste.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h | 68 +++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 48 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index c021945a75e3..d5dc1ef68bfe 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1098,30 +1098,6 @@ do {									       \
 			##__VA_ARGS__);					       \
 } while (0)
 
-#define KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BINARY_STR_ASSERTION(test,				       \
-				   assert_type,				       \
-				   left, ==, right,			       \
-				   fmt,					       \
-				   ##__VA_ARGS__)
-
-#define KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BINARY_STR_ASSERTION(test,				       \
-				   assert_type,				       \
-				   left, !=, right,			       \
-				   fmt,					       \
-				   ##__VA_ARGS__)
-
 #define KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
 						assert_type,		       \
 						ptr,			       \
@@ -1371,12 +1347,11 @@ do {									       \
 	KUNIT_EXPECT_STREQ_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_STREQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
-					  KUNIT_EXPECTATION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, ==, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_STRNEQ() - Expects that strings @left and @right are not equal.
@@ -1393,12 +1368,11 @@ do {									       \
 	KUNIT_EXPECT_STRNEQ_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
-					  KUNIT_EXPECTATION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, !=, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_NOT_ERR_OR_NULL() - Expects that @ptr is not null and not err.
@@ -1648,12 +1622,11 @@ do {									       \
 	KUNIT_ASSERT_STREQ_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_STREQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
-					  KUNIT_ASSERTION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, ==, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_STRNEQ() - Expects that strings @left and @right are not equal.
@@ -1670,12 +1643,11 @@ do {									       \
 	KUNIT_ASSERT_STRNEQ_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
-					  KUNIT_ASSERTION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, !=, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_NOT_ERR_OR_NULL() - Assertion that @ptr is not null and not err.
-- 
2.34.1.703.g22d0c6ccf7-goog

