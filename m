Return-Path: <linux-kselftest+bounces-10782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4178A8D1C86
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 15:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A8B0B23384
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9194171652;
	Tue, 28 May 2024 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR7CJYkf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5B917109F;
	Tue, 28 May 2024 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902135; cv=none; b=Xjiscujx1Dhgfc+ZtYYZxITxt6uXbeTTOzc9OhT4wYCt7cFM1xsAgDvDnBMbKK6GnJElWZEOI6FIXuSbuiMsnimOaDUkQ7zKvUGFwOgntLNW6ch4R6EGVg+P28Ct41t3EIXfqw1DrzqKqJAdanvRQ+QNZSx3ypTcrc0TcqqkhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902135; c=relaxed/simple;
	bh=8TtmKzskCffvmEzfSvuVmB1Ck3elvFNnCVCPNiogbA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MJkoLjkQGw3fvBgWvmCEIm1mkeiUGU7y9TfTqvBOcgXeQUZyh1epMcvnGusI7X12f+5HMpb/dq8Ivaj5pICtceSutLz05mDE0uPgJoWC9ndgRZo+zDm/KQTM+kC9u3bbWRrrky+q/d6RvzDQT+BrapNq7wyP224SXiUEzFsSqIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WR7CJYkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F373DC32789;
	Tue, 28 May 2024 13:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716902135;
	bh=8TtmKzskCffvmEzfSvuVmB1Ck3elvFNnCVCPNiogbA0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WR7CJYkfgTLAVkkHABUuOO3sPjxqKwpSypEQ9dn+TTz8xDAPOxkPe+ZPDGuJYI1v9
	 g8OwzrpwH7M9ZG9K9e3WCH4CDhvr8TZAKGkLBU8BSbjS6LXapSgWp5o0dAHz/tVR3W
	 BdAr4Bxn/bTmG8pBQuVv77Zo7Bmck78jW93QlDE+rncp1A0eauB93LgIokkFKpl9bB
	 eMvb7wRKOo5RkB9zQH5cbqCJ0B3pfI3MtfzPSjZO1Qr+qFYR65bWx9AFU6MBe6nHQM
	 0yp6Kl86QZCS6kPENdN504KzVi8ZYaUsTy+bRwJ+V8o3UseK57KfX+Aq8Fv7YAdQRZ
	 K+d3qqxRW6kiQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 28 May 2024 15:14:46 +0200
Subject: [PATCH HID 08/13] HID: bpf: remove tracing HID-BPF capability
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-hid_bpf_struct_ops-v1-8-8c6663df27d8@kernel.org>
References: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
In-Reply-To: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716902113; l=48085;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=8TtmKzskCffvmEzfSvuVmB1Ck3elvFNnCVCPNiogbA0=;
 b=oScMCchMR5Q3HLt0mkFyZ6mS/5Zq80ArDrJR1LF1WBEYIqNvSSnvxSgZeywDVCsiYp/3tuGqh
 Lj/qwECWDd+BegICDJiVG7Ifey+8frvRlJl8QtULzYlYDNdg+OqvrJh
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We can now rely on struct_ops as we cleared the users in-tree.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/Makefile                        |   2 +-
 drivers/hid/bpf/entrypoints/Makefile            |  93 ----
 drivers/hid/bpf/entrypoints/README              |   4 -
 drivers/hid/bpf/entrypoints/entrypoints.bpf.c   |  25 --
 drivers/hid/bpf/entrypoints/entrypoints.lskel.h | 248 -----------
 drivers/hid/bpf/hid_bpf_dispatch.c              | 193 +-------
 drivers/hid/bpf/hid_bpf_dispatch.h              |   8 -
 drivers/hid/bpf/hid_bpf_jmp_table.c             | 568 ------------------------
 include/linux/hid_bpf.h                         |  37 +-
 9 files changed, 8 insertions(+), 1170 deletions(-)

diff --git a/drivers/hid/bpf/Makefile b/drivers/hid/bpf/Makefile
index 1cb3f31e9335..d1f2b81788ca 100644
--- a/drivers/hid/bpf/Makefile
+++ b/drivers/hid/bpf/Makefile
@@ -8,4 +8,4 @@ LIBBPF_INCLUDE = $(srctree)/tools/lib
 obj-$(CONFIG_HID_BPF) += hid_bpf.o
 CFLAGS_hid_bpf_dispatch.o += -I$(LIBBPF_INCLUDE)
 CFLAGS_hid_bpf_jmp_table.o += -I$(LIBBPF_INCLUDE)
