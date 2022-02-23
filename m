Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457A64C1BF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 20:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbiBWTQd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 14:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244305AbiBWTQ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 14:16:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12DB4198F;
        Wed, 23 Feb 2022 11:15:57 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id B9D781F44BA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645643756;
        bh=x4JSiCOPtHsEXvsPXBpm2AoOrkiPe4lh9yMOQ/SteAw=;
        h=From:To:Cc:Subject:Date:From;
        b=CWCww7KqR8hxR5Wnu42ftHnZyk8bwfNctTtGtF+/5zFtTCQqgYP54C/4vYbayXpSl
         AjQsJ2OieDO1SXF/fsIgBnOaufeKla0AsZeh9WCbLD5pmxTnthifosiqev843rTsWU
         KOHA/7qXo/OLo/k3631gwv+jZ7gBVABv/QXg+OibsrBt46Ah3aBOPv9FRj1T4LkwDM
         /Gti9b2RmEWomGRkvsRsZoe+dm5zqPENEaiHSmIRDg+9pL0eAkxRuCuich/WUUohsB
         JJc+AKYX+FWPezodQUGiQFIo3/TWgE3RH1zlfflPlo44oJTq3Nt9WNbVyTkY0YmJMe
         s+PI+w5xp++lA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernelci@groups.io, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, keescook@chromium.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Makefile: Fix separate output directory build of kselftests
Date:   Thu, 24 Feb 2022 00:10:15 +0500
Message-Id: <20220223191016.1658728-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Build of kselftests fail if kernel's top most Makefile is used for
running or building kselftests with separate output directory. The
absolute path is needed to reference other files during this kind of
build. Set KBUILD_ABS_SRCTREE to use absolute path during the build. It
fixes the following different types of errors:

make kselftest-all O=/linux_mainline/build
Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory

make kselftest-all O=build
Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
I've tested this patch on top of next-20220217. The latest next-20220222
have missing patches.
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 86f633c2809ea..62b3eb8a102ab 100644
--- a/Makefile
+++ b/Makefile
@@ -1411,10 +1411,10 @@ tools/%: FORCE
 
 PHONY += kselftest
 kselftest:
-	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
+	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests KBUILD_ABS_SRCTREE=1 run_tests
 
 kselftest-%: FORCE
-	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
+	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests KBUILD_ABS_SRCTREE=1 $*
 
 PHONY += kselftest-merge
 kselftest-merge:
-- 
2.30.2

