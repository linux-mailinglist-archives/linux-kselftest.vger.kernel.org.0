Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DF2310060
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 23:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhBDWzi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Feb 2021 17:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhBDWzh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Feb 2021 17:55:37 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C943C06178A
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Feb 2021 14:54:57 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id j13so3446320qvy.19
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Feb 2021 14:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8M/syFwNKdzYEjkQkOYzNkXR9VPw1LAYsj1sJNWjiBk=;
        b=lV4qokZpvz9TBE6gXOr2d5HkvXq7zGHt4OIXu6Ce4kM0s8A9g8yBbQ8ElirRcUxRgl
         dP6GWRVMbDFNGbMM0irGa8mJvWqwhbgj30dkDJIGUYZp3c4ci+bDwzpePFC1rmanj4I0
         S3Nv0VOlruxlNlPXN/n6nEmneE6nna28QDkqYv5QYb/zdd/8crkW4r7rvEdR6sAFzPbY
         ZbEBKffeGdCwf29Q5zz9+we+4cvjNR3NOCl+gv6Ht5twvWTH0KykM04HLrstHOPAxN+I
         FAgeoJ8cZuyIBFx2QQEAPHx+du9ycRiq4j6Fw2spRW/1aNpWaH3z4OT7OvshwzRXWiHX
         kyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8M/syFwNKdzYEjkQkOYzNkXR9VPw1LAYsj1sJNWjiBk=;
        b=tO57Sy88X/QGP7HC/VG9WXKmkQFoHrcIEfCsJ+J2tuAJ9FSzbndyzlxW7ythVJql86
         EBuoAd+iJBLzFT6LeKrLzNSA0dPhhcA/N9qJEWkgkjQOYIqrqn8myeAMpAYZHIysvyRo
         nUzZ/yAy36DUR6SPz80rijPj3TKSsGhD6gzT7VmUawfqHIzNZd8tXL5ZPeZovZiqgQbn
         2wsvPF3MY9iP1RuHOsimOBDQ0J4QlLvziyZd63AiN1jYPjZzRdOSoml+6Q5xeAHpj+cg
         ha32GaJGRh3VS7QMTQK24o7dkboeDcZfA4qJuW9fzZGfpKqkRutbFP9Tphttso69g5pp
         EQHQ==
X-Gm-Message-State: AOAM531aMgRouQggv+ZJsnm1KQ49V2GxqspNSdL4BWRIJU4JKGgz6OiG
        tD4DZk/SIhUr0GjJGOePG9aT5rCiOjQ4IA==
X-Google-Smtp-Source: ABdhPJxB7zDMtGOhWk5MI+yovqPNBcal/Jo12FfODeGP8MLAllpAWvaVYTLbiu6xLUUrISe+jO4Vg9Oui3yB0Q==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bd7a:7717:5b5b:de27])
 (user=dlatypov job=sendgmr) by 2002:a0c:b9a2:: with SMTP id
 v34mr1791579qvf.17.1612479296534; Thu, 04 Feb 2021 14:54:56 -0800 (PST)
Date:   Thu,  4 Feb 2021 14:54:46 -0800
In-Reply-To: <20210204225448.1393741-1-dlatypov@google.com>
Message-Id: <20210204225448.1393741-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20210204225448.1393741-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v3 1/3] kunit: add kunit.filter_glob cmdline option to filter suites
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

E.g. specifying this would run suites with "list" in their name.
  kunit.filter_glob=list*

Note: the executor prints out a TAP header that includes the number of
suites we intend to run.
So unless we want to report empty results for filtered-out suites, we
need to do the filtering here in the executor.
It's also probably better in the executor since we most likely don't
want any filtering to apply to tests built as modules.

This code does add a CONFIG_GLOB=y dependency for CONFIG_KUNIT=y.
But the code seems light enough that it shouldn't be an issue.

For now, we only filter on suite names so we don't have to create copies
of the suites themselves, just the array (of arrays) holding them.

The name is rather generic since in the future, we could consider
extending it to a syntax like:
  kunit.filter_glob=<suite_glob>.<test_glob>
E.g. to run all the del list tests
  kunit.filter_glob=list-kunit-test.*del*

