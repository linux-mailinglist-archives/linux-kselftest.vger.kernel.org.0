Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203117930A6
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 23:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjIEVGh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 17:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241685AbjIEVGe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 17:06:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF7DDB;
        Tue,  5 Sep 2023 14:06:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31f2f43d5a0so2624087f8f.1;
        Tue, 05 Sep 2023 14:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693947989; x=1694552789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N562DkaeqjclPfcG3Qn5YTlQ8C7g+UGVy6pjf4xq4LQ=;
        b=sd4RTJqet/38R74ln45jBfERk9HW84C3jAtLQGj78D9/PJLbqsTWBshBz8qsAqQ18c
         IkA1wNo+fdLNJn/Yk0ZYd5aaKKHpJDPAA08EZ8DuNPzdluV9s3Som8eQSYzC1eJD58+y
         mL7G9wRb3AIe2rjQr3ESTNfqwrnCszKc0gFASNuvS4vDZWvaGYOoa4PcOTnQl2Zi+vl1
         P+fDjxQis6udq2G7iInb94fonQCd7PZihD8nU3gfPfT/0jSVRzy3e+7ZJzXeDkZYAO58
         KvfeuFEiNydtcuR6nHeWGwErrRyrN8l1V8gQHaGB2Fw6R2GVTRd//is8CN2tGYAL70hG
         K+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693947989; x=1694552789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N562DkaeqjclPfcG3Qn5YTlQ8C7g+UGVy6pjf4xq4LQ=;
        b=JqIoBeni13d5qa9rd5pcMVqFr76w6jbjAxobaYxe1pfsfZxdYwgyJq1ljvLqtxXAyR
         t4oIUgXXTFrkT8qzcqP6+A4ipxJ9YsE0ABSdv1IVoopYSTZkuggMdxcdO6siFVL9woHf
         FiN0OR3HKDs1c8OQa+z08ryWcIAEOJwupY28uSw5MuBjsWCvfutb+qADUQopTND0XGni
         AKVm8kw219Ck26zDA20xMCE5LJ66Spgchbe5AJCEi5HaAamJ2vmsE+NBMOad2jQ4jmks
         oaRL5V5vgvMzxxL78bqw8/iLyHEPyhyQkoB+x5Ag1kxEy5RnSu0pGgySPIEEB7HJi9fx
         MbXg==
X-Gm-Message-State: AOJu0Yw967x/ml9tgdE9Csd6xsohhhbyWkIViGsQlQjZtPdZrK3Eazmo
        UDQ0UdtZPD17RPUIe5N43emHxJTlwb2TKviPzq8=
X-Google-Smtp-Source: AGHT+IHz9ST2fK4aD1U4cyq70NUNCG9f+4a5YN0dUwzIcIsRpdpDgknMUXxkjzHsx3lvAUPmVVrB8Q==
X-Received: by 2002:adf:edc6:0:b0:317:6a8b:73f1 with SMTP id v6-20020adfedc6000000b003176a8b73f1mr750836wro.32.1693947989154;
        Tue, 05 Sep 2023 14:06:29 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5012000000b00317b063590fsm18427672wrt.55.2023.09.05.14.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:06:28 -0700 (PDT)
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
Subject: [PATCH bpf-next 7/8] selftest, bpf: enable cpu v4 tests for arm32
Date:   Tue,  5 Sep 2023 21:06:20 +0000
Message-Id: <20230905210621.1711859-8-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230905210621.1711859-1-puranjay12@gmail.com>
References: <20230905210621.1711859-1-puranjay12@gmail.com>
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
index 8893094725f0..d98485cd3fd8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bswap.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bswap.c
@@ -5,7 +5,8 @@
 #include "bpf_misc.h"
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || defined(__TARGET_ARCH_arm)) && \
+     __clang_major__ >= 18
 
 SEC("socket")
 __description("BSWAP, 16")
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotol.c b/tools/testing/selftests/bpf/progs/verifier_gotol.c
index 2dae5322a18e..f1d76e874c67 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotol.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
@@ -5,7 +5,8 @@
 #include "bpf_misc.h"
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || defined(__TARGET_ARCH_arm)) && \
+     __clang_major__ >= 18
 
 SEC("socket")
 __description("gotol, small_imm")
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 0c638f45aaf1..c712dffb90db 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -5,7 +5,8 @@
 #include "bpf_misc.h"
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || defined(__TARGET_ARCH_arm)) && \
+     __clang_major__ >= 18
 
 SEC("socket")
 __description("LDSX, S8")
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 3c8ac2c57b1b..24599b269d43 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -5,7 +5,8 @@
 #include "bpf_misc.h"
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || defined(__TARGET_ARCH_arm)) && \
+     __clang_major__ >= 18
 
 SEC("socket")
 __description("MOV32SX, S8")
diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
index 0990f8825675..31a0555c429c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -5,7 +5,8 @@
 #include "bpf_misc.h"
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || defined(__TARGET_ARCH_arm)) && \
+     __clang_major__ >= 18
 
 SEC("socket")
 __description("SDIV32, non-zero imm divisor, check 1")
-- 
2.39.2

