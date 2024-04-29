Return-Path: <linux-kselftest+bounces-9079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3718B63ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 22:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFABCB226B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 20:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230051779BD;
	Mon, 29 Apr 2024 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE1CYrNE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211433C0;
	Mon, 29 Apr 2024 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424315; cv=none; b=ewpR8JPr4zxg0kPVfphBLZLc9sfR6jqZqJXmcmjmvdgJrZnFd2gcTE7lYWu05+B8BEYkwuQV6Qeourv8FdFQJMh7bhU1xmoCB/WINAUgIEyrd08Avu4IUeWC6+zJIn9Y92aEOnO7fwJs74/6GNDxZFu6kCZ9WE0jLg+VatFFR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424315; c=relaxed/simple;
	bh=5mvG4EYEAZeLF9c6C4QFkFlDPc0X9iZzL+sBI6lVlmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAVFIvvtEQfA4wGo/JC05rFTfW3AKOV69vAf9jBiSiAwUsRmp3hqPrNXr5n07dTO00P5F07CjlVbxrZFUPntKVc3oqhZriHPHj81RXQbFerb9QFSUza99KSACKGVhJXUTABRj4v0NvVjTvzH/OnDMo0A5H3FEG1GntALJ48QpFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE1CYrNE; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-613a6bb2947so943136a12.3;
        Mon, 29 Apr 2024 13:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714424312; x=1715029112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzV2KrdONyufwu1s+mZDUMueihdf/aasQ5Pvlp/Y8XQ=;
        b=nE1CYrNEOVOSf9XWjDtubdjoy5/bgd7FGu/6IHC7o2ADmE6MDBgEDQ3to6N862j3N1
         ehWfhTMcATkGIGxbWpiI71RYVNckO/ogbTYuE+t1nWzkXJMuEMnuLaWMhevwb7/56jAm
         ybEiceW/hYWz2sMGEFVimwc2JUnlqKcwVEKWQJB3UAA6YcOozwIpQTxLR186cuGFfk75
         veeq2OHVSc52HzA8zcgYtJsLbFzeMi9+gNmEnFLDJQlzKJ/0MgSBNFDuJ3RQOY17jULN
         hQU1xeCkepuYyVtpi4YBZCpKzgiF3KtQb3IT/HyAzj4j6Xuh86WUmkZ2bigFZVca6Jp0
         zpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714424312; x=1715029112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzV2KrdONyufwu1s+mZDUMueihdf/aasQ5Pvlp/Y8XQ=;
        b=H2jeSXMjYFHP50T13ttf6APBVH0RU2ZrhJoDHnQDzpz3/XUcbALtbW/O5BRPcOLlTw
         +sYAZwNH7b3v/Z+7yKPoUHkl3gnwLg6imq6mIIqPhdmDxs4TnWNz1+v1CVofc1WbbcUj
         vT30qSNvFq9fnVBZjNcoY4ncWYHuOCyeLVKEYWmAPjl2BcvwavMpoZtbqOHy1cHI8ecN
         eYr5h4RCNEKs0m8MX3D2kMwL3Q4hyFbc3YhwEWIoAs0fpu3oZAZJryQkfAxCWBxeynII
         CfSfgKBYCGV/SrFzwNKSMb0NsHvdW17HJ7TITRCL/bGXrSaJgYTRDCr1yHyonl2owGkj
         7kzg==
X-Forwarded-Encrypted: i=1; AJvYcCWOurk4rYyCYWa1iP3oYCOo7HfETe+YZ7qRADFECtIO1XEwiCWqkOSmInUhFTzpbA9f91UMG3O+hF3kGst6UbStR2sZc1CmGwTz1zZsfe94wquqZRgYs2tVTWCmqizr4oUcVH9Giym5GidXG2GzCz7mcoJgQrtp+TiFo7xbJoq76xL9kj4A3oUSNJuF2kx8fTh37TfuVAbpdWFNOT+n4NaQembn
X-Gm-Message-State: AOJu0Yy4J1zbp6/GzRJ9bV6nylSoFT+Wg0tCZxCxD2s1lNnF6I0YeQGz
	ewBLPms7GjEsueaQ8LgwRRJqEAF9curOKsRo6jU22WS227ulCuv7jAT5s0CAk1dTnxNuKd+gQUJ
	Z0W1jHIpEd4PIQy7swG6fgslHluM=
