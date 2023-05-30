Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62213715C51
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 12:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjE3K4X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 06:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjE3K4V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 06:56:21 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E598AF7;
        Tue, 30 May 2023 03:56:17 -0700 (PDT)
X-QQ-mid: bizesmtp72t1685444172tvjqxqzn
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 18:56:11 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: IV30oiqrgAYLeAVOtqPY/w4sV51ufOZgvH9veDK9Ln5rvQZwJVqfvQebBNkb0
        rWdg0XWxELEr+D+JJDpmJRKXEGbTrqUmljotAwMSeKgbivwAh8Yc83kjym3D0j3G2Y/rfbT
        rmDMziIaF1RHSZ0VHwappE4cH+2ibJvPOUXuZeZixvII0+kcxU/CNsIAfWDAPnGiPA/X4Ry
        uhcwpAPuHw//KlJZuq0nj2KBV/mhrO1z6IjLwWZl6tEPenU5NHMlwsxmdxFUZgT39wwGWzW
        zUWW0R3DR8s36VqJKPbbMYeeSntiCd0UAIcDVkGpuo+W1S9x5EyFdJl4W5eKH6bam/lftYQ
        9/imcDdRSqPSe6FQ4g46x2VQalG7yfX6OA+ka7s9XC8huDYjbWd2rJlVOqjkRRquGnxwI1c
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16230640011585094560
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 1/4] selftests/nolibc: allow rerun with the same settings
Date:   Tue, 30 May 2023 18:56:10 +0800
Message-Id: <32d4ec1c3cabae5c1baabf85627b81d6ede01518.1685443199.git.falcon@tinylab.org>
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

Record the user settings from NOLIBC_TEST and allow reuse them in
another run iteration.

This allows to rerun the test cases with the same setting.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 46 ++++++++++++--------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index fd7515f6b1d2..be718fa5dc86 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -46,6 +46,9 @@ char **environ;
 /* definition of a series of tests */
 struct test {
 	const char *name;              /* test name */
+	int min;
+	int max;
+	int run;
 	int (*func)(int min, int max); /* handler */
 };
 
@@ -940,12 +943,12 @@ int prepare(void)
 }
 
 /* This is the definition of known test names, with their functions */
-static const struct test test_names[] = {
+static struct test test_names[] = {
 	/* add new tests here */
-	{ .name = "syscall",    .func = run_syscall    },
-	{ .name = "stdlib",     .func = run_stdlib     },
-	{ .name = "vfprintf",   .func = run_vfprintf   },
-	{ .name = "protection", .func = run_protection },
+	{ .name = "syscall",    .min = 0, .max = INT_MAX, .run = -1, .func = run_syscall    },
+	{ .name = "stdlib",     .min = 0, .max = INT_MAX, .run = -1, .func = run_stdlib     },
+	{ .name = "vfprintf",   .min = 0, .max = INT_MAX, .run = -1, .func = run_vfprintf   },
+	{ .name = "protection", .min = 0, .max = INT_MAX, .run = -1, .func = run_protection },
 	{ 0 }
 };
 
@@ -994,7 +997,11 @@ int main(int argc, char **argv, char **envp)
 					break;
 			}
 
-			if (test_names[idx].name) {
+			if (!test_names[idx].name) {
+				printf("Ignoring unknown test name '%s'\n", test);
+			} else {
+				test_names[idx].run = 1;
+
 				/* The test was named, it will be called at least
 				 * once. We may have an optional range at <colon>
 				 * here, which defaults to the full range.
@@ -1022,27 +1029,32 @@ int main(int argc, char **argv, char **envp)
 						value = colon;
 					}
 
-					/* now's time to call the test */
-					printf("Running test '%s'\n", test_names[idx].name);
-					err = test_names[idx].func(min, max);
-					ret += err;
-					printf("Errors during this test: %d\n\n", err);
+					test_names[idx].min = min;
+					test_names[idx].max = max;
 				} while (colon && *colon);
-			} else
-				printf("Ignoring unknown test name '%s'\n", test);
+			}
 
 			test = comma;
 		} while (test && *test);
-	} else {
-		/* no test mentioned, run everything */
+
+		/* disable the left tests */
 		for (idx = 0; test_names[idx].name; idx++) {
-			printf("Running test '%s'\n", test_names[idx].name);
-			err = test_names[idx].func(min, max);
+			if (test_names[idx].run != 1)
+				test_names[idx].run = 0;
+		}
+	}
+
+	/* run everything or the test mentioned */
+	for (idx = 0; test_names[idx].name; idx++) {
+		if (test_names[idx].run != 0) {
+			printf("Running test '%s', from %d to %d\n", test_names[idx].name, test_names[idx].min, test_names[idx].max);
+			err = test_names[idx].func(test_names[idx].min, test_names[idx].max);
 			ret += err;
 			printf("Errors during this test: %d\n\n", err);
 		}
 	}
 
+
 	printf("Total number of errors: %d\n", ret);
 
 	if (getpid() == 1) {
-- 
2.25.1

