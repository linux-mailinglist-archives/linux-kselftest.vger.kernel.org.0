Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0E157A94D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbiGSVrO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbiGSVrD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:47:03 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D59B9643DA;
        Tue, 19 Jul 2022 14:46:37 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26JLj4MY002588;
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
Subject: [PATCH 07/17] selftests/nolibc: add a few tests for some stdlib functions
Date:   Tue, 19 Jul 2022 23:44:39 +0200
Message-Id: <20220719214449.2520-9-w@1wt.eu>
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

The test series called "stdlib" covers some libc functions (string,
stdlib etc). By default they are automatically run after "syscall"
but may be requested in argument or in variable NOLIBC_TEST.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 35 ++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index dc87832912ce..ab7c4cbdef9b 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -496,11 +496,46 @@ int run_syscall(int min, int max)
 	return ret;
 }
 
+int run_stdlib(int min, int max)
+{
+	int test;
+	int tmp;
+	int ret = 0;
+	void *p1, *p2;
+
+	for (test = min; test >= 0 && test <= max; test++) {
+		int llen = 0; // line length
+
+		/* avoid leaving empty lines below, this will insert holes into
+		 * test numbers.
+		 */
+		switch (test + __LINE__ + 1) {
+		CASE_TEST(getenv_TERM);        EXPECT_STRNZ(1, getenv("TERM")); break;
+		CASE_TEST(getenv_blah);        EXPECT_STRZR(1, getenv("blah")); break;
+		CASE_TEST(strcmp_blah_blah);   EXPECT_EQ(1, strcmp("blah", "blah"), 0); break;
+		CASE_TEST(strcmp_blah_blah2);  EXPECT_NE(1, strcmp("blah", "blah2"), 0); break;
+		CASE_TEST(strncmp_blah_blah);  EXPECT_EQ(1, strncmp("blah", "blah", 10), 0); break;
+		CASE_TEST(strncmp_blah_blah4); EXPECT_EQ(1, strncmp("blah", "blah4", 4), 0); break;
+		CASE_TEST(strncmp_blah_blah5); EXPECT_NE(1, strncmp("blah", "blah5", 5), 0); break;
+		CASE_TEST(strncmp_blah_blah6); EXPECT_NE(1, strncmp("blah", "blah6", 6), 0); break;
+		CASE_TEST(strchr_foobar_o);    EXPECT_STREQ(1, strchr("foobar", 'o'), "oobar"); break;
+		CASE_TEST(strchr_foobar_z);    EXPECT_STRZR(1, strchr("foobar", 'z')); break;
+		CASE_TEST(strrchr_foobar_o);   EXPECT_STREQ(1, strrchr("foobar", 'o'), "obar"); break;
+		CASE_TEST(strrchr_foobar_z);   EXPECT_STRZR(1, strrchr("foobar", 'z')); break;
+		case __LINE__:
+			return ret; /* must be last */
+		/* note: do not set any defaults so as to permit holes above */
+		}
+	}
+	return ret;
+}
+
 
 /* This is the definition of known test names, with their functions */
 static struct test test_names[] = {
 	/* add new tests here */
 	{ .name = "syscall",   .func = run_syscall  },
+	{ .name = "stdlib",    .func = run_stdlib   },
 	{ 0 }
 };
 
-- 
2.17.5

