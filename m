Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBA837FE25
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 21:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhEMTda (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 15:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhEMTd1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 15:33:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2FFC061574
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 12:32:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e75-20020a25d34e0000b02904f982184581so3878001ybf.4
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 12:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=D+yqagsGWp1tAEgFX6sPw/TG2ByjsEg/cBXbIsBFBzw=;
        b=acF3o6KZ7Tyz+LT12SrTKSIZrlw0ycariii/Eq+dzME0v1aWXdhZqJisp7vrxn0pti
         kpp3pmw8ZfnovUCedVziAil5BfAoDXtdMFN5yZLgXb937CBgaKYfv3eV4Pw7nPtcacXs
         I7DYhVambo3aXKKNer/UVQezcunTjbAEOEgMdFC9rLp2dDUmdW/mPjYdwco2TeBP1cMa
         1Z1dSnZQ0ZTE9evtBew/VsOwz5aWQ3Yt6npE7Ax+eMxVIshkdZdU8T4M746Ra4vgZ1JB
         z7vKrXTWzXaw4+hlwESZGYv8/tdpdvJUeSwuLI+Y0lpTSk1VkCgkVpg2cBuSt7jVUMmg
         VkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=D+yqagsGWp1tAEgFX6sPw/TG2ByjsEg/cBXbIsBFBzw=;
        b=UHV7yfbqQ1Qj1/UgTKQCY62Hjt6aT1oAYXvEKYnWWJlbQ3r2yEa2uAdgqXk5iGiTRr
         /0xuEW1Wif+D5tI/0V+jd9sjrGEa+MrgMTF0IRZnznQjeyOgxFQVxYDYblKu/Z4J/gqT
         qhvjOjvtgaLLrUy98i+T/z4LbaLTuyqwMOU0mRl7HJivYkj+jISAtY5ZPBRwg8eRPa95
         Mtxhd2v7NXocGJr2HqdwuUuFJxhemMIOXLWdwCGK2ZqhW5w6wvTSIgKCMbXQQwVx5tKj
         MSi5O6a6Dui7xhlPjNyIuX02TpQPR11+ptDTrrQbE83iMdVSvjiUJQ7gowMalBTxCh3P
         /y5w==
X-Gm-Message-State: AOAM5324nlLlf7gLGEfvhVM/2VV8MUB9gEyTmnDG5KdNIJpK2pJgJMb0
        oL6Sd+0u9rvRDwfyHGVb8Eh8H5NY2KBJPw==
X-Google-Smtp-Source: ABdhPJzVzXZ4dRIPlNqyg2GWzAfK71f2xZtVVQeWjKQhSv1/edmZUwWher+K4Qy5JxEL4kjMkTcsQxMUK7hoAQ==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:5f61:8ca4:879b:809e])
 (user=davidgow job=sendgmr) by 2002:a25:4409:: with SMTP id
 r9mr44236161yba.401.1620934335869; Thu, 13 May 2021 12:32:15 -0700 (PDT)
Date:   Thu, 13 May 2021 12:31:55 -0700
Message-Id: <20210513193204.816681-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 01/10] kunit: Do not typecheck binary assertions
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The use of typecheck() in KUNIT_EXPECT_EQ() and friends is causing more
problems than I think it's worth. Things like enums need to have their
values explicitly cast, and literals all need to be very precisely
typed, else a large warning will be printed.

While typechecking does have its uses, the additional overhead of having
lots of needless casts -- combined with the awkward error messages which
don't mention which types are involved -- makes tests less readable and
more difficult to write.

By removing the typecheck() call, the two arguments still need to be of
compatible types, but don't need to be of exactly the same time, which
seems a less confusing and more useful compromise.

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20210507050908.1008686-1-davidgow@google.com/
- Tidy up the patch description to note that a warning was being
  produced, not an error.
- Add additional patches to remove many of the now unnecessary casts.

 include/kunit/test.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 49601c4b98b8..4c56ffcb7403 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -775,7 +775,6 @@ void kunit_do_assertion(struct kunit *test,
 do {									       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
-	((void)__typecheck(__left, __right));				       \
 									       \
 	KUNIT_ASSERTION(test,						       \
 			__left op __right,				       \
-- 
2.31.1.751.gd2f1c929bd-goog

