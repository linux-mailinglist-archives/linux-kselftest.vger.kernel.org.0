Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F05D76A845
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 07:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjHAFaY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 01:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjHAFaV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 01:30:21 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145031BF1;
        Mon, 31 Jul 2023 22:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690867812;
        bh=K1nxWE0fnm2Rd+ee1CtTMEzoebCOmluJAHtmf4S2JYw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cIt+g1aA+jbm6fXI+/dPh2DuwqkoKOOo4wP+v0r+PducTtkw+/Hva1UQ5XBBBqTPH
         xdjYo7Su6Yf1Dn/C6onQtRLZDAX9APRXi2kFZzWxTu4E8o1G3ASEn/Ecg1F2OS/7wi
         YzmVUoTN8hYPTULKPmDDTqzc3xQe5J+7Kqyoylqg=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 01 Aug 2023 07:30:10 +0200
Subject: [PATCH v2 03/10] tools/nolibc: stdint: use int for size_t on 32bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230801-nolibc-warnings-v2-3-1ba5ca57bd9b@weissschuh.net>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
In-Reply-To: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690867811; l=1072;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=K1nxWE0fnm2Rd+ee1CtTMEzoebCOmluJAHtmf4S2JYw=;
 b=ZyMAlp1fnMw5VR86DHSU2eD2euSXRI/6caWE9TNe6th9+CHufDYJ1f+j9pRXLM9tMXSXEP4Mb
 iQk6ibEQH0oBpfYcs26MtSjoWM0HJzl4CdfjtL5bBv8mVr9Jw/HUmse
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Otherwise both gcc and clang may generate warnings about type
mismatches:

sysroot/mips/include/string.h:12:14: warning: mismatch in argument 1 type of built-in function 'malloc'; expected 'unsigned int' [-Wbuiltin-declaration-mismatch]
   12 | static void *malloc(size_t len);
      |              ^~~~~~

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stdint.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index 4b282435a59a..0f390c3028d8 100644
--- a/tools/include/nolibc/stdint.h
+++ b/tools/include/nolibc/stdint.h
@@ -15,7 +15,11 @@ typedef unsigned int       uint32_t;
 typedef   signed int        int32_t;
 typedef unsigned long long uint64_t;
 typedef   signed long long  int64_t;
+#if __SIZE_WIDTH__ == 64
 typedef unsigned long        size_t;
+#else
+typedef unsigned int         size_t;
+#endif
 typedef   signed long       ssize_t;
 typedef unsigned long     uintptr_t;
 typedef   signed long      intptr_t;

-- 
2.41.0

