Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53383571495
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jul 2022 10:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiGLI36 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jul 2022 04:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiGLI3z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jul 2022 04:29:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EDA3190A;
        Tue, 12 Jul 2022 01:29:53 -0700 (PDT)
Received: from tincan.cable.virginm.net (cpc108961-cmbg20-2-0-cust263.5-4.cable.virginm.net [80.5.129.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6EF4B6601A24;
        Tue, 12 Jul 2022 09:29:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657614592;
        bh=Z/RhoByoSEAiaAQK6oCVIVGeLmj7WGTmSLfU1UPz9UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OBV5mixNKiQAfRRvGCgSDa/3DNwHchGtr/VXD2aC8Ira92MAdqc/4Wi6w+njwf/9G
         usz0n55nGKHEBEsGV65ZQtsTLqmF9J+WXK2myzw+ombfjyN5qDcP4jwk6zYowXx1U1
         S+gfHYQUN9cizNmIeSHzFQ4XLLRFsmpdOq46eLR0yNo6g1SO+rsTCwOud43alxYhJB
         v3bwqRVO61FIXmcu6KHJX+adipujmd396jcOGUXgBcZVpz3/Zs0NkHo2URkVlyOBIf
         gMwg/jCwLhUdewLo80DtiZdd+88hHTXCi6GMxLMcIlzi5atSLcwmYgMUZl/xu2Wq4g
         dY+YpW6xG53mQ==
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/4] selftests: drop KSFT_KHDR_INSTALL make target
Date:   Tue, 12 Jul 2022 09:29:47 +0100
Message-Id: <4a66bf3227825bbf9007ffc9c10e52fad9ae453f.1657614127.git.guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1657614127.git.guillaume.tucker@collabora.com>
References: <cover.1657614127.git.guillaume.tucker@collabora.com>
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

Drop the KSFT_KHDR_INSTALL make target now that all use-cases have
been removed from the other kselftest Makefiles.

Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 tools/testing/selftests/Makefile |  1 -
 tools/testing/selftests/lib.mk   | 38 --------------------------------
 2 files changed, 39 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 619451e82863..e060777239a4 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -143,7 +143,6 @@ endif
 # Prepare for headers install
 include $(top_srcdir)/scripts/subarch.include
 ARCH           ?= $(SUBARCH)
-export KSFT_KHDR_INSTALL_DONE := 1
 export BUILD
 export KHDR_INCLUDES
 
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 2a2d240cdc1b..df5f853951f2 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -30,45 +30,7 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
-ifdef KSFT_KHDR_INSTALL
-top_srcdir ?= ../../../..
-include $(top_srcdir)/scripts/subarch.include
-ARCH		?= $(SUBARCH)
-
-# set default goal to all, so make without a target runs all, even when
-# all isn't the first target in the file.
-.DEFAULT_GOAL := all
-
-# Invoke headers install with --no-builtin-rules to avoid circular
-# dependency in "make kselftest" case. In this case, second level
-# make inherits builtin-rules which will use the rule generate
-# Makefile.o and runs into
-# "Circular Makefile.o <- prepare dependency dropped."
-# and headers_install fails and test compile fails.
-# O= KBUILD_OUTPUT cases don't run into this error, since main Makefile
-# invokes them as sub-makes and --no-builtin-rules is not necessary,
-# but doesn't cause any failures. Keep it simple and use the same
-# flags in both cases.
-# Note that the support to install headers from lib.mk is necessary
-# when test Makefile is run directly with "make -C".
-# When local build is done, headers are installed in the default
-# INSTALL_HDR_PATH usr/include.
-.PHONY: khdr
-.NOTPARALLEL:
-khdr:
-ifndef KSFT_KHDR_INSTALL_DONE
-ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
-	$(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
-else
-	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$$OUTPUT/usr \
-		ARCH=$(ARCH) -C $(top_srcdir) headers_install
-endif
-endif
-
-all: khdr $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
-else
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
-endif
 
 define RUN_TESTS
 	BASE_DIR="$(selfdir)";			\
-- 
2.30.2

