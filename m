Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90DB2F3277
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jan 2021 15:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbhALOCI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jan 2021 09:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbhALOCI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jan 2021 09:02:08 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00010C061794
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 06:01:27 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id by27so2185472edb.10
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 06:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/yfuTkYujlI5zpMD6cZk7TUtmg/ofIBluQ9SYa0d4k=;
        b=Ob8lD9BwLkwk1Fwhio5z/w8szq2k9AeOJA2jTM9y549QSdSjGAMYhOREIggKoFq5H5
         WnSptKhIuj+B/8236Wla9mZ55kuHovqGFJoxvZ69F6EYq54plqSQUC1u5ylM2tFmb6LQ
         sKtuCFRD7H8YABeo6aVuF43lYj5IU9S3bkiLwFw/Js0hupTDnF7edWIq3Ro5les+MXpo
         h6/IbfIIyP4Y5g9qeiNTVFUxgSfXMl5BHmQ8PYRh3zxOYAYtGnpebofb2PlYprQmTLI1
         xJV31xaUjZbgw41U52eCpWFHXKpoxoDhOYWKorZ54q8R2+Qgq9m9qOqQ34aM5fHQXukE
         6CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/yfuTkYujlI5zpMD6cZk7TUtmg/ofIBluQ9SYa0d4k=;
        b=P2/KizM8z0Hv26Tqdz1wQ9k61KJxP2NgvYONbHZAolgnfG82ER0zz28MPAMMi8KReO
         vm+y6toRCD++JBTo25JfUiIVIg7a1etFaisBAtyxzVBYbJnhO9++63+y/E8bcp3ZSkej
         maeu3cbEZkMU+Z4EyCXf3wZd+kOxt4beKBiDBh91mjTB9rk5e0ExG1FeNPso6NtwcNGJ
         Zt5ySGbbjv3aG9gVfnXmXbMoqDfwaAsP/2BcSYetDl8zHo3c9c/u0bxU0KGh6qqBiBAy
         QIGkeRJJh9SKFpwQ0FwtPstszeRMYFLcIGpPqrq/m9SX1HzpMFnGbWiYAf4qyXi7Gikk
         3M3g==
X-Gm-Message-State: AOAM530qiXNhRA7PD+6g2yqLJQtMHPGoBE6yfxhfo3HoZbaIEptAzwZj
        dwAN/GexydEuDOh2k27iUVb90Q==
X-Google-Smtp-Source: ABdhPJwPwtnGSOqLzsGdYtrg6f/4OqrAfpVR5Xbc2Cj5OBeNB3lRApynbR27BLAxq4ivUhoJfAgexA==
X-Received: by 2002:aa7:c5d6:: with SMTP id h22mr3466670eds.82.1610460086628;
        Tue, 12 Jan 2021 06:01:26 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t19sm1227846ejc.62.2021.01.12.06.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:01:26 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 1/5] selftests/bpf: Enable cross-building
Date:   Tue, 12 Jan 2021 14:59:56 +0100
Message-Id: <20210112135959.649075-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112135959.649075-1-jean-philippe@linaro.org>
References: <20210112135959.649075-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Build bpftool and resolve_btfids using the host toolchain when
cross-compiling, since they are executed during build to generate the
selftests. Add a host build directory in order to build both host and
target version of libbpf. Build host tools using $(HOSTCC) defined in
Makefile.include.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 43 ++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c51df6b91bef..1d85565883ea 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 include ../../../../scripts/Kbuild.include
 include ../../../scripts/Makefile.arch
+include ../../../scripts/Makefile.include
 
 CXX ?= $(CROSS_COMPILE)g++
 
@@ -113,7 +114,20 @@ SCRATCH_DIR := $(OUTPUT)/tools
 BUILD_DIR := $(SCRATCH_DIR)/build
 INCLUDE_DIR := $(SCRATCH_DIR)/include
 BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
