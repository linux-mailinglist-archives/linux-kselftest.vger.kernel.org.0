Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEE7563E2A
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 06:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiGBEKV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 00:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiGBEKQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 00:10:16 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA6130560
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Jul 2022 21:10:15 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id u13-20020a17090a4bcd00b001eefd8fa171so1941911pjl.2
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Jul 2022 21:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PtLO6IdA/ejKq3y5cNTb8tv3Fwaz8VhRhGcv2qLEc+w=;
        b=PBmdJc1M/oHFNfRQca5cVRdely/fXH+p63r8m9g1bKicCm/1KfuNbC+U1Nj38uk30x
         zm/qFkQte1xbHx99xZBbYpJXEqePj0P+z1QGO1x+Egflz6Y5DMcTZrPWHt6jF1Z0Kw4C
         8Lp6x5tx3ttTzKiEMICNgbMkzEYcIO9Amnet/pYwMMf9tsXFxfE54ey+EW1sKUy3yX9o
         Mq2j8XCIL4MmEUQwe63f+4JY3uc/LGTMqUnKBk6+Jub5l045zizu6On17vVXZCORYDvp
         O1ME/T3feTZNJs8dZi0S2xVT8jYCSSNyZ1nz9X8ZVvC0PwYrh83cdzhQDiMNLjjnORB+
         ZcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PtLO6IdA/ejKq3y5cNTb8tv3Fwaz8VhRhGcv2qLEc+w=;
        b=qpRjAHMtkV0JeuVMoDU7nKd0pOKcdmXERHVOihOWtUK1H2/X8/ETsICQqwoEq+vM0Y
         Krahyx6UTtU7QDF76bxBp3ARdYBjiBrgrmenkOBP4zLzzqW3rVuY14r2DKP2/d9X3Pkn
         QnHfHc9Lnsx62NrjsMICv5msLMRo8jaET3HwvrtD1jyKV4EY1mVY321uS82XlojU3ej3
         Tap7VEHOIXjn6Wf1WerEyiSX0GRZiXZbW7xEKluLYC/u7aM2UkXoyBtTRIoJVyeLDRE5
         jR7FdCUC0pW6rdMF1n+wpgBj5pcI7pM33g0YNE952FMHJMjJ/JXu+bR7oSRYtfKH6OcR
         mjdw==
X-Gm-Message-State: AJIora/sCbiMPz8xtP+imRC6cgbZgh4/BCABVcx8Ju6uiKp2USjbhRom
        +S9V2Y1/sugQSmgCso6fH3ixQRtjbxSf/g==
X-Google-Smtp-Source: AGRyM1u47dhGQ5WGDHXPJOq9QdoYh4Ivg8v1FNCAipU9iw/L1xMWwUtVSl3eTWQoOraMr89FZocBiPoLvkYXXQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6a00:2295:b0:525:6c57:8dea with SMTP
 id f21-20020a056a00229500b005256c578deamr23491809pfe.62.1656735014424; Fri,
 01 Jul 2022 21:10:14 -0700 (PDT)
Date:   Sat,  2 Jul 2022 12:09:58 +0800
In-Reply-To: <20220702040959.3232874-1-davidgow@google.com>
Message-Id: <20220702040959.3232874-3-davidgow@google.com>
Mime-Version: 1.0
References: <20220702040959.3232874-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v5 3/4] kunit: Taint the kernel when KUnit tests are run
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
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

Make KUnit trigger the new TAINT_TEST taint when any KUnit test is run.
Due to KUnit tests not being intended to run on production systems, and
potentially causing problems (or security issues like leaking kernel
addresses), the kernel's state should not be considered safe for
production use after KUnit tests are run.

This both marks KUnit modules as test modules using MODULE_INFO() and
manually taints the kernel when tests are run (which catches builtin
tests).

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Tested-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/test.h | 3 ++-
 lib/kunit/test.c     | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8ffcd7de9607..ccae848720dc 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -277,7 +277,8 @@ static inline int kunit_run_all_tests(void)
 	{								\
 		return __kunit_test_suites_exit(__suites);		\
 	}								\
-	module_exit(kunit_test_suites_exit)
+	module_exit(kunit_test_suites_exit)				\
+	MODULE_INFO(test, "Y");
 #else
 #define kunit_test_suites_for_module(__suites)
 #endif /* MODULE */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index a5053a07409f..8b11552dc215 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -11,6 +11,7 @@
 #include <kunit/test-bug.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
+#include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
 
@@ -501,6 +502,9 @@ int kunit_run_tests(struct kunit_suite *suite)
 	struct kunit_result_stats suite_stats = { 0 };
 	struct kunit_result_stats total_stats = { 0 };
 
+	/* Taint the kernel so we know we've run tests. */
+	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
+
 	if (suite->suite_init) {
 		suite->suite_init_err = suite->suite_init(suite);
 		if (suite->suite_init_err) {
-- 
2.37.0.rc0.161.g10f37bed90-goog

