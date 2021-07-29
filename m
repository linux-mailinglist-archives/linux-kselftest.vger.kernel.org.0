Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D159C3DB00F
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jul 2021 01:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhG2Xzw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 19:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbhG2Xzt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 19:55:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE575C061765
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 16:55:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g11-20020a25ae4b0000b02905792fb55b0bso8372173ybe.9
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 16:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xV6nYQh6vIeMfHMSX9yqr53Q2dMYFsvSCqcZj7BCtOg=;
        b=cw4/EPbIsQnnba25xZG+p5I7r5Y9lGea6Ti2p3P0TazdUW6zQ2hKxXDWgnknL2KqHi
         cvyE/StrZrcbgcN5pRMLdKjvJ9vVsLw0EHoWDKFcL971eosaUzHAP4B2TgcJi57ewV0j
         x4+8Lp7zoYyT7gRICQ+2lbChqISsmWmyuAt7pUZdnn00/STQT68KomTTuEoo3PJejKDW
         oVqp6p7EJ0JUXXSsmbf+SF/ujTJ670VCrWYSM4BVaUxbzw2eF3LL93jAgnlPLEVDP1/H
         LmIpcuXGew+nT4M+g7RQj4g+tC1+sPabep/g9W2fEswOpdPpy5csHyOthQTUqzgH3Ijr
         5YjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xV6nYQh6vIeMfHMSX9yqr53Q2dMYFsvSCqcZj7BCtOg=;
        b=oVfk+briWoCFjCxFolO9XLv8zFlHP3eCf/M2NlJo1Yo/3s3BaXoBamd5zdT6Wgvs1f
         mxez4aQ6t+2cbNz4uPS1wpT2zWpixpooqrd53dAzTodukVu02K8H84f3TInohTcNfd8e
         ags9ct8oD+AU99eJAOV4ez+ROu5HJaQzyggIJm6h8xfjJA9aG1lWj7cHo7H4r4U0FP4M
         vcE2ARuZA4tRDhBiTbRjm3guXc7LrL1287DTszbSdLymEjYot33Evmw7etV7xs/N360R
         78/RLiPDScgmrckWFnC+CkSqpRORE1Pqs5ip2ree0+1kepad6BZST2WeMVxsMJE8TL40
         8Y4g==
X-Gm-Message-State: AOAM530QAS/9QkcVgwT5vr6Ei20wtzFRzMDBtQoI5Mf9wR46lSLuivbf
        3FaZS37XmK8xLTz/PQN74WyV/URjjFJc3g==
X-Google-Smtp-Source: ABdhPJz23N1pr4/WLiuePyhNmZsXzuXEg23lQU9LHDM9bFHRyo28b9fsgrhp+u5jedCZGCOCmpYtVOorWfo6cg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:675d:5947:e389:b947])
 (user=dlatypov job=sendgmr) by 2002:a25:2d17:: with SMTP id
 t23mr9865289ybt.125.1627602945174; Thu, 29 Jul 2021 16:55:45 -0700 (PDT)
Date:   Thu, 29 Jul 2021 16:55:21 -0700
In-Reply-To: <20210729235521.1127484-1-dlatypov@google.com>
Message-Id: <20210729235521.1127484-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20210729235521.1127484-1-dlatypov@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH 2/2] kunit: add 'kunit.action' param to allow listing out tests
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

Having a standard, easy way of getting the list could be useful in a
number of ways. For example, if we also extended kunit.filter_glob to
allow filtering on tests, this would allow users to run tests cases one
by one if they wanted to debug hermeticity issues.

This patch:
* adds a kunit.action module param with one valid non-null value, "list"
* for the "list" action, it simply prints out "<suite>.<test>"
* does not itself introduce kunit.py changes to make use of this [1].

Note: kunit.filter_glob is respected for this and all future actions.
Note: we need a TAP header for kunit.py to isolate the KUnit output.

Tested:
$ ./tools/testing/kunit/kunit.py run --kernel_arg=kunit.action=list --raw_output=kunit
...
TAP version 14
1..1
example.example_simple_test
example.example_skip_test
example.example_mark_skipped_test
reboot: System halted

[1] The interface for this can work in a few ways. We could add a
--list_tests flag or a new subcommand. But this change is enough to
allow people to split each suite into its own invocation, e.g. via a
short script like:

  #!/bin/bash

  cd $(git rev-parse --show-toplevel)

  for suite in $(
    ./tools/testing/kunit/kunit.py run --kernel_args=kunit.action=list --raw_output=kunit |
    sed -n '/^TAP version/,$p' | grep -P -o '^[a-z][a-z0-9_-]+\.' | tr -d '.' | sort -u);
  do
    ./tools/testing/kunit/kunit.py run "${suite}"
  done

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/executor.c | 46 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index acd1de436f59..77d99ee5ed64 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -15,9 +15,16 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 #if IS_BUILTIN(CONFIG_KUNIT)
 
 static char *filter_glob_param;
+static char *action_param;
+
 module_param_named(filter_glob, filter_glob_param, charp, 0);
 MODULE_PARM_DESC(filter_glob,
-		"Filter which KUnit test suites run at boot-time, e.g. list*");
+		 "Filter which KUnit test suites run at boot-time, e.g. list*");
+module_param_named(action, action_param, charp, 0);
+MODULE_PARM_DESC(action,
+		 "Changes KUnit executor behavior, valid values are:\n"
+		 "<none>: run the tests like normal\n"
+		 "'list' to list test names instead of running them.\n");
 
 static char *kunit_shutdown;
 core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
@@ -109,6 +116,33 @@ static void kunit_print_tap_header(struct suite_set *suite_set)
 	pr_info("1..%d\n", num_of_suites);
 }
 
+static void kunit_exec_run_tests(struct suite_set *suite_set)
+{
+	struct kunit_suite * const * const *suites;
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
 int kunit_run_all_tests(void)
 {
 	struct kunit_suite * const * const *suites;
@@ -120,10 +154,12 @@ int kunit_run_all_tests(void)
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
 		for (suites = suite_set.start; suites < suite_set.end; suites++)
-- 
2.32.0.554.ge1b32706d8-goog

