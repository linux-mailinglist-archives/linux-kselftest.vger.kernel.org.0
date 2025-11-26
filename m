Return-Path: <linux-kselftest+bounces-46491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E6FC88FE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 10:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53FF84E155B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E102302CDE;
	Wed, 26 Nov 2025 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J/GAprF4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3742F83CB
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149960; cv=none; b=G84Q5ZIYJrbF/c/2DMNUQ2Qq134zrsvD9psemZowsT3IucwT365Oe+GaKgsxhE5OTqCVfTAgyCNc5kl2XPkQ21erTLtFde73p1BHBvKCUHteSRBnJvrQFLC1bGnk9ei3TxjQ1dY0lMExlyWZWU9Sqez73zaGRkng39FvwF/H1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149960; c=relaxed/simple;
	bh=om+eQqL4kIiy2lNyumb4grIHb6MIzuA653l+7ULEiR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ph0OMl2PVCsl4Z8gXPZGnVyjZj8b8umzXH/SEZ+bkpYMPqhvs6nP1RcDnHcPHujGXMJqIIAmqur2RhD8SrwzMVZesDdNBRIlKiEXCGibPC1uaORp9whPZvfr6Rp8EdXGsEtnuj79a4a8l5Jivegte1QtUpMgRWrICkzqYd4pazw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J/GAprF4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso4467645e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 01:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764149946; x=1764754746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+6xmd0GzT9/AUTeRYJ6kJi+uUQG7cdNszXI28WYXXs=;
        b=J/GAprF4fbY++lnqdNmdFaE6yJjzg9kHTT+tQadeZFbAf3sfD/o9QMncqE1QAbi1+z
         6LgxzbTP4jEADqke17awRmBh1qM7TQ8WollrM+fh5DJvzKRF58g2UBWLKAYrKBbhrGNV
         SqzsL8PUpl8b4ZZwB9kVZDVgBj2l7Cj5ShySfuPk8hticQWKVYoQ09sDuTHhL8+I+1AU
         DYRyS7qEGv5Q5wvk7Px9BncUHXSViH3NFcb0Fx6s7w6IQlNU/kOm+eK4e17dyLFYDLC3
         gTEyhiaM5U3OaWYx5VyiyNCqVbYF4QSABiJ+oK5wFaWTPqgFeUJs+pC8wFYX5ObKBSY3
         WS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764149946; x=1764754746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+6xmd0GzT9/AUTeRYJ6kJi+uUQG7cdNszXI28WYXXs=;
        b=t3LaYem16P3dRWWas+yjPumin2ZWPdKl7zCoZIIXUIDeAjLJ9uDhImiI6ixRwkhy4t
         KCfqC/u27amozqceaU6OG5XDUsGOVLI6tcWIj/gFn3tngLk0UXkm6hOBMCTguGLWBlZ2
         xW4lJlWKsSfH8MR2hEWqCRCjh5q5Cy/40hBlcAOtgAwXPbn0DRtF3hoIOThh0qg5gAG+
         i6rCVksFWYoR9Ttc9kjQpq2G0smGYXIRVMPJPuH4AJWz8Ln4f5wO3S45YKq7b8fpAnkP
         nPAMgNrvkBM6YGWlrqYS7SZ1IkSA3FEmtZjIX2VjiTVu9Wb4sFh/mS8MTIM4+W6EiEk7
         kPfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg97/42pTalfrPHnf2bkmVQgaEmrVUg28g72QeAX1Mvca9FtY7PYB+j9bFVALSShTf88lPNSg3HI0m7MIQfrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznyUaRTGPp8j4cjA5nyJB7D3yJ5JfBQiQJiIZ7rHOr1Q/fFqnc
	Z2alZCTal2vW/NzP0rgr2ycxk3DnYkUPRPhmSpOI9IDlNZV9g8iYaDrFvuTOBJTnxZA=
X-Gm-Gg: ASbGncsjaXaXf80wp+b+20fwjO45RDrNSE/pt0jMCo0Im9Xvg31rJuqrZPRj57tq8s/
	VmnSCu+o6zZ7rKJTKSth4MDQmtm/hhCfqQnFbK90PHYr/xiiFVfKiX8aTbTu8wyk2/8LsOoPs76
	Z29+5Ys9qXzoiQI+Synf8YlfkvczWfFF39/55lOlkcm6xKZu+KLMktwJbWwaSogRr97xFIuSE17
	RZ0KXW/+1RrGQW19mqM/CQ67wcBLaU+bKl/NbHlrP6+6Pgnn8Q+h/84sQX0ozJsdXEXGjSbVvn8
	F5gC8QociIaM3N0in1WgbGsj6g8acP9DZG0E4BKM44n16quIfwdDVHn2sdkyPFvO6JlNCJ7DDtg
	qPlqAeQYDR8wzvcDCPYb6+9easjvZzk8KKpZu3hpZn1RT65n0qSEHSRn1hfmXC6t6lCO+m7287I
	yVj05jRrXruq35fsm+Fduc8XE1uG1ULv3AK/AJfOlyVAWyGeA2FA==
X-Google-Smtp-Source: AGHT+IFhc5zZMh6wyGVDrg/kJjyoGsNNaAWNYZw1h4de4FZXAZS6SfLYWJk0bi/L5azz/8iO79YgQQ==
X-Received: by 2002:a05:600c:2e4c:b0:477:9890:4528 with SMTP id 5b1f17b1804b1-477b9ea31e9mr141585845e9.2.1764149946038;
        Wed, 26 Nov 2025 01:39:06 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a7a5d4asm1952757a91.11.2025.11.26.01.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 01:39:05 -0800 (PST)
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next v2] tools: bpf: remove runqslower tool
Date: Wed, 26 Nov 2025 18:38:11 +0900
Message-ID: <20251126093821.373291-1-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

runqslower was added in commit 9c01546d26d2 "tools/bpf: Add runqslower
tool to tools/bpf" as a BCC port to showcase early BPF CO-RE + libbpf
workflows. runqslower continues to live in BCC (libbpf-tools), so there
is no need to keep building and maintaining it.

Drop tools/bpf/runqslower and remove all build hooks in tools/bpf and
selftests accordingly.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
Changes in V2:
- remove RUNQSLOWER_OUTPUT variable from selftests/bpf Makefile

 tools/bpf/Makefile                            |  13 +-
 tools/bpf/runqslower/.gitignore               |   2 -
 tools/bpf/runqslower/Makefile                 |  91 ----------
 tools/bpf/runqslower/runqslower.bpf.c         | 106 -----------
 tools/bpf/runqslower/runqslower.c             | 171 ------------------
 tools/bpf/runqslower/runqslower.h             |  13 --
 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |  16 +-
 .../selftests/bpf/test_bpftool_build.sh       |   4 -
 9 files changed, 4 insertions(+), 413 deletions(-)
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
index f00587d4ede6..c102922365f5 100644
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
@@ -232,7 +229,7 @@ $(notdir $(TEST_GEN_PROGS) $(TEST_KMODS)				\
 MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf	\
 	       $(BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/bpftool		\
 	       $(HOST_BUILD_DIR)/resolve_btfids				\
-	       $(RUNQSLOWER_OUTPUT) $(INCLUDE_DIR))
+	       $(INCLUDE_DIR))
 $(MAKE_DIRS):
 	$(call msg,MKDIR,,$@)
 	$(Q)mkdir -p $@
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


