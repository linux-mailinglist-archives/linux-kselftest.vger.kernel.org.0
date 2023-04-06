Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFD66DA502
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 23:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjDFVza (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 17:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbjDFVzA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 17:55:00 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF84AD25;
        Thu,  6 Apr 2023 14:54:59 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680818095;
        bh=nDb5IgQ9K96nEIM5nhFtSNKaObd3Bs6yLtAE0MQ90Hc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LPdIVCICDjAuwusY7LmbrPaSbZTK/TY/u3YCKNjEsKW57BDuZYkQnRPmQ+TbO5/op
         JYrIONDqCv7w3T7UwQtSEs2PBWMfvncntAg9sL4p9BOcdYSHcFhGoW7TyIqa8g59gO
         xCmGQQFJP2Vb4TKt0/gLUlmdqpFgpLQ8wsrj0wpA=
Date:   Thu, 06 Apr 2023 21:54:57 +0000
Subject: [PATCH v2 11/11] tools/nolibc: validate C89 compatibility
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-c99-v2-11-c989f2289222@weissschuh.net>
References: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
In-Reply-To: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680818091; l=950;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=nDb5IgQ9K96nEIM5nhFtSNKaObd3Bs6yLtAE0MQ90Hc=;
 b=AAij0njayIdL5IoD/YRXn3KBPMtLUquefELUQwUPjOP+L87s/bKaSI6xndpVU9yLH1h23h4+x
 o/7FTm9oR7RCztrlVIbPHtbzXaQJ447rGHWynoCFACVnyUY715Kc/BS
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To make sure no non-compatible changes are introduced accidentally
validate the language standard when building the tests.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 0cbe13809b37..423d22f353a0 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -83,7 +83,7 @@ CFLAGS_STKP_i386 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_x86_64 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_s390 = -m64
-CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables \
+CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(call cc-option,-fno-stack-protector) \
 		$(CFLAGS_STKP_$(ARCH)) $(CFLAGS_$(ARCH))
 LDFLAGS := -s

-- 
2.40.0

