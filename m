Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9742F60E97
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2019 05:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfGFDJs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Jul 2019 23:09:48 -0400
Received: from condef-02.nifty.com ([202.248.20.67]:33775 "EHLO
        condef-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfGFDJs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Jul 2019 23:09:48 -0400
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-02.nifty.com with ESMTP id x66384Yg017144
        for <linux-kselftest@vger.kernel.org>; Sat, 6 Jul 2019 12:08:04 +0900
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x6637E3N030660;
        Sat, 6 Jul 2019 12:07:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x6637E3N030660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562382436;
        bh=DqMeEpsYLg2FNqTNDCaAigGm7/V+QKqBZZKT+giJbgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kJnvv7BatHzNkfx4kfoKaFfSjB+Fu9Ax2s8IbKQtg2vu/HTFAzBzq8NGCBizAQJ/z
         qSULExu8ajajVh3uqkJH/e2MgR80ZFwY8FtbWRO6nIHYgnsbXX9nY056Qhxohqd8Ix
         7YynWU+HM9FZR3FiChRzDr8UcOQHBa7zwDxgPjmOhjXH+UCKLuAbtHeZYVSbodcg6r
         VunG+Tu0+talczuN/CdDgDQoVvGX2Q+mfB6q1Gkk0yBrVjqbhHAD4XKZ19oZR7BryA
         I/9zBwAKh2oIGP0XFetJew2+HOAkMHiLJdqLVzwMuvm4mZZDFl1ChDE1L/5h7GUJt7
         fxHya3EpK3Tpg==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Kieran Bingham <kbingham@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kselftest@vger.kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/3] kbuild: replace KBUILD_SRCTREE with boolean building_out_of_srctree
Date:   Sat,  6 Jul 2019 12:07:12 +0900
Message-Id: <20190706030713.6221-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190706030713.6221-1-yamada.masahiro@socionext.com>
References: <20190706030713.6221-1-yamada.masahiro@socionext.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 25b146c5b8ce ("kbuild: allow Kbuild to start from any directory")
deprecated KBUILD_SRCTREE.

It is only used in tools/testing/selftest/ to distinguish out-of-tree
build. Replace it with a new boolean flag, building_out_of_srctree.

I also replaced the conditional ($(srctree),.) because the next commit
will allow an absolute path for $(srctree) even when building in the
source tree.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                         | 19 ++++++++-----------
 scripts/Makefile.build           |  2 +-
 scripts/Makefile.host            |  2 +-
 scripts/Makefile.lib             |  2 +-
 scripts/Makefile.modbuiltin      |  2 +-
 scripts/gdb/linux/Makefile       |  2 +-
 tools/testing/selftests/Makefile |  2 +-
 tools/testing/selftests/lib.mk   |  4 ++--
 8 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index a5615edf2196..534a5dc796b1 100644
--- a/Makefile
+++ b/Makefile
@@ -228,9 +228,12 @@ ifeq ("$(origin M)", "command line")
   KBUILD_EXTMOD := $(M)
 endif
 
+export KBUILD_CHECKSRC KBUILD_EXTMOD
+
 ifeq ($(abs_srctree),$(abs_objtree))
         # building in the source tree
         srctree := .
+	building_out_of_srctree :=
 else
         ifeq ($(abs_srctree)/,$(dir $(abs_objtree)))
                 # building in a subdirectory of the source tree
@@ -238,19 +241,13 @@ else
         else
                 srctree := $(abs_srctree)
         endif
-
-	# TODO:
-	# KBUILD_SRC is only used to distinguish in-tree/out-of-tree build.
-	# Replace it with $(srctree) or something.
-	KBUILD_SRC := $(abs_srctree)
+	building_out_of_srctree := 1
 endif
 
-export KBUILD_CHECKSRC KBUILD_EXTMOD KBUILD_SRC
-
 objtree		:= .
 VPATH		:= $(srctree)
 
-export srctree objtree VPATH
+export building_out_of_srctree srctree objtree VPATH
 
 # To make sure we do not include .config for any of the *config targets
 # catch them early, and hand them over to scripts/kconfig/Makefile
@@ -453,7 +450,7 @@ USERINCLUDE    := \
 LINUXINCLUDE    := \
 		-I$(srctree)/arch/$(SRCARCH)/include \
 		-I$(objtree)/arch/$(SRCARCH)/include/generated \