-hid_bpf-objs += hid_bpf_dispatch.o hid_bpf_jmp_table.o hid_bpf_struct_ops.o
+hid_bpf-objs += hid_bpf_dispatch.o hid_bpf_struct_ops.o
diff --git a/drivers/hid/bpf/entrypoints/Makefile b/drivers/hid/bpf/entrypoints/Makefile
deleted file mode 100644
index 43b99b5575cf..000000000000
--- a/drivers/hid/bpf/entrypoints/Makefile
+++ /dev/null
@@ -1,93 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-OUTPUT := .output
-abs_out := $(abspath $(OUTPUT))
-
-CLANG ?= clang
-LLC ?= llc
-LLVM_STRIP ?= llvm-strip
-
-TOOLS_PATH := $(abspath ../../../../tools)
-BPFTOOL_SRC := $(TOOLS_PATH)/bpf/bpftool
-BPFTOOL_OUTPUT := $(abs_out)/bpftool
-DEFAULT_BPFTOOL := $(BPFTOOL_OUTPUT)/bootstrap/bpftool
-BPFTOOL ?= $(DEFAULT_BPFTOOL)
-
-LIBBPF_SRC := $(TOOLS_PATH)/lib/bpf
-LIBBPF_OUTPUT := $(abs_out)/libbpf
-LIBBPF_DESTDIR := $(LIBBPF_OUTPUT)
-LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)/include
-BPFOBJ := $(LIBBPF_OUTPUT)/libbpf.a
-
-INCLUDES := -I$(OUTPUT) -I$(LIBBPF_INCLUDE) -I$(TOOLS_PATH)/include/uapi
-CFLAGS := -g -Wall
-
-VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
-		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
-		     ../../../../vmlinux				\
-		     /sys/kernel/btf/vmlinux				\
-		     /boot/vmlinux-$(shell uname -r)
-VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
-ifeq ($(VMLINUX_BTF),)
-$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
-endif
-
-ifeq ($(V),1)
-Q =
-msg =
-else
-Q = @
-msg = @printf '  %-8s %s%s\n' "$(1)" "$(notdir $(2))" "$(if $(3), $(3))";
-MAKEFLAGS += --no-print-directory
-submake_extras := feature_display=0
-endif
-
-.DELETE_ON_ERROR:
-
-.PHONY: all clean
-
-all: entrypoints.lskel.h
-
-clean:
-	$(call msg,CLEAN)
-	$(Q)rm -rf $(OUTPUT) entrypoints
-
-entrypoints.lskel.h: $(OUTPUT)/entrypoints.bpf.o | $(BPFTOOL)
-	$(call msg,GEN-SKEL,$@)
-	$(Q)$(BPFTOOL) gen skeleton -L $< > $@
-
-
-$(OUTPUT)/entrypoints.bpf.o: entrypoints.bpf.c $(OUTPUT)/vmlinux.h $(BPFOBJ) | $(OUTPUT)
-	$(call msg,BPF,$@)
-	$(Q)$(CLANG) -g -O2 --target=bpf $(INCLUDES)			      \
-		 -c $(filter %.c,$^) -o $@ &&				      \
-	$(LLVM_STRIP) -g $@
-
-$(OUTPUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
-ifeq ($(VMLINUX_H),)
-	$(call msg,GEN,,$@)
-	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
-else
-	$(call msg,CP,,$@)
-	$(Q)cp "$(VMLINUX_H)" $@
-endif
-
-$(OUTPUT) $(LIBBPF_OUTPUT) $(BPFTOOL_OUTPUT):
-	$(call msg,MKDIR,$@)
-	$(Q)mkdir -p $@
-
-$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUTPUT)
-	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \
-		    OUTPUT=$(abspath $(dir $@))/ prefix=		       \
-		    DESTDIR=$(LIBBPF_DESTDIR) $(abspath $@) install_headers
-
-ifeq ($(CROSS_COMPILE),)
-$(DEFAULT_BPFTOOL): $(BPFOBJ) | $(BPFTOOL_OUTPUT)
-	$(Q)$(MAKE) $(submake_extras) -C $(BPFTOOL_SRC)			       \
-		    OUTPUT=$(BPFTOOL_OUTPUT)/				       \
-		    LIBBPF_BOOTSTRAP_OUTPUT=$(LIBBPF_OUTPUT)/		       \
-		    LIBBPF_BOOTSTRAP_DESTDIR=$(LIBBPF_DESTDIR)/ bootstrap
-else
-$(DEFAULT_BPFTOOL): | $(BPFTOOL_OUTPUT)
-	$(Q)$(MAKE) $(submake_extras) -C $(BPFTOOL_SRC)			       \
-		    OUTPUT=$(BPFTOOL_OUTPUT)/ bootstrap
-endif
diff --git a/drivers/hid/bpf/entrypoints/README b/drivers/hid/bpf/entrypoints/README
deleted file mode 100644
index 147e0d41509f..000000000000
--- a/drivers/hid/bpf/entrypoints/README
+++ /dev/null
@@ -1,4 +0,0 @@
-WARNING:
-If you change "entrypoints.bpf.c" do "make -j" in this directory to rebuild "entrypoints.skel.h".
-Make sure to have clang 10 installed.
-See Documentation/bpf/bpf_devel_QA.rst
diff --git a/drivers/hid/bpf/entrypoints/entrypoints.bpf.c b/drivers/hid/bpf/entrypoints/entrypoints.bpf.c
deleted file mode 100644
index c22921125a1a..000000000000
--- a/drivers/hid/bpf/entrypoints/entrypoints.bpf.c
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2022 Benjamin Tissoires */
-
-#include ".output/vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-
-#define HID_BPF_MAX_PROGS 1024
-
-struct {
-	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
-	__uint(max_entries, HID_BPF_MAX_PROGS);
-	__uint(key_size, sizeof(__u32));
-	__uint(value_size, sizeof(__u32));
-} hid_jmp_table SEC(".maps");
-
-SEC("fmod_ret/__hid_bpf_tail_call")
-int BPF_PROG(hid_tail_call, struct hid_bpf_ctx *hctx)
-{
-	bpf_tail_call(ctx, &hid_jmp_table, hctx->index);
-
-	return 0;
-}
-
-char LICENSE[] SEC("license") = "GPL";
diff --git a/drivers/hid/bpf/entrypoints/entrypoints.lskel.h b/drivers/hid/bpf/entrypoints/entrypoints.lskel.h
deleted file mode 100644
index 35618051598c..000000000000
--- a/drivers/hid/bpf/entrypoints/entrypoints.lskel.h
+++ /dev/null
@@ -1,248 +0,0 @@
-/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
-/* THIS FILE IS AUTOGENERATED BY BPFTOOL! */
-#ifndef __ENTRYPOINTS_BPF_SKEL_H__
-#define __ENTRYPOINTS_BPF_SKEL_H__
-
-#include <bpf/skel_internal.h>
-
-struct entrypoints_bpf {
-	struct bpf_loader_ctx ctx;
-	struct {
-		struct bpf_map_desc hid_jmp_table;
-	} maps;
-	struct {
-		struct bpf_prog_desc hid_tail_call;
-	} progs;
-	struct {
-		int hid_tail_call_fd;
-	} links;
-};
-
-static inline int
-entrypoints_bpf__hid_tail_call__attach(struct entrypoints_bpf *skel)
-{
-	int prog_fd = skel->progs.hid_tail_call.prog_fd;
-	int fd = skel_raw_tracepoint_open(NULL, prog_fd);
-
-	if (fd > 0)
-		skel->links.hid_tail_call_fd = fd;
-	return fd;
-}
-
-static inline int
-entrypoints_bpf__attach(struct entrypoints_bpf *skel)
-{
-	int ret = 0;
-
-	ret = ret < 0 ? ret : entrypoints_bpf__hid_tail_call__attach(skel);
-	return ret < 0 ? ret : 0;
-}
-
-static inline void
-entrypoints_bpf__detach(struct entrypoints_bpf *skel)
-{
-	skel_closenz(skel->links.hid_tail_call_fd);
-}
-static void
-entrypoints_bpf__destroy(struct entrypoints_bpf *skel)
-{
-	if (!skel)
-		return;
-	entrypoints_bpf__detach(skel);
-	skel_closenz(skel->progs.hid_tail_call.prog_fd);
-	skel_closenz(skel->maps.hid_jmp_table.map_fd);
-	skel_free(skel);
-}
-static inline struct entrypoints_bpf *
-entrypoints_bpf__open(void)
-{
-	struct entrypoints_bpf *skel;
-
-	skel = skel_alloc(sizeof(*skel));
-	if (!skel)
-		goto cleanup;
-	skel->ctx.sz = (void *)&skel->links - (void *)skel;
-	return skel;
-cleanup:
-	entrypoints_bpf__destroy(skel);
-	return NULL;
-}
-
-static inline int
-entrypoints_bpf__load(struct entrypoints_bpf *skel)
-{
-	struct bpf_load_and_run_opts opts = {};
-	int err;
-
-	opts.ctx = (struct bpf_loader_ctx *)skel;
-	opts.data_sz = 2856;
-	opts.data = (void *)"\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x9f\xeb\x01\0\
-\x18\0\0\0\0\0\0\0\x60\x02\0\0\x60\x02\0\0\x12\x02\0\0\0\0\0\0\0\0\0\x02\x03\0\
-\0\0\x01\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\x01\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\
-\0\0\x04\0\0\0\x03\0\0\0\x05\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\
-\x02\x06\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\0\0\x04\0\0\0\0\x04\0\0\0\0\0\0\
-\0\0\0\x02\x08\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\0\0\x04\0\0\0\x04\0\0\0\0\
-\0\0\0\x04\0\0\x04\x20\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\
-\x40\0\0\0\x2a\0\0\0\x07\0\0\0\x80\0\0\0\x33\0\0\0\x07\0\0\0\xc0\0\0\0\x3e\0\0\
-\0\0\0\0\x0e\x09\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\x02\x0c\0\0\0\x4c\0\0\0\0\0\0\
-\x01\x08\0\0\0\x40\0\0\0\0\0\0\0\x01\0\0\x0d\x02\0\0\0\x5f\0\0\0\x0b\0\0\0\x63\
-\0\0\0\x01\0\0\x0c\x0d\0\0\0\x09\x01\0\0\x05\0\0\x04\x20\0\0\0\x15\x01\0\0\x10\
-\0\0\0\0\0\0\0\x1b\x01\0\0\x12\0\0\0\x40\0\0\0\x1f\x01\0\0\x10\0\0\0\x80\0\0\0\
-\x2e\x01\0\0\x14\0\0\0\xa0\0\0\0\0\0\0\0\x15\0\0\0\xc0\0\0\0\x3a\x01\0\0\0\0\0\
-\x08\x11\0\0\0\x40\x01\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\x02\x13\
-\0\0\0\0\0\0\0\0\0\0\x0a\x1c\0\0\0\x4d\x01\0\0\x04\0\0\x06\x04\0\0\0\x5d\x01\0\
-\0\0\0\0\0\x6e\x01\0\0\x01\0\0\0\x80\x01\0\0\x02\0\0\0\x93\x01\0\0\x03\0\0\0\0\
-\0\0\0\x02\0\0\x05\x04\0\0\0\xa4\x01\0\0\x16\0\0\0\0\0\0\0\xab\x01\0\0\x16\0\0\
-\0\0\0\0\0\xb0\x01\0\0\0\0\0\x08\x02\0\0\0\xec\x01\0\0\0\0\0\x01\x01\0\0\0\x08\
-\0\0\x01\0\0\0\0\0\0\0\x03\0\0\0\0\x17\0\0\0\x04\0\0\0\x04\0\0\0\xf1\x01\0\0\0\
-\0\0\x0e\x18\0\0\0\x01\0\0\0\xf9\x01\0\0\x01\0\0\x0f\x20\0\0\0\x0a\0\0\0\0\0\0\
-\0\x20\0\0\0\xff\x01\0\0\x01\0\0\x0f\x04\0\0\0\x19\0\0\0\0\0\0\0\x04\0\0\0\x07\
-\x02\0\0\0\0\0\x07\0\0\0\0\0\x69\x6e\x74\0\x5f\x5f\x41\x52\x52\x41\x59\x5f\x53\
-\x49\x5a\x45\x5f\x54\x59\x50\x45\x5f\x5f\0\x74\x79\x70\x65\0\x6d\x61\x78\x5f\
-\x65\x6e\x74\x72\x69\x65\x73\0\x6b\x65\x79\x5f\x73\x69\x7a\x65\0\x76\x61\x6c\
-\x75\x65\x5f\x73\x69\x7a\x65\0\x68\x69\x64\x5f\x6a\x6d\x70\x5f\x74\x61\x62\x6c\
-\x65\0\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x6c\x6f\x6e\x67\x20\x6c\x6f\x6e\x67\
-\0\x63\x74\x78\0\x68\x69\x64\x5f\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\0\x66\x6d\
-\x6f\x64\x5f\x72\x65\x74\x2f\x5f\x5f\x68\x69\x64\x5f\x62\x70\x66\x5f\x74\x61\
-\x69\x6c\x5f\x63\x61\x6c\x6c\0\x2f\x68\x6f\x6d\x65\x2f\x62\x74\x69\x73\x73\x6f\
-\x69\x72\x2f\x53\x72\x63\x2f\x68\x69\x64\x2f\x64\x72\x69\x76\x65\x72\x73\x2f\
-\x68\x69\x64\x2f\x62\x70\x66\x2f\x65\x6e\x74\x72\x79\x70\x6f\x69\x6e\x74\x73\
-\x2f\x65\x6e\x74\x72\x79\x70\x6f\x69\x6e\x74\x73\x2e\x62\x70\x66\x2e\x63\0\x69\
-\x6e\x74\x20\x42\x50\x46\x5f\x50\x52\x4f\x47\x28\x68\x69\x64\x5f\x74\x61\x69\
-\x6c\x5f\x63\x61\x6c\x6c\x2c\x20\x73\x74\x72\x75\x63\x74\x20\x68\x69\x64\x5f\
-\x62\x70\x66\x5f\x63\x74\x78\x20\x2a\x68\x63\x74\x78\x29\0\x68\x69\x64\x5f\x62\
-\x70\x66\x5f\x63\x74\x78\0\x69\x6e\x64\x65\x78\0\x68\x69\x64\0\x61\x6c\x6c\x6f\
-\x63\x61\x74\x65\x64\x5f\x73\x69\x7a\x65\0\x72\x65\x70\x6f\x72\x74\x5f\x74\x79\
-\x70\x65\0\x5f\x5f\x75\x33\x32\0\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x69\x6e\
-\x74\0\x68\x69\x64\x5f\x72\x65\x70\x6f\x72\x74\x5f\x74\x79\x70\x65\0\x48\x49\
-\x44\x5f\x49\x4e\x50\x55\x54\x5f\x52\x45\x50\x4f\x52\x54\0\x48\x49\x44\x5f\x4f\
-\x55\x54\x50\x55\x54\x5f\x52\x45\x50\x4f\x52\x54\0\x48\x49\x44\x5f\x46\x45\x41\
-\x54\x55\x52\x45\x5f\x52\x45\x50\x4f\x52\x54\0\x48\x49\x44\x5f\x52\x45\x50\x4f\
-\x52\x54\x5f\x54\x59\x50\x45\x53\0\x72\x65\x74\x76\x61\x6c\0\x73\x69\x7a\x65\0\
-\x5f\x5f\x73\x33\x32\0\x30\x3a\x30\0\x09\x62\x70\x66\x5f\x74\x61\x69\x6c\x5f\
-\x63\x61\x6c\x6c\x28\x63\x74\x78\x2c\x20\x26\x68\x69\x64\x5f\x6a\x6d\x70\x5f\
-\x74\x61\x62\x6c\x65\x2c\x20\x68\x63\x74\x78\x2d\x3e\x69\x6e\x64\x65\x78\x29\
-\x3b\0\x63\x68\x61\x72\0\x4c\x49\x43\x45\x4e\x53\x45\0\x2e\x6d\x61\x70\x73\0\
-\x6c\x69\x63\x65\x6e\x73\x65\0\x68\x69\x64\x5f\x64\x65\x76\x69\x63\x65\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x8a\x04\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\
-\0\0\0\x04\0\0\0\x04\0\0\0\0\x04\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x68\x69\x64\x5f\
-\x6a\x6d\x70\x5f\x74\x61\x62\x6c\x65\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\x47\x50\x4c\0\0\0\0\0\x79\x12\0\0\0\0\0\0\x61\x23\0\0\0\0\
-\0\0\x18\x52\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x85\0\0\0\x0c\0\0\0\xb7\0\0\0\0\0\0\0\
-\x95\0\0\0\0\0\0\0\0\0\0\0\x0e\0\0\0\0\0\0\0\x8e\0\0\0\xd3\0\0\0\x05\x48\0\0\
-\x01\0\0\0\x8e\0\0\0\xba\x01\0\0\x02\x50\0\0\x05\0\0\0\x8e\0\0\0\xd3\0\0\0\x05\
-\x48\0\0\x08\0\0\0\x0f\0\0\0\xb6\x01\0\0\0\0\0\0\x1a\0\0\0\x07\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x68\x69\
-\x64\x5f\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\0\0\0\0\0\0\0\x1a\0\0\0\0\0\0\0\
-\x08\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\x01\0\
-\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\x5f\
-\x5f\x68\x69\x64\x5f\x62\x70\x66\x5f\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\0\0\0\
-\0\0";
-	opts.insns_sz = 1192;
-	opts.insns = (void *)"\
-\xbf\x16\0\0\0\0\0\0\xbf\xa1\0\0\0\0\0\0\x07\x01\0\0\x78\xff\xff\xff\xb7\x02\0\
-\0\x88\0\0\0\xb7\x03\0\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x05\0\x11\0\0\0\0\0\x61\
-\xa1\x78\xff\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x7c\xff\
-\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x80\xff\0\0\0\0\xd5\
-\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\
-\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\
-\xbf\x70\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\
-\0\0\0\0\0\xa8\x09\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\
-\0\0\0\0\0\0\0\xa4\x09\0\0\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\0\
-\0\0\0\0\0\0\0\0\0\x98\x09\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\
-\0\x05\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x90\x09\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\
-\0\0\x12\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x90\x09\0\0\xb7\x03\0\0\x1c\0\0\0\
-\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xd7\xff\0\0\0\0\x63\x7a\x78\
-\xff\0\0\0\0\x61\x60\x1c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\
-\0\0\xbc\x09\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\
-\0\0\0\xb0\x09\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\
-\0\xc5\x07\xca\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x63\x71\0\0\0\0\
-\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xf8\x09\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x90\
-\x0a\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\x0a\0\0\x18\x61\0\0\
-\0\0\0\0\0\0\0\0\x88\x0a\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\
-\x38\x0a\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xd0\x0a\0\0\x7b\x01\0\0\0\0\0\0\x18\
-\x60\0\0\0\0\0\0\0\0\0\0\x40\x0a\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xe0\x0a\0\0\
-\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x70\x0a\0\0\x18\x61\0\0\0\0\0\
-\0\0\0\0\0\0\x0b\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\xf8\x0a\0\0\x7b\x01\0\0\0\0\0\0\x61\x60\x08\0\0\0\
-\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x98\x0a\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\
-\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x9c\x0a\0\0\x63\x01\0\0\0\0\0\0\x79\x60\
-\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xa0\x0a\0\0\x7b\x01\0\0\0\0\0\0\x61\
-\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc8\x0a\0\0\x63\x01\0\0\0\0\0\
-\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x10\x0b\0\0\xb7\x02\0\0\x14\0\0\0\xb7\x03\0\0\
-\x0c\0\0\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\
-\x91\xff\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x80\x0a\0\0\x63\x70\x6c\0\0\0\0\0\
-\x77\x07\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\0\0\0\x18\x62\0\0\
-\0\0\0\0\0\0\0\0\x80\x0a\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\
-\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xf0\x0a\0\0\x61\x01\0\0\0\0\0\0\xd5\
-\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\x07\x7f\xff\0\0\
-\0\0\x63\x7a\x80\xff\0\0\0\0\x61\xa1\x78\xff\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\
-\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa0\x80\xff\0\0\0\0\x63\x06\x28\0\0\0\
-\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x18\0\0\0\
-\0\0\xb7\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0";
-	err = bpf_load_and_run(&opts);
-	if (err < 0)
-		return err;
-	return 0;
-}
-
-static inline struct entrypoints_bpf *
-entrypoints_bpf__open_and_load(void)
-{
-	struct entrypoints_bpf *skel;
-
-	skel = entrypoints_bpf__open();
-	if (!skel)
-		return NULL;
-	if (entrypoints_bpf__load(skel)) {
-		entrypoints_bpf__destroy(skel);
-		return NULL;
-	}
-	return skel;
-}
-
-__attribute__((unused)) static void
-entrypoints_bpf__assert(struct entrypoints_bpf *s __attribute__((unused)))
-{
-#ifdef __cplusplus
-#define _Static_assert static_assert
-#endif
-#ifdef __cplusplus
-#undef _Static_assert
-#endif
-}
-
-#endif /* __ENTRYPOINTS_BPF_SKEL_H__ */
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 7216c3c7713d..06cc628e7bb4 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -3,7 +3,7 @@
 /*
  *  HID-BPF support for Linux
  *
- *  Copyright (c) 2022 Benjamin Tissoires
+ *  Copyright (c) 2022-2024 Benjamin Tissoires
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -17,34 +17,11 @@
 #include <linux/kfifo.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
-#include <linux/workqueue.h>
 #include "hid_bpf_dispatch.h"
-#include "entrypoints/entrypoints.lskel.h"
 
 struct hid_ops *hid_ops;
 EXPORT_SYMBOL(hid_ops);
 
-/**
- * hid_bpf_device_event - Called whenever an event is coming in from the device
- *
- * @ctx: The HID-BPF context
- *
- * @return %0 on success and keep processing; a positive value to change the
- * incoming size buffer; a negative error code to interrupt the processing
- * of this event
- *
- * Declare an %fmod_ret tracing bpf program to this function and attach this
- * program through hid_bpf_attach_prog() to have this helper called for
- * any incoming event from the device itself.
- *
- * The function is called while on IRQ context, so we can not sleep.
- */
-/* never used by the kernel but declared so we can load and attach a tracepoint */
-__weak noinline int hid_bpf_device_event(struct hid_bpf_ctx *ctx)
-{
-	return 0;
-}
-
 u8 *
 dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type, u8 *data,
 			      u32 *size, int interrupt)
