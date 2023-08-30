Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AF478DBC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbjH3Shi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245303AbjH3PHX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 11:07:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A135B1A3;
        Wed, 30 Aug 2023 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693408036;
        bh=Xgp/Sfptd9jpyjywWiXrXHLawX5jayOTlAK64aJOzLU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QdEuQ+5ZOv6Rp138bQNGOc+hSqRvrIvmQ1DT6bRibhaEY+rnLvGJIztHA1Or2lEje
         n3jdgyOU1Xa7XvQz7L6yv3BBqds8jhu4FypaYeaAhmZ5E6OSAzAp3IRFpS/vjGN6jB
         hQdD+PPN1fzNGwnFuGzlJt437yeoP9LLXTduT1go=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 30 Aug 2023 17:07:13 +0200
Subject: [PATCH v2 2/2] selftests/nolibc: use -nostdinc for nolibc-test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230830-nolibc-nostdinc-v2-2-c5b1387b4a77@weissschuh.net>
References: <20230830-nolibc-nostdinc-v2-0-c5b1387b4a77@weissschuh.net>
In-Reply-To: <20230830-nolibc-nostdinc-v2-0-c5b1387b4a77@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, Yuan Tan <tanyuan@tinylab.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693408035; l=849;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Xgp/Sfptd9jpyjywWiXrXHLawX5jayOTlAK64aJOzLU=;
 b=Dc9hL0LMEkss2c9eMh/RAVONEIMrf3J8gsydIve0CGvKGilsLpclGAtc2KbZYVcjbPCpWWaDl
 RLiKxBCKm0oCl057HRNlYqOjikFNnxz3TAgppEr3ibg5WU7EU7B1fhl
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Avoid any accidental reliance on system includes.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index dfe66776a331..689658f81a19 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -170,7 +170,7 @@ sysroot/$(ARCH)/include:
 ifneq ($(NOLIBC_SYSROOT),0)
 nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
-	  -nostdlib -static -Isysroot/$(ARCH)/include $< -lgcc
+	  -nostdlib -nostdinc -static -Isysroot/$(ARCH)/include $< -lgcc
 else
 nolibc-test: nolibc-test.c
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \

-- 
2.42.0

