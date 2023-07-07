Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06D874B693
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 20:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjGGSoS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 14:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjGGSoR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 14:44:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0722684;
        Fri,  7 Jul 2023 11:44:15 -0700 (PDT)
X-QQ-mid: bizesmtp63t1688755446tq21jiw8
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 02:44:05 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: uGhnJwy6xZK2nzJD+cc5kZhLnCKCdne1Sfn1JdSmLb7re57uLtOqm35U5ddys
        GFLzxnlh1Sxv6m4JRyUpmAa4AIbblGLl2nbv0I7OsuFuxSujLPifjVJnU2WipHjHY77aTAn
        XMCJ3xtv5jkAvnSMwtWG48/N8VTl2MX/ViF1B1zJqPghy6LXYvGq4ZNjVJtY/XuxjwlNHqp
        oJkZJPtS5NCXhYajJbNwoVS4uq2RRHjszfLxMJc0FCnvZcmkwuyLfu59mf2cJ+BThUvUqmP
        3JtWYClB+QxvgFQG6MUHTGZ7ZCatDTbHkalQcS7xZx003ILw4PMM7fmfXkJ88fEadcnCqw1
        0THSH3uA2CMbwSauyKirykkIZd/0j2iyLyqeWk2j2HNDc8hI6S8Mj9qqR6sU48rRqf1YyvU
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6129854655699815004
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 16/18] selftests/nolibc: stat_timestamps: remove procfs dependency
Date:   Sat,  8 Jul 2023 02:43:44 +0800
Message-Id: <c8708f02f9c0bd0e25de4296fed319673ade07ed.1688750763.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688750763.git.falcon@tinylab.org>
References: <cover.1688750763.git.falcon@tinylab.org>
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

When CONFIG_PROC_FS=n, use argv0 instead of '/proc/self', use '/' for the
worst case.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 0ed207495ea6..2065b5b0d171 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -584,7 +584,7 @@ static int test_stat_timestamps(void)
 	if (sizeof(st.st_atim.tv_sec) != sizeof(st.st_atime))
 		return 1;
 
-	if (stat("/proc/self/", &st))
+	if (stat("/proc/self/", &st) && stat(argv0, &st) && stat("/", &st))
 		return 1;
 
 	if (st.st_atim.tv_sec != st.st_atime || st.st_atim.tv_nsec > 1000000000)
-- 
2.25.1

