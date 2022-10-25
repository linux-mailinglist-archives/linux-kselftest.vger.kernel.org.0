Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8064960C840
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 11:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiJYJf1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 05:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiJYJfX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 05:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD3E1004AF
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 02:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666690514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JqK/gI9CszUHpbM5UA+V8P5EUqKRzNRacsrpcy2Br/c=;
        b=G6P5qrGN8Zz4Tk/IXwKobudTuih0+zLtQVfOkPY82SMzA7HNRWurL3voprTeVg37d2TdpV
        Ke5Uby6M5di6x7+WrQhRoEAvpT//pUx2rSXX0IW0wWYPyTq/3rz/ntTnKlqWEbAviresDG
        A/ZkgdZUS4Su6odv98ttVP5XPoy4BFI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-rgk9IgdEPFiZ40MSpUbAHA-1; Tue, 25 Oct 2022 05:35:10 -0400
X-MC-Unique: rgk9IgdEPFiZ40MSpUbAHA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D193E803D4B;
        Tue, 25 Oct 2022 09:35:09 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.195.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F26DE4A9254;
        Tue, 25 Oct 2022 09:35:07 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH hid v11 03/14] selftests: add tests for the HID-bpf initial implementation
Date:   Tue, 25 Oct 2022 11:34:47 +0200
Message-Id: <20221025093458.457089-4-benjamin.tissoires@redhat.com>
In-Reply-To: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
References: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The tests are pretty basic:
- create a virtual uhid device that no userspace will like (to not mess
  up the running system)
- attach a BPF prog to it
- open the matching hidraw node
- inject one event and check:
  * that the BPF program can do something on the event stream
  * can modify the event stream
- add another test where we attach/detach BPF programs to see if we get
  errors

Note: the Makefile is extracted from selftests/bpf so we can rebuild
the libbpf and bpftool components from the current kernel tree without
relying on system installed components.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v11:
- introduce the tests in the new selftests/hid
- use of kselftests_harness to have cleaner cleanup code

no changes in v10

changes in v9:
- kept the selftest config list alphabetically ordered

no changes in v8

no changes in v7

no changes in v6

changes in v5:
- use of the HID device system id instead of fd
- attach to HID device with the new API
- add attach/detach test

changes in v4:
- manually retrieve the hidraw node from the sysfs (we can't get it for
  free from BPF)
- use the new API

changes in v3:
- squashed "hid: rely on uhid event to know if a test device is ready"
  into this one
- add selftests bpf VM config changes
- s/hidraw_ino/hidraw_number/

changes in v2:
- split the series by bpf/libbpf/hid/selftests and samples
---
 MAINTAINERS                             |   1 +
 tools/testing/selftests/Makefile        |   1 +
 tools/testing/selftests/hid/.gitignore  |   4 +
 tools/testing/selftests/hid/Makefile    | 242 +++++++++
 tools/testing/selftests/hid/config      |  20 +
 tools/testing/selftests/hid/hid_bpf.c   | 676 ++++++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c |  45 ++
 7 files changed, 989 insertions(+)
 create mode 100644 tools/testing/selftests/hid/.gitignore
 create mode 100644 tools/testing/selftests/hid/Makefile
 create mode 100644 tools/testing/selftests/hid/config
 create mode 100644 tools/testing/selftests/hid/hid_bpf.c
 create mode 100644 tools/testing/selftests/hid/progs/hid.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bdd43abd2683..514e05ddac18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9097,6 +9097,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
 F:	drivers/hid/
 F:	include/linux/hid*
 F:	include/uapi/linux/hid*
+F:	tools/testing/selftests/hid/
 
 HID LOGITECH DRIVERS
 R:	Filipe Laíns <lains@riseup.net>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 0464b2c6c1e4..fba95573d0b2 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -26,6 +26,7 @@ TARGETS += fpu
 TARGETS += ftrace
 TARGETS += futex
 TARGETS += gpio
+TARGETS += hid
 TARGETS += intel_pstate
 TARGETS += ipc
 TARGETS += ir
