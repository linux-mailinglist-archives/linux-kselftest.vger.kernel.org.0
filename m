Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74137DDD49
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Nov 2023 08:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjKAHeL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Nov 2023 03:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjKAHeK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Nov 2023 03:34:10 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270D7E4;
        Wed,  1 Nov 2023 00:34:08 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c514cbbe7eso90076371fa.1;
        Wed, 01 Nov 2023 00:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698824046; x=1699428846; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8hgrjlDvFMKSVzJkLU39O15qC5sfoG0Arowg8Wk8LM=;
        b=Gt0Hk+jgxbM8Pc/LxlG+Ik0K+FOr5UxAj1G0rCxbg8/9O50Lgk8nPA3yCPZUrejQPd
         C9Ysej+PmDG30BQJvyosS88IyTeR58fJoGb/vBayrcteLYIxeEfV7mIs8svMRJ8+0BzQ
         FiARKKib/XkfqRRGAwAWJZHsics5swhtL9RL/363l6XjwwDlLzVwxT1RBNGwp3zW4Lo9
         blh2UlqbgJJuxzoonkev5A1DiO40MHmdSkTvO7BKaTnZ0/Qu7tbbimLRQzVauUr2JUrF
         53oIX5nLlXKDXE9LV4qomMBD4JuC8HS60rGjo/4aHK89LTVAJtghwLDOLcVxgoRIMKcM
         C+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698824046; x=1699428846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8hgrjlDvFMKSVzJkLU39O15qC5sfoG0Arowg8Wk8LM=;
        b=mBnkWg2q60w9zG//M7eIuMe3DGYxFNOyN98G2kJEiQFmbkNjNvH13Up64b/2OkOFW+
         aUQszAgnVj70zxlFCQVJGyERm4Ods8Ba+xWLCy5JrPHaM3gjo7JJ2xc+w5qBdHXz+XLc
         T4xCPsjGMPinm7sb2JSvNnWMRKkyZrl99JRw7HqvNP3aLAvt9XlC3w1ecNR7P9uRwFfV
         IzRilPjije1dgQU3cA0krnDMRZwWgs7LYv2Opct3Lo8RvVvvAjVLaOxTBVGOo3nDXGVA
         8I1scgU+X8CDFs1rb2qA+qLavj04BsVtMNwxgRN84iR6G2A+99Nr1esIUSsTonbEURT5
         ZACw==
X-Gm-Message-State: AOJu0Yz8oUbgxyY+iTft464xrK+JtQo1i6+waOrG/1XyadROSCdhtgZ+
        Ljydv7sZ13LDbfTa07keBA==
X-Google-Smtp-Source: AGHT+IGmiYnbW7O7QqVgPinskC/MOx+ZrZXVgtqkcIXnimyAQpFooWC8s+gQWZXLiarAuM5VnNThjg==
X-Received: by 2002:a05:6512:3ba8:b0:509:3785:fd98 with SMTP id g40-20020a0565123ba800b005093785fd98mr3049466lfv.44.1698824045756;
        Wed, 01 Nov 2023 00:34:05 -0700 (PDT)
Received: from amdsuplus2.inf.ethz.ch (amdsuplus2.inf.ethz.ch. [129.132.31.88])
        by smtp.gmail.com with ESMTPSA id i18-20020adff312000000b0032d893d8dc8sm3401810wro.2.2023.11.01.00.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 00:34:04 -0700 (PDT)
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 01 Nov 2023 08:33:22 +0100
Subject: [PATCH bpf v2 1/2] bpf: Fix check_stack_write_fixed_off() to
 correctly spill imm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-fix-check-stack-write-v2-1-cb7c17b869b0@gmail.com>
References: <20231101-fix-check-stack-write-v2-0-cb7c17b869b0@gmail.com>
In-Reply-To: <20231101-fix-check-stack-write-v2-0-cb7c17b869b0@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698824042; l=2043;
 i=sunhao.th@gmail.com; s=20231009; h=from:subject:message-id;
 bh=ul85j3F8ehQe8EUMkKWv7wQfGIECOmyaTKwskzJcVEc=;
 b=a9SceJhCUVsYqeRF9Abk77k9yz7T72uAeX43PMew3+zfC1bN990ouVGTwaY4tBccnBb5o0ula
 9RkuD00PzovBipIYuBXsJcm9knM4amjzhnO5T82h4DLs9TEJNt5PueX
X-Developer-Key: i=sunhao.th@gmail.com; a=ed25519;
 pk=AHFxrImGtyqXOuw4f5xTNh4PGReb7hzD86ayyTZCXd4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In check_stack_write_fixed_off(), imm value is cast to u32 before being
spilled to the stack. Therefore, the sign information is lost, and the
range information is incorrect when load from the stack again.

For the following prog:
0: r2 = r10
1: *(u64*)(r2 -40) = -44
2: r0 = *(u64*)(r2 - 40)
3: if r0 s<= 0xa goto +2
4: r0 = 1
5: exit
6: r0  = 0
7: exit

The verifier gives:
func#0 @0
0: R1=ctx(off=0,imm=0) R10=fp0
0: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
1: (7a) *(u64 *)(r2 -40) = -44        ; R2_w=fp0 fp-40_w=4294967252
2: (79) r0 = *(u64 *)(r2 -40)         ; R0_w=4294967252 R2_w=fp0
fp-40_w=4294967252
3: (c5) if r0 s< 0xa goto pc+2
mark_precise: frame0: last_idx 3 first_idx 0 subseq_idx -1
mark_precise: frame0: regs=r0 stack= before 2: (79) r0 = *(u64 *)(r2 -40)
3: R0_w=4294967252
4: (b7) r0 = 1                        ; R0_w=1
5: (95) exit
verification time 7971 usec
stack depth 40
processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

So remove the incorrect cast, since imm field is declared as s32, and
__mark_reg_known() takes u64, so imm would be correctly sign extended
by compiler.

Fixes: ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
Cc: stable@vger.kernel.org
Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 857d76694517..44af69ce1301 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4674,7 +4674,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		   insn->imm != 0 && env->bpf_capable) {
 		struct bpf_reg_state fake_reg = {};
 
-		__mark_reg_known(&fake_reg, (u32)insn->imm);
+		__mark_reg_known(&fake_reg, insn->imm);
 		fake_reg.type = SCALAR_VALUE;
 		save_register_state(state, spi, &fake_reg, size);
 	} else if (reg && is_spillable_regtype(reg->type)) {

-- 
2.34.1

