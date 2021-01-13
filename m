Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E572F5018
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 17:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbhAMQfe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jan 2021 11:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbhAMQfd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jan 2021 11:35:33 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7275EC061794
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 08:34:53 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id q22so3985319eja.2
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 08:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WzeKjk6W2CxYi95uCJrjtjO+Mh+ZYv+OVOJ0F2MC/Ds=;
        b=V1PkJPpfoUhuI2v7Or3K6Aasit7NEsidV/b+AhjMSV6csJcSObKx1qxwjxyWbZhYTV
         U1rqPVsA1/Ztz6COPZYjx0gg+fU3+E/+w191oU3rAZTG9x8koHZwx5YGzByKWcYV5X6r
         UGo5q9tp5tLy2ABaanCMNzyb1q7O19ldm/03VB+tG/EHz3Q1D7ilBrW1VV/4CpLh+fYR
         HegIe7o2CsyJJMtLNU4p97ATsjL2uN/jronxkOIDh5X0rXbV8At4PwYsyN9bc8HGSm8z
         Pd4J4o2h1pbbD2TZRvUUbENpy+EQm+U78uOo/K3p2H8KGvn61dnXsyent9BlokqGp1H4
         4+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WzeKjk6W2CxYi95uCJrjtjO+Mh+ZYv+OVOJ0F2MC/Ds=;
        b=n/gE5PoUtp26PXRP/UH05NBLliaDqigbpELUZp27D1cm+sfDbtqQ0zccuC8Aa3cWDH
         TqHRTZJLzXZ1YxQHe7EGryJtfGf5Sofp8qiM6dWRQMj2heZAekhwhPEaaxVeEa62sysO
         W4sG7AMBi6NC/jopSvtUsTmHoIp4ntPtQuXNzhus91wdQGwFYThxwAo6MtfxEjf2xGGY
         cIxX5yoEv1kdjbk+bZNpkNygxw9yyJHfjvl29ZE8JSLqLgiBZ+e0bg/qNYFUyTE5jbAA
         GSnf7jsJyLH9gwYWaxYYsZ+0zJ623UTCvexLd+iSBsYEsQau02ICAovwJVYpVqhRxlu8
         tccw==
X-Gm-Message-State: AOAM530fljMbz/lm3Rw2GWTynY/BTyvKBOB2ryR2R0cQo1QfVJ2d/UQ8
        vZTc7rg9mCNdtvCVbzztYmOEqQ==
X-Google-Smtp-Source: ABdhPJzg8H3ADXCit0AoriOFHJL0dtctl3lFhEkY2tu1GfeckpfeF4w1Mina2VQpHVoKQUn5ylbVmw==
X-Received: by 2002:a17:907:546:: with SMTP id wk6mr2117779ejb.238.1610555692085;
        Wed, 13 Jan 2021 08:34:52 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g25sm923943ejf.15.2021.01.13.08.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:34:51 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 1/5] selftests/bpf: Enable cross-building
Date:   Wed, 13 Jan 2021 17:33:16 +0100
Message-Id: <20210113163319.1516382-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210113163319.1516382-1-jean-philippe@linaro.org>
References: <20210113163319.1516382-1-jean-philippe@linaro.org>
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 46 +++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c51df6b91bef..95ce81513648 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 include ../../../../scripts/Kbuild.include
 include ../../../scripts/Makefile.arch
+include ../../../scripts/Makefile.include
 
 CXX ?= $(CROSS_COMPILE)g++
 
@@ -113,7 +114,15 @@ SCRATCH_DIR := $(OUTPUT)/tools
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
 
 VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
@@ -135,6 +144,14 @@ $(notdir $(TEST_GEN_PROGS)						\
 	 $(TEST_GEN_PROGS_EXTENDED)					\
 	 $(TEST_CUSTOM_PROGS)): %: $(OUTPUT)/% ;
 
+# sort removes libbpf duplicates when not cross-building
+MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf	       \
+	       $(HOST_BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/resolve_btfids      \
+	       $(INCLUDE_DIR))
+$(MAKE_DIRS):
+	$(call msg,MKDIR,,$@)
+	$(Q)mkdir -p $@
+
 $(OUTPUT)/%.o: %.c
 	$(call msg,CC,,$@)
 	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
@@ -157,7 +174,7 @@ $(OUTPUT)/test_stub.o: test_stub.c $(BPFOBJ)
 	$(call msg,CC,,$@)
 	$(Q)$(CC) -c $(CFLAGS) -o $@ $<
 
-DEFAULT_BPFTOOL := $(SCRATCH_DIR)/sbin/bpftool
+DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
 
 $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL)
 	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	\
@@ -182,10 +199,11 @@ $(OUTPUT)/test_sysctl: cgroup_helpers.c
 
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
@@ -198,9 +216,14 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
 		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
 
-$(BUILD_DIR)/libbpf $(BUILD_DIR)/bpftool $(BUILD_DIR)/resolve_btfids $(INCLUDE_DIR):
-	$(call msg,MKDIR,,$@)
-	$(Q)mkdir -p $@
+ifneq ($(BPFOBJ),$(HOST_BPFOBJ))
+$(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)                \
+	   ../../../include/uapi/linux/bpf.h                                   \
+	   | $(INCLUDE_DIR) $(HOST_BUILD_DIR)/libbpf
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
+		OUTPUT=$(HOST_BUILD_DIR)/libbpf/ CC=$(HOSTCC) LD=$(HOSTLD)     \
+		    DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
+endif
 
 $(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) | $(BPFTOOL) $(INCLUDE_DIR)
 ifeq ($(VMLINUX_H),)
@@ -211,7 +234,7 @@ else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
-$(RESOLVE_BTFIDS): $(BPFOBJ) | $(BUILD_DIR)/resolve_btfids	\
+$(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 		       $(TOOLSDIR)/bpf/resolve_btfids/main.c	\
 		       $(TOOLSDIR)/lib/rbtree.c			\
 		       $(TOOLSDIR)/lib/zalloc.c			\
@@ -219,7 +242,8 @@ $(RESOLVE_BTFIDS): $(BPFOBJ) | $(BUILD_DIR)/resolve_btfids	\
 		       $(TOOLSDIR)/lib/ctype.c			\
 		       $(TOOLSDIR)/lib/str_error_r.c
 	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/resolve_btfids	\
-		OUTPUT=$(BUILD_DIR)/resolve_btfids/ BPFOBJ=$(BPFOBJ)
+		CC=$(HOSTCC) LD=$(HOSTLD) AR=$(HOSTAR) \
+		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
 
 # Get Clang's default includes on this system, as opposed to those seen by
 # '-target bpf'. This fixes "missing" files on some architectures/distros,
@@ -450,7 +474,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_helpers.o \
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(LDFLAGS) -o $@ $(filter %.a %.o,$^) $(LDLIBS)
 
-EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR)			\
+EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature								\
 	$(addprefix $(OUTPUT)/,*.o *.skel.h no_alu32 bpf_gcc bpf_testmod.ko)
-- 
2.30.0

