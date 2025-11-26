Return-Path: <linux-kselftest+bounces-46486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBA0C886DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 08:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 751404E2AA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 07:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0710296BB6;
	Wed, 26 Nov 2025 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UNLPgSW8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069F028D83F
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764142462; cv=none; b=gx5gSkaCAZYiqBCi3jxjV2QUUoUHwzofu5pkdR/Y8Hv8/96H7OZQsogPhufGeNIv2s/p/RWXN5/0Y8c0Wtmru3qPCrN8FMilAjrnHIs+ivwETfvYWyPa35K6gSE/XFZrnJzaYOXItkeJyWvPlxCufuQrqRyEskewMX4E4b1rbxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764142462; c=relaxed/simple;
	bh=HZHGEbWf4duCcAC2IFhVoTDYI22CIbFxeNitmSzTs0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o394M/XHT933eofolRcGTbNOPLn/xhdvEKxXHbBmBCGwqyQp3xGIWD/91rExPPR+3GuwNkOAnwXOoa7NKjJY3srJEHjZe3XEa3wH5Hoko3sckm8ekgjhq9gcuQZUVHJQi5x8WqsLjeCWLQkoL2LhiNjaRt5oNkWlAMdufrH7aAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UNLPgSW8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47774d3536dso4238325e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 23:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764142458; x=1764747258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPEFWx+aW9QC/nVK0x1/EOh/U5whRCkAn5X7jEbwW2g=;
        b=UNLPgSW8DaMda8t1FwNmLGrtiK7hHUsM8QU1mtaqR4nYHmIvV4FxYEYAzbp+6y1y8a
         nygzb1QX9mt1P7nE3w/wrGp11x/R3zQlLr140SjHdCOzfcFBVCjE4/7kOZ8kcRIZ7V9j
         lqeret/TM4t3qCiLNU9VG+E3/09jr/FNyU+fpuW8eOf/C+8vZ8oW8NTrYa3QRVZ97YRW
         eF8aHcpEBiL+c5uAnV4HXuZEd6iJWkkZqEiZHmzQxT5ZWCHNgPqcQeIrWvHeBk/LTdA0
         f94xhyKFQ3QFEUbjl+xcMvKnNbT2vixL1xah2xifg4hIMyn72ZYYvGlFvM2bxjd5va9z
         nxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764142458; x=1764747258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPEFWx+aW9QC/nVK0x1/EOh/U5whRCkAn5X7jEbwW2g=;
        b=KztBmfBGHsia5CS+JPesNsCs5QA4K7dH6LFVs/S2zoxWapAZ8kyHiFwDmM3aLvLxht
         oL6d0Q1I2c5OrlYUAKvCyq5w5xV1xgVnuvRmG+mVcEfVRCgdLxO42PDJfLHtBIgCG6OW
         HYTbPr6QF/4EfsJvsxY1w11IFEJNeYEASGAhGFyho5DxHGsqvASYmpSpg73CtPGEQJ7M
         ulzlkJ50Mg46wQX/Cs3iGVyXHyPDBv1nr770YHIxem9X5qg28h41CPR/BCr5zlcrG/5O
         Xl1fDsqvFPnGtAyEXX0GSJ1UG3AYdrZozlOWrExp1Vd+9EYWV6KZszYEJvxQ0PmW8PFv
         1jJA==
X-Forwarded-Encrypted: i=1; AJvYcCUN8ZGKEm+jIRB2C+bwT1HiW8uwcZJe8TMhKyzY0qBmWrBA/ZfqT5Y5tPKiVzUNz07eHNyfJgAxMOiS8qNwJ1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/tzfKW9hFho1G+Iyitz3qyulqeICnvdHFi6BhyHMy0ioEuKu
	0T3BfCW10xTniJXoXjvG9Z37i3HZG84XNShOIyFUuYMcJLisZfZo7lhcBzuOFaBH+nY=
