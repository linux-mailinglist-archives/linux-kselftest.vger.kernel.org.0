Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3459C332010
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Mar 2021 08:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhCIHt4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Mar 2021 02:49:56 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:36753 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhCIHtu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Mar 2021 02:49:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UR3kKxG_1615276182;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UR3kKxG_1615276182)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 15:49:47 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     john.stultz@linaro.org
Cc:     tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] selftests/timers: remove unneeded semicolon
Date:   Tue,  9 Mar 2021 15:49:41 +0800
Message-Id: <1615276181-27090-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following coccicheck warnings:

./tools/testing/selftests/timers/nanosleep.c:75:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/timers/nanosleep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 71b5441..433a096 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -72,7 +72,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
-- 
1.8.3.1

