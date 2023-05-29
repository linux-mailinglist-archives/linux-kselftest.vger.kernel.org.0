Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37AB714FE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 21:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjE2TrA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 15:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2TrA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 15:47:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD74B7;
        Mon, 29 May 2023 12:46:58 -0700 (PDT)
X-QQ-mid: bizesmtp79t1685389607t80smhoc
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 03:46:46 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: q+EIYT+FhZqztxguIVnnRhTx7mjT8KL3kpkNC9vlw/RJOJQunBpKKt3coh9nS
        b3hqugotci/+9LQaEWn5aWBw66TFgblIOoUHGzmoydkxp1VYBK3Jk0ftC+E+SfP8adRPKNC
        UOsplQSyz0Noa7ioorK0D4V2iSL+p0qOOTecBgsQGIF03PxcS8Wg384BzjdHIzbWaJY6A9P
        goVQyM/uk01ucMbDc8gymFRq/Br7+KWgXOlJbnQnNhcW26+kodAetsOUhrxkRr7H4ylwCrw
        UZsspZLj5FqA/WiT3kx2fAwpok1NcIOqmfOaxha6aU4OOvFLZ3nLptqkzd5wdCMDmGDCCMx
        o54rHau5cEQE7opKNJnlEEdyJKve++VllBqRR/ep/KB8//hCOyKMbqg+HwrLQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 274745737586768442
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 01/13] selftests/nolibc: remove gettimeofday_bad1/2 completely
Date:   Tue, 30 May 2023 03:46:42 +0800
Message-Id: <485fe4e27c1fd1a84d11e9fc47178a48de39263b.1685387484.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685387484.git.falcon@tinylab.org>
References: <cover.1685387484.git.falcon@tinylab.org>
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

In the clock_gettime / clock_gettime64 syscalls based gettimeofday(),
there is no way to let kernel space 'fixup' the invalid data pointer of
'struct timeval' and 'struct timezone' for us for we need to read
timespec from kernel space and then convert to timeval in user-space
ourselves and also we need to simply ignore and reset timezone in
user-space.

Without this removal, the invalid (void *)1 address will trigger a
sigsegv (signum = 11) signal and stop the whole test.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a8fcad801cf2..7be2625f952d 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -582,10 +582,6 @@ int run_syscall(int min, int max)
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