-		$(if $(filter .,$(srctree)),,-I$(srctree)/include) \
+		$(if $(building_out_of_srctree),-I$(srctree)/include) \
 		-I$(objtree)/include \
 		$(USERINCLUDE)
 
@@ -509,7 +506,7 @@ PHONY += outputmakefile
 # At the same time when output Makefile generated, generate .gitignore to
 # ignore whole output directory
 outputmakefile:
-ifneq ($(srctree),.)
+ifdef building_out_of_srctree
 	$(Q)ln -fsn $(srctree) source
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
 	$(Q)test -e .gitignore || \
@@ -1093,7 +1090,7 @@ PHONY += prepare archprepare prepare1 prepare3
 # and if so do:
 # 1) Check that make has not been executed in the kernel src $(srctree)
 prepare3: include/config/kernel.release
-ifneq ($(srctree),.)
+ifdef building_out_of_srctree
 	@$(kecho) '  Using $(srctree) as source for kernel'
 	$(Q)if [ -f $(srctree)/.config -o \
 		 -d $(srctree)/include/config -o \
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 341fca59d28f..1086caaac786 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -509,7 +509,7 @@ existing-targets := $(wildcard $(sort $(targets)))
 
 -include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
 
-ifneq ($(srctree),.)
+ifdef building_out_of_srctree
 # Create directories for object files if they do not exist
 obj-dirs := $(sort $(obj) $(patsubst %/,%, $(dir $(targets))))
 # If targets exist, their directories apparently exist. Skip mkdir.
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index b6a54bdf0965..fcf0213e6ac8 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -69,7 +69,7 @@ _hostcxx_flags = $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
 
 # $(objtree)/$(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)
-ifneq ($(srctree),.)
+ifdef building_out_of_srctree
 _hostc_flags   += -I $(objtree)/$(obj)
 _hostcxx_flags += -I $(objtree)/$(obj)
 endif
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 4d006923763c..f835a40ebae5 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -148,7 +148,7 @@ endif
 # $(srctree)/$(src) for including checkin headers from generated source files
 # $(objtree)/$(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)
-ifneq ($(srctree),.)
+ifdef building_out_of_srctree
 _c_flags   += -I $(srctree)/$(src) -I $(objtree)/$(obj)
 _a_flags   += -I $(srctree)/$(src) -I $(objtree)/$(obj)
 _cpp_flags += -I $(srctree)/$(src) -I $(objtree)/$(obj)
diff --git a/scripts/Makefile.modbuiltin b/scripts/Makefile.modbuiltin
index 12ac300fe51b..7d4711b88656 100644
--- a/scripts/Makefile.modbuiltin
+++ b/scripts/Makefile.modbuiltin
@@ -15,7 +15,7 @@ include include/config/tristate.conf
 
 include scripts/Kbuild.include
 
-ifneq ($(srctree),.)
+ifdef building_out_of_srctree
 # Create output directory if not already present
 _dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
 endif
diff --git a/scripts/gdb/linux/Makefile b/scripts/gdb/linux/Makefile
index 9fd3d8ed731a..124755087510 100644
--- a/scripts/gdb/linux/Makefile
+++ b/scripts/gdb/linux/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-ifneq ($(srctree),.)
+ifdef building_out_of_srctree
 
 symlinks := $(patsubst $(srctree)/$(src)/%,%,$(wildcard $(srctree)/$(src)/*.py))
 
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9781ca79794a..25b43a8c2b15 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -74,7 +74,7 @@ endif
 # Append kselftest to KBUILD_OUTPUT to avoid cluttering
 # KBUILD_OUTPUT with selftest objects and headers installed
 # by selftests Makefile or lib.mk.
-ifneq ($(KBUILD_SRC),)
+ifdef building_out_of_srctree
 override LDFLAGS =
 endif
 
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 077337195783..1c8a1963d03f 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -70,7 +70,7 @@ define RUN_TESTS
 endef
 
 run_tests: all
-ifneq ($(KBUILD_SRC),)
+ifdef building_out_of_srctree
 	@if [ "X$(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)" != "X" ]; then
 		@rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT)
 	fi
@@ -125,7 +125,7 @@ clean:
 # When make O= with kselftest target from main level
 # the following aren't defined.
 #
-ifneq ($(KBUILD_SRC),)
+ifdef building_out_of_srctree
 LINK.c = $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)
 COMPILE.S = $(CC) $(ASFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
 LINK.S = $(CC) $(ASFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)
-- 
2.17.1

