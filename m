Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9C9741213
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 15:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjF1NQl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:16:41 -0400
Received: from bg4.exmail.qq.com ([43.154.54.12]:44540 "EHLO bg4.exmail.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231503AbjF1NQ3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:16:29 -0400
X-QQ-mid: bizesmtp76t1687958175ts14rjnr
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:16:14 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 7YFKcddXagi2DVqxpVhCFo/vBHtMVaf8YdumO5sFURZlqB7s7a6X/9zpcHepq
        iPnG3ViG8HcSLGdZpQrvhSkyOrwOy0h6Y8KUmaU/t7wp1oMA/OcOL4wClUH0CNXRBqMxrMj
        GIC2HanU6i16pKbLA4pUUdIh34XWQG1o6j3DuERi6steSM2QS/B9rNh6xMOJTVS+A7AWUD1
        UfXJVTCTX2iF3kWRfOX254z5xX+/tuKpG6mzKcDKXigvnH0AxzW/a/wbLIkM3T/CMMvsx7C
        wZoPlQgV61dxlMnc65CO5dJ4akf+jSCmbBJTA7K3GFSZ4fsRIRleXmsVgXTncgucLNpMf/b
        89PJ8cHlmQ7V6djTC3psejkdfzrHomVv6U+zM5Q9fR039DUYyUvMNNy+nzUNQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3330608914897829044
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 04/14] tools/nolibc: unistd.h: reorder the syscall macros
Date:   Wed, 28 Jun 2023 21:14:53 +0800
Message-Id: <0e97fc7e36290e729d07e35db27caacb95354d87.1687957589.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687957589.git.falcon@tinylab.org>
References: <cover.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tune the macros in the using order and align most of them.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/unistd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index fabc846f797b..e38f3660c051 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -56,9 +56,9 @@ int tcsetpgrp(int fd, pid_t pid)
 	return ioctl(fd, TIOCSPGRP, &pid);
 }
 
-#define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
-#define _syscall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
 #define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
+#define _syscall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
+#define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
 #define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
 #define syscall(...) _syscall_n(_syscall_narg(__VA_ARGS__), ##__VA_ARGS__)
 
-- 
2.25.1

