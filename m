Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641C27155A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 08:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjE3GnN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 02:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjE3GnM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 02:43:12 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D967AB2;
        Mon, 29 May 2023 23:43:09 -0700 (PDT)
X-QQ-mid: bizesmtp82t1685428979t23ocw7f
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 14:42:58 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: QityeSR92A2o5sTwmGCD+PqYMSq7MB3IEE8O3t1qtWOzFpvckQlLvvdZrNOgE
        uarJb402gzy9fGIWVhjEYpQDyVh3pANl+z9B3bRnf03I3oT4Z8IS23/bof7tQtzq8n306zg
        rfkF9nyJz0EwgB6+lRhH48uRW1Yn26Wa63FhSP+VEpWjL4h88ydg+O9QTlN1tjcPMc1t78H
        Lu0IRV35MhW/3iu3iLPjt2I6GN62hUKHRs8usz00u+QHRmd27bfqhcoZ1YUR/uHt3KJZ/Vw
        tQDkvr5b+CSZZca3/Zlcg1e1Kta/IIJVePMt3sGEWhxF7kPE1xfj8pZlQvEA7kEfwwJmTWj
        SiRjvuntBLs2VvV4oWQ47+LPVOAvuJ4gnoct3RfMo8LyztoU7oMHjwGgkJujDhOIhrVpOhd
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9349735140151722294
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 2/2] selftests/nolibc: add sizeof test for the new 64bit data types
Date:   Tue, 30 May 2023 14:42:56 +0800
Message-Id: <d1f4073e1dd9a51be93ea9e14ebd746b312646a4.1685428087.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685428087.git.falcon@tinylab.org>
References: <cover.1685428087.git.falcon@tinylab.org>
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

These test cases are required to make sure the new added data types are
really 64bit based.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 20d184da9a2b..43ce4d34b596 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -721,6 +721,14 @@ int run_stdlib(int min, int max)
 #else
 # warning "__SIZEOF_LONG__ is undefined"
 #endif /* __SIZEOF_LONG__ */
+		CASE_TEST(sizeof_time_t);           EXPECT_EQ(1, 8,                sizeof(time_t)); break;
+		CASE_TEST(sizeof_timespec);         EXPECT_EQ(1, 16,               sizeof(struct timespec)); break;
+#ifdef NOLIBC
+		CASE_TEST(sizeof_itimerspec);       EXPECT_EQ(1, 32,               sizeof(struct itimerspec)); break;
+#endif
+		CASE_TEST(sizeof_timeval);          EXPECT_EQ(1, 16,               sizeof(struct timeval)); break;
+		CASE_TEST(sizeof_itimerval);        EXPECT_EQ(1, 32,               sizeof(struct itimerval)); break;
+		CASE_TEST(sizeof_off_t);            EXPECT_EQ(1, 8,                sizeof(off_t)); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
-- 
2.25.1