X-Google-Smtp-Source: AGHT+IElwXHig1wb13RauvtvskTgZgfBJUKBrwvlpcxzAMzvrzcNDyYGFdrbdp8s+IkxA0LBd/hL7tdBliiuCo5wFIA=
X-Received: by 2002:a17:90a:fa8e:b0:2ae:b8df:89e7 with SMTP id
 cu14-20020a17090afa8e00b002aeb8df89e7mr770373pjb.38.1714424312532; Mon, 29
 Apr 2024 13:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
 <20240411122752.2873562-8-xukuohai@huaweicloud.com> <e62e2971301ca7f2e9eb74fc500c520285cad8f5.camel@gmail.com>
 <f80991aa-3a49-451a-9a82-ac57982dcb28@huaweicloud.com> <bdc84c6c-7415-4b84-a883-1988cb5f77d1@linux.dev>
 <576c7c44-d1b4-42c8-8b6e-2e6b93d7547a@huaweicloud.com> <CAEf4BzZTzftrOCFsfBd81sHDBpmNK+4Jefqa3SSS6NiuncO0tQ@mail.gmail.com>
 <4fbce978-9687-48a9-be2a-1c4d76790f7d@huaweicloud.com>
In-Reply-To: <4fbce978-9687-48a9-be2a-1c4d76790f7d@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 13:58:20 -0700
Message-ID: <CAEf4BzZb38EemdD8ahX4Px3vWCp=ani6vcX71Z-1_MLeATNjwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 07/11] bpf: Fix a false rejection caused by
 AND operation
