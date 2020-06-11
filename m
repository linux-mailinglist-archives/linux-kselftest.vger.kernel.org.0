Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE381F7074
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 00:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgFKWlA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 18:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgFKWkh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 18:40:37 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A81C08C5C4
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 15:40:37 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ne5so2794233pjb.5
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sfoQ5BiylldStTNTrzMKbn3GtKtQVliYiR41t+/UpcM=;
        b=TmmrQxgX8kFAbH+aMFAgqEqWGYw/YGVRv9pj9hl9RxP+XQxIieQvyKZvHGisKjgQAn
         POnb8mipa2ySsXjt23dFtLiONcsFM/j7Ytq1Zn/Bj/baSZ/VG0XANaUSq0Qei/B6i0fy
         uJ7lYolInPj6qlVW5ihCoUzJowFpTDfgt09Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sfoQ5BiylldStTNTrzMKbn3GtKtQVliYiR41t+/UpcM=;
        b=WH5TlJhP3hT5oEkBXBMBY8KU09OqIBykTgiydntb6CMoq4Dbi/Z3l/yeny6hb+cZ7k
         YvF1ts+aBN0P4CLrVcSBhhwVB2FCHwterbJZVM2G3SfHCfVaD8yhRk8vLIaBrNnLmSqT
         LAMhi9iqSjLM0VAGrdp6d9Ta6wY77o6xte3Wryw1ZcMhgPucO5FHldpeVi5ng8I2L9Vz
         IToelYeurld57vbbXaQfoXRbYLBUkV4jWrOAmPczAkjmL6BVLPQg3S+DUjzzdQ0Ol4TB
         PZZraeqENl6vl+tMTvspAPZsarQodFOwdZj5S3NxDF7xNehLxhoD/fgQpuVVRbmL5Obh
         Fdkg==
X-Gm-Message-State: AOAM531bhQEmXG7Yo/IR4RL49fzEm8udp3rcZG4ztfS57CQA+vNfEWVj
        dgnMTyp0rJ/HkHLln23HrQXjXg==
X-Google-Smtp-Source: ABdhPJwsiJaPUeZ8CvZ+b/nMNKnYZomswgwPkcrS6uH6xADxMxgRQQfp/CNw0We0LiOO4yDb1i5x0Q==
X-Received: by 2002:a17:90b:3004:: with SMTP id hg4mr10980729pjb.208.1591915236708;
        Thu, 11 Jun 2020 15:40:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a16sm3558300pgk.88.2020.06.11.15.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 15:40:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] selftests/harness: Switch to TAP output
Date:   Thu, 11 Jun 2020 15:40:26 -0700
Message-Id: <20200611224028.3275174-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611224028.3275174-1-keescook@chromium.org>
References: <20200611224028.3275174-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Using the kselftest_harness.h would result in non-TAP test reporting,
which didn't make much sense given that all the requirements for using
the low-level API were met. Switch to using ksft_*() helpers while
retaining as much of a human-readability as possible.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest.h         |  5 +-
 tools/testing/selftests/kselftest_harness.h | 52 ++++++++++++---------
 2 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 5716cbb9eecc..3f0d236ca2e4 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -1,7 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * kselftest.h:	kselftest framework return codes to include from
- *		selftests.
+ * kselftest.h:	low-level kselftest framework to include from
+ *		selftest programs. When possible, please use
+ *		kselftest_harness.h instead.
  *
  * Copyright (c) 2014 Shuah Khan <shuahkh@osg.samsung.com>
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index c9f03ef93338..f8f7e47c739a 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -50,7 +50,9 @@
 #ifndef __KSELFTEST_HARNESS_H
 #define __KSELFTEST_HARNESS_H
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <asm/types.h>
 #include <errno.h>
 #include <stdbool.h>
@@ -62,6 +64,8 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
+#include "kselftest.h"
+
 #define TEST_TIMEOUT_DEFAULT 30
 
 /* Utilities exposed to the test definitions */
@@ -104,7 +108,7 @@
 
 /* Unconditional logger for internal use. */
 #define __TH_LOG(fmt, ...) \
