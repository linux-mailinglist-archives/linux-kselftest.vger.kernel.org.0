Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A1C591BDF
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Aug 2022 18:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239967AbiHMQEb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 Aug 2022 12:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbiHMQEa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 Aug 2022 12:04:30 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B77BE20;
        Sat, 13 Aug 2022 09:04:28 -0700 (PDT)
X-QQ-mid: bizesmtp80t1660406658tdadc5re
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 14 Aug 2022 00:04:12 +0800 (CST)
X-QQ-SSF: 0100000000000080H000000A0000020
X-QQ-FEAT: 7L1V3dHhUFO9M2cnAHxOI/5Ec20nw+AmdJKfhRxUPRqg3Elk7O7WLzn+8y9+j
        Iide/B8QvyH7vjTiL/tI8A1NnUS2SkVCHKFEOukgRR4sFjGJ9dDzV0JqfVp3VVvCTm2iSJV
        zF4bBSHm3J7wc++Fbpz8lkmBhXB31NS3lE1gSMLmRxF1WrB6nOypc1gKQjosen/NyXtryw9
        izZ4gbc9+rTiTnjvLe8SoZ5lJKsTGaoV64/6DDjRriw8be1HJF+OA0j+JP2qeQevRwNIrE5
        haYkBmZ2Gh7k4V0WYxs1yq0/OZ6nfpM8Vc+yYixur1AcxgRM5skHYkSdc1sOG58gH15tWyn
        G/2JO5u9ERY1ChBXciNoWS5nw9acaZBoonyoo5k
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     shuah@kernel.org
Cc:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        min tang <tangmin@cdjrlc.com>
Subject: [PATCH] selftests: Unneeded semicolon
Date:   Sun, 14 Aug 2022 00:04:00 +0800
Message-Id: <20220813160400.5636-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is no semicolon after '}' in line 83.

Signed-off-by: min tang <tangmin@cdjrlc.com>
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
2.17.1