@@ -52,7 +29,6 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 	struct hid_bpf_ctx_kern ctx_kern = {
 		.ctx = {
 			.hid = hdev,
-			.report_type = type,
 			.allocated_size = hdev->bpf.allocated_data,
 			.size = *size,
 		},
@@ -86,11 +62,6 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 	}
 	rcu_read_unlock();
 
-	ret = hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_DEVICE_EVENT, &ctx_kern);
-	if (ret < 0)
-		return ERR_PTR(ret);
-	ret = ctx_kern.ctx.retval;
-
 	if (ret) {
 		if (ret > ctx_kern.ctx.allocated_size)
 			return ERR_PTR(-EINVAL);
@@ -102,26 +73,6 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 }
 EXPORT_SYMBOL_GPL(dispatch_hid_bpf_device_event);
 
-/**
- * hid_bpf_rdesc_fixup - Called when the probe function parses the report
- * descriptor of the HID device
- *
- * @ctx: The HID-BPF context
- *
- * @return 0 on success and keep processing; a positive value to change the
- * incoming size buffer; a negative error code to interrupt the processing
- * of this event
- *
- * Declare an %fmod_ret tracing bpf program to this function and attach this
- * program through hid_bpf_attach_prog() to have this helper called before any
- * parsing of the report descriptor by HID.
- */
-/* never used by the kernel but declared so we can load and attach a tracepoint */
-__weak noinline int hid_bpf_rdesc_fixup(struct hid_bpf_ctx *ctx)
-{
-	return 0;
-}
-
 u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size)
 {
 	int ret;
@@ -133,16 +84,16 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *s
 		},
 	};
 
