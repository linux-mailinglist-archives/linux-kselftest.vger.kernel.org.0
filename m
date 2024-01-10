Return-Path: <linux-kselftest+bounces-2815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BCD82A38D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 22:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DF528973E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 21:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F7A4F886;
	Wed, 10 Jan 2024 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmkZGwI9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C524F883;
	Wed, 10 Jan 2024 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5578485fc0eso3697430a12.1;
        Wed, 10 Jan 2024 13:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704923545; x=1705528345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPanO/SqIYc4Q6eykHNme3WnMQup3s9zl6+bSP5wmLg=;
        b=nmkZGwI9Zh+lv8INMcwRVfV5cVSIClhY32atPnnNsIgEhj+Z+IxIo47Y36xPCngAPF
         AGF6x3AObn2oIehTgBhpjAa9zlM4LrJPY9nJKl/2WS9nqTwdY2NI9R7xJgSfQZhSjjcN
         Edd3LLz9PVk866PNQcUti1i/DounqAiRbGKbVI1wg3o7Fsji+ujRmZZV9XGPK0MmabWZ
         Qkl/Re3ZQvZmNCCMQb4ILZMdveVoE3GJeenIKyIFzTHORcDAUPyHKgT6Ajbx7UqYuV7x
         JMJ0sSM7oEchNt+AsiIbE+zlvyjgTPZ5Jwn842yXnlakmXnGFlT3oflvhY7NpgbUWON9
         1Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704923545; x=1705528345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPanO/SqIYc4Q6eykHNme3WnMQup3s9zl6+bSP5wmLg=;
        b=LmbodJT4IL9fYJauRUU2wHXBugCrqCB7HuHCmYzPgl56xHLYMx3T3G5TnWmV4bHN7J
         y06pcjEy1fnji/vDOhmLlE2zBMNPYGsmh4fH76cAKNQ97Iehs3db9nQHUpHaYHED8D7f
         XDMq53a3Trzljp3K8YfeqHFD5tdTrdoQVt1n3dRSqRGEKp4Oud7/sykbFEQF6MZebEas
         Xo/HvCKSI3JGB8TIVFy/r6p9Uzn7GB7ciWV+wHepGbPktBlYMcYZAaKN9yjfkfmulYHv
         ZVxbZZcRkzG8iFj0mr8ckzBVx0qLiuwTlSCws+Dd9kduIOd/3KBMj/nQQnurrY0jdDGa
         lYDA==
X-Gm-Message-State: AOJu0Yxn05JFDveO2y9ENGZBJ6VLnCWYrfDPj7aOlZCwY5dutmI4QWPO
	9JWrtIIBf0UEJZZGGi6sbxKVTeP68lVkNjuptZM=
X-Google-Smtp-Source: AGHT+IFz/cbzXiMwKfN1LO/rrM07hdScb89Zn3ZtGJ42uaFbatOGS5BcAqOOfFnp9R4hIwiKE8k1YAHTWxCLNrCuqRc=
X-Received: by 2002:aa7:c954:0:b0:557:ed8b:c606 with SMTP id
 h20-20020aa7c954000000b00557ed8bc606mr65860edt.23.1704923544651; Wed, 10 Jan
 2024 13:52:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108205209.838365-1-maxtram95@gmail.com> <20240108205209.838365-15-maxtram95@gmail.com>
 <CAEf4BzYizLHHYPg0yKu-no3toMLS3wSyA2V_wtnHAyn6Burofg@mail.gmail.com> <bf909ed6b01224e03f0b2770f041f5b3ecb4b218.camel@gmail.com>
