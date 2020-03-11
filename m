Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7CEB1823B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 22:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgCKVRk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 17:17:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36441 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgCKVRk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 17:17:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id i13so2052810pfe.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Mar 2020 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVB9ateUNPWjDSRVGMb+4rgbxEOqdavmk19dJVvZMIM=;
        b=YgTgbM406HdGsLsPlF+VVmtshblGPo2TvOf06wGTAhyHuMsZ2O+UXyNXLGkoFJjBZE
         cVnCgfZ5EH7rzeAdjXhc7QfXKSUzwW1Wq8FpJAB6ZT/GQkIbvJBMuNA33fRKml839N7I
         kj8xerEdEETVWepH0A+NUni0QHeCHJX7bbJ30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVB9ateUNPWjDSRVGMb+4rgbxEOqdavmk19dJVvZMIM=;
        b=QY8ORZWU398r2di9K9w9pV9K6AOZRL0myD5tRhn7HyTebBQOayXtLnD344/h/h355e
         41LfzbiO1lMit9mghTQhHcdiP10VORFuGtojYWJioQMcExqnxfBjdfi12PEyUwT+R/3Q
         SWuly2bUBQePQ/wgVjWLE5HuFlSymICeHam/9fccKltRBJmaFC/Ol44X1yiHbLmBmZVE
         zNH+CSAJRZIZyjMHK3KtL2gi43mxnQT33IrLPvJB98fbtZQOYv+oaWFRmy6xe3SwGHcd
         07nIY11zIf4zv9DNFXjm9aThze4YNXxg85M7r6tfj/DX6x4FGQIQ8noS+5HbB9EaFYMH
         G82A==
X-Gm-Message-State: ANhLgQ01mzB07p/Frlm7V8XekADANJX02vZV/TiZXWP1ZznrCJCjuHd0
        a82cEX9ZeMpKB/XvSaUKQwxn3A==
X-Google-Smtp-Source: ADFU+vtTCjEhI3JPw2xL9W4cakF1N6Pmv6rkqFP+mzP01zBwJjNzf9RYvvo4VRKg6V5rIt4yJLfXMA==
X-Received: by 2002:aa7:87c1:: with SMTP id i1mr1082817pfo.297.1583961458705;
        Wed, 11 Mar 2020 14:17:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y200sm19036662pfb.138.2020.03.11.14.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 14:17:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/harness: Handle timeouts cleanly
Date:   Wed, 11 Mar 2020 14:17:33 -0700
Message-Id: <20200311211733.21211-3-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311211733.21211-1-keescook@chromium.org>
References: <20200311211733.21211-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When a selftest would timeout before, the program would just fall over
and no accounting of failures would be reported (i.e. it would result in
an incomplete TAP report). Instead, add an explicit SIGALRM handler to
cleanly catch and report the timeout.

Before:

	[==========] Running 2 tests from 2 test cases.
	[ RUN      ] timeout.finish
	[       OK ] timeout.finish
	[ RUN      ] timeout.too_long
	Alarm clock

After:

	[==========] Running 2 tests from 2 test cases.
	[ RUN      ] timeout.finish
	[       OK ] timeout.finish
	[ RUN      ] timeout.too_long
	timeout.too_long: Test terminated by timeout
	[     FAIL ] timeout.too_long
	[==========] 1 / 2 tests passed.
	[  FAILED  ]

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h | 53 ++++++++++++++++++++-
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index c7b67e379219..2902f6a78f8a 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -639,7 +639,8 @@ struct __test_metadata {
 	int termsig;
 	int passed;
 	int trigger; /* extra handler after the evaluation */
-	int timeout;
+	int timeout;	/* seconds to wait for test timeout */
+	bool timed_out;	/* did this test timeout instead of exiting? */
 	__u8 step;
 	bool no_print; /* manual trigger when TH_LOG_STREAM is not available */
 	struct __test_metadata *prev, *next;
@@ -696,15 +697,63 @@ static inline int __bail(int for_realz, bool no_print, __u8 step)
 	return 0;
 }
 
+struct __test_metadata *__active_test;
+static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
+{
+	struct __test_metadata *t = __active_test;
+
+	/* Sanity check handler execution environment. */
+	if (!t) {
+		fprintf(TH_LOG_STREAM,
+			"no active test in SIGARLM handler!?\n");
+		abort();
+	}
+	if (sig != SIGALRM || sig != info->si_signo) {
+		fprintf(TH_LOG_STREAM,
+			"%s: SIGALRM handler caught signal %d!?\n",
+			t->name, sig != SIGALRM ? sig : info->si_signo);
+		abort();
+	}
+
+	t->timed_out = true;
+	kill(t->pid, SIGKILL);
+}
+
 void __wait_for_test(struct __test_metadata *t)
 {
+	struct sigaction action = {
+		.sa_sigaction = __timeout_handler,
+		.sa_flags = SA_SIGINFO,
+	};
+	struct sigaction saved_action;
 	int status;
 
+	if (sigaction(SIGALRM, &action, &saved_action)) {
+		t->passed = 0;
+		fprintf(TH_LOG_STREAM,
+			"%s: unable to install SIGARLM handler\n",
+			t->name);
+		return;
+	}
+	__active_test = t;
+	t->timed_out = false;
 	alarm(t->timeout);
 	waitpid(t->pid, &status, 0);
 	alarm(0);
+	if (sigaction(SIGALRM, &saved_action, NULL)) {
+		t->passed = 0;
+		fprintf(TH_LOG_STREAM,
+			"%s: unable to uninstall SIGARLM handler\n",
+			t->name);
+		return;
+	}
+	__active_test = NULL;
 
-	if (WIFEXITED(status)) {
+	if (t->timed_out) {
+		t->passed = 0;
+		fprintf(TH_LOG_STREAM,
+			"%s: Test terminated by timeout\n", t->name);
+	} else if (WIFEXITED(status)) {
 		t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
 		if (t->termsig != -1) {
 			fprintf(TH_LOG_STREAM,
-- 
2.20.1

