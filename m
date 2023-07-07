Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AD074B68A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 20:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGGSnA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 14:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjGGSmy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 14:42:54 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5B12684;
        Fri,  7 Jul 2023 11:42:51 -0700 (PDT)
X-QQ-mid: bizesmtp78t1688755361teq9xbkx
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 02:42:40 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: CR3LFp2JE4nH57ZbWfbpkynHmLRqBni2IKe5Hryw+3skA19dDY1bF6R4kIxbq
        oqTWzkbWrAXmYcKLOEF7Nysxicv3HEL8I8SurRZeGfKZx8CUXH39S2TX++/GRDf3kTfasZm
        EZNdcgFqqy2mhE4rIszH+lLV+kvqdWqrm7zA4c63RpdsxBPepWxHorukBNQrtdoYXbA37Rm
        RQNe0IY+Y+AS/o+Qmo/YhfA497Ns+5w+RT+c8QgSElqosOf6dUO073FHy4tpVByEWNOPC1Z
        VgGikTFw3EgAxouDFC/cCOyhjGjWg0okvA0i9Nmp40vPReOUvzRJazH+4adv7svGonENGHC
        gmvh9BlWpozE4xCUe9RnGikPEBfK82MxxnbWI+NIPXmc2H2pK9m7bTaB2vkCEfRoqO1H8VX
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4020998193701605089
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 15/18] selftests/nolibc: chdir_root: restore current path after test
Date:   Sat,  8 Jul 2023 02:42:01 +0800
Message-Id: <94cc3448a992e38a0ed22d5089b8a42235db24cb.1688750763.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688750763.git.falcon@tinylab.org>
References: <cover.1688750763.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The PWD environment variable has the path of the nolibc-test program,
the current path must be the same as it, otherwise, the test cases will
fail with relative path (e.g. ./nolibc-test).

Since only chdir_root really changes the current path, let's restore it
with the PWD environment variable.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 494195890e4b..0ed207495ea6 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -703,7 +703,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(sbrk_0);            EXPECT_PTRNE(1, sbrk(0), (void *)-1); break;
 		CASE_TEST(sbrk);              if ((p1 = p2 = sbrk(4096)) != (void *)-1) p2 = sbrk(-4096); EXPECT_SYSZR(1, (p2 == (void *)-1) || p2 == p1); break;
 		CASE_TEST(brk);               EXPECT_SYSZR(1, brk(sbrk(0))); break;
-		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); break;
+		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); chdir(getenv("PWD")); break;
 		CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
 		CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;
 		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 0555), -1, EPERM); break;
-- 
2.25.1

