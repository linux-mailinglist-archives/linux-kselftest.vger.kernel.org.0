Return-Path: <linux-kselftest+bounces-8942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A188B40E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 22:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDC42847A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 20:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F61428DBF;
	Fri, 26 Apr 2024 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRnIw8JB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32721DA58;
	Fri, 26 Apr 2024 20:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714163812; cv=none; b=mJjFOO8Cg8iYGZB2QwcvEkZWYvUOA6ihDrW4Ct7CNB0MTHeBa2cK18Ng4aZGTZvUA2Fihy6y7kBs3Gw3LMnCqbRJ1MkJhrAEivP1/wUHiDFKh1K5WD6XIEDuJe4e4vgWwgjabV8k9/Vkx6aEEQ0ZarnbMPmDxRKXmNsE8jGohpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714163812; c=relaxed/simple;
	bh=X8IErIlC2m8QN3nFTKDGCDU/pWgUuLgMypcotYSZXJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1kIhIGsWwPg5gUjHHXRTKLzKGu2zUXT/0OhVb0i0X4jZYX4prC39xNWCR5s8VOl3Ng3lMR6ew+z7+UShq6r9y0WBc/G0wCIKZWH1F22Hjf0nodH67ReV6DQCMxbnOLJJ3Rc57azXpvMaaAjVJ9saqSrnVbUn0C3Ach56/u96S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRnIw8JB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a78c2e253aso2104640a91.3;
        Fri, 26 Apr 2024 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714163810; x=1714768610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jn4qUqHJg9xwcPhzuWdeSDaiqF+y2jS4tFoSLpKXrGk=;
        b=hRnIw8JBTxq3oN1ImdsV+AS/AlzAwy6Z7WwxG72Hn0bnhTgCt0BkSe3hvvhmXq7JZe
         HKo36le8JDzr5JVMENKnCuUhs57mnfR/38/rLYTDPTg9je8RCsnKB9CeaHGbJ1t3Mdyb
         Wi17fM0/iktOU3g4w93nw/FFNPO6KskN7y2lH9He1Gj195NSm+nzvA9/qFO3UFgLovdV
         qUsNDECnN2meHHQMVkyRzmQ/j4jUXJkEzHBpNn0iiG6IyYD8lHciAGQJ0M6/98+ze3vd
         hKPVJYJs6ZxbgT4HEoicjs+O7r9NQOhTMbafNoUfhSM9DzInES7rxqxl0Mm5ql5nYWuC
         /tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714163810; x=1714768610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jn4qUqHJg9xwcPhzuWdeSDaiqF+y2jS4tFoSLpKXrGk=;
        b=Aq3t9sc+t9Kkd4IcSlq8ee+HARhc2N5gXd5i5BRQ8GenYil7X5Enbh0bmz3ArIziuD
         uVgdpqvhZeR5m3YyJJgeEG8W68lfpnbmN+XeU9CYuuy63QpYYUo9YnFcvSPW9SspQMAH
         Myv1yb+1yiCYkS8Gl4P3zKiNVL0lAcByoW1UCwvH8n/2+jPooOfYg5ZV9oVwUAOTksr1
         TCa7EypyCWYI2OJDhaalMkE8fvu5ym/kzGmXBp1nvJ86bHh0vuWfXRJ6pGsIwA0MkJOe
         sLQzb2FWpwyJUhwXTfv8V7pBFQ2xrCEqaUoRtTfzkIs9UHWhrcB8asUP/MZJOW8T7JXq
         Ht6w==
X-Forwarded-Encrypted: i=1; AJvYcCX94RSG8/cWH2OM47mbypCXC6pUierq7dqyEcG0ig6Na79MWuQLVIoReOPhWRMD+6GpK79c0kWFHfjlRFoTSS35AXXHTVPGEzwXqOv6fkMCqdXn/nJ0pLYqp1DrYf6ZgkWLZUUi7A5rbQ95EYTFa93ZX4bc3vnrI6htEctixhDXpw7u4fW3Gg8d1BNSSJcnop0k8bP+HZwrQ6tfrpoISz6IBmXd
X-Gm-Message-State: AOJu0YxMBZXXOKqCeB72UU4968F9LTGCQeVuVRYLMev/kFiHeakM/N7e
	nKb8gwjlKyRYlg3iQmEK4LVwr4y+xnN5n87FwYXiE06lZqVu/4BbOkEogMwUBoMS89NiwF/2oxq
	D1EwzrLLRQAWHUPfkB/DHp5N7KKg=
