Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8503E1F94
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Aug 2021 01:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242607AbhHEXwO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 19:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242542AbhHEXwK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 19:52:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FD5C061798
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Aug 2021 16:51:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p71-20020a25424a0000b029056092741626so7708654yba.19
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Aug 2021 16:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QxYsxzaJfWoxD1mihF0RJctGuwELl/VrTwhSBSYHHsw=;
        b=GTH2Oy1G7yZNM3Wl8w4mfMPVIthiiY+Io8Nm5Z3IonVKTZoMJLhJpe95an6UFSi85B
         UN03qTtpIP53sA9y/qKdEiyt30bv7kCK4o6aDt0AJzHub5j8uCCUMUZL0vlQTXlEBw23
         sXryUyHbCDE4gdKoVU8DU7DQcyYzAoFZIZ33kEdeb7CgE5S5LZzAnuFxguayUhbl3x++
         oNNUBNun7P3Yz41J8BAR1+lWcBkq03de+D377zQ6+kgnkwbvLbjGnZFQOWAwg07VNjMR
         RNJLuTdpXgqoF4MrshdinR0ienKr2krD2RXOfj1SzuPMwdsb5nY8NPNcx1FmnPR9eb1R
         h2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QxYsxzaJfWoxD1mihF0RJctGuwELl/VrTwhSBSYHHsw=;
        b=Ai7vEG0gmg7Ucd+x3iwcVRnWBeVQXBsBW7lV8blEG6b5qQpODxlPnQ6u2hD6x4wBnN
         or8fyF8e3lxGXx0u+zve3B69rQR5oQhyRQhgTfLHsOWwsbepJ9iD67TmNMhT2gE8wbnP
         KLo1nC8PHCFJx7dHLcGBxYuJJk/VCB03dOlVYAhAGeEVUWjvZ3B9khxwpI+ip/KfxD9U
         K0KBtng6wlLkXCuzNA/HCIi56cDsaoLzh98oMZv4EEeLBvGomLOT5RMHENMEyAADu7jx
         3RIoswOsEptKWsCvhm+/ffl3FB3mRf0aSsXXRVB1baEUMMhHY8YtamWTWEmUqiT2HU41
         tSJw==
X-Gm-Message-State: AOAM533BPJkCvdZth20vNKE2MfxIy/7kVrFJBw5MOiB8eUBfv8o0yAZk
        hDjt/6RFIz+j/4BwDLYE1UMlSCNtvABmnQ==
X-Google-Smtp-Source: ABdhPJzktPLs6OC1HVI1NYznIviv2nE/tjfSMl/sfBdC2aDxMcJ5SJqRhGkhIHyuQ1sNanaM/Sp5O4vVrN+kXg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:ba4b:612a:402a:3fbd])
 (user=dlatypov job=sendgmr) by 2002:a25:e70c:: with SMTP id
 e12mr8890281ybh.333.1628207515050; Thu, 05 Aug 2021 16:51:55 -0700 (PDT)
Date:   Thu,  5 Aug 2021 16:51:45 -0700
In-Reply-To: <20210805235145.2528054-1-dlatypov@google.com>
Message-Id: <20210805235145.2528054-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20210805235145.2528054-1-dlatypov@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v2 2/2] kunit: add 'kunit.action' param to allow listing out tests
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
v1 -> v2: write about potential other "actions" in commit desc.
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
2.32.0.605.g8dce9f2422-goog

