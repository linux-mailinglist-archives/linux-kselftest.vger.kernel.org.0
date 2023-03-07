Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBD66AE9CD
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 18:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjCGR1x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 12:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjCGR1X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 12:27:23 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEE598E9B;
        Tue,  7 Mar 2023 09:22:41 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i34so55323266eda.7;
        Tue, 07 Mar 2023 09:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678209760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX9d0kgXQURozDFuIvakR/LVRy3evUuOWuMgoK4cT+g=;
        b=KYbuBGMTm/O97tpiJqbC3UA2u2PmSRLd3BXaSJSzbOKrcpnC1hbia9Ulnm//kf17Ft
         s2KgO/waG1KDDBCkfLL/wrk8Uh0HdZFjBRXin7uAB/V4FIyBmtsray2lwwUC17Ky8ROC
         Ep8xBqg6KMq3//jUGyV2An9/LR3ZnM/cQCZR/nNQVIE/SfJ1nQfiG5Srbg/oxKZu1JjS
         km655NJCbEEkyuwRIxRu7TohWZlQld2XN9Y42LRyFIBhgGKxlQf/5LEs1OpgjiZbruJI
         kVQkLrQqZpo8j138Gde8dioPweszb88XCgR1gVeGr9bTd815i8FqfOeNubW4VJkLXn2D
         BBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678209760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX9d0kgXQURozDFuIvakR/LVRy3evUuOWuMgoK4cT+g=;
        b=DHGEi6hgY2yKeOGa49RFxkJewvsr5rmgLxj3SxkGYOdQovtxQ/aLHGkVB8Y8PLjTlD
         mK6rFALQL0MG5DB9So0VJ7Yx9/tKUbh5PRPy9+H+oHaaO4kR93/HvhoKcTRzHt/HFURc
         GIvST1g+3Knl3SD1cnJHfn3Z0ciWwx290ORI7xswgX4tYfYdtxbY2hQSRitC/vHW1l2d
         IuIZFgY94prPFqvBPSi7+dhRqIJCG/TMuQyNnOwH8cqZJZXnvsu0u8kURE2KP5WSqfXM
         a0PtOaW4zM5vuRXPagJQOU2aFhoMe6pI3mChoPbWv7lANUoNdDy1Md7BpIbPPe3mWeax
         Semw==
X-Gm-Message-State: AO0yUKX35BhOBb/MJkty4NCutm4GtatLAv/N4ORxIwgshK94ZmNiNAex
        Qi3JtuB7UX8IS53SatP9j+ECZDLvvtyu6LPIOQk=
X-Google-Smtp-Source: AK7set9LgTZn0HgFblAoXaH39W4h78GaBj+CHvntuYnzSuYHhLZ8me8dMoTLncFVsvKsy8oNT+TV7qReuhARn94FJOE=
X-Received: by 2002:a17:906:747:b0:87b:dce7:c245 with SMTP id
 z7-20020a170906074700b0087bdce7c245mr6851404ejb.3.1678209760095; Tue, 07 Mar
 2023 09:22:40 -0800 (PST)
MIME-Version: 1.0
References: <20230307220449.2933650-1-xukuohai@huaweicloud.com> <20230307220449.2933650-2-xukuohai@huaweicloud.com>
In-Reply-To: <20230307220449.2933650-2-xukuohai@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 7 Mar 2023 09:22:08 -0800
Message-ID: <CAADnVQLDmP0A7Pr7628nH8YSo3-xTjzAr5-x-0YCZvuS8xu09A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: update 32-bit bounds when the lower
 32-bit value is not wrapping
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 7, 2023 at 1:05=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com>=
 wrote:
>
> The following XDP prog is accepted by verifier.
>
> 0: (61) r2 =3D *(u32 *)(r1 +0)          ; R2_w=3Dpkt(off=3D0,r=3D0,imm=3D=
0)
> 1: (61) r3 =3D *(u32 *)(r1 +4)          ; R3_w=3Dpkt_end(off=3D0,imm=3D0)
> 2: (bf) r1 =3D r2
> 3: (07) r1 +=3D 1
> 4: (2d) if r1 > r3 goto pc+6
> 5: (71) r1 =3D *(u8 *)(r2 +0)           ; R1_w=3Dscalar(umax=3D255,var_of=
f=3D(0x0; 0xff))
> 6: (b4) w0 =3D 0x7fffff10
> 7: (0c) w1 +=3D w0                      ; R1_w=3Dscalar(umin=3D0x7fffff10=
,umax=3D0x8000000f,var_off=3D(0x0; 0xffffffff))
> 8: (b4) w0 =3D 0x80000000
> 9: (04) w0 +=3D 1
> 10: (ae) if w0 < w1 goto pc-2
> 11: (b7) r0 =3D 0
> 12: (95) exit
>
> while the following 64-bit version is rejected.
>
> 0: (61) r2 =3D *(u32 *)(r1 +0)          ; R2_w=3Dpkt(off=3D0,r=3D0,imm=3D=
0)
> 1: (61) r3 =3D *(u32 *)(r1 +4)          ; R3_w=3Dpkt_end(off=3D0,imm=3D0)
> 2: (bf) r1 =3D r2
> 3: (07) r1 +=3D 1
> 4: (2d) if r1 > r3 goto pc+8
> 5: (71) r1 =3D *(u8 *)(r2 +0)           ; R1_w=3Dscalar(umax=3D255,var_of=
f=3D(0x0; 0xff))
> 6: (18) r0 =3D 0x7fffffffffffff10
> 8: (0f) r1 +=3D r0                      ; R1_w=3Dscalar(umin=3D0x7fffffff=
ffffff10,umax=3D0x800000000000000f)
> 9: (18) r0 =3D 0x8000000000000000
> 11: (07) r0 +=3D 1
> 12: (ad) if r0 < r1 goto pc-2
> 13: (b7) r0 =3D 0
> 14: (95) exit

