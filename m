Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC44714FF5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 21:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjE2Ttl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 15:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjE2Ttk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 15:49:40 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4642E5;
        Mon, 29 May 2023 12:49:35 -0700 (PDT)
X-QQ-mid: bizesmtp83t1685389766t53i55xa
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 03:49:25 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: XBN7tc9DADK11f2bR4vYw8XCXzz6JcjAHYV1K2y5nPxMJB79I1Jp2sCFv3dB8
        iWvFxzDt5ZBO3/bVujU2W+nt/UA864ldEDVdt2QSjJhlfLCFx8a+GtHntrNXKQIP1rHXDuc
        apqK12n9mJIs7Ij9lXeQ69kiq9c3lq2eE9vKtqcVqZll+r1w1FU/+MPq9h6w/YnYjl1dB6X
        KbnN+QNfllARfcvZLB5QUu3mmHuKconJm3cU4J7X+xK9SrGZu64fOOKkE+nelsfVLERS46t
        OnYVaL2SeEnHyq5nNSOCononupQNDSiDFCOk9LaAJZJ+McV6LQll49XPFN7EXqDrFPVxRLz
        l533bTcMwWSQq+ywKl8jP9ZmLqs2PGN6ArqxLYoPsl8Zfca2ltTFw5rTPTkcg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7469899247824790916
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 03/13] selftests/nolibc: waitpid_min: add waitid syscall support
Date:   Tue, 30 May 2023 03:49:14 +0800
Message-Id: <cd9b9f1467f674f7d3f8a005ba54518aabf9481f.1685387484.git.falcon@tinylab.org>
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

waitpid() is based on sys_wait4().

When the first argument is INT_MIN, the wait4 syscall based sys_wait4()
return EFAULT by default, but the waitid syscall based sys_wait4()
return EINVAL in rv32 platform, let's support such case.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index bf63fc66e486..8ba8c2fc71a0 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -616,7 +616,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;
 		CASE_TEST(unlink_blah);       EXPECT_SYSER(1, unlink("/proc/self/blah"), -1, ENOENT); break;
 		CASE_TEST(wait_child);        EXPECT_SYSER(1, wait(&tmp), -1, ECHILD); break;
-		CASE_TEST(waitpid_min);       EXPECT_SYSER(1, waitpid(INT_MIN, &tmp, WNOHANG), -1, ESRCH); break;
+		CASE_TEST(waitpid_min);       EXPECT_SYSER2(1, waitpid(INT_MIN, &tmp, WNOHANG), -1, ESRCH, EINVAL); break;
 		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
 		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
-- 
2.25.1

