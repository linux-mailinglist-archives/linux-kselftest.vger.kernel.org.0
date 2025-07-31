Return-Path: <linux-kselftest+bounces-38114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E57B17515
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 18:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA3C3BB2E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 16:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98F023CEFF;
	Thu, 31 Jul 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEY2Uz3p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE723BCEB;
	Thu, 31 Jul 2025 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980101; cv=none; b=jY/VgGkigumQf6cT5mEiZss2FLNqoknkk89eb/MJ4QSascR8xysWXjkVjQGrS44RzdbkwAmbFqzA1ireuwDyitT78dMX9YLCb5bhIu9OWevEe7XHoMG3TP12VSA2a9oZg/DQn70697osDxl7GVo9zoJ8DxSoLZa43Q9p3iKPjFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980101; c=relaxed/simple;
	bh=FOn/6rSOFrcvFlub8uI3wyAurRPAFWyHtW66MMdoEnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXtpzm9mM/ZDzcLAsB+IfL3XZ9TJ1qsmBH3ohf5leepRGi3sl1ONJ90E4gZMhWZFbLlEzY73hcUPEurxV17e2HDys50MtvKqpeQCM0HjKa/RHuyE9/rSnkxpEuaJxvtQF15nXj8mTb826xgIvevAPjM7zP+Ou8etKXFpFDFiiNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEY2Uz3p; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so10809795e9.3;
        Thu, 31 Jul 2025 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753980098; x=1754584898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xsu6ObGdZ62l8P/qwUGJQLtAjhbxoXSmlIgJ/7hyZRU=;
        b=kEY2Uz3pVoapjD4YJJrkPwogcO+4fxuB5IqT+mfSwaOP11pYN4Ba/eFbwtVr+l5QlQ
         bTYfLt6gHitGsN2UPf6PCXql1uQw6gLwJjrb5DA5WUiEp2CX1KWJwVXKpwTUBAj1e/FA
         J+nt923sbDoLRdm7V+WWrPrWZCnQwopjQpWOko9BPkGfpVNwo3LINmFdh7PPG7bOHmvR
         G2VfxdZMrziTypJXMDLWOgt0AoO3rxy9gAOQBzjgZHUv35K5eYCTM/afFTvymjHMzbix
         EwU/admIy6YCGr/bSsIC00teeEbu5XxNFvBhq2IK0zK50348qCkawWt+Rzhdy7VAUY4g
         AyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753980098; x=1754584898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xsu6ObGdZ62l8P/qwUGJQLtAjhbxoXSmlIgJ/7hyZRU=;
        b=F0ejwvQWVwk+3aBagI4AcUd9UNgP5p5uuiRcNrWphLvUwNs764zLjvUPtT8OpgX3Di
         0gvFdUC2NSHJX2Yi5OLqKu6h2dArZ/l4HGnuiyyzHXKqdua6qp7WbQ1qtZKtJIu68g8Z
         H/bUavib3wxeL2PUVGw3N6GANg5aqobDPc5MOHP8BeiJadxVCnpf1bjIkylE3bXU8CLJ
         uTXVe0RAIA3YzgxjhBpxPzBh26uvxMd44q1a0VXY7ZvbS7+PlprPm6akQzKBnP3nD2bG
         agKig/jX5KdbTG0fF9tK2u51IhEtQs1R7qhuZLI/m8mmRJEWYQg3mL2tZ4ctDgFJGJ75
         FftA==
