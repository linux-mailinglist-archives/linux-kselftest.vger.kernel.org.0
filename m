Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0B645958B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Nov 2021 20:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbhKVT1G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Nov 2021 14:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbhKVT1B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Nov 2021 14:27:01 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3950FC061759
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Nov 2021 11:23:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so690275wmc.2
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Nov 2021 11:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vbsyyCPgwGcNnodUMG2F0UwivpAF3DhXaUta4p1GbE=;
        b=gqsg4lwy4awKuATbyfW9UconAkvdcpubQ0Fg6ZJmn1jWl1+DAI158OphbI9/m3JF0T
         lcaSMgr+c3E2AytYUiEnOLK0yv93QO2SiTJ9P5kK9fegBhN3bg732CU2eXs1xmF/tHPN
         FzKi5NOVMEpyIo6ysMJ+KjaYqO+rGMxrUIBcd7lKTKx1U87FH9DFBbWkbrClKmfvQEIC
         V+94I9tGizHddINl2+HparAL9qFvPJWt42xx2pBJrvdZYLv15kToIWv9qObJhuzVpvn+
         Y/KRj/iDwxNqBP3jLj7U1L1irc4Zw0blvFqZ2/NhMrARULQAidKfnkP1fegzim7pB2eP
         DL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vbsyyCPgwGcNnodUMG2F0UwivpAF3DhXaUta4p1GbE=;
        b=xTdPPnje6iWrNr2/nLAno4nbxRANFvn/5DqAHN29J+pcsJjG5qB7aFbNPb42yDl2kr
         4fm5tHxqiuHPOPlWIq5UAPF1jSPfPyDi2s3zbeV2ZZhomZowG34MfZ6IzsnYeb6dUXdG
         i+ASIRCodHWO2h9tjhzURnalOsfyNhQDQCbM6aAK+CLJSnZ63/j7Hpo+RYxX/Mc1l9SM
         aq6EXCnlRuJBmrBgDV+Zyu01DvvfvIGwrnK6uEDjgph9DXqarTcHg7DSY9gI4JOXTXq2
         70SoMwZDOfru7DCgedcEkNbzWnokHvYL3zzRleNjqar2aYZnH7Fj8T/EJva07+BbqtLv
         v37A==
X-Gm-Message-State: AOAM5336sZbn68HTWTOgC93tl2QP4UEz7U4noJXvgl+5Dwz8DvPcY3A1
        RjaUuX8Y+H7dSBuPkQCRbXCyGw==
X-Google-Smtp-Source: ABdhPJxhuBJuggVtgn8I/kW6Rm67LaXSe55bWuoQlgX9aTnz7EjNQo6U6VHbXsjwca6yIZWln3j7rg==
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr32238695wmm.154.1637609029830;
        Mon, 22 Nov 2021 11:23:49 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id b188sm9916150wmd.45.2021.11.22.11.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 11:23:49 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 4/6] bpftool: Enable cross-building with clang
Date:   Mon, 22 Nov 2021 19:20:18 +0000
Message-Id: <20211122192019.1277299-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211122192019.1277299-1-jean-philippe@linaro.org>
References: <20211122192019.1277299-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cross-building using clang requires passing the "-target" flag rather
than using the CROSS_COMPILE prefix. Makefile.include transforms
CROSS_COMPILE into CLANG_CROSS_FLAGS, and adds that to CFLAGS. Filter
out the cross flags for the bootstrap bpftool, and erase the
CROSS_COMPILE flag for the bootstrap libbpf.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/bpf/bpftool/Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 42eb8eee3d89..b0f3e17d981a 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -57,7 +57,7 @@ $(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_HDRS_
 $(LIBBPF_BOOTSTRAP): $(wildcard $(BPF_DIR)/*.[ch] $(BPF_DIR)/Makefile) | $(LIBBPF_BOOTSTRAP_OUTPUT)
 	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_BOOTSTRAP_OUTPUT) \
 		DESTDIR=$(LIBBPF_BOOTSTRAP_DESTDIR) prefix= \
-		ARCH= CC=$(HOSTCC) LD=$(HOSTLD) $@ install_headers
+		ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD) $@ install_headers
 
 $(LIBBPF_BOOTSTRAP_INTERNAL_HDRS): $(LIBBPF_BOOTSTRAP_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_BOOTSTRAP_HDRS_DIR)
 	$(call QUIET_INSTALL, $@)
@@ -152,6 +152,9 @@ CFLAGS += -DHAVE_LIBBFD_SUPPORT
 SRCS += $(BFD_SRCS)
 endif
 
+HOST_CFLAGS = $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
+		$(filter-out $(CLANG_CROSS_FLAGS),$(CFLAGS)))
+
 BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
 
 BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o disasm.o)
@@ -202,7 +205,7 @@ endif
 CFLAGS += $(if $(BUILD_BPF_SKELS),,-DBPFTOOL_WITHOUT_SKELETONS)
 
 $(BOOTSTRAP_OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
-	$(QUIET_CC)$(HOSTCC) $(CFLAGS) -c -MMD $< -o $@
+	$(QUIET_CC)$(HOSTCC) $(HOST_CFLAGS) -c -MMD $< -o $@
 
 $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
 	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD $< -o $@
@@ -213,15 +216,13 @@ ifneq ($(feature-zlib), 1)
 endif
 
 $(BPFTOOL_BOOTSTRAP): $(BOOTSTRAP_OBJS) $(LIBBPF_BOOTSTRAP)
-	$(QUIET_LINK)$(HOSTCC) $(CFLAGS) $(LDFLAGS) $(BOOTSTRAP_OBJS) $(LIBS_BOOTSTRAP) -o $@
+	$(QUIET_LINK)$(HOSTCC) $(HOST_CFLAGS) $(LDFLAGS) $(BOOTSTRAP_OBJS) $(LIBS_BOOTSTRAP) -o $@
 
 $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(LIBS) -o $@
 
 $(BOOTSTRAP_OUTPUT)%.o: %.c $(LIBBPF_BOOTSTRAP_INTERNAL_HDRS) | $(BOOTSTRAP_OUTPUT)
-	$(QUIET_CC)$(HOSTCC) \
-		$(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),$(CFLAGS)) \
-		-c -MMD $< -o $@
+	$(QUIET_CC)$(HOSTCC) $(HOST_CFLAGS) -c -MMD $< -o $@
 
 $(OUTPUT)%.o: %.c
 	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD $< -o $@
-- 
2.33.1

