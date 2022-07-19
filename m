Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C641057A941
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbiGSVqe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbiGSVqL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:46:11 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BE7018B21;
        Tue, 19 Jul 2022 14:45:57 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26JLj4Un002585;
        Tue, 19 Jul 2022 23:45:04 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Pranith Kumar <bobby.prani@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 05/17] selftests/nolibc: support a test definition format
Date:   Tue, 19 Jul 2022 23:44:36 +0200
Message-Id: <20220719214449.2520-6-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220719214449.2520-1-w@1wt.eu>
References: <20220719214449.2520-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It now becomes possible to pass a string either in argv[1] or in the
NOLIBC_TEST environment variable (the former having precedence), to
specify which tests to run. The format is:

   testname[:range]*[,testname...]

Where a range is either a single value or the min and max numbers of the
test IDs in a sequence, delimited by a dash. Multiple ranges are possible.
This should provide enough flexibility to focus on certain failing parts
just by playing with the boot command line in a boot loader or in qemu
depending on what is accessible.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 91 ++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6c050d4381fe..49177ea9943c 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -17,6 +17,12 @@
 /* will be used by nolibc by getenv() */
 char **environ;
 
+/* definition of a series of tests */
+struct test {
+	const char *name;              // test name
+	int (*func)(int min, int max); // handler
+};
+
 #define CASE_ERR(err) \
 	case err: return #err
 
@@ -376,19 +382,104 @@ static int expect_strne(const char *expr, int llen, const char *cmp)
 	return ret;
 }
 
+
 /* declare tests based on line numbers. There must be exactly one test per line. */
 #define CASE_TEST(name) \
 	case __LINE__: llen += printf("%d %s", test, #name);
 
 
+/* This is the definition of known test names, with their functions */
+static struct test test_names[] = {
+	/* add new tests here */
+	{ 0 }
+};
+
 int main(int argc, char **argv, char **envp)
 {
 	int min = 0;
 	int max = __INT_MAX__;
 	int ret = 0;
+	int err;
+	int idx;
+	char *test;
 
 	environ = envp;
 
+	/* the definition of a series of tests comes from either argv[1] or the
+	 * "NOLIBC_TEST" environment variable. It's made of a comma-delimited
+	 * series of test names and optional ranges:
+	 *    syscall:5-15[:.*],stdlib:8-10
+	 */
+	test = argv[1];
+	if (!test)
+		test = getenv("NOLIBC_TEST");
+
+	if (test) {
+		char *comma, *colon, *dash, *value;
+
+		do {
+			comma = strchr(test, ',');
+			if (comma)
+				*(comma++) = '\0';
+
+			colon = strchr(test, ':');
+			if (colon)
+				*(colon++) = '\0';
+
+			for (idx = 0; test_names[idx].name; idx++) {
+				if (strcmp(test, test_names[idx].name) == 0)
+					break;
+			}
+
+			if (test_names[idx].name) {
+				/* The test was named, it will be called at least
+				 * once. We may have an optional range at <colon>
+				 * here, which defaults to the full range.
+				 */
+				do {
+					min = 0; max = __INT_MAX__;
+					value = colon;
+					if (value && *value) {
+						colon = strchr(value, ':');
+						if (colon)
+							*(colon++) = '\0';
+
+						dash = strchr(value, '-');
+						if (dash)
+							*(dash++) = '\0';
+
+						/* support :val: :min-max: :min-: :-max: */
+						if (*value)
+							min = atoi(value);
+						if (!dash)
+							max = min;
+						else if (*dash)
+							max = atoi(dash);
+
+						value = colon;
+					}
+
+					/* now's time to call the test */
+					printf("Running test '%s'\n", test_names[idx].name);
+					err = test_names[idx].func(min, max);
+					ret += err;
+					printf("Errors during this test: %d\n\n", err);
+				} while (colon && *colon);
+			} else
+				printf("Ignoring unknown test name '%s'\n", test);
+
+			test = comma;
+		} while (test && *test);
+	} else {
+		/* no test mentioned, run everything */
+		for (idx = 0; test_names[idx].name; idx++) {
+			printf("Running test '%s'\n", test_names[idx].name);
+			err = test_names[idx].func(min, max);
+			ret += err;
+			printf("Errors during this test: %d\n\n", err);
+		}
+	}
+
 	printf("Total number of errors: %d\n", ret);
 	printf("Exiting with status %d\n", !!ret);
 	return !!ret;
-- 
2.17.5

