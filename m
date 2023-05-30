Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A7A715C82
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 13:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjE3LDk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 07:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjE3LDj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 07:03:39 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B05D9;
        Tue, 30 May 2023 04:03:37 -0700 (PDT)
X-QQ-mid: bizesmtp67t1685444612t08p4xww
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 19:03:31 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: C46Rb8GPIEc160nmUqFUHiFICVb8yJ5e11pqzLjXmS2/y5C6aYAhQb0+Cg9Tj
        G3ora3iXuOFD2kdO18FYoRZpzosUJ632Ckb/qSW3VPNCJimOOJtBcHY61W3wIe1KHd8Ku/m
        SNaBXZkq2EDAvjm3Z2XXHd9yz9p9K+IWKqic4/ShSxQLPa+MhRk+KsuDEZwgII7hmu9g0Hj
        OD4MUc56yMOVYx8jF1UmiV4xnslxBAOf8TydDIQUBAo1c/pZb2cTMLZhdKOyDiqzb5R5A3t
        sM7sjtpkHDsR1PkkNnf2L64rsCpz9zPGGU8rWiCfNGmSBMcaIdRNSmIkwsJ1IDxPvn6f6Lv
        /tN5H40PTJIIHyFAN1kYgY95zls1dyh5pu+erFw4eSHkrjvLHL//EpzyhXCHPv1LNHhyht+
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17642228944967858726
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 2/4] selftests/nolibc: add rerun support
Date:   Tue, 30 May 2023 19:03:30 +0800
Message-Id: <247d4d69a5e229446fc43efa49cc4fa36ccd600a.1685443199.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685443199.git.falcon@tinylab.org>
References: <cover.1685443199.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The global 'run' setting is added to allow specify the running
iterations, for example:

    NOLIBC_TEST=run:5,syscall:1

This setting allows to run the first syscall for 5 times.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 53 ++++++++++++++------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index be718fa5dc86..b8fd7fcf56a6 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -956,9 +956,12 @@ int main(int argc, char **argv, char **envp)
 {
 	int min = 0;
 	int max = INT_MAX;
+	int run = 1;
+	int selected = 0;
 	int ret = 0;
 	int err;
 	int idx;
+	int i;
 	char *test;
 
 	environ = envp;
@@ -974,7 +977,7 @@ int main(int argc, char **argv, char **envp)
 	/* the definition of a series of tests comes from either argv[1] or the
 	 * "NOLIBC_TEST" environment variable. It's made of a comma-delimited
 	 * series of test names and optional ranges:
-	 *    syscall:5-15[:.*],stdlib:8-10
+	 *    run:3,syscall:5-15[:.*],stdlib:8-10
 	 */
 	test = argv[1];
 	if (!test)
@@ -992,14 +995,27 @@ int main(int argc, char **argv, char **envp)
 			if (colon)
 				*(colon++) = '\0';
 
-			for (idx = 0; test_names[idx].name; idx++) {
-				if (strcmp(test, test_names[idx].name) == 0)
+			if (strcmp(test, "run") != 0) {
+				for (idx = 0; test_names[idx].name; idx++) {
+					if (strcmp(test, test_names[idx].name) == 0)
+						break;
+				}
+			} else {
+				value = colon;
+				if (value && *value)
+					run = atoi(value);
+
+				test = comma;
+				if (test && *test)
+					continue;
+				else
 					break;
 			}
 
 			if (!test_names[idx].name) {
 				printf("Ignoring unknown test name '%s'\n", test);
 			} else {
+				selected++;
 				test_names[idx].run = 1;
 
 				/* The test was named, it will be called at least
@@ -1038,24 +1054,31 @@ int main(int argc, char **argv, char **envp)
 		} while (test && *test);
 
 		/* disable the left tests */
-		for (idx = 0; test_names[idx].name; idx++) {
-			if (test_names[idx].run != 1)
-				test_names[idx].run = 0;
+		if (selected != 0) {
+			for (idx = 0; test_names[idx].name; idx++) {
+				if (test_names[idx].run != 1)
+					test_names[idx].run = 0;
+			}
 		}
 	}
 
 	/* run everything or the test mentioned */
-	for (idx = 0; test_names[idx].name; idx++) {
-		if (test_names[idx].run != 0) {
-			printf("Running test '%s', from %d to %d\n", test_names[idx].name, test_names[idx].min, test_names[idx].max);
-			err = test_names[idx].func(test_names[idx].min, test_names[idx].max);
-			ret += err;
-			printf("Errors during this test: %d\n\n", err);
-		}
-	}
+	printf("Running iteration(s): %d\n\n", run);
+	for (i = 0; i < run; i++) {
+		printf("Current iteration: %d\n\n", i + 1);
 
+		ret = 0;
+		for (idx = 0; test_names[idx].name; idx++) {
+			if (test_names[idx].run != 0) {
+				printf("Running test '%s', from %d to %d\n", test_names[idx].name, test_names[idx].min, test_names[idx].max);
+				err = test_names[idx].func(test_names[idx].min, test_names[idx].max);
+				ret += err;
+				printf("Errors during this test: %d\n\n", err);
+			}
+		}
 
-	printf("Total number of errors: %d\n", ret);
+		printf("Total number of errors in the %d iteration(s): %d\n\n", i + 1, ret);
+	}
 
 	if (getpid() == 1) {
 		/* we're running as init, there's no other process on the
-- 
2.25.1

