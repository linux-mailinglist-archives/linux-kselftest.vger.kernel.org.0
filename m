Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5150B7214D8
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 07:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjFDFiI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 01:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDFiH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 01:38:07 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F690CE;
        Sat,  3 Jun 2023 22:38:05 -0700 (PDT)
X-QQ-mid: bizesmtp91t1685857075t2knx7k6
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 04 Jun 2023 13:37:54 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: qTKqCPEPPMCMusprEIJpvMeXnrP/Pg47ltBveugHl56AMUwpiPQN+dX7Bx1al
        hyQMy5WOb2iwGqbVG2Vee4E1CJKGTYaPVCKPKX8kD8/yo3tZ2rIeymiY72vSvRoMb27pNEG
        jbtc7RzZOGJhVxHVAMve+71tINCsEp/ZTion6ifg/TNLEPpYBd9LH/w5ADuQNFBURZosfvJ
        q84P945SwQwPVyJeqTGthznnJkaFBxh1lvZinTuthAASHZzYB5dxSii1VjZ0QNeeP5aptOE
        l4sRjOXi7m0tDtf6US/kKjuJkH4SfpZllHn8WRggB3P2ElsmPmnvGNtklXZjXmiFa11fK2N
        83pqciJQiKSs3As+YWzh+KbdwYUfVOkVV+ojkfRpGAYNrxHTeuIvSLLAg2zfw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1136455146398936182
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 2/4] tools/nolibc: unistd.h: apply __syscall_ret() helper
Date:   Sun,  4 Jun 2023 13:36:20 +0800
Message-Id: <b3e791c9c2cd564e1b9b94d61104aa7d69b603c1.1685856497.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685856497.git.falcon@tinylab.org>
References: <cover.1685856497.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

get the return type automatically and use __syscall_ret() to shrink 4
code lines.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/unistd.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index 6773e83c16a0..e4e2b4c09771 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -56,14 +56,10 @@ int tcsetpgrp(int fd, pid_t pid)
 	return ioctl(fd, TIOCSPGRP, &pid);
 }
 
-#define _syscall(N, ...)                                                      \
-({                                                                            \
-	int _ret = my_syscall##N(__VA_ARGS__);                                \
-	if (_ret < 0) {                                                       \
-		SET_ERRNO(-_ret);                                             \
-		_ret = -1;                                                    \
-	}                                                                     \
-	_ret;                                                                 \
+#define _syscall(N, ...)							\
+({										\
+	typeof(my_syscall##N(__VA_ARGS__)) _ret = my_syscall##N(__VA_ARGS__);	\
+	__syscall_ret(_ret);							\
 })
 
 #define _sycall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
-- 
2.25.1

