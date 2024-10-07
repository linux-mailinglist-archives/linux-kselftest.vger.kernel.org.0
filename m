Return-Path: <linux-kselftest+bounces-19140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9E0992618
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 09:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559931C223C0
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 07:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A712176AAE;
	Mon,  7 Oct 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLNFMf52"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732C74C08;
	Mon,  7 Oct 2024 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728286301; cv=none; b=FUxgB8wmmPgbUoC0oMDOOM8bmb8L1YqhKmkNhGFl75eu5NJLlLuIAabhV6flrmhcfc22utJCT9R5NWKefjSS6B5iN/nW0sawGIKUFeG4Pl9V1W1D1UUILESrDk4Zh0srxawNqGdwXK3Ym7L1NetwZ1dMfUgLYKbUa3OrhA45wTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728286301; c=relaxed/simple;
	bh=MQvwg8vb9dS8GngN/GkkuavJEoeBFMRsx6M3qD2yGik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DrxWzS52ziB3fOXdKoHPpRIs7hwsWmfSa3CGWvz1REBNHnIxIYB52itwzwYzyng02dOAdfOamjwiF2oaGqxE8ajCINyFY1fwp8KRYarnKi+knlRZJ1JhniMnlSP7BXrWX9MJ0Eh2o4a2NPhRGkc9RXckD8xt8cRm6qsfbhv9aK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLNFMf52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4A1C4CEC6;
	Mon,  7 Oct 2024 07:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728286300;
	bh=MQvwg8vb9dS8GngN/GkkuavJEoeBFMRsx6M3qD2yGik=;
	h=From:To:Cc:Subject:Date:From;
	b=SLNFMf52qee2NT2FJBw+6q2wuOMrRwDdMT9RM/QC5e2BstAUBj1Hc6Vr72M6IG11g
	 djun7MKPdqc0Kr/PJEVHYIoosQ/oLZkHEjjziMtAgf5dl6A3AYdR92JqT9jc9MIfH3
	 AeVt6XCeXoMtV8pARxhMIXcCftCy82uoiZXMLtUl4qQkVWNE3po9fLfY3QR3bvJrc9
	 J0qSd1HdIhIhDBnUoySKUfOjM6hd05YmpbnrVvs80B0EBAxZiq/JO9VTEFPsFzmmup
	 BpqN4Xtq6M1vtmyGrphbZrfa7H3AhxPbserL89mENsKTAXKY3ZQwiJz7RdNyezNLLG
	 2uhJB0raF5AqA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] selftests: sched_ext: Add sched_ext as proper selftest target
Date: Mon,  7 Oct 2024 09:31:32 +0200
Message-ID: <20241007073133.989166-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

The sched_ext selftests is missing proper cross-compilation support, a
proper target entry, and out-of-tree build support.

When building the kselftest suite, e.g.:

  make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- \
    SKIP_TARGETS="" O=/output/foo -C tools/testing/selftests install

The expectation is that the sched_ext is included, cross-built, and
placed into /output/foo.

Add CROSS_COMPILE, OUTPUT, and TARGETS support to the sched_ext
selftest. Also, remove some variables that were unused by the
Makefile.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
v2: * Removed the duplicated LLVM prefix parsing (David)
    * Made sure make clean didn't do a complete mess (David)
    * Added sched_ext to default skip (Shuah)
---
tools/testing/selftests/Makefile           |  9 +--
 tools/testing/selftests/sched_ext/Makefile | 80 +++++++++++-----------
 2 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b38199965f99..363d031a16f7 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -88,6 +88,7 @@ TARGETS += rlimits
 TARGETS += rseq
 TARGETS += rtc
 TARGETS += rust
+TARGETS += sched_ext
 TARGETS += seccomp
 TARGETS += sgx
 TARGETS += sigaltstack
@@ -129,10 +130,10 @@ ifeq ($(filter net/lib,$(TARGETS)),)
 endif
 endif
 
