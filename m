Return-Path: <linux-kselftest+bounces-35683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FFEAE638A
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 13:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5094C0946
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 11:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C3A28BAA6;
	Tue, 24 Jun 2025 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXb6qYAR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD8281356
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750764587; cv=none; b=ADj94ivs02KamtObWRomVQy2LxkMf8bGkDmSRb/VEpkXX+gBR5nVgrVsllnJHc0ldgAPZugOj7ZroFcGCnkFAqJk7ewVhVk3rwlzrg/4er1RfTD4xWaynV8627bBtgnUDvKLwKSvYtm/WsMNNXeyjIe/MZfYoXoO2JIrkVxb4zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750764587; c=relaxed/simple;
	bh=lvAnRYVLGXQzPjh6386H4xE4YwPMe6ddfB/0cO1g2jQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nU9l5TQa6aXOT/VMMVLVSaEfjIRrQ1Z6r8jyg+0KN+pgqIGW/xJu76ioIjfn/DwJLSRU8hqXcYlAci+8QI08GuEyUz9Vj7oBHVq05EV9dzuxSNMliAvZer2sFt06FOlUGTitXdWLaLtJilYRAgGt6w1bwbADfGiLTij0fnbCc6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXb6qYAR; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-adb2bb25105so836526866b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 04:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750764582; x=1751369382; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT0e8thdB741gKZwqm26adW2g3BYeo+7KpebTXcd1V4=;
        b=gXb6qYARlQZOPtLnfT6JbLLb65iqU+UbNtf+c68MDGJRxpUBnQOo4lk/ChEVjcRgmb
         2NSDQfNjBPj9OvFrD2pAp1LkS3s6Kcy7E1XpnUt6cSDgPOxsmFIXcl/geB6jRSUxQ60g
         lDESKRazAijxPZgvxTiHSpKnEEoKvXHGTUTtZbK6DK3XrEoCa5SvLtCi71UrJQp/xvch
         n6krdmbaT6FzwSJ716TRYNo79n2nALLLFCxBtm0GG9mieOFgMnzRMVXWI/zIEbqiTmbb
         mHGKzJQ3UVLixBnFsbtYLDzvFFHZ8jI6QkGiqxMsdv9BzDPMzaAQtQnSpcPS+6BmHH51
         UanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750764582; x=1751369382;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cT0e8thdB741gKZwqm26adW2g3BYeo+7KpebTXcd1V4=;
        b=E8gkr/2bVq9fwulswOAOD8jDvwCokcnoGn/QI5NxHzm4Q4d7igSgVLtyOaiJUGjOwI
         zBvZ854ax/RjIsP04mWUAWu0t3JSnLJFjr87x05lgKWWKjgwdx7j1/jWj9fzat5xiLtE
         HZjUPA8hz/wP/jP4qUob0zevtgLQgmLhQWAMHWvDdL/uFls2/JdUAPlw2Yt9AbeZ9Rpd
         K+hvUlUCB2QU7Ayv0ARHnVlOGrxmWE8L2KRzQBtLAGWOwMIXsRvWhr9kP+QjZie01nPP
         WyiyTnhSKmrpmTj/5X/4dzaKhcnXA5QBzWeh7YTrS7zH3Taa3flcTzchDMYnYbhfSYtN
         vBlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO9MtWBnso6Tm6MbRani7HTbGQl5ZSAPAUA9t4EwNkL5+j4JXjK3uDagA0HdNpMdD6AoY8ucIKrZiRDmKMcQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuViuzQwTGLq6criVP18JhmepJRHSSXVHJKsWAhHWhLqj/gNLH
	uGFUJq/AVTcQ9Oq2y0zwbeZpBbIvl2iSmgsfFTIR/eir2Qsbmvp/g3z0
X-Gm-Gg: ASbGnct8Usy0Fy4ETKADwiJI6wEwO9Iip4VBCE7i5cG+uh5WtBSfl6yKahVcjEO/vwT
	H7rp6dZlycXC+DsibnZOApZNuswyytwF3XMVga25JpNFb/cOt048SOR9kkl0ylfgj2GZ9v2gsQ9
	AOKpks4g8wykklQGbAAVkkzIfWkmr+JqX6kzfKTvuW7UBahS6I+Hnfb8D12mzPNfk1gZBECEO6O
	4wostWOYIeANVOQiBB+F06yg1dsbvOaWDDKxYZcSZzyTIgV309CtR7/ww6laVOxF10MoKS1lvuk
	vGvzeSUkotYiCwKT8o1FFpKsjyHJ0E8ktiXbJhDCb5osdW5NY3zHMiFD7Et/oqdSbfU2vmgeVbc
	DSR4=
X-Google-Smtp-Source: AGHT+IGQvk8QZ+Fin/JWPu8cW0baEoe0DVTqf/iH6dwWkXfQMRKk1ZBhOly5xwow0t3UeqmTGHpNiw==
X-Received: by 2002:a17:907:9725:b0:adb:45eb:7d0b with SMTP id a640c23a62f3a-ae0579821c1mr1673852866b.15.1750764581968;
        Tue, 24 Jun 2025 04:29:41 -0700 (PDT)
