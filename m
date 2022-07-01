Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE168562EB7
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Jul 2022 10:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiGAIr6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Jul 2022 04:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiGAIr4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Jul 2022 04:47:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367A673901
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Jul 2022 01:47:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s131-20020a254589000000b0066cb1230608so1479041yba.3
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Jul 2022 01:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ml8Z1qiNNiXT/1PzWyvvt8aN8dvJcZjDGqTV68m+tGo=;
        b=NAQpECpRDHIM/hlGNxwkg9Hv5tgmFumtJ6WiXYFdt9aQ4roUlytgKojb2oeQb8TjrB
         HtvQBKcDWTPW0CjksH/AhxabVHDzZRMvRckEaD1IChNoWcA+AfXWvMzo5dmBGoZ7rZ6N
         ISBu70K79ljdgzwwSF+syxkbcCxHMVeZ1DW4SyFLagkIxCY3sc/IbqWgF642UX89HEVY
         HCM2kY5y7QtM4/HpY7j5bkgVJKqqeel36d+kTOEv9wuWYxInCQtPmh0pNG58a4QwgHSS
         qD6mJgVR0l2XfXKAlRjasF9Q9XreGRXEuMYw9+sZwGQuRQ2K3W511ibsd9lsVTfQPphz
         1zfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ml8Z1qiNNiXT/1PzWyvvt8aN8dvJcZjDGqTV68m+tGo=;
        b=LPX8HhbR/g1HvEOtMTIrhFMG6FPOmwxc3Wuatqrclz/paTR2dknSo6Limy7WALEOdA
         K+I/0VptBwZKUj+gjZYqFtFJus5lH7vWkjm1zlBaM8BEBakrUXhwkc8jDFkAWKOxsqvZ
         30w1lNQBl7ibIjRapsomdeLK3a1DMCDDorS6nkIvdwmq3FWVgYvfH4cyVDd2huh7SUx3
         N2WgXuKVAJpYYKI+9Ij490GhJzPQ3puVq9ON3AXJIvFO80HjNdCrNEm94P7Nustg3fDA
         LQ+yPKU+2XBsj4qx1kDnFO1E5jDsw1nK716nmhaDgC2BT6FcjoUF/uTvIlgXPko14xIG
         qQLQ==
X-Gm-Message-State: AJIora9hfElVPpqISy2k/Tyn5BKc4BkmCnJClBtAl49UvdUKXDfL1AIE
        DNEl9YXO1d5OsqDS1Mw7r8oryMKCYGYjGw==
X-Google-Smtp-Source: AGRyM1v7ew3j0R7c9yqC49uzuTOOzGkqAmVFXXxCn9zfU56NTTgCwP9X9gSqBlJ1BgffmPx/w2LuWEXg7FpvCA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:2443:0:b0:2eb:4ffe:fab2 with SMTP id
 k64-20020a812443000000b002eb4ffefab2mr14909347ywk.330.1656665274440; Fri, 01
 Jul 2022 01:47:54 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:47:42 +0800
In-Reply-To: <20220701084744.3002019-1-davidgow@google.com>
Message-Id: <20220701084744.3002019-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220701084744.3002019-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 2/4] module: panic: Taint the kernel when selftest modules load
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

Taint the kernel with TAINT_TEST whenever a test module loads, by adding
a new "TEST" module property, and setting it for all modules in the
tools/testing directory. This property can also be set manually, for
tests which live outside the tools/testing directory with:
MODULE_INFO(test, "Y");

Signed-off-by: David Gow <davidgow@google.com>
---

This patch is new in v4 of this series.

---
 kernel/module/main.c  | 8 ++++++++
 scripts/mod/modpost.c | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index fed58d30725d..f2ca0a3ee5e6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1988,6 +1988,14 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 	/* Set up license info based on the info section */
 	set_license(mod, get_modinfo(info, "license"));
 
+	if (!get_modinfo(info, "test")) {
+		if (!test_taint(TAINT_TEST))
+			pr_warn("%s: loading test module taints kernel.\n",
+				mod->name);
+		add_taint_module(mod, TAINT_TEST, LOCKDEP_STILL_OK);
+	}
+
+
 	return 0;
 }
 
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 29d5a841e215..5937212b4433 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2191,6 +2191,9 @@ static void add_header(struct buffer *b, struct module *mod)
 
 	if (strstarts(mod->name, "drivers/staging"))
 		buf_printf(b, "\nMODULE_INFO(staging, \"Y\");\n");
+
+	if (strstarts(mod->name, "tools/testing"))
+		buf_printf(b, "\nMODULE_INFO(test, \"Y\");\n");
 }
 
 static void add_exported_symbols(struct buffer *buf, struct module *mod)
-- 
2.37.0.rc0.161.g10f37bed90-goog

