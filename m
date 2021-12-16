Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACF14779AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 17:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbhLPQuz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 11:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239754AbhLPQuy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 11:50:54 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC4AC06173E
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 08:50:53 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so3579010wmd.5
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 08:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sT7c6xsY79+p4VjCJ0GuWfCfN2sZ5xBnIoxrf7S6ddA=;
        b=zXJ8r9ZL0HMuqNYJiTcdyKwaAcd2Hm/hnU26Go6jzk3Hiqo6X0i9NLN9p6AspDCY0V
         DnjMCTaUmWGj8gTU4jp+mH45CQeZtiarFsCe+yc/f0nDOdAnPxjQC70VaJKYtLnLRShG
         PfSJ2EX7Nbd5fP3chAm3iaKeLZkRETpU0Ch5pbTy9u16mVSub4HJUIj7TwAybF5baBVB
         aXLVkPwjApwqDmEmqo9gMgPyBsB+4+3BjQeNQZ7QmKQ6kHmoEpzrgXUATJf+2OTny8zg
         HYP2jb9qpyT3+5zqx7mRL6VNvRtyMVnbb4ZHIkWgaGVJckVXv43kTDFrMfYDkPpU0rUj
         fK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sT7c6xsY79+p4VjCJ0GuWfCfN2sZ5xBnIoxrf7S6ddA=;
        b=gap5LUPlfV5pQJF00eZ1MSt+5pLBPdPgv8KmOkruoDtRhJLGc7OLcdJaQ1I1Sy0ox9
         G5zQTKCdTCVQdaGVicLFC6FdpTLY7EkREDukpZz31Uk8syR+wv4vDM9kiDuytKxrAzo3
         8ta6qVoui3S2AN8YyoYhxWjzCvtUDd+AH6JEOdJuaLItXBr5CKnNDWfKHUY9AdqDLRMJ
         GF/YXO3KpBmq3MSjWwvAVE7PmAwwUASTEp+nqUtCMU+8WjWE4b/kZEi+T3j9FoEKf36a
         my4w+56ChHA8CXMRGP3Ww6sMCzj1gbouVpxRgbhfr8yZqUBUCPWHTZpCfm1paWpoV1eo
         TKWQ==
X-Gm-Message-State: AOAM530o8BMmduYnVmAsNBI+fqppn1SnKHHn8dOk0liOJ3Ikp3Ls8ijA
        n5fxt08hkF4f163QOWEDKhFvbw==
X-Google-Smtp-Source: ABdhPJyYw/JR5XWgtcqwAnuLqgpwIaezx+JHl1pGQ/V7SoktSGt0KL2b9TPIMm6Wy/etnCFJyiPINw==
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr5873052wmn.98.1639673452137;
        Thu, 16 Dec 2021 08:50:52 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id y15sm7438906wry.72.2021.12.16.08.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:50:51 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: Enable cross-building with clang
Date:   Thu, 16 Dec 2021 16:38:43 +0000
Message-Id: <20211216163842.829836-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216163842.829836-1-jean-philippe@linaro.org>
References: <20211216163842.829836-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cross building using clang requires passing the "-target" flag rather
than using the CROSS_COMPILE prefix. Makefile.include transforms
CROSS_COMPILE into CLANG_CROSS_FLAGS. Clear CROSS_COMPILE for bpftool
and the host libbpf, and use the clang flags for urandom_read and bench.

Acked-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 43f6f3159431..42ffc24e9e71 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -170,7 +170,7 @@ $(OUTPUT)/%:%.c
 
 $(OUTPUT)/urandom_read: urandom_read.c
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(LDFLAGS) $< $(LDLIBS) -Wl,--build-id=sha1 -o $@
+	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $< $(LDLIBS) -Wl,--build-id=sha1 -o $@
 
 $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
 	$(call msg,MOD,,$@)
@@ -217,7 +217,7 @@ BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
-		    CC=$(HOSTCC) LD=$(HOSTLD)				       \
+		    ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD) 	       \
 		    EXTRA_CFLAGS='-g -O0'				       \
 		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
 		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/		       \
@@ -248,7 +248,7 @@ $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 		$(APIDIR)/linux/bpf.h					       \
 		| $(HOST_BUILD_DIR)/libbpf
 	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
-		    EXTRA_CFLAGS='-g -O0'				       \
+		    EXTRA_CFLAGS='-g -O0' ARCH= CROSS_COMPILE=		       \
 		    OUTPUT=$(HOST_BUILD_DIR)/libbpf/ CC=$(HOSTCC) LD=$(HOSTLD) \
 		    DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
 endif
@@ -551,7 +551,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_bpf_loop.o \
 		 $(OUTPUT)/bench_strncmp.o
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
-- 
2.34.1

