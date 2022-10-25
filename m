Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EB060C86F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 11:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiJYJhJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 05:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiJYJgb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 05:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF3E10537C
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666690534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQ58eWMeteP/o6U0RuJVONzeDh4cEP1mT76qEfnYxe4=;
        b=LLqlL5tlcW8X2d/smlS4ehaDRlzHJR6/B/0TcA5HSFjzmDhc9GX1C2D0Yi1AP+oMHT5jO+
        QT0RZpxKSQKbgu6YxrfrySAGBWrc+uCVVeVzUIjc3pTrGi7ADk5IxVCGEHuFEUXxL5amIb
        GXnvcRz3jTguJ5un7HSUNFy2vkRAQfY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-cjhFFK01O7-uKnZt16DOpQ-1; Tue, 25 Oct 2022 05:35:29 -0400
X-MC-Unique: cjhFFK01O7-uKnZt16DOpQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB6C43C0D843;
        Tue, 25 Oct 2022 09:35:28 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.195.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C04349BB62;
        Tue, 25 Oct 2022 09:35:27 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH hid v11 12/14] samples/hid: add new hid BPF example
Date:   Tue, 25 Oct 2022 11:34:56 +0200
Message-Id: <20221025093458.457089-13-benjamin.tissoires@redhat.com>
In-Reply-To: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
References: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
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

Everything should be available in the selftest part of the tree, but
providing an example without uhid and hidraw will be more easy to
follow for users.

This example will probably ever only work on the Etekcity Scroll 6E
because we need to adapt the various raw values to the actual device.

On that device, the X and Y axis will be swapped and inverted, and on
any other device, chances are high that the device will not work until
Ctrl-C is hit.

The Makefiles are taken from samples/bpf to not reinvent the wheel and
to force using in-kernel libbpf and bpftool.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v11:
- move the samples to samples/hid to not pollute bpf

no changes in v10

changes in v9:
- amended the usage part
- changed the title of the commit

no changes in v8

changes in v7:
- remove unnecessary __must_check definition

changes in v6:
- clean up code by removing old comments

changes in v5:
- bring back same features than v3, with the new API

changes in v4:
- dropped the not-yet-implemented rdesc_fixup
- use the new API

changes in v3:
- use the new hid_get_data API
- add a comment for the report descriptor fixup to explain what is done

changes in v2:
- split the series by bpf/libbpf/hid/selftests and samples
---
 MAINTAINERS                 |   1 +
 samples/hid/.gitignore      |   7 ++
 samples/hid/Makefile        | 243 ++++++++++++++++++++++++++++++++++++
 samples/hid/Makefile.target |  75 +++++++++++
 samples/hid/hid_mouse.bpf.c | 134 ++++++++++++++++++++
 samples/hid/hid_mouse.c     | 160 ++++++++++++++++++++++++
 6 files changed, 620 insertions(+)
 create mode 100644 samples/hid/.gitignore
 create mode 100644 samples/hid/Makefile
 create mode 100644 samples/hid/Makefile.target
 create mode 100644 samples/hid/hid_mouse.bpf.c
 create mode 100644 samples/hid/hid_mouse.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 514e05ddac18..b3e16057834a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9097,6 +9097,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
 F:	drivers/hid/
 F:	include/linux/hid*
 F:	include/uapi/linux/hid*
+F:	samples/hid/
 F:	tools/testing/selftests/hid/
 
 HID LOGITECH DRIVERS
