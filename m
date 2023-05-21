Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7380470AD4F
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 May 2023 11:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjEUJhX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 May 2023 05:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjEUJhH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 May 2023 05:37:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B762D110;
        Sun, 21 May 2023 02:36:46 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1684661803;
        bh=YXp2m9tgYYm3XozTrNcpFRPq3F1yaY8YO1GDQgtWycY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cuTkVRdFSD8aU1GXz396vgHtB3VNSch92C6kqZT4CsY7NU9Dkk8yeLI5r9BpMlSwv
         c+NT8Q2JxQVi67MNAXm4LGgjGmx8+AZdHWztwK8/SCQYuliuCBiNK6uC77RLVJdkRd
         ECbbHpnAJs0mPpYnRhfWoy61Ori7ZZzSJ+nrQjuM=
Date:   Sun, 21 May 2023 11:36:29 +0200
Subject: [PATCH 1/7] tools/nolibc: fix typo pint -> point
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230521-nolibc-automatic-stack-protector-v1-1-dad6c80c51c1@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684661802; l=911;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YXp2m9tgYYm3XozTrNcpFRPq3F1yaY8YO1GDQgtWycY=;
 b=hXQEK2yzyvKcrsxqvCHHnlybPxqEKT+8f4pT6eqA/4X/1MZFG78E12gDhxYaloJHAY4BeGZ3w
 c4uyKXfeu17Cd4cftB+6y8+NA+RVvZ+myHSirZZyBr1tDhkGJOxFJj3
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

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index 2d5386a8d6aa..82b43935650f 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -7,7 +7,7 @@
  * the syscall declarations and the _start code definition. This is the only
  * global part. On all architectures the kernel puts everything in the stack
  * before jumping to _start just above us, without any return address (_start
- * is not a function but an entry pint). So at the stack pointer we find argc.
+ * is not a function but an entry point). So at the stack pointer we find argc.
  * Then argv[] begins, and ends at the first NULL. Then we have envp which
  * starts and ends with a NULL as well. So envp=argv+argc+1.
  */

-- 
2.40.1

