Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34971572E31
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 08:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiGMGeC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 02:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbiGMGeA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 02:34:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB026EEB6;
        Tue, 12 Jul 2022 23:33:59 -0700 (PDT)
Received: from localhost.localdomain (86.166.5.84.rev.sfr.net [84.5.166.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E7D3A6601A34;
        Wed, 13 Jul 2022 07:33:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657694037;
        bh=Bh/K41wvIG4TPoBcy9qS5NVjHErbM3kSr7yTQO5HdGQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ZkUIHeIvVE+nK75mXrZnTV8XnnkY5xN4jaBLk4AGP1ga7UIw3Gqs/lITrZzNT3NAX
         8nGbdgW0hsaqMfh/+MG2hoOkjwI1dHVD6Yyc8qWSb0GdKxQiT5iFEZr3rwlHIeM6qu
         TDGyoVq8+SI7QUXBheDqtg8ZwH83UTfPwWuyQCVCbpS7xAgfjy3FYtMDZUWDV+XqT/
         g1kTcL8FcZZHnvmDTbvgYJ8IzY2NPJz4tzrO5/tTuu0FKEMxOSzt6jQHhC2cL6epVa
         nsAYJws3pz829E2ZSOyDaKR+FAdGxPI7K4R1MsA/ygcXNtSAoJacJgeBZNdLkSYPT4
         52TgQUTW53RFQ==
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] Makefile: replace headers_install with headers for kselftest
Date:   Wed, 13 Jul 2022 08:33:43 +0200
Message-Id: <a7af58feaa6ae6d3b0c8c55972a470cec62341e5.1657693952.git.guillaume.tucker@collabora.com>
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

Replace headers_install with headers as kselftest uses the header
files from within the kernel tree rather than from a system-wide
installation.

We can still run this directly:

  $ make O=build kselftest-all

and when building from the selftests directory:

  $ make O=build headers
  $ make O=build -C tools/testing/selftests all

Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Reported-by: Masahiro Yamada <masahiroy@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index fb2f3bb53a6b..5c934d16664c 100644
--- a/Makefile
+++ b/Makefile
@@ -1347,10 +1347,10 @@ tools/%: FORCE
 # Kernel selftest
 
 PHONY += kselftest
-kselftest: headers_install
+kselftest: headers
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
 
-kselftest-%: headers_install FORCE
+kselftest-%: headers FORCE
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
 
 PHONY += kselftest-merge
-- 
2.30.2

