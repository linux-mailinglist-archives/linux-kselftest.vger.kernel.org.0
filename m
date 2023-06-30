Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A463743DCB
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjF3Opb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjF3Opa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 10:45:30 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEC199;
        Fri, 30 Jun 2023 07:45:28 -0700 (PDT)
X-QQ-mid: bizesmtp81t1688136303tkq6bgyc
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 22:45:01 +0800 (CST)
X-QQ-SSF: 00200000000000D0W000000A0000000
X-QQ-FEAT: eSZ1CZgv+JCNNmiaGU+xCx+Rwo8I6Yp2+gMQj7gkCsAkjSccXgiKv0mViWWtQ
        4Dsis6SCLBuuG7h8PbrFr5H6niurTsRSpLvA0m22HVFOIdb1VDnJjE92o9Rg/QunBgTXNh6
        R64hR4VIwoajaEBwaqym8LBpeDshvH5pSmJyvecPk9ST3nEAQoVyyt5pOlF2Ok7mfY+79KY
        4cLKLjEmwDcAIX8HB2TGzWeODijFUj0ERJnabnlqX6XXgUygoSneTU3UUYIdMSHw0GmnTC2
        Gv4fMGhBDJsps6ccLeZUy9qrMk/P2C35ock98RAvKTm43AHc++Sf1A+WvKW7Sgbze05toW3
        SiEzENKQ3ZjzKT9/rzE5DWGB0CgMzpPKs4CrO6cPjDceBzowtlSGOnzoV4WW2d5IPgsHBwB
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 650073420441935089
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 03/14] selftests/nolibc: add _LARGEFILE64_SOURCE for musl
Date:   Fri, 30 Jun 2023 22:44:56 +0800
Message-Id: <c61f64c4d1f69c19b41efae8fef5a94547089ca7.1688134399.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688134399.git.falcon@tinylab.org>
References: <cover.1688134399.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index be7614c897b4..d9644244fc95 100644
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

