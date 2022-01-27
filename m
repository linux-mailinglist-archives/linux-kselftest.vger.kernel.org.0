Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90CE49EDC8
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 22:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiA0Vw3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 16:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiA0Vw3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 16:52:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515D9C061714
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 13:52:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e13-20020a25e70d000000b00615e9bc9a3cso8441686ybh.22
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 13:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JPoXnQxk1ka8IPJ0XT1Jbys/cgKi0K3dUrFoxr2hH90=;
        b=AREOSaMxAUumJURgukoWmMtb4bSG3MUzjwZxH13PkmDxsGa4jqih87mtx1VOca+FO+
         uYfHoElnx0xbW8dtx76lzBMyitQ0SijCqOknlvCAYkHaMqlRry/XHIoVCp3rwviHZSgZ
         5bveJRUoYiigwe3v4MKWOwS9NCpzHJJjxEGjdTYRWDJl5jmezh5cQiG+2mffhKOSMUqF
         rtAjR5XdiS4w+O+XH6sUTpQKhZdlVKpUhzwT3iKLMIn95BmULQpHT24yxyrbe8UemQ3u
         /tq+IrAs3bU4yw3U9ZmFGuvxd1BtW3icneIalGq5YrU884YGNAhO4EP48UUd30aYuBd6
         69og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JPoXnQxk1ka8IPJ0XT1Jbys/cgKi0K3dUrFoxr2hH90=;
        b=29AbVo3Gu+gt8GSD1VkvMOVcKQTEjMMW3fiaCaD68F+5IKbCrEJVxoFquoOShm+Oa1
         PsvZ91k/SLIWXbiJ18/V4E/KP1ZQ5+nyrXROZfA8GCTUm3seW1giyPa9B3V4SLLmxtAl
         mTJswJxRkVr7oR89rFXug+6H1ZJaR42Fk8AV9611EiZHEhFSyTILeAEWjNw/zI3Z1pj3
         mtkkq7fjamLLdJkQ/I2BBVks0NgGsHb3ZbJZAbbYcQukp7fTqllO7YgxQwk7uVxzUWxc
         HtyxIha51Dlg6mm11k3ONg71DXlq6fGrI/LDH1oKzQi6wFt6tKZTjvDVkv0QfRRLFNav
         X0DQ==
X-Gm-Message-State: AOAM532SWvVgVT/2TDJwthP0efn19SDl+gLq9IChWwkSf7Rs1LEm0Pph
        mGE5rmJoVnw1QeBNXhKh/yEl2XcgGcwuSg==
X-Google-Smtp-Source: ABdhPJzBGtnLv/y52L2vEZJ97rm4iMHe/jYh76HL0wmgaI1BonlqwJGG8ueykRayA1mNwbDWnLuCJ5DjNAhFWQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:5484:2aa:f5f4:a1e0])
 (user=dlatypov job=sendgmr) by 2002:a81:23d1:: with SMTP id
 j200mr0ywj.471.1643320347735; Thu, 27 Jan 2022 13:52:27 -0800 (PST)
Date:   Thu, 27 Jan 2022 13:52:22 -0800
Message-Id: <20220127215222.159049-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH] kunit: cleanup assertion macro internal variables
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

All the operands should be tagged `const`.
We're only assigning them to variables so that we can compare them (e.g.
check if left == right, etc.) and avoid evaluating expressions multiple
times.

There's no need for them to be mutable.

Also rename the helper variable `loc` to `__loc` like we do with
`__assertion` and `__strs` to avoid potential name collisions with user
code.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
Note: this patch is based on top of
https://lore.kernel.org/all/20220125210011.3817742-4-dlatypov@google.com/
There is no semantic dependency between the patches, but they touch
adjacent lines.
---
 include/kunit/test.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 088ff394ae94..00b9ff7783ab 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -779,10 +779,10 @@ void kunit_do_failed_assertion(struct kunit *test,
 
 #define KUNIT_ASSERTION(test, assert_type, pass, assert_class, INITIALIZER, fmt, ...) do { \
 	if (unlikely(!(pass))) {					       \
-		static const struct kunit_loc loc = KUNIT_CURRENT_LOC;	       \
+		static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;       \
 		struct assert_class __assertion = INITIALIZER;		       \
 		kunit_do_failed_assertion(test,				       \
-					  &loc,				       \
+					  &__loc,			       \
 					  assert_type,			       \
 					  &__assertion.assert,		       \
 					  fmt,				       \
@@ -872,8 +872,8 @@ void kunit_do_failed_assertion(struct kunit *test,
 				    fmt,				       \
 				    ...)				       \
 do {									       \
-	typeof(left) __left = (left);					       \
-	typeof(right) __right = (right);				       \
+	const typeof(left) __left = (left);				       \
+	const typeof(right) __right = (right);				       \
 	static const struct kunit_binary_assert_text __text = {		       \
 		.operation = #op,					       \
 		.left_text = #left,					       \
@@ -956,7 +956,7 @@ do {									       \
 						fmt,			       \
 						...)			       \
 do {									       \
-	typeof(ptr) __ptr = (ptr);					       \
+	const typeof(ptr) __ptr = (ptr);				       \
 									       \
 	KUNIT_ASSERTION(test,						       \
 			assert_type,					       \
-- 
2.35.0.rc2.247.g8bbb082509-goog

