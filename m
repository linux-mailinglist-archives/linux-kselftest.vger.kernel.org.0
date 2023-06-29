Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6399274313A
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 01:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjF2XpP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 19:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjF2Xo6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 19:44:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068843A9E;
        Thu, 29 Jun 2023 16:44:31 -0700 (PDT)
X-QQ-mid: bizesmtp71t1688082237td2r7nrs
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 07:43:57 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 9fp+MOMfZT3B2+27Lz2FTtpHEdP5j3lylTTpTlkY+1W9tYtMODtQHajOyUa+u
        KjzLT8Qc3eQVG5pPIeHgQ5dEURdQ2cV62nDeE9XHkM2MvowgrDTcEq1J+MR+p2lBpjqDlHc
        tmi8mq8yEz4+BD0xkYc1YeDmRD++G0w1cUIY9KI046I1CS8lX0PcziIAYWisMdC9QHlVUwM
        hR+oTfgO3MsLZfc3/7PNuAUYridqhYq4hM/1uuCK1ba9SyEP7nnM6tmkOtQ0vVt/NgPqU3U
        3FHxEbPs/Dv4lcsYnMSZJ+xCqVW1y3+NJe4pF1nK122Bh9r3H7TYDjwy/7O9s3fM9xmypyg
        I3b3Aw9jgd9IHLy+5b7dY2iJnlWWr+OA/fedR4Ss3GD+2BOQy3BrmSl9H/qoA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15543981623249164707
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 07/15] selftests/nolibc: link_cross: use /proc/self/cmdline
Date:   Fri, 30 Jun 2023 07:37:00 +0800
Message-Id: <c792f3a55323a9eb118fd23efbd0e686f8d45185.1688078605.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688078604.git.falcon@tinylab.org>
References: <cover.1688078604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For CONFIG_NET=n, there would be no /proc/self/net, so, use
/proc/self/cmdline instead.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 1d2be52d44a5..0bb222eaafca 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -724,7 +724,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(link_root1);        EXPECT_SYSER(1, link("/", "/"), -1, EEXIST); break;
 		CASE_TEST(link_blah);         EXPECT_SYSER(1, link("/proc/self/blah", "/blah"), -1, ENOENT); break;
 		CASE_TEST(link_dir);          EXPECT_SYSER(euid0, link("/", "/blah"), -1, EPERM); break;
-		CASE_TEST(link_cross);        EXPECT_SYSER(proc, link("/proc/self/net", "/blah"), -1, EXDEV); break;
+		CASE_TEST(link_cross);        EXPECT_SYSER(proc, link("/proc/self/cmdline", "/blah"), -1, EXDEV); break;
 		CASE_TEST(lseek_m1);          EXPECT_SYSER(1, lseek(-1, 0, SEEK_SET), -1, EBADF); break;
 		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
 		CASE_TEST(mkdir_root);        EXPECT_SYSER(1, mkdir("/", 0755), -1, EEXIST); break;
-- 
2.25.1

