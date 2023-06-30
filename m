Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B583F743DE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 16:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjF3OtV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjF3OtU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 10:49:20 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901F1171E;
        Fri, 30 Jun 2023 07:49:17 -0700 (PDT)
X-QQ-mid: bizesmtp79t1688136546tlj7qf2s
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 22:49:04 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 3M0okmaRx3g9FGi2GrgTbWso5GF6j8mNsD9EEsYEj3ftL3NfDx/gEJX7AasWI
        CPaZaB2hzz3UmKC905zXg3WZwZ/Pw8rlRzBujXkhDTXYkh+YbYwSztk4k6xvNeu9EMYDvqR
        pDfa64sh3NeBr7EAWIkZNcfeZrzAsJypzUp1XO4zgsmJe1AG68vgYEJP26yaLpVilzLQZ9Y
        oO1l2vlTBbypgl1CmH2nZDniqAuJ0zeA+IVhPQrdCwEginvotjXC+2BworCYimBtNJA3G5+
        BcAHRBl+oWwFN04U4O8qGTPLocpyuS8ryGlfskhNRpPNKLYqrWH8iXGH+URyc2u9ZyYPtdN
        /GALQMhWZ5ODi9MtWkTD1/AFWcbPSvLRtXY5Uzf31pL9JmzUf8Cthm5LabQgXgFbZGcNDs/
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 519475413023589342
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 06/14] selftests/nolibc: stat_timestamps: remove procfs dependency
Date:   Fri, 30 Jun 2023 22:48:22 +0800
Message-Id: <b862299c4d09639024cebd64ba4cec04dcbdda6a.1688134400.git.falcon@tinylab.org>
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

'/proc/self/' is a good path which doesn't have stale time info but it
is only available for CONFIG_PROC_FS=y.

When CONFIG_PROC_FS=n, use '/init' for initramfs and '/' for the others.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 94801961740a..3e2e808e06c2 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -582,7 +582,7 @@ static int test_stat_timestamps(void)
 	if (sizeof(st.st_atim.tv_sec) != sizeof(st.st_atime))
 		return 1;
 
-	if (stat("/proc/self/", &st))
+	if (stat("/proc/self/", &st) && stat("/init", &st) && stat("/", &st))
 		return 1;
 
 	if (st.st_atim.tv_sec != st.st_atime || st.st_atim.tv_nsec > 1000000000)
-- 
2.25.1

