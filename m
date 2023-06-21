Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99B373844D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 15:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjFUNCP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 09:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFUNCO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 09:02:14 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1F2E57;
        Wed, 21 Jun 2023 06:02:12 -0700 (PDT)
X-QQ-mid: bizesmtp73t1687352523t66c15a0
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 21:02:02 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: ILHsT53NKPibvyQvvp6lgPNrBJ9TrIOguRRJiNb+93n428pRzDPRiPmUoEoJO
        7uoOFMcJa7vObbtOaqeAGyxKEVn82tPKKZ57jA/Pst6qecfTBHjqcB0JPpMMniwjOt3n3QS
        6U6D1JpbsppF7CtxvnyBIflJDkvUmwhVYVdqGKW68VZgpqS/c34cHZDH7PIYvP8Mgz9U/Hp
        tvXxkP7BoJwW1HMiWZR83VblMBRfj9w/VPxPso5uaYlog4+EzMIcWk9hVYaLJIzmwkS3E28
        t5EIJhPpKCcNP13QZYkYxgcbWLdavPdj93KRoXnUfKBxkVDeUoUDf3UwdG1x/bMjsGzUfYx
        dWZeNNORIEpl5ywH4on67PcH2u3kEDNQdflOz++xGrR7hzgzgjkW38vWIOE5A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14863239959184131679
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 07/17] selftests/nolibc: add a new rmdir() test case
Date:   Wed, 21 Jun 2023 21:01:45 +0800
Message-Id: <187bd4f7b4a611cedee3f2f8db04240a6aba3adb.1687344643.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687344643.git.falcon@tinylab.org>
References: <cover.1687344643.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A new rmdir_blah test case is added to remove a non-existing /blah,
which expects failure with ENOENT errno.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 2ef44176f7a9..9673c338d42e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -612,6 +612,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(lseek_m1);          EXPECT_SYSER(1, lseek(-1, 0, SEEK_SET), -1, EBADF); break;
 		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
 		CASE_TEST(mkdir_root);        EXPECT_SYSER(1, mkdir("/", 0755), -1, EEXIST); break;
+		CASE_TEST(rmdir_blah);        EXPECT_SYSER(1, rmdir("/blah"), -1, ENOENT); break;
 		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
 		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
-- 
2.25.1

