Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34077563E9C
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 07:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiGBFMQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 01:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiGBFMO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 01:12:14 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFACB2A434
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Jul 2022 22:12:10 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id p10-20020a631e4a000000b0040d2af22a74so2084469pgm.5
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Jul 2022 22:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FXDOVHKKv/Ct7G63am591KJ/jKCBJOElGG/6AF1hRUk=;
        b=eU5E1IkJFySb7qvJXe/F66qE6Yptt3fhfs21I6wv55+iaHhTIjXIwgoz35qqySdolW
         y2JuQQMS1QMZ6H4g3x94gKz2R7DvMKcQRga6Ap2PlI3cDtZs5QjYakUuggtCzrDckmsG
         q/Cmi+3F6Tmk7gLL2p3IuXtf5FfgRXGIHg3RpL/0WdA2sapBrl2g1Rr/7PZ2gV7sz7lm
         T7higJi3LrLZASEkQF7rJNgXBlSkFlO554ljvCm4yfwPx4jjEtmR8u5pW18X4pt+6uVk
         KqEaeW46hHRCQwPVDSbSp3Ux02E5LQq3KOLaCL+i8JSlyeYYA8oUcb3eNYBiJT2N8gN4
         /gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FXDOVHKKv/Ct7G63am591KJ/jKCBJOElGG/6AF1hRUk=;
        b=TrPC/8YtZS+uZzS9cJ/R3kmrHSEpLsFBlVOjTPr1A4h+XVTp4EVKAjeycS+8GB41rS
         fwNED/cvssxFZrkRQqE7zCoDU30Mv8CXgc8zklkX7zNhRtK55tfYLrEHTKEw+uW0wPf2
         /KKGgjL4lm6gd0LoZS5UUOTAFIYCAjLl+fhHoCqnVo4+Kcp+XBoUZUcTiV9eCsryiy9Y
         i7yJ6BLmE055FQoEOEnqQ64xEJmvIRe7igWaQtpuANuTOXWOf0AyXPsdGgKZfp8Nn54y
         KLsKjmJQt6JUg4/R4+WC1e6an55puEHaw0zYjMRFk/jaX8zfHIqtkDm2sxUFuobE8H+t
         AGIw==
X-Gm-Message-State: AJIora/g9UYdPES8/snFB2OwDxfGmZzmJlvFwUVhnq8r+PcBZwTtZXMa
        8Rc9LgThVArDc4135wEPf1teFdC2FPVrEw==
X-Google-Smtp-Source: AGRyM1uwlYtREUfsnXJSILU7FARqbS45lJAy3QlG+aJqOmgN42PdfzGJN/rFRYnT1YjzbPR+yfoME+fR+4z97Q==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:903:1c4:b0:16a:73fd:3c6c with SMTP id
 e4-20020a17090301c400b0016a73fd3c6cmr23401813plh.115.1656738730290; Fri, 01
 Jul 2022 22:12:10 -0700 (PDT)
Date:   Sat,  2 Jul 2022 13:12:05 +0800
Message-Id: <20220702051205.3292468-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] kunit: Documentation: Fix a kernel-doc reference
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        Kees Cook <keescook@chromium.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

When building the KUnit documentation, the reference to
kunit_test_suites in the kunit_test_init_section_suites kernel-doc
comment gives an error:
Documentation/dev-tools/kunit/api/test:9: ./include/kunit/test.h:323: WARNING: Inline interpreted text or phrase reference start-string without end-string.

This is because the reference is mixing two function reference styles:
adding an '&' to the front, and "()" to the end. The latter is neater,
so get rid of the '&'.

Fixes: 9bf2eed995f9 ("kunit: add support for kunit_suites that reference init code")
Signed-off-by: David Gow <davidgow@google.com>
---

(As a KUnit patch, we'll accept this via the KUnit tree.)

---
 include/kunit/test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8ffcd7de9607..f1c1a95df9b8 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -320,7 +320,7 @@ static inline int kunit_run_all_tests(void)
  *
  * @__suites: a statically allocated list of &struct kunit_suite.
  *
- * This functions identically as &kunit_test_suites() except that it suppresses
+ * This functions identically as kunit_test_suites() except that it suppresses
  * modpost warnings for referencing functions marked __init or data marked
  * __initdata; this is OK because currently KUnit only runs tests upon boot
  * during the init phase or upon loading a module during the init phase.
-- 
2.37.0.rc0.161.g10f37bed90-goog

