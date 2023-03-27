Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236D06C9A12
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 05:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjC0DVD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Mar 2023 23:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC0DUy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Mar 2023 23:20:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E786249CE;
        Sun, 26 Mar 2023 20:20:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cn12so30168924edb.4;
        Sun, 26 Mar 2023 20:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679887246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrfkKr7kVJzAl2Q8p+pDeSS3kB9FzyNS1dOlr1t1DZA=;
        b=erEjrwRR9E22dVyY+ccsOjPF5S5RMKG0pg4THPjlSDYE0jsuAeAE/v6H1rfe/v7jjS
         T6xXriDXxvinfOjfPXIzC8uT10F3H2JOtN3q/iqZUc58v0U/atKykYUR+14KSfM2y4PT
         9ElYBWmts0hhdu0Oy+3t5/J+4C3eY+GGruRVC5tJQBY5HGFnDOr16NweNCZ7bBHKoJK6
         uT1EtrODm+8SjstPAIEnh4u5kvrE/w3OcRribQy1CVCPE2RxT+TvBHiR8G/uPOMkBUgc
         HM2Vu6zhzy402JUTGrTX3E6esTgtf/iyh02m24KnSvSrWL5vjY3or8qKHpkbKjDC6Wy5
         /7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679887246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrfkKr7kVJzAl2Q8p+pDeSS3kB9FzyNS1dOlr1t1DZA=;
        b=TH9x9CgSGsGepoXnIml2zdyZLZ5iuwZQh218yzCP4ZlWCk21fpiYeLlL5lAWIA885v
         m6rMhi2xWSqEsKO+hCzpp2E+8Lm6uB7y3QdDVL+ciTSBbH/m5JTH9qTOeO/zxHi48nxD
         mR9Vcvt8RNkkvsMbjYHIrV2SCCgO2zIVjbwonyDaGU1TTwb/XX45EFIZayrEo1h4O7IX
         ht3Cdhzg5w9uFrl1NdIAipef6am4gAZ8hg8nUgVi6lnAGQsRQzEnsx33CYxasgjSEJAM
         J/d17lYYqrOT4iqOYDEK+P5gNDTZYjQv36849LlI3giccDcO3zrvgmG6I70mxv11FqgU
         /ORw==
X-Gm-Message-State: AAQBX9eetgH+/EyImzWvojAlgxcgl03G1vI3gtfilDwWxT0647EHQpoV
        hecLSqcnFF7HFPL3wc/tOSu2S7tOZfJTG9NHLZrhRqfebUs=
X-Google-Smtp-Source: AKy350aBsQNuTRy1d+LNW3Q51cuggDsvwLLrjlnN64vxnMXSSa/s51Ed9cOjQQG8YsB/hY7s6vF/HKGlYHnI3zbrAPY=
X-Received: by 2002:a50:d694:0:b0:4fc:f0b8:7da0 with SMTP id
 r20-20020a50d694000000b004fcf0b87da0mr5258495edi.1.1679887246271; Sun, 26 Mar
 2023 20:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230327153538.850440-1-xukuohai@huaweicloud.com>
In-Reply-To: <20230327153538.850440-1-xukuohai@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 26 Mar 2023 20:20:34 -0700
Message-ID: <CAEf4BzZuf=G0sEk5XqB0nAbvr81uRChLa96WDz0jCSG82=kofQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove two infinite loop bound
 check cases
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 26, 2023 at 7:45=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> The two infinite loop bound check cases added by commit
> 1a3148fc171f ("selftests/bpf: Check when bounds are not in the 32-bit ran=
ge")
> take a long time to execute but don't add much value.
>
> Remove them to reduce run time of test_verifier.

Summary: 2042 PASSED, 0 SKIPPED, 1 FAILED

real    0m4.780s
user    0m0.458s
sys     0m3.871s


5 seconds isn't such a long time, especially when we compare it to
test_progs (even with parallelization).

>
> Fixes: 1a3148fc171f ("selftests/bpf: Check when bounds are not in the 32-=
bit range")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  tools/testing/selftests/bpf/verifier/bounds.c | 50 -------------------
>  1 file changed, 50 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testin=
g/selftests/bpf/verifier/bounds.c
> index 74b1917d4208..515a8222f08f 100644
> --- a/tools/testing/selftests/bpf/verifier/bounds.c
> +++ b/tools/testing/selftests/bpf/verifier/bounds.c
> @@ -777,31 +777,6 @@
>         .result =3D ACCEPT,
>         .prog_type =3D BPF_PROG_TYPE_XDP,
>  },
> -{
> -       "bound check with JMP_JSLT for crossing 64-bit signed boundary",
> -       .insns =3D {
> -       BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, =
data)),
> -       BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, =
data_end)),
> -       BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
> -       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
> -       BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 8),
> -
> -       BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
> -       BPF_LD_IMM64(BPF_REG_0, 0x7fffffffffffff10),
> -       BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
> -
> -       BPF_LD_IMM64(BPF_REG_0, 0x8000000000000000),
> -       BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
> -       /* r1 signed range is [S64_MIN, S64_MAX] */
> -       BPF_JMP_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
> -
> -       BPF_MOV64_IMM(BPF_REG_0, 0),
> -       BPF_EXIT_INSN(),
> -       },
> -       .errstr =3D "BPF program is too large",
> -       .result =3D REJECT,
> -       .prog_type =3D BPF_PROG_TYPE_XDP,
> -},
>  {
>         "bound check for loop upper bound greater than U32_MAX",
>         .insns =3D {
> @@ -849,28 +824,3 @@
>         .result =3D ACCEPT,
>         .prog_type =3D BPF_PROG_TYPE_XDP,
>  },
> -{
> -       "bound check with JMP32_JSLT for crossing 32-bit signed boundary"=
,
> -       .insns =3D {
> -       BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, =
data)),
> -       BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, =
data_end)),
> -       BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
> -       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
> -       BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 6),
> -
> -       BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
> -       BPF_MOV32_IMM(BPF_REG_0, 0x7fffff10),
> -       BPF_ALU32_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
> -
> -       BPF_MOV32_IMM(BPF_REG_0, 0x80000000),
> -       BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
> -       /* r1 signed range is [S32_MIN, S32_MAX] */
> -       BPF_JMP32_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
> -
> -       BPF_MOV64_IMM(BPF_REG_0, 0),
> -       BPF_EXIT_INSN(),
> -       },
> -       .errstr =3D "BPF program is too large",
> -       .result =3D REJECT,
> -       .prog_type =3D BPF_PROG_TYPE_XDP,
> -},
> --
> 2.30.2
>
