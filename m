Return-Path: <linux-kselftest+bounces-48620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E52D0B25A
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 17:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7992C3012C75
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 16:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C4A35CBD4;
	Fri,  9 Jan 2026 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GFIsCHdg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EEB363C5F
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975166; cv=none; b=oCuRLQr0ubhBcKMUrs0fWcLh95Sz4p1xF/AMAJFPl3W6ouRL14xmzlBnJYgQysJpzIImNcsysk/BD1ZGTMbUlflAiulEzNfWEzTXnlk8xg0iWfWq0MLp1MlEzQ7fYmhezytLYW36blGAVtqZepTAVvy+kFGiO+o3WH3GJ3XfD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975166; c=relaxed/simple;
	bh=7nYTkLWPl1UM8TZDYNKBL/hfXO/2Wa7x8HBtreZOD0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDvrOFuBN6tefN7/oLvi2KhBQbslSe+IRROciJPXC53CzSk2PL2HkYrQfZMU8ATroWlp5VUGLoEZokyrpW37q1v1qwhWziGeCvIoyj1bPRIW33SAb2JPqT0G4I5Xxrc1l3+SULD4WMUf2e0ApQRTSY1U8YZ7Ft+xnYdEqLwaz+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GFIsCHdg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4327555464cso2602150f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 08:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767975152; x=1768579952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nYTkLWPl1UM8TZDYNKBL/hfXO/2Wa7x8HBtreZOD0U=;
        b=GFIsCHdgo5Ew5jPavjDOBmjvuUgGrcZgeEHM2cksiftSXsFTCs3j/BsRwC8pbJhvl0
         czCoa0b3YuiV3xIUk/NrXx0FiL4ffHPe6ZEjeFNR3sI/K3jWw4rFR69RL8sQfOq9tzuZ
         8KxrYa4DqKDh5CU4Vmax+EFJMfp3ZCUCfEMIJza9rXFSbtY4kg7PtABE28AFwuQx7nYv
         4tyG1bWdQFsilaDRL5E9DL9Y+mR1dS8Qqr7fX84dNjFKkpteucnOPOE5hOZGBYEWhU0V
         k2Wpue9SDW1oAQ6jxO9VkKZanKFqqMACOs71h3dG8Cm92yDb2nSqDe9MlvuxUL6LUk2j
         1rRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767975152; x=1768579952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nYTkLWPl1UM8TZDYNKBL/hfXO/2Wa7x8HBtreZOD0U=;
        b=P2Xewi4NSsW5DT+krAKZKPLQvgACRhUdnUM5xL8s1YPaZ4dbJis6yAaxLvJG4NJEan
         +vdVQMcOIH7mFzgJTTARawMKsv1XAtRl1VaoknpUOGjIwl1MG0RJzwp5x8x7qUYTV1ub
         67MHrFwRU7R0i0S5+wCte/Vfjd1edcAK4rMm6h2rSoVJMH+gLQKvuiSb4Ad8B7NxoVwq
         jOqvCtGPgOqVWP9yYnLVLoYys4+t8LmbGKFAJ4oSQVphTRdUsG2EQlnrW0VIROJoEVgf
         t5+Yi4G43wVlE5PTaajeDhTvuuHsHeww0EakAaFQOC+z5tPZOuNKrwE8+LeE5eU6+QZh
         PWPw==
X-Forwarded-Encrypted: i=1; AJvYcCXd0A6jlAzULQufBUMKDmXwFu/Q+w3XvdE9BOBWvHUL6y6KpSHJZhvS0QaCj3j5Oq6SEjZLckyLRIc4wGmewKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYD1tI0LlFcpYztMPzTKlIv3t1kZ9X9S21pMVmJMiR2/mArxQ1
	Hn2HJIkjEiHaWKrXUKsG52hMqGcq+YMRjOr9IaCrWgFwO9enW5a9uhwGLWM+F85A1AY=