diff --git a/samples/hid/.gitignore b/samples/hid/.gitignore
new file mode 100644
index 000000000000..8cb45592e29a
--- /dev/null
+++ b/samples/hid/.gitignore
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+hid_mouse
+*.out
+*.skel.h
+/vmlinux.h
+/bpftool/
+/libbpf/
diff --git a/samples/hid/Makefile b/samples/hid/Makefile
new file mode 100644
index 000000000000..f52b2d811976
--- /dev/null
+++ b/samples/hid/Makefile
@@ -0,0 +1,243 @@
+# SPDX-License-Identifier: GPL-2.0
+
+HID_SAMPLES_PATH ?= $(abspath $(srctree)/$(src))
+TOOLS_PATH := $(HID_SAMPLES_PATH)/../../tools
+
+pound := \#
+
+# List of programs to build
+tprogs-y += hid_mouse
+
+# Libbpf dependencies
+LIBBPF_SRC = $(TOOLS_PATH)/lib/bpf
+LIBBPF_OUTPUT = $(abspath $(HID_SAMPLES_PATH))/libbpf
+LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
+LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
+LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
+
+hid_mouse-objs := hid_mouse.o
+
+# Tell kbuild to always build the programs
+always-y := $(tprogs-y)
+
+ifeq ($(ARCH), arm)
+# Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
+# headers when arm instruction set identification is requested.
+ARM_ARCH_SELECTOR := $(filter -D__LINUX_ARM_ARCH__%, $(KBUILD_CFLAGS))
+BPF_EXTRA_CFLAGS := $(ARM_ARCH_SELECTOR)
+TPROGS_CFLAGS += $(ARM_ARCH_SELECTOR)
+endif
+
+ifeq ($(ARCH), mips)
+TPROGS_CFLAGS += -D__SANE_USERSPACE_TYPES__
+ifdef CONFIG_MACH_LOONGSON64
+BPF_EXTRA_CFLAGS += -I$(srctree)/arch/mips/include/asm/mach-loongson64
+BPF_EXTRA_CFLAGS += -I$(srctree)/arch/mips/include/asm/mach-generic
+endif
+endif
+
+TPROGS_CFLAGS += -Wall -O2
+TPROGS_CFLAGS += -Wmissing-prototypes
+TPROGS_CFLAGS += -Wstrict-prototypes
+
+TPROGS_CFLAGS += -I$(objtree)/usr/include
+TPROGS_CFLAGS += -I$(LIBBPF_INCLUDE)
+TPROGS_CFLAGS += -I$(srctree)/tools/include
+
+ifdef SYSROOT
+TPROGS_CFLAGS += --sysroot=$(SYSROOT)
+TPROGS_LDFLAGS := -L$(SYSROOT)/usr/lib
+endif
+
+TPROGS_LDLIBS			+= $(LIBBPF) -lelf -lz
+
+# Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
+# make M=samples/bpf LLC=~/git/llvm-project/llvm/build/bin/llc CLANG=~/git/llvm-project/llvm/build/bin/clang
+LLC ?= llc
+CLANG ?= clang
+OPT ?= opt
+LLVM_DIS ?= llvm-dis
+LLVM_OBJCOPY ?= llvm-objcopy
+LLVM_READELF ?= llvm-readelf
+BTF_PAHOLE ?= pahole
+
+# Detect that we're cross compiling and use the cross compiler
+ifdef CROSS_COMPILE
+CLANG_ARCH_ARGS = --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif
+
+# Don't evaluate probes and warnings if we need to run make recursively
+ifneq ($(src),)
+HDR_PROBE := $(shell printf "$(pound)include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
+	$(CC) $(TPROGS_CFLAGS) $(TPROGS_LDFLAGS) -x c - \
+	-o /dev/null 2>/dev/null && echo okay)
+
+ifeq ($(HDR_PROBE),)
+$(warning WARNING: Detected possible issues with include path.)
+$(warning WARNING: Please install kernel headers locally (make headers_install).)
+endif
+
+BTF_LLC_PROBE := $(shell $(LLC) -march=bpf -mattr=help 2>&1 | grep dwarfris)
+BTF_PAHOLE_PROBE := $(shell $(BTF_PAHOLE) --help 2>&1 | grep BTF)
+BTF_OBJCOPY_PROBE := $(shell $(LLVM_OBJCOPY) --help 2>&1 | grep -i 'usage.*llvm')
+BTF_LLVM_PROBE := $(shell echo "int main() { return 0; }" | \
+			  $(CLANG) -target bpf -O2 -g -c -x c - -o ./llvm_btf_verify.o; \
+			  $(LLVM_READELF) -S ./llvm_btf_verify.o | grep BTF; \
+			  /bin/rm -f ./llvm_btf_verify.o)
+
+BPF_EXTRA_CFLAGS += -fno-stack-protector
+ifneq ($(BTF_LLVM_PROBE),)
+	BPF_EXTRA_CFLAGS += -g
+else
+ifneq ($(and $(BTF_LLC_PROBE),$(BTF_PAHOLE_PROBE),$(BTF_OBJCOPY_PROBE)),)
+	BPF_EXTRA_CFLAGS += -g
+	LLC_FLAGS += -mattr=dwarfris
+	DWARF2BTF = y
+endif
+endif
+endif
+
+# Trick to allow make to be run from this directory
+all:
+	$(MAKE) -C ../../ M=$(CURDIR) HID_SAMPLES_PATH=$(CURDIR)
+
+clean:
+	$(MAKE) -C ../../ M=$(CURDIR) clean
+	@find $(CURDIR) -type f -name '*~' -delete
+	@$(RM) -r $(CURDIR)/libbpf $(CURDIR)/bpftool
+
+$(LIBBPF): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUTPUT)
+# Fix up variables inherited from Kbuild that tools/ build system won't like
+	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(TPROGS_CFLAGS)" \
+		LDFLAGS=$(TPROGS_LDFLAGS) srctree=$(HID_SAMPLES_PATH)/../../ \
+		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
+		$@ install_headers
+
+BPFTOOLDIR := $(TOOLS_PATH)/bpf/bpftool
+BPFTOOL_OUTPUT := $(abspath $(HID_SAMPLES_PATH))/bpftool
+BPFTOOL := $(BPFTOOL_OUTPUT)/bootstrap/bpftool
+$(BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile) | $(BPFTOOL_OUTPUT)
+	$(MAKE) -C $(BPFTOOLDIR) srctree=$(HID_SAMPLES_PATH)/../../ 		\
+		OUTPUT=$(BPFTOOL_OUTPUT)/ bootstrap
+
+$(LIBBPF_OUTPUT) $(BPFTOOL_OUTPUT):
+	$(call msg,MKDIR,$@)
+	$(Q)mkdir -p $@
+
+FORCE:
+
+
+# Verify LLVM compiler tools are available and bpf target is supported by llc
+.PHONY: verify_cmds verify_target_bpf $(CLANG) $(LLC)
+
+verify_cmds: $(CLANG) $(LLC)
+	@for TOOL in $^ ; do \
+		if ! (which -- "$${TOOL}" > /dev/null 2>&1); then \
+			echo "*** ERROR: Cannot find LLVM tool $${TOOL}" ;\
+			exit 1; \
+		else true; fi; \
+	done
+
+verify_target_bpf: verify_cmds
+	@if ! (${LLC} -march=bpf -mattr=help > /dev/null 2>&1); then \
+		echo "*** ERROR: LLVM (${LLC}) does not support 'bpf' target" ;\
+		echo "   NOTICE: LLVM version >= 3.7.1 required" ;\
+		exit 2; \
+	else true; fi
+
+$(HID_SAMPLES_PATH)/*.c: verify_target_bpf $(LIBBPF)
+$(src)/*.c: verify_target_bpf $(LIBBPF)
+
+libbpf_hdrs: $(LIBBPF)
+
+.PHONY: libbpf_hdrs
+
+$(obj)/hid_mouse.o: $(obj)/hid_mouse.skel.h
+
+-include $(HID_SAMPLES_PATH)/Makefile.target
+
+VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))				\
+		     $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux))	\
+		     $(abspath ./vmlinux)
+VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+
+$(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
+ifeq ($(VMLINUX_H),)
+ifeq ($(VMLINUX_BTF),)
+	$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)",\
+		build the kernel or set VMLINUX_BTF or VMLINUX_H variable)
+endif
+	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+else
+	$(Q)cp "$(VMLINUX_H)" $@
+endif
+
+clean-files += vmlinux.h
+
+# Get Clang's default includes on this system, as opposed to those seen by
+# '-target bpf'. This fixes "missing" files on some architectures/distros,
+# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
+#
+# Use '-idirafter': Don't interfere with include mechanics except where the
+# build would have failed anyways.
+define get_sys_includes
+$(shell $(1) -v -E - </dev/null 2>&1 \
+        | sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
+$(shell $(1) -dM -E - </dev/null | grep '#define __riscv_xlen ' | sed 's/#define /-D/' | sed 's/ /=/')
+endef
+
+CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
+
+
+$(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h
+	@echo "  CLANG-BPF " $@
+	$(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
+		-Wno-compare-distinct-pointer-types -I$(srctree)/include \
+		-I$(srctree)/samples/bpf -I$(srctree)/tools/include \
+		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
+		-c $(filter %.bpf.c,$^) -o $@
+
+LINKED_SKELS := hid_mouse.skel.h
+clean-files += $(LINKED_SKELS)
+
+hid_mouse.skel.h-deps := hid_mouse.bpf.o
+hid_surface_dial.skel.h-deps := hid_surface_dial.bpf.o
+
+LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
+
+BPF_SRCS_LINKED := $(notdir $(wildcard $(src)/*.bpf.c))
+BPF_OBJS_LINKED := $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_LINKED))
+BPF_SKELS_LINKED := $(addprefix $(obj)/,$(LINKED_SKELS))
+
+$(BPF_SKELS_LINKED): $(BPF_OBJS_LINKED) $(BPFTOOL)
+	@echo "  BPF GEN-OBJ " $(@:.skel.h=)
+	$(Q)$(BPFTOOL) gen object $(@:.skel.h=.lbpf.o) $(addprefix $(obj)/,$($(@F)-deps))
+	@echo "  BPF GEN-SKEL" $(@:.skel.h=)
+	$(Q)$(BPFTOOL) gen skeleton $(@:.skel.h=.lbpf.o) name $(notdir $(@:.skel.h=)) > $@
+
+# asm/sysreg.h - inline assembly used by it is incompatible with llvm.
+# But, there is no easy way to fix it, so just exclude it since it is
+# useless for BPF samples.
+# below we use long chain of commands, clang | opt | llvm-dis | llc,
+# to generate final object file. 'clang' compiles the source into IR
+# with native target, e.g., x64, arm64, etc. 'opt' does bpf CORE IR builtin
+# processing (llvm12) and IR optimizations. 'llvm-dis' converts
+# 'opt' output to IR, and finally 'llc' generates bpf byte code.
+$(obj)/%.o: $(src)/%.c
+	@echo "  CLANG-bpf " $@
+	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS) \
+		-I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
+		-I$(LIBBPF_INCLUDE) \
+		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
+		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
+		-Wno-gnu-variable-sized-type-not-at-end \
+		-Wno-address-of-packed-member -Wno-tautological-compare \
+		-Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
+		-fno-asynchronous-unwind-tables \
+		-I$(srctree)/samples/hid/ \
+		-O2 -emit-llvm -Xclang -disable-llvm-passes -c $< -o - | \
+		$(OPT) -O2 -mtriple=bpf-pc-linux | $(LLVM_DIS) | \
+		$(LLC) -march=bpf $(LLC_FLAGS) -filetype=obj -o $@
+ifeq ($(DWARF2BTF),y)
+	$(BTF_PAHOLE) -J $@
+endif
diff --git a/samples/hid/Makefile.target b/samples/hid/Makefile.target
new file mode 100644
index 000000000000..7621f55e2947
--- /dev/null
+++ b/samples/hid/Makefile.target
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Building binaries on the host system
+# Binaries are not used during the compilation of the kernel, and intended
+# to be build for target board, target board can be host of course. Added to
+# build binaries to run not on host system.
+#
+# Sample syntax
+# tprogs-y := xsk_example
+# Will compile xsk_example.c and create an executable named xsk_example
+#
+# tprogs-y    := xdpsock
+# xdpsock-objs := xdpsock_1.o xdpsock_2.o
+# Will compile xdpsock_1.c and xdpsock_2.c, and then link the executable
+# xdpsock, based on xdpsock_1.o and xdpsock_2.o
+#
+# Derived from scripts/Makefile.host
+#
+__tprogs := $(sort $(tprogs-y))
+
+# C code
+# Executables compiled from a single .c file
+tprog-csingle	:= $(foreach m,$(__tprogs), \
+			$(if $($(m)-objs),,$(m)))
+
+# C executables linked based on several .o files
+tprog-cmulti	:= $(foreach m,$(__tprogs),\
+			$(if $($(m)-objs),$(m)))
+
+# Object (.o) files compiled from .c files
+tprog-cobjs	:= $(sort $(foreach m,$(__tprogs),$($(m)-objs)))
+
+tprog-csingle	:= $(addprefix $(obj)/,$(tprog-csingle))
+tprog-cmulti	:= $(addprefix $(obj)/,$(tprog-cmulti))
+tprog-cobjs	:= $(addprefix $(obj)/,$(tprog-cobjs))
+
+#####
+# Handle options to gcc. Support building with separate output directory
+
+_tprogc_flags   = $(TPROGS_CFLAGS) \
+                 $(TPROGCFLAGS_$(basetarget).o)
+
+# $(objtree)/$(obj) for including generated headers from checkin source files
+ifeq ($(KBUILD_EXTMOD),)
+ifdef building_out_of_srctree
+_tprogc_flags   += -I $(objtree)/$(obj)
+endif
+endif
+
+tprogc_flags    = -Wp,-MD,$(depfile) $(_tprogc_flags)
+
+# Create executable from a single .c file
+# tprog-csingle -> Executable
+quiet_cmd_tprog-csingle 	= CC  $@
+      cmd_tprog-csingle	= $(CC) $(tprogc_flags) $(TPROGS_LDFLAGS) -o $@ $< \
+		$(TPROGS_LDLIBS) $(TPROGLDLIBS_$(@F))
+$(tprog-csingle): $(obj)/%: $(src)/%.c FORCE
+	$(call if_changed_dep,tprog-csingle)
+
+# Link an executable based on list of .o files, all plain c
+# tprog-cmulti -> executable
+quiet_cmd_tprog-cmulti	= LD  $@
+      cmd_tprog-cmulti	= $(CC) $(tprogc_flags) $(TPROGS_LDFLAGS) -o $@ \
+			  $(addprefix $(obj)/,$($(@F)-objs)) \
+			  $(TPROGS_LDLIBS) $(TPROGLDLIBS_$(@F))
+$(tprog-cmulti): $(tprog-cobjs) FORCE
+	$(call if_changed,tprog-cmulti)
+$(call multi_depend, $(tprog-cmulti), , -objs)
+
+# Create .o file from a single .c file
+# tprog-cobjs -> .o
+quiet_cmd_tprog-cobjs	= CC  $@
+      cmd_tprog-cobjs	= $(CC) $(tprogc_flags) -c -o $@ $<
+$(tprog-cobjs): $(obj)/%.o: $(src)/%.c FORCE
+	$(call if_changed_dep,tprog-cobjs)
diff --git a/samples/hid/hid_mouse.bpf.c b/samples/hid/hid_mouse.bpf.c
new file mode 100644
index 000000000000..0113e603f7a7
--- /dev/null
+++ b/samples/hid/hid_mouse.bpf.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/* following are kfuncs exported by HID for HID-BPF */
+extern int hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, u32 flags) __ksym;
+extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
+			      unsigned int offset,
+			      const size_t __sz) __ksym;
+extern void hid_bpf_data_release(__u8 *data) __ksym;
+extern int hid_bpf_hw_request(struct hid_bpf_ctx *ctx) __ksym;
+
+struct attach_prog_args {
+	int prog_fd;
+	unsigned int hid;
+	int retval;
+};
+
+SEC("syscall")
+int attach_prog(struct attach_prog_args *ctx)
+{
+	ctx->retval = hid_bpf_attach_prog(ctx->hid,
+					  ctx->prog_fd,
+					  0);
+	return 0;
+}
+
+SEC("fmod_ret/hid_bpf_device_event")
+int BPF_PROG(hid_y_event, struct hid_bpf_ctx *hctx)
+{
+	s16 y;
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 9 /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	bpf_printk("event: size: %d", hctx->size);
+	bpf_printk("incoming event: %02x %02x %02x",
+		   data[0],
+		   data[1],
+		   data[2]);
+	bpf_printk("                %02x %02x %02x",
+		   data[3],
+		   data[4],
+		   data[5]);
+	bpf_printk("                %02x %02x %02x",
+		   data[6],
+		   data[7],
+		   data[8]);
+
+	y = data[3] | (data[4] << 8);
+
+	y = -y;
+
+	data[3] = y & 0xFF;
+	data[4] = (y >> 8) & 0xFF;
+
+	bpf_printk("modified event: %02x %02x %02x",
+		   data[0],
+		   data[1],
+		   data[2]);
+	bpf_printk("                %02x %02x %02x",
+		   data[3],
+		   data[4],
+		   data[5]);
+	bpf_printk("                %02x %02x %02x",
+		   data[6],
+		   data[7],
+		   data[8]);
+
+	return 0;
+}
+
+SEC("fmod_ret/hid_bpf_device_event")
+int BPF_PROG(hid_x_event, struct hid_bpf_ctx *hctx)
+{
+	s16 x;
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 9 /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	x = data[1] | (data[2] << 8);
+
+	x = -x;
+
+	data[1] = x & 0xFF;
+	data[2] = (x >> 8) & 0xFF;
+	return 0;
+}
+
+SEC("fmod_ret/hid_bpf_rdesc_fixup")
+int BPF_PROG(hid_rdesc_fixup, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4096 /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	bpf_printk("rdesc: %02x %02x %02x",
+		   data[0],
+		   data[1],
+		   data[2]);
+	bpf_printk("       %02x %02x %02x",
+		   data[3],
+		   data[4],
+		   data[5]);
+	bpf_printk("       %02x %02x %02x ...",
+		   data[6],
+		   data[7],
+		   data[8]);
+
+	/*
+	 * The original report descriptor contains:
+	 *
+	 * 0x05, 0x01,                    //   Usage Page (Generic Desktop)      30
+	 * 0x16, 0x01, 0x80,              //   Logical Minimum (-32767)          32
+	 * 0x26, 0xff, 0x7f,              //   Logical Maximum (32767)           35
+	 * 0x09, 0x30,                    //   Usage (X)                         38
+	 * 0x09, 0x31,                    //   Usage (Y)                         40
+	 *
+	 * So byte 39 contains Usage X and byte 41 Usage Y.
+	 *
+	 * We simply swap the axes here.
+	 */
+	data[39] = 0x31;
+	data[41] = 0x30;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/samples/hid/hid_mouse.c b/samples/hid/hid_mouse.c
new file mode 100644
index 000000000000..3550cef3eed9
--- /dev/null
+++ b/samples/hid/hid_mouse.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022 Benjamin Tissoires
+ *
+ * This is a pure HID-BPF example, and should be considered as such:
+ * on the Etekcity Scroll 6E, the X and Y axes will be swapped and
+ * inverted. On any other device... Not sure what this will do.
+ *
+ * This C main file is generic though. To adapt the code and test, users
+ * must amend only the .bpf.c file, which this program will load any
+ * eBPF program it finds.
+ */
+
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <libgen.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <unistd.h>
+
+#include <linux/bpf.h>
+#include <linux/errno.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include "hid_mouse.skel.h"
+
+static bool running = true;
+
+struct attach_prog_args {
+	int prog_fd;
+	unsigned int hid;
+	int retval;
+};
+
+static void int_exit(int sig)
+{
+	running = false;
+	exit(0);
+}
+
+static void usage(const char *prog)
+{
+	fprintf(stderr,
+		"%s: %s /sys/bus/hid/devices/0BUS:0VID:0PID:00ID\n\n",
+		__func__, prog);
+	fprintf(stderr,
+		"This program will upload and attach a HID-BPF program to the given device.\n"
+		"On the Etekcity Scroll 6E, the X and Y axis will be inverted, but on any other\n"
+		"device, chances are high that the device will not be working anymore\n\n"
+		"consider this as a demo and adapt the eBPF program to your needs\n"
+		"Hit Ctrl-C to unbind the program and reset the device\n");
+}
+
+static int get_hid_id(const char *path)
+{
+	const char *str_id, *dir;
+	char uevent[1024];
+	int fd;
+
+	memset(uevent, 0, sizeof(uevent));
+	snprintf(uevent, sizeof(uevent) - 1, "%s/uevent", path);
+
+	fd = open(uevent, O_RDONLY | O_NONBLOCK);
+	if (fd < 0)
+		return -ENOENT;
+
+	close(fd);
+
+	dir = basename((char *)path);
+
+	str_id = dir + sizeof("0003:0001:0A37.");
+	return (int)strtol(str_id, NULL, 16);
+}
+
+int main(int argc, char **argv)
+{
+	struct hid_mouse *skel;
+	struct bpf_program *prog;
+	int err;
+	const char *optstr = "";
+	const char *sysfs_path;
+	int opt, hid_id, attach_fd;
+	struct attach_prog_args args = {
+		.retval = -1,
+	};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattr,
+			    .ctx_in = &args,
+			    .ctx_size_in = sizeof(args),
+	);
+
+	while ((opt = getopt(argc, argv, optstr)) != -1) {
+		switch (opt) {
+		default:
+			usage(basename(argv[0]));
+			return 1;
+		}
+	}
+
+	if (optind == argc) {
+		usage(basename(argv[0]));
+		return 1;
+	}
+
+	sysfs_path = argv[optind];
+	if (!sysfs_path) {
+		perror("sysfs");
+		return 1;
+	}
+
+	skel = hid_mouse__open_and_load();
+	if (!skel) {
+		fprintf(stderr, "%s  %s:%d", __func__, __FILE__, __LINE__);
+		return -1;
+	}
+
+	hid_id = get_hid_id(sysfs_path);
+
+	if (hid_id < 0) {
+		fprintf(stderr, "can not open HID device: %m\n");
+		return 1;
+	}
+	args.hid = hid_id;
+
+	attach_fd = bpf_program__fd(skel->progs.attach_prog);
+	if (attach_fd < 0) {
+		fprintf(stderr, "can't locate attach prog: %m\n");
+		return 1;
+	}
+
+	bpf_object__for_each_program(prog, *skel->skeleton->obj) {
+		/* ignore syscalls */
+		if (bpf_program__get_type(prog) != BPF_PROG_TYPE_TRACING)
+			continue;
+
+		args.retval = -1;
+		args.prog_fd = bpf_program__fd(prog);
+		err = bpf_prog_test_run_opts(attach_fd, &tattr);
+		if (err) {
+			fprintf(stderr, "can't attach prog to hid device %d: %m (err: %d)\n",
+				hid_id, err);
+			return 1;
+		}
+	}
+
+	signal(SIGINT, int_exit);
+	signal(SIGTERM, int_exit);
+
+	while (running)
+		sleep(1);
+
+	hid_mouse__destroy(skel);
+
+	return 0;
+}
-- 
2.36.1

