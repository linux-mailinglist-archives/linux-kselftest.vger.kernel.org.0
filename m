Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB50D7E12F0
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 11:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjKEKKN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 05:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjKEKKM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 05:10:12 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF34EE;
        Sun,  5 Nov 2023 02:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699179007;
        bh=Ub0vfkKTHQaxoKQLNxleKQsHEn6st8jde4Faibw+HU4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PHXRxBuygJSjWJJPy7h88sXSdqvzAHV0/Omgiuaxiwb9ilxsJJdh0UlefMW5shctD
         9/i7EYZbjIW6o6v8HxtAomLdvTWLh/yesIjADJX3L9+etj9wzm8+mtMWbfi6R7DRb+
         Ld31aVjeiN+fVY9LEyL/D1RlQGzdpfgaPRnt98js=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 05 Nov 2023 11:09:58 +0100
Subject: [PATCH 4/6] selftests/nolibc: explicitly specify ABI for MIPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231105-nolibc-mips-be-v1-4-6c2ad3e50a1f@weissschuh.net>
References: <20231105-nolibc-mips-be-v1-0-6c2ad3e50a1f@weissschuh.net>
In-Reply-To: <20231105-nolibc-mips-be-v1-0-6c2ad3e50a1f@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699179006; l=1051;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Ub0vfkKTHQaxoKQLNxleKQsHEn6st8jde4Faibw+HU4=;
 b=QtlZAmoS38Wuiigizvm3fQP1+w3wMJyzrNQM7bn8X94d7O9xEW7WEGR+5HV5fWwlwQzFmFAjQ
 nh8xTFIVY2RACsl+i+LPp9mFgMaslo3JGqKbP3aYMDUKrZXengTpbb3
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

More ABIs exist, for better clarity specify it explicitly everywhere.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 15c12f3c27ba..f8fea9fa0263 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -136,7 +136,7 @@ CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
 CFLAGS_s390 = -m64
-CFLAGS_mipso32le = -EL
+CFLAGS_mipso32le = -EL -mabi=32
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
 		$(call cc-option,-fno-stack-protector) \

-- 
2.42.1

