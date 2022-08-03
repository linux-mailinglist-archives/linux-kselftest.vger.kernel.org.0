Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2982658930C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 22:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbiHCUOX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 16:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbiHCUOW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 16:14:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1FF4E86B;
        Wed,  3 Aug 2022 13:14:21 -0700 (PDT)
Received: from localhost.localdomain (92.40.178.37.threembb.co.uk [92.40.178.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E86BD66017FE;
        Wed,  3 Aug 2022 21:14:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659557658;
        bh=tabkDjgdyw2xBTyi9xcIpJHbuW1UrDhBK1x+ki9o6ZM=;
        h=From:To:Cc:Subject:Date:From;
        b=QvWsQUzNeyhffDtJ4G0dvV5w50VTfSz0XgJeveb597J1f6azxDYwGtR4npfykBqv0
         pcAakntnog4hv3M/eiRmjHRFrtvpvxJ948Wn8LayWOmdtJBdaL3IR18QOvSygvSMq/
         qHOOmVtwnW5X9qsOBxohmnWH+T5hYNpe4ycNPMlAe4y4oUekY4TcXpVEbtV68SFQ3x
         zNL4VMCvAuqw4r+VhEmb5jv4pH8/KyDynLvq4Lxr2uMCX2H+HqJ7jYLHQ+ZJdop1AT
         K8c55HlfExrQoAiZy1ZPOh5y0AlwxWCB3+lEBcUHaCyYskBe6XhZFCjQVPonzbR33I
         rkQ6/GBiA8tzA==
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Guillaume <guillaume.tucker@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH] selftests/landlock: fix broken include of linux/landlock.h
Date:   Wed,  3 Aug 2022 22:13:54 +0200
Message-Id: <a459363217b1847c0f206a5dbdf181cb21cf3d0c.1659557290.git.guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Revert part of the earlier changes to fix the kselftest build when
using a sub-directory from the top of the tree as this broke the
landlock test build as a side-effect when building with "make -C
tools/testing/selftests/landlock".

Reported-by: Mickaël Salaün <mic@digikod.net>
Fixes: a917dd94b832 ("selftests/landlock: drop deprecated headers dependency")
Fixes: f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 tools/testing/selftests/landlock/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
index a6959df28eb0..02868ac3bc71 100644
--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -9,10 +9,13 @@ TEST_GEN_PROGS := $(src_test:.c=)
 TEST_GEN_PROGS_EXTENDED := true
 
 OVERRIDE_TARGETS := 1
+top_srcdir := ../../../..
 include ../lib.mk
 
+khdr_dir = $(top_srcdir)/usr/include
+
 $(OUTPUT)/true: true.c
 	$(LINK.c) $< $(LDLIBS) -o $@ -static
 
-$(OUTPUT)/%_test: %_test.c ../kselftest_harness.h common.h
-	$(LINK.c) $< $(LDLIBS) -o $@ -lcap
+$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h ../kselftest_harness.h common.h
+	$(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)
-- 
2.30.2

