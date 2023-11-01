Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B357DE01F
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Nov 2023 12:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjKALHg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Nov 2023 07:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjKALHg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Nov 2023 07:07:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B704BF7;
        Wed,  1 Nov 2023 04:07:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507a5f2193bso813867e87.1;
        Wed, 01 Nov 2023 04:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698836851; x=1699441651; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sDsETI9m7t7kgPADCEoFbUHNZWp8HwKd1gKWFMHiraw=;
        b=d6WK6cIXmUSySuT10Jnpvc5Uyz2R3ZZNP7RlLykIWODa7bA0KCgzu3BRl5QvixXzyW
         jIiGPR+mvutPRCq1mcVt6241nMP/sIarbFs3oqe9+0Jx8uo7iKbxFCxp6Vy+wFb4lM/+
         TmM3ejIbYmGy64gL4b3K8s7q/4vUnfYn/Q1gJSpgJS3sG0bAfT+rkeDDGSFmM6AJ0aKU
         IE9EgTFhX116fSNYQkBz8COAgx8chCIdj53KwHJ51ONpPDcbSVbwyCG7E1VrIneEllLK
         HoV/s1HwCs8Shue0/NRPCKZ6ygHQvFHjgN1QmE2eBQnjO+STimf1cO2z/lyJDXso2NWz
         /jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698836851; x=1699441651;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDsETI9m7t7kgPADCEoFbUHNZWp8HwKd1gKWFMHiraw=;
        b=RHHjUo2O6JXVIhKYTi8IoS1nxmuDHAhu0PYOkgrnQQg7jL7HcdkpFSeMtB90YAT/O5
         FMqzya4q8XdEC3YZkzibfFiohVOQgAcepVgG9TdBTDp4GtMxdHzMIkNSZ40lsOmBxj38
         IkP1mSPkR7cV85XFhw+SeMFccYnMnADIfGE6dMXa3IBb1t3dGMXVcSoULGArDv4eH6VW
         EhZ5ZoY9S/IcXrQt/356+dw8fxL0hTl4a/b9buaqs1C7Wts1NmfJrey0KdSQTW23bnnr
         GOdiIzZcwx84H8lYl5brtcDR8JLaqvxKHl9LPmAhalE71XM0kU/Uny77EmgxT54oCBmb
         a1Ow==
X-Gm-Message-State: AOJu0YyUq8J5+Cy91SRVQdJgskqnzlDdAngmklaWdTAOooUktpaEYXxJ
        057AQpl5LtHAlXjBAX0C1dc=
X-Google-Smtp-Source: AGHT+IFbtcY7xqdiXKsjDIjg9rlbnlCsFSG5QAuU9IfJq0aZoZL9DgyUJ/Dfd9y0/HbJkivnyOSMQA==
X-Received: by 2002:a05:6512:4007:b0:509:39c0:7207 with SMTP id br7-20020a056512400700b0050939c07207mr1291389lfb.1.1698836850704;
        Wed, 01 Nov 2023 04:07:30 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d26-20020a194f1a000000b0050910031a92sm189915lfb.271.2023.11.01.04.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 04:07:30 -0700 (PDT)
Message-ID: <d10eae8fbdb8bbf85438879190414f57c999b4bc.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix check_stack_write_fixed_off() to
 correctly spill imm
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
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
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Date:   Wed, 01 Nov 2023 13:07:28 +0200
In-Reply-To: <20231101-fix-check-stack-write-v2-1-cb7c17b869b0@gmail.com>
References: <20231101-fix-check-stack-write-v2-0-cb7c17b869b0@gmail.com>
         <20231101-fix-check-stack-write-v2-1-cb7c17b869b0@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2023-11-01 at 08:33 +0100, Hao Sun wrote:
> In check_stack_write_fixed_off(), imm value is cast to u32 before being
> spilled to the stack. Therefore, the sign information is lost, and the
> range information is incorrect when load from the stack again.
>=20
> For the following prog:
> 0: r2 =3D r10
> 1: *(u64*)(r2 -40) =3D -44
> 2: r0 =3D *(u64*)(r2 - 40)
> 3: if r0 s<=3D 0xa goto +2
> 4: r0 =3D 1
> 5: exit
> 6: r0  =3D 0
> 7: exit
>=20
> The verifier gives:
> func#0 @0
> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> 0: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
> 1: (7a) *(u64 *)(r2 -40) =3D -44        ; R2_w=3Dfp0 fp-40_w=3D4294967252
> 2: (79) r0 =3D *(u64 *)(r2 -40)         ; R0_w=3D4294967252 R2_w=3Dfp0
> fp-40_w=3D4294967252
> 3: (c5) if r0 s< 0xa goto pc+2
> mark_precise: frame0: last_idx 3 first_idx 0 subseq_idx -1
> mark_precise: frame0: regs=3Dr0 stack=3D before 2: (79) r0 =3D *(u64 *)(r=
2 -40)
> 3: R0_w=3D4294967252
> 4: (b7) r0 =3D 1                        ; R0_w=3D1
> 5: (95) exit
> verification time 7971 usec
> stack depth 40
> processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
>=20
> So remove the incorrect cast, since imm field is declared as s32, and
> __mark_reg_known() takes u64, so imm would be correctly sign extended
> by compiler.
>=20
> Fixes: ecdf985d7615 ("bpf: track immediate values written to stack by BPF=
_ST instruction")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 857d76694517..44af69ce1301 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4674,7 +4674,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>  		   insn->imm !=3D 0 && env->bpf_capable) {
>  		struct bpf_reg_state fake_reg =3D {};
> =20
> -		__mark_reg_known(&fake_reg, (u32)insn->imm);
> +		__mark_reg_known(&fake_reg, insn->imm);
>  		fake_reg.type =3D SCALAR_VALUE;
>  		save_register_state(state, spi, &fake_reg, size);
>  	} else if (reg && is_spillable_regtype(reg->type)) {
>=20

