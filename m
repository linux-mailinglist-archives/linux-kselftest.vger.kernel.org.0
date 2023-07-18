Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD4E7586A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 23:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjGRVNh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 17:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjGRVNg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 17:13:36 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B245219B4;
        Tue, 18 Jul 2023 14:13:13 -0700 (PDT)
X-QQ-mid: bizesmtp63t1689714782trzjin3e
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 05:13:01 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: l1AKOOPZQsd2aCFsuejlNygv+phjrrzDIHE36qpwYCRFFVPb7T6TNOUd714WZ
        V+Eq9b0Q7T1QA85+NfBHTpJmI/t3DNgUsEnfwX+9uSeZ8DVVMD1MoCVJAmEirVXb5bnycmX
        IG0S/sAWuKOgLuoMLpCJyCAKbgSX6/7Y2B3/g9Y+o7Bkqcq4KwKEnsFyrdLRRI5plgb5pcw
        cb3RIj/J84BRFBYO+sknqb4qbSrT7OqAyYsh7elnNOEFikxelUCPbOHg1LxZtbQc4pNubRA
        yZCQulxaGRRjMkCQj+vPoh0+N8meAJrdfnx05uyQv3XpV8BT5rsMcBG7CjJ97NU6LQxC8Si
        BVa5fjFX2BLJAc8qXfML/PYZrQceL2pQnH5rq98cHk+0x/n2Z+x2VUjLkY0Qw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2481483960197194193
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 3/8] selftests/nolibc: select_null: fix up for big endian powerpc64
Date:   Wed, 19 Jul 2023 05:13:01 +0800
Message-Id: <56e91281fde98fb3b2e34986d96870d76ebc3238.1689713175.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689713175.git.falcon@tinylab.org>
References: <cover.1689713175.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The following error reported while running nolibc-test on the big endian
64-bit PowerPC kernel compiled with powerpc64le-linux-gnu-gcc in Ubuntu
20.04.

    56 select_nullinit[1]: illegal instruction (4) at 100042a8 nip 100042a8 lr 100042a8 code 1 in init[10000000+10000]
    init[1]: code: 7c6307b4 7c234840 4081f580 7c6300d0 907d0000 3860ffff 4bfff570 3ca2fffe
    init[1]: code: 38800038 38a5d547 7fc3f378 4bffcd65 <1000038c> 38c10060 38a00000 38800000

Let's explicitly initialize all of the timeval members to zero.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 03b1d30f5507..ec2c7774522e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -858,7 +858,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(read_badf);         EXPECT_SYSER(1, read(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(rmdir_blah);        EXPECT_SYSER(1, rmdir("/blah"), -1, ENOENT); break;
 		CASE_TEST(sched_yield);       EXPECT_SYSZR(1, sched_yield()); break;
-		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0 }; select(0, NULL, NULL, NULL, &tv); })); break;
+		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0, 0 }; select(0, NULL, NULL, NULL, &tv); })); break;
 		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
 		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
 		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
-- 
2.25.1

