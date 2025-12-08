Return-Path: <linux-kselftest+bounces-47271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B688CCAD74C
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 15:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E42C3065AF4
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C05532AAB0;
	Mon,  8 Dec 2025 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WbYhK0vb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C432AAA1
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Dec 2025 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765204318; cv=none; b=ta+CZBYtMs8DH98F9Nt+AQFBDdihlKU3YKmA5Bg7e7uVSx5xdZLmcJ6jvqY/6z9xqt++mtJYFrFLFz97dWHXrfOwxVkKtHOxLhVziyeZeGpqxKZazeWy9XEi6bjhOL0As+f4fNc3aNJxE73clvI/Cq9s9Ifhjm5nD53UXja/hoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765204318; c=relaxed/simple;
	bh=O3Uh3B4gYAOFneJgek3n7rIoT2td1Ad2IKeXnSRNodk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6KpmAnD9kFfiFv51vVZwrAivcxyD2DpA+ZOgONeCrkgF3YpvQ+F4tZDP5DVqkNbCAJCnANp2/Rp0WZwIreRzYo2282+mtlU6udcF4i3TdaO2lMLjfGXOQZabnx8ZNG+se6RMHUhle7TGw1hufzYxhqlYlqlUkR0MYTLNUmxCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WbYhK0vb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so2706525f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Dec 2025 06:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765204315; x=1765809115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zbS/TB8hAZ6DXQ0g6ryy+CyTpWKhfJVHRWKBtDSGFk0=;
        b=WbYhK0vbg68AsMM99gu2KpRcjgIib3jHGoJ1FhN5HlEHLdWOA0o279/RF5KNYmgWTa
         9fl1vpBN6CbdLsdmfxAvUdmij9oRUnyTPK3Z/UhB1muwLZcAn+TZJTURJvXLgi49uqaQ
         WeNA9aoiuZlgbnuShzd3A8FTp9hJAAtUTCqnaKQrrI6uQ16+Jyo7y5OmNuuz2/6VSqiP
         JeQnie9s5YehgKGXFhtOtvRTS/avzd3zZ5hqC8hVUaE+f1+X8S9YkKyGo53ovYKT3XNN
         Cu3gkGwKmPH3b4rhqTsS9hJ7aktWqb3c1eTfLSfoTGq9AmHQNBm+mok7EUuUZEhGsSRG
         Mw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765204315; x=1765809115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbS/TB8hAZ6DXQ0g6ryy+CyTpWKhfJVHRWKBtDSGFk0=;
        b=gnSGWZ1uv4dGKtKoBpTfowaAXw0GEaW9ZFAtFbyWPvT7tKuq4YX+UqQWCql7+d8o4g
         rKRdWp2LoeLOGyMExGk88aCFcG0dA4Vt1komFCLhMWbXEcwKyiibh963JXaxqDPieSk7
         fMlDQaOTLyFa76MnxILXTwN29kbV2Tg6VqNClCZKs94nyFmP5CpQrEMkkSk5Y0gZSxYO
         dPm6qEPxsliutWxNe8KieUCmwpeC74m+9aFgsqhfhy/U9nuci0HGWbkihqomqSp6OUZZ
         r9hvAvam8N3IUYOHfRkuVF3vKjxkhO1LyFDbP5kqOCsmCBt6pMShUbgiZ9B9Vm6cuG/j
         d20g==
X-Forwarded-Encrypted: i=1; AJvYcCVfNxChBdf6bBNmMjHJfoPaWnVCZYpDX9AGs9KLw0L7W6rR5azcPYyKO8cYXEVxgLsOG0SBMFiaGoaYzwUrWLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzcQ47BkigI2I8yb6UypALCfsxbthT7uS12lwFsDR9/QfQIZdS
	X9uTZeeHyFoOV9mCkEfm/sC6SphIbe0sjIAKkLkZ2G7DvUdOMHlAUs/kWW7AoIC/D8k=
X-Gm-Gg: ASbGnctXa2BsGjWG43KAgoJEw0hxHLVLtWmLLD01fimzUtJitnp9THDBYGFTsFkzhMO
	hDNugJdFhwYi8kQyvezCxXTV+LLyOqtVYePQCyOLIil02qF4R+aTXTyszh84lCZrhYSlhLDrODN
	wqFptSjdfMxL6LBFFl9SDpKC/3gTn2Z9cXAXv0DQ+AtJqnKclGSRjPqQq2V1Un3HytKVwlS0Uxx
	I1zx80j4/BeoITDNOcLL2ghBwMNhE2/s4iNvIgvfn2TP8FxTUMrlNM2/ulFYyDFRwXwKF/zCU77
	kJIkzA3rmYU+QG5/p/+EfI/qCti6HZ7OGSE8UoYPyKQSoGhjEBjIdkcZoPrlS3H2Ui/+YFMryvE
	Tg/LhGDZDQeLIF0opdsd75WKGCbG7h2b/kcfPtjVr1cXpPrEaOK9PFuSDmqo6JOBPsqA2q2Cftd
	Q+yPbymm/WP8ogdauV8DKZDhDSbW4mPoI=