X-Google-Smtp-Source: AGHT+IER4EmdCyyG0qZAtgXO6o5b8tyvfs+DdJNSbmswQkHsMgeOmonX/SvLE5epcCY5xpdPz2tiPS2vzdHRbh8fi44=
X-Received: by 2002:a17:90a:b317:b0:2a2:227a:50fc with SMTP id
 d23-20020a17090ab31700b002a2227a50fcmr3507983pjr.41.1714163809972; Fri, 26
 Apr 2024 13:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
 <20240411122752.2873562-8-xukuohai@huaweicloud.com> <e62e2971301ca7f2e9eb74fc500c520285cad8f5.camel@gmail.com>
 <f80991aa-3a49-451a-9a82-ac57982dcb28@huaweicloud.com> <bdc84c6c-7415-4b84-a883-1988cb5f77d1@linux.dev>
 <576c7c44-d1b4-42c8-8b6e-2e6b93d7547a@huaweicloud.com>
In-Reply-To: <576c7c44-d1b4-42c8-8b6e-2e6b93d7547a@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 13:36:37 -0700
Message-ID: <CAEf4BzZTzftrOCFsfBd81sHDBpmNK+4Jefqa3SSS6NiuncO0tQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 07/11] bpf: Fix a false rejection caused by
 AND operation
To: Xu Kuohai <xukuohai@huaweicloud.com>
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

On Tue, Apr 23, 2024 at 7:26=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 4/24/2024 5:55 AM, Yonghong Song wrote:
> >
> > On 4/20/24 1:33 AM, Xu Kuohai wrote:
> >> On 4/20/2024 7:00 AM, Eduard Zingerman wrote:
> >>> On Thu, 2024-04-11 at 20:27 +0800, Xu Kuohai wrote:
> >>>> From: Xu Kuohai <xukuohai@huawei.com>
> >>>>
> >>>> With lsm return value check, the no-alu32 version test_libbpf_get_fd=
_by_id_opts
> >>>> is rejected by the verifier, and the log says:
> >>>>
> >>>>    0: R1=3Dctx() R10=3Dfp0
> >>>>    ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) =
@ test_libbpf_get_fd_by_id_opts.c:27
> >>>>    0: (b7) r0 =3D 0                        ; R0_w=3D0
> >>>>    1: (79) r2 =3D *(u64 *)(r1 +0)
> >>>>    func 'bpf_lsm_bpf_map' arg0 has btf_id 916 type STRUCT 'bpf_map'
> >>>>    2: R1=3Dctx() R2_w=3Dtrusted_ptr_bpf_map()
> >>>>    ; if (map !=3D (struct bpf_map *)&data_input) @ test_libbpf_get_f=
d_by_id_opts.c:29
> >>>>    2: (18) r3 =3D 0xffff9742c0951a00       ; R3_w=3Dmap_ptr(map=3Dda=
ta_input,ks=3D4,vs=3D4)
> >>>>    4: (5d) if r2 !=3D r3 goto pc+4         ; R2_w=3Dtrusted_ptr_bpf_=
map() R3_w=3Dmap_ptr(map=3Ddata_input,ks=3D4,vs=3D4)
> >>>>    ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) =
@ test_libbpf_get_fd_by_id_opts.c:27
> >>>>    5: (79) r0 =3D *(u64 *)(r1 +8)          ; R0_w=3Dscalar() R1=3Dct=
x()
> >>>>    ; if (fmode & FMODE_WRITE) @ test_libbpf_get_fd_by_id_opts.c:32
> >>>>    6: (67) r0 <<=3D 62                     ; R0_w=3Dscalar(smax=3D0x=
4000000000000000,umax=3D0xc000000000000000,smin32=3D0,smax32=3Dumax32=3D0,v=
ar_off=3D(0x0; 0xc000000000000000))
> >>>>    7: (c7) r0 s>>=3D 63                    ; R0_w=3Dscalar(smin=3Dsm=
in32=3D-1,smax=3Dsmax32=3D0)
> >>>>    ;  @ test_libbpf_get_fd_by_id_opts.c:0
> >>>>    8: (57) r0 &=3D -13                     ; R0_w=3Dscalar(smax=3D0x=
7ffffffffffffff3,umax=3D0xfffffffffffffff3,smax32=3D0x7ffffff3,umax32=3D0xf=
ffffff3,var_off=3D(0x0; 0xfffffffffffffff3))
> >>>>    ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) =
@ test_libbpf_get_fd_by_id_opts.c:27
> >>>>    9: (95) exit

