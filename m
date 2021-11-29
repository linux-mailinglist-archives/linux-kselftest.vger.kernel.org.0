Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA9C461525
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Nov 2021 13:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbhK2Mfl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Nov 2021 07:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbhK2Mdl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Nov 2021 07:33:41 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E399BC0619DD
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Nov 2021 03:17:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l16so35926774wrp.11
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Nov 2021 03:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rMp9H8jRFfH7llkB2xQVwKBEFjMHtmUdm+dWrw4nySU=;
        b=K0z8uEjoQRnumItTYpzbCf/F4g6/WoBOfEAP7nXpsPYHT7L6o6XxRdwW3Z6LjloS+O
         WPhlbW2dQAy1mXGwlb6SnfjoxvHXz1zVqUFPkg7zKkOhG2SOjqld7xvQsQ5mUmIHbE4S
         gV7AmNXFlH5mlv492RC75g+m5E1Zp2YHW2KBp/WZ8lutVmyP5KF9gji5wiuLs0qyEVSc
         u/u2iDKisfWIq5LnkPWLWtC/c9+Hq2SSzdicSoMqp/41rmoWdomXRYJNYm9g8YH/pNTw
         lqkg5XsQB4WB0kjOcUqEL7B4XCf1NRVadri3NjhMpqWPJVFPTleYHyUO1FRhNd2/JEYN
         xkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rMp9H8jRFfH7llkB2xQVwKBEFjMHtmUdm+dWrw4nySU=;
        b=cXAy+PI0q6Li8Y7OkBszHq599f2fQFqzX3b7dtAsgxqBgiK9ifHE/HuV/WzdDI/JJp
         mZmVldrtAXp27DrZvnt2zDtsM92NE+cS013axBJT8dewkONcONAiS1lMW9EdYaLemcoD
         yIYgUsXwEut8M5cRGRtBE7JH2P6XN9Khm4Ax5xC5W2zSL00LW26/jOVHOeSLniycJIXW
         OKoeLygv7GxJuF4CsTeCQUWUpDuNYpW+yxwauCiB/yTPKaEUarpk0rhWznS/SH2k+t2l
         6fLF0NxT92AmRCDUUgnjdpC0aDZbkyshTQBplsAITlWKB5b7mlATI5D2tk+jNsmrNwnZ
         KEFQ==
X-Gm-Message-State: AOAM5329bDLfvv//eHUunS8R+hcih7Z42aSxyFWXRP86eE+fYQ2DKvDI
        WL3XT/6iZFai5mWelDjUUkOdkw==
X-Google-Smtp-Source: ABdhPJyNPhBxP9qKjIS1TTNVSBvBZw8o1KBSGHV+QiiUPUkZLPIY17BtUbGVHBZm0XnXtJN1Q+7sBQ==
X-Received: by 2002:adf:dbd2:: with SMTP id e18mr32554783wrj.478.1638184636436;
        Mon, 29 Nov 2021 03:17:16 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id b197sm14292269wmb.24.2021.11.29.03.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 03:17:16 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next] selftests/bpf: Build testing_helpers.o out of tree
Date:   Mon, 29 Nov 2021 11:15:10 +0000
Message-Id: <20211129111508.404367-1-jean-philippe@linaro.org>
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

Fixes: f87c1930ac29 ("selftests/bpf: Merge test_stub.c into testing_helpers.c")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 32 ++++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 35684d61aaeb..082f6aeec1d9 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -192,22 +192,22 @@ TEST_GEN_PROGS_EXTENDED += $(DEFAULT_BPFTOOL)
 
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
+$(OUTPUT)/test_dev_cgroup: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
+$(OUTPUT)/test_skb_cgroup_id_user: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
+$(OUTPUT)/test_sock: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
+$(OUTPUT)/test_sock_addr: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
+$(OUTPUT)/test_sockmap: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
+$(OUTPUT)/test_tcpnotify_user: cgroup_helpers.c trace_helpers.c $(OUTPUT)/testing_helpers.o
+$(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
+$(OUTPUT)/test_cgroup_storage: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
+$(OUTPUT)/test_sock_fields: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
+$(OUTPUT)/test_sysctl: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
+$(OUTPUT)/test_tag: $(OUTPUT)/testing_helpers.o
+$(OUTPUT)/test_lirc_mode2_user: $(OUTPUT)/testing_helpers.o
+$(OUTPUT)/xdping: $(OUTPUT)/testing_helpers.o
+$(OUTPUT)/flow_dissector_load: $(OUTPUT)/testing_helpers.o
+$(OUTPUT)/test_maps: $(OUTPUT)/testing_helpers.o
+$(OUTPUT)/test_verifier: $(OUTPUT)/testing_helpers.o
 
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
-- 
2.34.0