In-Reply-To: <bf909ed6b01224e03f0b2770f041f5b3ecb4b218.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jan 2024 13:52:12 -0800
Message-ID: <CAEf4BzaKS_f9uOorcCbsoui9KNRA0HxX8=A+9sNAq+1mJoy-kg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 14/15] bpf: Optimize state pruning for spilled scalars
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Maxim Mikityanskiy <maxtram95@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 1:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-01-09 at 16:22 -0800, Andrii Nakryiko wrote:
> [...]
> > >  static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_=
state *old,
> > >                       struct bpf_func_state *cur, struct bpf_idmap *i=
dmap, bool exact)
> > >  {
> > > +       struct bpf_reg_state unbound_reg =3D {};
> > > +       struct bpf_reg_state zero_reg =3D {};
> > >         int i, spi;
> > >
> > > +       __mark_reg_unknown(env, &unbound_reg);
> > > +       __mark_reg_const_zero(env, &zero_reg);
> > > +       zero_reg.precise =3D true;
> >
> > these are immutable, right? Would it make sense to set them up just
> > once as static variables instead of initializing on each check?
>
> Should be possible.
>
> > > +
> > >         /* walk slots of the explored stack and ignore any additional
> > >          * slots in the current stack, since explored(safe) state
> > >          * didn't use them
> > > @@ -16484,6 +16524,49 @@ static bool stacksafe(struct bpf_verifier_en=
v *env, struct bpf_func_state *old,
> > >                         continue;
> > >                 }
> > >
> >
> > we didn't check that cur->stack[spi] is ok to access yet, it's done a
> > bit later with `if (i >=3D cur->allocated_stack)`, if I'm not mistaken.
> > So these checks would need to be moved a bit lower, probably.
>
> Right. And it seems the issue is already present:
>
>                 if (exact &&
>                     old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D
>                     cur->stack[spi].slot_type[i % BPF_REG_SIZE])
>                         return false;
>
> This is currently executed before `if (i >=3D cur->allocated_stack)` chec=
k as well.
> Introduced by another commit of mine :(

I guess we'll need to move that too, then

>
> > > +               /* load of stack value with all MISC and ZERO slots p=
roduces unbounded
> > > +                * scalar value, call regsafe to ensure scalar ids ar=
e compared.
> > > +                */
> > > +               if (is_spilled_unbound_scalar_reg64(&old->stack[spi])=
 &&
> > > +                   is_stack_unbound_slot64(env, &cur->stack[spi])) {
> > > +                       i +=3D BPF_REG_SIZE - 1;
> > > +                       if (!regsafe(env, &old->stack[spi].spilled_pt=
r, &unbound_reg,
> > > +                                    idmap, exact))
> > > +                               return false;
> > > +                       continue;
> > > +               }
> > > +
> > > +               if (is_stack_unbound_slot64(env, &old->stack[spi]) &&
> > > +                   is_spilled_unbound_scalar_reg64(&cur->stack[spi])=
) {
> > > +                       i +=3D BPF_REG_SIZE - 1;
> > > +                       if (!regsafe(env,  &unbound_reg, &cur->stack[=
spi].spilled_ptr,
> > > +                                    idmap, exact))
> > > +                               return false;
> > > +                       continue;
> > > +               }
> >
> > scalar_old =3D scalar_cur =3D NULL;
> > if (is_spilled_unbound64(&old->..))
> >     scalar_old =3D old->stack[spi].slot_type[0] =3D=3D STACK_SPILL ?
> > &old->stack[spi].spilled_ptr : &unbound_reg;
> > if (is_spilled_unbound64(&cur->..))
> >     scalar_cur =3D cur->stack[spi].slot_type[0] =3D=3D STACK_SPILL ?
> > &cur->stack[spi].spilled_ptr : &unbound_reg;
> > if (scalar_old && scalar_cur) {
> >     if (!regsafe(env, scalar_old, scalar_new, idmap, exact)
> >         return false;
> >     i +=3D BPF_REG_SIZE - 1;
> >     continue;
> > }
>
> Ok, I'll switch to this.
> (Although, I think old variant is a bit simpler to follow).

my goal was to eliminate duplicated logic inside each if and kind of
showing at high level that we are comparing two "logically unbound
scalars", regardless of whether that's STACK_xxx mix or spilled
scalar.

I haven't thought this through, but if we can simplify further to
something like this:

if (is_spilled_unbound64(old) && is_spilled_unbound64(cur)) {
  scalar_cur =3D ...
  scalar_old =3D ...
  if (!regsafe(...))
    return false;
  i +=3D BPF_REG_SIZE - 1;
}

In general, this symmetry in two consecutive if conditions seems like
an opportunity to simplify. But if you think it's more complicated,
I'm fine with leaving it as is.

>
> > where is_spilled_unbound64() would be basically `return
> > is_spilled_unbound_scalar_reg64(&old->..) ||
> > is_stack_unbound_slot64(&old->...)`;
> >
> > Similarly for zero case? Though I'm wondering if zero case should be
> > checked first, as it's actually a subset of is_spilled_unbound64 when
> > it comes to STACK_ZERO/STACK_MISC mixes, no?
>
> Yes, makes sense.
>
> [...]