X-Forwarded-Encrypted: i=1; AJvYcCWJlBBdrnVjLxuVtyo89cQh19w++3NkkLyXIruY+wS2mUPwlBrIJYDL04632uuYvrccx9tyHQVTwbiQUD2F@vger.kernel.org, AJvYcCWgmg7S8gubYy713E066aHIDmSOccS1L4gAhfSjZRHHJLKdrqPw35QTSH8CtTTV3xODLaXdxTYN9XVKSxKEMZx6@vger.kernel.org, AJvYcCWqThGoNqMI7+/cDMwLy3p+iv95TjoXeP7j+SBas5K1dalnvG2uHuaQ/neLL0fbr20JxzrjDJem@vger.kernel.org, AJvYcCX3aNdWMluw+sAX6KGTPu9VxNSboeKPAZeMLf1FaiXbJPTDJo2yPzDn7wF0nckHkPpcPs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYCsH8rQlst0r3wuzVnCGriCNWkWjdgvusEjWExSw5owiQRbLU
	p4HAe+f9C0bX181iQB7TVsoW+HYkZ79vYfk2C3aeDNh9TrzFSGAzmx8E4xYR8q3Hy2G2IAL4bB9
	GQ7twV7JPwFJIKmX35lmjCTQW6GvHuoibcg==
X-Gm-Gg: ASbGncunMnqRES0/Q7nOx6l1qfzu+waGbJXz6UKffI0WMaFKHZMep/t1w0V3t6OOREk
	HJzxuFguFSMGZ673d0CoOrSYA1z6z8PbRihYhfDvGvDequ7hyGLBma59OIlfzFxdh29EP5sjzoU
	Ym/fxKj7PxyCdf8/ajW+hKc+hHj1ABPK215tn5XJCsc9BeeyIQbVnUJPM1uSvz3Wo1dvI50ifSB
	0KkgXWNEiibkm8mi/iUavs=
X-Google-Smtp-Source: AGHT+IFM8ZRUhTMMFPoPU9m6U65rQihPR6DTHa7d6s2IreKPbGglE506/v94vJCHwTLm/k801E+rGxEYCdn9O+Ebt44=
X-Received: by 2002:a05:600c:3145:b0:453:81a:2f3f with SMTP id
 5b1f17b1804b1-45892bed97emr80555055e9.30.1753980097839; Thu, 31 Jul 2025
 09:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722150152.1158205-1-matt@readmodwrite.com>
 <CAADnVQ+rLJwKVbhd6LyGxDQwGUfg9EANcA5wOpA3C3pjaLdRQw@mail.gmail.com> <CAENh_SS2R3aQByV_=WRCO=ZHknk_+pV7RhXA4qx5OGMBN1SnOA@mail.gmail.com>
In-Reply-To: <CAENh_SS2R3aQByV_=WRCO=ZHknk_+pV7RhXA4qx5OGMBN1SnOA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 31 Jul 2025 09:41:22 -0700
X-Gm-Features: Ac12FXxYox-ZTydO-9bGxcV7tjEfh_Od76qWoqE9ySEFca9hzhP54c2ZNF2ytCk
Message-ID: <CAADnVQLnicTicjJhH8gUJK+mpngg5rVoJuQGMiypwtmyC01ZOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add LPM trie microbenchmarks
To: Matt Fleming <matt@readmodwrite.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 6:56=E2=80=AFAM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> On Mon, Jul 28, 2025 at 3:35=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Please make a full description of what the test does,
> > since it's not trivial to decipher from the code.
> > If I'm reading it correctly, first, the user space
> > makes the LPM completely full and then lookup/update
> > use random key-s within range.
>
> Yep, that's correct. I'll provide a more comprehensive description in v4.
>
> > But delete looks different. It seems the kernel delete
> > operation can interleave with user space refilling the LPM,
> > so ...
> >
> > >   lookup: throughput    7.423 =C2=B1 0.023 M ops/s (  7.423M ops/prod=
), latency  134.710 ns/op
> > >   update: throughput    2.643 =C2=B1 0.015 M ops/s (  2.643M ops/prod=
), latency  378.310 ns/op
> > >   delete: throughput    0.712 =C2=B1 0.008 M ops/s (  0.712M ops/prod=
), latency 1405.152 ns/op
> >
> > this comparison doesn't look like apples to apples,
> > since delete will include user space refill time.
>
> Yeah, you're right. Though we only measure the delete time from in the
> BPF prog, delete throughput is essentially blocked while the refill
> happens and because things are measured with a 1-second timer
> (bench.c:sigalarm_handler) the refill time gets accounted for anyway.
> I could try extrapolating the delete time like I've done for the free
> op, i.e. we calculate how many ops were completed in what fraction of
> a second.
>
> > >     free: throughput    0.574 =C2=B1 0.003 K ops/s (  0.574K ops/prod=
), latency    1.743 ms/op
> >
> > Does this measure the free-ing of full LPM ?
>
> Yes, this measures the total time to free every element in the trie.
>
> > > +static void __lpm_validate(void)
> >
> > why double underscore ?
> > Just lpm_validate() ?
>
> The double underscore is used for the common validation parts, but
> I'll rename this to include "_common()" (along with all other uses of
> __).