+	if (!hdev->bpf.rdesc_ops)
+		goto ignore_bpf;
+
 	ctx_kern.data = kzalloc(ctx_kern.ctx.allocated_size, GFP_KERNEL);
 	if (!ctx_kern.data)
 		goto ignore_bpf;
 
 	memcpy(ctx_kern.data, rdesc, min_t(unsigned int, *size, HID_MAX_DESCRIPTOR_SIZE));
 
-	if (hdev->bpf.rdesc_ops)
-		ret = hdev->bpf.rdesc_ops->hid_rdesc_fixup(&ctx_kern.ctx);
-	else
-		ret = hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_RDESC_FIXUP, &ctx_kern);
+	ret = hdev->bpf.rdesc_ops->hid_rdesc_fixup(&ctx_kern.ctx);
 	if (ret < 0)
 		goto ignore_bpf;
 
@@ -242,39 +193,6 @@ int hid_bpf_reconnect(struct hid_device *hdev)
 	return 0;
 }
 
-static int do_hid_bpf_attach_prog(struct hid_device *hdev, int prog_fd, struct bpf_prog *prog,
-				  __u32 flags)
-{
-	int fd, err, prog_type;
-
-	prog_type = hid_bpf_get_prog_attach_type(prog);
-	if (prog_type < 0)
-		return prog_type;
-
-	if (prog_type >= HID_BPF_PROG_TYPE_MAX)
-		return -EINVAL;
-
-	if (prog_type == HID_BPF_PROG_TYPE_DEVICE_EVENT) {
-		err = hid_bpf_allocate_event_data(hdev);
-		if (err)
-			return err;
-	}
-
-	fd = __hid_bpf_attach_prog(hdev, prog_type, prog_fd, prog, flags);
-	if (fd < 0)
-		return fd;
-
-	if (prog_type == HID_BPF_PROG_TYPE_RDESC_FIXUP) {
-		err = hid_bpf_reconnect(hdev);
-		if (err) {
-			close_fd(fd);
-			return err;
-		}
-	}
-
-	return fd;
-}
-
 /* Disables missing prototype warnings */
 __bpf_kfunc_start_defs();
 
