Return-Path: <linux-kselftest+bounces-2420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADEB81E272
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Dec 2023 22:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8101C20ECC
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Dec 2023 21:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CE453E11;
	Mon, 25 Dec 2023 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOrTPZM/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E99553E08;
	Mon, 25 Dec 2023 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33687627ad0so3847117f8f.2;
        Mon, 25 Dec 2023 13:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703539608; x=1704144408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+L51mB2csaR9UkZde3kUlSEYRY06OW9hRSr1rL2Ttcg=;
        b=NOrTPZM/Ix2/IaGhfDKgqovuKmGFyYCWNAwrSuSZGlyrBvB5jsC0yjvTUnIQmQRtFW
         Jj24xg8/ObAU0jF29sz6PxRFFQNKu3IOlfttbYVzPKxyG7zHsx2JV05+YU7h7J3H3z4m
         2JMatVuIDQzyUSU3WU5ix2KWiRSN+/kIPE9Rq0LEB/LaqILgBHgTYXeYFbV2g9Qly1Z/
         y16YzvQWB0qVNSiiiYopCBRDg5Qu0dIQ+PrOp7K10GR4zvAjNk9RksbfdrQQ1yiWz3wA
         loKUhvZrDj81+PeAq80AUdu1FGaQrBu1rdwHMEqDcAgq7784nc14ZhXPK0VNEptFMaNQ
         MCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703539608; x=1704144408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+L51mB2csaR9UkZde3kUlSEYRY06OW9hRSr1rL2Ttcg=;
        b=BDeHwcw9MXtvTUMZYErWH/3jo7m4ySqlZMHJ0wqLDu6cWYugjR+pDcvsu5oWqOqk4K
         E7J3CHgpXmkaIPvSrCUNcb0Skb171vBfFWyhodHrbGGUCNIb2tOoZyX4vQOoUol9K/zi
         h89MQiQoQK7EzDmS7H6N7lswTUgK+VonT0q7v39bldBACuNk/Vv/+yRcp7Ifitilqy3g
         deSjMXl4Z8n5kb6GIuc7DemoqRAAo3Q42mKg/zvmBCGZpCMFS/RJBDxBqw6Evf3ywpSz
         xRK532HvYYudyJXS8VyU7GSTdRwTE9tefcWlYsatlL6W9D4FLOpX8rgPHj0Zy34anoK2
         fXIQ==
X-Gm-Message-State: AOJu0YzM+zmwRJLVaSD2ZI7xxvjFg1zWhrxtGNE3J2uieTH6kyDpoB/4
	b+hoi4jrjtl/dLdq2nKVYA6gi2v/xhoTzT2SBV0=
X-Google-Smtp-Source: AGHT+IGlubB1jbgFPApkUs7San55vfeFBs7qnGCKBWc4Pe0A3rVF9xq8ojAyBtBAvcOcmCT14AVLQWoEAiC2LSZoLCU=
X-Received: by 2002:a05:6000:2c6:b0:336:cc50:7907 with SMTP id
 o6-20020a05600002c600b00336cc507907mr869140wry.27.1703539607889; Mon, 25 Dec
 2023 13:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220214013.3327288-1-maxtram95@gmail.com> <20231220214013.3327288-9-maxtram95@gmail.com>
 <CAADnVQ+6MjSLRq5hFy=kHosoWR=RDOSuU1znCrkcRp-WeD5CMw@mail.gmail.com> <ZYnwAt941SOohbzx@mail.gmail.com>
