Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D042670FD2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 19:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbjEXRuB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 13:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjEXRt6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 13:49:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A085F122;
        Wed, 24 May 2023 10:49:54 -0700 (PDT)
X-QQ-mid: bizesmtp84t1684950589taqcvbsf
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 01:49:48 +0800 (CST)
X-QQ-SSF: 00200000000000D0V000000A0000000
X-QQ-FEAT: uGhnJwy6xZIUNwFWUkTcVZC7g8QNyKiY+XzJriACbUL4oqMszlNtgYpAkhLex
        cwihvRwjjgmsdDZeCDPBF1DQ938pSja9bqh13OBnuTww50GACW6NmZRGD621FTL2iQ3QVmZ
        3HkI3ZEvZW3yLng05TVWCIwUhYuPiSBwb0uYCZ2D0qnkqyOSDmeRKNiGa4kRHpIhHm7YHPU
        M+DcW0gUtbzTW69JkDGyC5dTxiYptZzlvCJn1XJGMlllb0F9TAExPLOZnvDJwVcyv4oUI5Y
        ue15DAsGTU3Ke9lTyUtaRF1ixOTRnyGTK0aokkIreZiU8hdYxCiI4zKZzp6KpnUehGaYkIe
        EmHYz1QP6NJqwxJyJLXzjh4+56x/vuIlsuhL/BW/dMwVCVkSckCr2+nK3wZ+NdVB6t/VW7q
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17354439834397082086
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: [PATCH 04/13] selftests/nolibc: syscall_args: use __NR_statx for rv32
Date:   Thu, 25 May 2023 01:48:11 +0800
Message-Id: <b306ae7b53d67acad6d1e2f63d43505d79f81241.1684949267.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684949267.git.falcon@tinylab.org>
References: <cover.1684949267.git.falcon@tinylab.org>
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

When compile nolibc-test.c for rv32, we got such error:

    tools/testing/selftests/nolibc/nolibc-test.c:599:57: error: ‘__NR_fstat’ undeclared (first use in this function)
      599 |   CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT); break;

The generic include/uapi/asm-generic/unistd.h used by rv32 doesn't
support __NR_fstat, use __NR_statx instead:

    Running test 'syscall'
    69 syscall_noargs = 1                                            [OK]
    70 syscall_args = -1 EFAULT                                      [OK]

As tools/include/nolibc/sys.h shows, __NR_statx is either not supported
by all platforms, so, both __NR_fstat and __NR_statx are required.

Btw, the latest riscv libc6-dev package is required, otherwise, we would
also get such error:

    In file included from /usr/riscv64-linux-gnu/include/sys/cdefs.h:452,
                     from /usr/riscv64-linux-gnu/include/features.h:461,
                     from /usr/riscv64-linux-gnu/include/bits/libc-header-start.h:33,
                     from /usr/riscv64-linux-gnu/include/limits.h:26,
                     from /usr/lib/gcc-cross/riscv64-linux-gnu/9/include/limits.h:194,
                     from /usr/lib/gcc-cross/riscv64-linux-gnu/9/include/syslimits.h:7,
                     from /usr/lib/gcc-cross/riscv64-linux-gnu/9/include/limits.h:34,
                     from /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/nolibc-test.c:6:
    /usr/riscv64-linux-gnu/include/bits/wordsize.h:28:3: error: #error "rv32i-based targets are not supported"
       28 | # error "rv32i-based targets are not supported"

The glibc commit 5b6113d62efa ("RISC-V: Support the 32-bit ABI
implementation") fixed up above error, so, glibc >= 2.33 (who includes
this commit) is required.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 227ef2a3ebba..c86ff6018c7f 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -501,6 +501,17 @@ static int test_fork(void)
 	}
 }
 
+static int test_syscall_args(void)
+{
+#ifdef __NR_fstat
+	return syscall(__NR_fstat, 0, NULL);
+#elif defined(__NR_statx)
+	return syscall(__NR_statx, 0, NULL, 0, 0, NULL);
+#else
+#error Neither __NR_fstat nor __NR_statx defined, cannot implement syscall_args test
+#endif
+}
+
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
@@ -597,7 +608,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
 		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
-		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT); break;
+		CASE_TEST(syscall_args);      EXPECT_SYSER(1, test_syscall_args(), -1, EFAULT); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
-- 
2.25.1

