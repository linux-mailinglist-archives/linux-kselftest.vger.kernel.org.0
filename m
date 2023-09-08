Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EB5799220
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 00:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbjIHWWu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 18:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245667AbjIHWWt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 18:22:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9D41FE9
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Sep 2023 15:22:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c8f360a07a2so2638661276.2
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Sep 2023 15:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694211764; x=1694816564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9irfI9A0N/Dt7kJJSjpCAtQ4KpuXf47ryLkMZkjJxb8=;
        b=iAs4beuKZ2q3E6N3f1tNzGqeZjG/EcTLbWmMDX06pL+TW1odRjPXd8WDXIJIxBLe4n
         WJbDRVlkQtqlePwdbUQXlbNPcfdhVOCrCKOzNsDIJBr4Hk/nK/E/mFxocNbByOC7+4od
         63yL0yKZaNtCDkfAMHOyBeFGVzbdSeL3lrYmKoLhRMMxw5YntKN9WDwHCSYPiJIK6dQK
         fuk4sU/+vViQBJ1aciPEMbMLjJPCPPBzMk6XqdypKh9EgG13rgHLQsBmow/H+wO/swjs
         E2nNohyuDAj+hAEayRxj8MuIZwq5wFaHZooQSQozQmp1NcUb5VsnPzSiQc12bPe1RlLR
         xUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694211764; x=1694816564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9irfI9A0N/Dt7kJJSjpCAtQ4KpuXf47ryLkMZkjJxb8=;
        b=Q1Uyjq9Mh/s4Ws2J+T09//AxsYkuv+MlcOlhzhr8dnihGMCYtPkRZGhUXQeZpeDEQh
         VtK1n25trx/B7tHZkVU7AaxJLApk4HBVh73bAHYdvNKEMXxBhMi9fr/7GZEAoHP+2J4k
         C2rVDuY3MQQKhpXFzqBF6g4npjgINJv2LQI9t3vug4h5vwfW0ySyQQeHiKEfZnNfOz7O
         rdOXOPQMV1IyGzlKAHegpMlJnpg7plklC7fFtLZtQCqnd782PzuHcIuyxtmd8v6tMEHJ
         0sVN/DBniCYuAETANQJiLZ0GAg/tZHmueJMpAACPC+GbUsAuqenEZZjo+/GZh3sTCo0C
         OvWg==
X-Gm-Message-State: AOJu0Yxcofi29PV945trUKLEtcRlbFU2AicoKJGkSylvuJPxQ1i3WV3J
        Z3iT9TDAFpcDBsORGgh/82bw8dWPyFZUXEnSCA==
X-Google-Smtp-Source: AGHT+IFtq0snbvMXeqBS8VLVImcr9xrcVjtDXsq4clwId3rPRzXuop4Ehcv6ufF/SxSOtY+mWo9nUsHBtDPCLpEyHg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:cb4d:0:b0:d13:856b:c10a with SMTP
 id b74-20020a25cb4d000000b00d13856bc10amr82340ybg.3.1694211763898; Fri, 08
 Sep 2023 15:22:43 -0700 (PDT)
Date:   Fri, 08 Sep 2023 22:22:39 +0000
In-Reply-To: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
Mime-Version: 1.0
References: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694211760; l=1956;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=6t8U2ctGsOCguE1q+j7opibZJXo2rKtjXxRgmhSJEx0=; b=6HwCgpBH7Dms8xi43xj5xBqDMogSIehMI+w9LKuw68MhZgBZRYqaREBJnnDKMwyX+B7vVbEy+
 acvBW/er81XDbEJIFYnTeXWIVtHVBw/Lc8w2xXSbOZP1FOMD9jveHZq
X-Mailer: b4 0.12.3
Message-ID: <20230908-kselftest-09-08-v2-2-0def978a4c1b@google.com>
Subject: [PATCH v2 2/3] selftests/hid: do not manually call headers_install
From:   Justin Stitt <justinstitt@google.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Benjamin Tissoires <bentiss@kernel.org>

"make headers" is a requirement before calling make on the selftests
dir, so we should not have to manually install those headers

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/Makefile | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 01c0491d64da..c5522088ece4 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -21,7 +21,7 @@ CXX ?= $(CROSS_COMPILE)g++
 
 HOSTPKG_CONFIG := pkg-config
 
-CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(KHDR_INCLUDES) -I$(OUTPUT)
+CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
 LDLIBS += -lelf -lz -lrt -lpthread
 
 # Silence some warnings when compiled with clang
@@ -65,7 +65,6 @@ BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
 SCRATCH_DIR := $(OUTPUT)/tools
 BUILD_DIR := $(SCRATCH_DIR)/build
 INCLUDE_DIR := $(SCRATCH_DIR)/include
-KHDR_INCLUDES := $(SCRATCH_DIR)/uapi/include
 BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
 ifneq ($(CROSS_COMPILE),)
 HOST_BUILD_DIR		:= $(BUILD_DIR)/host
@@ -151,9 +150,6 @@ else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
-$(KHDR_INCLUDES)/linux/hid.h: $(top_srcdir)/include/uapi/linux/hid.h
-	$(MAKE) -C $(top_srcdir) INSTALL_HDR_PATH=$(SCRATCH_DIR)/uapi headers_install
-
 $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 		       $(TOOLSDIR)/bpf/resolve_btfids/main.c	\
 		       $(TOOLSDIR)/lib/rbtree.c			\
@@ -231,7 +227,7 @@ $(BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(OUTPUT)
 	$(Q)$(BPFTOOL) gen object $(<:.o=.linked1.o) $<
 	$(Q)$(BPFTOOL) gen skeleton $(<:.o=.linked1.o) name $(notdir $(<:.bpf.o=)) > $@
 
-$(OUTPUT)/%.o: %.c $(BPF_SKELS) $(KHDR_INCLUDES)/linux/hid.h
+$(OUTPUT)/%.o: %.c $(BPF_SKELS)
 	$(call msg,CC,,$@)
 	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
 

-- 
2.42.0.283.g2d96d420d3-goog

