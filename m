Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C1956C025
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jul 2022 20:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbiGHQYh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 12:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239241AbiGHQYM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 12:24:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6E7E2C;
        Fri,  8 Jul 2022 09:23:48 -0700 (PDT)
Received: from tincan.cable.virginm.net (cpc108961-cmbg20-2-0-cust263.5-4.cable.virginm.net [80.5.129.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7775A66019F4;
        Fri,  8 Jul 2022 17:23:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657297425;
        bh=kor1Cms+AMsR/IKJNAddcN3ta7oQeHR4XCGYvZ0Sk20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNhAcg624vgjQZEGtQIkLxdCpHMP4ToBmoJAH8RVjjHSF7/XVgl/IUDtxITQDhHV0
         1hEB46NbhR99RCmfujrzhAidc+G7plD4aCr68zblBaXZVknywTJpE+BXR6pnLhs1Su
         N0YI2i+zFkSEUAAijqUkUa13gDbYYcz3/LQYLqTmsGtdWiNJbByMtAQRCk2/MO4LKi
         ngpxh/6eLkz27XqiKJS7/1rv5G18FRkfHk/26Ci0aeZo+JLNlldw6mcML7i0D054v+
         nk1Z7MRti2+g9ubDAUFReu+dULWnrpaezenFeM7uka7Ag7GvfzrxqbHlyn0ojgPrp4
         GTZ/yUe1cIkZw==
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     kernel@collabora.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/4] selftests: drop khdr make target
Date:   Fri,  8 Jul 2022 17:23:27 +0100
Message-Id: <f06875d5c8162181a5cf62a5c3ae980369d97046.1657296695.git.guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1657296695.git.guillaume.tucker@collabora.com>
References: <cover.1657296695.git.guillaume.tucker@collabora.com>
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

Drop the "khdr" make target as it fails when the build directory is a
sub-directory of the source tree.  Rely on the "headers_install"
target to have been run first instead.

For example, here's a typical error this patch is addressing:

  $ make O=build -j32 kselftest-gen_tar
  make[1]: Entering directory '/home/kernelci/linux/build'
  make --no-builtin-rules INSTALL_HDR_PATH=/home/kernelci/linux/build/usr \
          ARCH=x86 -C ../../.. headers_install
  make[3]: Entering directory '/home/kernelci/linux'
  Makefile:1022: ../scripts/Makefile.extrawarn: No such file or directory

The source directory is determined in the top-level Makefile as ".."
relatively to the "build" directory, but then the kselftest Makefile
switches to "-C ../../.." so "../scripts" then points one level higher
than the source tree e.g. "linux/../scripts" - which fails obviously.
There is no other use-case in the kernel tree where a sub-directory
Makefile tries to call a top-level make target, and it appears this
isn't really a valid thing to do.

Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 tools/testing/selftests/Makefile | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index de11992dc577..619451e82863 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -151,30 +151,7 @@ export KHDR_INCLUDES
 # all isn't the first target in the file.
 .DEFAULT_GOAL := all
 
-# Install headers here once for all tests. KSFT_KHDR_INSTALL_DONE
-# is used to avoid running headers_install from lib.mk.
-# Invoke headers install with --no-builtin-rules to avoid circular
-# dependency in "make kselftest" case. In this case, second level
-# make inherits builtin-rules which will use the rule generate
-# Makefile.o and runs into
-# "Circular Makefile.o <- prepare dependency dropped."
-# and headers_install fails and test compile fails.
-#
-# O= KBUILD_OUTPUT cases don't run into this error, since main Makefile
-# invokes them as sub-makes and --no-builtin-rules is not necessary,
-# but doesn't cause any failures. Keep it simple and use the same
-# flags in both cases.
-# Local build cases: "make kselftest", "make -C" - headers are installed
-# in the default INSTALL_HDR_PATH usr/include.
-khdr:
-ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
-	$(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
-else
-	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$(abs_objtree)/usr \
-		ARCH=$(ARCH) -C $(top_srcdir) headers_install
-endif
-
-all: khdr
+all:
 	@ret=1;							\
 	for TARGET in $(TARGETS); do				\
 		BUILD_TARGET=$$BUILD/$$TARGET;			\
@@ -274,4 +251,4 @@ clean:
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
 	done;
 
-.PHONY: khdr all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean gen_tar
+.PHONY: all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean gen_tar
-- 
2.30.2

