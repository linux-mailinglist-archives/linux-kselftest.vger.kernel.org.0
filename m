Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8AE5F175D
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 02:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiJAA10 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 20:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiJAA1C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 20:27:02 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16D714663E
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 17:26:51 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id g24-20020a056a00079800b0054b1a110543so3572600pfu.2
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 17:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=VtHbDGUyBMlmUU7N3DxfY8TUG6hQduH5eTgQ3i+7K4w=;
        b=dqKmZOYwrmLA7ihchLDdTFZu8Lku9ziAfkQaHH5XF3iYrQhGAxlAwW8OUlR76A2ivi
         4tEwxYMmmnP3iB2VGC2Ngm4/tRoVTspfAPibOJUoA3rIdWx/Ii/hz5GeXBttisxIP1Gf
         DbGBcn8GD1rmcJd3Yyfv0usZNO6OJaRj32QQHrVJVz3YxbwBKPYhFrUyC2tmXDGICqrg
         xXtpqsBd5mbX5KwyPai8i5DXWZm3jhRKGck9w4j2+HS/GlVk4h+hQ+Xp2uC22kr776dO
         1mLxojybJsSrLBRMmb0YJ7neMafnFfonmA0YIRfM2Fah8uOlZ7pH+hQQ1mbDtJT1Zlg6
         xjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=VtHbDGUyBMlmUU7N3DxfY8TUG6hQduH5eTgQ3i+7K4w=;
        b=607cRQH9hBWuY96e5kOaI/kYB3IFi8utgjbav9I9mJHpNVpA6DZj3Bfaxqbhv6Vjux
         Bn6SXjJL+YfMNDIcNEKFPegh7M0K7rV6sbgll1t0CowUNUfOJzwDdoLuzNhsyMnL3qiE
         0Qv3nxS/rlwzWFnRi2KZSPXdM2IQSJPkd+5fMro0xYV3yRaTtNRVDloQ+ZJe9R+MMjdA
         XxLHbXNMrwIz6d7tPSNqbFcJU9x2kUPmjH4dgKRIMhkVM/e/nqf0EAOP9iTh8mxXXbhp
         /ngM/sQKkBXPvxn+LmyCM6Ps0fGC4N3SJhZH+voRkFspxtITaTDcRRFFDpLjoFDK/MvF
         5bRw==
X-Gm-Message-State: ACrzQf1QqfQISEbO7+oYmgV0/Y+11B2tDtoron7dRQsfoLaCKw94qw+t
        I6mc4u52jpqhQBL3GAch2W7SmcaJyDcyoA==
X-Google-Smtp-Source: AMsMyM7+ieKmpuNfGNK3lVj+ymHsmU/Lgv/olEOsTFS9fjZPCLSyK2lX8thNmdwPjbaie+lBICU3N7ZgKfCAgQ==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:902:d509:b0:179:ee34:faaf with SMTP
 id b9-20020a170902d50900b00179ee34faafmr11510191plg.150.1664584011307; Fri,
 30 Sep 2022 17:26:51 -0700 (PDT)
Date:   Fri, 30 Sep 2022 17:26:37 -0700
In-Reply-To: <20221001002638.2881842-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001002638.2881842-4-dlatypov@google.com>
Subject: [PATCH 3/4] kunit: eliminate KUNIT_INIT_*_ASSERT_STRUCT macros
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        miguel.ojeda.sandonis@gmail.com,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These macros exist because passing an initializer list to other macros
is hard.

The goal of these macros is to generate a line like
  struct $ASSERT_TYPE __assertion = $APPROPRIATE_INITIALIZER;
e.g.
  struct kunit_unary_assertion __assertion = {
	  .condition = "foo()",
	  .expected_true = true
  };

But the challenge is you can't pass `{.condition=..., .expect_true=...}`
as a macro argument, since the comma means you're actually passing two
arguments, `{.condition=...` and `.expect_true=....}`.
So we'd made custom macros for each different initializer-list shape.

But we can work around this with the following generic macro
  #define KUNIT_INIT_ASSERT(initializers...) { initializers }

Note: this has the downside that we have to rename some macros arguments
to not conflict with the struct field names (e.g. `expected_true`).
It's a bit gross, but probably worth reducing the # of macros.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/assert.h | 48 ------------------------------------------
 include/kunit/test.h   | 27 +++++++++++++-----------
 2 files changed, 15 insertions(+), 60 deletions(-)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index ace3de8d1ee7..01b191fa17c3 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -90,19 +90,6 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
 			       const struct va_format *message,
 			       struct string_stream *stream);
 
