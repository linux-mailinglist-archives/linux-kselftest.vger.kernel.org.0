Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E2D74312B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 01:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjF2XgL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 19:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2XgK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 19:36:10 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3A51713;
        Thu, 29 Jun 2023 16:36:08 -0700 (PDT)
X-QQ-mid: bizesmtp64t1688081757tnqk2bme
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 07:35:56 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 3M0okmaRx3jzXUNZYCjF22Yt5q5NFwMgmhuWKlNMBfQ9f40ThEIsT/5lI1O4U
        WTU+lHNIjWl6hrnW7p4jSjiM7agpdRFqQPOYCLhDNV+lu8Gw8Ix+6NWlvPgvzPOA03J22Hs
        xnOaKbUZegQkWE2vf+3+hpyASl6yde1FbI7BjKOd3RWr64jv3jC7X/FKkiY+gbl0I2iV2vp
        abwjKmGuqvzJszYtKQcASRVuIKUcNRXdwsuK3jMwUIECfGliZDnizInZnNeglxZ0Hh15PpQ
        9Zdle0TebbOIE/kaNpct8qijh366/xn6vycmfsA8M9NqWBuOsRh5KNxHkAp2Lfpk/7q+4HP
        20AiePlmwg77191+LbqegPp1akzdiPRWn4wvBFR5rBZWkLxit/0Xzf4+I2sfQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10916663048857480056
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 06/15] selftests/nolibc: stat_timestamps: remove procfs dependency
Date:   Fri, 30 Jun 2023 07:31:33 +0800
Message-Id: <6fae777966cf710321a8d8369a9194e00b72ecf6.1688078605.git.falcon@tinylab.org>
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

'/proc/self/' is a good path which doesn't have stale time info but it
is only available for CONFIG_PROC_FS=y.

For CONFIG_PROC_FS=n, Let's try '/init' for initramfs and '/' for the
others.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 223c00e83abf..1d2be52d44a5 100644
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

