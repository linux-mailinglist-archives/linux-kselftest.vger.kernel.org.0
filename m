Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB05170AD4B
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 May 2023 11:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjEUJh1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 May 2023 05:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjEUJhH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 May 2023 05:37:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB97124;
        Sun, 21 May 2023 02:36:49 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1684661803;
        bh=KkdsW9VXfNNBI6sP0ntlx33DPNCyB2uOxDEqiGEf2wU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=RdpfqaQoyGQXLZ4oSh4gSS+fa4ntLUJSJ+BTBwKdA+ZohbITgg7DP4w6h/Rvnfq5R
         Lqo4qICVTQGNvwcYUitfO7CRTCoMDHx64OoX/jV66bQOrbJAPUmtIZAXOe8dJtAvP1
         LFr5kgG6Vu554SvJ2nNgIFHASIJgCCWujtCD4Ak8=
Date:   Sun, 21 May 2023 11:36:33 +0200
Subject: [PATCH 5/7] tools/nolibc: reformat list of headers to be installed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230521-nolibc-automatic-stack-protector-v1-5-dad6c80c51c1@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684661802; l=1064;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=KkdsW9VXfNNBI6sP0ntlx33DPNCyB2uOxDEqiGEf2wU=;
 b=HmqDEXUj86k+sCTx7kSFyyZmSkwOFjknXc2XT/iZXgF9ShYYJ+3e3o9ak9JftRvYgatJUZAZ9
 erlY0GjTc2QCCoJU5J7KOTchwQ0j6e0q00Qivlm5cdviCW8McaI2uSo
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

This makes it easier to add and remove more entries in the future
without creating spurious diff hunks.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 9839feafd38a..e37c3ac86e23 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -25,8 +25,22 @@ endif
 
 nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
 arch_file := arch-$(nolibc_arch).h
-all_files := ctype.h errno.h nolibc.h signal.h stackprotector.h std.h stdint.h \
-             stdio.h stdlib.h string.h sys.h time.h types.h unistd.h
+all_files := \
+		ctype.h \
+		errno.h \
+		nolibc.h \
+		signal.h \
+		stackprotector.h \
+		std.h \
+		stdint.h \
+		stdlib.h \
+		string.h \
+		sys.h \
+		time.h \
+		types.h \
+		unistd.h \
+		stdio.h \
+
 
 # install all headers needed to support a bare-metal compiler
 all: headers

-- 
2.40.1

