Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECF675B297
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 17:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjGTPag (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 11:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjGTPaf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 11:30:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DE02706;
        Thu, 20 Jul 2023 08:30:11 -0700 (PDT)
X-QQ-mid: bizesmtp63t1689866981t599l9r8
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 20 Jul 2023 23:29:40 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: LE7C6P2vL8QHe4mvvHH0q96A0G++pPLR/aSG1lKbkXa0Wii3Y2PgYRO2VIj+i
        K95p9gZzvt9OcNxb5oKKOkxnjzObylDjH10meNR4fus7qhBQgGMQ9Q1XCQiweJPQa/plE51
        IHyUv22YYyH1AmWZefc2rWcZcxwUKzGYt4BYiJ5GMWvLjjRALlU6552euLerECa23mM63DE
        5fDTEqLrLJMgAOnBdu1rQdaIM+tsB8d3HQEMxBaNl7ictefnj9tBEW2ojNPxJ4G5AQY05A2
        MMCl6LyIdi8uepkpbO/5rATnluIGrEfjInDyZKGT/NOx3nYjSm487MUznpqWlcJ7TOEoetQ
        NWS6d5rO6IxXgYStQMxIj5v65bf3q1QYKXvyFXpD2910T/GKoA=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9125664167204295423
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux@weissschuh.net
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: [PATCH RFC 7/7] selftests/nolibc: proof of concept for TAP output
Date:   Thu, 20 Jul 2023 23:29:40 +0800
Message-Id: <20230720152940.7623-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719-nolibc-ktap-tmp-v1-7-930bd0c52ff1@weissschuh.net>
References: <20230719-nolibc-ktap-tmp-v1-7-930bd0c52ff1@weissschuh.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

The result looks very similar and the change seems not that big, thanks.

I have a generic question: do we need to compile nolibc-test.c
independently or at least let users easily compile nolibc-test.c in the
other places no just in kernel source code, for example, the other libcs
may want to download and compile it directly.

The functions used in this change seems not many, is it able to provide
our clones for them or only provide the clones when we compile them
out-of-kernel.

for example:

    #ifdef NOLIBC_TEST_IN_KERNEL
    /* -DNOLIBC_TEST_IN_KERNEL from Makefile, for future compatibility */
    #include "../kselftest.h"
    #else
    // our clones of the used functions, for standalone usage
    #endif

Best regards,
Zhangjin

> Dirty proof of concept to show how (K)TAP output can look and how it can
> be used.
> 
> Currently test selection is not supported and for simplicity only the
> startup tests are enabled.
> 
> Example output:
> 
> $ ./nolibc-test
>  KTAP version 1
>  1..15
>  ok 1 argc = 1
>  ok 2 argv_addr = <0x7ffdc66173a8>
>  ok 3 argv_environ = <0x7ffdc66173a8>
>  ok 4 argv_total = 1
>  ok 5 argv0_addr = <0x7ffdc6618bca>
>  ok 6 argv0_str = <0x7ffdc6618bca>
>  ok 7 argv0_len = 13
>  ok 8 environ_addr = <0x7ffdc66173b8>
>  ok 9 environ_envp = <0x7ffdc66173b8>
>  ok 10 environ_auxv = <0x7ffdc66173b8>
>  ok 11 environ_total = 271
>  ok 12 environ_HOME = <0x7ffdc6618cc7>
>  ok 13 auxv_addr = <0x7ffdc66174c8>
>  ok 14 auxv_AT_UID = 1000
>  ok 15 auxv_AT_PAGESZ = 4096
>  # Exiting with status 0
>  # Totals: pass:15 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> $ ./libc-test
>  KTAP version 1
>  1..15
>  ok 1 argc = 1
>  ok 2 argv_addr = <0x7ffd5f3d43e8>
>  ok 3 argv_environ = <0x7ffd5f3d43e8>
>  ok 4 argv_total = 1
>  ok 5 argv0_addr = <0x7ffd5f3d5bd0>
>  ok 6 argv0_str = <0x7ffd5f3d5bd0>
>  ok 7 argv0_len = 11
>  ok 8 environ_addr = <0x7ffd5f3d43f8>
>  ok 9 environ_envp = <0x7ffd5f3d43f8>
>  ok 10 environ_auxv # SKIP test_auxv != (void *)-1
>  ok 11 environ_total # SKIP test_auxv != (void *)-1
>  ok 12 environ_HOME = <0x7ffd5f3d5ccb>
>  ok 13 auxv_addr # SKIP test_auxv != (void *)-1
>  ok 14 auxv_AT_UID = 1000
>  ok 15 auxv_AT_PAGESZ = 4096
>  # Exiting with status 0
>  # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:3 error:0
> 
> ./run-all-tests.sh | $SRC/tools/testing/kunit/kunit.py parse
>  [23:47:26] ============================================================
>  [23:47:26] ====================== (15 subtests) =======================
>  [23:47:26] [PASSED] argc = 1
>  [23:47:26] [PASSED] argv_addr = <0x7ffcac1b8bc8>
>  [23:47:26] [PASSED] argv_environ = <0x7ffcac1b8bc8>
>  [23:47:26] [PASSED] argv_total = 1
>  [23:47:26] [PASSED] argv0_addr = <0x7ffcac1b9bd0>
>  [23:47:26] [PASSED] argv0_str = <0x7ffcac1b9bd0>
>  [23:47:26] [PASSED] argv0_len = 11
>  [23:47:26] [PASSED] environ_addr = <0x7ffcac1b8bd8>
>  [23:47:26] [PASSED] environ_envp = <0x7ffcac1b8bd8>
>  [23:47:26] [SKIPPED] environ_auxv
>  [23:47:26] [SKIPPED] environ_total
>  [23:47:26] [PASSED] environ_HOME = <0x7ffcac1b9ccb>
>  [23:47:26] [SKIPPED] auxv_addr
>  [23:47:26] [PASSED] auxv_AT_UID = 1000
>  [23:47:26] [PASSED] auxv_AT_PAGESZ = 4096
>  [23:47:26] ====================== [PASSED] arm64 ======================
>  [23:47:26] ====================== (15 subtests) =======================
>  [23:47:26] [PASSED] argc = 1
>  [23:47:26] [PASSED] argv_addr = <0x7ffdee178188>
>  [23:47:26] [PASSED] argv_environ = <0x7ffdee178188>
>  [23:47:26] [PASSED] argv_total = 1
>  [23:47:26] [PASSED] argv0_addr = <0x7ffdee178bd0>
>  [23:47:26] [PASSED] argv0_str = <0x7ffdee178bd0>
>  [23:47:26] [PASSED] argv0_len = 11
>  [23:47:26] [PASSED] environ_addr = <0x7ffdee178198>
>  [23:47:26] [PASSED] environ_envp = <0x7ffdee178198>
>  [23:47:26] [SKIPPED] environ_auxv
>  [23:47:26] [SKIPPED] environ_total
>  [23:47:26] [PASSED] environ_HOME = <0x7ffdee178ccb>
>  [23:47:26] [SKIPPED] auxv_addr
>  [23:47:26] [PASSED] auxv_AT_UID = 1000
>  [23:47:26] [PASSED] auxv_AT_PAGESZ = 4096
>  [23:47:26] ===================== [PASSED] x86_64 ======================
>  [23:47:26] ====================== (15 subtests) =======================
>  [23:47:26] [PASSED] argc = 1
>  [23:47:26] [PASSED] argv_addr = <0x7ffc16bf3628>
>  [23:47:26] [PASSED] argv_environ = <0x7ffc16bf3628>
>  [23:47:26] [PASSED] argv_total = 1
>  [23:47:26] [PASSED] argv0_addr = <0x7ffc16bf4bd0>
>  [23:47:26] [PASSED] argv0_str = <0x7ffc16bf4bd0>
>  [23:47:26] [PASSED] argv0_len = 11
>  [23:47:26] [PASSED] environ_addr = <0x7ffc16bf3638>
>  [23:47:26] [PASSED] environ_envp = <0x7ffc16bf3638>
>  [23:47:26] [SKIPPED] environ_auxv
>  [23:47:26] [SKIPPED] environ_total
>  [23:47:26] [PASSED] environ_HOME = <0x7ffc16bf4ccb>
>  [23:47:26] [SKIPPED] auxv_addr
>  [23:47:26] [PASSED] auxv_AT_UID = 1000
>  [23:47:26] [PASSED] auxv_AT_PAGESZ = 4096
>  [23:47:26] ===================== [PASSED] riscv64 =====================
>  [23:47:26] ============================================================
>  [23:47:26] Testing complete. Ran 45 tests: passed: 36, skipped: 9
> 
> The output of kunit.py is colored after the test results.
> 
> Not-signed-off
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c    | 121 ++++++++----------------
>  tools/testing/selftests/nolibc/run-all-tests.sh |  22 +++++
>  2 files changed, 63 insertions(+), 80 deletions(-)
> 
