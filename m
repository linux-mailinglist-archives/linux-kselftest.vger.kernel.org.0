Return-Path: <linux-kselftest+bounces-19246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87372995373
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 17:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960EA1C24910
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 15:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F7D18C327;
	Tue,  8 Oct 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJs2EVol"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF2249E5;
	Tue,  8 Oct 2024 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401728; cv=none; b=sEzXDV7Lq08ooY+F+oZlHJ8qzEJDPuD2umR/UJhjgTWhiADn4kClgDhGTjNXNY1o/c60Ysjd76Sqwc0t55Q/cUlWiB9GvntBBENXBa2/UrKnlLM8yF5U5pzUmflseESE/YiKUmWHn5iWz1L9erRo18rbduvOmiK1AS8gsKYp5rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401728; c=relaxed/simple;
	bh=Wl1j1DcsdjghWUruz8NJy1B0MpfUs6RuX40DQKKNB4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d9usMJV+6gIKhBy2ZL/Te4QArMezKVLOGipuuTAFWSt3D0lONt4Mo5JD7bHlulrE1HP4Ilxmy51DGz7AWJ8GleKrLp4+ueImQKxc1KZieAn6qFPGBCznHti+ba2Rj6aoI/xa0DlsB9sBxbdSS8Y2oyyRSWeGJil9S6qneG4TX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJs2EVol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C0FC4CECE;
	Tue,  8 Oct 2024 15:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728401728;
	bh=Wl1j1DcsdjghWUruz8NJy1B0MpfUs6RuX40DQKKNB4I=;
	h=From:To:Cc:Subject:Date:From;
	b=PJs2EVolLdF3G1KCtNP10zYBxCxio9SdSC5+Q40F64AvPO+dwJiGEVjVuhP0HB4V6
	 NVNzPnBR/tjFyDVvRCN2IWSw6db+SpTMAycXYsVy0iW9ILoLPznpqVzqBvH7I46vTo
	 PnH3zijWchCPF9cnAYUSaUUy9lTzqjOzrDPkLDuuuNhS5kzG7faD9CbDSWp+vbLkAU
	 ZPIpdNblmYgxaP1wH4aIjX6glH8IV2vuKDLLli8K7BvLR2I2n5AXSoitZJMOI8ziwb
	 TltOKetZuXsSrR9hkKq57H7YZrCA92znScqi9WcT+GChkcj9u8yWlkLQ6iSDmhGCtz
	 hGxJdqziUftpA==
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
Subject: [PATCH v3] selftests: sched_ext: Add sched_ext as proper selftest target
Date: Tue,  8 Oct 2024 17:35:18 +0200
Message-ID: <20241008153519.1270862-1-bjorn@kernel.org>
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

  make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-  \
    TARGETS=sched_ext SKIP_TARGETS="" O=/output/foo \
    -C tools/testing/selftests install

or:

  make ARCH=arm64 LLVM=1 TARGETS=sched_ext SKIP_TARGETS="" \
    O=/output/foo -C tools/testing/selftests install

The expectation is that the sched_ext is included, cross-built, the
correct toolchain is picked up, and placed into /output/foo.

In contrast to the BPF selftests, the sched_ext suite does not use
bpftool at test run-time, so it is sufficient to build bpftool for the
build host only.

Add ARCH, CROSS_COMPILE, OUTPUT, and TARGETS support to the sched_ext
selftest. Also, remove some variables that were unused by the
Makefile.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
v3: * Always build a build host version of bpftool (Mark)
    * Make sure LLVM style "ARCH only" cross-build works (Mark)
    
v2: * Removed the duplicated LLVM prefix parsing (David)
    * Made sure make clean didn't do a complete mess (David)
    * Added sched_ext to default skip (Shuah)
---
 tools/testing/selftests/Makefile           |  9 +--
 tools/testing/selftests/sched_ext/Makefile | 73 ++++++++++------------
 2 files changed, 38 insertions(+), 44 deletions(-)

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
index 0754a2c110a1..06ae9c107049 100644
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
@@ -34,18 +23,23 @@ GENHDR := $(GENDIR)/autoconf.h
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
+DEFAULT_BPFTOOL := $(OUTPUT_DIR)/host/sbin/bpftool
+HOST_OBJ_DIR := $(OBJ_DIR)/host/bpftool
+HOST_LIBBPF_OUTPUT := $(OBJ_DIR)/host/libbpf/
+HOST_LIBBPF_DESTDIR := $(OUTPUT_DIR)/host/
+HOST_DESTDIR := $(OUTPUT_DIR)/host/
+
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)					\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)		\
+		     ../../../../vmlinux					\
 		     /sys/kernel/btf/vmlinux					\
 		     /boot/vmlinux-$(shell uname -r)
 VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
@@ -80,17 +74,23 @@ IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null |				\
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
@@ -98,7 +98,7 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
 # sort removes libbpf duplicates when not cross-building
 MAKE_DIRS := $(sort $(OBJ_DIR)/libbpf $(OBJ_DIR)/libbpf				\
 	       $(OBJ_DIR)/bpftool $(OBJ_DIR)/resolve_btfids			\
-	       $(INCLUDE_DIR) $(SCXOBJ_DIR))
+	       $(HOST_OBJ_DIR) $(INCLUDE_DIR) $(SCXOBJ_DIR))
 
 $(MAKE_DIRS):
 	$(call msg,MKDIR,,$@)
@@ -108,18 +108,19 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)			\
 	   $(APIDIR)/linux/bpf.h						\
 	   | $(OBJ_DIR)/libbpf
 	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(OBJ_DIR)/libbpf/	\
+		    ARCH=$(ARCH) CC="$(CC)" CROSS_COMPILE=$(CROSS_COMPILE)	\
 		    EXTRA_CFLAGS='-g -O0 -fPIC'					\
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
@@ -150,9 +151,7 @@ $(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BP
 
 override define CLEAN
 	rm -rf $(OUTPUT_DIR)
-	rm -f *.o *.bpf.o *.bpf.skel.h *.bpf.subskel.h
 	rm -f $(TEST_GEN_PROGS)
-	rm -f runner
 endef
 
 # Every testcase takes all of the BPF progs are dependencies by default. This
@@ -196,21 +195,15 @@ $(SCXOBJ_DIR)/runner.o: runner.c | $(SCXOBJ_DIR)
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

base-commit: 87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
-- 
2.43.0


