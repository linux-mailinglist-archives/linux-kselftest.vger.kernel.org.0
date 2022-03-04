Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527A64CD9DE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 18:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbiCDRPD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 12:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbiCDRPB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 12:15:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7781B30B9;
        Fri,  4 Mar 2022 09:14:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E05A61E11;
        Fri,  4 Mar 2022 17:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7FAC340E9;
        Fri,  4 Mar 2022 17:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646414050;
        bh=urMoF0QwA97qglaGPFsx97nYeFm3RG9gjqb6/tJfDDc=;
        h=From:To:Cc:Subject:Date:From;
        b=PKBPuPKAaWGIxbrNogHiLftkPxshMiREjd5Ff8AhUziTua3jzNg6b7V40046Ve52j
         ccF8oJMMrMkqpbP0ynY0hpWoFvZanuQC6kMBJaEFVJwLmAXwB8y/LUbmdfi5h/G8xv
         MrSHguxKcOStPNr6d/k/+noXkqjjewSPvCaY221/hw8HE4zK9sW+1hoH1J8DRI5Eq0
         /naRyTOYklr6Z1SJlsflsf8e+2KwgGL+ZlUf0Xv7MXwahOIdeqZ1Xip9UtLHDWlBGz
         p/sekDMVJd/zZZSdiEXBjZDoA6sbIzTNMtNGgB3lWmkB4+ZYO7P8rhXT/7zJyfmn/Y
         e5sgSB50lKfmA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] kbuild: Make $(LLVM) more flexible
Date:   Fri,  4 Mar 2022 10:08:14 -0700
Message-Id: <20220304170813.1689186-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The LLVM make variable allows a developer to quickly switch between the
GNU and LLVM tools. However, it does not handle versioned binaries, such
as the ones shipped by Debian, as LLVM=1 just defines the tool variables
with the unversioned binaries.

There was some discussion during the review of the patch that introduces
LLVM=1 around versioned binaries, ultimately coming to the conclusion
that developers can just add the folder that contains the unversioned
binaries to their PATH, as Debian's versioned suffixed binaries are
really just symlinks to the unversioned binaries in /usr/lib/llvm-#/bin:

$ realpath /usr/bin/clang-14
/usr/lib/llvm-14/bin/clang

$ PATH=/usr/lib/llvm-14/bin:$PATH make ... LLVM=1

However, that can be cumbersome to developers who are constantly testing
series with different toolchains and versions. It is simple enough to
support these versioned binaries directly in the Kbuild system by
allowing the developer to specify the version suffix with LLVM=, which
is shorter than the above suggestion:

$ make ... LLVM=-14

It does not change the meaning of LLVM=1 (which will continue to use
unversioned binaries) and it does not add too much additional complexity
to the existing $(LLVM) code, while allowing developers to quickly test
their series with different versions of the whole LLVM suite of tools.

Some developers may build LLVM from source but not add the binaries to
their PATH, as they may not want to use that toolchain systemwide.
Support those developers by allowing them to supply the directory that
the LLVM tools are available in, as it is no more complex to support
than the version suffix change above.

$ make ... LLVM=/path/to/llvm/

Update and reorder the documentation to reflect these new additions.
At the same time, notate that LLVM=0 is not the same as just omitting it
altogether, which has confused people in the past.

Link: https://lore.kernel.org/r/20200317215515.226917-1-ndesaulniers@google.com/
Link: https://lore.kernel.org/r/20220224151322.072632223@infradead.org/
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v1 -> v2: https://lore.kernel.org/r/20220302234400.782002-1-nathan@kernel.org/

* Drop Kees and Nick's reviewed-by tags, as there is a substantial logic
  update.

* Only support dash-based suffixes (Masahiro).

* Support passing a path to LLVM, which will be prefixed onto the
  tools (Masahiro).

* Reorder and update documentation for LLVM (Masahiro).

* Reword commit message to reflect new changes.

RFC -> v1: https://lore.kernel.org/r/Yh%2FegU1LZudfrgVy@dev-arch.thelio-3990X/

* Tidy up commit message slightly.

* Add tags.

* Add links to prior discussions for context.

* Add change to tools/testing/selftests/lib.mk.

I would like for this to go through the Kbuild tree, please ack as
necessary.

 Documentation/kbuild/llvm.rst  | 31 +++++++++++++++++++++++++------
 Makefile                       | 26 ++++++++++++++++----------
 tools/scripts/Makefile.include | 22 ++++++++++++++--------
 tools/testing/selftests/lib.mk |  8 +++++++-
 4 files changed, 62 insertions(+), 25 deletions(-)

diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
index d32616891dcf..68b74416ec48 100644
--- a/Documentation/kbuild/llvm.rst
+++ b/Documentation/kbuild/llvm.rst
@@ -49,17 +49,36 @@ example: ::
 LLVM Utilities
 --------------
 
