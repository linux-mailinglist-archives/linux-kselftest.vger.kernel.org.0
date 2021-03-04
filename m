Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DE832CEF4
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Mar 2021 09:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbhCDI5B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Mar 2021 03:57:01 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:42019 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236868AbhCDI4g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Mar 2021 03:56:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UQNwmyl_1614848149;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UQNwmyl_1614848149)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Mar 2021 16:55:54 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     john.stultz@linaro.org
Cc:     tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] selftests: timers: set-timer-lat: remove unneeded semicolon
Date:   Thu,  4 Mar 2021 16:55:48 +0800
Message-Id: <1614848148-16191-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following coccicheck warnings:

./tools/testing/selftests/timers/set-timer-lat.c:83:2-3: Unneeded
semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/timers/set-timer-lat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
index 50da454..d60bbca 100644
--- a/tools/testing/selftests/timers/set-timer-lat.c
+++ b/tools/testing/selftests/timers/set-timer-lat.c
@@ -80,7 +80,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
-- 
1.8.3.1

