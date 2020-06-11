Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC391F7076
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 00:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgFKWlC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 18:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgFKWkg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 18:40:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705AEC03E96F
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 15:40:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so3328651pfn.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 15:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jcdp0A52gYZCph0gGADuhIc0HKnI1/wmXKSbfXbaq1E=;
        b=XdFFw63UJpNGqBL7fTO6FKlXTUH3FHRz8l92YtC2as+K9G2dTnD39Y21MNKNTlI9pv
         G3e1BfmFvQjrYE3AGlGtBFHSpVbfIJqDnWpYmPdlbMPEvi/2g5PIz2+Hdk9q0Ysr+zXp
         bv1RlEDqeVdLd/aS+0p97SsGOk4eNo11ITLXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jcdp0A52gYZCph0gGADuhIc0HKnI1/wmXKSbfXbaq1E=;
        b=lPlOhK+9s8V34mj+LkwGytHIwEWqIqvswkBGAQeY0KaORZ1xfo9I3YlZqQmJTpGKsG
         TFXM1psOURh23hAgOIqAwsTRk0cPu1OR9rcowmlAswg2nxWltBqUDSGZmhl1CkEyL9Dd
         pH7aRF6KPQ+QxYTvLXgqfTDNQGJ8fENmqKdzZZgVMl83BsvgGpuAkmD+jX2GXuBq4fzb
         1YeaH+l4S55xGJPDoXtyVgAYLln3a3uC8+62k8yEP3T3v8jfWaLFQKnSvGX8U0hSqGai
         8+9ezs14Q3VOSqUW8F+OHN0lojx+/ifx1TYpROdQi9F4z2gRy3dMHh3YMvJnGoipPxn5
         KYvw==
X-Gm-Message-State: AOAM532DNwiuIPzyVkRM2dk+z1Ib2HLCCXnMoRo3jKm5rYcLmYei35xr
        noaaIxuJcuyEklR1nCWCxoXyHw==
X-Google-Smtp-Source: ABdhPJylH72DBV8tqKKaeCUxFpQ8TAs3vubI8hM3JGruoMZCjKkdrnMmuO+fvk1mDYtvZ0bi2qIgJA==
X-Received: by 2002:a63:503:: with SMTP id 3mr8616778pgf.15.1591915236006;
        Thu, 11 Jun 2020 15:40:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p12sm4216167pfq.69.2020.06.11.15.40.32
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
Subject: [PATCH 6/7] selftests/harness: Fully track XFAIL reports
Date:   Thu, 11 Jun 2020 15:40:27 -0700
Message-Id: <20200611224028.3275174-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611224028.3275174-1-keescook@chromium.org>
References: <20200611224028.3275174-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Plumb XFAIL conditions up into TAP reporting and test counts.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest.h         | 17 ++++++-
 tools/testing/selftests/kselftest_harness.h | 54 ++++++++++++++++-----
 2 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 3f0d236ca2e4..9b4efdbb07f6 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -17,12 +17,13 @@
  *
  *     ksft_print_msg(fmt, ...);
  *
- * and finally report the pass/fail/skip state of the test with one of:
+ * and finally report the pass/fail/skip/xfail state of the test with one of:
  *
  *     ksft_test_result(condition, fmt, ...);
  *     ksft_test_result_pass(fmt, ...);
  *     ksft_test_result_fail(fmt, ...);
  *     ksft_test_result_skip(fmt, ...);
+ *     ksft_test_result_xfail(fmt, ...);
  *     ksft_test_result_error(fmt, ...);
  *
  * When all tests are finished, clean up and exit the program with one of:
@@ -163,7 +164,19 @@ static inline void ksft_test_result_fail(const char *msg, ...)
 		ksft_test_result_fail(fmt, ##__VA_ARGS__);\
 	} while (0)
 
