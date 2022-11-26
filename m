Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50396395A4
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Nov 2022 12:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKZLOG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Nov 2022 06:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKZLNr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Nov 2022 06:13:47 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029291B1DA;
        Sat, 26 Nov 2022 03:13:46 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id mv18so5591802pjb.0;
        Sat, 26 Nov 2022 03:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wXxHwlliB9k9y/zRVSVfdaJjEK9h41TVLmU74Ql4mM=;
        b=Az5eaU6yt/A/9EC16A5mgH5D+UhNxILaYesE0vaILZ41HUY0H0EcrKI190CwWnHlva
         EXRB9mqds4P/vTNnGQg7YIWQHGxxy4rLja4l7HFjLh+xPTQmDug3UqLnYCBSwRb4OnFR
         td+HpnkaCwdIwsKLWuIDT/+/983Dja5Dnkjcwn7l69ufK4v3lQ9eRyxXcBvE+vG0o2ZU
         B7pUk+wC4UHYJrw71hTnsZKRWdr/UfG0sCH8mKtMm9i41WM05y5xUGmMbxlMFniZrXQn
         82gU94ss0lWMN2ElU1tahDVhU4fILxrUBPUEiuptI3nsv+xUeD4LabOjkE9mzsmXxY+4
         CnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wXxHwlliB9k9y/zRVSVfdaJjEK9h41TVLmU74Ql4mM=;
        b=ETisHak7yZaVwnFqdzUePVIlflzx4x7UMke0HbXSVogI1L2KtdZQT6FHME3FHS4uRo
         3TZreymeCJ4zmjd+GOGfCcdFWuGLP600fvY0enFlzmOcB7vJu4KNExUu5rxXzj7E/uWv
         mXgqQNhp9amsbcMBf0OmqO2p+4Sr49BKZavHiuXFCv99oTOSVFOHDBx5bvqnFj4u3Z58
         43rV4l+gCYL9me8LUr+OJrNN1ZJaIsgHqh28LH21AGGs5c8WLuILS1qGHbN5QFFmVv+J
         rl8PDf1AuNOpADIdpHt2YL01Mn8wTi5seiuNxKMhhx/dN7Of9m3MMwDaziG9FRoyonhl
         JJUg==
X-Gm-Message-State: ANoB5pm2juBX3egqsvGAvH4o1lKdCEXE9vcfCD/vQTirfPEMKs4C6OWa
        ropDKkJh8Z2x+sUfLGxjDTo=
X-Google-Smtp-Source: AA0mqf4bjAQLyAOUkGVkFZ7QeA5U2FbfawVL8N5Pl0UJnzhCMcX/K+w/Q3lJasx/E4aU1n8l6Pjukg==
X-Received: by 2002:a17:902:e807:b0:186:fb90:5774 with SMTP id u7-20020a170902e80700b00186fb905774mr23432978plg.137.1669461225418;
        Sat, 26 Nov 2022 03:13:45 -0800 (PST)
Received: from WRT-WX9.. ([103.135.102.183])
        by smtp.gmail.com with ESMTPSA id c194-20020a621ccb000000b0056a93838606sm4555639pfc.58.2022.11.26.03.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 03:13:44 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 2/2] makefiles: do not generate empty vmlinux.h
Date:   Sat, 26 Nov 2022 19:11:47 +0800
Message-Id: <20221126111147.199366-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221126111147.199366-1-changbin.du@gmail.com>
References: <20221126111147.199366-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove the empty vmlinux.h if bpftool failed to dump btf info.
The emptry vmlinux.h can hide real error when reading output
of make.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 samples/bpf/Makefile                 | 2 +-
 tools/bpf/bpftool/Makefile           | 2 +-
 tools/bpf/runqslower/Makefile        | 2 +-
 tools/perf/Makefile.perf             | 2 +-
 tools/testing/selftests/bpf/Makefile | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 727da3c5879b..ab4788b4883e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -362,7 +362,7 @@ ifeq ($(VMLINUX_BTF),)
 	$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)",\
 		build the kernel or set VMLINUX_BTF or VMLINUX_H variable)
 endif
-	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@ || { rm $@; exit 1; }
 else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 4a95c017ad4c..d9d6f890884c 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -177,7 +177,7 @@ BUILD_BPF_SKELS := 1
 
 $(OUTPUT)vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL_BOOTSTRAP)
 ifeq ($(VMLINUX_H),)
-	$(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) btf dump file $< format c > $@
+	$(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) btf dump file $< format c > $@ || { rm $@; exit 1; }
 else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index 8b3d87b82b7a..2d7911f4666b 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -77,7 +77,7 @@ ifeq ($(VMLINUX_H),)
 			"specify its location." >&2;			       \
 		exit 1;\
 	fi
-	$(QUIET_GEN)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
+	$(QUIET_GEN)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@ || { rm $@; exit 1; }
 else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a432e59afc42..0546d408aa4e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1064,7 +1064,7 @@ VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
 
 $(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
 ifeq ($(VMLINUX_H),)
-	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
+	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@ || { rm $@; exit 1; }
 else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e6cf21fad69f..9aa2475b4ac6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -284,7 +284,7 @@ endif
 $(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
 ifeq ($(VMLINUX_H),)
 	$(call msg,GEN,,$@)
-	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@ || { rm $@; exit 1; }
 else
 	$(call msg,CP,,$@)
 	$(Q)cp "$(VMLINUX_H)" $@
-- 
2.37.2

