Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405CD7A2E57
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Sep 2023 09:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbjIPHO0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Sep 2023 03:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjIPHN5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Sep 2023 03:13:57 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C73CD8;
        Sat, 16 Sep 2023 00:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694848422;
        bh=N0u5CeBhd0jeZ72RH1KvQRJvme7lnR8v86eiHR768eA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=augLYVjbQcljGggD5qeSqYYRU5WC7gfXQEiSnnCrypztUS3jhu2zLHTz/2dS/JyYE
         o+RlvUUAomea51gY787k3m90sbwPo2kWvivjFSoxH6IinQSKPN2KnGqiN3p6z/pijy
         6ntMLymfLzmK329uMjt861kPaOq0RPPQM3U89xgQ=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sat, 16 Sep 2023 09:13:27 +0200
Subject: [PATCH RFC 1/3] kbuild: add toplevel target for usr/gen_init_cpio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230916-nolibc-initramfs-v1-1-4416ecedca6d@weissschuh.net>
References: <20230916-nolibc-initramfs-v1-0-4416ecedca6d@weissschuh.net>
In-Reply-To: <20230916-nolibc-initramfs-v1-0-4416ecedca6d@weissschuh.net>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Willy Tarreau <w@1wt.eu>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694848421; l=887;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=N0u5CeBhd0jeZ72RH1KvQRJvme7lnR8v86eiHR768eA=;
 b=D/hhNRXl2GztEC1PQG3thapDENVP/CxmF97SvrXxLGAzYCCHDXpFLXQBLdh/P/leibxfDH+yN
 5qLcNhqpDb9BB9AnpCG8CBg082F5DayoQ4Wwasi2WdoTwtDoM3J8a0W
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The nolibc testsuite wants to generate an initrams without linking it
into the kernel for which it needs access to gen_init_cpio.
Add a new toplevel target for it so it can be built standalone.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---

Kbuild maintainers:

If there is a way that does not require modification of the toplevel
Makefile that would be nice, too.
I followed the example of the "scripts_unifdef" target.
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index ceb23eed4dce..1caa4429eceb 100644
--- a/Makefile
+++ b/Makefile
@@ -1812,6 +1812,10 @@ endif
 
 endif # KBUILD_EXTMOD
 
+PHONY += usr_gen_init_cpio
+usr_gen_init_cpio:
+	$(Q)$(MAKE) $(build)=usr usr/gen_init_cpio
+
 # ---------------------------------------------------------------------------
 # Modules
 

-- 
2.42.0