No. It's also wrong.
Double underscore or _common suffix are both meaningless.
The helper name should describe what it's for.

> > > +       /*
> > > +        * Ideally we'd have access to the map ID but that's already
> > > +        * freed before we enter trie_free().
> > > +        */
> > > +       BPF_CORE_READ_STR_INTO(&name, map, name);
> > > +       if (bpf_strncmp(name, BPF_OBJ_NAME_LEN, "trie_free_map"))
> > > +               return 0;
> > > +
> > > +       val =3D bpf_ktime_get_ns();
> > > +       bpf_map_update_elem(&latency_free_start, &map, &val, BPF_ANY)=
;
> >
> > Looks like there is only one lpm map.
> > What's the point of that extra map ?
> > Just have a global var for start time ?
>
> Sure, I can make this a global variable for the start time instead.
>
> > bpf_get_prandom_u32() is not free
> > and modulo operation isn't free either.
> > The benchmark includes their time.
> > It's ok to have it, but add a mode where the bench
> > tests linear lookup/update too with simple key.data++
>
> Good idea.
>
> > Since the map suppose to full before we start all keys
> > should be there, right?
>
> Yes.
>
> > Let's add a sanity check that update() succeeds.
>
> Will do.
>
> > > +static int delete (__u32 index, bool *need_refill)
> > > +{
> > > +       struct trie_key key =3D {
> > > +               .data =3D deleted_entries,
> > > +               .prefixlen =3D prefixlen,
> > > +       };
> > > +
> > > +       bpf_map_delete_elem(&trie_map, &key);
> > > +
> > > +       /* Do we need to refill the map? */
> > > +       if (++deleted_entries =3D=3D nr_entries) {
> > > +               /*
> > > +                * Atomicity isn't required because DELETE only suppo=
rts
> > > +                * one producer running concurrently. What we need is=
 a
> > > +                * way to track how many entries have been deleted fr=
om
> > > +                * the trie between consecutive invocations of the BP=
F
> > > +                * prog because a single bpf_loop() call might not
> > > +                * delete all entries, e.g. when NR_LOOPS < nr_entrie=
s.
> > > +                */
> > > +               deleted_entries =3D 0;
> > > +               *need_refill =3D true;
> > > +               return 1;
> >
> > This early break is another reason that makes
> > 'delete' op different from 'lookup/update'.
> > Pls make all 3 consistent, so they can be compared to each other.
>
> Hmm.. I'm not quite sure how to do that. lookup/update don't modify
> the number of entries in the map whereas delete does (update only
> updates existing entries, it doesn't create new ones). So when the map
> is empty it needs to be refilled. You're right that somehow the time
> to refill needs to be removed from the delete throughput/latency
> numbers but fundamentally these 3 ops are not the same and I don't see
> how to treat them as such.

well, random-key update when the map is full is also quite different from
random-key update when the map is empty.

Instead doing an update from user space do timed ops:
1 start with empty map, update (aka insert) all keys sequentially
2 lookup all sequentially
3 delete all sequentially
4 update (aka insert) all sequentially
5 lookup random
6 update random
7 delete all random

The elapsed time for 1 and 4 should be exactly the same.
While all others might have differences,
but all can be compared to each other and reasoned about.

