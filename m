Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA2203EF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 20:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgFVSRF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 14:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730348AbgFVSRC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 14:17:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A5FC061573
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 11:17:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j1so8771619pfe.4
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x3nUJp5mj9ISdHDTPKK6ZLb2jWaFUux9X4xb06xMOF4=;
        b=TeOQ14ynGoaXKS6y0nfg5Vud4307oGqqzQqJW/4d4q7+9Mv/GCHhMFZVbmFwyn5CjD
         jM/m6SN5T8tuG+92yPl71fA0xOt4Yq6m5bqUzI+5pSQQoHePdiKLEr1NtVlUx/+TDIyo
         OlMN++8k4xfoTAIZNfkbx2T18x3r6WCg4ywyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3nUJp5mj9ISdHDTPKK6ZLb2jWaFUux9X4xb06xMOF4=;
        b=gKCuW2xzzwF8qCoZiVg7PGBOLgh/eFUfx9PdMcW3oVqeIr7XTeYgdgtOp3doisp5ED
         FwRpCp1/JohLmhxON0pMhcDRMNuUb41ZNk5L77CRiDtJZTwdu/4fG3YA/PlmKGCFTHE8
         3YemJQN2v113Sq/oHAWKuI+NwDY2EeunazzORAEFLg8ga4oYLRGJ7TgYZ8JMhJg5ah5J
         l8MIcxjRl+QQ+AVq5apJAAYZekwNdQbfFiVBXO9cuSHdTYq6dGtHKaooZz8OLsRgE7Mw
         l3sPWfG5S82/muE1/9Cxr2nSiEaDkySH/YpaFY/GdY3c9NwlXlDioqVuyItpDAQ/H0/P
         eioQ==
X-Gm-Message-State: AOAM531tqYuM5y5J8qxN1mkB0EK2cXkKvTEmxKjXQiJOISIkQeBJudEu
        yClyQlwEP3zf80P4wLF8T8uL1Q==
X-Google-Smtp-Source: ABdhPJy+Wdreo0cL0rS8c6+f2Ef0QkO/1E2AmDTPNVLx0blG5j9Z66OZ6Kl+sozhtO1qkn5XyLKieQ==
X-Received: by 2002:aa7:8bd0:: with SMTP id s16mr22490552pfd.80.1592849821698;
        Mon, 22 Jun 2020 11:17:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 22sm12113426pgs.49.2020.06.22.11.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 11:16:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] selftests/harness: Report skip reason
Date:   Mon, 22 Jun 2020 11:16:51 -0700
Message-Id: <20200622181651.2795217-9-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622181651.2795217-1-keescook@chromium.org>
References: <20200622181651.2795217-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use a share memory segment to pass string information between forked
test and the test runner for the skip reason.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h | 25 +++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index ae51b762d120..438c19740838 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -60,6 +60,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
@@ -122,9 +123,11 @@
  * and runs "statement", which is usually "return" or "goto skip".
  */
 #define SKIP(statement, fmt, ...) do { \
+	snprintf(_metadata->results->reason, \
+		 sizeof(_metadata->results->reason), fmt, ##__VA_ARGS__); \
 	if (TH_LOG_ENABLED) { \
-		fprintf(TH_LOG_STREAM, "#      SKIP     " fmt "\n", \
-			##__VA_ARGS__); \
+		fprintf(TH_LOG_STREAM, "#      SKIP     %s\n", \
+			_metadata->results->reason); \
 	} \
 	_metadata->passed = 1; \
 	_metadata->skip = 1; \
@@ -762,6 +765,10 @@
 	} \
 }
 
+struct __test_results {
+	char reason[1024];	/* Reason for test result */
+};
+
 struct __test_metadata;
 struct __fixture_variant_metadata;
 
@@ -815,6 +822,7 @@ struct __test_metadata {
 	bool timed_out;	/* did this test timeout instead of exiting? */
 	__u8 step;
 	bool no_print; /* manual trigger when TH_LOG_STREAM is not available */
+	struct __test_results *results;
 	struct __test_metadata *prev, *next;
 };
 
@@ -957,6 +965,7 @@ void __run_test(struct __fixture_metadata *f,
 	t->trigger = 0;
 	t->step = 0;
 	t->no_print = 0;
+	memset(t->results->reason, 0, sizeof(t->results->reason));
 
 	ksft_print_msg(" RUN           %s%s%s.%s ...\n",
 	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
@@ -986,8 +995,8 @@ void __run_test(struct __fixture_metadata *f,
 	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
 
 	if (t->skip)
-		ksft_test_result_skip("%s%s%s.%s\n",
-			f->name, variant->name[0] ? "." : "", variant->name, t->name);
+		ksft_test_result_skip("%s\n", t->results->reason[0] ?
+					t->results->reason : "unknown");
 	else
 		ksft_test_result(t->passed, "%s%s%s.%s\n",
 			f->name, variant->name[0] ? "." : "", variant->name, t->name);
@@ -999,6 +1008,7 @@ static int test_harness_run(int __attribute__((unused)) argc,
 	struct __fixture_variant_metadata no_variant = { .name = "", };
 	struct __fixture_variant_metadata *v;
 	struct __fixture_metadata *f;
+	struct __test_results *results;
 	struct __test_metadata *t;
 	int ret = 0;
 	unsigned int case_count = 0, test_count = 0;
@@ -1013,6 +1023,9 @@ static int test_harness_run(int __attribute__((unused)) argc,
 		}
 	}
 
+	results = mmap(NULL, sizeof(*results), PROT_READ | PROT_WRITE,
+		       MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
 	ksft_print_header();
 	ksft_set_plan(test_count);
 	ksft_print_msg("Starting %u tests from %u test cases.\n",
@@ -1021,7 +1034,9 @@ static int test_harness_run(int __attribute__((unused)) argc,
 		for (v = f->variant ?: &no_variant; v; v = v->next) {
 			for (t = f->tests; t; t = t->next) {
 				count++;
+				t->results = results;
 				__run_test(f, v, t);
+				t->results = NULL;
 				if (t->passed)
 					pass_count++;
 				else
@@ -1029,6 +1044,8 @@ static int test_harness_run(int __attribute__((unused)) argc,
 			}
 		}
 	}
+	munmap(results, sizeof(*results));
+
 	ksft_print_msg("%s: %u / %u tests passed.\n", ret ? "FAILED" : "PASSED",
 			pass_count, count);
 	ksft_exit(ret == 0);
-- 
2.25.1

