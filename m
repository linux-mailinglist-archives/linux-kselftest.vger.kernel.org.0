Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6CB572E37
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 08:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiGMGfT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 02:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiGMGfR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 02:35:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12C4A8526;
        Tue, 12 Jul 2022 23:35:15 -0700 (PDT)
Received: from localhost.localdomain (86.166.5.84.rev.sfr.net [84.5.166.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2E1276601A38;
        Wed, 13 Jul 2022 07:35:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657694114;
        bh=ko+gnbg7O7P7dW9D/N5Lqjcvm4L0iCayu0mdGjwGvqg=;
        h=From:To:Cc:Subject:Date:From;
        b=XTi7VGFX8LxfBC2xgqC9MOWUepPUjodigpCi2VfUsApAKI8Ctz1SZ/YV8gvSHBoch
         6fk5enB95UqaM5yEi5OhUDs2o458J9bmLYIk2S8Wy2vdpiptwSoUaZMlqgtoYs+9D6
         t1ccBxJ7Dx5Dis4vFT7OeNrvXrz24gVz1sR1tX+4ptOqTpjcd0lFL/dvUxp+L1m4Vf
         V2upTGZgZugQ10sZdDsBZnSo0yAzJbxbuwczu5qhfI2ioTZge8F/m6kKDl/4qgYOBX
         YJrpJM4lcLhW4I5GMOkd1Da/NywzdJlkNuWaTg3QUr6NIDJ6saWwjP7ZvVrrr2xHu5
         hwfJ/RlcV4YGw==
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/landlock: drop deprecated headers dependency
Date:   Wed, 13 Jul 2022 08:35:01 +0200
Message-Id: <b79c51ed97219b1c10e2e3f2bcd3269305f0f035.1657694067.git.guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The khdr make target has been removed, so drop it from the landlock
Makefile dependencies as well as related include paths that are
standard for headers in the kernel tree.

Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/landlock/Makefile | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
index 1313e44e8fb9..a6959df28eb0 100644
--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -11,13 +11,8 @@ TEST_GEN_PROGS_EXTENDED := true
 OVERRIDE_TARGETS := 1
 include ../lib.mk
 
-khdr_dir = $(top_srcdir)/usr/include
-
-$(khdr_dir)/linux/landlock.h: khdr
-	@:
-
 $(OUTPUT)/true: true.c
 	$(LINK.c) $< $(LDLIBS) -o $@ -static
 
-$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h ../kselftest_harness.h common.h
-	$(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)
+$(OUTPUT)/%_test: %_test.c ../kselftest_harness.h common.h
+	$(LINK.c) $< $(LDLIBS) -o $@ -lcap
-- 
2.30.2