To: Xu Kuohai <xukuohai@huaweicloud.com>, Edward Cree <ecree.xilinx@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Brendan Jackman <jackmanb@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 8:15=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 4/27/2024 4:36 AM, Andrii Nakryiko wrote:
> > On Tue, Apr 23, 2024 at 7:26=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud=
.com> wrote:
> >>
> >> On 4/24/2024 5:55 AM, Yonghong Song wrote:
> >>>
> >>> On 4/20/24 1:33 AM, Xu Kuohai wrote:
> >>>> On 4/20/2024 7:00 AM, Eduard Zingerman wrote:
> >>>>> On Thu, 2024-04-11 at 20:27 +0800, Xu Kuohai wrote:
> >>>>>> From: Xu Kuohai <xukuohai@huawei.com>
> >>>>>>
> >>>>>> With lsm return value check, the no-alu32 version test_libbpf_get_=
fd_by_id_opts
> >>>>>> is rejected by the verifier, and the log says:
> >>>>>>
> >>>>>>     0: R1=3Dctx() R10=3Dfp0
> >>>>>>     ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmod=
e) @ test_libbpf_get_fd_by_id_opts.c:27
> >>>>>>     0: (b7) r0 =3D 0                        ; R0_w=3D0
> >>>>>>     1: (79) r2 =3D *(u64 *)(r1 +0)
> >>>>>>     func 'bpf_lsm_bpf_map' arg0 has btf_id 916 type STRUCT 'bpf_ma=
p'
> >>>>>>     2: R1=3Dctx() R2_w=3Dtrusted_ptr_bpf_map()
> >>>>>>     ; if (map !=3D (struct bpf_map *)&data_input) @ test_libbpf_ge=
t_fd_by_id_opts.c:29
> >>>>>>     2: (18) r3 =3D 0xffff9742c0951a00       ; R3_w=3Dmap_ptr(map=
=3Ddata_input,ks=3D4,vs=3D4)
> >>>>>>     4: (5d) if r2 !=3D r3 goto pc+4         ; R2_w=3Dtrusted_ptr_b=
pf_map() R3_w=3Dmap_ptr(map=3Ddata_input,ks=3D4,vs=3D4)
> >>>>>>     ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmod=
e) @ test_libbpf_get_fd_by_id_opts.c:27
> >>>>>>     5: (79) r0 =3D *(u64 *)(r1 +8)          ; R0_w=3Dscalar() R1=
=3Dctx()
> >>>>>>     ; if (fmode & FMODE_WRITE) @ test_libbpf_get_fd_by_id_opts.c:3=
2
> >>>>>>     6: (67) r0 <<=3D 62                     ; R0_w=3Dscalar(smax=
=3D0x4000000000000000,umax=3D0xc000000000000000,smin32=3D0,smax32=3Dumax32=
=3D0,var_off=3D(0x0; 0xc000000000000000))
> >>>>>>     7: (c7) r0 s>>=3D 63                    ; R0_w=3Dscalar(smin=
=3Dsmin32=3D-1,smax=3Dsmax32=3D0)
> >>>>>>     ;  @ test_libbpf_get_fd_by_id_opts.c:0
> >>>>>>     8: (57) r0 &=3D -13                     ; R0_w=3Dscalar(smax=
=3D0x7ffffffffffffff3,umax=3D0xfffffffffffffff3,smax32=3D0x7ffffff3,umax32=
=3D0xfffffff3,var_off=3D(0x0; 0xfffffffffffffff3))
> >>>>>>     ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmod=
e) @ test_libbpf_get_fd_by_id_opts.c:27
> >>>>>>     9: (95) exit
> >
> > [...]
> >
> >>
> >>       As suggested by Eduard, this patch makes a special case for sour=
ce
> >>       or destination register of '&=3D' operation being in range [-1, =
0].
> >>
> >>       Meaning that one of the '&=3D' operands is either:
> >>       - all ones, in which case the counterpart is the result of the o=
peration;
> >>       - all zeros, in which case zero is the result of the operation.
> >>
> >>       And MIN and MAX values could be derived based on above two obser=
vations.
> >>
> >>       [0] https://lore.kernel.org/bpf/e62e2971301ca7f2e9eb74fc500c5202=
85cad8f5.camel@gmail.com/
> >>       [1] https://github.com/llvm/llvm-project/blob/4523a267829c807f3f=
c8fab8e5e9613985a51565/llvm/lib/CodeGen/SelectionDAG/DAGCombiner.cpp
> >>
> >>       Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> >>       Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 640747b53745..30c551d39329 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -13374,6 +13374,24 @@ static void scalar32_min_max_and(struct bpf_r=
eg_state *dst_reg,
> >>           dst_reg->u32_min_value =3D var32_off.value;
> >>           dst_reg->u32_max_value =3D min(dst_reg->u32_max_value, umax_=
val);
> >>
> >> +       /* Special case: src_reg is known and dst_reg is in range [-1,=
 0] */
> >> +       if (src_known &&
> >> +               dst_reg->s32_min_value =3D=3D -1 && dst_reg->s32_max_v=
alue =3D=3D 0 &&
> >> +               dst_reg->smin_value =3D=3D -1 && dst_reg->smax_value =
=3D=3D 0) {
> >
> > please keep if () condition aligned across multiple lines, it's super
> > confusing this way
> >
>
> OK, will update the align style
>
> >> +               dst_reg->s32_min_value =3D min_t(s32, src_reg->s32_min=
_value, 0);
> >> +               dst_reg->s32_max_value =3D max_t(s32, src_reg->s32_min=
_value, 0);
> >
> > do we need to update tnum parts as well (or reset and re-derive, probab=
ly)?
> >
> > btw, can't we support src being a range here? the idea is that dst_reg
> > either all ones or all zeros. For and it means that it either stays
> > all zero, or will be *exactly equal* to src, right? So I think the
> > logic would be:
> >
> > a) if [s32_min, s32_max] is on the same side of zero, then resulting
> > range would be [min(s32_min, 0), max(s32_max, 0)], just like you have
> > here
> >
> > b) if [s32_min, s32_max] contains zero, then resulting range will be
> > exactly [s32_min, s32_max]
> >
> > Or did I make a mistake above?
> >
>
> Totally agree, the AND of any set with the range [-1,0] is equivalent
> to adding number 0 to the set!
>
> Based on this observation, I've rewritten the patch as follows.
>
> diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> index 3c13240077b8..5e795d728b9f 100644
> --- a/include/linux/tnum.h
> +++ b/include/linux/tnum.h
> @@ -52,6 +52,9 @@ struct tnum tnum_mul(struct tnum a, struct tnum b);
>   /* Return a tnum representing numbers satisfying both @a and @b */
>   struct tnum tnum_intersect(struct tnum a, struct tnum b);
>
> +/* Return a tnum representing numbers satisfying either @a or @b */
> +struct tnum tnum_union(struct tnum a, struct tnum b);
> +
>   /* Return @a with all but the lowest @size bytes cleared */
>   struct tnum tnum_cast(struct tnum a, u8 size);
>
> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index 9dbc31b25e3d..9d4480a683ca 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -150,6 +150,29 @@ struct tnum tnum_intersect(struct tnum a, struct tnu=
m b)
>          return TNUM(v & ~mu, mu);
>   }
>
> +/*
> + * Each bit has 3 states: unkown, known 0, known 1. If using x to repres=
ent
> + * unknown state, the result of the union of two bits is as follows:
> + *
> + *         | x    0    1
> + *    -----+------------
> + *     x   | x    x    x
> + *     0   | x    0    x
> + *     1   | x    x    1
> + *
> + * For tnum a and b, only the bits that are both known 0 or known 1 in a
> + * and b are known in the result of union a and b.
> + */
> +struct tnum tnum_union(struct tnum a, struct tnum b)
> +{
> +       u64 v0, v1, mu;
> +
> +       mu =3D a.mask | b.mask; // unkown bits either in a or b
> +       v1 =3D (a.value & b.value) & ~mu; // "known 1" bits in both a and=
 b
> +       v0 =3D (~a.value & ~b.value) & ~mu; // "known 0" bits in both a a=
nd b

no C++-style comments, please

> +       return TNUM(v1, mu | ~(v0 | v1));
> +}
> +

I've CC'ed Edward, hopefully he can take a look as well. Please CC him
on future patches touching tnum as well.

