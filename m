Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE67364FC9E
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Dec 2022 23:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiLQWg0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Dec 2022 17:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiLQWgV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Dec 2022 17:36:21 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AA7DF9B;
        Sat, 17 Dec 2022 14:36:18 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so9512089pjr.3;
        Sat, 17 Dec 2022 14:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/x+afgh1ISBbPnqbY131/KLKQLBCqSdbqqjGYkdUb0=;
        b=IW1S7JyfXFSmWvxk6gMhZug6pfeHdNdgY37zEjjD/JmrXVaXgi/KXE1+TN3SKiHx1F
         O4TszTlAt5kynelThdmi2Wjec9cipMeCcKI4Gii8kJbsIAtzaOpZ+N06xoKZ3UKoE1+n
         APXw7UtHDHpyYqdvfSGFKzaRadZ0MxG2+9FoMrdzETpVf8sd+i+HAjT36llOcvvBgP0f
         mVK3dLD9POmL8TXVpe+wlLLIWYEYMajUXK4rZ9Gtbd8tL5umXAgCpaBmcFx8mOTNG4Oa
         hwTjQANXReCYaMC3qfaw/T15+PouA1L/aZMhiptHxkxHN1QZFKvJjyl5zYtQkR/pgrJG
         rPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/x+afgh1ISBbPnqbY131/KLKQLBCqSdbqqjGYkdUb0=;
        b=vP7jPszf8qtGZl7t5dVtbDrYXyXi8VIGcF27EcmsLInanb+xerOj4JXmgX96NqKydI
         je9BWFW+00pwAH7BkxK79mm9S3XldcLWVVIzbXrL5brkIqJsVrlT4jYHJgogW9cbkaPu
         yrUQAGVoPr/ZU2kMn1EigJYgVFVcbGhxVts+nlOzYQpu/zswVlbWmXEOSZJSS+SzVhZG
         JpHAlQq3aOKAA1vRbtmmRhkZpnPv9eOwHEwahjBOeg0IBMgvmmpePQhreF1+AB5qJAUm
         qPquBF/+TAI1HCMEt6u1DxQBQVSGPoArhF8oaUVl/C803ZdE2wA9qPpbvliDedp7rDRv
         B3sg==
X-Gm-Message-State: AFqh2kpBxk9/Dcpc9CCeUqy+4xgHvAsFD1YHmNKL+vmSAZZkVfRDgWuc
        2axeyVHcDpZb7trWSM3yBqY=
X-Google-Smtp-Source: AMrXdXvyldrQM+icuuDpeqSxgOlxhnJZ7fov1jplJPtL8crIBtJ4q/X95pvJfq/n7f7FSa3ZuchL4g==
X-Received: by 2002:a17:902:e212:b0:189:30cd:8fa2 with SMTP id u18-20020a170902e21200b0018930cd8fa2mr3027852plb.50.1671316578407;
        Sat, 17 Dec 2022 14:36:18 -0800 (PST)
Received: from WRT-WX9.. ([103.135.102.144])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001801aec1f6bsm4031660ple.141.2022.12.17.14.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 14:36:17 -0800 (PST)
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
Subject: [PATCH v3 2/2] bpf: makefiles: do not generate empty vmlinux.h
Date:   Sun, 18 Dec 2022 06:35:09 +0800
Message-Id: <20221217223509.88254-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221217223509.88254-1-changbin.du@gmail.com>
References: <20221217223509.88254-1-changbin.du@gmail.com>
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
The empty vmlinux.h can hide real error when reading output
of make.

This is done by adding .DELETE_ON_ERROR special target in related
makefiles.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/bpf/bpftool/Makefile           | 3 +++
 tools/testing/selftests/bpf/Makefile | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 787b857d3fb5..313fd1b09189 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -289,3 +289,6 @@ FORCE:
 .PHONY: all FORCE bootstrap clean install-bin install uninstall
 .PHONY: doc doc-clean doc-install doc-uninstall
 .DEFAULT_GOAL := all
+
+# Delete partially updated (corrupted) files on error
+.DELETE_ON_ERROR:
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c22c43bbee19..205e8c3c346a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -626,3 +626,6 @@ EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 			       liburandom_read.so)
 
 .PHONY: docs docs-clean
+
+# Delete partially updated (corrupted) files on error
+.DELETE_ON_ERROR:
-- 
2.37.2

