Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8767D85BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345426AbjJZPOI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 11:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345454AbjJZPN6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 11:13:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15F31B3;
        Thu, 26 Oct 2023 08:13:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so632405f8f.0;
        Thu, 26 Oct 2023 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698333234; x=1698938034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GZYfM9alYx1XV17SBVaQQmHlkvchqeTDUZzRxp2Jy0=;
        b=dOGplKLeaxgFaaM4GEvbyRJN5ySrNBqp2CYp14LNSKp9/DZ3dMEkpXlo8qD5s1Vj3u
         2ZquMtROAjtb+H36v+g37ekN4cMhjM89OvaXVnginirI9zS72a6f67lQ6cm6r60UCr04
         t1QX4kKgowj13JVrRRoqncgkd2T/uVvgKs36dZuUyi9dPgMKVXtb69oEZx7bNL7qwpV7
         pcpssTzf1pTiUEZIoqNmi+xWHbg1aE7gp9epX8fmDg+BsvBdmsK0OVhSrtXzPv4Lhk8P
         c9oOkDjn8Lto0X0Wfc4fXp5EpdxIAY8DEEUnBnW5wodW3dG3mBrrcrGB6PQscN0Y21lg
         +ABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698333234; x=1698938034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GZYfM9alYx1XV17SBVaQQmHlkvchqeTDUZzRxp2Jy0=;
        b=ctfv37clNsy4h7QsOJfErZ4fvEBdOxH4OynQ8u28KmH8WUgPJq9XKek5ibbfYMJOqp
         O08SJupttd7WunHETgbE2LdHAg+13cuyW1VqXxWwprCVVsGssJREHxx7ikPLrH3I/XGD
         lAhA6WOnE3n26lkVS3GOVwW7X7OpWJlePdbVZ0kf4e/0yhVo8LZZbf/1DKmO6zv0pOjm
         1kJby5sTQgCg16G5oIYLg3c73dAlTYoF8JNppKInjGr9m2LA0dKTkPDRtxREbMhddDy/
         EiIk0GT4wAPk79mq6GneL43hAAiMV6jfeM2ovvsGgB82ju02CeQqRjByK1auxvzQrv+s
         hTLQ==
X-Gm-Message-State: AOJu0YxhGs812PRswLvyHvTI6l3wJobPnlEqdURl3hsNAF5kih2Bwg1Z
        cVgBQzpuXx9ammcMTOUosQ==
X-Google-Smtp-Source: AGHT+IFo7NpHFXI5idFzGlmK+ztX8otPFBJI+8ajZV7yNDSBpaEqyzQ2RCwvfK+sw+TRBREMVc85Uw==
X-Received: by 2002:adf:fac1:0:b0:32d:a3cb:4059 with SMTP id a1-20020adffac1000000b0032da3cb4059mr2733307wrs.24.1698333234312;
        Thu, 26 Oct 2023 08:13:54 -0700 (PDT)
Received: from amdsuplus2.inf.ethz.ch (amdsuplus2.inf.ethz.ch. [129.132.31.88])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b0040472ad9a3dsm2843778wmo.14.2023.10.26.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:13:53 -0700 (PDT)
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Thu, 26 Oct 2023 17:13:10 +0200
Subject: [PATCH bpf-next 1/2] bpf: Fix check_stack_write_fixed_off() to
 correctly spill imm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-fix-check-stack-write-v1-1-6b325ef3ce7e@gmail.com>
References: <20231026-fix-check-stack-write-v1-0-6b325ef3ce7e@gmail.com>
In-Reply-To: <20231026-fix-check-stack-write-v1-0-6b325ef3ce7e@gmail.com>
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
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698333232; l=1923;
 i=sunhao.th@gmail.com; s=20231009; h=from:subject:message-id;
 bh=AjbqDip507uf1NxfrRiMESWoZyiU61/MidrgGnrm2Jo=;
 b=oJUHqmVuu6c81zWOl/sr8oDm3BiMn6W2du8FnGH+2KE4zKTxCLtWoLcmmugBf0S4cTNati4uy
 VEkTXeODXocBnRvBko0pdZhOT3KglpHpjNBQz4MydugW6hF5QXfyFG/
X-Developer-Key: i=sunhao.th@gmail.com; a=ed25519;
 pk=AHFxrImGtyqXOuw4f5xTNh4PGReb7hzD86ayyTZCXd4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

