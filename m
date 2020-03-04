Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 861CF178CDC
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 09:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbgCDIwZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 03:52:25 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:1230 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbgCDIwY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 03:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1583311944; x=1614847944;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Kll+TJ1Wu1IFm6GdiF7Rbn4hXVv0O3AYnXmSMG+t02Y=;
  b=kIMHmdvCB9WIIIHxRYEMK8WKywJYrL4AvRCyYiMngHNrkWrZXP/FTWwU
   Wicp+3637wS9Mu9ElPoX7qp5D4heyxpv07q/RLJ8HpeqQ6QDxv/U9A+qZ
   Np8TsML/M/JQUz+oI4OLXFKFqQxBv4wOyHKXaVGF/f8NKDD5zszEv3D3T
   4=;
IronPort-SDR: 3e1IRx9eTxYaWHYGZpiT53D4MTPmQC94rn9jHUI1GaCBFKZ1Aej3w1aS97hu7kHuqqKAftgd63
 5JOv33fR919Q==
X-IronPort-AV: E=Sophos;i="5.70,513,1574121600"; 
   d="scan'208";a="20732236"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 04 Mar 2020 08:52:23 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 1A26EA1E2E;
        Wed,  4 Mar 2020 08:52:19 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Mar 2020 08:52:19 +0000
Received: from 38f9d3582de7.ant.amazon.com.com (10.43.162.171) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 4 Mar 2020 08:52:10 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        <osa-contribution-log@amazon.com>
Subject: [PATCH] selftests: Add support for argc and argv.
Date:   Wed, 4 Mar 2020 17:52:04 +0900
Message-ID: <20200304085204.48118-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.171]
X-ClientProxiedBy: EX13D04UWB003.ant.amazon.com (10.43.161.231) To
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
 tools/testing/selftests/kselftest_harness.h | 30 ++++++++++++---------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5336b26506ab..75bee67b87fa 100644
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
@@ -293,9 +296,11 @@
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
@@ -304,7 +309,7 @@
 		/* Let setup failure terminate early. */ \
 		if (!_metadata->passed) \
 			return; \
-		fixture_name##_##test_name(_metadata, &self); \
+		fixture_name##_##test_name(_metadata, &self, argc, argv); \
 		fixture_name##_teardown(_metadata, &self); \
 	} \
 	static struct __test_metadata \
@@ -321,7 +326,9 @@
 	} \
 	static void fixture_name##_##test_name( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
-		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
+		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
+		int __attribute__ ((unused)) argc, \
+		char __attribute__ ((unused)) **argv)
 
 /**
  * TEST_HARNESS_MAIN - Simple wrapper to run the test harness
@@ -634,7 +641,7 @@
 /* Contains all the information for test execution and status checking. */
 struct __test_metadata {
 	const char *name;
-	void (*fn)(struct __test_metadata *);
+	void (*fn)(struct __test_metadata *, int, char **);
 	int termsig;
 	int passed;
 	int trigger; /* extra handler after the evaluation */
@@ -695,7 +702,7 @@ static inline int __bail(int for_realz, bool no_print, __u8 step)
 	return 0;
 }
 
-void __run_test(struct __test_metadata *t)
+void __run_test(struct __test_metadata *t, int argc, char **argv)
 {
 	pid_t child_pid;
 	int status;
@@ -709,7 +716,7 @@ void __run_test(struct __test_metadata *t)
 		printf("ERROR SPAWNING TEST CHILD\n");
 		t->passed = 0;
 	} else if (child_pid == 0) {
-		t->fn(t);
+		t->fn(t, argc, argv);
 		/* return the step that failed or 0 */
 		_exit(t->passed ? 0 : t->step);
 	} else {
@@ -755,8 +762,7 @@ void __run_test(struct __test_metadata *t)
 	alarm(0);
 }
 
-static int test_harness_run(int __attribute__((unused)) argc,
-			    char __attribute__((unused)) **argv)
+static int test_harness_run(int argc, char **argv)
 {
 	struct __test_metadata *t;
 	int ret = 0;
@@ -768,7 +774,7 @@ static int test_harness_run(int __attribute__((unused)) argc,
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

