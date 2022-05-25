Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2571B534092
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 May 2022 17:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiEYPpM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 May 2022 11:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245252AbiEYPpC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 May 2022 11:45:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BCB8A302
        for <linux-kselftest@vger.kernel.org>; Wed, 25 May 2022 08:45:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7dbceab08so180099067b3.10
        for <linux-kselftest@vger.kernel.org>; Wed, 25 May 2022 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LVwK1TWS2ZAb7Kfk7FPrer/dNWd3IkmkzZFa2JkAqMQ=;
        b=CuaSdqC5/5PGcYkkjh3I3OulmQD6xBIMr/i67/rl3Sr5cF5QK7OG8SNCHSejBCSiIk
         nYuKyrdDBQG9TzVOPyZnfHKbYR9ZLYhuVYNx+/hI9J/p96Pm4rG0hwKBSVm7JiSmDaAJ
         8oQuniLZV712jAH7Hi5EUL00vQrXjmDGHht6C05HzTKBbO5uPqQGd9JMfZF364rkA4bo
         HRlCpE905u+xVUd3l+C00OV5QSoY7s3/GKn8e/BkktXg9ZZUceVASl/sjBPF3IbrbGss
         ff9PXEEjt9LgkVCED7YN2NL50v/EqNmcj0ywVqewWziWGuo7Mqm/EGeV0tujugQwnhBu
         Ebyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LVwK1TWS2ZAb7Kfk7FPrer/dNWd3IkmkzZFa2JkAqMQ=;
        b=BhM15cxOqE4sXmSwNgjQEHBZmosfJWlTQd1DNZRQey++lE9k2YdfecYrpEakcv73BN
         Fa/yhpFUJeOIfTSa8/ITHuPYuAlH4GitF1nHb3Ftm7mX2kRfvA8HF24+RIZTJu0/lJm9
         yyehI34QaHAxgUhsPpQ2bsM/AVlU1qHQgvx9vJuVjUpIW34Cw1DMfkI9Ew3eZvV81Fob
         t32B2hV9v1BJIKZAk0jqYkpJjqUl/14YqcP5DiDth/FbJhCWAGQVxBJCjqf/kIHvzfdU
         CbLn7SjAEcYOJVJcHKO/J6NmPeW5JzdYb+icv447saTx48Wo1K3TyEYfMD6I+Nc/tve3
         dLew==
X-Gm-Message-State: AOAM530D2kXeYkfwY27MiCbSviZiC30ESsopz+B+WyBej2MJqMOPnV4w
        eVoEsmeMrUA1a2lM4+F9ZjpNjcLeJaalog==
X-Google-Smtp-Source: ABdhPJyw+1yei1o/kJT6QO5M4hmlZq8hDTO/YxwP2PZ0T2KZlMVtxI8Ats6BjBJ/yA1EIyPvhA5QvyRZ05/BzQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:5bba:b161:2a8a:2ddd])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:143:b0:628:7cf1:f2a9 with SMTP
 id p3-20020a056902014300b006287cf1f2a9mr30129754ybh.51.1653493500535; Wed, 25
 May 2022 08:45:00 -0700 (PDT)
Date:   Wed, 25 May 2022 08:44:40 -0700
In-Reply-To: <20220525154442.1438081-1-dlatypov@google.com>
Message-Id: <20220525154442.1438081-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220525154442.1438081-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH 2/4] rfc: kunit: rename base KUNIT_ASSERTION macro to _KUNIT_FAILED
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     ojeda@kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Context:
Currently this macro's name, KUNIT_ASSERTION conflicts with the name of
an enum whose values are {KUNIT_EXPECTATION, KUNIT_ASSERTION}.

It's hard to think of a better name for the enum, so rename this macro.
It's also a bit strange that the macro might do nothing depending on the
boolean argument `pass`. Why not have callers check themselves?

This patch:
Moves the pass/fail checking into the callers of KUNIT_ASSERTION, so now
we only call it when the check has failed.
Then we rename the macro the _KUNIT_FAILED() to reflect the new
semantics.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h | 119 ++++++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 58 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 6730734a2216..4a7cb7e72660 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -512,30 +512,27 @@ void kunit_do_failed_assertion(struct kunit *test,
 			       assert_format_t assert_format,
 			       const char *fmt, ...);
 
