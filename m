Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B70720EAF
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 10:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjFCIPL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 04:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjFCIPK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 04:15:10 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AB71B3;
        Sat,  3 Jun 2023 01:15:08 -0700 (PDT)
X-QQ-mid: bizesmtp86t1685780099tqgbsuv9
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 03 Jun 2023 16:14:58 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: r/cTxDoDoiFSJcynUBZ645fSSLznEC5jgi3uRP7p6xwjwJ8yn76kBQYvv1+GG
        iSipIpMWgeICdSXmOhHNqLO/hOb9a5g5856OSS72uk43s6aREo8TPK0o30mBeug9pyUBLrA
        ZiLJ8k7sA6+0MXELj+RZn+XGSSA3Q/ntnx/vUhzeGoY2kBexAX2DklILwcrBfrSx9afdubX
        497b/Fry/Cf0DfK9l+fgBCU+RlJuaZonwfKrkQFZ1LqdSm2vkoorwENzGUUoJWn62agPV3l
        x6N4lgt6iYLXz2z/uvnNqE1SuEJs29gQz+108F2wiJv9flrYxecsaTZHFgzU5qNIgNKyV55
        67KtRV6ZoEdOMjWid/N6HLbKZ6RVvaA0n+W19QwOz6ykH3goDRIarP5h2O/snuiSaYfMmm+
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8443338395293632196
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v3 10/12] selftests/nolibc: remove gettimeofday_bad1/2 completely
Date:   Sat,  3 Jun 2023 16:14:55 +0800
Message-Id: <a94f1adb851938da7693e8eed0927cbe01a74d56.1685777982.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685777982.git.falcon@tinylab.org>
References: <cover.1685777982.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In the clock_gettime / clock_gettime64 syscalls based gettimeofday(),
there is no way to let kernel space 'fixup' the invalid data pointer of
'struct timeval' and 'struct timezone' for us for we need to read
timespec from kernel space and then convert to timeval in user-space
ourselves and also we need to simply ignore and reset timezone in
user-space.

Without this removal, the invalid (void *)1 address will trigger a
sigsegv (signum = 11) signal and stop the whole test.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/linux-riscv/20230528113325.GJ1956@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a1c402ce32f4..bf63fc66e486 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -588,10 +588,6 @@ int run_syscall(int min, int max)
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
 		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
-#ifdef NOLIBC
-		CASE_TEST(gettimeofday_bad1); EXPECT_SYSER(1, gettimeofday((void *)1, NULL), -1, EFAULT); break;
-		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
-#endif
 		CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
-- 
2.25.1

