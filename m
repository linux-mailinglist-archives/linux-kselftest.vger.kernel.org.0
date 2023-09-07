Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E01797F00
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 01:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbjIGXGT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 19:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbjIGXGH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 19:06:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D232C1BD7;
        Thu,  7 Sep 2023 16:06:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso16246365e9.0;
        Thu, 07 Sep 2023 16:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694127960; x=1694732760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDHabXQ3v0V6rVN5TewLut1ATi0BNX0QhXwmwgrIhV4=;
        b=jz4yCofb1X8TBpYGMxSSD88nS01Pirv+Gvu+nl7NaPNUfQjQ0FxnQw1e2pgPduRiiY
         dxFkMXXaYhbaBT6ihaJX/4eSsvfUP9IljiVBW3Q8GyuGZ9F8IdnIN3RBk3UCsinFIgSY
         rDEpjnMdOr7YaEOi2yNrxFXKzRZghK25EjF/YprgCx2E0K99agp0coXQZA4Sb2rfMjta
         ZVyd/LrZXJE4BT4TkiRum0O3J4IFai1ZSvuDaFyKSvdsbJHoJN/Fq66Ye0DKwLAWiOyF
         2ysNXLQrcZ0k28JjAFq5HlL2kQVSTACVlupqlErvR9DB4Zkx3F4kj6uEPIZ4FwhKVlLN
         hxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694127960; x=1694732760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDHabXQ3v0V6rVN5TewLut1ATi0BNX0QhXwmwgrIhV4=;
        b=WqSWonyMCC4//vDVCtcalsBrsFJPG9oD3XpxQ4emz00SDB6B2DmJppyy/cZFPUmMmK
         Z05xt7mfQ/3QiBzjoSoFZHe0uUuuGc45ZA4kV4SKWoP26LUwiv1tuIcUu8ngw9ZKS1U3
         sBVWxjRXB/ZhtZ/YKIEM+YldyZJtaASVnRRGOfZqv2BGL8qBxMJNLhAPiQrmKsTWdt6A
         LyLfX3oyvc0Np65q/mXEs7D3/3rNbHDUVeX/GFonU7hjGxGvwVX5UyPOWTxe+XkX9Et9
         Cso7lmU1z9iJcYAB1oI4u01qf7qhIP1Jf/0A9x/WpMx87OCSNiNkycoE5sdQsKSl14Vk
         ygYg==
X-Gm-Message-State: AOJu0YzdLIZuWfh6IQrZ3RhlQZsyCVvwAkebIWT01/SIdSh8cYnOS9TK
        Bit96QK5eUsFuYZDM+t7Z+c=
X-Google-Smtp-Source: AGHT+IEmcguzVBEHfttctnJtLySpXnF4gFIkspE8p80QSVVNZnxtnM0EMW80+VyiApNxEnhZNdT1wg==
X-Received: by 2002:a5d:4702:0:b0:31a:d9bc:47a2 with SMTP id y2-20020a5d4702000000b0031ad9bc47a2mr479062wrq.53.1694127959738;
        Thu, 07 Sep 2023 16:05:59 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-3-249-32-32.eu-west-1.compute.amazonaws.com. [3.249.32.32])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d484d000000b0031f3b04e7cdsm491358wrs.109.2023.09.07.16.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 16:05:59 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     puranjay12@gmail.com
Subject: [PATCH bpf-next v3 7/9] selftest, bpf: enable cpu v4 tests for arm32
Date:   Thu,  7 Sep 2023 23:05:48 +0000
Message-Id: <20230907230550.1417590-8-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230907230550.1417590-1-puranjay12@gmail.com>
References: <20230907230550.1417590-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that all the cpuv4 instructions are supported by the arm32 JIT,
enable the selftests for arm32.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_bswap.c | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_gotol.c | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_movsx.c | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_sdiv.c  | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bswap.c b/tools/testing/selftests/bpf/progs/verifier_bswap.c
index 8893094725f0..5d54f8eae6a1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bswap.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bswap.c
@@ -5,7 +5,8 @@
 #include "bpf_misc.h"
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || defined(__TARGET_ARCH_arm)) && \
+	__clang_major__ >= 18
 
 SEC("socket")
 __description("BSWAP, 16")
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotol.c b/tools/testing/selftests/bpf/progs/verifier_gotol.c
index 2dae5322a18e..aa54ecd5829e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotol.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
@@ -5,7 +5,8 @@
 #include "bpf_misc.h"
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || defined(__TARGET_ARCH_arm)) && \
+	__clang_major__ >= 18
 
 SEC("socket")
 __description("gotol, small_imm")
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 0c638f45aaf1..1e1bc379c44f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -5,7 +5,8 @@
 #include "bpf_misc.h"
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || defined(__TARGET_ARCH_arm)) && \
+	__clang_major__ >= 18
 
 SEC("socket")
 __description("LDSX, S8")
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 3c8ac2c57b1b..ca11fd5dafd1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -5,7 +5,8 @@
 #include "bpf_misc.h"
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || defined(__TARGET_ARCH_arm)) && \
+	__clang_major__ >= 18
 
 SEC("socket")
 __description("MOV32SX, S8")
diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
index 0990f8825675..fb039722b639 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -5,7 +5,8 @@
 #include "bpf_misc.h"
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || defined(__TARGET_ARCH_arm)) && \
+	__clang_major__ >= 18
 
 SEC("socket")
 __description("SDIV32, non-zero imm divisor, check 1")
-- 
2.39.2

