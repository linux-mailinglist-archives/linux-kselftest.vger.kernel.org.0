Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6D1758822
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 00:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjGRWFa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 18:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGRWFa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 18:05:30 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7230D1FDF;
        Tue, 18 Jul 2023 15:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689717869;
        bh=m5aG2jsE/sgyJ2tqwTkKOysF3r7AOBHTMjAwg4kbc1g=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=eRcA8RmHcS61tw1UzwYA05Tv5Kkw2ND09r6+RbnVucax+MJIVCssxlKCIB1lYmhT9
         aVi7nAJ8fNzPR42fUhN+bPFGWTJ/h+TmCVjiHxEOzPcWQWaIrUMvGJrmmNkB7aGQsr
         u0odUd3EuICoRsC6nRZQq1z21HdHuI3kdD3OfcIw=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 19 Jul 2023 00:00:42 +0200
Subject: [PATCH RFC 4/7] selftests/nolibc: count subtests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230719-nolibc-ktap-tmp-v1-4-930bd0c52ff1@weissschuh.net>
References: <20230719-nolibc-ktap-tmp-v1-0-930bd0c52ff1@weissschuh.net>
In-Reply-To: <20230719-nolibc-ktap-tmp-v1-0-930bd0c52ff1@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689717869; l=4038;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=m5aG2jsE/sgyJ2tqwTkKOysF3r7AOBHTMjAwg4kbc1g=;
 b=fJ2NOu2wG+DLyHL32lAYwKlvELVRJsD01KjN7sfi/PiA2+k3UNDobW0TTr/7jSZPdiTHPQu2t
 HAWcOWx0qwMA48xC01ns+/GgrZXn+10kbj4H4KWTwCRaomgoElyjVYo
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This will be needed for KTAP output.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 30 +++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 76bd6a0a8132..03f64ce1dda6 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -65,6 +65,13 @@ struct test {
 	int (*func)(unsigned int min, unsigned int max); /* handler */
 };
 
+#define COUNT_SUBTESTS (-1)
+
+static unsigned int count_subtests(const struct test *test)
+{
+	return test->func(COUNT_SUBTESTS, COUNT_SUBTESTS);
+}
+
 #ifndef _NOLIBC_STDLIB_H
 char *itoa(int i)
 {
@@ -571,10 +578,10 @@ static int expect_strne(const char *expr, int llen, const char *cmp)
 	case __LINE__: llen += printf("%d %s", test, #name);
 
 #define SWITCH_TEST \
-	switch (test + __LINE__ + 1) {
+	int _tests_start = __LINE__; switch (test + __LINE__ + 1) {
 
 #define SWITCH_TEST_END \
-	case __LINE__: return ret; }
+	case __LINE__: return ret; default: return __LINE__ - _tests_start - 1; }
 
 
 int run_startup(unsigned int min, unsigned int max)
@@ -592,7 +599,7 @@ int run_startup(unsigned int min, unsigned int max)
 	test_auxv = _auxv;
 #endif
 
-	for (test = min; test >= 0 && test <= max; test++) {
+	for (test = min; test == COUNT_SUBTESTS || (test >= 0 && test <= max); test++) {
 		int llen = 0; /* line length */
 
 		/* avoid leaving empty lines below, this will insert holes into
@@ -801,7 +808,7 @@ int run_syscall(unsigned int min, unsigned int max)
 	has_gettid = __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 30);
 #endif
 
-	for (test = min; test >= 0 && test <= max; test++) {
+	for (test = min; test == COUNT_SUBTESTS || (test >= 0 && test <= max); test++) {
 		int llen = 0; /* line length */
 
 		/* avoid leaving empty lines below, this will insert holes into
@@ -892,7 +899,7 @@ int run_stdlib(unsigned int min, unsigned int max)
 	int ret = 0;
 	void *p1, *p2;
 
-	for (test = min; test >= 0 && test <= max; test++) {
+	for (test = min; test == COUNT_SUBTESTS || (test >= 0 && test <= max); test++) {
 		int llen = 0; /* line length */
 
 		/* avoid leaving empty lines below, this will insert holes into
@@ -1032,7 +1039,7 @@ static int run_vfprintf(unsigned int min, unsigned int max)
 	int ret = 0;
 	void *p1, *p2;
 
-	for (test = min; test >= 0 && test <= max; test++) {
+	for (test = min; test == COUNT_SUBTESTS || (test >= 0 && test <= max); test++) {
 		int llen = 0; /* line length */
 
 		/* avoid leaving empty lines below, this will insert holes into
@@ -1070,6 +1077,9 @@ static int run_protection(unsigned int min, unsigned int max)
 	pid_t pid;
 	int llen = 0, status;
 
+	if (min == COUNT_SUBTESTS)
+		return 1;
+
 	llen += printf("0 -fstackprotector ");
 
 #if !defined(_NOLIBC_STACKPROTECTOR)
@@ -1219,6 +1229,7 @@ int main(int argc, char **argv, char **envp)
 	int ret = 0;
 	int err;
 	int idx;
+	unsigned int subtests;
 	char *test;
 
 	argv0 = argv[0];
@@ -1265,6 +1276,8 @@ int main(int argc, char **argv, char **envp)
 				 * once. We may have an optional range at <colon>
 				 * here, which defaults to the full range.
 				 */
+
+				subtests = count_subtests(&test_names[idx]);
 				do {
 					min = 0; max = INT_MAX;
 					value = colon;
@@ -1285,11 +1298,14 @@ int main(int argc, char **argv, char **envp)
 						else if (*dash)
 							max = atoi(dash);
 
+						if (max > subtests)
+							max = subtests;
+
 						value = colon;
 					}
 
 					/* now's time to call the test */
-					printf("Running test '%s'\n", test_names[idx].name);
+					printf("Running test '%s' (%d-%d of %d)\n", test_names[idx].name, min, max, subtests);
 					err = test_names[idx].func(min, max);
 					ret += err;
 					printf("Errors during this test: %d\n\n", err);

-- 
2.41.0

