Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB43720E99
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 10:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjFCIBK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 04:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFCIBJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 04:01:09 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812D81B6;
        Sat,  3 Jun 2023 01:01:06 -0700 (PDT)
X-QQ-mid: bizesmtp66t1685779256tfrhwl1v
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 03 Jun 2023 16:00:55 +0800 (CST)
X-QQ-SSF: 00200000000000D0V000000A0000000
X-QQ-FEAT: k0mQ4ihyJQNgkVwygW0yshuGkeM5gEbPP6qD3JPq1MQNFpbusU7tTU0lbB22l
        A/5UcKnooUQIfO7IdU6An49Ew/yF6sQud/gbxCL4QnanhGzK5jwDlyfGoBThAEWl768oPaN
        eBs1jfQtfGszTLv2Ika597BM+IvXXcun0tPnrU6tHzcRc2UZUueBk6bih+duFmLswS5oeaG
        vFxXt7CE38Pel27vLsN2UsJz//tO/rgvA+hJSXSRHAQTde1zwQCX9o42qUvx0BGe+Zs2U5Z
        2CNFuUUZWezBEgy6ORi06eutXif6JZYh+Pnlp3AnWar+2IW0xvGRO9ed1T643iOLM4zGfFm
        dF/cgTkjCgfOoncc6p43EE+tkxQsdBQsYmRC9NXrF1fNybD8O6YFpEQI/CODCNYAvg059yP
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13312987647065387357
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v3 01/12] selftests/nolibc: syscall_args: use generic __NR_statx
Date:   Sat,  3 Jun 2023 16:00:46 +0800
Message-Id: <d61b1251af808b91f79f49e5b9a773141aa86eaf.1685777982.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685777982.git.falcon@tinylab.org>
References: <cover.1685777982.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

    commit a528d35e8bfc ("statx: Add a system call to make enhanced file info available")

It has been supported by all of the platforms since at least from v4.20.

Fixes: 8e3ab529bef9 ("tools/nolibc/unistd: add syscall()")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-riscv/ee8b1f02-ded1-488b-a3a5-68774f0349b5@app.fastmail.com/
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

