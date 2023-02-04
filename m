Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4A768A810
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Feb 2023 05:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjBDEFV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 23:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjBDEFQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 23:05:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06A993E2F
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Feb 2023 20:05:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u8-20020a258408000000b00880a7cc9684so546299ybk.13
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Feb 2023 20:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r5EFoFMVQYP17Xk0sb+cncV8M1YLnWiOANhXlugOkSU=;
        b=BBJOOR76NkBgdtCg6usaleW4LsFx6vglyGlX8SyNwQPRg+rzfzIPIATi+uRucr4Sxy
         o+6DJtjTZypV5HMQ78NBcz2zeCuaxNChyT+F+GSsiJG4BQmGKFf+fjUA8jaOwF/ZUDJD
         wcDEKtRWNdWVI9bqhGTh6bOw/vR8Jul4cs1/sW5+pWWLe8o5bpDX6j06USstu0q1jQrj
         tJs3EZxdipuWXbgYhLTjRmhFwbLUZnt0TXHThqgaSUc2tP7YCJRVQgYxWbunC/aJ6Ohi
         QnpckY3xyGph3OKbe1AyuUv6nwtP1Pe19k9rcObeRTlBj3HGNuDejatA6ZqBntUVYfSO
         lt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5EFoFMVQYP17Xk0sb+cncV8M1YLnWiOANhXlugOkSU=;
        b=NxVz09KnP97upoYMf5Qz8ZfeXUtWiXDrWnOP2RQY8/C9mFW+1njDAn38F+zTA95V1p
         etXNeeAIYPuRPtF1kaE7+0hgpEcbO+keR9zhKuUTb3vIEECGtohNqq7k2Bcg4wNv4tf7
         M6ut7Vokqy66VDVjblFD+jZeJR8rNlnGmL6/FVF0iFm6yzgGLRvtu+CFi9vktQ7hSOM+
         fNlFvs0ZcKj+/thvJ+49OAi4JZSf++eRjVAV31gfbycqf+d2/XueaDpgkziFGfj21Spx
         avaQDinnSgLXoWLxxiySeEMR6/r9M2s3ru8gR/abk2wsG3aQzhelOrU7UFMp6foGMJi/
         2xRA==
X-Gm-Message-State: AO0yUKWYHhR5lzRlZXAsX6AUZ0Ogicv5NmObvFfbZnjbtjhjMoBvdrlK
        aUjd9rZUliJxxXNg1mX4OWhP9k5wn/arbQ==
X-Google-Smtp-Source: AK7set9nTil8ICmyhj+V3pe2+QNKgnsFyALqgFyookFeO+kG8LStHKMMPIjFn+V1LpwsXEaqDePIqmvS3FUTZg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a0d:ef87:0:b0:524:3607:6034 with SMTP id
 y129-20020a0def87000000b0052436076034mr7ywe.7.1675483510477; Fri, 03 Feb 2023
 20:05:10 -0800 (PST)
Date:   Sat,  4 Feb 2023 12:04:53 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230204040452.3699111-1-davidgow@google.com>
Subject: [PATCH] kunit: Add printf attribute to fail_current_test_impl
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>
Cc:     David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
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

Add the gnu_printf (__printf()) attribute to the
kunit_fail_current_test() implementation in
__kunit_fail_current_test_impl(). While it's not actually useful here,
as this function is never called directly, it nevertheless was
triggering -Wsuggest-attribute=format warnings, so we should add it to
reduce the noise.

Fixes: cc3ed2fe5c93 ("kunit: Add "hooks" to call into KUnit when it's built as a module")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/hooks-impl.h | 4 +++-
 lib/kunit/test.c       | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/hooks-impl.h b/lib/kunit/hooks-impl.h
index ec745a39832c..4e71b2d0143b 100644
--- a/lib/kunit/hooks-impl.h
+++ b/lib/kunit/hooks-impl.h
@@ -15,7 +15,9 @@
 #include <kunit/test-bug.h>
 
 /* List of declarations. */
-void __kunit_fail_current_test_impl(const char *file, int line, const char *fmt, ...);
+void __printf(3, 4) __kunit_fail_current_test_impl(const char *file,
+						   int line,
+						   const char *fmt, ...);
 void *__kunit_get_static_stub_address_impl(struct kunit *test, void *real_fn_addr);
 
 /* Code to set all of the function pointers. */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 51cae59d8aae..c9e15bb60058 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -24,7 +24,7 @@
 /*
  * Hook to fail the current test and print an error message to the log.
  */
-void __kunit_fail_current_test_impl(const char *file, int line, const char *fmt, ...)
+void __printf(3, 4) __kunit_fail_current_test_impl(const char *file, int line, const char *fmt, ...)
 {
 	va_list args;
 	int len;
-- 
2.39.1.519.gcb327c4b5f-goog

