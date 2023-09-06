Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8DF794312
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 20:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242007AbjIFSdz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 14:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjIFSdv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 14:33:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945851738;
        Wed,  6 Sep 2023 11:33:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-402cc6b8bedso1984295e9.1;
        Wed, 06 Sep 2023 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694025207; x=1694630007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDHabXQ3v0V6rVN5TewLut1ATi0BNX0QhXwmwgrIhV4=;
        b=Y1f8RY8kFgNQWx6xYtjRwTyP+AbvdqOxK/KMhPDk3RIdLqxlrrg+09VXuXuyw3F7L8
         EqGQNZLcRdJR2z7mvI6R42GW/qDYIa/jY/Qv1AbLMxfgvAVYe7KhlRFQa45P/ZwYzuDW
         qG7IgjacfktU9Wr5D1kkGABciPQvUM5eVHVLmSHt55NPkxrHbRAWQB4a7/q7PvQHWOoa
         wFn8u+oohlV1vUBGkvXmfZnOh9E9u8Tkl/Uk8Q9bMpzs63DaWeiJTQlqUhElv2VY2i4p
         ZxxMCIlyDX8KOJn+hkdaAiUT63Lblx1GBpjOdnTLRNrrjt1cVd9l3hxiB+yR5xJ5NoSE
         +QKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694025207; x=1694630007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDHabXQ3v0V6rVN5TewLut1ATi0BNX0QhXwmwgrIhV4=;
        b=lK9GEynF9/TpfqVDJGrgOct26x+/qdasvsLpDkrXqs69syNHmXfTH2DpFRnhlhwKkD
         jCV96bPB2XUIRwm00RVE5qF5rDi+Djk0NCgTjl3JklBrWXIZEeCZyU66xYUCScXnkGgA
         venA+ta1RvOkrwxXU1Fe6Ba2upIAGIbhy6cXFrDSxgfJH55I0b08XhX401H0Pl1SOmsL
         2EcyqtwgQ/R8b+RhobcyrQBnNw23KN5fkPI3xm57PTH1ijkq1f6dU8yCUdK8Hyz34ves
         +bSTgUxy3Qlz/1Gm9VD791t5CszllmAh250Yf4C9NMNoS+kRWt1SEGeBZv0iqMqNjN4S
         +daw==
X-Gm-Message-State: AOJu0YxwnFRoCvggCl/JKLSKfHQrIgtF1xtThxGyuHC0KgAimZye3w36
        3YQgQKO8Xtn5BFc58y9kj7I=
X-Google-Smtp-Source: AGHT+IF6zrzuB7dNZDvwoFD7KuzrYKg3eZVeC4tkmJLvhV11HRZ0cFMPbVge1Wr5VIdOESNSbBmymA==
X-Received: by 2002:a05:600c:2285:b0:401:5443:5598 with SMTP id 5-20020a05600c228500b0040154435598mr2887693wmf.25.1694025207327;
        Wed, 06 Sep 2023 11:33:27 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d4bca000000b003180155493esm21094891wrt.67.2023.09.06.11.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:33:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 7/8] selftest, bpf: enable cpu v4 tests for arm32
Date:   Wed,  6 Sep 2023 18:33:19 +0000
Message-Id: <20230906183320.1959008-8-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230906183320.1959008-1-puranjay12@gmail.com>
References: <20230906183320.1959008-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

