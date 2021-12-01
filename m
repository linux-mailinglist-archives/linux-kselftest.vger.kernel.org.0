Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BC94650A8
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 15:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbhLAPDC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 10:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbhLAPDB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 10:03:01 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44B3C061574
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Dec 2021 06:59:40 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d24so53013528wra.0
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Dec 2021 06:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RS1vzmzmQeEBjKlSDlmgEppWunZ2lvwJs6T3YgQzeck=;
        b=PADzr4eyzFeEVSKDETkultCMlz+18FGAcT2+wAOK1FssyF0X1L3HQ1tTsp8n/esGtf
         oJIwQbQZJIfeuORQAE6fn+d8sBcoe7pzLMmyM7as0o3M/ZAsioDKYEp7zpeuWrAa+qol
         uz9C5SV6r9cd2PQ3skbPjj6CIDhjl5LBBtYbcpO5TSOe3mtt0fd92JNyiq4cUIfMsiC8
         ngcjmRFGr0TMe44bqGKuwtfYxI9CelQ5lOEkvJhLzW4NwTdSyN18PQImaeNdtVkrrJ5Y
         ouKchDn6OAgX4ZfDbjW3ZdjmZ9UnkFGFxPSIiqDJrq/egTrf31/LzTWkphe77foOGJSj
         HOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RS1vzmzmQeEBjKlSDlmgEppWunZ2lvwJs6T3YgQzeck=;
        b=T3VG1fBzpp/0dwevNGdJPMOQacduBfxXX0GNmqgIaDg+n4lgR0+omjNQNm771NKs4v
         HLvoFR+z4mvDAF/zOvhKdEcO2sJh8kQ/hcAOEupWiPtdHEGVCjewkzmk/pNszzKGUdoI
         B8Dg/gFfV2ARpDEhfRKQPrRb5n9IINgfgM80PfBT1/OWbbjdS2yFg0UL0DtNu+BP0nYu
         1s4gLjovDgsjgSKocdhRfwX9zXLwXW0fEtHMEo/bTO6CFj6c7ktVvr0HaD7P02uoKyqQ
         gwZrlm/+V36Fo+mcAO272ILKvLJUpHnkXmr7DqybpZ+DY+stRGOFQduVIaGqjlVYdQ5H
         7E9A==
X-Gm-Message-State: AOAM5318Czp1xL58EpujeRKrvO2itB4N95OX6mdeBNAzUhoIrh/10TXo
        Yxd7wVRWOOZbc3fW1nxipIeH1A==
X-Google-Smtp-Source: ABdhPJzz8Jon5yKRGqvms3lrtF2W7TCzv4+iL+ICaMgjz8Dd5EA4Zg3K+dINCyAeL2BBg2cF6G5VlQ==
X-Received: by 2002:adf:ef84:: with SMTP id d4mr7069949wro.175.1638370779228;
        Wed, 01 Dec 2021 06:59:39 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id a9sm46541wrt.66.2021.12.01.06.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 06:59:38 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 bpf-next] selftests/bpf: Build testing_helpers.o out of tree
Date:   Wed,  1 Dec 2021 14:51:02 +0000
Message-Id: <20211201145101.823159-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add $(OUTPUT) prefix to testing_helpers.o, so it can be built out of
tree when necessary. At the moment, in addition to being built in-tree
even when out-of-tree is required, testing_helpers.o is not built with
the right recipe when cross-building.

For consistency the other helpers, cgroup_helpers and trace_helpers, can
also be passed as objects instead of source. Use *_HELPERS variable to
keep the Makefile readable.

Fixes: f87c1930ac29 ("selftests/bpf: Merge test_stub.c into testing_helpers.c")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2: Homogenize cgroup_helpers and trace_helpers.
v1: https://lore.kernel.org/bpf/20211129111508.404367-1-jean-philippe@linaro.org/
---
 tools/testing/selftests/bpf/Makefile | 40 +++++++++++++++-------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a6c0e92c86a1..75799506a5d8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -192,22 +192,26 @@ TEST_GEN_PROGS_EXTENDED += $(DEFAULT_BPFTOOL)
 
 $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
 
-$(OUTPUT)/test_dev_cgroup: cgroup_helpers.c testing_helpers.o
-$(OUTPUT)/test_skb_cgroup_id_user: cgroup_helpers.c testing_helpers.o
-$(OUTPUT)/test_sock: cgroup_helpers.c testing_helpers.o
-$(OUTPUT)/test_sock_addr: cgroup_helpers.c testing_helpers.o
-$(OUTPUT)/test_sockmap: cgroup_helpers.c testing_helpers.o
-$(OUTPUT)/test_tcpnotify_user: cgroup_helpers.c trace_helpers.c testing_helpers.o
-$(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c testing_helpers.o
-$(OUTPUT)/test_cgroup_storage: cgroup_helpers.c testing_helpers.o
-$(OUTPUT)/test_sock_fields: cgroup_helpers.c testing_helpers.o
-$(OUTPUT)/test_sysctl: cgroup_helpers.c testing_helpers.o
-$(OUTPUT)/test_tag: testing_helpers.o
-$(OUTPUT)/test_lirc_mode2_user: testing_helpers.o
-$(OUTPUT)/xdping: testing_helpers.o
-$(OUTPUT)/flow_dissector_load: testing_helpers.o
-$(OUTPUT)/test_maps: testing_helpers.o
-$(OUTPUT)/test_verifier: testing_helpers.o
+CGROUP_HELPERS	:= $(OUTPUT)/cgroup_helpers.o
+TESTING_HELPERS	:= $(OUTPUT)/testing_helpers.o
+TRACE_HELPERS	:= $(OUTPUT)/trace_helpers.o
+
+$(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
+$(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
+$(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
+$(OUTPUT)/test_sock_addr: $(CGROUP_HELPERS) $(TESTING_HELPERS)
+$(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
+$(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
+$(OUTPUT)/get_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
+$(OUTPUT)/test_cgroup_storage: $(CGROUP_HELPERS) $(TESTING_HELPERS)
+$(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
+$(OUTPUT)/test_sysctl: $(CGROUP_HELPERS) $(TESTING_HELPERS)
+$(OUTPUT)/test_tag: $(TESTING_HELPERS)
+$(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
+$(OUTPUT)/xdping: $(TESTING_HELPERS)
+$(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
+$(OUTPUT)/test_maps: $(TESTING_HELPERS)
+$(OUTPUT)/test_verifier: $(TESTING_HELPERS)
 
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
@@ -535,8 +539,8 @@ $(OUTPUT)/bench_bpf_loop.o: $(OUTPUT)/bpf_loop_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
-		 $(OUTPUT)/testing_helpers.o \
-		 $(OUTPUT)/trace_helpers.o \
+		 $(TESTING_HELPERS) \
+		 $(TRACE_HELPERS) \
 		 $(OUTPUT)/bench_count.o \
 		 $(OUTPUT)/bench_rename.o \
 		 $(OUTPUT)/bench_trigger.o \
-- 
2.34.0

