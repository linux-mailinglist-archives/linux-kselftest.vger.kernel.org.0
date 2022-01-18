Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0604930D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 23:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350021AbiARWfU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 17:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350010AbiARWfT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 17:35:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA16C06161C
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 14:35:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w189-20020a2549c6000000b00611c8be224cso964314yba.14
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 14:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IWVQqcg7rIXz6kLAaetcDmpZRL5060Dx7jdRLa/XWp0=;
        b=UpYee12u3RjjPEYtjg9z/mfNP6iMokT6d9P8EYagkJ0pBWmrR1UmHSmAzh/BVxsS0Y
         NF3utvrXXqVcrLwExQUb6nsPwJLMaeaaVD+OjLCGxBaFCpw+Jg+bwUldTfLGOqcEVPn6
         VWSgwfwrskgdO3YeO1BxWeuX70noBJLMUnNeq7S8k/a+Etu8q4RKylhrRZ/AJ07fQ9pT
         b+hoslrTmSsuh7puxVGyOoztoXwSBCMsmrL1U1l93CGVhaTe5WoJ9aK4sWyymE7ZeJnu
         8uKsQQeoXnMrez3GI3d2BrF+9arFB8H1uxlwz/h68N1HBqwx2vEemNM/IbUJOyk3zvIY
         F6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IWVQqcg7rIXz6kLAaetcDmpZRL5060Dx7jdRLa/XWp0=;
        b=IWR3Y0U2dEEw8wx8CeyIgjYxifbwwl+KA0gPS7pLrBBoK2KxodBHdXrC6IcOCoio5O
         vK8rVPxZai625avO+/Xc5c/LhCnMVuy8k4zTCvrcOsH7IkcFtzLFCNjP2FXRnpnPRNRM
         Y54KsKSrvRmPbIhBOE573ZgwvOf1lVHFq/TmybYe4D//KP8fbGxmT4Akz3ymjLoegyWc
         yjUOHH4Ne7GJpGEd8UcvtYg1qpxQ1RH/uOK3mh4n6K1wnjGa2oarj6VYP/dM//rNKncl
         rY5jw0iDqR0xxriu6eM9ubklNyPs2vIiOivVLXPWbedxzw8z7+WZJf2ytOQ4XX1z8454
         wK3A==
X-Gm-Message-State: AOAM532hELaxYezNHagwu0Dd7uG4dzdILFki69pAc47J7n8R5y2IItHN
        GJ53AdIyFRi7+/DjJ3tFrsPoQ1J3gQY3eg==
X-Google-Smtp-Source: ABdhPJyCnt6uK/glIekOwV6wdmMKBWi0Nc2xd4h1eQxLfw92JTINZw+jP0976SAGeHJJ39Nbb3wBRiU0vgx+ow==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7fc9:5977:ab73:1d36])
 (user=dlatypov job=sendgmr) by 2002:a25:9290:: with SMTP id
 y16mr34539130ybl.382.1642545318413; Tue, 18 Jan 2022 14:35:18 -0800 (PST)
Date:   Tue, 18 Jan 2022 14:35:03 -0800
In-Reply-To: <20220118223506.1701553-1-dlatypov@google.com>
Message-Id: <20220118223506.1701553-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 2/5] kunit: drop unused intermediate macros for ptr inequality checks
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We have the intermediate macros for KUNIT_EXPECT_PTR_GT() and friends,
but these macros don't exist.

I can see niche usecases for these macros existing, but since we've been
fine without them for so long, let's drop this dead code.

Users can instead cast the pointers and use the other GT/LT macros.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h | 60 --------------------------------------------
 1 file changed, 60 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index b032dd6816d2..c021945a75e3 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1044,21 +1044,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
 #define KUNIT_BINARY_LE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
 	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
 				    kunit_binary_assert,		       \
@@ -1069,21 +1054,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
 #define KUNIT_BINARY_GT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
 	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
 				    kunit_binary_assert,		       \
@@ -1094,21 +1064,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
 #define KUNIT_BINARY_GE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
 	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
 				    kunit_binary_assert,		       \
@@ -1119,21 +1074,6 @@ do {									       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
 #define KUNIT_BINARY_STR_ASSERTION(test,				       \
 				   assert_type,				       \
 				   left,				       \
-- 
2.34.1.703.g22d0c6ccf7-goog

