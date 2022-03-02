Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F954CB2E3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 00:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiCBXsF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 18:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiCBXsD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 18:48:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1CF17185A;
        Wed,  2 Mar 2022 15:47:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3278B82259;
        Wed,  2 Mar 2022 23:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1D5C004E1;
        Wed,  2 Mar 2022 23:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646264823;
        bh=iNqELq+lX+h6oGIXCLQayAVdk7lzG1NGvnedGOzYkkM=;
        h=From:To:Cc:Subject:Date:From;
        b=RTYDe4ktdxhZsPRhExKj5tzN1nAbRVZrUpiXPL2JtIpf2z/I5dM3rN/1hplrrHVs/
         AUUE+VpS6cjgBRyL66ETXfgZwMZAYlZPgDbdWIDa65uq/AxQlf6oG9J9RWutENDa0o
         JHHftuSm5ZOPYgoGkP591g+wjyXgKK4yZnaK9ZJHlbBAiVQE63iEGuokIK6nUFN1bo
         RG3Yiz6cY6KfcrZwCa2dsWYIkiI1oEgeaUI1Fn4LFh3SGmg1IkY7WRVNAVZ/j7wXGM
         Ri3ihv+umpKM4bgUArI+aDAWp5qB1oWbM1js+cB/KBgtkh2ZZh7Q4NtKvdNxLpbAff
         socg10N3TsW5Q==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] kbuild: Allow a suffix with $(LLVM)
Date:   Wed,  2 Mar 2022 16:44:01 -0700
Message-Id: <20220302234400.782002-1-nathan@kernel.org>
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

Link: https://lore.kernel.org/r/20200317215515.226917-1-ndesaulniers@google.com/
Link: https://lore.kernel.org/r/20220224151322.072632223@infradead.org/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

RFC -> v1: https://lore.kernel.org/r/Yh%2FegU1LZudfrgVy@dev-arch.thelio-3990X/

* Tidy up commit message slightly.

* Add tags.

* Add links to prior discussions for context.

* Add change to tools/testing/selftests/lib.mk.

I would like for this to go through the Kbuild tree, please ack as
necessary.

 Documentation/kbuild/llvm.rst  |  7 +++++++
 Makefile                       | 24 ++++++++++++++----------
 tools/scripts/Makefile.include | 20 ++++++++++++--------
 tools/testing/selftests/lib.mk |  6 +++++-
 4 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
index d32616891dcf..5805a8473a36 100644
--- a/Documentation/kbuild/llvm.rst
+++ b/Documentation/kbuild/llvm.rst
@@ -60,6 +60,13 @@ They can be enabled individually. The full list of the parameters: ::
 	  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
 	  HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld
 
+If your LLVM tools have a suffix and you prefer to test an explicit version rather
+than the unsuffixed executables, use ``LLVM=<suffix>``. For example: ::
+
+	make LLVM=-14
+
+will use ``clang-14``, ``ld.lld-14``, etc.
+
 The integrated assembler is enabled by default. You can pass ``LLVM_IAS=0`` to
 disable it.
 
diff --git a/Makefile b/Makefile
index a82095c69fdd..963840c00eae 100644
--- a/Makefile
+++ b/Makefile
@@ -424,8 +424,12 @@ HOST_LFS_LDFLAGS := $(shell getconf LFS_LDFLAGS 2>/dev/null)
 HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
 
 ifneq ($(LLVM),)
-HOSTCC	= clang
-HOSTCXX	= clang++
+ifneq ($(LLVM),1)
+LLVM_SFX := $(LLVM)
+endif
+
+HOSTCC	= clang$(LLVM_SFX)
+HOSTCXX	= clang++$(LLVM_SFX)
 else
 HOSTCC	= gcc
 HOSTCXX	= g++
@@ -444,14 +448,14 @@ KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
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
+CC		= clang$(LLVM_SFX)
+LD		= ld.lld$(LLVM_SFX)
+AR		= llvm-ar$(LLVM_SFX)
+NM		= llvm-nm$(LLVM_SFX)
+OBJCOPY		= llvm-objcopy$(LLVM_SFX)
+OBJDUMP		= llvm-objdump$(LLVM_SFX)
+READELF		= llvm-readelf$(LLVM_SFX)
+STRIP		= llvm-strip$(LLVM_SFX)
 else
 CC		= $(CROSS_COMPILE)gcc
 LD		= $(CROSS_COMPILE)ld
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 79d102304470..ab3b2a7dcc94 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -52,11 +52,15 @@ define allow-override
 endef
 
 ifneq ($(LLVM),)
-$(call allow-override,CC,clang)
-$(call allow-override,AR,llvm-ar)
-$(call allow-override,LD,ld.lld)
-$(call allow-override,CXX,clang++)
-$(call allow-override,STRIP,llvm-strip)
+ifneq ($(LLVM),1)
+LLVM_SFX := $(LLVM)
+endif
+
+$(call allow-override,CC,clang$(LLVM_SFX))
+$(call allow-override,AR,llvm-ar$(LLVM_SFX))
+$(call allow-override,LD,ld.lld$(LLVM_SFX))
+$(call allow-override,CXX,clang++$(LLVM_SFX))
+$(call allow-override,STRIP,llvm-strip$(LLVM_SFX))
 else
 # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
 $(call allow-override,CC,$(CROSS_COMPILE)gcc)
@@ -69,9 +73,9 @@ endif
 CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
 
 ifneq ($(LLVM),)
-HOSTAR  ?= llvm-ar
-HOSTCC  ?= clang
-HOSTLD  ?= ld.lld
+HOSTAR  ?= llvm-ar$(LLVM_SFX)
+HOSTCC  ?= clang$(LLVM_SFX)
+HOSTLD  ?= ld.lld$(LLVM_SFX)
 else
 HOSTAR  ?= ar
 HOSTCC  ?= gcc
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index a40add31a2e3..b3ab713537c6 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -1,7 +1,11 @@
 # This mimics the top-level Makefile. We do it explicitly here so that this
 # Makefile can operate with or without the kbuild infrastructure.
 ifneq ($(LLVM),)
-CC := clang
+ifneq ($(LLVM),1)
+LLVM_SFX := $(LLVM)
+endif
+
+CC := clang$(LLVM_SFX)
 else
 CC := $(CROSS_COMPILE)gcc
 endif

base-commit: 55de8686df7ed2b5237867b130e30c728bbd9db4
-- 
2.35.1

