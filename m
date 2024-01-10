Return-Path: <linux-kselftest+bounces-2812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F59E82A302
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 22:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0536E1F21AAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4104F209;
	Wed, 10 Jan 2024 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKTI+AQy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5DA4F5E8;
	Wed, 10 Jan 2024 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2ac304e526so372863266b.0;
        Wed, 10 Jan 2024 13:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704920688; x=1705525488; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qQ4Q9d03/MIDTc6INiponXcc3ERNzIxbQX3C58OSL9s=;
        b=UKTI+AQyRWXcHGTmsQJHMJdprLYBBHb3no2CNlTYQA7jqYGrCGnIkIoQDi9cuwblvr
         FHtS6rNR89XIQuVaJ/UWnvToz/7wKw4CY1c+Kb22lyatRmQ4i1MKMtyfqkaN3ZEKubI1
         kechCxlchohN0oX6G/Cb3jf4Cu/QvWEUslrwYyGbe6+Ua2pkaaWKaHPuUODt+4zp0AXE
         WygHvgQlKgKQfYsYxc96qkMpiI5n1sXfdbKjneX5+leTZvxTgkYh/H3TEkumcAbb3HnA
         Nf/yWiDxQDBn2GcBOMYgQ5VOt9T+kAfSkohiofKR+nifflNqi3WSrOEKOUc5sOzBvSdx
         KmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704920688; x=1705525488;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ4Q9d03/MIDTc6INiponXcc3ERNzIxbQX3C58OSL9s=;
        b=S18fkY5MBPzDhTKnBDmdQVntRGeIZzUBFQ/Ih/3AmaNSTdmigSrJlM9pCvz1t+YFlf
         h+yOOTUHYbBP1UVBTJHxed2iKe8NTjQ4X7qTNhh1x9tZqRrp2s4cFL36hMUNVFN32w2z
         P6VxG6uXFhW3wrx3GrOL3JFyNGGugPt2YL9qrtNniOIc3mcUDYsEseOyWjMfv/C5Ppja
         ZaECOmnE/BVRMHOgoC+KDl2wymYBfczJ0zoRRJz5L4ajgAucu56rjl0RfIy3+2VJPbA9
         0WjO9okJnHBWxdg36cgvHOVeYTDPq9D7FPy/+7NmB3EbM0FNUG145KMq8dnJpm3SIt94
         g7Zg==
X-Gm-Message-State: AOJu0YzrsEs9F6sIwPd0xE/w8kW+LQo9667euJlUlT7Vs5e21nN/m3WJ
	KrswCUsBJUK0mMYRRq28R6Q=
X-Google-Smtp-Source: AGHT+IErhAjR4Z9MADvpgax5/fCS/NkdCek08c10zmCNkSqape+zUMQY8aNLIVMn9cbPMxxDGZvkTw==
X-Received: by 2002:a17:906:7cd4:b0:a27:5343:d3e8 with SMTP id h20-20020a1709067cd400b00a275343d3e8mr58837ejp.97.1704920687560;
        Wed, 10 Jan 2024 13:04:47 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y19-20020a17090668d300b00a27a7fa8691sm2451725ejr.137.2024.01.10.13.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 13:04:46 -0800 (PST)
Message-ID: <bf909ed6b01224e03f0b2770f041f5b3ecb4b218.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 14/15] bpf: Optimize state pruning for
 spilled scalars
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Maxim Mikityanskiy
	 <maxtram95@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>, John Fastabend <john.fastabend@gmail.com>,  Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org
Date: Wed, 10 Jan 2024 23:04:39 +0200
In-Reply-To: <CAEf4BzYizLHHYPg0yKu-no3toMLS3wSyA2V_wtnHAyn6Burofg@mail.gmail.com>
References: <20240108205209.838365-1-maxtram95@gmail.com>
	 <20240108205209.838365-15-maxtram95@gmail.com>
	 <CAEf4BzYizLHHYPg0yKu-no3toMLS3wSyA2V_wtnHAyn6Burofg@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-09 at 16:22 -0800, Andrii Nakryiko wrote:
