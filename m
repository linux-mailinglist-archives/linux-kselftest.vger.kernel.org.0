Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AB2743DFD
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 16:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjF3O4B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 10:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjF3O4A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 10:56:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90583C35;
        Fri, 30 Jun 2023 07:55:51 -0700 (PDT)
X-QQ-mid: bizesmtp89t1688136942tf8eezrl
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 22:55:41 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: rZJGTgY0+YPl1Ti/yTwBd86Id6oVjQsowhpNx/GMYyB2MOxQs7beAu2rW5Arc
        JT9wcxUF4ckea9ztg2+aZJPJ6y5rv6GwKodyUfioNl992oUArIBDJNNuweEKqFBH+4juqYh
        2AC+Q4u+WZhtkhOM0Dt+Cutc4yyw/Am1mSnvMDzkB3yL/KXghV0cbsCEdBKwIMFkGJwvPWG
        OvyYy5ijguBkR4KFGGS1ZSC6HIGZ2H1NusquSuusiDgpo04NMZuMav+kVwWWq61j0bsGrqw
        O1KyYLxp5ixnzgj88Se3TTQVDmwHtRfylIRHqSxeE9KQ5HaBtoWM9N4xulNDtfTIJ5rcuNJ
        5OZOLEN+QZBkyR7bYuX8dGkljemL698iLRCRU67JRXwizBLOKMCPvfR7amZoFMnFbWytcs4
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15980847344132787065
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 10/14] selftests/nolibc: add a new rmdir() test case
Date:   Fri, 30 Jun 2023 22:55:36 +0800
Message-Id: <1b65441f8f6f115788922459e453e5bf35a4fdf6.1688134400.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688134399.git.falcon@tinylab.org>
References: <cover.1688134399.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 8269f900db76..34a47c512b97 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -737,6 +737,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll((void *)1, 1, 0), -1, EFAULT); break;
 		CASE_TEST(prctl);             EXPECT_SYSER(1, prctl(PR_SET_NAME, (unsigned long)NULL, 0, 0, 0), -1, EFAULT); break;
 		CASE_TEST(read_badf);         EXPECT_SYSER(1, read(-1, &tmp, 1), -1, EBADF); break;
+		CASE_TEST(rmdir_blah);        EXPECT_SYSER(1, rmdir("/blah"), -1, ENOENT); break;
 		CASE_TEST(sched_yield);       EXPECT_SYSZR(1, sched_yield()); break;
 		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0 }; select(0, NULL, NULL, NULL, &tv); })); break;
 		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
-- 
2.25.1


