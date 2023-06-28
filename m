Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3255741305
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 15:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjF1NvV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:51:21 -0400
Received: from bg4.exmail.qq.com ([43.155.65.254]:15726 "EHLO
        bg4.exmail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjF1NvI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:51:08 -0400
X-QQ-mid: bizesmtp62t1687960254t1k4fnuc
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:50:52 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: LE7C6P2vL8Rs71HKKnUKI/KsyIrvxJemr+QCXnBO0TehcHy+yUadv9WfiP7BO
        HumbA33LeCmpxXahC9MRtCsLp5durYPTvDlmaJANCO1MTNZEb96K4CiFu4Fl/voUN96haZ9
        ZXcXz4lYzLkh1CGfyBVFfJpuIPMmn7i6aYGvsP138KojvBcs/6/Gnegj72JAAmfLUO2AkYr
        IAf+MrlyOU2tFhoCORLxP8p1gN7+1CNaExSogNRUJPXZSOMYa4w1o2+VKtn7eSCuWW3+Jn7
        QbGg+iWGuMvOZIh1BQHkcnh8BLx3mRLxLqIcBeQ/8bNQkAlB1QJJaoayNC4N6eDso0yW2XO
        LBMnmsTl2FHwwFfqw7qGLOxkdTijLN0URhWT7t/v7RlefDPLcE=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15994507505466130744
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 13/14] selftests/nolibc: add sbrk_0 to test current brk getting
Date:   Wed, 28 Jun 2023 21:46:28 +0800
Message-Id: <f329ca3550f654501390d3fda46889367babfc60.1687957589.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687957589.git.falcon@tinylab.org>
References: <cover.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
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

