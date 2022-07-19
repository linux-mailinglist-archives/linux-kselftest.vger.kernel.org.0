Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805BC579134
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 05:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiGSDQE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jul 2022 23:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiGSDQD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jul 2022 23:16:03 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E122A65D1;
        Mon, 18 Jul 2022 20:15:58 -0700 (PDT)
X-QQ-mid: bizesmtp74t1658200549t8zbsz5q
Received: from harry-jrlc.. ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 11:15:35 +0800 (CST)
X-QQ-SSF: 0100000000000030C000000A0000020
X-QQ-FEAT: FsG0r2mBeltI1VOefITHTvE/PeY8tbn3ltQ6K0aV9d4v7CGQwCWh39Xc8V5pQ
        EEp3CltAtiI5WnPcQXKVMYN00hdRdSgu8RZR1iWJdGbLkDECI2Pw/kHhtGA2AaZG8AjkVk4
        w9LM8xK3SwNTYAtqeH9kXH/grJvuRVGbwtkrOustcf+5MfxKJG63pxibFcLYtnQ/aZhcb+Y
        xo2iaEz80p1NKbgrT/duWJpZz3lwbCulU7x+7bqF/xBhTstwSX7DpeZk0OM3RXeZkiQ5e8Q
        +egFq6hii5DWdsYnwFLg29L6tbxKotM0TU0VhbasBtgq5nNnXN80aqCCVUOIw8HnRif3W6b
        Ix8wHL5KJtGTDWOy47PImiPBUkagaMZdSOwyom7apUpOnh2K3xABC8SvUw7kg==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     shuah@kernel.org
Cc:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] selftests:Unneeded semicolon
Date:   Tue, 19 Jul 2022 11:15:33 +0800
Message-Id: <20220719031533.5023-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Unneeded semicolon

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 tools/testing/selftests/timers/nsleep-lat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
index eb3e79ed7b4a..a7ca9825e106 100644
--- a/tools/testing/selftests/timers/nsleep-lat.c
+++ b/tools/testing/selftests/timers/nsleep-lat.c
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

