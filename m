Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EEC74B696
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 20:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGGSp2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 14:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGSp2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 14:45:28 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE522130;
        Fri,  7 Jul 2023 11:45:26 -0700 (PDT)
X-QQ-mid: bizesmtp67t1688755517t6zf8zx8
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 02:45:16 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: Xz3VOcA7Mr23TD+MxBGuqCLuoaQVTw9wn1kX2MooEVE7xaVCf2Ulc9NFyLVp4
        J2s7OzOFoftCwuXSVhAq4XJYt0Bue03Q18ZXrM8uvRsnudoZ58mWFkJz4yNFBkdOXL5xGMy
        CAdhWhwFThY9IuFQswZCjPkQsCMI5iCg0vm8IBYnrufY9/Sj5hImKJsCPCTfn+HK69z3W73
        Vc70g/bvm+n06Lj6Qj0uWrJ6OgXUfrgXjF0YAfROflWkrTqyUmWc4SG0SDCW0ht3EFP6zx6
        ldzx+YG5BRFT+wO2ILNcZQgD0Vyfm2FqutCTFvZPHk4E4pRKB/PaMlMCFT/aeN2VJbws/U1
        g1iL+8qT8tm/WUsZEWokHzfTcNXtuijoW7U4DpiTgajggeXt2exFfunqENitR74BnUWMQRy
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5870997765808739935
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 17/18] selftests/nolibc: chroot_exe: remove procfs dependency
Date:   Sat,  8 Jul 2023 02:45:08 +0800
Message-Id: <beb48fbb26ed15671ef13b80ccbff87fbb3c08b5.1688750763.git.falcon@tinylab.org>
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

Since argv0 also works for CONFIG_PROC_FS=n, let's use it instead of
'/proc/self/exe'.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 2065b5b0d171..c74b2af2414e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -710,7 +710,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
 		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;
 		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
-		CASE_TEST(chroot_exe);        EXPECT_SYSER(proc, chroot("/proc/self/exe"), -1, ENOTDIR); break;
+		CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot(argv0), -1, ENOTDIR); break;
 		CASE_TEST(close_m1);          EXPECT_SYSER(1, close(-1), -1, EBADF); break;
 		CASE_TEST(close_dup);         EXPECT_SYSZR(1, close(dup(0))); break;
 		CASE_TEST(dup_0);             tmp = dup(0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
-- 
2.25.1

