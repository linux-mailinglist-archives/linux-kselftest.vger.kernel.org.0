Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84B6235AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 22:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiKIVUk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 16:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiKIVUj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 16:20:39 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFAD2F03A
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Nov 2022 13:20:38 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id x18-20020a170902ec9200b001869f20da7eso14245171plg.10
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Nov 2022 13:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9j1Fdjw+QKrP8KK510mV9QHiJhXJjqbCZmYMnpYJD+w=;
        b=lc6wWWvNrO5dyaVIDT2ULScb++4l6ht9/mmwQ7XVv4hfdd/ZsFA7RYpeCE04Ig4rOT
         ft7xWbGZt0pAYXYGDcUBzCCKFcyxGCJxvndT13WIjww8CNWljGbcW65CVwBTkJSDUTuJ
         TaBMe2liq1yujJ0OMvYv4JkY366+GY7RVqGF+GjQJb9jx5nPxYcJ+0SkRY5hQ9Y0j+WD
         NfFexaeGObUTniQIwHhCNusmzbXgzKcolmTKOkhtHWDmfQematDe5+OC66ArvNVIfjeG
         GIadcjaOY4infU6r1EClQJXUBsKuCvdAUs/yVehu4mqGn0wq98RK4a/eSTeZMnjR7MyH
         SlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9j1Fdjw+QKrP8KK510mV9QHiJhXJjqbCZmYMnpYJD+w=;
        b=sLa+Vb/6ovO5WSsL7m+ykh38Pp+fCqFOP9glNN4wWz9Uhy/cFjR69yBRpgRZo06opD
         /DqCB4bxGWimlk/6QTLM5kNL/6n47YmJIVZrtXlNIDf9fHbEwPALdAxHGCrOju6MJA4k
         sKwltqAkMmfbcBRogTSNfZ89NjaTsii4HVpZByV4+6R2h/DegM/eSLQWpefOoxTnVoJo
         alhhTdBvG3kvDyh9sXEMGo5+xg2FN+JBNmV6e+lUHbnaJ84tZPTqIk1eOxBIBvaUQF4E
         GLd3Ylup6/VfqvmkSmbSL/8UTnkONOCtjbmFS1DOtw1dm+Po/O6pfW0AwmCNLh73+MBk
         yueg==
X-Gm-Message-State: ACrzQf132aP/w65AaTj0Or1riZmGFjL6oMDXLeU39tPtXnfSs5Kj4sLC
        TlDd/Bi76z5/uYQFobC1U4bG8ZluUhvy5g==
X-Google-Smtp-Source: AMsMyM69MAZSgTG0L+a1corcfO0Yh14SP+6sG4CoVQqfQuA7E0mImAEeypcGoh1NSt/V/gdclsyHzTl0vfTt/A==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a62:e214:0:b0:56c:4303:a93d with SMTP id
 a20-20020a62e214000000b0056c4303a93dmr1265599pfi.73.1668028838307; Wed, 09
 Nov 2022 13:20:38 -0800 (PST)
Date:   Wed,  9 Nov 2022 13:20:32 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221109212032.123021-1-dlatypov@google.com>
Subject: [PATCH] kunit: remove KUNIT_INIT_MEM_ASSERTION macro
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
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

Commit 870f63b7cd78 ("kunit: eliminate KUNIT_INIT_*_ASSERT_STRUCT
macros") removed all the other macros of this type.

But it raced with commit b8a926bea8b1 ("kunit: Introduce
KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros"), which added another
instance.

Remove KUNIT_INIT_MEM_ASSERTION and just use the generic
KUNIT_INIT_ASSERT macro instead.
Rename the `size` arg to avoid conflicts by appending a "_" (like we did
in the previous commit).

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/assert.h |  7 -------
 include/kunit/test.h   | 12 ++++++------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index 43144cfddc19..24c2b9fa61e8 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -192,13 +192,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    const struct va_format *message,
 				    struct string_stream *stream);
 
-#define KUNIT_INIT_MEM_ASSERT_STRUCT(text_, left_val, right_val, size_) {      \
-	.text = text_,							       \
-	.left_value = left_val,						       \
-	.right_value = right_val,				       	       \
-	.size = size_						       	       \
-}
-
 /**
  * struct kunit_mem_assert - An expectation/assertion that compares two
  *	memory blocks.
diff --git a/include/kunit/test.h b/include/kunit/test.h
index d7f60e8aab30..4666a4d199ea 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -666,13 +666,13 @@ do {									       \
 			    left,					       \
 			    op,						       \
 			    right,					       \
-			    size,					       \
+			    size_,					       \
 			    fmt,					       \
 			    ...)					       \
 do {									       \
 	const void *__left = (left);					       \
 	const void *__right = (right);					       \
-	const size_t __size = (size);					       \
+	const size_t __size = (size_);					       \
 	static const struct kunit_binary_assert_text __text = {		       \
 		.operation = #op,					       \
 		.left_text = #left,					       \
@@ -686,10 +686,10 @@ do {									       \
 		      assert_type,					       \
 		      kunit_mem_assert,					       \
 		      kunit_mem_assert_format,				       \
-		      KUNIT_INIT_MEM_ASSERT_STRUCT(&__text,		       \
-						   __left,		       \
-						   __right,		       \
-						   __size),		       \
+		      KUNIT_INIT_ASSERT(.text = &__text,		       \
+					.left_value = __left,		       \
+					.right_value = __right,		       \
+					.size = __size),		       \
 		      fmt,						       \
 		      ##__VA_ARGS__);					       \
 } while (0)

base-commit: 870f63b7cd78d0055902d839a60408f7428b4e84
-- 
2.38.1.431.g37b22c650d-goog

