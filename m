Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09F861DBB3
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Nov 2022 16:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiKEPfT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Nov 2022 11:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiKEPfS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Nov 2022 11:35:18 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E35C76D;
        Sat,  5 Nov 2022 08:35:14 -0700 (PDT)
X-QQ-mid: bizesmtp87t1667662506tmjcg99l
Received: from localhost.localdomain ( [182.148.13.29])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Nov 2022 23:34:58 +0800 (CST)
X-QQ-SSF: 01000000002000D0E000B00A0000000
X-QQ-FEAT: 3adAc7TLCXYUBMAV1nn3K5AMUFdiqLsuGFYml9+EkoHBGpNkwgXmAUGnK6TWk
        LZ7t+oeMTWB9W66CwuV29DfXx2z+jwaid80G+iGwladtelTZRHmyog9pa8kYVOgeKnZ+2ju
        N7Q8Cu6Zj90wCunSNKt7BFATXX8mQs87EQN2+j1X4r60v3Cn4ypjeFTrZcaBv1i3JnDx0QE
        jjvoCtg4Gza2VQGbI1IlMHM1Nz68nk+5ZTpRlQUhaWn+KYaREZFofkvO6eJ1pZwGt0B4MJO
        tE1ibg2dVFNZ0xSKUibsLXxqSkm/OLtVwc0V4BXJH2xt1I04JvJgEb6Hh6xSHZaIvZlLi66
        X+zd3ojxaCirapZ70n6ddNpRqoUBjtUJs+3A4azzR1zlTpSeRBVeeYqWp6/uQ==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     jstultz@google.com, tglx@linutronix.de, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] selftests: timers: Drop the rebundant semicolon
Date:   Sat,  5 Nov 2022 11:34:57 -0400
Message-Id: <20221105153457.7001-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Drop the unneeded semicolon.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 tools/testing/selftests/timers/set-timer-lat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
index 50da45437daa..d60bbcad487f 100644
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
2.35.1