@@ -303,57 +221,6 @@ hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const size_t rdwr
 	return ctx_kern->data + offset;
 }
 
-/**
- * hid_bpf_attach_prog - Attach the given @prog_fd to the given HID device
- *
- * @hid_id: the system unique identifier of the HID device
- * @prog_fd: an fd in the user process representing the program to attach
- * @flags: any logical OR combination of &enum hid_bpf_attach_flags
- *
- * @returns an fd of a bpf_link object on success (> %0), an error code otherwise.
- * Closing this fd will detach the program from the HID device (unless the bpf_link
- * is pinned to the BPF file system).
- */
-/* called from syscall */
-__bpf_kfunc int
-hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags)
-{
-	struct hid_device *hdev;
-	struct bpf_prog *prog;
-	int err, fd;
-
-	if ((flags & ~HID_BPF_FLAG_MASK))
-		return -EINVAL;
-
-	hdev = hid_get_device(hid_id);
-	if (IS_ERR(hdev))
-		return PTR_ERR(hdev);
-
-	/*
-	 * take a ref on the prog itself, it will be released
-	 * on errors or when it'll be detached
-	 */
-	prog = bpf_prog_get(prog_fd);
-	if (IS_ERR(prog)) {
-		err = PTR_ERR(prog);
-		goto out_dev_put;
-	}
-
-	fd = do_hid_bpf_attach_prog(hdev, prog_fd, prog, flags);
-	if (fd < 0) {
-		err = fd;
-		goto out_prog_put;
-	}
-
-	return fd;
-
- out_prog_put:
-	bpf_prog_put(prog);
- out_dev_put:
-	hid_put_device(hdev);
-	return err;
-}
-
 /**
  * hid_bpf_allocate_context - Allocate a context to the given HID device
  *
@@ -583,21 +450,8 @@ static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {
 	.set   = &hid_bpf_kfunc_ids,
 };
 
-/* our HID-BPF entrypoints */
-BTF_SET8_START(hid_bpf_fmodret_ids)
-BTF_ID_FLAGS(func, hid_bpf_device_event)
-BTF_ID_FLAGS(func, hid_bpf_rdesc_fixup)
-BTF_ID_FLAGS(func, __hid_bpf_tail_call)
-BTF_SET8_END(hid_bpf_fmodret_ids)
-
-static const struct btf_kfunc_id_set hid_bpf_fmodret_set = {
-	.owner = THIS_MODULE,
-	.set   = &hid_bpf_fmodret_ids,
-};
-
 /* for syscall HID-BPF */
 BTF_KFUNCS_START(hid_bpf_syscall_kfunc_ids)
-BTF_ID_FLAGS(func, hid_bpf_attach_prog)
 BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
 BTF_ID_FLAGS(func, hid_bpf_hw_request)
@@ -622,8 +476,6 @@ int hid_bpf_connect_device(struct hid_device *hdev)
 			break;
 		}
 	}
-	if (rcu_dereference(hdev->bpf.progs[HID_BPF_PROG_TYPE_DEVICE_EVENT]))
-		need_to_allocate = true;
 	rcu_read_unlock();
 
 	/* only allocate BPF data if there are programs attached */
@@ -650,14 +502,12 @@ void hid_bpf_destroy_device(struct hid_device *hdev)
 	/* mark the device as destroyed in bpf so we don't reattach it */
 	hdev->bpf.destroyed = true;
 
-	__hid_bpf_destroy_device(hdev);
 	__hid_bpf_ops_destroy_device(hdev);
 }
 EXPORT_SYMBOL_GPL(hid_bpf_destroy_device);
 
 void hid_bpf_device_init(struct hid_device *hdev)
 {
-	spin_lock_init(&hdev->bpf.progs_lock);
 	INIT_LIST_HEAD(&hdev->bpf.prog_list);
 	mutex_init(&hdev->bpf.prog_list_lock);
 }
@@ -670,37 +520,15 @@ static int __init hid_bpf_init(void)
 	/* Note: if we exit with an error any time here, we would entirely break HID, which
 	 * is probably not something we want. So we log an error and return success.
 	 *
-	 * This is not a big deal: the syscall allowing to attach a BPF program to a HID device
-	 * will not be available, so nobody will be able to use the functionality.
+	 * This is not a big deal: nobody will be able to use the functionality.
 	 */
 
-	err = register_btf_fmodret_id_set(&hid_bpf_fmodret_set);
-	if (err) {
-		pr_warn("error while registering fmodret entrypoints: %d", err);
-		return 0;
-	}
-
-	err = hid_bpf_preload_skel();
-	if (err) {
-		pr_warn("error while preloading HID BPF dispatcher: %d", err);
-		return 0;
-	}
-
-	/* register tracing kfuncs after we are sure we can load our preloaded bpf program */
-	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &hid_bpf_kfunc_set);
-	if (err) {
-		pr_warn("error while setting HID BPF tracing kfuncs: %d", err);
-		return 0;
-	}
-
-	/* register struct_ops kfuncs after we are sure we can load our preloaded bpf program */
 	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &hid_bpf_kfunc_set);
 	if (err) {
 		pr_warn("error while setting HID BPF tracing kfuncs: %d", err);
 		return 0;
 	}
 
-	/* register syscalls after we are sure we can load our preloaded bpf program */
 	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &hid_bpf_syscall_kfunc_set);
 	if (err) {
 		pr_warn("error while setting HID BPF syscall kfuncs: %d", err);
@@ -710,15 +538,6 @@ static int __init hid_bpf_init(void)
 	return 0;
 }
 
-static void __exit hid_bpf_exit(void)
-{
-	/* HID depends on us, so if we hit that code, we are guaranteed that hid
-	 * has been removed and thus we do not need to clear the HID devices
-	 */
-	hid_bpf_free_links_and_skel();
-}
-
 late_initcall(hid_bpf_init);
-module_exit(hid_bpf_exit);
 MODULE_AUTHOR("Benjamin Tissoires");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.h b/drivers/hid/bpf/hid_bpf_dispatch.h
index e52c43d81650..835e6f69f479 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.h
+++ b/drivers/hid/bpf/hid_bpf_dispatch.h
@@ -13,15 +13,7 @@ struct hid_bpf_ctx_kern {
 struct hid_device *hid_get_device(unsigned int hid_id);
 void hid_put_device(struct hid_device *hid);
 int hid_bpf_allocate_event_data(struct hid_device *hdev);
-int hid_bpf_preload_skel(void);
-void hid_bpf_free_links_and_skel(void);
-int hid_bpf_get_prog_attach_type(struct bpf_prog *prog);
-int __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type, int prog_fd,
-			  struct bpf_prog *prog, __u32 flags);
-void __hid_bpf_destroy_device(struct hid_device *hdev);
 void __hid_bpf_ops_destroy_device(struct hid_device *hdev);
