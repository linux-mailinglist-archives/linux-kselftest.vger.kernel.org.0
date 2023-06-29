Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E47E743136
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 01:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjF2Xsw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 19:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF2Xsv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 19:48:51 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B952D55;
        Thu, 29 Jun 2023 16:48:49 -0700 (PDT)
X-QQ-mid: bizesmtp73t1688082520tj99e1ey
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 07:48:39 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: rZJGTgY0+YPV5/jLlL1r2TTowp9VzAJ/QuZsdkm5XOB79yntw54lelBhGFGBW
        +iDCR+bq5zuGY1Fb5AOm9nx/s2lzObBrLIU6hKpbs2UAer50DRPUX5SXgyRxGcGoeAj4hLE
        ZeKdJH9pzNzvsarmvs3DCR53UszQvhXaLbg4dp20rANnIT0/3bXQEFJYUINdfEY5uYn18gq
        u9ksw5IB8zjOinFLQFFb9AuiAFpF2HoQxoPVaS2/Uhz2MaX8tb6sbRf1nDxkcWLFqUrwA20
        msOXABk2XcYTB7yww0XiP5gppsd/tXgth9vLou2iZhqKqV42WH1UKjxu82NVmaDS51d5vO3
        StbtwR6MAldUGm6M3EglvM8DTmqRzi64SQ+8y8VHJ3FStWMmcAADDmXyBZjzQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1596370371220799989
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 09/15] selftests/nolibc: add a new rmdir() test case
Date:   Fri, 30 Jun 2023 07:48:29 +0800
Message-Id: <652efe216f732c88bd275b597924c4d106741c6b.1688078605.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688078604.git.falcon@tinylab.org>
References: <cover.1688078604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A new rmdir_blah test case is added to remove a non-existing /blah,
which expects failure with ENOENT errno.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 0bb222eaafca..2725d3dbfaf0 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -738,6 +738,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll((void *)1, 1, 0), -1, EFAULT); break;
 		CASE_TEST(prctl);             EXPECT_SYSER(1, prctl(PR_SET_NAME, (unsigned long)NULL, 0, 0, 0), -1, EFAULT); break;
 		CASE_TEST(read_badf);         EXPECT_SYSER(1, read(-1, &tmp, 1), -1, EBADF); break;
+		CASE_TEST(rmdir_blah);        EXPECT_SYSER(1, rmdir("/blah"), -1, ENOENT); break;
 		CASE_TEST(sched_yield);       EXPECT_SYSZR(1, sched_yield()); break;
 		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0 }; select(0, NULL, NULL, NULL, &tv); })); break;
 		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
-- 
2.25.1

