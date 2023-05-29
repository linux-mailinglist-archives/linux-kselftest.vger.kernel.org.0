Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC097149B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 14:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjE2My4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 08:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2Myz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 08:54:55 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC82B5;
        Mon, 29 May 2023 05:54:51 -0700 (PDT)
X-QQ-mid: bizesmtp68t1685364882tneg2x8d
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 29 May 2023 20:54:41 +0800 (CST)
X-QQ-SSF: 00200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3gSbqUlMdelesQfurP/ax7t3wqfS40b16enwTCNEPD74koH8ri3v
        vF1/Uz8gKhJ6aIWLWeHRJaW+NXsMZon13qE8WY3E+I9olyqaYkmE/3o+f9Qo69tCPQ3O7Km
        Gf35vAVg9cjJVDrHCf6H+AqcGzDVm6L7LVWfChGkYuLculAPsZPMArIO57GsYnjGLqa9Sd/
        CCtlm2mUDcbpjGPdMqU8kHPZ3JH+pXGX/8t9bq4Kc0mZQcjg9Pkf0nriZKmTV2M8Zouw0+f
        emeWCxZi7f6/d6vJKZOSmK6YtQqakQtMlESY48tTRDf4axguS6W+r8GKAl0bW2rejY+5Ck7
        KVPsUKt7pUAHOLUq2CAbKSK9kkHHUz8y+O4aTOT8PHK2TjG2mHsvijHKvl6Dw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11219330658314727703
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 1/7] selftests/nolibc: syscall_args: use generic __NR_statx
Date:   Mon, 29 May 2023 20:54:39 +0800
Message-Id: <e291752517d42d10294d4c1975808d32420a003f.1685362482.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685362482.git.falcon@tinylab.org>
References: <cover.1685362482.git.falcon@tinylab.org>
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

Compiling nolibc-test.c for rv32 got such error:

    tools/testing/selftests/nolibc/nolibc-test.c:599:57: error: ‘__NR_fstat’ undeclared (first use in this function)
      599 |   CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT); break;

The generic include/uapi/asm-generic/unistd.h used by rv32 doesn't
support __NR_fstat, use the more generic __NR_statx instead:

    Running test 'syscall'
    69 syscall_noargs = 1                                            [OK]
    70 syscall_args = -1 EFAULT                                      [OK]

__NR_statx has been added from v4.10:

    a528d35e8bfc ("statx: Add a system call to make enhanced file info available")

It has been supported by all of the platforms since at least from v4.20.

Fixes: 8e3ab529bef9 ("tools/nolibc/unistd: add syscall()")
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 7de46305f419..d417ca5d976f 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -621,7 +621,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
 		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
-		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT); break;
+		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_statx, 0, NULL, 0, 0, NULL), -1, EFAULT); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
-- 
2.25.1

