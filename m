Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC9E61DBC0
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Nov 2022 16:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiKEP7Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Nov 2022 11:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEP7P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Nov 2022 11:59:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92140F581;
        Sat,  5 Nov 2022 08:59:13 -0700 (PDT)
X-QQ-mid: bizesmtp78t1667663944t6bkrnyh
Received: from localhost.localdomain ( [182.148.13.29])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Nov 2022 23:58:56 +0800 (CST)
X-QQ-SSF: 01000000002000D0E000B00A0000000
X-QQ-FEAT: Qib4UA9Xm7q5osBZryMvif+5CjZZEeJ/P3uRYRiY4zC8PW/Sm/T75vEbfEBYn
        Gc6Om7QzKjJGbpVVBJmDZhRB44Frple5pOQ4K6Qu9niJvPgxqYWvjNQbhtg9oOgG2pb3LB5
        CuMiq1htZjZFmJvq/9g0uGhN9YmadtoQVpNJ8wXm31r4K5r76wpJ8/3T5ixGKcK5QDBg6iZ
        Ax5UEjorCuvX7P9wQ6m6x4IHUY4nQL3GHB/PZHxIr+vCH4IParoz0G5tYthSJXNhu5iIGxk
        X5wUT4aEexY1ahhWvWwpsSjgRR4HZTo7/0sMPxexV1gX6tmochBOnVLOn9ZVWakTFINwIJC
        YvJXyTQZMqfZ7KolCvTcOwbW0hxAnTWQ5C/7B4gtL641o59V+6xC6twSln0Mw==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     jstultz@google.com, Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] selftests/timers: Delete unneeded semicolon
Date:   Sat,  5 Nov 2022 11:58:55 -0400
Message-Id: <20221105155855.14342-1-dengshaomin@cdjrlc.com>
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

Delete the unneeded semicolon after curly braces.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 tools/testing/selftests/timers/nanosleep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index df1d03516e7b..34e61507fa1f 100644
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
2.35.1

