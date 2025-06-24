Return-Path: <linux-kselftest+bounces-35682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A766AE6389
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 13:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315B23B1E20
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 11:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46AC289E1B;
	Tue, 24 Jun 2025 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmjbxtAm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0464F27FB31
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750764586; cv=none; b=hjqnx0jlD4t5XJeksEWd/uo3PHuzFCUrCEKTJld1O4WS0VIjGtzIsuxfcd4a0sApNEkQpMtyss9MwL0VGBPWV32E4SMrCqrP/6X35PQJzvCQmpxKjbrjQOhv9HZ3/WJPk+aNNu9y9zia96ViJsRmvscH+3+3CdzyLDQMxDcy3ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750764586; c=relaxed/simple;
	bh=lvAnRYVLGXQzPjh6386H4xE4YwPMe6ddfB/0cO1g2jQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Oa2PCXeJlmi2abSp5Bt+sPJnlvMOpAK+mXE0x9tRD3uRK+PyvcMjtMNKxY9mtaquY56O1OjVXryE2FN+uSoD2+ryLFM2Zx+1zSkAyc7T5McRNblcGXndazRiG6CmYd5kkXXA5ZtiBPzgh9alC+dT8froBXahbGw8ZG1viMBvjo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmjbxtAm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acb5ec407b1so868652066b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 04:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750764583; x=1751369383; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT0e8thdB741gKZwqm26adW2g3BYeo+7KpebTXcd1V4=;
        b=lmjbxtAmSlbxPGUF5+d+ITbXfV15HVJdaDU2WvLveEPm+emww2ANbixNwC5Yf5f1FI
         XYvLCW+ocNe2oyvv9H1y7Ay2ZW3eCb+QG/gZjnsqNP5bomCgHucd8eXJkI5vxfTzDdZs
         H5vAtIv/KEh+0c7uldlGEMtpBc+V16na5Dans4Pye533wHCEsxpP6bxnjbPq5cd0uxkz
         5DzNn6aLhvzLVlb5Sy90s0hrVfwe4gMJOFHWSfF2Yn042/92XiZSRU3iE5bNVjiS/GUV
         ELhGyky9fVWXgLVQh7bBy/YBdrv6HlsGue6f9S/18E20tPsx/B7PDzOSwkjjhJTmdedy
         R6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750764583; x=1751369383;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cT0e8thdB741gKZwqm26adW2g3BYeo+7KpebTXcd1V4=;
        b=SVI68L4LATI898Ocqwiidc5sp0G0n10BU0R4vc588Z0lWi1XwwIVYPmMFEntXAeukV
         l5SV6snJxzIy/DiEgKPCWQjaDPYht91O6ZqjYrf4fp4M5h/9h+4RYvPZ8JhBYSTJvztR
         bTa5/1ZnyRedNrFHwhcr4TN+kWfDQoGH9exOZVb5jnw65bPmefFuDmdCGpXjf2mFVlHg
         AojhLtLqqyc1NdBqtqAANT5vFuuCqITTPCnzAZ9RpUkjXXhYHAUEU2jC+8h8gMBAowyT
         AlsKqXchJRdBRDPDDxZn6avEVd1WLfZ/WcbSRnwun1/JBRPYIycBJmBD4e/ddu1Bypmc
         aXiw==
X-Forwarded-Encrypted: i=1; AJvYcCVriTHqJH5FsT7zxJ30tD9iQdh1NwkVDeTvAUdP8ReP0AoUio6cS5HQXQL3622q0qqeJiXapkWGdESiN0j3NYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHEREbqUs3tsuMUGvb6rShPYTPLaeqfS3JUCin3xXWD88Tkazv
	lUg1TGqHN7zkV7eQCj3PdUqSL0vi8Etur4o3RkufBQXNdYn4nNpAEt3K
X-Gm-Gg: ASbGncu7PmjxwaF5/IhkjHr7puICezhBLv1kQYUA3BYa8OULWQKjVYirYqmbOrsb7pz
	pQ2O/aXWxqHJBtT02wKqAcAoEOs+TGLpvWeCT8pgtpUDFpptDGW+TDZVbe+mWTQFjvZe9RWbvYN
	QtGxmbsGFZ8aIJISYcVykhSq5zg/4UqFtOXa36wA7UtN2nNWCUOsq5ElVkBYGMP3bF8Y1cK6pa8
	5vzkEUoV8AFP8ZbrzJCXT1V79PP7QdUyahHHy+p3StuJkQze8JM36DfeU+effJwOfzY0enqQ6OC
	OXS+3yxlEARuvovFXBck8UI8MxOq2EVIYfmNFcVOHTSxo5QA62ZNyHXqeZZ9IFzTicDT8tKIa8n
	IgDQ=
X-Google-Smtp-Source: AGHT+IEA/K3OuO8GKA38R1Psg6fkZo6i4uFIRJ9XpGyL94ZkcldAAB91lALLGbw5tcpVdwIdkTNqCg==
X-Received: by 2002:a17:907:1c99:b0:ae0:2fab:f01a with SMTP id a640c23a62f3a-ae05792d1c1mr1525398166b.12.1750764582593;
        Tue, 24 Jun 2025 04:29:42 -0700 (PDT)
Received: from smtpclient.apple ([209.35.226.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0b7bc2107sm11498866b.104.2025.06.24.04.29.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jun 2025 04:29:42 -0700 (PDT)
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


