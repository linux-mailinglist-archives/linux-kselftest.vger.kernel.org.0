Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0CB7DE0F4
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Nov 2023 13:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbjKAMeG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Nov 2023 08:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343670AbjKAMeF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Nov 2023 08:34:05 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617A4E4;
        Wed,  1 Nov 2023 05:34:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c50d1b9f22so87049791fa.0;
        Wed, 01 Nov 2023 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698842040; x=1699446840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/NwfKtoyspxT9DotnbjmoTKFlNWUE7/HmaMh4d/yZM=;
        b=jDubYWjfISERIunB27vuNZspL9NmWjE1butfVlPShGaRwEctheifwbZSz6O5ge4IMs
         QKdTE3GtEQky+qJ7hHCopRmkU3dzdnuTD8+k1zXLw6Zi1cVsdYMzPuZnXwV4tRZ03cXc
         TJK6oe2aYuvXMRGa9rpRN9d1u/LuD+uefoH4a3wbZfcCNZyACRQ7FJjg/3+LxFfXWCXp
         B7bXWjpvbX0Ag6qui7cgHbG5Lp8PJMKam/Fh7iKa0xN6vuhZEMrQv67f7ToJM/ANQZ6x
         WxAq15n+ePkiy98vvPt+EDAGQLtQKYpmdxI8+zRMRkjb4VQY1HeIwmqxL8rX7KXacqRQ
         X0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698842040; x=1699446840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/NwfKtoyspxT9DotnbjmoTKFlNWUE7/HmaMh4d/yZM=;
        b=Oy+eb3D0iyN2HOcfgBfTygCDjPNMM4j8ZDJUDbcJaviriSiUnCAcP3vH/ox3Eg3Vi9
         uWDhihum1KCtXb/6U4wRHl8OSjjs6oOoiI6u967mnfjv5jyuWObkU0K+xFnSR3GQkvAX
         ORsXRDkHoCqjGTwgfVl8+05JaiC3eTFQ+ItDfjjt3gwgyuPz+t1o1fceXKtV6xbemde4
         KyBJgEeMYT29VDZ7mDqnVylj4lTx0Ha3jX3JaUfNhhvjOAE7vprwvui6Xpdm3BLOjjyX
         ijNO/yPQLPEegXYRMSEPDKSalkyoGlX+jyPFNnF8vtT2vg9oyS017GpQ4uGy0Bg48Ke9
         vdpA==
X-Gm-Message-State: AOJu0YzNgnZafC6m5em5NA4lUVRYdonQTqen3YezQf3GHFAsLLwN95GA
        CvmNBw1TjpjCP1m01KHJ+A==
X-Google-Smtp-Source: AGHT+IHHyFwufSFlvgaff4yXL+LU1czAmdIqzYLTTRatYKLTMU94nukYoAJIQ3MmMKpSEHTy3KOiaw==
X-Received: by 2002:a2e:3e1a:0:b0:2bf:ab17:d48b with SMTP id l26-20020a2e3e1a000000b002bfab17d48bmr12931671lja.34.1698842040205;
        Wed, 01 Nov 2023 05:34:00 -0700 (PDT)
Received: from amdsuplus2.inf.ethz.ch (amdsuplus2.inf.ethz.ch. [129.132.31.88])
        by smtp.gmail.com with ESMTPSA id fk15-20020a05600c0ccf00b0040849ce7116sm1453505wmb.43.2023.11.01.05.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 05:33:59 -0700 (PDT)
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 01 Nov 2023 13:33:51 +0100
Subject: [PATCH bpf v3 1/2] bpf: Fix check_stack_write_fixed_off() to
 correctly spill imm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-fix-check-stack-write-v3-1-f05c2b1473d5@gmail.com>
References: <20231101-fix-check-stack-write-v3-0-f05c2b1473d5@gmail.com>
In-Reply-To: <20231101-fix-check-stack-write-v3-0-f05c2b1473d5@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698842036; l=2139;
 i=sunhao.th@gmail.com; s=20231009; h=from:subject:message-id;
 bh=4BtzXLkq4i2wNmdy8ecUMdiwriJ5sawqxpkEKLH1c/8=;
 b=sBMS/uPQK6NCw+m9NjK4TUB4ZeIxMxZnXuNhGWMxzje1/bQxqOz6YDGyGxVIIjZWFLm30UKJ2
 gMS37A4LHYJDI6FE8DLdpAb5ihedoaHU20y5UFPcAWzxZ4Fis0HB235
X-Developer-Key: i=sunhao.th@gmail.com; a=ed25519;
 pk=AHFxrImGtyqXOuw4f5xTNh4PGReb7hzD86ayyTZCXd4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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