-		fprintf(TH_LOG_STREAM, "%s:%d:%s:" fmt "\n", \
+		fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
 			__FILE__, __LINE__, _metadata->name, ##__VA_ARGS__)
 
 /**
@@ -119,7 +123,7 @@
  */
 #define XFAIL(statement, fmt, ...) do { \
 	if (TH_LOG_ENABLED) { \
-		fprintf(TH_LOG_STREAM, "[  XFAIL!  ] " fmt "\n", \
+		fprintf(TH_LOG_STREAM, "#      XFAIL     " fmt "\n", \
 			##__VA_ARGS__); \
 	} \
 	/* TODO: find a way to pass xfail to test runner process. */ \
@@ -813,12 +817,12 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 	/* Sanity check handler execution environment. */
 	if (!t) {
 		fprintf(TH_LOG_STREAM,
-			"no active test in SIGALRM handler!?\n");
+			"# no active test in SIGALRM handler!?\n");
 		abort();
 	}
 	if (sig != SIGALRM || sig != info->si_signo) {
 		fprintf(TH_LOG_STREAM,
-			"%s: SIGALRM handler caught signal %d!?\n",
+			"# %s: SIGALRM handler caught signal %d!?\n",
 			t->name, sig != SIGALRM ? sig : info->si_signo);
 		abort();
 	}
@@ -839,7 +843,7 @@ void __wait_for_test(struct __test_metadata *t)
 	if (sigaction(SIGALRM, &action, &saved_action)) {
 		t->passed = 0;
 		fprintf(TH_LOG_STREAM,
-			"%s: unable to install SIGALRM handler\n",
+			"# %s: unable to install SIGALRM handler\n",
 			t->name);
 		return;
 	}
@@ -851,7 +855,7 @@ void __wait_for_test(struct __test_metadata *t)
 	if (sigaction(SIGALRM, &saved_action, NULL)) {
 		t->passed = 0;
 		fprintf(TH_LOG_STREAM,
-			"%s: unable to uninstall SIGALRM handler\n",
+			"# %s: unable to uninstall SIGALRM handler\n",
 			t->name);
 		return;
 	}
@@ -860,18 +864,17 @@ void __wait_for_test(struct __test_metadata *t)
 	if (t->timed_out) {
 		t->passed = 0;
 		fprintf(TH_LOG_STREAM,
-			"%s: Test terminated by timeout\n", t->name);
+			"# %s: Test terminated by timeout\n", t->name);
 	} else if (WIFEXITED(status)) {
 		t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
 		if (t->termsig != -1) {
 			fprintf(TH_LOG_STREAM,
-				"%s: Test exited normally "
-				"instead of by signal (code: %d)\n",
+				"# %s: Test exited normally instead of by signal (code: %d)\n",
 				t->name,
 				WEXITSTATUS(status));
 		} else if (!t->passed) {
 			fprintf(TH_LOG_STREAM,
-				"%s: Test failed at step #%d\n",
+				"# %s: Test failed at step #%d\n",
 				t->name,
 				WEXITSTATUS(status));
 		}
@@ -879,20 +882,19 @@ void __wait_for_test(struct __test_metadata *t)
 		t->passed = 0;
 		if (WTERMSIG(status) == SIGABRT) {
 			fprintf(TH_LOG_STREAM,
-				"%s: Test terminated by assertion\n",
+				"# %s: Test terminated by assertion\n",
 				t->name);
 		} else if (WTERMSIG(status) == t->termsig) {
 			t->passed = 1;
 		} else {
 			fprintf(TH_LOG_STREAM,
-				"%s: Test terminated unexpectedly "
-				"by signal %d\n",
+				"# %s: Test terminated unexpectedly by signal %d\n",
 				t->name,
 				WTERMSIG(status));
 		}
 	} else {
 		fprintf(TH_LOG_STREAM,
-			"%s: Test ended in some other way [%u]\n",
+			"# %s: Test ended in some other way [%u]\n",
 			t->name,
 			status);
 	}
@@ -908,11 +910,11 @@ void __run_test(struct __fixture_metadata *f,
 	t->step = 0;
 	t->no_print = 0;
 
-	printf("[ RUN      ] %s%s%s.%s\n",
+	ksft_print_msg(" RUN           %s%s%s.%s ...\n",
 	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
 	t->pid = fork();
 	if (t->pid < 0) {
-		printf("ERROR SPAWNING TEST CHILD\n");
+		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");
 		t->passed = 0;
 	} else if (t->pid == 0) {
 		t->fn(t, variant);
@@ -921,7 +923,9 @@ void __run_test(struct __fixture_metadata *f,
 	} else {
 		__wait_for_test(t);
 	}
-	printf("[     %4s ] %s%s%s.%s\n", (t->passed ? "OK" : "FAIL"),
+	ksft_print_msg("         %4s  %s%s%s.%s\n", t->passed ? "OK" : "FAIL",
+	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
+	ksft_test_result(t->passed, "%s%s%s.%s\n",
 	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
 }
 
@@ -945,8 +949,9 @@ static int test_harness_run(int __attribute__((unused)) argc,
 		}
 	}
 
-	/* TODO(wad) add optional arguments similar to gtest. */
-	printf("[==========] Running %u tests from %u test cases.\n",
+	ksft_print_header();
+	ksft_set_plan(test_count);
+	ksft_print_msg("Starting %u tests from %u test cases.\n",
 	       test_count, case_count);
 	for (f = __fixture_list; f; f = f->next) {
 		for (v = f->variant ?: &no_variant; v; v = v->next) {
@@ -960,9 +965,12 @@ static int test_harness_run(int __attribute__((unused)) argc,
 			}
 		}
 	}
-	printf("[==========] %u / %u tests passed.\n", pass_count, count);
-	printf("[  %s  ]\n", (ret ? "FAILED" : "PASSED"));
-	return ret;
+	ksft_print_msg("%s: %u / %u tests passed.\n", ret ? "FAILED" : "PASSED",
+			pass_count, count);
+	ksft_exit(ret == 0);
+
+	/* unreachable */
+	return KSFT_FAIL;
 }
 
 static void __attribute__((constructor)) __constructor_order_first(void)
-- 
2.25.1

