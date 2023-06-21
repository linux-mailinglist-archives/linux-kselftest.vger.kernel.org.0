Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C82F73841F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 14:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjFUMyC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 08:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjFUMyB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 08:54:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF790198E;
        Wed, 21 Jun 2023 05:53:59 -0700 (PDT)
X-QQ-mid: bizesmtp75t1687352030t6j173ww
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 20:53:49 +0800 (CST)
X-QQ-SSF: 00200000000000D0V000000A0000000
X-QQ-FEAT: rZJGTgY0+YPZ7mrwklJEhXkxIhwVAUczV0XJnaL0tpQYWZHFFFHnfUHkJIX1z
        sWOoGTqB/Z5xI0uOG1O7jU4STKbVEZhWcePXhzT7VX5SBwKucKebhCloWNphgvPrsNvvRKW
        6Nt5lrd2BHcm8T1TDQJeBHne0RhSELBHlqyotO+bh4mGc5cPHPAe4zayQAiaA25mdYqH93u
        jb4hWDuC7Eahb7t1ORs90h8wBddDcTWDUL5Mb8rXYLJind7Nv9ttrboZipA0b/Nv8V6bNyZ
        62l8/Kmnn5sea08fk6yMMh2o3uREf9OLHTxDYbJnwxHcXNrqcXBCCE8Jvl7PY4TQMho+Ro9
        7cHDlAfWcRQX50pU/xfYBSMarFOejMdOQPLx77w8enOSPAdvTZuN2z/BPxElg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10490605076319373216
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 01/17] selftests/nolibc: stat_fault: silence NULL argument warning with glibc
Date:   Wed, 21 Jun 2023 20:53:45 +0800
Message-Id: <7edcfbe718bbaf145e303ef353d427373cec63dc.1687344643.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687344643.git.falcon@tinylab.org>
References: <cover.1687344643.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 486334981e60..99afec93dfae 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -619,7 +619,7 @@ int run_syscall(int min, int max)
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

