Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708AA7DE010
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Nov 2023 12:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjKALFm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Nov 2023 07:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjKALFl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Nov 2023 07:05:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C994111;
        Wed,  1 Nov 2023 04:05:38 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c594196344so97509631fa.3;
        Wed, 01 Nov 2023 04:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698836736; x=1699441536; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+Z3Do7J3Zw1Jdi4ducS/Fi/mcvigbwggXv1TRTYbns=;
        b=RJgnSiQICprdLcbtO678GSVkis2V4EpLxB8aPbeYLcFO4EBjy8r9h9VCH8M9q4HbKM
         L/0WO0CVyGldY8c6MObJyQQOSUljZOz57D715P5Ny4jNkpV+LOkuZu9yyE/WxFEoqFoN
         JWTpYycqdEKMbB7z12PJs4Gu/Fs88kwZDdTU9i9wIXE1gh/1DkEZ0N/Dv17Nt9uOTo6C
         GUhlCnCVd61o7+QAFaG/wA0+85axNMP2OzbbgbDCsAPkf7zJoqiizNRcNu6HTZWy/V6s
         DbUG1BEvCuFeANkmUraPdi2tKooTTRr0iE1tiMwvO1JkZs9NmzyHCAgtAhSkYPSRVPMC
         FIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698836736; x=1699441536;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+Z3Do7J3Zw1Jdi4ducS/Fi/mcvigbwggXv1TRTYbns=;
        b=CAekvDGlyaJaMK2PIfl1md7RYITqP47SFa6h5QzJjz8kDWIdFxFqfy4NyB7NOISJe0
         +a4PSBQ6EJoGwt1PgSfumHgnmTUu+WcYKIslgmKoXhOlqAYEbFx70o+uHnb44/fLa1PB
         6CbZUIBFb6VcxpTlM3pGV/IWijdnBzvkWcxRKqOjwMdeSZbCU/hzKliOk9f1hW6yWFDJ
         D2QnmbLxnBxeusILCTfetwTMFvDpewWLQFHCBDIsTkxkjPXo/vQNpZmeFEyGAEMqvpQi
         E7uWAY4lvOSI42tLcjKQXrBtCfb9M0JXzpMbrZ9MfkwhwJe7gtl6RbuNgDkA0Rs9gnIl
         G9Fg==
X-Gm-Message-State: AOJu0YxtVOzZ7MEKoACQMWYzBklN47Io194qT13QPz75KMq7/fOwA6hH
        s+WilK3msnu2BjGfXjp7PnM=
X-Google-Smtp-Source: AGHT+IGB3Q+cPBWL9THhOrCjrcivf3jw9MrANp+1qm19E2D4+8F1GTRcj//bNpekNgn1CA5TwkIz/g==
X-Received: by 2002:a05:651c:c9b:b0:2c0:7d6:570a with SMTP id bz27-20020a05651c0c9b00b002c007d6570amr14088608ljb.33.1698836736066;
        Wed, 01 Nov 2023 04:05:36 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v20-20020a2e5054000000b002c17dcd8d91sm183576ljd.120.2023.11.01.04.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 04:05:35 -0700 (PDT)
Message-ID: <4ec86365668f6c3b4242232506e896a17aa2af4c.camel@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add test for immediate
 spilled to stack
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
        linux-kselftest@vger.kernel.org