-/**
- * KUNIT_INIT_UNARY_ASSERT_STRUCT() - Initializes &struct kunit_unary_assert.
- * @cond: A string representation of the expression asserted true or false.
- * @expect_true: True if of type KUNIT_{EXPECT|ASSERT}_TRUE, false otherwise.
- *
- * Initializes a &struct kunit_unary_assert. Intended to be used in
- * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
- */
-#define KUNIT_INIT_UNARY_ASSERT_STRUCT(cond, expect_true) {		       \
-	.condition = cond,						       \
-	.expected_true = expect_true					       \
-}
-
 /**
  * struct kunit_ptr_not_err_assert - An expectation/assertion that a pointer is
  *	not NULL and not a -errno.
@@ -123,20 +110,6 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 				     const struct va_format *message,
 				     struct string_stream *stream);
 
-/**
- * KUNIT_INIT_PTR_NOT_ERR_ASSERT_STRUCT() - Initializes a
- *	&struct kunit_ptr_not_err_assert.
- * @txt: A string representation of the expression passed to the expectation.
- * @val: The actual evaluated pointer value of the expression.
- *
- * Initializes a &struct kunit_ptr_not_err_assert. Intended to be used in
- * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
- */
-#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(txt, val) {			       \
-	.text = txt,							       \
-	.value = val							       \
-}
-
 /**
  * struct kunit_binary_assert_text - holds strings for &struct
  *	kunit_binary_assert and friends to try and make the structs smaller.
@@ -173,27 +146,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 				const struct va_format *message,
 				struct string_stream *stream);
 
-/**
- * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a binary assert like
- *	kunit_binary_assert, kunit_binary_ptr_assert, etc.
- *
- * @text_: Pointer to a kunit_binary_assert_text.
- * @left_val: The actual evaluated value of the expression in the left slot.
- * @right_val: The actual evaluated value of the expression in the right slot.
- *
- * Initializes a binary assert like kunit_binary_assert,
- * kunit_binary_ptr_assert, etc. This relies on these structs having the same
- * fields but with different types for left_val/right_val.
- * This is ultimately used by binary assertion macros like KUNIT_EXPECT_EQ, etc.
- */
-#define KUNIT_INIT_BINARY_ASSERT_STRUCT(text_,				       \
-					left_val,			       \
-					right_val) {			       \
-	.text = text_,							       \
-	.left_value = left_val,						       \
-	.right_value = right_val					       \
-}
-
 /**
  * struct kunit_binary_ptr_assert - An expectation/assertion that compares two
  *	pointer values (for example, KUNIT_EXPECT_PTR_EQ(test, foo, bar)).
diff --git a/include/kunit/test.h b/include/kunit/test.h
index fec437c8a2b7..e49348bbc6ee 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -514,22 +514,25 @@ void kunit_do_failed_assertion(struct kunit *test,
 			     fmt,					       \
 			     ##__VA_ARGS__)
 
+/* Helper to safely pass around an initializer list to other macros. */
+#define KUNIT_INIT_ASSERT(initializers...) { initializers }
+
 #define KUNIT_UNARY_ASSERTION(test,					       \
 			      assert_type,				       \
-			      condition,				       \
-			      expected_true,				       \
+			      condition_,				       \
+			      expected_true_,				       \
 			      fmt,					       \
 			      ...)					       \
 do {									       \
-	if (likely(!!(condition) == !!expected_true))			       \
+	if (likely(!!(condition_) == !!expected_true_))			       \
 		break;							       \
 									       \
 	_KUNIT_FAILED(test,						       \
 		      assert_type,					       \
 		      kunit_unary_assert,				       \
 		      kunit_unary_assert_format,			       \
-		      KUNIT_INIT_UNARY_ASSERT_STRUCT(#condition,	       \
-						     expected_true),	       \
+		      KUNIT_INIT_ASSERT(.condition = #condition_,	       \
+					.expected_true = expected_true_),      \
 		      fmt,						       \
 		      ##__VA_ARGS__);					       \
 } while (0)
@@ -589,9 +592,9 @@ do {									       \
 		      assert_type,					       \
 		      assert_class,					       \
 		      format_func,					       \
-		      KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,		       \
-						      __left,		       \
-						      __right),		       \
+		      KUNIT_INIT_ASSERT(.text = &__text,		       \
+					.left_value = __left,		       \
+					.right_value = __right),	       \
 		      fmt,						       \
 		      ##__VA_ARGS__);					       \
 } while (0)
@@ -650,9 +653,9 @@ do {									       \
 		      assert_type,					       \
 		      kunit_binary_str_assert,				       \
 		      kunit_binary_str_assert_format,			       \
-		      KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,		       \
-						      __left,		       \
-						      __right),		       \
+		      KUNIT_INIT_ASSERT(.text = &__text,		       \
+					.left_value = __left,		       \
+					.right_value = __right),	       \
 		      fmt,						       \
 		      ##__VA_ARGS__);					       \
 } while (0)
@@ -672,7 +675,7 @@ do {									       \
 		      assert_type,					       \
 		      kunit_ptr_not_err_assert,				       \
 		      kunit_ptr_not_err_assert_format,			       \
-		      KUNIT_INIT_PTR_NOT_ERR_STRUCT(#ptr, __ptr),	       \
+		      KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),	       \
 		      fmt,						       \
 		      ##__VA_ARGS__);					       \
 } while (0)
-- 
2.38.0.rc1.362.ged0d419d3c-goog