X-Gm-Gg: ASbGncvzmT80DULlfUQwfQMMV+q4NdIC+TU14pKd/+jxs91z2dicY4SJsgjmF011e9l
	OZtRlKZmD2NQDp4VB4nEnIiEmPORTbZBjkSPjZ8+Q7BVMdNdO0ZX3LDBSTxZ+VhA/xQ1lco4SiX
	qmEHgPSLTgQQYVAUIoXoIr1HNU+5WSJvkOZar6MKPjsghEmVWEczTUQS4w2z4M8MEsX/3dxTpxL
	tv/Hs/6wjN2obaVT1n5E/Q/Taa7OtuiScA1JeTgmIGf/JrKYMfOhtOUWFMm2gO1CeXKysWcmKVH
	fbXHlCggubbQEqx3w+cFQxT+wmkcGFQ3H6eHHNeQ9eLikjuN+QGbqc8qzbPnIhK4+SqrngJxnF9
	b9Ykm3CRGm2UtV5lDHaVKNMLhpDuGXZ+v0zqTQ+BNdaroPRfb/b6+7XTRNanqV8i6/mXoE5zS81
	9Nozdaca1Dqw6crYCKqMYc2fXQ9qxGKnO01WpCZ+ucSfohQwYZKA==
X-Google-Smtp-Source: AGHT+IExbNcMrZ8ihgVaZHsrCfvACWEaSJvBZnWNl9nlwlY/Qjpy6FU6zmaHua6tMjGBUq1Hvlg8Yg==
X-Received: by 2002:a7b:cbd3:0:b0:477:991c:a17c with SMTP id 5b1f17b1804b1-477b9ea90b7mr161854985e9.6.1764142458142;
        Tue, 25 Nov 2025 23:34:18 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a5603bdsm1603290a91.8.2025.11.25.23.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 23:34:17 -0800 (PST)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org
Cc: Hoyeon Lee <hoyeon.lee@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] tools: bpf: remove runqslower tool
Date: Wed, 26 Nov 2025 16:33:00 +0900
Message-ID: <20251126073308.365432-3-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

