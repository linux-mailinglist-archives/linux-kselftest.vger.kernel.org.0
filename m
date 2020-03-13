Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5F9B18521C
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Mar 2020 00:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgCMXM6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 19:12:58 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38212 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgCMXM5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 19:12:57 -0400
Received: by mail-pj1-f66.google.com with SMTP id m15so4470934pje.3
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Mar 2020 16:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nc9NjinbmrTaxyzjE2LeQktq68AoC4uPHhJEEjjrJgc=;
        b=QIDWWQZQFkfdnxlv9rWymjRUikbA5qJhWY/1BThRf8ssFyFkbOmtx1qqGRm/pZ3Mck
         SuMh7HylisSJvEBqhXY/cUsqjQJ87kyiD/UxKZV76TyIp1k+YvTm6lt4U9zNBt3RgCNQ
         LS67svR00DSCGD8M/FXti6ujWl4IWh9VU/EVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nc9NjinbmrTaxyzjE2LeQktq68AoC4uPHhJEEjjrJgc=;
        b=oT5cj7MmZumW388j0yX+DeiBSvzryssoJL5z/nRYC1LDhpRt9DqnqIIFXXBHB2GDVO
         Ihebv5aycCCkE5y3O7xzfM1QPND33A2Yc2Y9/E+OOhMBCZ7AZIRLg4Lj+3wynUARu7zW
         nn6cbW2ahIGmyOxCqzXnymDm0G/25fzXGUhW6KkYOnP7CoMQhpwzYlOWrRio6YSnCUD8
         9uAaBLnDi1DwpX069DQ7dflAGAKYgtp1nl0U5PA2MFQUkZ1GsDLdMBEN/mWMvJI3Ppup
         76Z9cg2Pl8GAQV5Gfd3prfM4VB9fbQMTb12Z6b67g12Zt6WLLmedEnzYS4rJ00zpkCTV
         bMTA==
X-Gm-Message-State: ANhLgQ3GHIrBVDyHni4RqVLpSIztOfOLmzcxy/ktDNynAH7Vq+R8o7uS
        GjA69Kt8tQ4MtHqxbLu3Td+d5w==
X-Google-Smtp-Source: ADFU+vtJmozvpA0ahKetinxSppYXZAwjluvNEjbmJUKpwX6mtjSVabr2qZ632EkirI9Ux0ctG8xb8w==
X-Received: by 2002:a17:902:8c8b:: with SMTP id t11mr14384295plo.319.1584141176532;
        Fri, 13 Mar 2020 16:12:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i5sm40803587pfo.173.2020.03.13.16.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:12:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] selftests/harness: Move test child waiting logic
Date:   Fri, 13 Mar 2020 16:12:51 -0700
Message-Id: <20200313231252.64999-2-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200313231252.64999-1-keescook@chromium.org>
References: <20200313231252.64999-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to better handle timeout failures, rearrange the child waiting
logic into a separate function. This is mostly a copy/paste with an
indentation change. To handle pid tracking, a new field is added for
the child pid. Also move the alarm() pairing into the function.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h | 93 +++++++++++----------
 1 file changed, 49 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5336b26506ab..c7b67e379219 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -635,6 +635,7 @@
 struct __test_metadata {
 	const char *name;
 	void (*fn)(struct __test_metadata *);
+	pid_t pid;	/* pid of test when being run */
 	int termsig;
 	int passed;
 	int trigger; /* extra handler after the evaluation */
@@ -695,64 +696,68 @@ static inline int __bail(int for_realz, bool no_print, __u8 step)
 	return 0;
 }
 
-void __run_test(struct __test_metadata *t)
+void __wait_for_test(struct __test_metadata *t)
 {
-	pid_t child_pid;
 	int status;
 
+	alarm(t->timeout);
+	waitpid(t->pid, &status, 0);
+	alarm(0);
+
+	if (WIFEXITED(status)) {
+		t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
+		if (t->termsig != -1) {
+			fprintf(TH_LOG_STREAM,
+				"%s: Test exited normally "
+				"instead of by signal (code: %d)\n",
+				t->name,
+				WEXITSTATUS(status));
+		} else if (!t->passed) {
+			fprintf(TH_LOG_STREAM,
+				"%s: Test failed at step #%d\n",
+				t->name,
+				WEXITSTATUS(status));
+		}
+	} else if (WIFSIGNALED(status)) {
+		t->passed = 0;
+		if (WTERMSIG(status) == SIGABRT) {
+			fprintf(TH_LOG_STREAM,
+				"%s: Test terminated by assertion\n",
+				t->name);
+		} else if (WTERMSIG(status) == t->termsig) {
+			t->passed = 1;
+		} else {
+			fprintf(TH_LOG_STREAM,
+				"%s: Test terminated unexpectedly "
+				"by signal %d\n",
+				t->name,
+				WTERMSIG(status));
+		}
+	} else {
+		fprintf(TH_LOG_STREAM,
+			"%s: Test ended in some other way [%u]\n",
+			t->name,
+			status);
+	}
+}
+
+void __run_test(struct __test_metadata *t)
+{
 	t->passed = 1;
 	t->trigger = 0;
 	printf("[ RUN      ] %s\n", t->name);
-	alarm(t->timeout);
-	child_pid = fork();
-	if (child_pid < 0) {
+	t->pid = fork();
+	if (t->pid < 0) {
 		printf("ERROR SPAWNING TEST CHILD\n");
 		t->passed = 0;
-	} else if (child_pid == 0) {
+	} else if (t->pid == 0) {
 		t->fn(t);
 		/* return the step that failed or 0 */
 		_exit(t->passed ? 0 : t->step);
 	} else {
-		/* TODO(wad) add timeout support. */
-		waitpid(child_pid, &status, 0);
-		if (WIFEXITED(status)) {
-			t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
-			if (t->termsig != -1) {
-				fprintf(TH_LOG_STREAM,
-					"%s: Test exited normally "
-					"instead of by signal (code: %d)\n",
-					t->name,
-					WEXITSTATUS(status));
-			} else if (!t->passed) {
-				fprintf(TH_LOG_STREAM,
-					"%s: Test failed at step #%d\n",
-					t->name,
-					WEXITSTATUS(status));
-			}
-		} else if (WIFSIGNALED(status)) {
-			t->passed = 0;
-			if (WTERMSIG(status) == SIGABRT) {
-				fprintf(TH_LOG_STREAM,
-					"%s: Test terminated by assertion\n",
-					t->name);
-			} else if (WTERMSIG(status) == t->termsig) {
-				t->passed = 1;
-			} else {
-				fprintf(TH_LOG_STREAM,
-					"%s: Test terminated unexpectedly "
-					"by signal %d\n",
-					t->name,
-					WTERMSIG(status));
-			}
-		} else {
-			fprintf(TH_LOG_STREAM,
-				"%s: Test ended in some other way [%u]\n",
-				t->name,
-				status);
-		}
+		__wait_for_test(t);
 	}
 	printf("[     %4s ] %s\n", (t->passed ? "OK" : "FAIL"), t->name);
-	alarm(0);
 }
 
 static int test_harness_run(int __attribute__((unused)) argc,
-- 
2.20.1