-/* TODO: add ksft_test_result_xfail() */
+static inline void ksft_test_result_xfail(const char *msg, ...)
+{
+	int saved_errno = errno;
+	va_list args;
+
+	ksft_cnt.ksft_xfail++;
+
+	va_start(args, msg);
+	printf("ok %d # XFAIL ", ksft_test_num());
+	errno = saved_errno;
+	vprintf(msg, args);
+	va_end(args);
+}
 
 static inline void ksft_test_result_skip(const char *msg, ...)
 {
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index f8f7e47c739a..6b06930468e5 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -126,8 +126,8 @@
 		fprintf(TH_LOG_STREAM, "#      XFAIL     " fmt "\n", \
 			##__VA_ARGS__); \
 	} \
-	/* TODO: find a way to pass xfail to test runner process. */ \
 	_metadata->passed = 1; \
+	_metadata->xfail = 1; \
 	_metadata->trigger = 0; \
 	statement; \
 } while (0)
@@ -777,6 +777,7 @@ struct __test_metadata {
 	struct __fixture_metadata *fixture;
 	int termsig;
 	int passed;
+	int xfail;	/* did XFAIL get used? */
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
 	bool timed_out;	/* did this test timeout instead of exiting? */
@@ -866,17 +867,31 @@ void __wait_for_test(struct __test_metadata *t)
 		fprintf(TH_LOG_STREAM,
 			"# %s: Test terminated by timeout\n", t->name);
 	} else if (WIFEXITED(status)) {
-		t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
 		if (t->termsig != -1) {
+			t->passed = 0;
 			fprintf(TH_LOG_STREAM,
 				"# %s: Test exited normally instead of by signal (code: %d)\n",
 				t->name,
 				WEXITSTATUS(status));
-		} else if (!t->passed) {
-			fprintf(TH_LOG_STREAM,
-				"# %s: Test failed at step #%d\n",
-				t->name,
-				WEXITSTATUS(status));
+		} else {
+			switch (WEXITSTATUS(status)) {
+			/* Success */
+			case 0:
+				t->passed = 1;
+				break;
+			/* XFAIL */
+			case 255:
+				t->passed = 1;
+				t->xfail = 1;
+				break;
+			/* Other failure, assume step report. */
+			default:
+				t->passed = 0;
+				fprintf(TH_LOG_STREAM,
+					"# %s: Test failed at step #%d\n",
+					t->name,
+					WEXITSTATUS(status));
+			}
 		}
 	} else if (WIFSIGNALED(status)) {
 		t->passed = 0;
@@ -906,6 +921,7 @@ void __run_test(struct __fixture_metadata *f,
 {
 	/* reset test struct */
 	t->passed = 1;
+	t->xfail = 0;
 	t->trigger = 0;
 	t->step = 0;
 	t->no_print = 0;
@@ -918,15 +934,31 @@ void __run_test(struct __fixture_metadata *f,
 		t->passed = 0;
 	} else if (t->pid == 0) {
 		t->fn(t, variant);
-		/* return the step that failed or 0 */
-		_exit(t->passed ? 0 : t->step);
+		/* Make sure step doesn't get lost in reporting */
+		if (t->step >= 255) {
+			ksft_print_msg("Too many test steps (%u)!?\n", t->step);
+			t->step = 254;
+		}
+		/* Use 255 for XFAIL */
+		if (t->xfail)
+			_exit(255);
+		/* Pass is exit 0 */
+		if (t->passed)
+			_exit(0);
+		/* Something else happened, report the step. */
+		_exit(t->step);
 	} else {
 		__wait_for_test(t);
 	}
 	ksft_print_msg("         %4s  %s%s%s.%s\n", t->passed ? "OK" : "FAIL",
 	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
-	ksft_test_result(t->passed, "%s%s%s.%s\n",
-	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
+
+	if (t->xfail)
+		ksft_test_result_xfail("%s%s%s.%s\n",
+			f->name, variant->name[0] ? "." : "", variant->name, t->name);
+	else
+		ksft_test_result(t->passed, "%s%s%s.%s\n",
+			f->name, variant->name[0] ? "." : "", variant->name, t->name);
 }
 
 static int test_harness_run(int __attribute__((unused)) argc,
-- 
2.25.1