X-Google-Smtp-Source: AGHT+IFE7vUIMGvCnJOjKOCQWrdf18Do3wS1MnUJq3sK9xI/Jc79nYC+PBM3L0+BYybJi+Ost3nvog==
X-Received: by 2002:a05:6000:2f88:b0:42b:30f9:79c9 with SMTP id ffacd0b85a97d-42f89f455c7mr8439244f8f.37.1765204314477;
        Mon, 08 Dec 2025 06:31:54 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222506sm27611266f8f.28.2025.12.08.06.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:31:53 -0800 (PST)
Date: Mon, 8 Dec 2025 15:31:52 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: chenridong@huaweicloud.com, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	llong@redhat.com, shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
Message-ID: <b3umm7mcucmztqqnp6x4e6ichqcml2r2bg7d2xairxajyqrzbt@3nshatmt2evo>
References: <45f5e2c6-42ec-4d77-9c2d-0e00472a05de@huaweicloud.com>
 <20251201094447.108278-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ji2b3cuc5ipyhw7r"
Content-Disposition: inline
In-Reply-To: <20251201094447.108278-1-sunshaojie@kylinos.cn>


--ji2b3cuc5ipyhw7r
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
MIME-Version: 1.0

Hello.

On Mon, Dec 01, 2025 at 05:44:47PM +0800, Sun Shaojie <sunshaojie@kylinos.c=
n> wrote:
> As for "different operation orders yield different results", Below is an
> example that is not a corner case.
>=20
>     root cgroup
>       /    \
>      A1    B1
>=20
>  #1> echo "0" > A1/cpuset.cpus
>  #2> echo "0-1" > B1/cpuset.cpus.exclusive --> return error
>=20
>  #1> echo "0-1" > B1/cpuset.cpus.exclusive
>  #2> echo "0" > A1/cpuset.cpus

Here it is a combination of remote cs local partitions.
I'd like to treat the two approaches separately and better not consider
their combination.

The idea (and permissions check AFACS) behind remote partitions is to
allow "stealing" CPU ownership so cpuset.cpus.exclusive has different
behavior.

> >   root cgroup
> >        |
> >       A1  //MK: A4 A5 here?
> >      /  \
> >    A2    A3... //MK: A4 A5 or here?
> >
> > #1> echo "0-1" > A1/cpuset.cpus
> > #2> echo "root" > A1/cpuset.cpus.partition
> > #3> echo "0-1" > A2/cpuset.cpus
> > #4> echo "root" > A2/cpuset.cpus.partition
> > mkdir A4
> > mkdir A5
> > echo "0" > A4/cpuset.cpus
> > echo $$ > A4/cgroup.procs
> > echo "1" > A5/cpuset.cpus
> > echo $$ > A5/cgroup.procs
> >
>=20
> If A2...A5 all belong to the same user, and that user wants both A4 and A=
5=20
> to have effective CPUs, then the user should also understand that A2 needs
> to be adjusted to "member" instead of "root".
>=20
> if A2...A5 belong to different users, must satisfying user A4=E2=80=99s r=
equirement
> come at the expense of user A2=E2=80=99s requirement? That is not fair.

If A4 is a sibling at the level of A1, then A2 must be stripped of its
CPUs to honor the hierarchy hence the apparent unfairness.

If A4 is a sibling at the level of A2 and they have different owning
users, their respective cpuset.cpus should only be writable by A1's user
(the one who distributes the cpus) so that any arbitration between the
siblings is avoided.

0.02=E2=82=AC,
Michal

--ji2b3cuc5ipyhw7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaTbhSRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiR3QD/SGEhKmZeuPCjZm+gTCIO
JD8ZSy5Dy5ZU6hpXQCtRXvEBAKsTxFqdq+5hdMBQKpsxhCKKGYjnRsciVMJNZ1AA
ThYG
=qpLP
-----END PGP SIGNATURE-----

--ji2b3cuc5ipyhw7r--

