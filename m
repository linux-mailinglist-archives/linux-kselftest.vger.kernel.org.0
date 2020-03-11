Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3581823BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 22:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgCKVRl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 17:17:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45224 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgCKVRk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 17:17:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id b22so1675244pls.12
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Mar 2020 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nc9NjinbmrTaxyzjE2LeQktq68AoC4uPHhJEEjjrJgc=;
        b=i1rRo9cQXtQVJYpbkuUHBDz3DG2L+anp7slukdngNw8TGGR8GERDze0/8etvv/yWCU
         oK1pY3tV7qSb9h+h38yzskqqoUyBDN0LO34fCcezTJH4uiRheDXJoTKLGn8dSZkiw9c0
         p7x8bEBWEzaa1MXRoL5I8RL7L3uHPzbYdtGf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nc9NjinbmrTaxyzjE2LeQktq68AoC4uPHhJEEjjrJgc=;
        b=Ecsm0QhQEVme08XV3eZKW4cq58N5HTGAIoGJzKLN4B4dDO4aH9zLec6+5OM6zIdSMt
         JoU3KPQCIjlf4JH0auYehSQ/9JfwuWlS9qe8NzUK42IWCLHGOWzRZpyUoseNle/pro/5
         05FlB6Uj83APjqK8BVt2p/cTeLzjzWxdf7EakOLNcF9Gs4ym5rTg1JObLqLLElmXXy1X
         fJe0SCQvWQnrnltp40DVQ8kOBBxL+eW4rkNqcaZdfK4z8MAYLifJtc5KANKR1PIdscNS
         fGo0Gsh7y9vhFX4BOTQHbYQvjuOf6MRd34E3LuLg4Fxx+kDTJSTA6Zg04JBcHAsSxzJW
         GiRQ==
X-Gm-Message-State: ANhLgQ0sQPj1EwZ+A4E/YuSxgZOfMVjva8lNIXVptqiudyjaku/KIXNz
        qBTsQIICgostuJXWgJfH6Cd+4w==
X-Google-Smtp-Source: ADFU+vtwSFH+JOAbpOb/3n4HNpVl3+GgXIImjKKjyy8vWRpDCnnW52YDpgakBJbUmvK3PJtQ+eVTKA==
X-Received: by 2002:a17:902:8485:: with SMTP id c5mr4831297plo.156.1583961459264;
        Wed, 11 Mar 2020 14:17:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u3sm6874522pfb.36.2020.03.11.14.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 14:17:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests/seccomp: Move test child waiting logic
Date:   Wed, 11 Mar 2020 14:17:32 -0700
Message-Id: <20200311211733.21211-2-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311211733.21211-1-keescook@chromium.org>
References: <20200311211733.21211-1-keescook@chromium.org>
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

