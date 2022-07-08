Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E1E56B1F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jul 2022 07:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbiGHEtb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 00:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbiGHEtY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 00:49:24 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39552B7C5
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Jul 2022 21:49:17 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s9-20020a170902ea0900b0016a4515b2e4so9491369plg.16
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Jul 2022 21:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1A6qYqJKHf9NGGZzmDub8k30/R66by5jlEKXrPXJj44=;
        b=SucqxFgX5rzmSoqNlZU2wpXRBbbPqhJVl8kphJxPAiVmOyq1RCb6fPcIgZTCECgvWY
         ZvzyzFgvUUwI2OfgQCMK/ZMVW2DbcyvoVaCjOIk3Dd9X8NddhS2BqOJEBFi1zlZGoDG9
         cBp+bBfHNgKW5bcgTDicUBNuURnwtK5JpSMpAudRip2/A0kgo09arl5cIxAqSggphD5h
         DlmAsg0XbQxTyWvCbiLSwdJ7D5fZkkDKn5z2B8yBbrjY7kie+eVqFCLQ95btr4MHp9KJ
         IkZ7oBqL3WHolRgwyxaP4j7aA4VVLVZ/jpHzsbqbpei9/XO0E7tMb7v8AsWgJnbkvxSx
         KOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1A6qYqJKHf9NGGZzmDub8k30/R66by5jlEKXrPXJj44=;
        b=MRwEEESoQUEIllKYRYLRYZGR6eIKaNWYalcjpuVmAwU+61+CQbQTY+sd0wXYyI0EDs
         12lj90frwZTTpDtybp2vRIg1QojQGJa14Z8s8Ph9Gd6ksTLKVGgZuFLC0FXhmAb7r2gd
         4xJqFaKUsbuaqkjp3Cwek4cbISF4dolYoivL4hxjR+MZv1Ky/+XAVScOOURaSjbX8NYn
         9vtPnBgO1vTihju0O+GMaTsIlLYZnBWn3v9K/toiBQlDzi5t1XdZVSZo/U/YBbCY5tE7
         xpcUTvX5nI8uq/Al3oIcfVrgleLHcWfgmidrcMsRk1sAr5EuTO52pqnD4TkGXLq2PKBk
         Isjw==
X-Gm-Message-State: AJIora9ZR6zkYXgSmEwNcOKKD7bBeHEI6tkLM5nwsrhGeAgvr1hYOvTx
        bbtZNrfEuq4A62kVq6bfQq8qfpoGJ8jogg==
X-Google-Smtp-Source: AGRyM1sNiqa//ZLeKy8OfqscWC5TleJ9FjN0cVegp4W+XLXK7wRYhByeorgwSFiNKTOHYZCDeoM1MTU2M/LAsw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr4643pje.0.1657255756113; Thu, 07 Jul
 2022 21:49:16 -0700 (PDT)
Date:   Fri,  8 Jul 2022 12:48:46 +0800
In-Reply-To: <20220708044847.531566-1-davidgow@google.com>
Message-Id: <20220708044847.531566-3-davidgow@google.com>
Mime-Version: 1.0
References: <20220708044847.531566-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v6 3/4] kunit: Taint the kernel when KUnit tests are run
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
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
        autolearn=ham autolearn_force=no version=3.4.6
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

No changes since v5:
https://lore.kernel.org/linux-kselftest/20220702040959.3232874-3-davidgow@google.com/

No changes since v4:
https://lore.kernel.org/linux-kselftest/20220701084744.3002019-3-davidgow@google.com/

Changes since v3:
https://lore.kernel.org/lkml/20220513083212.3537869-2-davidgow@google.com/
- Use MODULE_INFO() for KUnit modules.
  - This is technically redundant, as the KUnit executor will taint the
    kernel when _any_ KUnit tests are run, but may be useful if some
    other tool will parse the 'test' property.
- Add {Acked,Tested,Reviewed}-by tags.

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

