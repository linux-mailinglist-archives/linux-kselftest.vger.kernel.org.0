Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF6E534093
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 May 2022 17:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiEYPpO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 May 2022 11:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245274AbiEYPpE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 May 2022 11:45:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF3457B25
        for <linux-kselftest@vger.kernel.org>; Wed, 25 May 2022 08:45:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30041bd304bso32722997b3.18
        for <linux-kselftest@vger.kernel.org>; Wed, 25 May 2022 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4eDRE9vOcSvYw9kUli1P4DtZ7qFlBTNAI5FAWRDONxU=;
        b=LMW44NeuqR1j1pXQTHLqvxCFNDEdiCI2W3fPbAApJUpfne2MXxxcczCTIoIh92KC6T
         cAP4VCEG2p26KRK99hP2ulco6gkPKJ5lMcNOCWHXLuIaM0XC8J4ScZVI9dIt5c5/lVyH
         4N0qZ9JmvRRM4O7B/qRFgq2xKzHC+BGKKIdkRVdtkiXgE2j8Aw5V8yNcK1zZvbGlE8b+
         FZlI19SfyleEMUprMmPSF5ExN0jst0IY6CugjgTJYzejHKBxVLT+6tZ68v8xrpZm7eXt
         xxmWTY3IRWs6kq/QgGtNgtzhq3My5/oXaujGaa7mf4aNAdqkiaO6mPA969anN4pj2zKB
         Gncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4eDRE9vOcSvYw9kUli1P4DtZ7qFlBTNAI5FAWRDONxU=;
        b=j0sZSjNXC5qZr8lbS3U6kUSYDY+esOBJc3s94suoFEdL0DdiY182pXWJBoRYZAQild
         NhzV19OKuDPppdJZ+8l9WKhd8XYJa5yyBnHzipcMAbcrT2jmvv7O94H+ENLgA3gcusgZ
         BDJMwnqjFxaCk4AXsOBZlOLx3pZNYJ7hdkm+xeI5lD0V3K7R43HQ3e1IOmaxniYCn2L4
         LFfEJlv7TuSOLSyjamZXIioNmaQC/EGDLLvT/CfhXmHQFmpcT+BMeC2krGgnVEf9ImiA
         FjsxZIWrr5AM0syTLtWdcwNxvL66z5VdAp0xwqudRWsMSq9WQ9MkUcNMjbCtwDdvSXdc
         QnpQ==
X-Gm-Message-State: AOAM532BphFkOh2bBasjvjePABKteNbTmru9VbZ2X0OA6C1Iyq407LNy
        ec6seCPMTt+VVCKjLYTSxEAh0lty566oaA==
X-Google-Smtp-Source: ABdhPJy02E3IASmDV51uvh2PP3kPGRgtRVl8uhEsV0zg9rJKXXVuF8UZbRWcT68XWym8eJpclcJy22zDgBDAKg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:5bba:b161:2a8a:2ddd])
 (user=dlatypov job=sendgmr) by 2002:a25:aad0:0:b0:655:8404:34ff with SMTP id
 t74-20020a25aad0000000b00655840434ffmr5619462ybi.299.1653493502610; Wed, 25
 May 2022 08:45:02 -0700 (PDT)
Date:   Wed, 25 May 2022 08:44:41 -0700
In-Reply-To: <20220525154442.1438081-1-dlatypov@google.com>
Message-Id: <20220525154442.1438081-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20220525154442.1438081-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH 3/4] rfc: kunit: eliminate KUNIT_INIT_*_ASSERT_STRUCT macros
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     ojeda@kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/assert.h | 48 ------------------------------------------
 include/kunit/test.h   | 27 +++++++++++++-----------
 2 files changed, 15 insertions(+), 60 deletions(-)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index aab5b1147df9..c041cd9fb0d4 100644
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
index 4a7cb7e72660..e4b54f5d2731 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -551,21 +551,24 @@ void kunit_do_failed_assertion(struct kunit *test,
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
-	if (likely(!!(condition) == !!expected_true)) break;		       \
+	if (likely(!!(condition_) == !!expected_true_)) break;		       \
 									       \
 	_KUNIT_FAILED(test,						       \
 		      assert_type,					       \
 		      kunit_unary_assert,				       \
 		      kunit_unary_assert_format,			       \
-		      KUNIT_INIT_UNARY_ASSERT_STRUCT(#condition,	       \
-						     expected_true),	       \
+		      KUNIT_INIT_ASSERT(.condition=#condition_,		       \
+					.expected_true=expected_true_),	       \
 		      fmt,						       \
 		      ##__VA_ARGS__);					       \
 } while(0)
@@ -624,9 +627,9 @@ do {									       \
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
@@ -684,9 +687,9 @@ do {									       \
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
@@ -705,7 +708,7 @@ do {									       \
 		      assert_type,					       \
 		      kunit_ptr_not_err_assert,				       \
 		      kunit_ptr_not_err_assert_format,			       \
-		      KUNIT_INIT_PTR_NOT_ERR_STRUCT(#ptr, __ptr),	       \
+		      KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),	       \
 		      fmt,						       \
 		      ##__VA_ARGS__);					       \
 } while (0)
-- 
2.36.1.124.g0e6072fb45-goog