>   struct tnum tnum_cast(struct tnum a, u8 size)
>   {
>          a.value &=3D (1ULL << (size * 8)) - 1;
>   {
>          a.value &=3D (1ULL << (size * 8)) - 1;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8f0f2e21699e..b69c89bc5cfc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13478,6 +13478,28 @@ static void scalar32_min_max_and(struct bpf_reg_=
state *dst_reg,
>                  return;
>          }
>
> +       /* Special case: dst_reg is in range [-1, 0] */
> +       if (dst_reg->s32_min_value =3D=3D -1 && dst_reg->s32_max_value =
=3D=3D 0) {
> +               var32_off =3D tnum_union(src_reg->var_off, tnum_const(0))=
;
> +               dst_reg->var_off =3D tnum_with_subreg(dst_reg->var_off, v=
ar32_off);
> +               dst_reg->u32_min_value =3D var32_off.value;
> +               dst_reg->u32_max_value =3D min(dst_reg->u32_max_value, um=
ax_val);

can you explain the logic behing u32 min/max updates, especially that
we use completely different values for min/max and it's not clear why
u32_min <=3D u32_max invariant will always hold. Same below

> +               dst_reg->s32_min_value =3D min_t(s32, src_reg->s32_min_va=
lue, 0);
> +               dst_reg->s32_max_value =3D max_t(s32, src_reg->s32_max_va=
lue, 0);
> +               return;
> +       }
> +
> +       /* Special case: src_reg is in range [-1, 0] */
> +       if (src_reg->s32_min_value =3D=3D -1 && src_reg->s32_max_value =
=3D=3D 0) {
> +               var32_off =3D tnum_union(dst_reg->var_off, tnum_const(0))=
;
> +               dst_reg->var_off =3D tnum_with_subreg(dst_reg->var_off, v=
ar32_off);
> +               dst_reg->u32_min_value =3D var32_off.value;
> +               dst_reg->u32_max_value =3D min(dst_reg->u32_max_value, um=
ax_val);
> +               dst_reg->s32_min_value =3D min_t(s32, dst_reg->s32_min_va=
lue, 0);
> +               dst_reg->s32_max_value =3D max_t(s32, dst_reg->s32_max_va=
lue, 0);
> +               return;
> +       }
> +
>          /* We get our minimum from the var_off, since that's inherently
>           * bitwise.  Our maximum is the minimum of the operands' maxima.
>           */
> @@ -13508,6 +13530,26 @@ static void scalar_min_max_and(struct bpf_reg_st=
ate *dst_reg,
>                  return;
>          }
>
> +       /* Special case: dst_reg is in range [-1, 0] */
> +       if (dst_reg->smin_value =3D=3D -1 && dst_reg->smax_value =3D=3D 0=
) {
> +               dst_reg->var_off =3D tnum_union(src_reg->var_off, tnum_co=
nst(0));
> +               dst_reg->umin_value =3D dst_reg->var_off.value;
> +               dst_reg->umax_value =3D min(dst_reg->umax_value, umax_val=
);
> +               dst_reg->smin_value =3D min_t(s64, src_reg->smin_value, 0=
);
> +               dst_reg->smax_value =3D max_t(s64, src_reg->smax_value, 0=
);
> +               return;
> +       }
> +
> +       /* Special case: src_reg is in range [-1, 0] */
> +       if (src_reg->smin_value =3D=3D -1 && src_reg->smax_value =3D=3D 0=
) {
> +               dst_reg->var_off =3D tnum_union(dst_reg->var_off, tnum_co=
nst(0));
> +               dst_reg->umin_value =3D dst_reg->var_off.value;
> +               dst_reg->umax_value =3D min(dst_reg->umax_value, umax_val=
);
> +               dst_reg->smin_value =3D min_t(s64, dst_reg->smin_value, 0=
);
> +               dst_reg->smax_value =3D max_t(s64, dst_reg->smax_value, 0=
);
> +               return;
> +       }
> +
>
> >> +               return;
> >> +       }
> >> +
> >> +       /* Special case: dst_reg is known and src_reg is in range [-1,=
 0] */
> >> +       if (dst_known &&
> >> +               src_reg->s32_min_value =3D=3D -1 && src_reg->s32_max_v=
alue =3D=3D 0 &&
> >> +               src_reg->smin_value =3D=3D -1 && src_reg->smax_value =
=3D=3D 0) {
> >> +               dst_reg->s32_min_value =3D min_t(s32, dst_reg->s32_min=
_value, 0);
> >> +               dst_reg->s32_max_value =3D max_t(s32, dst_reg->s32_min=
_value, 0);
> >> +               return;
> >> +       }
> >> +
> >>           /* Safe to set s32 bounds by casting u32 result into s32 whe=
n u32
> >>            * doesn't cross sign boundary. Otherwise set s32 bounds to =
unbounded.
> >>            */
> >
> > [...]
> >
>

