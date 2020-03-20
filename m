Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F3518CE8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Mar 2020 14:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgCTNPo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Mar 2020 09:15:44 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:33942 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCTNPo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Mar 2020 09:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1584710143; x=1616246143;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=37agGHt15brKZq1XU2VPRhgEfxAWu0yPz/qm4RymSvg=;
  b=Kd0MczKUkgvN0FBY3KqkHBwjv2/2PMywtt0+OP7VQtqin2CizgVhHhkl
   E2y+6VLwInS3VBEw/Nnsj/eSK/vL2rGV8Kh4kSXvcC3vqAqUKyRYSJxtP
   UciZ3wc0aCWJXB5O5rilTZSWKqe9Osz57TNOUDrnNh8sqiOHb3MTp0PFt
   g=;
IronPort-SDR: YmIyF0kKkvBXHi84n1e2wANvtyHUoyKqMbN5JJJjW86hqvkdbzAbDJv47G3zOMNBYkTDHXy1As
 Egw/pvG23jqA==
X-IronPort-AV: E=Sophos;i="5.72,284,1580774400"; 
   d="scan'208";a="23377215"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 20 Mar 2020 13:15:42 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 19126A2A33;
        Fri, 20 Mar 2020 13:15:38 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 20 Mar 2020 13:15:38 +0000
Received: from 38f9d3582de7.ant.amazon.com (10.43.161.244) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 20 Mar 2020 13:15:34 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        <osa-contribution-log@amazon.com>
Subject: [PATCH v2] selftests: Add support for argc and argv.
Date:   Fri, 20 Mar 2020 22:14:28 +0900
Message-ID: <20200320131428.98093-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.244]
X-ClientProxiedBy: EX13D12UWC002.ant.amazon.com (10.43.162.253) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently tests are often written in C and shell script. In many cases, the
script passes some arguments to the C program. However, the helper
functions do not support arguments, so many tests are written without
helper functions.

This patch allows us to handle argc and argv in each tests and makes it
easier to write tests flexibly with helper functions.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
---
 tools/testing/selftests/kselftest_harness.h | 43 +++++++++++++--------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5336b26506ab..680a6e42f58b 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -167,7 +167,8 @@
 #define TEST_SIGNAL(test_name, signal) __TEST_IMPL(test_name, signal)
 
 #define __TEST_IMPL(test_name, _signal) \
-	static void test_name(struct __test_metadata *_metadata); \
+	static void test_name(struct __test_metadata *_metadata, \
+		int argc, char **argv); \
 	static struct __test_metadata _##test_name##_object = \
 		{ .name = "global." #test_name, \
 		  .fn = &test_name, .termsig = _signal, \
@@ -177,7 +178,9 @@
 		__register_test(&_##test_name##_object); \
 	} \
 	static void test_name( \
-		struct __test_metadata __attribute__((unused)) *_metadata)
+		struct __test_metadata __attribute__((unused)) *_metadata, \
+		int __attribute__((unused)) argc, \
+		char __attribute__((unused)) **argv)
 
 /**
  * FIXTURE_DATA(datatype_name) - Wraps the struct name so we have one less
@@ -241,7 +244,10 @@
 #define FIXTURE_SETUP(fixture_name) \
 	void fixture_name##_setup( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
-		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
+		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
+		int __attribute__ ((unused)) argc, \
+		char __attribute__ ((unused)) **argv)
+
 /**
  * FIXTURE_TEARDOWN(fixture_name)
  * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
@@ -261,7 +267,9 @@
 #define FIXTURE_TEARDOWN(fixture_name) \
 	void fixture_name##_teardown( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
-		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
+		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
+		int __attribute__ ((unused)) argc, \
+		char __attribute__ ((unused)) **argv)
 
 /**
  * TEST_F(fixture_name, test_name) - Emits test registration and helpers for
@@ -293,19 +301,21 @@
 #define __TEST_F_IMPL(fixture_name, test_name, signal, tmout) \
 	static void fixture_name##_##test_name( \
 		struct __test_metadata *_metadata, \
-		FIXTURE_DATA(fixture_name) *self); \
+		FIXTURE_DATA(fixture_name) *self, \
+		int argc, char **argv); \
 	static inline void wrapper_##fixture_name##_##test_name( \
-		struct __test_metadata *_metadata) \
+		struct __test_metadata *_metadata, \
+		int argc, char **argv) \
 	{ \
 		/* fixture data is alloced, setup, and torn down per call. */ \
 		FIXTURE_DATA(fixture_name) self; \
 		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
-		fixture_name##_setup(_metadata, &self); \
+		fixture_name##_setup(_metadata, &self, argc, argv); \
 		/* Let setup failure terminate early. */ \
 		if (!_metadata->passed) \
 			return; \
-		fixture_name##_##test_name(_metadata, &self); \
-		fixture_name##_teardown(_metadata, &self); \
+		fixture_name##_##test_name(_metadata, &self, argc, argv); \
+		fixture_name##_teardown(_metadata, &self, argc, argv); \
 	} \
 	static struct __test_metadata \
 		      _##fixture_name##_##test_name##_object = { \
@@ -321,7 +331,9 @@
 	} \
 	static void fixture_name##_##test_name( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
-		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
+		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
+		int __attribute__ ((unused)) argc, \
+		char __attribute__ ((unused)) **argv)
 
 /**
  * TEST_HARNESS_MAIN - Simple wrapper to run the test harness
@@ -634,7 +646,7 @@
 /* Contains all the information for test execution and status checking. */
 struct __test_metadata {
 	const char *name;
-	void (*fn)(struct __test_metadata *);
+	void (*fn)(struct __test_metadata *, int, char **);
 	int termsig;
 	int passed;
 	int trigger; /* extra handler after the evaluation */
@@ -695,7 +707,7 @@ static inline int __bail(int for_realz, bool no_print, __u8 step)
 	return 0;
 }
 
-void __run_test(struct __test_metadata *t)
+void __run_test(struct __test_metadata *t, int argc, char **argv)
 {
 	pid_t child_pid;
 	int status;
@@ -709,7 +721,7 @@ void __run_test(struct __test_metadata *t)
 		printf("ERROR SPAWNING TEST CHILD\n");
 		t->passed = 0;
 	} else if (child_pid == 0) {
-		t->fn(t);
+		t->fn(t, argc, argv);
 		/* return the step that failed or 0 */
 		_exit(t->passed ? 0 : t->step);
 	} else {
@@ -755,8 +767,7 @@ void __run_test(struct __test_metadata *t)
 	alarm(0);
 }
 
-static int test_harness_run(int __attribute__((unused)) argc,
-			    char __attribute__((unused)) **argv)
+static int test_harness_run(int argc, char **argv)
 {
 	struct __test_metadata *t;
 	int ret = 0;
@@ -768,7 +779,7 @@ static int test_harness_run(int __attribute__((unused)) argc,
 	       __test_count, __fixture_count + 1);
 	for (t = __test_list; t; t = t->next) {
 		count++;
-		__run_test(t);
+		__run_test(t, argc, argv);
 		if (t->passed)
 			pass_count++;
 		else
-- 
2.17.2 (Apple Git-113)

