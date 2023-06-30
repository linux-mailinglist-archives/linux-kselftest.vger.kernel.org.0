Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34514743DFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 16:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjF3O5L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 10:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjF3O5K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 10:57:10 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D75171E;
        Fri, 30 Jun 2023 07:57:08 -0700 (PDT)
X-QQ-mid: bizesmtp82t1688137018tsiqwx7a
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 22:56:57 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: +ynUkgUhZJmKaF5lx43msVOqUOEusgk0PNkqlU5Je21DA28KFEa/NSf3ei5GC
        8ujOyUUh0oJCOeE0bIFeiDv23kIV2OyzhEBlyx6kIfnhlhooHbcSy/KieZ7PlYewN310ono
        eeacy8IX7WzDhYNygHg2pO8NrYhe+qtZ7Be2Maskig39IMsqf7Ggr8eTwX++W402Iv8ztEe
        RyMXx6V38NGtfViJgAGOMrD2l2eKcMLlZRte11ElHDkHXRufUT1IvNk4aMIKMaxkLdhvuko
        9hFzgHQsZTjVVud17s0AueJ7Dss7dKpnbgc2NpObJW3bWFc2K/9zzAJcjIpc+1lMM8Sy7uu
        pUKmL2hKpFuKLE1GrBM5hALFm4CzcgAUraZSdCjO0nzQQDPWrwU2m7OV3iIoOhSZdOhS29e
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7295049176166171116
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 11/14] selftests/nolibc: fix up failures when CONFIG_PROC_FS=n
Date:   Fri, 30 Jun 2023 22:56:46 +0800
Message-Id: <023e07a05e3af211da893e76ae4328983b19882c.1688134400.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688134399.git.falcon@tinylab.org>
References: <cover.1688134399.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 34a47c512b97..b7ea95dad0fb 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1046,8 +1046,11 @@ int prepare(void)
 
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