-int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
-		     struct hid_bpf_ctx_kern *ctx_kern);
 int hid_bpf_reconnect(struct hid_device *hdev);
 
 struct bpf_prog;
diff --git a/drivers/hid/bpf/hid_bpf_jmp_table.c b/drivers/hid/bpf/hid_bpf_jmp_table.c
deleted file mode 100644
index 8a54ba447718..000000000000
--- a/drivers/hid/bpf/hid_bpf_jmp_table.c
+++ /dev/null
@@ -1,568 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-/*
- *  HID-BPF support for Linux
- *
- *  Copyright (c) 2022 Benjamin Tissoires
- */
-
-#include <linux/bitops.h>
-#include <linux/btf.h>
-#include <linux/btf_ids.h>
-#include <linux/circ_buf.h>
-#include <linux/filter.h>
-#include <linux/hid.h>
-#include <linux/hid_bpf.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/workqueue.h>
-#include "hid_bpf_dispatch.h"
-#include "entrypoints/entrypoints.lskel.h"
-
-#define HID_BPF_MAX_PROGS 1024 /* keep this in sync with preloaded bpf,
-				* needs to be a power of 2 as we use it as
-				* a circular buffer
-				*/
-
-#define NEXT(idx) (((idx) + 1) & (HID_BPF_MAX_PROGS - 1))
-#define PREV(idx) (((idx) - 1) & (HID_BPF_MAX_PROGS - 1))
-
-/*
- * represents one attached program stored in the hid jump table
- */
-struct hid_bpf_prog_entry {
-	struct bpf_prog *prog;
-	struct hid_device *hdev;
-	enum hid_bpf_prog_type type;
-	u16 idx;
-};
-
-struct hid_bpf_jmp_table {
-	struct bpf_map *map;
-	struct hid_bpf_prog_entry entries[HID_BPF_MAX_PROGS]; /* compacted list, circular buffer */
-	int tail, head;
-	struct bpf_prog *progs[HID_BPF_MAX_PROGS]; /* idx -> progs mapping */
-	unsigned long enabled[BITS_TO_LONGS(HID_BPF_MAX_PROGS)];
-};
-
-#define FOR_ENTRIES(__i, __start, __end) \
-	for (__i = __start; CIRC_CNT(__end, __i, HID_BPF_MAX_PROGS); __i = NEXT(__i))
-
-static struct hid_bpf_jmp_table jmp_table;
-
-static DEFINE_MUTEX(hid_bpf_attach_lock);		/* held when attaching/detaching programs */
-
-static void hid_bpf_release_progs(struct work_struct *work);
-
-static DECLARE_WORK(release_work, hid_bpf_release_progs);
-
-BTF_ID_LIST(hid_bpf_btf_ids)
-BTF_ID(func, hid_bpf_device_event)			/* HID_BPF_PROG_TYPE_DEVICE_EVENT */
-BTF_ID(func, hid_bpf_rdesc_fixup)			/* HID_BPF_PROG_TYPE_RDESC_FIXUP */
-
-static int hid_bpf_max_programs(enum hid_bpf_prog_type type)
-{
-	switch (type) {
-	case HID_BPF_PROG_TYPE_DEVICE_EVENT:
-		return HID_BPF_MAX_PROGS_PER_DEV;
-	case HID_BPF_PROG_TYPE_RDESC_FIXUP:
-		return 1;
-	default:
-		return -EINVAL;
-	}
-}
-
-static int hid_bpf_program_count(struct hid_device *hdev,
-				 struct bpf_prog *prog,
-				 enum hid_bpf_prog_type type)
-{
-	int i, n = 0;
-
-	if (type >= HID_BPF_PROG_TYPE_MAX)
-		return -EINVAL;
-
-	if (type == HID_BPF_PROG_TYPE_RDESC_FIXUP && hdev->bpf.rdesc_ops)
-		n += 1;
-
-	FOR_ENTRIES(i, jmp_table.tail, jmp_table.head) {
-		struct hid_bpf_prog_entry *entry = &jmp_table.entries[i];
-
-		if (type != HID_BPF_PROG_TYPE_UNDEF && entry->type != type)
-			continue;
-
-		if (hdev && entry->hdev != hdev)
-			continue;
-
-		if (prog && entry->prog != prog)
-			continue;
-
-		n++;
-	}
-
-	return n;
-}
-
-__weak noinline int __hid_bpf_tail_call(struct hid_bpf_ctx *ctx)
-{
-	return 0;
-}
-
-int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
-		     struct hid_bpf_ctx_kern *ctx_kern)
-{
-	struct hid_bpf_prog_list *prog_list;
-	int i, idx, err = 0;
-
-	rcu_read_lock();
-	prog_list = rcu_dereference(hdev->bpf.progs[type]);
-
-	if (!prog_list)
-		goto out_unlock;
-
-	for (i = 0; i < prog_list->prog_cnt; i++) {
-		idx = prog_list->prog_idx[i];
-
-		if (!test_bit(idx, jmp_table.enabled))
-			continue;
-
-		ctx_kern->ctx.index = idx;
-		err = __hid_bpf_tail_call(&ctx_kern->ctx);
-		if (err < 0)
-			break;
-		if (err)
-			ctx_kern->ctx.retval = err;
-	}
-
- out_unlock:
-	rcu_read_unlock();
-
-	return err;
-}
-
-/*
- * assign the list of programs attached to a given hid device.
- */
-static void __hid_bpf_set_hdev_progs(struct hid_device *hdev, struct hid_bpf_prog_list *new_list,
-				     enum hid_bpf_prog_type type)
-{
-	struct hid_bpf_prog_list *old_list;
-
-	spin_lock(&hdev->bpf.progs_lock);
-	old_list = rcu_dereference_protected(hdev->bpf.progs[type],
-					     lockdep_is_held(&hdev->bpf.progs_lock));
-	rcu_assign_pointer(hdev->bpf.progs[type], new_list);
-	spin_unlock(&hdev->bpf.progs_lock);
-	synchronize_rcu();
-
-	kfree(old_list);
-}
-
-/*
- * allocate and populate the list of programs attached to a given hid device.
- *
- * Must be called under lock.
- */
-static int hid_bpf_populate_hdev(struct hid_device *hdev, enum hid_bpf_prog_type type)
-{
-	struct hid_bpf_prog_list *new_list;
-	int i;
-
-	if (type >= HID_BPF_PROG_TYPE_MAX || !hdev)
-		return -EINVAL;
-
-	if (hdev->bpf.destroyed)
-		return 0;
-
-	new_list = kzalloc(sizeof(*new_list), GFP_KERNEL);
-	if (!new_list)
-		return -ENOMEM;
-
-	FOR_ENTRIES(i, jmp_table.tail, jmp_table.head) {
-		struct hid_bpf_prog_entry *entry = &jmp_table.entries[i];
-
-		if (entry->type == type && entry->hdev == hdev &&
-		    test_bit(entry->idx, jmp_table.enabled))
-			new_list->prog_idx[new_list->prog_cnt++] = entry->idx;
-	}
-
-	__hid_bpf_set_hdev_progs(hdev, new_list, type);
-
-	return 0;
-}
-
-static void __hid_bpf_do_release_prog(int map_fd, unsigned int idx)
-{
-	skel_map_delete_elem(map_fd, &idx);
-	jmp_table.progs[idx] = NULL;
-}
-
-static void hid_bpf_release_progs(struct work_struct *work)
-{
-	int i, j, n, map_fd = -1;
-	bool hdev_destroyed;
-
-	if (!jmp_table.map)
-		return;
-
-	/* retrieve a fd of our prog_array map in BPF */
-	map_fd = skel_map_get_fd_by_id(jmp_table.map->id);
-	if (map_fd < 0)
-		return;
-
-	mutex_lock(&hid_bpf_attach_lock); /* protects against attaching new programs */
-
-	/* detach unused progs from HID devices */
-	FOR_ENTRIES(i, jmp_table.tail, jmp_table.head) {
-		struct hid_bpf_prog_entry *entry = &jmp_table.entries[i];
-		enum hid_bpf_prog_type type;
-		struct hid_device *hdev;
-
-		if (test_bit(entry->idx, jmp_table.enabled))
-			continue;
-
-		/* we have an attached prog */
-		if (entry->hdev) {
-			hdev = entry->hdev;
-			type = entry->type;
-			/*
-			 * hdev is still valid, even if we are called after hid_destroy_device():
-			 * when hid_bpf_attach() gets called, it takes a ref on the dev through
-			 * bus_find_device()
-			 */
-			hdev_destroyed = hdev->bpf.destroyed;
-
-			hid_bpf_populate_hdev(hdev, type);
-
-			/* mark all other disabled progs from hdev of the given type as detached */
-			FOR_ENTRIES(j, i, jmp_table.head) {
-				struct hid_bpf_prog_entry *next;
-
-				next = &jmp_table.entries[j];
-
-				if (test_bit(next->idx, jmp_table.enabled))
-					continue;
-
-				if (next->hdev == hdev && next->type == type) {
-					/*
-					 * clear the hdev reference and decrement the device ref
-					 * that was taken during bus_find_device() while calling
-					 * hid_bpf_attach()
-					 */
-					next->hdev = NULL;
-					put_device(&hdev->dev);
-				}
-			}
-
-			/* if type was rdesc fixup and the device is not gone, reconnect device */
-			if (type == HID_BPF_PROG_TYPE_RDESC_FIXUP && !hdev_destroyed)
-				hid_bpf_reconnect(hdev);
-		}
-	}
-
-	/* remove all unused progs from the jump table */
-	FOR_ENTRIES(i, jmp_table.tail, jmp_table.head) {
-		struct hid_bpf_prog_entry *entry = &jmp_table.entries[i];
-
-		if (test_bit(entry->idx, jmp_table.enabled))
-			continue;
-
-		if (entry->prog)
-			__hid_bpf_do_release_prog(map_fd, entry->idx);
-	}
-
-	/* compact the entry list */
-	n = jmp_table.tail;
-	FOR_ENTRIES(i, jmp_table.tail, jmp_table.head) {
-		struct hid_bpf_prog_entry *entry = &jmp_table.entries[i];
-
-		if (!test_bit(entry->idx, jmp_table.enabled))
-			continue;
-
-		jmp_table.entries[n] = jmp_table.entries[i];
-		n = NEXT(n);
-	}
-
-	jmp_table.head = n;
-
-	mutex_unlock(&hid_bpf_attach_lock);
-
-	if (map_fd >= 0)
-		close_fd(map_fd);
-}
-
-static void hid_bpf_release_prog_at(int idx)
-{
-	int map_fd = -1;
-
-	/* retrieve a fd of our prog_array map in BPF */
-	map_fd = skel_map_get_fd_by_id(jmp_table.map->id);
-	if (map_fd < 0)
-		return;
-
-	__hid_bpf_do_release_prog(map_fd, idx);
-
-	close(map_fd);
-}
-
-/*
- * Insert the given BPF program represented by its fd in the jmp table.
- * Returns the index in the jump table or a negative error.
- */
-static int hid_bpf_insert_prog(int prog_fd, struct bpf_prog *prog)
-{
-	int i, index = -1, map_fd = -1, err = -EINVAL;
-
-	/* retrieve a fd of our prog_array map in BPF */
-	map_fd = skel_map_get_fd_by_id(jmp_table.map->id);
-
-	if (map_fd < 0) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	/* find the first available index in the jmp_table */
-	for (i = 0; i < HID_BPF_MAX_PROGS; i++) {
-		if (!jmp_table.progs[i] && index < 0) {
-			/* mark the index as used */
-			jmp_table.progs[i] = prog;
-			index = i;
-			__set_bit(i, jmp_table.enabled);
-		}
-	}
-	if (index < 0) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	/* insert the program in the jump table */
-	err = skel_map_update_elem(map_fd, &index, &prog_fd, 0);
-	if (err)
-		goto out;
-
-	/* return the index */
-	err = index;
-
- out:
-	if (err < 0)
-		__hid_bpf_do_release_prog(map_fd, index);
-	if (map_fd >= 0)
-		close_fd(map_fd);
-	return err;
-}
-
-int hid_bpf_get_prog_attach_type(struct bpf_prog *prog)
-{
-	int prog_type = HID_BPF_PROG_TYPE_UNDEF;
-	int i;
-
-	for (i = 0; i < HID_BPF_PROG_TYPE_MAX; i++) {
-		if (hid_bpf_btf_ids[i] == prog->aux->attach_btf_id) {
-			prog_type = i;
-			break;
-		}
-	}
-
-	return prog_type;
-}
-
-static void hid_bpf_link_release(struct bpf_link *link)
-{
-	struct hid_bpf_link *hid_link =
-		container_of(link, struct hid_bpf_link, link);
-
-	__clear_bit(hid_link->hid_table_index, jmp_table.enabled);
-	schedule_work(&release_work);
-}
-
-static void hid_bpf_link_dealloc(struct bpf_link *link)
-{
-	struct hid_bpf_link *hid_link =
-		container_of(link, struct hid_bpf_link, link);
-
-	kfree(hid_link);
-}
-
-static void hid_bpf_link_show_fdinfo(const struct bpf_link *link,
-					 struct seq_file *seq)
-{
-	seq_printf(seq,
-		   "attach_type:\tHID-BPF\n");
-}
-
-static const struct bpf_link_ops hid_bpf_link_lops = {
-	.release = hid_bpf_link_release,
-	.dealloc = hid_bpf_link_dealloc,
-	.show_fdinfo = hid_bpf_link_show_fdinfo,
-};
-
-/* called from syscall */
-noinline int
-__hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type,
-		      int prog_fd, struct bpf_prog *prog, __u32 flags)
-{
-	struct bpf_link_primer link_primer;
-	struct hid_bpf_link *link;
-	struct hid_bpf_prog_entry *prog_entry;
-	int cnt, err = -EINVAL, prog_table_idx = -1;
-
-	mutex_lock(&hid_bpf_attach_lock);
-
-	link = kzalloc(sizeof(*link), GFP_USER);
-	if (!link) {
-		err = -ENOMEM;
-		goto err_unlock;
-	}
-
-	bpf_link_init(&link->link, BPF_LINK_TYPE_UNSPEC,
-		      &hid_bpf_link_lops, prog);
-
-	/* do not attach too many programs to a given HID device */
-	cnt = hid_bpf_program_count(hdev, NULL, prog_type);
-	if (cnt < 0) {
-		err = cnt;
-		goto err_unlock;
-	}
-
-	if (cnt >= hid_bpf_max_programs(prog_type)) {
-		err = -E2BIG;
-		goto err_unlock;
-	}
-
-	prog_table_idx = hid_bpf_insert_prog(prog_fd, prog);
-	/* if the jmp table is full, abort */
-	if (prog_table_idx < 0) {
-		err = prog_table_idx;
-		goto err_unlock;
-	}
-
-	if (flags & HID_BPF_FLAG_INSERT_HEAD) {
-		/* take the previous prog_entry slot */
-		jmp_table.tail = PREV(jmp_table.tail);
-		prog_entry = &jmp_table.entries[jmp_table.tail];
-	} else {
-		/* take the next prog_entry slot */
-		prog_entry = &jmp_table.entries[jmp_table.head];
-		jmp_table.head = NEXT(jmp_table.head);
-	}
-
-	/* we steal the ref here */
-	prog_entry->prog = prog;
-	prog_entry->idx = prog_table_idx;
-	prog_entry->hdev = hdev;
-	prog_entry->type = prog_type;
-
-	/* finally store the index in the device list */
-	err = hid_bpf_populate_hdev(hdev, prog_type);
-	if (err) {
-		hid_bpf_release_prog_at(prog_table_idx);
-		goto err_unlock;
-	}
-
-	link->hid_table_index = prog_table_idx;
-
-	err = bpf_link_prime(&link->link, &link_primer);
-	if (err)
-		goto err_unlock;
-
-	mutex_unlock(&hid_bpf_attach_lock);
-
-	return bpf_link_settle(&link_primer);
-
- err_unlock:
-	mutex_unlock(&hid_bpf_attach_lock);
-
-	kfree(link);
-
-	return err;
-}
-
-void __hid_bpf_destroy_device(struct hid_device *hdev)
-{
-	int type, i;
-	struct hid_bpf_prog_list *prog_list;
-
-	rcu_read_lock();
-
-	for (type = 0; type < HID_BPF_PROG_TYPE_MAX; type++) {
-		prog_list = rcu_dereference(hdev->bpf.progs[type]);
-
-		if (!prog_list)
-			continue;
-
-		for (i = 0; i < prog_list->prog_cnt; i++)
-			__clear_bit(prog_list->prog_idx[i], jmp_table.enabled);
-	}
-
-	rcu_read_unlock();
-
-	for (type = 0; type < HID_BPF_PROG_TYPE_MAX; type++)
-		__hid_bpf_set_hdev_progs(hdev, NULL, type);
-
-	/* schedule release of all detached progs */
-	schedule_work(&release_work);
-}
-
-#define HID_BPF_PROGS_COUNT 1
-
-static struct bpf_link *links[HID_BPF_PROGS_COUNT];
-static struct entrypoints_bpf *skel;
-
-void hid_bpf_free_links_and_skel(void)
-{
-	int i;
-
-	/* the following is enough to release all programs attached to hid */
-	if (jmp_table.map)
-		bpf_map_put_with_uref(jmp_table.map);
-
-	for (i = 0; i < ARRAY_SIZE(links); i++) {
-		if (!IS_ERR_OR_NULL(links[i]))
-			bpf_link_put(links[i]);
-	}
-	entrypoints_bpf__destroy(skel);
-}
-
-#define ATTACH_AND_STORE_LINK(__name) do {					\
-	err = entrypoints_bpf__##__name##__attach(skel);			\
-	if (err)								\
-		goto out;							\
-										\
-	links[idx] = bpf_link_get_from_fd(skel->links.__name##_fd);		\
-	if (IS_ERR(links[idx])) {						\
-		err = PTR_ERR(links[idx]);					\
-		goto out;							\
-	}									\
-										\
-	/* Avoid taking over stdin/stdout/stderr of init process. Zeroing out	\
-	 * makes skel_closenz() a no-op later in iterators_bpf__destroy().	\
-	 */									\
-	close_fd(skel->links.__name##_fd);					\
-	skel->links.__name##_fd = 0;						\
-	idx++;									\
-} while (0)
-
-int hid_bpf_preload_skel(void)
-{
-	int err, idx = 0;
-
-	skel = entrypoints_bpf__open();
-	if (!skel)
-		return -ENOMEM;
-
-	err = entrypoints_bpf__load(skel);
-	if (err)
-		goto out;
-
-	jmp_table.map = bpf_map_get_with_uref(skel->maps.hid_jmp_table.map_fd);
-	if (IS_ERR(jmp_table.map)) {
-		err = PTR_ERR(jmp_table.map);
-		goto out;
-	}
-
-	ATTACH_AND_STORE_LINK(hid_tail_call);
-
-	return 0;
-out:
-	hid_bpf_free_links_and_skel();
-	return err;
-}
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 96495e977204..c0682db73aeb 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -4,7 +4,7 @@
 #define __HID_BPF_H
 
 #include <linux/bpf.h>
-#include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <uapi/linux/hid.h>
 
 struct hid_device;
@@ -24,11 +24,7 @@ struct hid_device;
  *
  * All of these fields are currently read-only.
  *
- * @index: program index in the jump table. No special meaning (a smaller index
- *         doesn't mean the program will be executed before another program with
- *         a bigger index).
  * @hid: the ``struct hid_device`` representing the device itself
- * @report_type: used for ``hid_bpf_device_event()``
  * @allocated_size: Allocated size of data.
  *
  *                  This is how much memory is available and can be requested
@@ -47,10 +43,8 @@ struct hid_device;
  * @retval: Return value of the previous program.
  */
 struct hid_bpf_ctx {
-	__u32 index;
 	const struct hid_device *hid;
 	__u32 allocated_size;
-	enum hid_report_type report_type;
 	union {
 		__s32 retval;
 		__s32 size;
@@ -74,27 +68,13 @@ enum hid_bpf_attach_flags {
 	HID_BPF_FLAG_MAX,
 };
 
-/* Following functions are tracepoints that BPF programs can attach to */
-int hid_bpf_device_event(struct hid_bpf_ctx *ctx);
-int hid_bpf_rdesc_fixup(struct hid_bpf_ctx *ctx);
-
 /*
  * Below is HID internal
  */
 
-/* internal function to call eBPF programs, not to be used by anybody */
-int __hid_bpf_tail_call(struct hid_bpf_ctx *ctx);
-
 #define HID_BPF_MAX_PROGS_PER_DEV 64
 #define HID_BPF_FLAG_MASK (((HID_BPF_FLAG_MAX - 1) << 1) - 1)
 
-/* types of HID programs to attach to */
-enum hid_bpf_prog_type {
-	HID_BPF_PROG_TYPE_UNDEF = -1,
-	HID_BPF_PROG_TYPE_DEVICE_EVENT,			/* an event is emitted from the device */
-	HID_BPF_PROG_TYPE_RDESC_FIXUP,
-	HID_BPF_PROG_TYPE_MAX,
-};
 
 struct hid_report_enum;
 
@@ -170,11 +150,6 @@ struct hid_bpf_ops {
 	struct hid_device *hdev;
 } ____cacheline_aligned_in_smp;
 
-struct hid_bpf_prog_list {
-	u16 prog_idx[HID_BPF_MAX_PROGS_PER_DEV];
-	u8 prog_cnt;
-};
-
 /* stored in each device */
 struct hid_bpf {
 	u8 *device_data;		/* allocated when a bpf program of type
@@ -182,23 +157,13 @@ struct hid_bpf {
 					 * to this HID device
 					 */
 	u32 allocated_data;
-
-	struct hid_bpf_prog_list __rcu *progs[HID_BPF_PROG_TYPE_MAX];	/* attached BPF progs */
 	bool destroyed;			/* prevents the assignment of any progs */
 
-	spinlock_t progs_lock;		/* protects RCU update of progs */
-
 	struct hid_bpf_ops *rdesc_ops;
 	struct list_head prog_list;
 	struct mutex prog_list_lock;	/* protects RCU update of prog_list */
 };
 
-/* specific HID-BPF link when a program is attached to a device */
-struct hid_bpf_link {
-	struct bpf_link link;
-	int hid_table_index;
-};
-
 #ifdef CONFIG_HID_BPF
 u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type, u8 *data,
 				  u32 *size, int interrupt);

-- 
2.44.0


