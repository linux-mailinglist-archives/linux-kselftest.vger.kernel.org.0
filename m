Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6679870AD48
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 May 2023 11:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjEUJhV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 May 2023 05:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjEUJhH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 May 2023 05:37:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5F7E6;
        Sun, 21 May 2023 02:36:49 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1684661804;
        bh=OtZaR9VeuPmOojjtUgQSBdMGO5O2wKJgryXGtmTqRzI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=qhrhQOOMS89DvZWNK5Af0kDzvUeY+vJnHje0Yv/lqShv8qVQxvPu7lLqOxLdaHDbb
         yg7wwTACqQ699CQiFqiHYVuIpHZfQMKuNwT2AyogjeH4mqTU1vmIvrxFgkdbLkNxF/
         nsk2legjwR2ozCkPxi3xQjS0XL+LYgRhmOHn0l14=
Date:   Sun, 21 May 2023 11:36:35 +0200
Subject: [PATCH 7/7] tools/nolibc: simplify stackprotector compiler flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230521-nolibc-automatic-stack-protector-v1-7-dad6c80c51c1@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684661802; l=1698;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=OtZaR9VeuPmOojjtUgQSBdMGO5O2wKJgryXGtmTqRzI=;
 b=DomoIsmXsRZwQWk0ScmwjLFDuu1dnN26YCXUzo34GqOdYuAtwSgkUrabKkFdr4rSI27UuPoCc
 06iKjlgljDsC3ma9RvH/A7hClYqSQSwPisv/goaAeqLfKemkx+wOWfn
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

Now that nolibc enable stackprotector support automatically when the
compiler enables it we only have to get the -fstack-protector flags
correct.

The cc-options are structured so that -fstack-protector-all is only
enabled if -mstack-protector=guard works, as that is the only mode
supported by nolibc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index bd41102ea299..445c352b1b33 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -76,20 +76,11 @@ else
 Q=@
 endif
 
-CFLAGS_STACKPROTECTOR = -DNOLIBC_STACKPROTECTOR \
-			$(call cc-option,-mstack-protector-guard=global) \
-			$(call cc-option,-fstack-protector-all)
-CFLAGS_STKP_i386 = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_x86_64 = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_arm64 = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_arm = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_mips = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_riscv = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_loongarch = $(CFLAGS_STACKPROTECTOR)
+CFLAGS_STACKPROTECTOR = $(call cc-option,-mstack-protector-guard=global -fstack-protector-all)
 CFLAGS_s390 = -m64
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(call cc-option,-fno-stack-protector) \
+		$(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all)) \
 		$(CFLAGS_STKP_$(ARCH)) $(CFLAGS_$(ARCH))
 LDFLAGS := -s
 

-- 
2.40.1

