Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFB7735B9D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 17:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjFSPzA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 11:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjFSPyx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 11:54:53 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E79188;
        Mon, 19 Jun 2023 08:54:52 -0700 (PDT)
X-QQ-mid: bizesmtp88t1687190077tbbjb744
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 23:54:36 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 7jw2iSiCazrClih7lQSw1lHt5a5sEA2WAD1UMQ9RMYxH4lPlMP9RlLSFyxJtv
        j+1aODH0kfVvVUG+Hy8dMmNAmWCFvsk7cZphwRrkAIZmNzeRcqbsnR/b9YWp4mLgpZYF8ld
        1Z2z/0qDH1rmprRPceUvjzkuQXRO5Dnej7ew6HFEXPKN76cwi5AkJzV4Piq3D1EF4ZqlAgb
        J0QjvClC5shv0UDB2arUdlC8rfhsKGMNY9guCj6qdEvcw1uJFuz9xx6PEb4iLKZBwtyNtiA
        9QJE/Iu05lxs6gtg6Q0YYXvOdh+oKy6Jy6Ckk5ArTaEIK5YorKlbnR/0/zKNqR5/pxE+LAy
        83PDzWkqpozLdwmYpDUci7RfDcCowkFAAhvNqPTgaagQ0fEoys/YTJD6UYrAA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2291941404729433177
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     david.laight@aculab.com, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v4 09/10] selftests/nolibc: add sbrk_0 to test current brk getting
Date:   Mon, 19 Jun 2023 23:54:15 +0800
Message-Id: <105b488a94953ec8e7b4555bbc89c8e5a17e2c8f.1687187451.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687187451.git.falcon@tinylab.org>
References: <cover.1687187451.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From musl 0.9.14 (to the latest version 1.2.3), both sbrk() and brk()
have almost been disabled for they conflict with malloc, only sbrk(0) is
still permitted as a way to get the current brk, let's support such
case.

EXPECT_PTRNE() is used to expect sbrk() always successfully getting the
current brk.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 34af802dadfd..80ab29e2887c 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -630,6 +630,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(kill_0);            EXPECT_SYSZR(1, kill(getpid(), 0)); break;
 		CASE_TEST(kill_CONT);         EXPECT_SYSZR(1, kill(getpid(), 0)); break;
 		CASE_TEST(kill_BADPID);       EXPECT_SYSER(1, kill(INT_MAX, 0), -1, ESRCH); break;
+		CASE_TEST(sbrk_0);            EXPECT_PTRNE(1, sbrk(0), (void *)-1); break;
 		CASE_TEST(sbrk);              if ((p1 = p2 = sbrk(4096)) != (void *)-1) p2 = sbrk(-4096); EXPECT_SYSZR(1, (p2 == (void *)-1) || p2 == p1); break;
 		CASE_TEST(brk);               EXPECT_SYSZR(1, brk(sbrk(0))); break;
 		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); break;
-- 
2.25.1

