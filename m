Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D26176E162
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjHCH27 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjHCH2y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:28:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1ED30D5;
        Thu,  3 Aug 2023 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1691047729;
        bh=K1nxWE0fnm2Rd+ee1CtTMEzoebCOmluJAHtmf4S2JYw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=d3oYr9ZKnj81yRNQs7tguKWRZj+K+kOD9aCvxHPy9sln2oa8ZNdOGxPxAC3ZyE9o8
         6amfOuVyomwybMZoLE5XSQ1VpDwXVFPd25so9KO64tXuyJ8IRl6AtVlAgk/KxCT7Ja
         abX6rrF3TPhctcQVoi5qTqmXXhgxtxC9mIQ2eJgc=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 03 Aug 2023 09:28:49 +0200
Subject: [PATCH v3 05/14] tools/nolibc: stdint: use int for size_t on 32bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230803-nolibc-warnings-v3-5-bcc1a096ae02@weissschuh.net>
References: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
In-Reply-To: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691047727; l=1072;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=K1nxWE0fnm2Rd+ee1CtTMEzoebCOmluJAHtmf4S2JYw=;
 b=c9Cgu8bto58cOlvZooH2C/yq8ewDPwtBzS6vev6ZRrqlH0do7tsxTiV75lYiOPpWXJvbOhhxV
 LWNXjln6xFtC8i/+MTZ4YavCk/Ik+vvihxujZIEb8spYbYMEvi9lw+S
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