[...]

>
>      As suggested by Eduard, this patch makes a special case for source
>      or destination register of '&=3D' operation being in range [-1, 0].
>
>      Meaning that one of the '&=3D' operands is either:
>      - all ones, in which case the counterpart is the result of the opera=
tion;
>      - all zeros, in which case zero is the result of the operation.
>
>      And MIN and MAX values could be derived based on above two observati=
ons.
>
>      [0] https://lore.kernel.org/bpf/e62e2971301ca7f2e9eb74fc500c520285ca=
d8f5.camel@gmail.com/
>      [1] https://github.com/llvm/llvm-project/blob/4523a267829c807f3fc8fa=
b8e5e9613985a51565/llvm/lib/CodeGen/SelectionDAG/DAGCombiner.cpp
>
>      Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
>      Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 640747b53745..30c551d39329 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13374,6 +13374,24 @@ static void scalar32_min_max_and(struct bpf_reg_=
state *dst_reg,
>          dst_reg->u32_min_value =3D var32_off.value;
>          dst_reg->u32_max_value =3D min(dst_reg->u32_max_value, umax_val)=
;
>
> +       /* Special case: src_reg is known and dst_reg is in range [-1, 0]=
 */
> +       if (src_known &&
> +               dst_reg->s32_min_value =3D=3D -1 && dst_reg->s32_max_valu=
e =3D=3D 0 &&
> +               dst_reg->smin_value =3D=3D -1 && dst_reg->smax_value =3D=
=3D 0) {

please keep if () condition aligned across multiple lines, it's super
confusing this way

> +               dst_reg->s32_min_value =3D min_t(s32, src_reg->s32_min_va=
lue, 0);
> +               dst_reg->s32_max_value =3D max_t(s32, src_reg->s32_min_va=
lue, 0);

do we need to update tnum parts as well (or reset and re-derive, probably)?

btw, can't we support src being a range here? the idea is that dst_reg
either all ones or all zeros. For and it means that it either stays
all zero, or will be *exactly equal* to src, right? So I think the
logic would be:

a) if [s32_min, s32_max] is on the same side of zero, then resulting
range would be [min(s32_min, 0), max(s32_max, 0)], just like you have
here

b) if [s32_min, s32_max] contains zero, then resulting range will be
exactly [s32_min, s32_max]

Or did I make a mistake above?

> +               return;
> +       }
> +
> +       /* Special case: dst_reg is known and src_reg is in range [-1, 0]=
 */
> +       if (dst_known &&
> +               src_reg->s32_min_value =3D=3D -1 && src_reg->s32_max_valu=
e =3D=3D 0 &&
> +               src_reg->smin_value =3D=3D -1 && src_reg->smax_value =3D=
=3D 0) {
> +               dst_reg->s32_min_value =3D min_t(s32, dst_reg->s32_min_va=
lue, 0);
> +               dst_reg->s32_max_value =3D max_t(s32, dst_reg->s32_min_va=
lue, 0);
> +               return;
> +       }
> +
>          /* Safe to set s32 bounds by casting u32 result into s32 when u3=
2
>           * doesn't cross sign boundary. Otherwise set s32 bounds to unbo=
unded.
>           */

[...]

