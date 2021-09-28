Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC4941BA65
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 00:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243154AbhI1WbW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Sep 2021 18:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243128AbhI1WbP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Sep 2021 18:31:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1861C061746
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Sep 2021 15:29:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y134-20020a25dc8c000000b0059f0301df0fso710691ybe.21
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Sep 2021 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bHizloEx22Z6hLibzG6QcbUw3rTdxTIS5l8/XPEsnqo=;
        b=rGdb5TCCUvotiU9FT5MrlYDHot35pUEKPJgFHTdPY0YXARmH8LEx3qZFYpCCFqBd5G
         qlviHB+rPPKP0ETy9LQCxfkgG0iQsULhZu3HOhs9SbWbB42kushGP2BaXyym0WCoD+LI
         q2pA7fQ8MBgxefmInsy5KnNA6KN5nEDdLGXhQAXo83WTWmZZif+b4VsvtB4c9pA2sWSK
         AlvLtFyGH264wotPmkvh08LxFWdp9qjzyEjEwjvUvwZkf0pPhc9m18knq/wuP1P8SbL9
         +YPksmrqs79gKZMK+pMn3Ce5+u038G3fQDT0M03vlSwRQJb6J8kjy787FChmw78mDuMQ
         6FMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bHizloEx22Z6hLibzG6QcbUw3rTdxTIS5l8/XPEsnqo=;
        b=F9EeGBvi8u+EvmLibuGjmGj8U4gLAG2LqspZn6ws4U8T8ShtSgkAwGVoHfcSAdXygf
         1fJE2YRbEVsMiwds/higk1rJsqN9uRJNAr+qRm53UnYNNWtPLrXjkxAnb3YFR6hRSrOF
         q7d5NmkVVcPFzJMSzr7A5jTaNT19uUH4dqiZxDixSsKa/sYlwyxySCH6G2N5RuNjB931
         CaPuLextiVU3ra/Hgb7azT42cDxuZ/oqNvnZA9f160mf22FJiQZ27Cl1U+OUxtIavSm0
         U8MX+879Tii2Ocz5rkHbnn7idEoVODfGxHkY4YFVBjm6rvKhCe01NpVPyzHado0PIfC4
         ZG1w==
X-Gm-Message-State: AOAM530wlRR0TVDNEalF5CNC1Xww8P1dIQU078FyDFPVf2WvcF4aE15I
        04LcOS0aQYr2S7utn7PQvrjlb9EZmZLi8A==
X-Google-Smtp-Source: ABdhPJwM80TM5YxWBCZ6qQnnFISrE/Tp2ZJIPuykwhP7hBb+dHmK6I2AFadL6KxXr78LOMLp3d6iOO747rkknA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:981c:22f3:3855:9bb7])
 (user=dlatypov job=sendgmr) by 2002:a25:86cd:: with SMTP id
 y13mr1557471ybm.528.1632868175217; Tue, 28 Sep 2021 15:29:35 -0700 (PDT)
Date:   Tue, 28 Sep 2021 15:29:24 -0700
In-Reply-To: <20210928222926.1180749-1-dlatypov@google.com>
Message-Id: <20210928222926.1180749-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20210928222926.1180749-1-dlatypov@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 1/3] kunit: add 'kunit.action' param to allow listing out tests
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Context:
It's difficult to map a given .kunitconfig => set of enabled tests.
Letting kunit.py figure that out would be useful.

This patch:
* is intended to be an implementation detail used only by kunit.py
* adds a kunit.action module param with one valid non-null value, "list"
* for the "list" action, it simply prints out "<suite>.<test>"
* leaves the kunit.py changes to make use of this for another patch.

Note: kunit.filter_glob is respected for this and all future actions.

Hack: we print a TAP header and fake test plan to allow kunit.py to
use the same code to pick up KUnit output that it does for normal tests.
Since this is intended to be an implementation detail, it seems fine for
now. Maybe in the future we ouptut each test as SKIPPED or the like.

Go with a more generic "action" param, since it seems like we might
eventually have more modes besides just running or listing tests, e.g.
* perhaps a benchmark mode that reruns test cases and reports timing
* perhaps a deflake mode that reruns test cases that failed
* perhaps a mode where we randomize test order to try and catch
  hermeticity bugs like "test a only passes if run after test b"

Tested:
$ ./tools/testing/kunit/kunit.py run --kernel_arg=kunit.action=list --raw_output=kunit
...
TAP version 14
1..1
example.example_simple_test
example.example_skip_test
example.example_mark_skipped_test
reboot: System halted

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/executor.c | 45 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index bab3ab940acc..8b38c91b4fac 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -15,9 +15,16 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 #if IS_BUILTIN(CONFIG_KUNIT)
 
 static char *filter_glob_param;
+static char *action_param;
+
 module_param_named(filter_glob, filter_glob_param, charp, 0);
 MODULE_PARM_DESC(filter_glob,
 		"Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test");
+module_param_named(action, action_param, charp, 0);
+MODULE_PARM_DESC(action,
+		 "Changes KUnit executor behavior, valid values are:\n"
+		 "<none>: run the tests like normal\n"
+		 "'list' to list test names instead of running them.\n");
 
 /* glob_match() needs NULL terminated strings, so we need a copy of filter_glob_param. */
 struct kunit_test_filter {
@@ -196,9 +203,35 @@ static void kunit_print_tap_header(struct suite_set *suite_set)
 	pr_info("1..%d\n", num_of_suites);
 }
 
-int kunit_run_all_tests(void)
+static void kunit_exec_run_tests(struct suite_set *suite_set)
 {
 	struct kunit_suite * const * const *suites;
+
+	kunit_print_tap_header(suite_set);
+
+	for (suites = suite_set->start; suites < suite_set->end; suites++)
+		__kunit_test_suites_init(*suites);
+}
+
+static void kunit_exec_list_tests(struct suite_set *suite_set)
+{
+	unsigned int i;
+	struct kunit_suite * const * const *suites;
+	struct kunit_case *test_case;
+
+	/* Hack: print a tap header so kunit.py can find the start of KUnit output. */
+	kunit_print_tap_header(suite_set);
+
+	for (suites = suite_set->start; suites < suite_set->end; suites++)
+		for (i = 0; (*suites)[i] != NULL; i++) {
+			kunit_suite_for_each_test_case((*suites)[i], test_case) {
+				pr_info("%s.%s\n", (*suites)[i]->name, test_case->name);
+			}
+		}
+}
+
+int kunit_run_all_tests(void)
+{
 	struct suite_set suite_set = {
 		.start = __kunit_suites_start,
 		.end = __kunit_suites_end,
@@ -207,10 +240,12 @@ int kunit_run_all_tests(void)
 	if (filter_glob_param)
 		suite_set = kunit_filter_suites(&suite_set, filter_glob_param);
 
-	kunit_print_tap_header(&suite_set);
-
-	for (suites = suite_set.start; suites < suite_set.end; suites++)
-		__kunit_test_suites_init(*suites);
+	if (!action_param)
+		kunit_exec_run_tests(&suite_set);
+	else if (strcmp(action_param, "list") == 0)
+		kunit_exec_list_tests(&suite_set);
+	else
+		pr_err("kunit executor: unknown action '%s'\n", action_param);
 
 	if (filter_glob_param) { /* a copy was made of each array */
 		kunit_free_suite_set(suite_set);
-- 
2.33.0.685.g46640cef36-goog

