Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7246F74B698
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 20:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjGGSrM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 14:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjGGSrL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 14:47:11 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD91CAC;
        Fri,  7 Jul 2023 11:47:09 -0700 (PDT)
X-QQ-mid: bizesmtp79t1688755620th4o4fq9
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 02:46:59 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: swyrzWPvyR2YsBS+GP8c8VCuAw6ly3u9jQq5KwZxHb0xtgpoYXkfWu3pVJOQ9
        ys+i2xXVpkqyPF3E/3/ARVmgKkgA8+l8q4LWeAGtBEdFmpFqCwlx525QsO2WBpCDOZk1Mzn
        kgNXhK1hobQGI6JixpPn6cJnbpOP8TvkTaR3BXQsnxS1Nmb8mY1aip9nCuKbZqFPKWChQFQ
        3OObuv6i2dVBRM0VU/RXq8oNJiFJn7QE64l+GWPHCsHftDnAnNE69xmnGAXzuMEXz7xfP4b
        B3Fwh9/gx6GQZHK6Afo6oBvlpNd9j7DtMZb0wCrDx1DBtSx3QfpeRzpTkoAvFHz4SSnBFBV
        bHbpt4aZkJFmbmAn4G5huzHV0wwFRSTE6KjrcYT1dKjJjfnqDv3L43cZNyFSQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6858150708780378719
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 18/18] selftests/nolibc: add chmod_argv0 test
Date:   Sat,  8 Jul 2023 02:46:20 +0800
Message-Id: <23f35e7c435e5ff254b2c75239eed0aa4ee36b25.1688750763.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688750763.git.falcon@tinylab.org>
References: <cover.1688750763.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

argv0 is readable and chmodable, let's use it for chmod test, but a safe
umask should be used, the readable and executable modes should be
reserved.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index c74b2af2414e..10247fbbdace 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -706,6 +706,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); chdir(getenv("PWD")); break;
 		CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
 		CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;
+		CASE_TEST(chmod_argv0);       EXPECT_SYSZR(1, chmod(argv0, 0555)); break;
 		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 0555), -1, EPERM); break;
 		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
 		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;
-- 
2.25.1

