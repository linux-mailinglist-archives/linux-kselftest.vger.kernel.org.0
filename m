Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A889459587
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Nov 2021 20:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbhKVT1E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Nov 2021 14:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbhKVT1B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Nov 2021 14:27:01 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3130CC06175D
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Nov 2021 11:23:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso74139wms.2
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Nov 2021 11:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MueQ2379h1Uuijf7NqAb6HWoHYhn8omMshbqb9U40ok=;
        b=vKmce3kDMZmUHh9EtAaylm0uTDuOHxU5YdLDjx/josn1ViJ21s1pxYrA/dggbwyKro
         NP8IfrbaB62GmB+r6YEe21cIMdos9quzJtls8cHjPai79kA2n0cyer1/sjjAfFRRh18O
         +ybc+sXph9F8kLdrR8JegSUYcjnz81dUALTw52G6rpjEzGk/sfhqy5jvnZZpICrS1OFA
         IjFr7msRc1Z88s4Ks6ELKpOB+GwZaXSw+7PU2l6O3KxUXGjJz48633YvyzJ1TagyUwde
         fLgwzDjziuhcFEeDf6N761QOw214lO+zBQ4OQhfEh/df0BW//34eDJGIwWaR8KVsgTVa
         0k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MueQ2379h1Uuijf7NqAb6HWoHYhn8omMshbqb9U40ok=;
        b=cYUU5SZnqcJGzctqyJyTsJcgB4FRnhKyDl3UPw+CCZXESCxPqAwL4+YqMHmr5UburU
         nmfe+RT3MBmULXKuvKWllCvceAvFjISYi13vregKTXwG+y/hSQ82ZKwWvj+sEfahnqOD
         Jm6B8hwb17Tsx7+VvzB9dgzbVSClERG0Yibgd7KqZd7lHYwHGKuDd8YzKjPBDPeYsYvD
         hNB9sIGSfaq+ftl9fSaDeo3f9wqh/wVA6MqkBxAH6YthkCYTy68YbfTgNsmh5RgsLUpq
         Aln6G54nzvZBSaHQwq53RAS8XbeyqDzX1G/ZC2jDa3EdkFJJdWAy3sqNUZ6HxdBMct9S
         nlJQ==
X-Gm-Message-State: AOAM5331EYgxljJjD6zLlprk24h+OU6RhoKXm+2DX8xwGz9WfYUicz76
        5HM5m74TgAtE4kyMBf6PoC8kyQ==
X-Google-Smtp-Source: ABdhPJzXyUHo0yJWSCehK43dYuv912k1yCNST/t8EupwNz6wdrdT1eg1p3ZuLuOleoZjMgl73ipD3Q==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr31898456wmj.190.1637609031784;
        Mon, 22 Nov 2021 11:23:51 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id b188sm9916150wmd.45.2021.11.22.11.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 11:23:51 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 6/6] selftests/bpf: Enable cross-building with clang
Date:   Mon, 22 Nov 2021 19:20:20 +0000
Message-Id: <20211122192019.1277299-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211122192019.1277299-1-jean-philippe@linaro.org>
References: <20211122192019.1277299-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cross building using clang requires passing the "-target" flag rather
than using the CROSS_COMPILE prefix. Makefile.include transforms
CROSS_COMPILE into CLANG_CROSS_FLAGS. Clear CROSS_COMPILE for bpftool
and the host libbpf, and use the clang flags for urandom_read and bench.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 52383fe8ba42..6c678509e949 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -170,7 +170,7 @@ $(OUTPUT)/%:%.c
 
 $(OUTPUT)/urandom_read: urandom_read.c
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(LDFLAGS) $< $(LDLIBS) -Wl,--build-id=sha1 -o $@
+	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $< $(LDLIBS) -Wl,--build-id=sha1 -o $@
 
 $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
 	$(call msg,MOD,,$@)
@@ -213,7 +213,7 @@ BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
-		    CC=$(HOSTCC) LD=$(HOSTLD)				       \
+		    ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD) 	       \
 		    EXTRA_CFLAGS='-g -O0'				       \
 		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
 		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/		       \
@@ -244,7 +244,7 @@ $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 		$(APIDIR)/linux/bpf.h					       \
 		| $(HOST_BUILD_DIR)/libbpf
 	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
-		    EXTRA_CFLAGS='-g -O0'				       \
+		    EXTRA_CFLAGS='-g -O0' ARCH= CROSS_COMPILE=		       \
 		    OUTPUT=$(HOST_BUILD_DIR)/libbpf/ CC=$(HOSTCC) LD=$(HOSTLD) \
 		    DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
 endif
@@ -542,7 +542,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_ringbufs.o \
 		 $(OUTPUT)/bench_bloom_filter_map.o
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
-- 
2.33.1