In-Reply-To: <ZYnwAt941SOohbzx@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Dec 2023 13:26:36 -0800
Message-ID: <CAADnVQLOn5yeupGdOCGD=Xqj=3S+9Sm4zXYcVZnjf-+6MKbYDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 08/15] bpf: Assign ID to scalars on spill
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Maxim Mikityanskiy <maxim@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 1:11=E2=80=AFPM Maxim Mikityanskiy <maxtram95@gmail=
.com> wrote:
>
> On Sun, 24 Dec 2023 at 19:15:42 -0800, Alexei Starovoitov wrote:
> > On Wed, Dec 20, 2023 at 1:40=E2=80=AFPM Maxim Mikityanskiy <maxtram95@g=
mail.com> wrote:
> > >
> > > From: Maxim Mikityanskiy <maxim@isovalent.com>
> > >
> > > Currently, when a scalar bounded register is spilled to the stack, it=
s
> > > ID is preserved, but only if was already assigned, i.e. if this regis=
ter
> > > was MOVed before.
> > >
> > > Assign an ID on spill if none is set, so that equal scalars could be
> > > tracked if a register is spilled to the stack and filled into another
> > > register.
> > >
> > > One test is adjusted to reflect the change in register IDs.
> > >
> > > Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> > > ---
> > >  kernel/bpf/verifier.c                                     | 8 ++++++=
+-
> > >  .../selftests/bpf/progs/verifier_direct_packet_access.c   | 2 +-
> > >  2 files changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index b757fdbbbdd2..caa768f1e369 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -4503,9 +4503,15 @@ static int check_stack_write_fixed_off(struct =
bpf_verifier_env *env,
> > >
> > >         mark_stack_slot_scratched(env, spi);
> > >         if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) =
&& env->bpf_capable) {
> > > +               bool reg_value_fits;
> > > +
> > > +               reg_value_fits =3D get_reg_width(reg) <=3D BITS_PER_B=
YTE * size;
> > > +               /* Make sure that reg had an ID to build a relation o=
n spill. */
> > > +               if (reg_value_fits)
> > > +                       assign_scalar_id_before_mov(env, reg);
> >
> > Thanks.
> > I just debugged this issue as part of my bpf_cmp series.
> >
> > llvm generated:
> >
> > 1093: (7b) *(u64 *)(r10 -96) =3D r0     ;
> > R0_w=3Dscalar(smin=3Dsmin32=3D-4095,smax=3Dsmax32=3D256) R10=3Dfp0
> > fp-96_w=3Dscalar(smin=3Dsmin32=3D-4095,smax=3Dsmax32=3D256)
> > ; if (bpf_cmp(filepart_length, >, MAX_PATH))
> > 1094: (25) if r0 > 0x100 goto pc+903          ;
> > R0_w=3Dscalar(id=3D53,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=
=3D256,var_off=3D(0x0;
> > 0x1ff))
> >
> > the verifier refined the range of 'r0' here,
> > but the code just read spilled value from stack:
> >
> > 1116: (79) r1 =3D *(u64 *)(r10 -64)     ; R1_w=3Dmap_value
> > ; payload +=3D filepart_length;
> > 1117: (79) r2 =3D *(u64 *)(r10 -96)     ;
> > R2_w=3Dscalar(smin=3Dsmin32=3D-4095,smax=3Dsmax32=3D256) R10=3Dfp0
> > fp-96=3Dscalar(smin=3Dsmin32=3D-4095,smax=3Dsmax32=3D256)
> > 1118: (0f) r1 +=3D r2 ;
> > R1_w=3Dmap_value(map=3Ddata_heap,ks=3D4,vs=3D23040,off=3D148,smin=3Dsmi=
n32=3D-4095,smax=3Dsmax32=3D3344)
> >
> > And later errors as:
> > "R1 min value is negative, either use unsigned index or do a if (index
> > >=3D0) check."
> >
> > This verifier improvement is certainly necessary.
>
> Glad that you found it useful!
>
> > Since you've analyzed this issue did you figure out a workaround
> > for C code on existing and older kernels?
>
> Uhm... in my case (Cilium, it was a while ago) I did some big change
> (reorganized function calls and revalidate_data() calls) that changed
> codegen significantly, and the problematic pattern disappeared.
>
> I can suggest trying to play with volatile, e.g., declare
> filepart_length as volatile; if it doesn't help, create another volatile
> variable and copy filepart_length to it before doing bpf_cmp (copying
> reg->reg will assign an ID, but I'm not sure if they'll still be in
> registers after being declared as volatile).
>
> Unfortunately, I couldn't reproduce your issue locally, so I couldn't
> try these suggestions myself.

No worries.

> What LLVM version do you see the issue on? I can try to look for a
> specific C workaround if I reproduce it locally.
>
> BTW, the asm workaround is obvious (copy reg to another reg to assign an
> ID), so maybe an inline asm like this would do the thing?
>
> asm volatile("r8 =3D %0" :: "r"(filepart_length) : "r8");

Right. I tried:
asm volatile("%[reg]=3D%[reg]"::[reg]"r"((short)filepart_length));

and it forces ID assignment, but depending on the code it might still be
too late.
I've seen the pattern:
call ...
*(u64 *)(r10 -96) =3D r0
r0 =3D r0 // asm trick above
if r0 > 0x100 goto pc+903

So it may or may not help, but it was good to understand this issue.