-# User can optionally provide a TARGETS skiplist.  By default we skip
-# BPF since it has cutting edge build time dependencies which require
-# more effort to install.
-SKIP_TARGETS ?= bpf
+# User can optionally provide a TARGETS skiplist. By default we skip
+# targets using BPF since it has cutting edge build time dependencies
+# which require more effort to install.
+SKIP_TARGETS ?= bpf sched_ext
 ifneq ($(SKIP_TARGETS),)
 	TMP := $(filter-out $(SKIP_TARGETS), $(TARGETS))
 	override TARGETS := $(TMP)
diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 0754a2c110a1..acab9732b23e 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -3,24 +3,13 @@
 include ../../../build/Build.include
 include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
+
+TEST_GEN_PROGS := runner
+
+# override lib.mk's default rules
+OVERRIDE_TARGETS := 1
 include ../lib.mk
 
-ifneq ($(LLVM),)
-ifneq ($(filter %/,$(LLVM)),)
-LLVM_PREFIX := $(LLVM)
-else ifneq ($(filter -%,$(LLVM)),)
-LLVM_SUFFIX := $(LLVM)
-endif
-
-CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
-else
-CC := gcc
-endif # LLVM
-
-ifneq ($(CROSS_COMPILE),)
-$(error CROSS_COMPILE not supported for scx selftests)
-endif # CROSS_COMPILE
-
 CURDIR := $(abspath .)
 REPOROOT := $(abspath ../../../..)
 TOOLSDIR := $(REPOROOT)/tools
@@ -34,18 +23,31 @@ GENHDR := $(GENDIR)/autoconf.h
 SCXTOOLSDIR := $(TOOLSDIR)/sched_ext
 SCXTOOLSINCDIR := $(TOOLSDIR)/sched_ext/include
 
-OUTPUT_DIR := $(CURDIR)/build
+OUTPUT_DIR := $(OUTPUT)/build
 OBJ_DIR := $(OUTPUT_DIR)/obj
 INCLUDE_DIR := $(OUTPUT_DIR)/include
 BPFOBJ_DIR := $(OBJ_DIR)/libbpf
 SCXOBJ_DIR := $(OBJ_DIR)/sched_ext
 BPFOBJ := $(BPFOBJ_DIR)/libbpf.a
 LIBBPF_OUTPUT := $(OBJ_DIR)/libbpf/libbpf.a
-DEFAULT_BPFTOOL := $(OUTPUT_DIR)/sbin/bpftool
-HOST_BUILD_DIR := $(OBJ_DIR)
-HOST_OUTPUT_DIR := $(OUTPUT_DIR)
 
-VMLINUX_BTF_PATHS ?= ../../../../vmlinux					\
+ifneq ($(CROSS_COMPILE),)
+DEFAULT_BPFTOOL := $(OUTPUT_DIR)/host/sbin/bpftool
+HOST_OBJ_DIR := $(OBJ_DIR)/host/bpftool
+HOST_LIBBPF_OUTPUT := $(OBJ_DIR)/host/libbpf/
+HOST_LIBBPF_DESTDIR := $(OUTPUT_DIR)/host/
+HOST_DESTDIR := $(OUTPUT_DIR)/host/
+else
+DEFAULT_BPFTOOL := $(OUTPUT_DIR)/sbin/bpftool
+HOST_OBJ_DIR := $(OBJ_DIR)/bpftool
+HOST_LIBBPF_OUTPUT := $(OBJ_DIR)/libbpf/
+HOST_LIBBPF_DESTDIR := $(OUTPUT_DIR)/
+HOST_DESTDIR := $(OUTPUT_DIR)/
+endif
+
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)					\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)		\
+		     ../../../../vmlinux					\
 		     /sys/kernel/btf/vmlinux					\
 		     /boot/vmlinux-$(shell uname -r)
 VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
@@ -80,17 +82,23 @@ IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null |				\
 # Use '-idirafter': Don't interfere with include mechanics except where the
 # build would have failed anyways.
 define get_sys_includes