These two programs are not equivalent.
Not clear how apples to oranges comparison explains anything.

> The verifier log says:
>
> [...]
>
> from 12 to 11: R0_w=3D-9223372036854775794 R1=3Dscalar(umin=3D92233720368=
54775823,umax=3D9223372036854775823,var_off=3D(0x8000000000000000; 0xffffff=
ff))
> 11: (07) r0 +=3D 1                      ; R0_w=3D-9223372036854775793
> 12: (ad) if r0 < r1 goto pc-2         ; R0_w=3D-9223372036854775793 R1=3D=
scalar(umin=3D9223372036854775823,umax=3D9223372036854775823,var_off=3D(0x8=
000000000000000; 0xffffffff))
> 13: safe
>
> from 12 to 11: R0_w=3D-9223372036854775793 R1=3Dscalar(umin=3D92233720368=
54775824,umax=3D9223372036854775823,var_off=3D(0x8000000000000000; 0xffffff=
ff))

First thing to debug is why umin is higher than umax.

> 11: (07) r0 +=3D 1                      ; R0_w=3D-9223372036854775792
> 12: (ad) if r0 < r1 goto pc-2         ; R0_w=3D-9223372036854775792 R1=3D=
scalar(umin=3D9223372036854775824,umax=3D9223372036854775823,var_off=3D(0x8=
000000000000000; 0xffffffff))
> 13: safe
>
> [...]
>
> The loop crosses termination condition r0 =3D=3D r1.umax, and does not st=
op.
>
> The reason is that when the verifier enumerates to r1.umin =3D=3D r1.umax=
, the value
> 0x800000000000000f of r1.umin is greater than U32_MAX, so __reg_combine_6=
4_into_32
> sets the u32 range of r1 to [0, U32_MAX] instead of marking r1 as a const=
ant,
> making is_branch_taken() in check_cond_jmp_op() be skipped.

And it's fine. The verifier is conservative.

>
> To fix it, update 32-bit bounds when the lower 32-bit value is not wrappi=
ng,
> even if the 64-bit value is beyond the range of [0, U32_MAX] or [S32_MIN,=
 S32_MAX].

That's not safe in general.

>
> Signed-off-by: Xu Kuohai <xukuohai@huaweicloud.com>
> ---
>  kernel/bpf/verifier.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b2116ca78d9a..64c9ee3857ec 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2013,26 +2013,21 @@ static void __reg_combine_32_into_64(struct bpf_r=
eg_state *reg)
>         reg_bounds_sync(reg);
>  }
>
> -static bool __reg64_bound_s32(s64 a)
> -{
> -       return a >=3D S32_MIN && a <=3D S32_MAX;
> -}
> -
> -static bool __reg64_bound_u32(u64 a)
> -{
> -       return a >=3D U32_MIN && a <=3D U32_MAX;
> -}
> -
>  static void __reg_combine_64_into_32(struct bpf_reg_state *reg)
>  {
> +       s64 smin =3D reg->smin_value;
> +       s64 smax =3D reg->smax_value;
> +       u64 umin =3D reg->umin_value;
> +       u64 umax =3D reg->umax_value;
> +
>         __mark_reg32_unbounded(reg);
> -       if (__reg64_bound_s32(reg->smin_value) && __reg64_bound_s32(reg->=
smax_value)) {
> -               reg->s32_min_value =3D (s32)reg->smin_value;
> -               reg->s32_max_value =3D (s32)reg->smax_value;
> +       if ((u64)(smax - smin) <=3D (u64)U32_MAX && (s32)smin <=3D (s32)s=
max) {
> +               reg->s32_min_value =3D (s32)smin;
> +               reg->s32_max_value =3D (s32)smax;
>         }
> -       if (__reg64_bound_u32(reg->umin_value) && __reg64_bound_u32(reg->=
umax_value)) {
> -               reg->u32_min_value =3D (u32)reg->umin_value;
> -               reg->u32_max_value =3D (u32)reg->umax_value;
> +       if (umax - umin <=3D U32_MAX && (u32)umin <=3D (u32)umax) {
> +               reg->u32_min_value =3D (u32)umin;
> +               reg->u32_max_value =3D (u32)umax;

This looks like a workaround for umin > umax issue.
Please debug that instead.

>         }
>         reg_bounds_sync(reg);
>  }
> --
> 2.30.2
>
