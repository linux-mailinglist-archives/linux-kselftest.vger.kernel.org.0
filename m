Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026B6743168
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 02:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjF3AC3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 20:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjF3ACX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 20:02:23 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5B83588;
        Thu, 29 Jun 2023 17:02:21 -0700 (PDT)
X-QQ-mid: bizesmtp73t1688083331t4dhfelf
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 08:02:10 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: eSZ1CZgv+JACTc0WzG4h74YvHe3gYF2XyV6HOEkcVE0utw0p/IA1Z5qToF1SM
        3RioGCvD1BnB7phTtW7YUGkLu/mO4OLtLuJtK9lcbL1Wjv1fHbWItWGhIUokSs7aA1G6RmO
        iWqNAcsY1vABTHLrGflhEGYSlrXuqFUmkROxHdV5zxKFqyPNRDFlkIUjEa7cBj+/1kubjDh
        Vkc21XSo9YgqVB8wJwRykJpc1f4bpDrmIaIHkVbIa70aTwJSs82UHnS1IsSS49VrDbQc8Ew
        MkRPNOwLf+bR2SIpfKT+20lSlA6kQZOH3fsiMHvsH8voRT3tPqDCWobmkXTcRfS2KqpsWQc
        F9+jJROZtG5A/m81h/Tk7Sjl2cCnoGIRIf0+BDU6yZSIX1DdiwNkTwMaTctAw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5863286306713928212
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 14/15] selftests/nolibc: add chmod_tmpfile test
Date:   Fri, 30 Jun 2023 08:01:46 +0800
Message-Id: <02a08c64cd16ea03101e271527c5573453e9195f.1688078605.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688078604.git.falcon@tinylab.org>
References: <cover.1688078604.git.falcon@tinylab.org>
MIME-Version: 1.0
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

allow test chmod with tmpfs even when procfs is not there.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 2e9eaa7efa6e..0ca7d011765a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -719,6 +719,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;
 		CASE_TEST(chmod_net);         EXPECT_SYSZR(proc, chmod("/proc/self/net", 0555)); break;
 		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 0555), -1, EPERM); break;
+		CASE_TEST(chmod_tmpfile);     EXPECT_SYSZR(has_tmpfile, chmod(tmpfile, 0555)); break;
 		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
 		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;
 		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
-- 
2.25.1