X-Gm-Gg: AY/fxX4TG/CSfbYl+xAjA3/7ztu9YnBhyj6fGTbm9mcgmCCLNAnxFpgkbVib3E/2TMK
	jzyCwDAVvOp/kzm+HX8j3UYC+Sj3MIz6imAh7m3/PJsC3ky8gxVDQoi85LiscnH5UgZ1x1hK/lF
	N7bTeiO6sxwN7Lhepqc+OZ/7laFhClb6hyb5FMVVQx0eEbNyx7AwzjItffj4m+kgdgLJGdwgkcI
	vqLtpEHJcQpcSVLKilNT0NLLN56xPPw/1DXZZZFz35Zjou4vsfPmmdTBwGxS5McQ2Vvnlhwz/IX
	anzkgbe4NjvHNM7HreqFTGIkMpySEw1BOrnGw/x6uwp4TcgERXkxRH1mnqcQ+khjf+vP1vaZDTE
	UHt6JbRfPZN+RS/oqPDAgiJ5+eGKafrufkL4FN2L+iWTQV89ek73woDbZnSy1A+j/OypMR9zatl
	0ikk/WpdTvm2PIADQHAkVzR3dQjFTB5uc=
X-Google-Smtp-Source: AGHT+IGqi0WGxFAcDFwR5qEinbKBaTRMIfIyWMKP/Zy/UAYWvqJ9DVeTS3bRLdcV05itFpZa0N5HLQ==
X-Received: by 2002:a05:6000:40e1:b0:431:16d:63d1 with SMTP id ffacd0b85a97d-432c37a50aemr13205705f8f.44.1767975152120;
        Fri, 09 Jan 2026 08:12:32 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee24esm23190979f8f.33.2026.01.09.08.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:12:31 -0800 (PST)
Date: Fri, 9 Jan 2026 17:12:29 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Sun Shaojie <sunshaojie@kylinos.cn>
Subject: Re: [cgroup/for-6.20 PATCH v2 4/4] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
Message-ID: <oaewv3tyxpufdn3d3tnb43d2qyhqxlorl7fbbp3vwbw3j4jxn6@lonmplwkfumn>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-5-longman@redhat.com>
 <chijw6gvtql74beputm3ue2zu2vmrwvtg5a2bn3wabgkqldq4d@obrdh4znejaw>
 <990be63e-3884-4933-9ad7-bfd9f2be05df@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c2bzswrle4z6exsi"
Content-Disposition: inline
In-Reply-To: <990be63e-3884-4933-9ad7-bfd9f2be05df@huaweicloud.com>


--c2bzswrle4z6exsi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cgroup/for-6.20 PATCH v2 4/4] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
MIME-Version: 1.0

On Fri, Jan 09, 2026 at 09:30:08AM +0800, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> > Concept question:=20
> > When a/b/cpuset.cpus.exclusive =E2=8A=82 a/b/cpuset.cpus (proper subset)
> > and a/b/cpuset.cpus.partition =3D=3D root, a/cpuset.cpus.partition =3D=
=3D root
> > (b is valid partition)
> > should a/b/cpuset.cpus.exclusive.effective be equal to cpuset.cpus (as
> > all of them happen to be exclusive) or "only" cpuset.cpus.exclusive?
> >=20
>=20
> The value of cpuset.cpus will not affect cpuset.cpus.exclusive.effective =
when cpuset.cpus.exclusive
> is set.
>=20
> Therefore, the answer: only cpuset.cpus.exclusive.

Thanks. (I later arrived at that conclusion by studying
Documentation/admin-guide/cgroup-v2.rst.)

> If cpuset.cpus could not be used for exclusive CPU allocation in a partit=
ion, it would be easier to
> understand the settings of cpuset.cpus.exclusive and cpuset.cpus.partitio=
n. This means that only
> when cpuset.cpus.exclusive is set can the cpuset be a partition (it has n=
othing to do with
> cpuset.cpus). However, for historical and compatibility reasons, cpuset.c=
pus is considered as the
> exclusive CPUs if cpuset.cpus.exclusive is not set.

I reckon this is the difference between local and remote partitions.
I.e. non-empty cpuset.cpus.exclusive is what makes a remote partition
together with non-member cpuset.cpus.partition. Where the latter may get
into the way as an uninteded local partiton.

Cheers,
Michal

--c2bzswrle4z6exsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWEo6RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjISAD+PtIh8Hw7ChSTbbpB9n/I
EZmtcsvJGLy+zKIi8ieqW3YA/AgypfRIytJKhva0dZqwrLB0OhLD25ULmEUPQMSf
S2QA
=tOrM
-----END PGP SIGNATURE-----

--c2bzswrle4z6exsi--

