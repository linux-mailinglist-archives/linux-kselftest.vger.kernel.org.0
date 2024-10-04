Return-Path: <linux-kselftest+bounces-19009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B93990026
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 11:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE11028542F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 09:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A0C148827;
	Fri,  4 Oct 2024 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6O24UIr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEF2179BB;
	Fri,  4 Oct 2024 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034979; cv=none; b=LN4f3nhEI2CHa1Ak2zks+YZixIrh3g+so46gtdn+kX4CbH2vwvtHDn0GB8EJ0gpMCRkDJZzUyMRFf7e3kq3TXXhApwEjcShFIeSmlJub++DCx1kVSUSI937vfDE8h8WcXtVKw0EMVk7yZL73WjUZBeUHtPtu/QUKgnszusi9ATQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034979; c=relaxed/simple;
	bh=SzhRbPk78jtGFOBCsX0ZbmHldM75YK5G46pTsUz7W2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pQqvg6GDJTunOQLMsAnH40DpfADfx2EJLy4AiX5AfAIcK8dY0VKBZnT08xufqwntLLJeanRbo4gjxNgOdQ70wgPaQraiROa9XwH7oO+GDGZhD6rcYgLV9r6PAgjmZaUOOqHIzgtnAbk55PR2Ciiplf7QIj5bJQ/+G09p2Zb5Ueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6O24UIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F50C4CEC6;
	Fri,  4 Oct 2024 09:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728034979;
	bh=SzhRbPk78jtGFOBCsX0ZbmHldM75YK5G46pTsUz7W2A=;
	h=From:To:Cc:Subject:Date:From;
	b=K6O24UIrnQLvTn2gf3tB4sV3i5xDEFVB8dYD+wUb7ntkgmHrol4txY5c1cCuaD/Fp
	 gO5mQrMCLw/Lwjmhzuu5bj9lkgYwNXUNrYysI9LO+0OarhhTP0gD2/mwHU5jlanowY
	 236S4FQ0Jw5Nx377/hmDZaIPvZ4beLHmqREhQ+vXmW/k52t/upg3CY8ouuTCL31+EB
	 9uPvLAb9xAQBNliOtgTfhZWGuTmtGhDwpKGhZw6A2GLMiSrycHgnqdy4SB1ZrRa+nX
	 JpsIfIEx6FDaDyNspvZkNAO70gb1i1JqmPrNmUv3lEw7NTrz918G2220FK/4I5cGGN
	 1ZhZ+KWb9tbQw==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: sched_ext: Add sched_ext as proper selftest target
Date: Fri,  4 Oct 2024 11:42:46 +0200
Message-ID: <20241004094247.795385-1-bjorn@kernel.org>
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
selftest.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/Makefile           |  1 +
 tools/testing/selftests/sched_ext/Makefile | 59 +++++++++++++++-------
 2 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b38199965f99..20ee8a0b795c 100644
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
diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 0754a2c110a1..66467a99184d 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -13,14 +13,8 @@ LLVM_SUFFIX := $(LLVM)
 endif
 
 CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
-else
-CC := gcc
 endif # LLVM
 
-ifneq ($(CROSS_COMPILE),)
-$(error CROSS_COMPILE not supported for scx selftests)
-endif # CROSS_COMPILE
-
 CURDIR := $(abspath .)
 REPOROOT := $(abspath ../../../..)
 TOOLSDIR := $(REPOROOT)/tools
@@ -34,18 +28,39 @@ GENHDR := $(GENDIR)/autoconf.h
 SCXTOOLSDIR := $(TOOLSDIR)/sched_ext
 SCXTOOLSINCDIR := $(TOOLSDIR)/sched_ext/include
 
-OUTPUT_DIR := $(CURDIR)/build
+ifeq (,$(OUTPUT))
+OUTPUT := $(CURDIR)/build
+RUNNER_DIR := $(CURDIR)
+else
+OUTPUT_DIR := $(OUTPUT)
+RUNNER_DIR := $(OUTPUT)
+endif
 OBJ_DIR := $(OUTPUT_DIR)/obj
 INCLUDE_DIR := $(OUTPUT_DIR)/include
 BPFOBJ_DIR := $(OBJ_DIR)/libbpf
 SCXOBJ_DIR := $(OBJ_DIR)/sched_ext
 BPFOBJ := $(BPFOBJ_DIR)/libbpf.a
 LIBBPF_OUTPUT := $(OBJ_DIR)/libbpf/libbpf.a
-DEFAULT_BPFTOOL := $(OUTPUT_DIR)/sbin/bpftool
 HOST_BUILD_DIR := $(OBJ_DIR)
 HOST_OUTPUT_DIR := $(OUTPUT_DIR)
 
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
@@ -80,17 +95,23 @@ IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null |				\
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
@@ -98,7 +119,7 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
 # sort removes libbpf duplicates when not cross-building
 MAKE_DIRS := $(sort $(OBJ_DIR)/libbpf $(OBJ_DIR)/libbpf				\
 	       $(OBJ_DIR)/bpftool $(OBJ_DIR)/resolve_btfids			\
-	       $(INCLUDE_DIR) $(SCXOBJ_DIR))
+	       $(HOST_OBJ_DIR) $(INCLUDE_DIR) $(SCXOBJ_DIR))
 
 $(MAKE_DIRS):
 	$(call msg,MKDIR,,$@)
@@ -112,14 +133,14 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)			\
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
@@ -203,7 +224,7 @@ $(SCXOBJ_DIR)/util.o: util.c | $(SCXOBJ_DIR)
 
 runner: $(SCXOBJ_DIR)/runner.o $(SCXOBJ_DIR)/util.o $(BPFOBJ) $(testcase-targets)
 	@echo "$(testcase-targets)"
-	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
+	$(CC) $(CFLAGS) -o $(RUNNER_DIR)/$@ $^ $(LDFLAGS)
 
 TEST_GEN_PROGS := runner
 

base-commit: 0c559323bbaabee7346c12e74b497e283aaafef5
-- 
2.43.0


