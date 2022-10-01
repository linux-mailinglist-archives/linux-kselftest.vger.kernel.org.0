Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FCA5F175C
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 02:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiJAA10 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 20:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiJAA1B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 20:27:01 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA0714E766
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 17:26:50 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o91-20020a17090a0a6400b0020a72db3b87so38792pjo.5
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 17:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=g7IKu7kh+TXflaUbseOlbPiX53qX2o5Vb+tfLsI4XGE=;
        b=TT8XyI1j+MuboHcIEBy8S+9qTS/bL6xxy7o2ViUntEzgt3WGf883Lk7OvJyY7/Iz8w
         B+ZcRhFBcNQHlLbwX4dE/ZdFBJxLOoEfGJe1RNTSJ8WNP7W4IDkqlxG/7h26zv5slJsF
         CGbZuPy6QbD6vHxK0FXU28bRegwXt8oOh/qBLDGIeQSbXVwAGkLoFi6LvMtsudzHMLlX
         qGbe7IMI59y6lv+iA3H3VILoHPLGKJ5CBJHBcBQIJ65sIjfm5B8LIcKDhr24//taG87/
         AwbtG4fj80zL+oepGgRJaM8K+8XQT3NoXVIU6FbpScI/g/w2UXrBF7igEnSZoRR/oBUq
         Pb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=g7IKu7kh+TXflaUbseOlbPiX53qX2o5Vb+tfLsI4XGE=;
        b=Euv+CvtcPO3D0Ru1z8PB1t/9gRrwYoRcE+9XIJc6HivNPj9XwSusWY5TNSUo5jEfBi
         8/xEHdehmOj2oBFuF5WprqW/iGt8ymkc5lilfvz44P5mcZkzYkkEv6fdOeofMWfxHa9w
         p6vHL5wIVEEiGhWm9i1Mts2LzjhXhPapT0/ggPLpkJhSU0/Qld5SJCmoE3OuMuqJAD1a
         HMSstxSFat86NDD8zZTEyKyp4oxlUplydEZ5SnYqRSiXImSnv+3vktYtp2JuE/tLGMSn
         JunIGjsvUVQYRkwqegVtHb/Ao9MYI/Ihvzowrqlh4YgEFDBufveKJH5IN/XJkr6yw0I7
         AxoA==
X-Gm-Message-State: ACrzQf3xIj+4spF9+bECJSk80FZdQZfscl/BCp2yYxW6xn+ZXECj+/G0
        ZHERVR2Hru/yRKDIGcvISpPI/ae6/Z/6ww==
X-Google-Smtp-Source: AMsMyM5gCj7Mz0UQ8se1CKRxCJ9h08KUcoTB1jj8AdzDGbzgN1Iq1BCDVICqXx9lq/PnPRnKRTO98K/Z/fl/pw==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:4a12:b0:203:3482:d39e with SMTP
 id kk18-20020a17090b4a1200b002033482d39emr877855pjb.145.1664584009747; Fri,
 30 Sep 2022 17:26:49 -0700 (PDT)
Date:   Fri, 30 Sep 2022 17:26:36 -0700
In-Reply-To: <20221001002638.2881842-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001002638.2881842-3-dlatypov@google.com>
Subject: [PATCH 2/4] kunit: rename base KUNIT_ASSERTION macro to _KUNIT_FAILED
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        miguel.ojeda.sandonis@gmail.com,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
 include/kunit/test.h | 123 +++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 58 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 3476549106f7..fec437c8a2b7 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -475,30 +475,27 @@ void kunit_do_failed_assertion(struct kunit *test,
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
@@ -523,15 +520,19 @@ void kunit_do_failed_assertion(struct kunit *test,
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
+	if (likely(!!(condition) == !!expected_true))			       \
+		break;							       \
+									       \
+	_KUNIT_FAILED(test,						       \
+		      assert_type,					       \
+		      kunit_unary_assert,				       \
+		      kunit_unary_assert_format,			       \
+		      KUNIT_INIT_UNARY_ASSERT_STRUCT(#condition,	       \
+						     expected_true),	       \
+		      fmt,						       \
+		      ##__VA_ARGS__);					       \
+} while (0)
 
 #define KUNIT_TRUE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)       \
 	KUNIT_UNARY_ASSERTION(test,					       \
@@ -581,16 +582,18 @@ do {									       \
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
+	if (likely(__left op __right))					       \
+		break;							       \
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
@@ -639,16 +642,19 @@ do {									       \
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
+	if (likely(strcmp(__left, __right) op 0))			       \
+		break;							       \
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
@@ -659,15 +665,16 @@ do {									       \
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
+	if (!IS_ERR_OR_NULL(__ptr))					       \
+		break;							       \
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
2.38.0.rc1.362.ged0d419d3c-goog

