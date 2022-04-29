Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0C951417E
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Apr 2022 06:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiD2EnY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 00:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiD2EnX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 00:43:23 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1A816590
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 21:40:03 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id k5-20020a636f05000000b003aab7e938a5so3363605pgc.21
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 21:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7pAm/LDFHoDLOVuIZx6NOUlnYoOG6z2KtSbentQNohQ=;
        b=lOJ6ndqujbkQ9y8YtiKLh1NmKtjsaaYLb7DNBKdzwM6kNdDJymwTB229+sHcII9IGm
         ZgijMD9LB65oEfpnzDUuw7gMa1qtR6k7S2ZlegTaofUACUzwpv8vlppdU55LGRFu3xOo
         DTTGaB92cV5r20Fkg0e2H9E3kthvAOiLTkz3TfcnrbdLxtSzKUl/QUaAPl9Nlyd9d+NP
         hlFSo4WvNXsXYW96S52BZhtTswOFsceMy/Pzv0U02tJAyQ7NxtUhQdPT8MVsYrL7qi8C
         lrvnil194+31LqgOEWw4WdQqbFQ3bkGTAw/oDIyQ1CcH4F+XIZe5J159ZKBObnviPkrs
         Yh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7pAm/LDFHoDLOVuIZx6NOUlnYoOG6z2KtSbentQNohQ=;
        b=6ThWMo2GvjlT9f4pztR1xgp2pQwkNlIJd/AcUtoa2lGaEKoEiygdl5v8vB5gR/Pv/U
         pyz1dgcRD6UqX+Bq80NQXlWS0mD7N+5Olv5rjueUCwxrmlF4RYD0OwvoEHfYY/kEJkXb
         vPJWq2fMzJUqae6N5iGOge08ghtkDA+m1zj7fZpgsgHjwjuWORHrR78HI3WUXx5WnbLk
         t5+UvwULeaOLjiPmxiz8kGSgC7gjW1MJwRKOmMrm1hFYCkW99IjaE4ZhPg1ibkmN6b8P
         9Iv1EFNaAdr9Pema6W8Uc332eGBy5bAlztYdoEux1SnRLmSslO0IzqJw8PlDyMNnxp4h
         mujQ==
X-Gm-Message-State: AOAM531iQ7ZmmFcxiCjWzOoXnvdJPVnMXt40jkeQmNORtlwkGL2uZC/c
        hv7lfn4uZcJD9OxxsjdfnhsdsFYoJe4ufQ==
X-Google-Smtp-Source: ABdhPJymcIZSLhtD4Eu7q4Ap5bwpv/nVLCJ/HlABq4/5Ntta3fkMA3IydOm1P3Wx780QZrTfXCSsdCH/PLWsog==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:902:ce02:b0:151:a86d:dc2b with SMTP
 id k2-20020a170902ce0200b00151a86ddc2bmr37514527plg.57.1651207203378; Thu, 28
 Apr 2022 21:40:03 -0700 (PDT)
Date:   Fri, 29 Apr 2022 12:39:14 +0800
Message-Id: <20220429043913.626647-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH] kunit: Taint kernel if any tests run
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

KUnit tests are not supposed to run on production systems: they may do
deliberately illegal things to trigger errors, and have security
implications (assertions will often deliberately leak kernel addresses).

Add a new taint type, TAINT_KUNIT to signal that a KUnit test has been
run. This will be printed as 'N' (for kuNit, as K, U and T were already
taken).

This should discourage people from running KUnit tests on production
systems, and to make it easier to tell if tests have been run
accidentally (by loading the wrong configuration, etc.)

Signed-off-by: David Gow <davidgow@google.com>
---

This is something I'd been thinking about for a while, and it came up
again, so I'm finally giving it a go.

Two notes:
- I decided to add a new type of taint, as none of the existing ones
  really seemed to fit. We could live with considering KUnit tests as
  TAINT_WARN or TAINT_CRAP or something otherwise, but neither are quite
  right.
- The taint_flags table gives a couple of checkpatch.pl errors around
  bracket placement. I've kept the new entry consistent with what's
  there rather than reformatting the whole table, but be prepared for
  complaints about spaces.

Thoughts?
-- David

---
 Documentation/admin-guide/tainted-kernels.rst | 1 +
 include/linux/panic.h                         | 3 ++-
 kernel/panic.c                                | 1 +
 lib/kunit/test.c                              | 4 ++++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index ceeed7b0798d..8f18fc4659d4 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -100,6 +100,7 @@ Bit  Log  Number  Reason that got the kernel tainted
  15  _/K   32768  kernel has been live patched
  16  _/X   65536  auxiliary taint, defined for and used by distros
  17  _/T  131072  kernel was built with the struct randomization plugin
+ 18  _/N  262144  a KUnit test has been run
 ===  ===  ======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
diff --git a/include/linux/panic.h b/include/linux/panic.h
index f5844908a089..1d316c26bf27 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -74,7 +74,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_LIVEPATCH			15
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
-#define TAINT_FLAGS_COUNT		18
+#define TAINT_KUNIT			18
+#define TAINT_FLAGS_COUNT		19
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/kernel/panic.c b/kernel/panic.c
index eb4dfb932c85..b24ca63ed738 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -404,6 +404,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
+	[ TAINT_KUNIT ]			= { 'N', ' ', false },
 };
 
 /**
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 0f66c13d126e..ea8e9162445d 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -11,6 +11,7 @@
 #include <kunit/test-bug.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
+#include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
 
@@ -498,6 +499,9 @@ int kunit_run_tests(struct kunit_suite *suite)
 	struct kunit_result_stats suite_stats = { 0 };
 	struct kunit_result_stats total_stats = { 0 };
 
+	/* Taint the kernel so we know we've run tests. */
+	add_taint(TAINT_KUNIT, LOCKDEP_STILL_OK);
+
 	kunit_print_subtest_start(suite);
 
 	kunit_suite_for_each_test_case(suite, test_case) {
-- 
2.36.0.464.gb9c8b46e94-goog

