Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601EC41E3C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Oct 2021 00:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348220AbhI3WWj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 18:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345914AbhI3WWi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 18:22:38 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAB3C06176C
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 15:20:54 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id x6-20020ac81206000000b002a6e46bbd0eso13160074qti.12
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 15:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oVM2hdB8RC6fQaL+4s/CT41d6411HX3AvlV7ayHiB3g=;
        b=AMGRccwhHZXbfrGDzWdiEQa4o0WoQuZHgVHTTrethAAfudcI4snNltoUj9hEH9/WGz
         KApiWEVCNdyu5XuSPp+NXYApczDc3AAPsTzn7lx+6P1YqK4/WL3rBdwNH+mDeZnL6bMt
         BkDbBvwzw9kj/S8gYBpkFrcF7UuwCQcN1PUTx62mnwJh+oWtnEJyeR01SL4zv9sXImHg
         FWZ7J8c1YA7exgHs1+KAnrQLwpDUef125cDKgXBIfuH+v1CihC7oIyIyEDkf7Qx/63Iu
         n4UygnTVJ9qKQF56EQLqOkTADCiqjT+rkN7OoHxKh6UzwZX4xwy+9pxE9d6CNKEUYlyg
         BTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oVM2hdB8RC6fQaL+4s/CT41d6411HX3AvlV7ayHiB3g=;
        b=56Ks8GzzsvqyV+8BPhRyEoeK3fSw8Tk4u9dmaWKRvR+TDdx6QS95qtrU4H2S3s0Hdu
         x01Pd6Lkq9XvVQlsCzl25SbE5RkZw1+IlJqSjDH7eNz3CWyUetrL39/7KG5KFPznRDXG
         DbYiCB4xzWpsEVMmokdc5wn6g1JEtDDpE/ikgGdDIGbF+/uGPUBbvVTgfBcgTRK7SogG
         EImvBKuPIZZV2zWgqAg/WnuzT6hFvmJbLrBVer5e8R2sCoiHJQ8jQMmvYwLC+JZTHKG9
         Hf5pjNlDjspIMapCUrkNX9tqK1FQ61KjjBtTK6DhlxWv97x9ifQdq17F1r5EAEco3Kuf
         bZAg==
X-Gm-Message-State: AOAM532j52/fXlu+fW3Q01K22CgFzcGA1xH6MbIQCYFg/zXLNVyrGAPI
        Lxbgo6TM4DB5EphyrtywgaIUCmymCRC1xA==
X-Google-Smtp-Source: ABdhPJwualFYNIzNHsRgxJ2wvmizyMALHAdS+elxgz+ue8yxQxhfOr/IkR/E/Pp4eHEPJyulROZtCFKoNEWclQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:39fa:d88:fb3b:880e])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:3ac:: with SMTP id
 m12mr6202027qvy.9.1633040454046; Thu, 30 Sep 2021 15:20:54 -0700 (PDT)
Date:   Thu, 30 Sep 2021 15:20:45 -0700
In-Reply-To: <20210930222048.1692635-1-dlatypov@google.com>
Message-Id: <20210930222048.1692635-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20210930222048.1692635-1-dlatypov@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 1/4] kunit: add 'kunit.action' param to allow listing out tests
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

Hack: we print a TAP header (but no test plan) to allow kunit.py to
use the same code to pick up KUnit output that it does for normal tests.
Since this is intended to be an implementation detail, it seems fine for
now. Maybe in the future we output each test as SKIPPED or the like.

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
Reviewed-by: David Gow <davidgow@google.com>
---
 lib/kunit/executor.c | 45 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index bab3ab940acc..ce1f57a44ab9 100644
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
+	pr_info("TAP version 14\n");
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
2.33.0.800.g4c38ced690-goog