diff --git a/tools/testing/selftests/hid/.gitignore b/tools/testing/selftests/hid/.gitignore
new file mode 100644
index 000000000000..a462ca6ab2c0
--- /dev/null
+++ b/tools/testing/selftests/hid/.gitignore
@@ -0,0 +1,4 @@
+bpftool
+*.skel.h
+/tools
+hid_bpf
diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
new file mode 100644
index 000000000000..a7ba4aa0c8bd
--- /dev/null
+++ b/tools/testing/selftests/hid/Makefile
@@ -0,0 +1,242 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# based on tools/testing/selftest/bpf/Makefile
+include ../../../build/Build.include
+include ../../../scripts/Makefile.arch
+include ../../../scripts/Makefile.include
+
+CXX ?= $(CROSS_COMPILE)g++
+
+CURDIR := $(abspath .)
+TOOLSDIR := $(abspath ../../..)
+LIBDIR := $(TOOLSDIR)/lib
+BPFDIR := $(LIBDIR)/bpf
+TOOLSINCDIR := $(TOOLSDIR)/include
+BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
+APIDIR := $(TOOLSINCDIR)/uapi
+GENDIR := $(abspath ../../../../include/generated)
+GENHDR := $(GENDIR)/autoconf.h
+HOSTPKG_CONFIG := pkg-config
+
+ifneq ($(wildcard $(GENHDR)),)
+  GENFLAGS := -DHAVE_GENHDR
+endif
+
+SAN_CFLAGS	?=
+CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)	\
+	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
+	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
+LDFLAGS += $(SAN_CFLAGS)
+LDLIBS += -lelf -lz -lrt -lpthread
+
+# Silence some warnings when compiled with clang
+ifneq ($(LLVM),)
+CFLAGS += -Wno-unused-command-line-argument
+endif
+
+# Order correspond to 'make run_tests' order
+TEST_GEN_PROGS = hid_bpf
+
+# Emit succinct information message describing current building step
+# $1 - generic step name (e.g., CC, LINK, etc);
+# $2 - optional "flavor" specifier; if provided, will be emitted as [flavor];
+# $3 - target (assumed to be file); only file name will be emitted;
+# $4 - optional extra arg, emitted as-is, if provided.
+ifeq ($(V),1)
+Q =
+msg =
+else
+Q = @
+msg = @printf '  %-8s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
+MAKEFLAGS += --no-print-directory
+submake_extras := feature_display=0
+endif
+
+# override lib.mk's default rules
+OVERRIDE_TARGETS := 1
+override define CLEAN
+	$(call msg,CLEAN)
+	$(Q)$(RM) -r $(TEST_GEN_PROGS)
+	$(Q)$(RM) -r $(EXTRA_CLEAN)
+endef
+
+include ../lib.mk
+
+SCRATCH_DIR := $(OUTPUT)/tools
+BUILD_DIR := $(SCRATCH_DIR)/build
+INCLUDE_DIR := $(SCRATCH_DIR)/include
+BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
+ifneq ($(CROSS_COMPILE),)
+HOST_BUILD_DIR		:= $(BUILD_DIR)/host
+HOST_SCRATCH_DIR	:= $(OUTPUT)/host-tools
+HOST_INCLUDE_DIR	:= $(HOST_SCRATCH_DIR)/include
+else
+HOST_BUILD_DIR		:= $(BUILD_DIR)
+HOST_SCRATCH_DIR	:= $(SCRATCH_DIR)
+HOST_INCLUDE_DIR	:= $(INCLUDE_DIR)
+endif
+HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
+RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
+
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
+		     ../../../../vmlinux				\
+		     /sys/kernel/btf/vmlinux				\
+		     /boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+ifeq ($(VMLINUX_BTF),)
+$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
+endif
+
+# Define simple and short `make test_progs`, `make test_sysctl`, etc targets
+# to build individual tests.
+# NOTE: Semicolon at the end is critical to override lib.mk's default static
+# rule for binaries.
+$(notdir $(TEST_GEN_PROGS)): %: $(OUTPUT)/% ;
+
+# sort removes libbpf duplicates when not cross-building
+MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf		\
+	       $(HOST_BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/resolve_btfids	\
+	       $(INCLUDE_DIR))
+$(MAKE_DIRS):
+	$(call msg,MKDIR,,$@)
+	$(Q)mkdir -p $@
+
+$(OUTPUT)/%.o: %.c
+	$(call msg,CC,,$@)
+	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
+
+# LLVM's ld.lld doesn't support all the architectures, so use it only on x86
+ifeq ($(SRCARCH),x86)
+LLD := lld
+else
+LLD := ld
+endif
+
+DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
+
+TEST_GEN_PROGS_EXTENDED += $(DEFAULT_BPFTOOL)
+
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
+
+BPFTOOL ?= $(DEFAULT_BPFTOOL)
+$(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
+		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
+	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
+		    ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD) 	       \
+		    EXTRA_CFLAGS='-g -O0'				       \
+		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
+		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/		       \
+		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/			       \
+		    prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin
+
+$(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
+	   $(APIDIR)/linux/bpf.h					       \
+	   | $(BUILD_DIR)/libbpf
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
+		    EXTRA_CFLAGS='-g -O0'				       \
+		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
+
+ifneq ($(BPFOBJ),$(HOST_BPFOBJ))
+$(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
+		$(APIDIR)/linux/bpf.h					       \
+		| $(HOST_BUILD_DIR)/libbpf
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
+		    EXTRA_CFLAGS='-g -O0' ARCH= CROSS_COMPILE=		       \
+		    OUTPUT=$(HOST_BUILD_DIR)/libbpf/ CC=$(HOSTCC) LD=$(HOSTLD) \
+		    DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
+endif
+
+$(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
+ifeq ($(VMLINUX_H),)
+	$(call msg,GEN,,$@)
+	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+else
+	$(call msg,CP,,$@)
+	$(Q)cp "$(VMLINUX_H)" $@
+endif
+
+$(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
+		       $(TOOLSDIR)/bpf/resolve_btfids/main.c	\
+		       $(TOOLSDIR)/lib/rbtree.c			\
+		       $(TOOLSDIR)/lib/zalloc.c			\
+		       $(TOOLSDIR)/lib/string.c			\
+		       $(TOOLSDIR)/lib/ctype.c			\
+		       $(TOOLSDIR)/lib/str_error_r.c
+	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/resolve_btfids	\
+		CC=$(HOSTCC) LD=$(HOSTLD) AR=$(HOSTAR) \
+		LIBBPF_INCLUDE=$(HOST_INCLUDE_DIR) \
+		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
+
+# Get Clang's default includes on this system, as opposed to those seen by
+# '-target bpf'. This fixes "missing" files on some architectures/distros,
+# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
+#
+# Use '-idirafter': Don't interfere with include mechanics except where the
+# build would have failed anyways.
+define get_sys_includes
+$(shell $(1) -v -E - </dev/null 2>&1 \
+	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
+$(shell $(1) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
+endef
+
+# Determine target endianness.
+IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
+			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
+MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
+
+CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
+BPF_CFLAGS = -g -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 		\
+	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
+	     -I$(abspath $(OUTPUT)/../usr/include)
+
+CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
+	       -Wno-compare-distinct-pointer-types
+
+# Build BPF object using Clang
+# $1 - input .c file
+# $2 - output .o file
+# $3 - CFLAGS
+define CLANG_BPF_BUILD_RULE
+	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
+	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -mcpu=v3 -o $2
+endef
+# Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
+define CLANG_NOALU32_BPF_BUILD_RULE
+	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
+	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -mcpu=v2 -o $2
+endef
+# Build BPF object using GCC
+define GCC_BPF_BUILD_RULE
+	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
+	$(Q)$(BPF_GCC) $3 -O2 -c $1 -o $2
+endef
+
+BPF_PROGS_DIR := progs
+BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
+BPF_SRCS := $(notdir $(wildcard $(BPF_PROGS_DIR)/*.c))
+BPF_OBJS := $(patsubst %.c,$(OUTPUT)/%.bpf.o, $(BPF_SRCS))
+BPF_SKELS := $(patsubst %.c,$(OUTPUT)/%.skel.h, $(BPF_SRCS))
+TEST_GEN_FILES += $(BPF_OBJS)
+
+$(BPF_PROGS_DIR)-bpfobjs := y
+$(BPF_OBJS): $(OUTPUT)/%.bpf.o:				\
+	     $(BPF_PROGS_DIR)/%.c			\
+	     $(wildcard $(BPF_PROGS_DIR)/*.h)		\
+	     $(INCLUDE_DIR)/vmlinux.h				\
+	     $(wildcard $(BPFDIR)/bpf_*.h)			\
+	     $(wildcard $(BPFDIR)/*.bpf.h)			\
+	     | $(OUTPUT) $(BPFOBJ)
+	$(call $(BPF_BUILD_RULE),$<,$@, $(BPF_CFLAGS))
+
+$(BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(OUTPUT)
+	$(call msg,GEN-SKEL,$(BINARY),$@)
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked1.o) $<
+	$(Q)$(BPFTOOL) gen skeleton $(<:.o=.linked1.o) name $(notdir $(<:.bpf.o=)) > $@
+
+$(OUTPUT)/%:%.c $(BPF_SKELS)
+	$(call msg,BINARY,,$@)
+	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
+
+EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR) feature bpftool	\
+	$(addprefix $(OUTPUT)/,*.o *.skel.h no_alu32)
diff --git a/tools/testing/selftests/hid/config b/tools/testing/selftests/hid/config
new file mode 100644
index 000000000000..d4130489c1b1
--- /dev/null
+++ b/tools/testing/selftests/hid/config
@@ -0,0 +1,20 @@
+CONFIG_BPF_EVENTS=y
+CONFIG_BPFILTER=y
+CONFIG_BPF_JIT_ALWAYS_ON=y
+CONFIG_BPF_JIT=y
+CONFIG_BPF_KPROBE_OVERRIDE=y
+CONFIG_BPF_LSM=y
+CONFIG_BPF_PRELOAD_UMD=y
+CONFIG_BPF_PRELOAD=y
+CONFIG_BPF_STREAM_PARSER=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_BPF=y
+CONFIG_CGROUP_BPF=y
+CONFIG_DEBUG_INFO_BTF=y
+CONFIG_FPROBE=y
+CONFIG_FTRACE_SYSCALLS=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_HIDRAW=y
+CONFIG_HID=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_UHID=y
diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
new file mode 100644
index 000000000000..3012fb95e6fc
--- /dev/null
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -0,0 +1,676 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Red Hat */
+#include "hid.skel.h"
+
+#include "../kselftest_harness.h"
+
+#include <bpf/bpf.h>
+#include <fcntl.h>
+#include <fnmatch.h>
+#include <dirent.h>
+#include <poll.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <linux/hid_bpf.h>
+#include <linux/hidraw.h>
+#include <linux/uhid.h>
+
+#define SHOW_UHID_DEBUG 0
+
+static unsigned char rdesc[] = {
+	0x06, 0x00, 0xff,	/* Usage Page (Vendor Defined Page 1) */
+	0x09, 0x21,		/* Usage (Vendor Usage 0x21) */
+	0xa1, 0x01,		/* COLLECTION (Application) */
+	0x09, 0x01,			/* Usage (Vendor Usage 0x01) */
+	0xa1, 0x00,			/* COLLECTION (Physical) */
+	0x85, 0x01,				/* REPORT_ID (1) */
+	0x06, 0x00, 0xff,			/* Usage Page (Vendor Defined Page 1) */
+	0x19, 0x01,				/* USAGE_MINIMUM (1) */
+	0x29, 0x03,				/* USAGE_MAXIMUM (3) */
+	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
+	0x25, 0x01,				/* LOGICAL_MAXIMUM (1) */
+	0x95, 0x03,				/* REPORT_COUNT (3) */
+	0x75, 0x01,				/* REPORT_SIZE (1) */
+	0x81, 0x02,				/* INPUT (Data,Var,Abs) */
+	0x95, 0x01,				/* REPORT_COUNT (1) */
+	0x75, 0x05,				/* REPORT_SIZE (5) */
+	0x81, 0x01,				/* INPUT (Cnst,Var,Abs) */
+	0x05, 0x01,				/* USAGE_PAGE (Generic Desktop) */
+	0x09, 0x30,				/* USAGE (X) */
+	0x09, 0x31,				/* USAGE (Y) */
+	0x15, 0x81,				/* LOGICAL_MINIMUM (-127) */
+	0x25, 0x7f,				/* LOGICAL_MAXIMUM (127) */
+	0x75, 0x10,				/* REPORT_SIZE (16) */
+	0x95, 0x02,				/* REPORT_COUNT (2) */
+	0x81, 0x06,				/* INPUT (Data,Var,Rel) */
+
+	0x06, 0x00, 0xff,			/* Usage Page (Vendor Defined Page 1) */
+	0x19, 0x01,				/* USAGE_MINIMUM (1) */
+	0x29, 0x03,				/* USAGE_MAXIMUM (3) */
+	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
+	0x25, 0x01,				/* LOGICAL_MAXIMUM (1) */
+	0x95, 0x03,				/* REPORT_COUNT (3) */
+	0x75, 0x01,				/* REPORT_SIZE (1) */
+	0x91, 0x02,				/* Output (Data,Var,Abs) */
+	0x95, 0x01,				/* REPORT_COUNT (1) */
+	0x75, 0x05,				/* REPORT_SIZE (5) */
+	0x91, 0x01,				/* Output (Cnst,Var,Abs) */
+
+	0x06, 0x00, 0xff,			/* Usage Page (Vendor Defined Page 1) */
+	0x19, 0x06,				/* USAGE_MINIMUM (6) */
+	0x29, 0x08,				/* USAGE_MAXIMUM (8) */
+	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
+	0x25, 0x01,				/* LOGICAL_MAXIMUM (1) */
+	0x95, 0x03,				/* REPORT_COUNT (3) */
+	0x75, 0x01,				/* REPORT_SIZE (1) */
+	0xb1, 0x02,				/* Feature (Data,Var,Abs) */
+	0x95, 0x01,				/* REPORT_COUNT (1) */
+	0x75, 0x05,				/* REPORT_SIZE (5) */
+	0x91, 0x01,				/* Output (Cnst,Var,Abs) */
+
+	0xc0,				/* END_COLLECTION */
+	0xc0,			/* END_COLLECTION */
+};
+
+struct attach_prog_args {
+	int prog_fd;
+	unsigned int hid;
+	int retval;
+};
+
+#define ASSERT_OK(data) ASSERT_FALSE(data)
+#define ASSERT_OK_PTR(ptr) ASSERT_NE(NULL, ptr)
+
+#define UHID_LOG(fmt, ...) do { \
+	if (SHOW_UHID_DEBUG) \
+		TH_LOG(fmt, ##__VA_ARGS__); \
+} while (0)
+
+static pthread_mutex_t uhid_started_mtx = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t uhid_started = PTHREAD_COND_INITIALIZER;
+
+/* no need to protect uhid_stopped, only one thread accesses it */
+static bool uhid_stopped;
+
+static int uhid_write(struct __test_metadata *_metadata, int fd, const struct uhid_event *ev)
+{
+	ssize_t ret;
+
+	ret = write(fd, ev, sizeof(*ev));
+	if (ret < 0) {
+		TH_LOG("Cannot write to uhid: %m");
+		return -errno;
+	} else if (ret != sizeof(*ev)) {
+		TH_LOG("Wrong size written to uhid: %zd != %zu",
+			ret, sizeof(ev));
+		return -EFAULT;
+	} else {
+		return 0;
+	}
+}
+
+static int uhid_create(struct __test_metadata *_metadata, int fd, int rand_nb)
+{
+	struct uhid_event ev;
+	char buf[25];
+
+	sprintf(buf, "test-uhid-device-%d", rand_nb);
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_CREATE;
+	strcpy((char *)ev.u.create.name, buf);
+	ev.u.create.rd_data = rdesc;
+	ev.u.create.rd_size = sizeof(rdesc);
+	ev.u.create.bus = BUS_USB;
+	ev.u.create.vendor = 0x0001;
+	ev.u.create.product = 0x0a37;
+	ev.u.create.version = 0;
+	ev.u.create.country = 0;
+
+	sprintf(buf, "%d", rand_nb);
+	strcpy((char *)ev.u.create.phys, buf);
+
+	return uhid_write(_metadata, fd, &ev);
+}
+
+static void uhid_destroy(struct __test_metadata *_metadata, int fd)
+{
+	struct uhid_event ev;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+
+	uhid_write(_metadata, fd, &ev);
+}
+
+static int uhid_event(struct __test_metadata *_metadata, int fd)
+{
+	struct uhid_event ev;
+	ssize_t ret;
+
+	memset(&ev, 0, sizeof(ev));
+	ret = read(fd, &ev, sizeof(ev));
+	if (ret == 0) {
+		UHID_LOG("Read HUP on uhid-cdev");
+		return -EFAULT;
+	} else if (ret < 0) {
+		UHID_LOG("Cannot read uhid-cdev: %m");
+		return -errno;
+	} else if (ret != sizeof(ev)) {
+		UHID_LOG("Invalid size read from uhid-dev: %zd != %zu",
+			ret, sizeof(ev));
+		return -EFAULT;
+	}
+
+	switch (ev.type) {
+	case UHID_START:
+		pthread_mutex_lock(&uhid_started_mtx);
+		pthread_cond_signal(&uhid_started);
+		pthread_mutex_unlock(&uhid_started_mtx);
+
+		UHID_LOG("UHID_START from uhid-dev");
+		break;
+	case UHID_STOP:
+		uhid_stopped = true;
+
+		UHID_LOG("UHID_STOP from uhid-dev");
+		break;
+	case UHID_OPEN:
+		UHID_LOG("UHID_OPEN from uhid-dev");
+		break;
+	case UHID_CLOSE:
+		UHID_LOG("UHID_CLOSE from uhid-dev");
+		break;
+	case UHID_OUTPUT:
+		UHID_LOG("UHID_OUTPUT from uhid-dev");
+		break;
+	case UHID_GET_REPORT:
+		UHID_LOG("UHID_GET_REPORT from uhid-dev");
+		break;
+	case UHID_SET_REPORT:
+		UHID_LOG("UHID_SET_REPORT from uhid-dev");
+		break;
+	default:
+		TH_LOG("Invalid event from uhid-dev: %u", ev.type);
+	}
+
+	return 0;
+}
+
+struct uhid_thread_args {
+	int fd;
+	struct __test_metadata *_metadata;
+};
+static void *uhid_read_events_thread(void *arg)
+{
+	struct uhid_thread_args *args = (struct uhid_thread_args *)arg;
+	struct __test_metadata *_metadata = args->_metadata;
+	struct pollfd pfds[1];
+	int fd = args->fd;
+	int ret = 0;
+
+	pfds[0].fd = fd;
+	pfds[0].events = POLLIN;
+
+	uhid_stopped = false;
+
+	while (!uhid_stopped) {
+		ret = poll(pfds, 1, 100);
+		if (ret < 0) {
+			TH_LOG("Cannot poll for fds: %m");
+			break;
+		}
+		if (pfds[0].revents & POLLIN) {
+			ret = uhid_event(_metadata, fd);
+			if (ret)
+				break;
+		}
+	}
+
+	return (void *)(long)ret;
+}
+
+static int uhid_start_listener(struct __test_metadata *_metadata, pthread_t *tid, int uhid_fd)
+{
+	struct uhid_thread_args args = {
+		.fd = uhid_fd,
+		._metadata = _metadata,
+	};
+	int err;
+
+	pthread_mutex_lock(&uhid_started_mtx);
+	err = pthread_create(tid, NULL, uhid_read_events_thread, (void *)&args);
+	ASSERT_EQ(0, err) {
+		TH_LOG("Could not start the uhid thread: %d", err);
+		pthread_mutex_unlock(&uhid_started_mtx);
+		close(uhid_fd);
+		return -EIO;
+	}
+	pthread_cond_wait(&uhid_started, &uhid_started_mtx);
+	pthread_mutex_unlock(&uhid_started_mtx);
+
+	return 0;
+}
+
+static int uhid_send_event(struct __test_metadata *_metadata, int fd, u8 *buf, size_t size)
+{
+	struct uhid_event ev;
+
+	if (size > sizeof(ev.u.input.data))
+		return -E2BIG;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_INPUT2;
+	ev.u.input2.size = size;
+
+	memcpy(ev.u.input2.data, buf, size);
+
+	return uhid_write(_metadata, fd, &ev);
+}
+
+static int setup_uhid(struct __test_metadata *_metadata, int rand_nb)
+{
+	int fd;
+	const char *path = "/dev/uhid";
+	int ret;
+
+	fd = open(path, O_RDWR | O_CLOEXEC);
+	ASSERT_GE(fd, 0) TH_LOG("open uhid-cdev failed; %d", fd);
+
+	ret = uhid_create(_metadata, fd, rand_nb);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("create uhid device failed: %d", ret);
+		close(fd);
+	}
+
+	return fd;
+}
+
+static bool match_sysfs_device(int dev_id, const char *workdir, struct dirent *dir)
+{
+	const char *target = "0003:0001:0A37.*";
+	char phys[512];
+	char uevent[1024];
+	char temp[512];
+	int fd, nread;
+	bool found = false;
+
+	if (fnmatch(target, dir->d_name, 0))
+		return false;
+
+	/* we found the correct VID/PID, now check for phys */
+	sprintf(uevent, "%s/%s/uevent", workdir, dir->d_name);
+
+	fd = open(uevent, O_RDONLY | O_NONBLOCK);
+	if (fd < 0)
+		return false;
+
+	sprintf(phys, "PHYS=%d", dev_id);
+
+	nread = read(fd, temp, ARRAY_SIZE(temp));
+	if (nread > 0 && (strstr(temp, phys)) != NULL)
+		found = true;
+
+	close(fd);
+
+	return found;
+}
+
+static int get_hid_id(int dev_id)
+{
+	const char *workdir = "/sys/devices/virtual/misc/uhid";
+	const char *str_id;
+	DIR *d;
+	struct dirent *dir;
+	int found = -1, attempts = 3;
+
+	/* it would be nice to be able to use nftw, but the no_alu32 target doesn't support it */
+
+	while (found < 0 && attempts > 0) {
+		attempts--;
+		d = opendir(workdir);
+		if (d) {
+			while ((dir = readdir(d)) != NULL) {
+				if (!match_sysfs_device(dev_id, workdir, dir))
+					continue;
+
+				str_id = dir->d_name + sizeof("0003:0001:0A37.");
+				found = (int)strtol(str_id, NULL, 16);
+
+				break;
+			}
+			closedir(d);
+		}
+		if (found < 0)
+			usleep(100000);
+	}
+
+	return found;
+}
+
+static int get_hidraw(int dev_id)
+{
+	const char *workdir = "/sys/devices/virtual/misc/uhid";
+	char sysfs[1024];
+	DIR *d, *subd;
+	struct dirent *dir, *subdir;
+	int i, found = -1;
+
+	/* retry 5 times in case the system is loaded */
+	for (i = 5; i > 0; i--) {
+		usleep(10);
+		d = opendir(workdir);
+
+		if (!d)
+			continue;
+
+		while ((dir = readdir(d)) != NULL) {
+			if (!match_sysfs_device(dev_id, workdir, dir))
+				continue;
+
+			sprintf(sysfs, "%s/%s/hidraw", workdir, dir->d_name);
+
+			subd = opendir(sysfs);
+			if (!subd)
+				continue;
+
+			while ((subdir = readdir(subd)) != NULL) {
+				if (fnmatch("hidraw*", subdir->d_name, 0))
+					continue;
+
+				found = atoi(subdir->d_name + strlen("hidraw"));
+			}
+
+			closedir(subd);
+
+			if (found > 0)
+				break;
+		}
+		closedir(d);
+	}
+
+	return found;
+}
+
+static int open_hidraw(int dev_id)
+{
+	int hidraw_number;
+	char hidraw_path[64] = { 0 };
+
+	hidraw_number = get_hidraw(dev_id);
+	if (hidraw_number < 0)
+		return hidraw_number;
+
+	/* open hidraw node to check the other side of the pipe */
+	sprintf(hidraw_path, "/dev/hidraw%d", hidraw_number);
+	return open(hidraw_path, O_RDWR | O_NONBLOCK);
+}
+
+FIXTURE(hid_bpf) {
+	int dev_id;
+	int uhid_fd;
+	int hidraw_fd;
+	int hid_id;
+	pthread_t tid;
+	struct hid *skel;
+};
+static void detach_bpf(FIXTURE_DATA(hid_bpf) * self)
+{
+	if (self->hidraw_fd)
+		close(self->hidraw_fd);
+	self->hidraw_fd = 0;
+
+	hid__destroy(self->skel);
+	self->skel = NULL;
+}
+
+FIXTURE_TEARDOWN(hid_bpf) {
+	void *uhid_err;
+
+	uhid_destroy(_metadata, self->uhid_fd);
+
+	detach_bpf(self);
+	pthread_join(self->tid, &uhid_err);
+}
+#define TEARDOWN_LOG(fmt, ...) do { \
+	TH_LOG(fmt, ##__VA_ARGS__); \
+	hid_bpf_teardown(_metadata, self, variant); \
+} while (0)
+
+FIXTURE_SETUP(hid_bpf)
+{
+	time_t t;
+	int err;
+
+	/* initialize random number generator */
+	srand((unsigned int)time(&t));
+
+	self->dev_id = rand() % 1024;
+
+	self->uhid_fd = setup_uhid(_metadata, self->dev_id);
+
+	/* locate the uev, self, variant);ent file of the created device */
+	self->hid_id = get_hid_id(self->dev_id);
+	ASSERT_GT(self->hid_id, 0)
+		TEARDOWN_LOG("Could not locate uhid device id: %d", self->hid_id);
+
+	err = uhid_start_listener(_metadata, &self->tid, self->uhid_fd);
+	ASSERT_EQ(0, err) TEARDOWN_LOG("could not start udev listener: %d", err);
+}
+
+struct test_program {
+	const char *name;
+};
+#define LOAD_PROGRAMS(progs) \
+	load_programs(progs, ARRAY_SIZE(progs), _metadata, self, variant)
+#define LOAD_BPF \
+	load_programs(NULL, 0, _metadata, self, variant)
+static void load_programs(const struct test_program programs[],
+			  const size_t progs_count,
+			  struct __test_metadata *_metadata,
+			  FIXTURE_DATA(hid_bpf) * self,
+			  const FIXTURE_VARIANT(hid_bpf) * variant)
+{
+	int attach_fd, err = -EINVAL;
+	struct attach_prog_args args = {
+		.retval = -1,
+	};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattr,
+			    .ctx_in = &args,
+			    .ctx_size_in = sizeof(args),
+	);
+
+	/* open the bpf file */
+	self->skel = hid__open();
+	ASSERT_OK_PTR(self->skel) TEARDOWN_LOG("Error while calling hid__open");
+
+	for (int i = 0; i < progs_count; i++) {
+		struct bpf_program *prog;
+
+		prog = bpf_object__find_program_by_name(*self->skel->skeleton->obj,
+							programs[i].name);
+		ASSERT_OK_PTR(prog) TH_LOG("can not find program by name '%s'", programs[i].name);
+
+		bpf_program__set_autoload(prog, true);
+	}
+
+	err = hid__load(self->skel);
+	ASSERT_OK(err) TH_LOG("hid_skel_load failed: %d", err);
+
+	attach_fd = bpf_program__fd(self->skel->progs.attach_prog);
+	ASSERT_GE(attach_fd, 0) TH_LOG("locate attach_prog: %d", attach_fd);
+
+	for (int i = 0; i < progs_count; i++) {
+		struct bpf_program *prog;
+
+		prog = bpf_object__find_program_by_name(*self->skel->skeleton->obj,
+							programs[i].name);
+		ASSERT_OK_PTR(prog) TH_LOG("can not find program by name '%s'", programs[i].name);
+
+		args.prog_fd = bpf_program__fd(prog);
+		args.hid = self->hid_id;
+		err = bpf_prog_test_run_opts(attach_fd, &tattr);
+		ASSERT_OK(args.retval) TH_LOG("attach_hid(%s): %d", programs[i].name, args.retval);
+	}
+
+	self->hidraw_fd = open_hidraw(self->dev_id);
+	ASSERT_GE(self->hidraw_fd, 0) TH_LOG("open_hidraw");
+}
+
+/*
+ * A simple test to see if the fixture is working fine.
+ * If this fails, none of the other tests will pass.
+ */
+TEST_F(hid_bpf, test_create_uhid)
+{
+}
+
+/*
+ * Attach hid_first_event to the given uhid device,
+ * retrieve and open the matching hidraw node,
+ * inject one event in the uhid device,
+ * check that the program sees it and can change the data
+ */
+TEST_F(hid_bpf, raw_event)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_first_event" },
+	};
+	u8 buf[10] = {0};
+	int err;
+
+	LOAD_PROGRAMS(progs);
+
+	/* check that the program is correctly loaded */
+	ASSERT_EQ(self->skel->data->callback_check, 52) TH_LOG("callback_check1");
+	ASSERT_EQ(self->skel->data->callback2_check, 52) TH_LOG("callback2_check1");
+
+	/* inject one event */
+	buf[0] = 1;
+	buf[1] = 42;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	/* check that hid_first_event() was executed */
+	ASSERT_EQ(self->skel->data->callback_check, 42) TH_LOG("callback_check1");
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 1);
+	ASSERT_EQ(buf[2], 47);
+
+	/* inject another event */
+	memset(buf, 0, sizeof(buf));
+	buf[0] = 1;
+	buf[1] = 47;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	/* check that hid_first_event() was executed */
+	ASSERT_EQ(self->skel->data->callback_check, 47) TH_LOG("callback_check1");
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[2], 52);
+}
+
+/*
+ * Ensures that we can attach/detach programs
+ */
+TEST_F(hid_bpf, test_attach_detach)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_first_event" },
+	};
+	u8 buf[10] = {0};
+	int err;
+
+	LOAD_PROGRAMS(progs);
+
+	/* inject one event */
+	buf[0] = 1;
+	buf[1] = 42;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 1);
+	ASSERT_EQ(buf[2], 47);
+
+	/* pin the program and immediately unpin it */
+#define PIN_PATH "/sys/fs/bpf/hid_first_event"
+	bpf_program__pin(self->skel->progs.hid_first_event, PIN_PATH);
+	remove(PIN_PATH);
+#undef PIN_PATH
+	usleep(100000);
+
+	/* detach the program */
+	detach_bpf(self);
+
+	self->hidraw_fd = open_hidraw(self->dev_id);
+	ASSERT_GE(self->hidraw_fd, 0) TH_LOG("open_hidraw");
+
+	/* inject another event */
+	memset(buf, 0, sizeof(buf));
+	buf[0] = 1;
+	buf[1] = 47;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw_no_bpf");
+	ASSERT_EQ(buf[0], 1);
+	ASSERT_EQ(buf[1], 47);
+	ASSERT_EQ(buf[2], 0);
+
+	/* re-attach our program */
+
+	LOAD_PROGRAMS(progs);
+
+	/* inject one event */
+	memset(buf, 0, sizeof(buf));
+	buf[0] = 1;
+	buf[1] = 42;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 1);
+	ASSERT_EQ(buf[2], 47);
+}
+
+static int libbpf_print_fn(enum libbpf_print_level level,
+			   const char *format, va_list args)
+{
+	char buf[1024];
+
+	if (level == LIBBPF_DEBUG)
+		return 0;
+
+	snprintf(buf, sizeof(buf), "# %s", format);
+
+	vfprintf(stdout, buf, args);
+	return 0;
+}
+
+static void __attribute__((constructor)) __constructor_order_last(void)
+{
+	if (!__constructor_order)
+		__constructor_order = _CONSTRUCTOR_ORDER_BACKWARD;
+}
+
+int main(int argc, char **argv)
+{
+	/* Use libbpf 1.0 API mode */
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+	libbpf_set_print(libbpf_print_fn);
+
+	return test_harness_run(argc, argv);
+}
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
new file mode 100644
index 000000000000..fc0a4241643a
--- /dev/null
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Red hat */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
+			      unsigned int offset,
+			      const size_t __sz) __ksym;
+extern int hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, u32 flags) __ksym;
+
+struct attach_prog_args {
+	int prog_fd;
+	unsigned int hid;
+	int retval;
+};
+
+__u64 callback_check = 52;
+__u64 callback2_check = 52;
+
+SEC("?fmod_ret/hid_bpf_device_event")
+int BPF_PROG(hid_first_event, struct hid_bpf_ctx *hid_ctx)
+{
+	__u8 *rw_data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 3 /* size */);
+
+	if (!rw_data)
+		return 0; /* EPERM check */
+
+	callback_check = rw_data[1];
+
+	rw_data[2] = rw_data[1] + 5;
+
+	return 0;
+}
+
+SEC("syscall")
+int attach_prog(struct attach_prog_args *ctx)
+{
+	ctx->retval = hid_bpf_attach_prog(ctx->hid,
+					  ctx->prog_fd,
+					  0);
+	return 0;
+}
-- 
2.36.1