Received: from smtpclient.apple ([209.35.226.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0b5ab9b8esm28917966b.140.2025.06.24.04.29.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jun 2025 04:29:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2] selftests/mm: Fix UFFDIO_API usage with proper
 two-step feature negotiation
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <4fd18a1c-aba2-468a-881f-0507953f2904@redhat.com>
Date: Tue, 24 Jun 2025 14:29:27 +0300
Cc: Li Wang <liwang@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-kselftest@vger.kernel.org,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Peter Xu <peterx@redhat.com>,
 Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Joey Gouly <joey.gouly@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Keith Lucas <keith.lucas@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Shuah Khan <shuah@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <611F9598-A1A4-47B6-B37E-09BF7B4D17D0@gmail.com>
References: <20250622081035.378164-1-liwang@redhat.com>
 <20250624042411.395285-1-liwang@redhat.com>
 <dfd7650d-1154-467d-ae70-c126610413f6@redhat.com>
 <4fd18a1c-aba2-468a-881f-0507953f2904@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> On 24 Jun 2025, at 11:22, David Hildenbrand <david@redhat.com> wrote:
>=20
> On 24.06.25 10:07, David Hildenbrand wrote:
>>>=20
>> Is that actually required?
>> The man page explicitly documents:
>> "       EINVAL A  previous  UFFDIO_API  call already enabled one or =
more
>> features for this userfaultfd.  Calling UFF=E2=80=90
>>                DIO_API twice, the first time with no features set, is
>> explicitly allowed as per the two-step  feature
>>                detection handshake.
>> "
>> So if that doesn't work, something might be broken.
>=20
> CCing Nadav and Peter:
>=20
> Could it be that
>=20
> commit 22e5fe2a2a279d9a6fcbdfb4dffe73821bef1c90
> Author: Nadav Amit <nadav.amit@gmail.com>
> Date:   Thu Sep 2 14:58:59 2021 -0700
>=20
>    userfaultfd: prevent concurrent API initialization
>        userfaultfd assumes that the enabled features are set once and =
never
>    changed after UFFDIO_API ioctl succeeded.
>        However, currently, UFFDIO_API can be called concurrently from =
two
>    different threads, succeed on both threads and leave userfaultfd's
>    features in non-deterministic state.  Theoretically, other uffd =
operations
>    (ioctl's and page-faults) can be dispatched while adversely =
affected by
>    such changes of features.
>        Moreover, the writes to ctx->state and ctx->features are not =
ordered,
>    which can - theoretically, again - let userfaultfd_ioctl() think =
that
>    userfaultfd API completed, while the features are still not =
initialized.
>        To avoid races, it is arguably best to get rid of ctx->state.  =
Since there
>    are only 2 states, record the API initialization in ctx->features =
as the
>    uppermost bit and remove ctx->state.
>=20
> Accidentally broke the documented two-step handshake in the man page =
where we
> can avoid closing + reopening the fd?

I agree the code is not correct (and my patch didn=E2=80=99t address =
this issue),
but I don=E2=80=99t see it broke it either.

Unless I=E2=80=99m missing something the code before my patch, when
uffdio_api.features =3D=3D 0, also set ctx->state to UFFD_STATE_RUNNING, =
which
meant another invocation would see (ctx->state !=3D UFFD_STATE_WAIT_API) =
and
fail.

>=20
> Without testing, the following might fix it if I am right:
>=20
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 22f4bf956ba1c..f03e7c980e1c5 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1944,9 +1944,9 @@ static int userfaultfd_move(struct =
userfaultfd_ctx *ctx,
> static int userfaultfd_api(struct userfaultfd_ctx *ctx,
>                           unsigned long arg)
> {
> +       unsigned int new_features, old_features =3D 0;
>        struct uffdio_api uffdio_api;
>        void __user *buf =3D (void __user *)arg;
> -       unsigned int ctx_features;
>        int ret;
>        __u64 features;
> @@ -1990,9 +1990,12 @@ static int userfaultfd_api(struct =
userfaultfd_ctx *ctx,
>                goto out;
>         /* only enable the requested features for this uffd context */
> -       ctx_features =3D uffd_ctx_features(features);
> +       new_features =3D uffd_ctx_features(features);
> +       /* allow two-step handshake */
> +       if (userfaultfd_is_initialized(ctx))
> +               old_features =3D UFFD_FEATURE_INITIALIZED;
>        ret =3D -EINVAL;
> -       if (cmpxchg(&ctx->features, 0, ctx_features) !=3D 0)
> +       if (cmpxchg(&ctx->features, old_features, new_features) !=3D =
old_features)
>                goto err_out;
>         ret =3D 0;

I am not sure it is right since you would return EINVAL in this case.
It also looks a bit overly complicated - are you concerned about a race?
My whole concern about race was that somebody would exploit it to
overcome non-cooperative UFFD (IIRC).

So perhaps just add a check for the case features if 0 and be done with
it? Something like adding:

	ret =3D 0;
	if (ctx->features =3D=3D 0 && features =3D=3D 0)
		goto err_out; 		/* no error but copying of =
uffdio_api required */

before enabling the requested features for this uffd context.


