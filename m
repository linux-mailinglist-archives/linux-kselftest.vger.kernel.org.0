Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3565743109
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 01:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjF2XYX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 19:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjF2XYW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 19:24:22 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4784A1FC2;
        Thu, 29 Jun 2023 16:24:21 -0700 (PDT)
X-QQ-mid: bizesmtp89t1688081051teyogk65
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 07:24:10 +0800 (CST)
X-QQ-SSF: 00200000000000D0W000000A0000000
X-QQ-FEAT: rZJGTgY0+YOVTQ2kNXjsPZ3MGX+TVmKJcovJh/8yjg+hV2a7oyT97pXC4kLUt
        mj9kJr6hG0y/CgiAEGGVEQ4x8Y9AeFZstxg5XaUwLeMy80LNWwim6uWDIJUnX6Ztr7ukka1
        amq3OMPGiPSMhwkSmJDwXL23FHx8t+SuFEbAuNwNV/of0y9mJKUzwS4DwkqsQUzuEoEjk1f
        uXXZVY5h8yw/DOBh76j+UqmQ25T3BY41/ByGpxOCochUrt0fUUqYmZJdMXliAYePfLoBrZj
        JOzjvwk+WeruPWku6rWBrYp8v5IEsP3ixD6wEetyP/yUR1iezjb2ttPlzHVx1ai6IHfodGv
        21qh12wA/PRoTW43Af1PqTnR3fswnj8HWQdDzi5ThJF3q0lgJYnhgkuDaVYYQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12172486614225476365
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 01/15] selftests/nolibc: stat_fault: silence NULL argument warning with glibc
Date:   Fri, 30 Jun 2023 07:23:58 +0800
Message-Id: <64938ffca05019a13e2cbcdc5beaa12625947572.1688078604.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688078604.git.falcon@tinylab.org>
References: <cover.1688078604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use another invalid address (void *)1 instead of NULL to silence this
compile warning with glibc:

    $ make libc-test
      CC      libc-test
    nolibc-test.c: In function ‘run_syscall’:
    nolibc-test.c:622:49: warning: null argument where non-null required (argument 1) [-Wnonnull]
      622 |   CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
          |                                                 ^~~~
    nolibc-test.c:304:79: note: in definition of macro ‘EXPECT_SYSER2’
      304 |  do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
          |                                                                               ^~~~
    nolibc-test.c:622:33: note: in expansion of macro ‘EXPECT_SYSER’
      622 |   CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index b178bfa29ad9..a2eacd6436d0 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -734,7 +734,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
 		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
 		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
-		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
+		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat((void *)1, &stat_buf), -1, EFAULT); break;
 		CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
 		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;
-- 
2.25.1

