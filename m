Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8DB70AD46
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 May 2023 11:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjEUJhU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 May 2023 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjEUJhH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 May 2023 05:37:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B9C109;
        Sun, 21 May 2023 02:36:46 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1684661803;
        bh=lj2geLr/EdywhNVRdZihjVutdtlzdrTLYrnqWuCaRHI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cFDVWF4VRJK30uYLVDvSQLOKcqHfOapaHKy+uCiYEHV8joFGCP1VNLTw5YTPsrZdu
         tKcAKkoYbj7IucjFJRilU2Xdy+lRiSR3cTBsitu86G2g61qPlvLRSWYVEYyWSjooCV
         85iXyDnx1wO3gM4uzxU1VGrjVCV4siMhkPC8TJwY=
Date:   Sun, 21 May 2023 11:36:30 +0200
Subject: [PATCH 2/7] tools/nolibc: x86_64: disable stack protector for
 _start
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230521-nolibc-automatic-stack-protector-v1-2-dad6c80c51c1@weissschuh.net>
References: <20230521-nolibc-automatic-stack-protector-v1-0-dad6c80c51c1@weissschuh.net>
In-Reply-To: <20230521-nolibc-automatic-stack-protector-v1-0-dad6c80c51c1@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684661802; l=1079;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=lj2geLr/EdywhNVRdZihjVutdtlzdrTLYrnqWuCaRHI=;
 b=JVbhHarzeBvvcx5vDuAxt69sG68MA2ijZHbow7ctpQ1HKfKs70ByaOsPMJGeyj+rVqnfqQVyk
 1O4/8Fg7pOIBbY4WpL5JP7Mj+mvvpxTiEIflujBujsb3if9KDfDQVZN
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This was forgotten in the original submission.

It is unknown why it worked for x86_64 on some compiler without this
attribute.

Reported-by: Willy Tarreau <w@1wt.eu>
Closes: https://lore.kernel.org/lkml/20230520133237.GA27501@1wt.eu/
Fixes: 0d8c461adbc4 ("tools/nolibc: x86_64: add stackprotector support")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-x86_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index d98f6c89d143..e201af15e142 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -190,7 +190,7 @@ const unsigned long *_auxv __attribute__((weak));
  * 2) The deepest stack frame should be zero (the %rbp).
  *
  */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
 {
 	__asm__ volatile (
 #ifdef NOLIBC_STACKPROTECTOR

-- 
2.40.1