-LLVM has substitutes for GNU binutils utilities. Kbuild supports ``LLVM=1``
-to enable them. ::
-
-	make LLVM=1
-
-They can be enabled individually. The full list of the parameters: ::
+LLVM has substitutes for GNU binutils utilities. They can be enabled individually.
+The full list of supported make variables: ::
 
 	make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
 	  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
 	  HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld
 
+To simplify the above command, Kbuild supports the ``LLVM`` variable: ::
+
+	make LLVM=1
+
+If your LLVM tools are not available in your PATH, you can supply their
+location using the LLVM variable with a trailing slash: ::
+
+	make LLVM=/path/to/llvm/
+
+which will use ``/path/to/llvm/clang``, ``/path/to/llvm/ld.lld``, etc.
+
+If your LLVM tools have a version suffix and you want to test with that
+explicit version rather than the unsuffixed executables like ``LLVM=1``, you
+can pass the suffix using the ``LLVM`` variable: ::
+
+	make LLVM=-14
+
+which will use ``clang-14``, ``ld.lld-14``, etc.
+
+``LLVM=0`` is not the same as omitting ``LLVM`` altogether, it will behave like
+``LLVM=1``. If you only wish to use certain LLVM utilities, use their respective
+make variables.
+
 The integrated assembler is enabled by default. You can pass ``LLVM_IAS=0`` to
 disable it.
 
diff --git a/Makefile b/Makefile
index a82095c69fdd..b3fb32fd3906 100644
--- a/Makefile
+++ b/Makefile
@@ -424,8 +424,14 @@ HOST_LFS_LDFLAGS := $(shell getconf LFS_LDFLAGS 2>/dev/null)
 HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
 
 ifneq ($(LLVM),)
-HOSTCC	= clang
-HOSTCXX	= clang++
+ifneq ($(filter %/,$(LLVM)),)
+LLVM_PREFIX := $(LLVM)
+else ifneq ($(filter -%,$(LLVM)),)
+LLVM_SUFFIX := $(LLVM)
+endif
+
+HOSTCC	= $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
+HOSTCXX	= $(LLVM_PREFIX)clang++$(LLVM_SUFFIX)
 else
 HOSTCC	= gcc
 HOSTCXX	= g++
@@ -444,14 +450,14 @@ KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
 # Make variables (CC, etc...)
 CPP		= $(CC) -E
 ifneq ($(LLVM),)
-CC		= clang
-LD		= ld.lld
-AR		= llvm-ar
-NM		= llvm-nm
-OBJCOPY		= llvm-objcopy
-OBJDUMP		= llvm-objdump
-READELF		= llvm-readelf
-STRIP		= llvm-strip
+CC		= $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
+LD		= $(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX)
+AR		= $(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX)
+NM		= $(LLVM_PREFIX)llvm-nm$(LLVM_SUFFIX)
+OBJCOPY		= $(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX)
+OBJDUMP		= $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
+READELF		= $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
+STRIP		= $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
 else
 CC		= $(CROSS_COMPILE)gcc
 LD		= $(CROSS_COMPILE)ld
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 79d102304470..b507a6a733f5 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -52,11 +52,17 @@ define allow-override
 endef
 
 ifneq ($(LLVM),)
-$(call allow-override,CC,clang)
-$(call allow-override,AR,llvm-ar)
-$(call allow-override,LD,ld.lld)
-$(call allow-override,CXX,clang++)
-$(call allow-override,STRIP,llvm-strip)
+ifneq ($(filter %/,$(LLVM)),)
+LLVM_PREFIX := $(LLVM)
+else ifneq ($(filter -%,$(LLVM)),)
+LLVM_SUFFIX := $(LLVM)
+endif
+
+$(call allow-override,CC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
+$(call allow-override,AR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
+$(call allow-override,LD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
+$(call allow-override,CXX,$(LLVM_PREFIX)clang++$(LLVM_SUFFIX))
+$(call allow-override,STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
 else
 # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
 $(call allow-override,CC,$(CROSS_COMPILE)gcc)
@@ -69,9 +75,9 @@ endif
 CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
 
 ifneq ($(LLVM),)
-HOSTAR  ?= llvm-ar
-HOSTCC  ?= clang
-HOSTLD  ?= ld.lld
+HOSTAR  ?= $(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX)
+HOSTCC  ?= $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
+HOSTLD  ?= $(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX)
 else
 HOSTAR  ?= ar
 HOSTCC  ?= gcc
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index a40add31a2e3..2a2d240cdc1b 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -1,7 +1,13 @@
 # This mimics the top-level Makefile. We do it explicitly here so that this
 # Makefile can operate with or without the kbuild infrastructure.
 ifneq ($(LLVM),)
-CC := clang
+ifneq ($(filter %/,$(LLVM)),)
+LLVM_PREFIX := $(LLVM)
+else ifneq ($(filter -%,$(LLVM)),)
+LLVM_SUFFIX := $(LLVM)
+endif
+
+CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
 else
 CC := $(CROSS_COMPILE)gcc
 endif

base-commit: d42118db5e7bea017cf9d7c122c7ca3b89a51421
-- 
2.35.1

