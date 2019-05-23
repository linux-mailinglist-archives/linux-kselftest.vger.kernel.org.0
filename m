Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B1C28D5C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 00:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbfEWWm5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 18:42:57 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:52213 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387616AbfEWWm4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 18:42:56 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D4023FF804;
        Thu, 23 May 2019 22:42:41 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] selftests/harness: Allow test to configure timeout
Date:   Fri, 24 May 2019 00:42:22 +0200
Message-Id: <20190523224223.11054-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523224223.11054-1-alexandre.belloni@bootlin.com>
References: <20190523224223.11054-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per test")
adds an hardcoded 30s timeout to all tests. Unfortunately, rtctest has two
tests taking up to 60s. Allow for individual tests to define their own
timeout.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 tools/testing/selftests/kselftest_harness.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 941d9391377f..2067c6b0e8a1 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -62,6 +62,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
+#define TEST_TIMEOUT_DEFAULT 30
 
 /* Utilities exposed to the test definitions */
 #ifndef TH_LOG_STREAM
@@ -169,7 +170,8 @@
 	static void test_name(struct __test_metadata *_metadata); \
 	static struct __test_metadata _##test_name##_object = \
 		{ .name = "global." #test_name, \
-		  .fn = &test_name, .termsig = _signal }; \
+		  .fn = &test_name, .termsig = _signal, \
+		  .timeout = TEST_TIMEOUT_DEFAULT, }; \
 	static void __attribute__((constructor)) _register_##test_name(void) \
 	{ \
 		__register_test(&_##test_name##_object); \
@@ -280,12 +282,15 @@
  */
 /* TODO(wad) register fixtures on dedicated test lists. */
 #define TEST_F(fixture_name, test_name) \
-	__TEST_F_IMPL(fixture_name, test_name, -1)
+	__TEST_F_IMPL(fixture_name, test_name, -1, TEST_TIMEOUT_DEFAULT)
 
 #define TEST_F_SIGNAL(fixture_name, test_name, signal) \
-	__TEST_F_IMPL(fixture_name, test_name, signal)
+	__TEST_F_IMPL(fixture_name, test_name, signal, TEST_TIMEOUT_DEFAULT)
 
-#define __TEST_F_IMPL(fixture_name, test_name, signal) \
+#define TEST_F_TIMEOUT(fixture_name, test_name, timeout) \
+	__TEST_F_IMPL(fixture_name, test_name, -1, timeout)
+
+#define __TEST_F_IMPL(fixture_name, test_name, signal, tmout) \
 	static void fixture_name##_##test_name( \
 		struct __test_metadata *_metadata, \
 		FIXTURE_DATA(fixture_name) *self); \
@@ -307,6 +312,7 @@
 		.name = #fixture_name "." #test_name, \
 		.fn = &wrapper_##fixture_name##_##test_name, \
 		.termsig = signal, \
+		.timeout = tmout, \
 	 }; \
 	static void __attribute__((constructor)) \
 			_register_##fixture_name##_##test_name(void) \
@@ -632,6 +638,7 @@ struct __test_metadata {
 	int termsig;
 	int passed;
 	int trigger; /* extra handler after the evaluation */
+	int timeout;
 	__u8 step;
 	bool no_print; /* manual trigger when TH_LOG_STREAM is not available */
 	struct __test_metadata *prev, *next;
@@ -696,7 +703,7 @@ void __run_test(struct __test_metadata *t)
 	t->passed = 1;
 	t->trigger = 0;
 	printf("[ RUN      ] %s\n", t->name);
-	alarm(30);
+	alarm(t->timeout);
 	child_pid = fork();
 	if (child_pid < 0) {
 		printf("ERROR SPAWNING TEST CHILD\n");
-- 
2.21.0