-$(shell $(1) -v -E - </dev/null 2>&1 \
+$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
 	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
-$(shell $(1) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
+$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
 endef
 
+ifneq ($(CROSS_COMPILE),)
+CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif
+
+CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
+
 BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
 	     $(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)		\
 	     -I$(CURDIR)/include -I$(CURDIR)/include/bpf-compat			\
 	     -I$(INCLUDE_DIR) -I$(APIDIR) -I$(SCXTOOLSINCDIR)			\
 	     -I$(REPOROOT)/include						\
-	     $(call get_sys_includes,$(CLANG))					\
+	     $(CLANG_SYS_INCLUDES) 						\
 	     -Wall -Wno-compare-distinct-pointer-types				\
 	     -Wno-incompatible-function-pointer-types				\
 	     -O2 -mcpu=v3
@@ -98,7 +106,7 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
 # sort removes libbpf duplicates when not cross-building
 MAKE_DIRS := $(sort $(OBJ_DIR)/libbpf $(OBJ_DIR)/libbpf				\
 	       $(OBJ_DIR)/bpftool $(OBJ_DIR)/resolve_btfids			\
-	       $(INCLUDE_DIR) $(SCXOBJ_DIR))
+	       $(HOST_OBJ_DIR) $(INCLUDE_DIR) $(SCXOBJ_DIR))
 
 $(MAKE_DIRS):
 	$(call msg,MKDIR,,$@)
@@ -112,14 +120,14 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)			\
 		    DESTDIR=$(OUTPUT_DIR) prefix= all install_headers
 
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
-		    $(LIBBPF_OUTPUT) | $(OBJ_DIR)/bpftool
+		    $(LIBBPF_OUTPUT) | $(HOST_OBJ_DIR)
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
 		    ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD)		\
 		    EXTRA_CFLAGS='-g -O0'					\
-		    OUTPUT=$(OBJ_DIR)/bpftool/					\
-		    LIBBPF_OUTPUT=$(OBJ_DIR)/libbpf/				\
-		    LIBBPF_DESTDIR=$(OUTPUT_DIR)/				\
-		    prefix= DESTDIR=$(OUTPUT_DIR)/ install-bin
+		    OUTPUT=$(HOST_OBJ_DIR)/					\
+		    LIBBPF_OUTPUT=$(HOST_LIBBPF_OUTPUT)				\
+		    LIBBPF_DESTDIR=$(HOST_LIBBPF_DESTDIR)			\
+		    prefix= DESTDIR=$(HOST_DESTDIR) install-bin
 
 $(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
 ifeq ($(VMLINUX_H),)
@@ -150,9 +158,7 @@ $(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BP
 
 override define CLEAN
 	rm -rf $(OUTPUT_DIR)
-	rm -f *.o *.bpf.o *.bpf.skel.h *.bpf.subskel.h
 	rm -f $(TEST_GEN_PROGS)
-	rm -f runner
 endef
 
 # Every testcase takes all of the BPF progs are dependencies by default. This
@@ -196,21 +202,15 @@ $(SCXOBJ_DIR)/runner.o: runner.c | $(SCXOBJ_DIR)
 # function doesn't support using implicit rules otherwise.
 $(testcase-targets): $(SCXOBJ_DIR)/%.o: %.c $(SCXOBJ_DIR)/runner.o $(all_test_bpfprogs) | $(SCXOBJ_DIR)
 	$(eval test=$(patsubst %.o,%.c,$(notdir $@)))
-	$(CC) $(CFLAGS) -c $< -o $@ $(SCXOBJ_DIR)/runner.o
+	$(CC) $(CFLAGS) -c $< -o $@
 
 $(SCXOBJ_DIR)/util.o: util.c | $(SCXOBJ_DIR)
 	$(CC) $(CFLAGS) -c $< -o $@
 
-runner: $(SCXOBJ_DIR)/runner.o $(SCXOBJ_DIR)/util.o $(BPFOBJ) $(testcase-targets)
+$(OUTPUT)/runner: $(SCXOBJ_DIR)/runner.o $(SCXOBJ_DIR)/util.o $(BPFOBJ) $(testcase-targets)
 	@echo "$(testcase-targets)"
 	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
 
-TEST_GEN_PROGS := runner
-
-all: runner
-
-.PHONY: all clean help
-
 .DEFAULT_GOAL := all
 
 .DELETE_ON_ERROR:

base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
-- 
2.43.0


