Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCCA743114
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 01:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjF2X1Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 19:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjF2X1Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 19:27:24 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD0A1FE7;
        Thu, 29 Jun 2023 16:27:22 -0700 (PDT)
X-QQ-mid: bizesmtp71t1688081232ti5nzs9c
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 07:27:11 +0800 (CST)
X-QQ-SSF: 00200000000000D0W000000A0000000
X-QQ-FEAT: q+EIYT+FhZp1QK6qVIW9/zys5/KvQqS+TKOloNFVdqbJx/9/bvxODLmCOphZz
        y9+f4YPiil1IcYvKMFJp05kBj1sxwVhflNVeqk1yCTzpfMR2Yv2gqiHtlQJDxWUsrO/9Pj3
        WXlKB+g3MsWThlTe5KAmbSDgenTw/b7cG8nJ+q4xC1D7JWNs7FW2Bl/TNcPFS0m1hlrfbQs
        YRptoCHdUObycOZ8PikqrUOT5VZLLcJgcYLQetbfB5hdwO2pZs3Z4t/TZ0PAmpBgcx0PM70
        CFWvfM9isuV0+nkhLbZkdZPk7Y0SYJ7KD+1eSNEfk2iWxGlcD5/62jPSRN4o0KYqgSFGLlz
        4UcPV1x4z8UiIaqIO5kSsHF6Ut5+cYfLev2/gdn3UYcY3avkpnUgt7FUxGott8CbjdolC5t
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1369624537871017279
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 03/15] selftests/nolibc: add _LARGEFILE64_SOURCE for musl
Date:   Fri, 30 Jun 2023 07:26:57 +0800
Message-Id: <7486b55751e388b7c532246f068a77a187f0abc0.1688078605.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688078604.git.falcon@tinylab.org>
References: <cover.1688078604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 785b1f4cbdc5..29c21880a198 100644
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

