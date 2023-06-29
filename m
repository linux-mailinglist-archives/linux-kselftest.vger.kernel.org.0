Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC8474315B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 01:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjF2XvU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 19:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjF2XvT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 19:51:19 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3592D56;
        Thu, 29 Jun 2023 16:51:10 -0700 (PDT)
X-QQ-mid: bizesmtp83t1688082660twu7a8ef
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 07:50:58 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: D2GZf6M6C/i23X3okTEDyY7sY3qClIpPp5F6NuS/AEEIAEVpfzZOlfZdTUae/
        8CfRQul6j18UQzkvZt4EsG5DY7/jNUNQinzpFR6x/BTidUBNAu9H2aVgrxP7o2Q7pS7SCfg
        w5kxfiqw3cg2/Olv9TybUurx+SRkjOzWzeDs/NRYj3Q5/ToQPoACfSxqmES7ywPwYJabr2g
        0g6EM//dSBgtZRsUVY5Bc4/1Vw1kaRxeEiQ7/prMFw7/U1s7lOJqskt9aYv3ariLgg5Q8t/
        KW9cw0ditY8PZiICS5z9ENmLuWC56RUovXsksri2oZLW9rd07Bvtrx0qYtrw3KdX2junOQT
        +7T0Y8lW34Z+6nDzkXxM9rGwCchPB4d3xzAqiL5qMR17heqzC0iW53NX0FHnQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18297835509952804073
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 10/15] selftests/nolibc: fix up failures when CONFIG_PROC_FS=n
Date:   Fri, 30 Jun 2023 07:49:42 +0800
Message-Id: <dc306c108c6bb83dc4dde6b973c0e41c81b3da98.1688078605.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688078604.git.falcon@tinylab.org>
References: <cover.1688078604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For CONFIG_PROC_FS=n, the /proc is not mountable, but the /proc
directory has been created in the prepare() stage whenever /proc is
there or not.

so, the checking of /proc in the run_syscall() stage will be always true
and at last it will fail all of the procfs dependent test cases, which
deviates from the 'cond' check design of the EXPECT_xx macros, without
procfs, these test cases should be skipped instead of failed.

To solve this issue, one method is checking /proc/self instead of /proc,
another method is removing the /proc directory completely for
CONFIG_PROC_FS=n, we apply the second method to avoid misleading the
users.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 2725d3dbfaf0..c0f5302ada5d 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1047,8 +1047,11 @@ int prepare(void)
 
 	/* try to mount /proc if not mounted. Silently fail otherwise */
 	if (stat("/proc/.", &stat_buf) == 0 || mkdir("/proc", 0755) == 0) {
-		if (stat("/proc/self", &stat_buf) != 0)
-			mount("/proc", "/proc", "proc", 0, 0);
+		if (stat("/proc/self", &stat_buf) != 0) {
+			/* If not mountable, remove /proc completely to avoid misuse */
+			if (mount("none", "/proc", "proc", 0, 0) != 0)
+				rmdir("/proc");
+		}
 	}
 
 	return 0;
-- 
2.25.1