But at the moment, it's far easier to manually comment out test cases in
test files as opposed to messing with sets of Kconfig entries to select
specific suites.
So even just doing this makes using kunit far less annoying.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 lib/kunit/Kconfig    |  1 +
 lib/kunit/executor.c | 93 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 85 insertions(+), 9 deletions(-)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 00909e6a2443..0b5dfb001bac 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -4,6 +4,7 @@
 
 menuconfig KUNIT
 	tristate "KUnit - Enable support for unit tests"
+	select GLOB if KUNIT=y
 	help
 	  Enables support for kernel unit tests (KUnit), a lightweight unit
 	  testing and mocking framework for the Linux kernel. These tests are
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index a95742a4ece7..15832ed44668 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <kunit/test.h>
+#include <linux/glob.h>
+#include <linux/moduleparam.h>
 
 /*
  * These symbols point to the .kunit_test_suites section and are defined in
@@ -11,14 +13,81 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
-static void kunit_print_tap_header(void)
+static char *filter_glob;
+module_param(filter_glob, charp, 0);
+MODULE_PARM_DESC(filter_glob,
+		"Filter which KUnit test suites run at boot-time, e.g. list*");
+
+static struct kunit_suite * const *
+kunit_filter_subsuite(struct kunit_suite * const * const subsuite)
+{
+	int i, n = 0;
+	struct kunit_suite **filtered;
+
+	n = 0;
+	for (i = 0; subsuite[i] != NULL; ++i) {
+		if (glob_match(filter_glob, subsuite[i]->name))
+			++n;
+	}
+
+	if (n == 0)
+		return NULL;
+
+	filtered = kmalloc_array(n + 1, sizeof(*filtered), GFP_KERNEL);
+	if (!filtered)
+		return NULL;
+
+	n = 0;
+	for (i = 0; subsuite[i] != NULL; ++i) {
+		if (glob_match(filter_glob, subsuite[i]->name))
+			filtered[n++] = subsuite[i];
+	}
+	filtered[n] = NULL;
+
+	return filtered;
+}
+
+struct suite_set {
+	struct kunit_suite * const * const *start;
+	struct kunit_suite * const * const *end;
+};
+
+static struct suite_set kunit_filter_suites(void)
+{
+	int i;
+	struct kunit_suite * const **copy, * const *filtered_subsuite;
+	struct suite_set filtered;
+
+	const size_t max = __kunit_suites_end - __kunit_suites_start;
+
+	if (!filter_glob) {
+		filtered.start = __kunit_suites_start;
+		filtered.end = __kunit_suites_end;
+		return filtered;
+	}
+
+	copy = kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
+	filtered.start = copy;
+	if (!copy) { /* won't be able to run anything, return an empty set */
+		filtered.end = copy;
+		return filtered;
+	}
+
+	for (i = 0; i < max; ++i) {
+		filtered_subsuite = kunit_filter_subsuite(__kunit_suites_start[i]);
+		if (filtered_subsuite)
+			*copy++ = filtered_subsuite;
+	}
+	filtered.end = copy;
+	return filtered;
+}
+
+static void kunit_print_tap_header(struct suite_set *suite_set)
 {
 	struct kunit_suite * const * const *suites, * const *subsuite;
 	int num_of_suites = 0;
 
-	for (suites = __kunit_suites_start;
-	     suites < __kunit_suites_end;
-	     suites++)
+	for (suites = suite_set->start; suites < suite_set->end; suites++)
 		for (subsuite = *suites; *subsuite != NULL; subsuite++)
 			num_of_suites++;
 
@@ -30,12 +99,18 @@ int kunit_run_all_tests(void)
 {
 	struct kunit_suite * const * const *suites;
 
-	kunit_print_tap_header();
+	struct suite_set suite_set = kunit_filter_suites();
+
+	kunit_print_tap_header(&suite_set);
+
+	for (suites = suite_set.start; suites < suite_set.end; suites++)
+		__kunit_test_suites_init(*suites);
 
-	for (suites = __kunit_suites_start;
-	     suites < __kunit_suites_end;
-	     suites++)
-			__kunit_test_suites_init(*suites);
+	if (filter_glob) { /* a copy was made of each array */
+		for (suites = suite_set.start; suites < suite_set.end; suites++)
+			kfree(*suites);
+		kfree(suite_set.start);
+	}
 
 	return 0;
 }
-- 
2.30.0.478.g8a0d178c01-goog

