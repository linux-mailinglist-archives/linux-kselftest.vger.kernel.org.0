Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD4E63C15A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 14:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiK2NnL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 08:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbiK2Nmx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 08:42:53 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C80B867;
        Tue, 29 Nov 2022 05:42:50 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id io19so13424034plb.8;
        Tue, 29 Nov 2022 05:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k5rf78k7+OEY6nBWA1O7f1OJqZ5j+/qpJl/iZqmpyo=;
        b=XfzWpsAwrdakVJ6T4hn6JM2PHV+n+hvfFFzsYM/gPTZps22qaFyz6bxZ61VE1jFaXK
         eKCTmWssI6VPH7OsgeM48JOdxXPTKbNb6LQfpJmzwcyHu/bdMIeuJUqAXyB7G0FCRE14
         swdSU5eS9QCuFj3Zg+TIiJkCZuS32UuLxK+hQBPzV5uRDmzm4MaVygkKZFqMVYSbuhDZ
         +iE/NIkbCct3kp2Th0CNdV2X4h6DIFpQFqk3mzGiJKrXktqPm6kusYG08sjOZKK1GQRM
         NbnQLuJvkTRut+1y8lmS4+EZP1tOLmfIfVivsFTtTFcJI7dYtW29TJFCQs5yB3et+ySt
         mE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0k5rf78k7+OEY6nBWA1O7f1OJqZ5j+/qpJl/iZqmpyo=;
        b=arNfjwsYkYTSZNJuYtM0qh0bGtTLtx/I0XzAk6KsghBR87IwkLDACitid+6Q2WAn9E
         1s5ShgmGo+3Z/Kv0zyCoMvGGvhbi7uazJulDsK1s+dqZze7qve8VNVjTPr5kebnyj+TL
         iQs72icgQi7aS06th7QsCx3bCGyy4qE6y3PTij6XGAPKH0uezPu1rin+HfXYizRr6fQ9
         lZZf4HOVIeOLemD/2QipQ62cXKM7TZXcnTSf+Ikvyqkr2Akc5LCCIWE08HvTWSmtM0Hp
         0Qj5afjcQRsTx8Xo8/iyA1d7s5a7xWB6jUe2/7zYnwezqZTCsJJR0OKhvpkAha8uS8xP
         MulA==
X-Gm-Message-State: ANoB5pk+4y06/YfF1rAxxP/EWRmrDhfIjueaHczsIuzWkCjuU00b9p1p
        o/lQtI79pHH8wFuhtTc/HSA=
X-Google-Smtp-Source: AA0mqf78QcbeQGRnxYQ8sKZN1u5YNPGSAvMc67kXLYU9TmX7jlvk0LQf9CJrZ8HUNsMkPGLQL9+KGQ==
X-Received: by 2002:a17:90a:1a07:b0:212:fbab:446b with SMTP id 7-20020a17090a1a0700b00212fbab446bmr61121117pjk.146.1669729370013;
        Tue, 29 Nov 2022 05:42:50 -0800 (PST)
Received: from WRT-WX9.. ([103.135.102.183])
        by smtp.gmail.com with ESMTPSA id z5-20020aa79f85000000b005636326fdbfsm9977154pfr.78.2022.11.29.05.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 05:42:49 -0800 (PST)
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
Subject: [PATCH v2 2/2] bpf: makefiles: do not generate empty vmlinux.h
Date:   Tue, 29 Nov 2022 21:42:17 +0800
Message-Id: <20221129134217.52767-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129134217.52767-1-changbin.du@gmail.com>
References: <20221129134217.52767-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove the empty vmlinux.h if bpftool failed to dump btf info.
The emptry vmlinux.h can hide real error when reading output
of make.

This is done by adding .DELETE_ON_ERROR special target in related
makefiles.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/bpf/bpftool/Makefile           | 3 +++
 tools/perf/Makefile.perf             | 2 ++
 tools/testing/selftests/bpf/Makefile | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 4a95c017ad4c..f6b1e65085db 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -265,3 +265,6 @@ FORCE:
 .PHONY: all FORCE bootstrap clean install-bin install uninstall
 .PHONY: doc doc-clean doc-install doc-uninstall
 .DEFAULT_GOAL := all
+
+# Delete partially updated (corrupted) files on error
+.DELETE_ON_ERROR:
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a432e59afc42..265254fc641a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1149,3 +1149,5 @@ FORCE:
 .PHONY: libtraceevent_plugins archheaders
 
 endif # force_fixdep
+
+.DELETE_ON_ERROR:
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e6cf21fad69f..f41c4b011221 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -617,3 +617,6 @@ EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 			       liburandom_read.so)
 
 .PHONY: docs docs-clean
+
+# Delete partially updated (corrupted) files on error
+.DELETE_ON_ERROR:
-- 
2.37.2

