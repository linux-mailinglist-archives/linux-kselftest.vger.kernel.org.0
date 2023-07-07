Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A163174B639
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 20:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGGS0u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 14:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjGGS0t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 14:26:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46821FEF;
        Fri,  7 Jul 2023 11:26:47 -0700 (PDT)
X-QQ-mid: bizesmtp77t1688754397ti6mrfex
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 02:26:36 +0800 (CST)
X-QQ-SSF: 00200000000000D0W000000A0000000
X-QQ-FEAT: lO87fmWkX3EaHwlleNUDHGjVqaGc0+ZZIdig5664u8XhYAXp/F/zmRuny3En9
        LeRYrCHxNGL1pIAzgA1hz3p7HWq/VJs+OtPcEMG25UNx023fPX+gKhz5tMcjUN122YhxosM
        uJbkRAva89uNOtOCqakmMEDzb7CQwPHziMhytE6KDm7OJk0hBGVXICW6C/G5OoC6VdGrzQU
        Fj53PhfimB0Kc0NHYhng7GBrqsjhz91v5CW5ix85EaCHjq+R/TZTU9CugGM1yij0DIo0iHD
        LJQY+5niPwdsa/s5o1JGtBtxp2AtsWc8xPCNHLKHhFrhQucD2KYDqmpJwEMmhNGcQZW3MsW
        ZsBfzwsJydwUgFEv12w17X6D+OCGtShoFofmIXP/3/ZvvbROlIOqIpcHGBlvg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5110181960524252780
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 04/18] selftests/nolibc: add _LARGEFILE64_SOURCE for musl
Date:   Sat,  8 Jul 2023 02:26:24 +0800
Message-Id: <0026b19f1f89a27375e8a225baac2f923cd4020b.1688750763.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688750763.git.falcon@tinylab.org>
References: <cover.1688750763.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

_GNU_SOURCE Implies _LARGEFILE64_SOURCE in glibc, but in musl, the
default configuration doesn't enable _LARGEFILE64_SOURCE.

From include/dirent.h of musl, getdents64 is provided as getdents when
_LARGEFILE64_SOURCE is defined.

    #if defined(_LARGEFILE64_SOURCE)
    ...
    #define getdents64 getdents
    #endif

Let's define _LARGEFILE64_SOURCE to fix up this compile error:

    tools/testing/selftests/nolibc/nolibc-test.c: In function ‘test_getdents64’:
    tools/testing/selftests/nolibc/nolibc-test.c:453:8: warning: implicit declaration of function ‘getdents64’; did you mean ‘getdents’? [-Wimplicit-function-declaration]
      453 |  ret = getdents64(fd, (void *)buffer, sizeof(buffer));
          |        ^~~~~~~~~~
          |        getdents
    /usr/bin/ld: /tmp/ccKILm5u.o: in function `test_getdents64':
    nolibc-test.c:(.text+0xe3e): undefined reference to `getdents64'
    collect2: error: ld returned 1 exit status

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index b63afe1975c4..db743144d8f3 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #define _GNU_SOURCE
+#define _LARGEFILE64_SOURCE
 
 /* libc-specific include files
  * The program may be built in 3 ways:
-- 
2.25.1

