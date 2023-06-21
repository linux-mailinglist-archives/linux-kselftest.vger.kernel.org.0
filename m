Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A5E738426
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 14:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjFUM4v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 08:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjFUM4u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 08:56:50 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE021AC;
        Wed, 21 Jun 2023 05:56:48 -0700 (PDT)
X-QQ-mid: bizesmtp71t1687352198t3y4p8d8
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 20:56:37 +0800 (CST)
X-QQ-SSF: 00200000000000D0V000000A0000000
X-QQ-FEAT: kW11ei911QIEmMARb2D/9riz1PmfAVjY0VfqkkrlMxEhhNhhOM6Lop7SLtmUf
        wM8PfJZIXzcE8XffnD6KaOQeOPUIUkxe9Nnu0JrvGtyaukJEccdFZmu74ZhjuBWMDlyf/bB
        4psKfa61jl09sqKWt7abjFYCwzUO+BwI9SXCuiLjmYlHyHWoemIaFVlpPiGgv8IMr5n7ET+
        KeAp2NB2XWDWX6thOVS5g0df3C72/7zHaxp4D64GWf1elO0WAU2TDaB2yxfQdteVmxIrRyi
        96Z64UweY4ajqpKnug/miPliEMgg+YM43kA/j4dsGVRiw7pLlS++xC3MajL5tLACqWofxWy
        kB+/1DhGQxhf/42v2D2iq0kru0MySKugpr1MnrhDLEVJNKKF/PkFecRbfqqyA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1937265591445148803
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 03/17] selftests/nolibc: add _LARGEFILE64_SOURCE for musl
Date:   Wed, 21 Jun 2023 20:56:03 +0800
Message-Id: <6b28c488dbbdee2d44d75fffe067feb884865861.1687344643.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687344643.git.falcon@tinylab.org>
References: <cover.1687344643.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 739c9daa91b6..d43116553288 100644
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