[...]
> >  static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_st=
ate *old,
> >                       struct bpf_func_state *cur, struct bpf_idmap *idm=
ap, bool exact)
> >  {
> > +       struct bpf_reg_state unbound_reg =3D {};
> > +       struct bpf_reg_state zero_reg =3D {};
> >         int i, spi;
> >=20
> > +       __mark_reg_unknown(env, &unbound_reg);
> > +       __mark_reg_const_zero(env, &zero_reg);
> > +       zero_reg.precise =3D true;
>=20
> these are immutable, right? Would it make sense to set them up just
> once as static variables instead of initializing on each check?

Should be possible.

> > +
> >         /* walk slots of the explored stack and ignore any additional
> >          * slots in the current stack, since explored(safe) state
> >          * didn't use them
> > @@ -16484,6 +16524,49 @@ static bool stacksafe(struct bpf_verifier_env =
*env, struct bpf_func_state *old,
> >                         continue;
> >                 }
> >=20
>=20
> we didn't check that cur->stack[spi] is ok to access yet, it's done a
> bit later with `if (i >=3D cur->allocated_stack)`, if I'm not mistaken.
> So these checks would need to be moved a bit lower, probably.

Right. And it seems the issue is already present:

		if (exact &&
		    old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D
		    cur->stack[spi].slot_type[i % BPF_REG_SIZE])
			return false;

This is currently executed before `if (i >=3D cur->allocated_stack)` check =
as well.
Introduced by another commit of mine :(

> > +               /* load of stack value with all MISC and ZERO slots pro=
duces unbounded
> > +                * scalar value, call regsafe to ensure scalar ids are =
compared.
> > +                */
> > +               if (is_spilled_unbound_scalar_reg64(&old->stack[spi]) &=
&
> > +                   is_stack_unbound_slot64(env, &cur->stack[spi])) {
> > +                       i +=3D BPF_REG_SIZE - 1;
> > +                       if (!regsafe(env, &old->stack[spi].spilled_ptr,=
 &unbound_reg,
> > +                                    idmap, exact))
> > +                               return false;
> > +                       continue;
> > +               }
> > +
> > +               if (is_stack_unbound_slot64(env, &old->stack[spi]) &&
> > +                   is_spilled_unbound_scalar_reg64(&cur->stack[spi])) =
{
> > +                       i +=3D BPF_REG_SIZE - 1;
> > +                       if (!regsafe(env,  &unbound_reg, &cur->stack[sp=
i].spilled_ptr,
> > +                                    idmap, exact))
> > +                               return false;
> > +                       continue;
> > +               }
>=20
> scalar_old =3D scalar_cur =3D NULL;
> if (is_spilled_unbound64(&old->..))
>     scalar_old =3D old->stack[spi].slot_type[0] =3D=3D STACK_SPILL ?
> &old->stack[spi].spilled_ptr : &unbound_reg;
> if (is_spilled_unbound64(&cur->..))
>     scalar_cur =3D cur->stack[spi].slot_type[0] =3D=3D STACK_SPILL ?
> &cur->stack[spi].spilled_ptr : &unbound_reg;
> if (scalar_old && scalar_cur) {
>     if (!regsafe(env, scalar_old, scalar_new, idmap, exact)
>         return false;
>     i +=3D BPF_REG_SIZE - 1;
>     continue;
> }

Ok, I'll switch to this.
(Although, I think old variant is a bit simpler to follow).

> where is_spilled_unbound64() would be basically `return
> is_spilled_unbound_scalar_reg64(&old->..) ||
> is_stack_unbound_slot64(&old->...)`;
>=20
> Similarly for zero case? Though I'm wondering if zero case should be
> checked first, as it's actually a subset of is_spilled_unbound64 when
> it comes to STACK_ZERO/STACK_MISC mixes, no?

Yes, makes sense.

[...]