Date:   Wed, 01 Nov 2023 13:05:33 +0200
In-Reply-To: <20231101-fix-check-stack-write-v2-2-cb7c17b869b0@gmail.com>
References: <20231101-fix-check-stack-write-v2-0-cb7c17b869b0@gmail.com>
         <20231101-fix-check-stack-write-v2-2-cb7c17b869b0@gmail.com>
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
> Add a test to check if the verifier correctly reason about the sign
> of an immediate spilled to stack by BPF_ST instruction.
>=20
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> ---
>  tools/testing/selftests/bpf/verifier/bpf_st_mem.c | 32 +++++++++++++++++=
++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/verifier/bpf_st_mem.c b/tools/te=
sting/selftests/bpf/verifier/bpf_st_mem.c
> index 3af2501082b2..0ba23807c46c 100644
> --- a/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
> +++ b/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
> @@ -65,3 +65,35 @@
>  	.expected_attach_type =3D BPF_SK_LOOKUP,
>  	.runs =3D -1,
>  },
> +{
> +	"BPF_ST_MEM stack imm sign",
> +	/* Check if verifier correctly reasons about sign of an
> +	 * immediate spilled to stack by BPF_ST instruction.
> +	 *
> +	 *   fp[-8] =3D -44;
> +	 *   r0 =3D fp[-8];
> +	 *   if r0 s< 0 goto ret0;
> +	 *   r0 =3D -1;
> +	 *   exit;
> +	 * ret0:
> +	 *   r0 =3D 0;
> +	 *   exit;
> +	 */
> +	.insns =3D {
> +	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, -44),
> +	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
> +	BPF_JMP_IMM(BPF_JSLT, BPF_REG_0, 0, 2),
> +	BPF_MOV64_IMM(BPF_REG_0, -1),
> +	BPF_EXIT_INSN(),
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +	},
> +	/* Use prog type that requires return value in range [0, 1] */
> +	.prog_type =3D BPF_PROG_TYPE_SK_LOOKUP,
> +	.expected_attach_type =3D BPF_SK_LOOKUP,
> +	.result =3D VERBOSE_ACCEPT,
> +	.runs =3D -1,
> +	.errstr =3D "0: (7a) *(u64 *)(r10 -8) =3D -44        ; R10=3Dfp0 fp-8_w=
=3D-44\
> +	2: (c5) if r0 s< 0x0 goto pc+2\
> +	2: R0_w=3D-44",
> +},
>=20

Please note that this test case fails on CI [0], full log below:

2023-11-01T07:49:51.2841702Z #116/p BPF_ST_MEM stack imm sign FAIL
2023-11-01T07:49:51.2843456Z Unexpected verifier log!
2023-11-01T07:49:51.2844968Z EXP: 2: R0_w=3D-44
2023-11-01T07:49:51.2845583Z RES:
2023-11-01T07:49:51.2846693Z func#0 @0
2023-11-01T07:49:51.2848932Z 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
2023-11-01T07:49:51.2853045Z 0: (7a) *(u64 *)(r10 -8) =3D -44        ; R10=
=3Dfp0 fp-8_w=3D-44
2023-11-01T07:49:51.2857391Z 1: (79) r0 =3D *(u64 *)(r10 -8)         ; R0_w=
=3D-44 R10=3Dfp0 fp-8_w=3D-44
2023-11-01T07:49:51.2859127Z 2: (c5) if r0 s< 0x0 goto pc+2
2023-11-01T07:49:51.2862943Z mark_precise: frame0: last_idx 2 first_idx 0 s=
ubseq_idx -1=20
2023-11-01T07:49:51.2867511Z mark_precise: frame0: regs=3Dr0 stack=3D befor=
e 1: (79) r0 =3D *(u64 *)(r10 -8)
2023-11-01T07:49:51.2872217Z mark_precise: frame0: regs=3D stack=3D-8 befor=
e 0: (7a) *(u64 *)(r10 -8) =3D -44
2023-11-01T07:49:51.2872816Z 5: R0_w=3D-44
2023-11-01T07:49:51.2875653Z 5: (b7) r0 =3D 0                        ; R0_w=
=3D0
2023-11-01T07:49:51.2876493Z 6: (95) exit

I suspect that after recent logging fixes instruction number printed
after jump changed and that's why test case no longer passes.

Note: you can check CI status for submitted patch-sets using link [1].

[0] https://github.com/kernel-patches/bpf/actions/runs/6717053909/job/18254=
330860
[1] https://patchwork.kernel.org/project/netdevbpf/list/