-RESOLVE_BTFIDS := $(BUILD_DIR)/resolve_btfids/resolve_btfids
+ifneq ($(CROSS_COMPILE),)
+HOST_BUILD_DIR		:= $(BUILD_DIR)/host
+HOST_SCRATCH_DIR	:= $(OUTPUT)/host-tools
+else
+HOST_BUILD_DIR		:= $(BUILD_DIR)
+HOST_SCRATCH_DIR	:= $(SCRATCH_DIR)
+endif
+HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
+RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
+
+# sort removes libbpf duplicates when not cross-building
+MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf	       \
+	       $(HOST_BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/resolve_btfids      \
+	       $(INCLUDE_DIR))
 
 VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
@@ -157,7 +171,7 @@ $(OUTPUT)/test_stub.o: test_stub.c $(BPFOBJ)
 	$(call msg,CC,,$@)
 	$(Q)$(CC) -c $(CFLAGS) -o $@ $<
 
-DEFAULT_BPFTOOL := $(SCRATCH_DIR)/sbin/bpftool
+DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
 
 $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL)
 	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	\
@@ -182,10 +196,11 @@ $(OUTPUT)/test_sysctl: cgroup_helpers.c
 
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
-		    $(BPFOBJ) | $(BUILD_DIR)/bpftool
+		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
-		    OUTPUT=$(BUILD_DIR)/bpftool/			       \
-		    prefix= DESTDIR=$(SCRATCH_DIR)/ install
+		    CC=$(HOSTCC) LD=$(HOSTLD)				       \
+		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
+		    prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install
 	$(Q)mkdir -p $(BUILD_DIR)/bpftool/Documentation
 	$(Q)RST2MAN_OPTS="--exit-status=1" $(MAKE) $(submake_extras)	       \
 		    -C $(BPFTOOLDIR)/Documentation			       \
@@ -198,7 +213,16 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
 		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
 
-$(BUILD_DIR)/libbpf $(BUILD_DIR)/bpftool $(BUILD_DIR)/resolve_btfids $(INCLUDE_DIR):
+ifneq ($(BPFOBJ),$(HOST_BPFOBJ))
+$(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)                \
+	   ../../../include/uapi/linux/bpf.h                                   \
+	   | $(INCLUDE_DIR) $(HOST_BUILD_DIR)/libbpf
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
+		OUTPUT=$(HOST_BUILD_DIR)/libbpf/ CC=$(HOSTCC) LD=$(HOSTLD)     \
+		    DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
+endif
+
+$(MAKE_DIRS):
 	$(call msg,MKDIR,,$@)
 	$(Q)mkdir -p $@
 
@@ -211,7 +235,7 @@ else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
-$(RESOLVE_BTFIDS): $(BPFOBJ) | $(BUILD_DIR)/resolve_btfids	\
+$(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 		       $(TOOLSDIR)/bpf/resolve_btfids/main.c	\
 		       $(TOOLSDIR)/lib/rbtree.c			\
 		       $(TOOLSDIR)/lib/zalloc.c			\
@@ -219,7 +243,8 @@ $(RESOLVE_BTFIDS): $(BPFOBJ) | $(BUILD_DIR)/resolve_btfids	\
 		       $(TOOLSDIR)/lib/ctype.c			\
 		       $(TOOLSDIR)/lib/str_error_r.c
 	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/resolve_btfids	\
-		OUTPUT=$(BUILD_DIR)/resolve_btfids/ BPFOBJ=$(BPFOBJ)
+		CC=$(HOSTCC) LD=$(HOSTLD) AR=$(HOSTAR) \
+		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
 
 # Get Clang's default includes on this system, as opposed to those seen by
 # '-target bpf'. This fixes "missing" files on some architectures/distros,
@@ -450,7 +475,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_helpers.o \
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(LDFLAGS) -o $@ $(filter %.a %.o,$^) $(LDLIBS)
 
-EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR)			\
+EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature								\
 	$(addprefix $(OUTPUT)/,*.o *.skel.h no_alu32 bpf_gcc bpf_testmod.ko)
-- 
2.30.0

