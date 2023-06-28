Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BE9741204
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjF1NMh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:12:37 -0400
Received: from bg4.exmail.qq.com ([43.155.65.254]:43529 "EHLO
        bg4.exmail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjF1NMf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:12:35 -0400
X-QQ-mid: bizesmtp82t1687957941t9p5g4ui
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:12:19 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3gc349QTkQ7SU6ffMdAH/eQrZxvNwomvXA+s018/A5CbPdqWJXSW
        bsMr2cGgOsXAIGORzyCtAvwWtBM3WGjAIgeGNA5LwvZ7A0C3R/qatX7x0uOqiKPa+jnPPoR
        L6O/pCd7cphqFeTZFLjidIzWD70WfHXKJkoZbFrK5HGGqwJhJ/py1h1SDopPrTdtcEcqOQv
        lRFN4dnH3wRAXA5a/sh6SEb0XzJiezI5dXuqOf2Nb2WVPqg39e1NbRSSCT8G10sKwrTgS7D
        X5lHIUSGZX1OYsAM301CgLDgmN8KE+ZBq6zQ8OW3OC/MoqsucGHLIKLSmODCnkZ9jTTZOpI
        AzADRoZVbljpu1ByHxS64uX+TfoCxi6lPdMSMwN
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10617112051867632203
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v5 02/14] tools/nolibc: unistd.h: apply __sysret() helper
Date:   Wed, 28 Jun 2023 21:11:44 +0800
Message-Id: <d6dea45987fda7edc0bdc3a1f6865ab8edd3cfd8.1687957589.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687957589.git.falcon@tinylab.org>
References: <cover.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use __sysret() to shrink the whole _syscall() to oneline code.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/unistd.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index 0e832e10a0b2..fabc846f797b 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -56,16 +56,7 @@ int tcsetpgrp(int fd, pid_t pid)
 	return ioctl(fd, TIOCSPGRP, &pid);
 }
 
-#define _syscall(N, ...)                                                      \
-({                                                                            \
-	long _ret = my_syscall##N(__VA_ARGS__);                               \
-	if (_ret < 0) {                                                       \
-		SET_ERRNO(-_ret);                                             \
-		_ret = -1;                                                    \
-	}                                                                     \
-	_ret;                                                                 \
-})
-
+#define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
 #define _syscall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
 #define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
 #define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
-- 
2.25.1