runqslower was added in commit 9c01546d26d2 ("tools/bpf: Add runqslower
tool to tools/bpf") as a BCC port to showcase early BPF CO-RE + libbpf
workflows. runqslower continues to live in BCC (libbpf-tools), so there
is no need to keep building and maintaining it.

Drop tools/bpf/runqslower and remove all build hooks in tools/bpf and
selftests accordingly.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 tools/bpf/Makefile                            |  13 +-
 tools/bpf/runqslower/.gitignore               |   2 -
 tools/bpf/runqslower/Makefile                 |  91 ----------
 tools/bpf/runqslower/runqslower.bpf.c         | 106 -----------
 tools/bpf/runqslower/runqslower.c             | 171 ------------------
 tools/bpf/runqslower/runqslower.h             |  13 --
 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |  14 --
 .../selftests/bpf/test_bpftool_build.sh       |   4 -
 9 files changed, 3 insertions(+), 412 deletions(-)
 delete mode 100644 tools/bpf/runqslower/.gitignore
 delete mode 100644 tools/bpf/runqslower/Makefile
 delete mode 100644 tools/bpf/runqslower/runqslower.bpf.c
 delete mode 100644 tools/bpf/runqslower/runqslower.c
 delete mode 100644 tools/bpf/runqslower/runqslower.h

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index 062bbd6cd048..fd2585af1252 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -32,7 +32,7 @@ FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled
 FEATURE_DISPLAY = libbfd
 
 check_feat := 1
-NON_CHECK_FEAT_TARGETS := clean bpftool_clean runqslower_clean resolve_btfids_clean
+NON_CHECK_FEAT_TARGETS := clean bpftool_clean resolve_btfids_clean
 ifdef MAKECMDGOALS
 ifeq ($(filter-out $(NON_CHECK_FEAT_TARGETS),$(MAKECMDGOALS)),)
   check_feat := 0
@@ -70,7 +70,7 @@ $(OUTPUT)%.lex.o: $(OUTPUT)%.lex.c
 
 PROGS = $(OUTPUT)bpf_jit_disasm $(OUTPUT)bpf_dbg $(OUTPUT)bpf_asm
 
-all: $(PROGS) bpftool runqslower
+all: $(PROGS) bpftool
 
 $(OUTPUT)bpf_jit_disasm: CFLAGS += -DPACKAGE='bpf_jit_disasm'
 $(OUTPUT)bpf_jit_disasm: $(OUTPUT)bpf_jit_disasm.o
@@ -86,7 +86,7 @@ $(OUTPUT)bpf_exp.lex.c: $(OUTPUT)bpf_exp.yacc.c
 $(OUTPUT)bpf_exp.yacc.o: $(OUTPUT)bpf_exp.yacc.c
 $(OUTPUT)bpf_exp.lex.o: $(OUTPUT)bpf_exp.lex.c
 
-clean: bpftool_clean runqslower_clean resolve_btfids_clean
+clean: bpftool_clean resolve_btfids_clean
 	$(call QUIET_CLEAN, bpf-progs)
 	$(Q)$(RM) -r -- $(OUTPUT)*.o $(OUTPUT)bpf_jit_disasm $(OUTPUT)bpf_dbg \
 	       $(OUTPUT)bpf_asm $(OUTPUT)bpf_exp.yacc.* $(OUTPUT)bpf_exp.lex.*
@@ -112,12 +112,6 @@ bpftool_install:
 bpftool_clean:
 	$(call descend,bpftool,clean)
 
-runqslower:
-	$(call descend,runqslower)
-
-runqslower_clean:
-	$(call descend,runqslower,clean)
-
 resolve_btfids:
 	$(call descend,resolve_btfids)
 
@@ -125,5 +119,4 @@ resolve_btfids_clean:
 	$(call descend,resolve_btfids,clean)
 
 .PHONY: all install clean bpftool bpftool_install bpftool_clean \
-	runqslower runqslower_clean \
 	resolve_btfids resolve_btfids_clean
diff --git a/tools/bpf/runqslower/.gitignore b/tools/bpf/runqslower/.gitignore
deleted file mode 100644
index ffdb70230c8b..000000000000
--- a/tools/bpf/runqslower/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-/.output
diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
deleted file mode 100644
index 78a436c4072e..000000000000
--- a/tools/bpf/runqslower/Makefile
+++ /dev/null
@@ -1,91 +0,0 @@
-# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-include ../../scripts/Makefile.include
-
-OUTPUT ?= $(abspath .output)/
-
-BPFTOOL_OUTPUT := $(OUTPUT)bpftool/
-DEFAULT_BPFTOOL := $(BPFTOOL_OUTPUT)bootstrap/bpftool
-BPFTOOL ?= $(DEFAULT_BPFTOOL)
-BPF_TARGET_ENDIAN ?= --target=bpf
-LIBBPF_SRC := $(abspath ../../lib/bpf)
-BPFOBJ_OUTPUT := $(OUTPUT)libbpf/
-BPFOBJ := $(BPFOBJ_OUTPUT)libbpf.a
-BPF_DESTDIR := $(BPFOBJ_OUTPUT)
-BPF_INCLUDE := $(BPF_DESTDIR)/include
-INCLUDES := -I$(OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../include/uapi)
-CFLAGS := -g -Wall $(CLANG_CROSS_FLAGS)
-CFLAGS += $(EXTRA_CFLAGS)
-LDFLAGS += $(EXTRA_LDFLAGS)
-LDLIBS += -lelf -lz
-
-# Try to detect best kernel BTF source
-KERNEL_REL := $(shell uname -r)
-VMLINUX_BTF_PATHS := $(if $(O),$(O)/vmlinux)		\
-	$(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux) \
-	../../../vmlinux /sys/kernel/btf/vmlinux	\
-	/boot/vmlinux-$(KERNEL_REL)
-VMLINUX_BTF_PATH := $(or $(VMLINUX_BTF),$(firstword			       \
-					  $(wildcard $(VMLINUX_BTF_PATHS))))
-
-ifneq ($(V),1)
-MAKEFLAGS += --no-print-directory
-submake_extras := feature_display=0
-endif
-
-.DELETE_ON_ERROR:
-
-.PHONY: all clean runqslower libbpf_hdrs
-all: runqslower
-
-runqslower: $(OUTPUT)/runqslower
-
-clean:
-	$(call QUIET_CLEAN, runqslower)
-	$(Q)$(RM) -r $(BPFOBJ_OUTPUT) $(BPFTOOL_OUTPUT)
-	$(Q)$(RM) $(OUTPUT)*.o $(OUTPUT)*.d
-	$(Q)$(RM) $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
-	$(Q)$(RM) $(OUTPUT)runqslower
-	$(Q)$(RM) -r .output
-
-libbpf_hdrs: $(BPFOBJ)
-
-$(OUTPUT)/runqslower: $(OUTPUT)/runqslower.o $(BPFOBJ)
-	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
-
-$(OUTPUT)/runqslower.o: runqslower.h $(OUTPUT)/runqslower.skel.h	      \
-			$(OUTPUT)/runqslower.bpf.o | libbpf_hdrs
-
-$(OUTPUT)/runqslower.bpf.o: $(OUTPUT)/vmlinux.h runqslower.h | libbpf_hdrs
-
-$(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
-	$(QUIET_GEN)$(BPFTOOL) gen skeleton $< > $@
-
-$(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
-	$(QUIET_GEN)$(CLANG) -g -O2 $(BPF_TARGET_ENDIAN) $(INCLUDES)	      \
-		 -c $(filter %.c,$^) -o $@ &&				      \
-	$(LLVM_STRIP) -g $@
-
-$(OUTPUT)/%.o: %.c | $(OUTPUT)
-	$(QUIET_CC)$(CC) $(CFLAGS) $(INCLUDES) -c $(filter %.c,$^) -o $@
-
-$(OUTPUT) $(BPFOBJ_OUTPUT) $(BPFTOOL_OUTPUT):
-	$(QUIET_MKDIR)mkdir -p $@
-
-$(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
-ifeq ($(VMLINUX_H),)
-	$(Q)if [ ! -e "$(VMLINUX_BTF_PATH)" ] ; then \
-		echo "Couldn't find kernel BTF; set VMLINUX_BTF to"	       \
-			"specify its location." >&2;			       \
-		exit 1;\
-	fi
-	$(QUIET_GEN)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
-else
-	$(Q)cp "$(VMLINUX_H)" $@
-endif
-
-$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(BPFOBJ_OUTPUT)
-	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(BPFOBJ_OUTPUT) \
-		    DESTDIR=$(BPFOBJ_OUTPUT) prefix= $(abspath $@) install_headers
-
-$(DEFAULT_BPFTOOL): | $(BPFTOOL_OUTPUT)
-	$(Q)$(MAKE) $(submake_extras) -C ../bpftool OUTPUT=$(BPFTOOL_OUTPUT) bootstrap
diff --git a/tools/bpf/runqslower/runqslower.bpf.c b/tools/bpf/runqslower/runqslower.bpf.c
deleted file mode 100644
index fced54a3adf6..000000000000
--- a/tools/bpf/runqslower/runqslower.bpf.c
+++ /dev/null
@@ -1,106 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2019 Facebook
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include "runqslower.h"
-
-#define TASK_RUNNING 0
-#define BPF_F_CURRENT_CPU 0xffffffffULL
-
-const volatile __u64 min_us = 0;
-const volatile pid_t targ_pid = 0;
-
-struct {
-	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
-	__uint(map_flags, BPF_F_NO_PREALLOC);
-	__type(key, int);
-	__type(value, u64);
-} start SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
-	__uint(key_size, sizeof(u32));
-	__uint(value_size, sizeof(u32));
-} events SEC(".maps");
-
-/* record enqueue timestamp */
-__always_inline
-static int trace_enqueue(struct task_struct *t)
-{
-	u32 pid = t->pid;
-	u64 *ptr;
-
-	if (!pid || (targ_pid && targ_pid != pid))
-		return 0;
-
-	ptr = bpf_task_storage_get(&start, t, 0,
-				   BPF_LOCAL_STORAGE_GET_F_CREATE);
-	if (!ptr)
-		return 0;
-
-	*ptr = bpf_ktime_get_ns();
-	return 0;
-}
-
-SEC("tp_btf/sched_wakeup")
-int handle__sched_wakeup(u64 *ctx)
-{
-	/* TP_PROTO(struct task_struct *p) */
-	struct task_struct *p = (void *)ctx[0];
-
-	return trace_enqueue(p);
-}
-
-SEC("tp_btf/sched_wakeup_new")
-int handle__sched_wakeup_new(u64 *ctx)
-{
-	/* TP_PROTO(struct task_struct *p) */
-	struct task_struct *p = (void *)ctx[0];
-
-	return trace_enqueue(p);
-}
-
-SEC("tp_btf/sched_switch")
-int handle__sched_switch(u64 *ctx)
-{
-	/* TP_PROTO(bool preempt, struct task_struct *prev,
-	 *	    struct task_struct *next)
-	 */
-	struct task_struct *prev = (struct task_struct *)ctx[1];
-	struct task_struct *next = (struct task_struct *)ctx[2];
-	struct runq_event event = {};
-	u64 *tsp, delta_us;
-	u32 pid;
-
-	/* ivcsw: treat like an enqueue event and store timestamp */
-	if (prev->__state == TASK_RUNNING)
-		trace_enqueue(prev);
-
-	pid = next->pid;
-
-	/* For pid mismatch, save a bpf_task_storage_get */
-	if (!pid || (targ_pid && targ_pid != pid))
-		return 0;
-
-	/* fetch timestamp and calculate delta */
-	tsp = bpf_task_storage_get(&start, next, 0, 0);
-	if (!tsp)
-		return 0;   /* missed enqueue */
-
-	delta_us = (bpf_ktime_get_ns() - *tsp) / 1000;
-	if (min_us && delta_us <= min_us)
-		return 0;
-
-	event.pid = pid;
-	event.delta_us = delta_us;
-	bpf_get_current_comm(&event.task, sizeof(event.task));
-
-	/* output */
-	bpf_perf_event_output(ctx, &events, BPF_F_CURRENT_CPU,
-			      &event, sizeof(event));
-
-	bpf_task_storage_delete(&start, next);
-	return 0;
-}
-
-char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/bpf/runqslower/runqslower.c b/tools/bpf/runqslower/runqslower.c
deleted file mode 100644
index 83c5993a139a..000000000000
--- a/tools/bpf/runqslower/runqslower.c
+++ /dev/null
@@ -1,171 +0,0 @@
-// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-// Copyright (c) 2019 Facebook
-#include <argp.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <time.h>
-#include <bpf/libbpf.h>
-#include <bpf/bpf.h>
-#include "runqslower.h"
-#include "runqslower.skel.h"
-
-struct env {
-	pid_t pid;
-	__u64 min_us;
-	bool verbose;
-} env = {
-	.min_us = 10000,
-};
-
-const char *argp_program_version = "runqslower 0.1";
-const char *argp_program_bug_address = "<bpf@vger.kernel.org>";
-const char argp_program_doc[] =
-"runqslower    Trace long process scheduling delays.\n"
-"              For Linux, uses eBPF, BPF CO-RE, libbpf, BTF.\n"
-"\n"
-"This script traces high scheduling delays between tasks being\n"
-"ready to run and them running on CPU after that.\n"
-"\n"
-"USAGE: runqslower [-p PID] [min_us]\n"
-"\n"
-"EXAMPLES:\n"
-"    runqslower         # trace run queue latency higher than 10000 us (default)\n"
-"    runqslower 1000    # trace run queue latency higher than 1000 us\n"
-"    runqslower -p 123  # trace pid 123 only\n";
-
-static const struct argp_option opts[] = {
-	{ "pid", 'p', "PID", 0, "Process PID to trace"},
-	{ "verbose", 'v', NULL, 0, "Verbose debug output" },
-	{},
-};
-
-static error_t parse_arg(int key, char *arg, struct argp_state *state)
-{
-	static int pos_args;
-	int pid;
-	long long min_us;
-
-	switch (key) {
-	case 'v':
-		env.verbose = true;
-		break;
-	case 'p':
-		errno = 0;
-		pid = strtol(arg, NULL, 10);
-		if (errno || pid <= 0) {
-			fprintf(stderr, "Invalid PID: %s\n", arg);
-			argp_usage(state);
-		}
-		env.pid = pid;
-		break;
-	case ARGP_KEY_ARG:
-		if (pos_args++) {
-			fprintf(stderr,
-				"Unrecognized positional argument: %s\n", arg);
-			argp_usage(state);
-		}
-		errno = 0;
-		min_us = strtoll(arg, NULL, 10);
-		if (errno || min_us <= 0) {
-			fprintf(stderr, "Invalid delay (in us): %s\n", arg);
-			argp_usage(state);
-		}
-		env.min_us = min_us;
-		break;
-	default:
-		return ARGP_ERR_UNKNOWN;
-	}
-	return 0;
-}
-
-int libbpf_print_fn(enum libbpf_print_level level,
-		    const char *format, va_list args)
-{
-	if (level == LIBBPF_DEBUG && !env.verbose)
-		return 0;
-	return vfprintf(stderr, format, args);
-}
-
-void handle_event(void *ctx, int cpu, void *data, __u32 data_sz)
-{
-	const struct runq_event *e = data;
-	struct tm *tm;
-	char ts[32];
-	time_t t;
-
-	time(&t);
-	tm = localtime(&t);
-	strftime(ts, sizeof(ts), "%H:%M:%S", tm);
-	printf("%-8s %-16s %-6d %14llu\n", ts, e->task, e->pid, e->delta_us);
-}
-
-void handle_lost_events(void *ctx, int cpu, __u64 lost_cnt)
-{
-	printf("Lost %llu events on CPU #%d!\n", lost_cnt, cpu);
-}
-
-int main(int argc, char **argv)
-{
-	static const struct argp argp = {
-		.options = opts,
-		.parser = parse_arg,
-		.doc = argp_program_doc,
-	};
-	struct perf_buffer *pb = NULL;
-	struct runqslower_bpf *obj;
-	int err;
-
-	err = argp_parse(&argp, argc, argv, 0, NULL, NULL);
-	if (err)
-		return err;
-
-	libbpf_set_print(libbpf_print_fn);
-
-	/* Use libbpf 1.0 API mode */
-	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
-
-	obj = runqslower_bpf__open();
-	if (!obj) {
-		fprintf(stderr, "failed to open and/or load BPF object\n");
-		return 1;
-	}
-
-	/* initialize global data (filtering options) */
-	obj->rodata->targ_pid = env.pid;
-	obj->rodata->min_us = env.min_us;
-
-	err = runqslower_bpf__load(obj);
-	if (err) {
-		fprintf(stderr, "failed to load BPF object: %d\n", err);
-		goto cleanup;
-	}
-
-	err = runqslower_bpf__attach(obj);
-	if (err) {
-		fprintf(stderr, "failed to attach BPF programs\n");
-		goto cleanup;
-	}
-
-	printf("Tracing run queue latency higher than %llu us\n", env.min_us);
-	printf("%-8s %-16s %-6s %14s\n", "TIME", "COMM", "PID", "LAT(us)");
-
-	pb = perf_buffer__new(bpf_map__fd(obj->maps.events), 64,
-			      handle_event, handle_lost_events, NULL, NULL);
-	err = libbpf_get_error(pb);
-	if (err) {
-		pb = NULL;
-		fprintf(stderr, "failed to open perf buffer: %d\n", err);
-		goto cleanup;
-	}
-
-	while ((err = perf_buffer__poll(pb, 100)) >= 0)
-		;
-	printf("Error polling perf buffer: %d\n", err);
-
-cleanup:
-	perf_buffer__free(pb);
-	runqslower_bpf__destroy(obj);
-
-	return err != 0;
-}
diff --git a/tools/bpf/runqslower/runqslower.h b/tools/bpf/runqslower/runqslower.h
deleted file mode 100644
index 4f70f07200c2..000000000000
--- a/tools/bpf/runqslower/runqslower.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
-#ifndef __RUNQSLOWER_H
-#define __RUNQSLOWER_H
-
-#define TASK_COMM_LEN 16
-
-struct runq_event {
-	char task[TASK_COMM_LEN];
-	__u64 delta_us;
-	pid_t pid;
-};
-
-#endif /* __RUNQSLOWER_H */
diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index be1ee7ba7ce0..e091809f07a0 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -32,7 +32,6 @@ test_cpp
 /cpuv4
 /host-tools
 /tools
-/runqslower
 /bench
 /veristat
 /sign-file
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f00587d4ede6..79f9f96d153f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -127,7 +127,6 @@ TEST_KMOD_TARGETS = $(addprefix $(OUTPUT)/,$(TEST_KMODS))
 TEST_GEN_PROGS_EXTENDED = \
 	bench \
 	flow_dissector_load \
-	runqslower \
 	test_cpp \
 	test_lirc_mode2_user \
 	veristat \
@@ -209,8 +208,6 @@ HOST_INCLUDE_DIR	:= $(INCLUDE_DIR)
 endif
 HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
 RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
-RUNQSLOWER_OUTPUT := $(BUILD_DIR)/runqslower/
-
 VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
 		     ../../../../vmlinux				\
@@ -304,17 +301,6 @@ TRUNNER_BPFTOOL := $(DEFAULT_BPFTOOL)
 USE_BOOTSTRAP := "bootstrap/"
 endif
 
-$(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
-	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	       \
-		    OUTPUT=$(RUNQSLOWER_OUTPUT) VMLINUX_BTF=$(VMLINUX_BTF)     \
-		    BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/		       \
-		    BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf/			       \
-		    BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)		       \
-		    BPF_TARGET_ENDIAN=$(BPF_TARGET_ENDIAN)		       \
-		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXTRA_CFLAGS)' \
-		    EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)' &&	       \
-		    cp $(RUNQSLOWER_OUTPUT)runqslower $@
-
 TEST_GEN_PROGS_EXTENDED += $(TRUNNER_BPFTOOL)
 
 $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
diff --git a/tools/testing/selftests/bpf/test_bpftool_build.sh b/tools/testing/selftests/bpf/test_bpftool_build.sh
index 1453a53ed547..b03a87571592 100755
--- a/tools/testing/selftests/bpf/test_bpftool_build.sh
+++ b/tools/testing/selftests/bpf/test_bpftool_build.sh
@@ -90,10 +90,6 @@ echo -e "... through kbuild\n"
 
 if [ -f ".config" ] ; then
 	make_and_clean tools/bpf
-	## "make tools/bpf" sets $(OUTPUT) to ...tools/bpf/runqslower for
-	## runqslower, but the default (used for the "clean" target) is .output.
-	## Let's make sure we clean runqslower's directory properly.
-	make -C tools/bpf/runqslower OUTPUT=${KDIR_ROOT_DIR}/tools/bpf/runqslower/ clean
 
 	## $OUTPUT is overwritten in kbuild Makefile, and thus cannot be passed
 	## down from toplevel Makefile to bpftool's Makefile.
-- 
2.52.0


