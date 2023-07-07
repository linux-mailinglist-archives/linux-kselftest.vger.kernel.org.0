Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E174B668
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 20:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjGGSiH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 14:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGGSiG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 14:38:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D896D2130;
        Fri,  7 Jul 2023 11:38:04 -0700 (PDT)
X-QQ-mid: bizesmtp76t1688755075t7a4e2ih
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 02:37:54 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: ShvZ91UTFj5yB/+Ev38CMV6CIpBprc4qrbbU2hYxpW1GkZvzMatwzYL4FyhsW
        3PRijSlAFL9abUjBsl9bR0EMlSyhRsjaTrNV0VJIz9o2Lu3s/NxlwYtWnq5IZlpkP8qwLGZ
        byyUrdoh7A4uqCtoGF++2PSdPA/ghnEGO55qrfHpYNJR8v0kep7i2XxsZSuOzQpBbMK69ka
        PtjnVo06Ej+OrvisdUcKHfKsWkMhfgkIAsSMqnNV5Jh3OdURa4Ccfkun3cDNHID0Dd9gxM+
        rO728L8eoQTBwez3nXhh7MOx4PQwCd1Yju0SaeD4mkq4bp/B1gSMysr++ZXflvaxUHsCV6A
        wcc8O2OMkrgxrhWjIV49plnXKA5wQaw5nCuXfaraIM5mKFGlDBUp2SaFKsJkw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8013575817692833523
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 12/18] selftests/nolibc: fix up failures when CONFIG_PROC_FS=n
Date:   Sat,  8 Jul 2023 02:37:45 +0800
Message-Id: <563c1ceb201ad95221610ef3a4aaed48640b4e8d.1688750763.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688750763.git.falcon@tinylab.org>
References: <cover.1688750763.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index deff804e0753..5497ee86cf40 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1056,8 +1056,11 @@ int prepare(void)
 
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