-#define KUNIT_ASSERTION(test, assert_type, pass, assert_class, assert_format, INITIALIZER, fmt, ...) do { \
-	if (unlikely(!(pass))) {					       \
-		static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;       \
-		struct assert_class __assertion = INITIALIZER;		       \
-		kunit_do_failed_assertion(test,				       \
-					  &__loc,			       \
-					  assert_type,			       \
-					  &__assertion.assert,		       \
-					  assert_format,		       \
-					  fmt,				       \
-					  ##__VA_ARGS__);		       \
-	}								       \
+#define _KUNIT_FAILED(test, assert_type, assert_class, assert_format, INITIALIZER, fmt, ...) do { \
+	static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;	       \
+	struct assert_class __assertion = INITIALIZER;			       \
+	kunit_do_failed_assertion(test,					       \
+				  &__loc,				       \
+				  assert_type,				       \
+				  &__assertion.assert,			       \
+				  assert_format,			       \
+				  fmt,					       \
+				  ##__VA_ARGS__);			       \
 } while (0)
 
 
 #define KUNIT_FAIL_ASSERTION(test, assert_type, fmt, ...)		       \
-	KUNIT_ASSERTION(test,						       \
-			assert_type,					       \
-			false,						       \
-			kunit_fail_assert,				       \
-			kunit_fail_assert_format,			       \
-			{},						       \
-			fmt,						       \
-			##__VA_ARGS__)
+	_KUNIT_FAILED(test,						       \
+		      assert_type,					       \
+		      kunit_fail_assert,				       \
+		      kunit_fail_assert_format,				       \
+		      {},						       \
+		      fmt,						       \
+		      ##__VA_ARGS__)
 
 /**
  * KUNIT_FAIL() - Always causes a test to fail when evaluated.
@@ -560,15 +557,18 @@ void kunit_do_failed_assertion(struct kunit *test,
 			      expected_true,				       \
 			      fmt,					       \
 			      ...)					       \
-	KUNIT_ASSERTION(test,						       \
-			assert_type,					       \
-			!!(condition) == !!expected_true,		       \
-			kunit_unary_assert,				       \
-			kunit_unary_assert_format,			       \
-			KUNIT_INIT_UNARY_ASSERT_STRUCT(#condition,	       \
-						       expected_true),	       \
-			fmt,						       \
-			##__VA_ARGS__)
+do {									       \
+	if (likely(!!(condition) == !!expected_true)) break;		       \
+									       \
+	_KUNIT_FAILED(test,						       \
+		      assert_type,					       \
+		      kunit_unary_assert,				       \
+		      kunit_unary_assert_format,			       \
+		      KUNIT_INIT_UNARY_ASSERT_STRUCT(#condition,	       \
+						     expected_true),	       \
+		      fmt,						       \
+		      ##__VA_ARGS__);					       \
+} while(0)
 
 #define KUNIT_TRUE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)       \
 	KUNIT_UNARY_ASSERTION(test,					       \
@@ -618,16 +618,17 @@ do {									       \
 		.right_text = #right,					       \
 	};								       \
 									       \
-	KUNIT_ASSERTION(test,						       \
-			assert_type,					       \
-			__left op __right,				       \
-			assert_class,					       \
-			format_func,					       \
-			KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,	       \
-							__left,		       \
-							__right),	       \
-			fmt,						       \
-			##__VA_ARGS__);					       \
+	if (likely(__left op __right)) break;				       \
+									       \
+	_KUNIT_FAILED(test,						       \
+		      assert_type,					       \
+		      assert_class,					       \
+		      format_func,					       \
+		      KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,		       \
+						      __left,		       \
+						      __right),		       \
+		      fmt,						       \
+		      ##__VA_ARGS__);					       \
 } while (0)
 
 #define KUNIT_BINARY_INT_ASSERTION(test,				       \
@@ -676,16 +677,18 @@ do {									       \
 		.right_text = #right,					       \
 	};								       \
 									       \
-	KUNIT_ASSERTION(test,						       \
-			assert_type,					       \
-			strcmp(__left, __right) op 0,			       \
-			kunit_binary_str_assert,			       \
-			kunit_binary_str_assert_format,			       \
-			KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,	       \
-							__left,		       \
-							__right),	       \
-			fmt,						       \
-			##__VA_ARGS__);					       \
+	if (likely(strcmp(__left, __right) op 0)) break;		       \
+									       \
+									       \
+	_KUNIT_FAILED(test,						       \
+		      assert_type,					       \
+		      kunit_binary_str_assert,				       \
+		      kunit_binary_str_assert_format,			       \
+		      KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,		       \
+						      __left,		       \
+						      __right),		       \
+		      fmt,						       \
+		      ##__VA_ARGS__);					       \
 } while (0)
 
 #define KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
@@ -696,15 +699,15 @@ do {									       \
 do {									       \
 	const typeof(ptr) __ptr = (ptr);				       \
 									       \
-	KUNIT_ASSERTION(test,						       \
-			assert_type,					       \
-			!IS_ERR_OR_NULL(__ptr),				       \
-			kunit_ptr_not_err_assert,			       \
-			kunit_ptr_not_err_assert_format,		       \
-			KUNIT_INIT_PTR_NOT_ERR_STRUCT(#ptr,		       \
-						      __ptr),		       \
-			fmt,						       \
-			##__VA_ARGS__);					       \
+	if (likely(!IS_ERR_OR_NULL(__ptr))) break;			       \
+									       \
+	_KUNIT_FAILED(test,						       \
+		      assert_type,					       \
+		      kunit_ptr_not_err_assert,				       \
+		      kunit_ptr_not_err_assert_format,			       \
+		      KUNIT_INIT_PTR_NOT_ERR_STRUCT(#ptr, __ptr),	       \
+		      fmt,						       \
+		      ##__VA_ARGS__);					       \
 } while (0)
 
 /**
-- 
2.36.1.124.g0e6072fb45-goog

