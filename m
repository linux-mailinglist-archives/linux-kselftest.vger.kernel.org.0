Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C658A5790F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 04:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiGSClG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jul 2022 22:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiGSCk6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jul 2022 22:40:58 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B034230563;
        Mon, 18 Jul 2022 19:40:50 -0700 (PDT)
X-QQ-mid: bizesmtp90t1658198440to8icm5y
Received: from harry-jrlc.. ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 10:40:32 +0800 (CST)
X-QQ-SSF: 0100000000000030C000000A0000020
X-QQ-FEAT: PmqGvGyLYjCfW0gTB+1gUNTalk25ka+9yQ4e4ZPKNIayCW/d5+lYRLeMovNq7
        gKYmLrOrbbSX3dB+88GzhvvoBwNU9Nem1tVxm08pVyHX6aPpNvD49sVk3J8+PPbNJtk4LmQ
        u6DdQlu9B+WuxMu4zVoF4T+8XPGbHElQtE5uiDNxiLtFoeRjhok+vTTs8qbIHS6Jdzr2wqf
        pfSqOxtwgRHi/+Mmwo2j77/D04IlI2e0Sq1B3rN+/SyKA5jZA+6RO6U1OtqGmZwUUNBO9Hp
        7YKO35xAdhmSjduJr6YSzZfjhM+MFwXNSIIRjlRLlYHKwLXKfb+98VEY9dY+riAj2lGY7f7
        VDDnEV87LiYhe14RIs=
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     shuah@kernel.org
Cc:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] selftests:Unneeded semicolon
Date:   Tue, 19 Jul 2022 10:40:30 +0800
Message-Id: <20220719024030.4442-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Unneeded semicolon

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 tools/testing/selftests/timers/nanosleep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 71b5441c2fd9..433a09676aeb 100644
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
2.30.2

