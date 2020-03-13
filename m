Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C74718521D
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Mar 2020 00:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCMXM6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 19:12:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37880 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgCMXM6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 19:12:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id a32so5019491pga.4
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Mar 2020 16:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVB9ateUNPWjDSRVGMb+4rgbxEOqdavmk19dJVvZMIM=;
        b=ClF8fqoBumZSnRpv0Utqo38yv0uvnElq5GseaaNLk/d0T0DTwHAZdaKo5jwGvqJDyU
         RoNsMHO1KDZdq+giL7q3wYKY9HUW0QO045PUqWadbPDAOdsYSOrHjG1QQg/cYr4ufbU4
         JnTVX7waraMyka1dAVcE/afVQf2yXqlDROpgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVB9ateUNPWjDSRVGMb+4rgbxEOqdavmk19dJVvZMIM=;
        b=Sg9ACLhfbrQr1QRvzglfbMGd/C/4BOMrZszXW6vOWiPZStLky4brHs1t+0tiCiCLwf
         0crxidrU2/4hvve/w2dsNcvKLr3E/OWnpSwE28in+079sdkjsxP/DGvzkz+rdUYWxO30
         SsdRQqhF6gKbPg12VpNjZMNMGbZIxaIYFGSe4DALVjZP1imNaXd3SsKVoWy6EzFSYzbd
         ORg51dA6JdDMLiPmRerj7xQij8pELQDy1Om+KZRHEsbXE2WlLsuj34ESNJ6nyZuUeXgF
         5bga6qFizm8X8D9oi63CVYK1fpZ0CC4jwF+xNkiGBhLlMEILlmpfdaDEldPIkDeXf3lb
         ijyg==
X-Gm-Message-State: ANhLgQ3UR3gYPE2owyFQherRN6FR8ibTTq73JvKkbriXCl38oVabG5Cj
        VXqD1vKk//s8TzIaF5sfF4jZ6Q==
X-Google-Smtp-Source: ADFU+vuW5MY2BTvDr6DsWnU09ruFOrR5LSI5+g6PygmDmDlEm+j/U5jO/QNzQgn9N62SKP200VkfvA==
X-Received: by 2002:a63:445:: with SMTP id 66mr14736826pge.351.1584141177002;
        Fri, 13 Mar 2020 16:12:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p21sm58790400pfn.103.2020.03.13.16.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:12:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/harness: Handle timeouts cleanly
Date:   Fri, 13 Mar 2020 16:12:52 -0700
Message-Id: <20200313231252.64999-3-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200313231252.64999-1-keescook@chromium.org>
References: <20200313231252.64999-1-keescook@chromium.org>
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

