Return-Path: <linux-kselftest+bounces-47272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF03CAD737
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 15:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E72E0301E6CB
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1EA32AAB4;
	Mon,  8 Dec 2025 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PES9lO5R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA6D288C2B
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Dec 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765204329; cv=none; b=lMJjcEZvBxYZcgJiBBcb8gD9m8EfilvTxIS1HdNyLk8gziZxCF1QAkeWn0F95GTdr3E3YEg2JIkydoQg3EHFWAZ8u9wejZxr0CwyavNnXSlQoA1BDXx3CVrnyH5nJwIKyy3kVFSQLz6zPqEo27yKX58rNYz8Q+PRv5D0amuZIgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765204329; c=relaxed/simple;
	bh=90BBNBXDvrM79MgXY50AHCjXT7YIdu6d4NZhjCu1SyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KR3YAb4nfnHi44lvuw/GGg6WX2h/oAwx5DbT3dXREqN51GWrCOVkv53fcYkrL56I5HQ5NdAlFDrtLXgtyJy2Xf0M8E+EKCbtk0WU/uKBbloa1iuahkg+ZvqfTIjVg2hUoLCUhube/gdlfTwJwiU2qe5da1YtEmzxgQRpyx7+mmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PES9lO5R; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso33940875e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Dec 2025 06:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765204323; x=1765809123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=90BBNBXDvrM79MgXY50AHCjXT7YIdu6d4NZhjCu1SyA=;
        b=PES9lO5ReOX1VEX1vont5hO1Ko400f67fgK2UIkSH6F47cITYoR8pZHYjwn4w5W0kr
         WskeT1kmgDTjzHToGx31Z+KalcwDozideJZJntLu4XQBa5a7+jx1IUc0fOzFYzUugMOt
         6kVxgbgely68sauiJd5cgKjWvwCOLjeT5jZKPSLs7CbKXDU630bB7+MzZ2pW+lhYUINY
         m+tmcJt22GW0Cu+ZSBsU8/0cpglx5nIKSAvJdVl3sMgJWflg+Fijvxc+yFHAV9TjRjPV
         TDE5KFtKA9wv6D3w8r5KJ7Zy5tj581WeHtntz8Ru37UL0v1ck/c2yola/Cxe9+nDRtzO
         Iw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765204323; x=1765809123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90BBNBXDvrM79MgXY50AHCjXT7YIdu6d4NZhjCu1SyA=;
        b=T1Ea0O6ezCVhmLqGf+bGSNPeO2ugSCvC/BYyEZCLm3FmSvpZDtd76eG59eQZ3SV0j5
         KqwLSqEm9b0UbVEAELRlFBe5/SSxCVkELGZ8O8NN7v+/3FQFMv8Ygv3ZDBd2Ki9B8LhM
         SC0NU3QPrAy77OVP93jPcMnFSpeTrNcaG1HoLrCh2d1UoEN9Fuw1ckRCANcUUpAyUGZy
         5KfMtUNNd2huRlsAFe4KN+7xvSPUswJlnjTKMx0rZB+omS1dfL5pMsPcntgV65sO7AP+
         zBzTBGQuw5ivhZTMrbD5FTeNSS0v56YcKpa9c6o4kpUwcUdRkbSmsI+kFYuIPK/YSg+A
         L25A==
X-Forwarded-Encrypted: i=1; AJvYcCWHKhpOPyHbXxCMKK14XZ/TyDj1vf+4ZsHmUC2hQmJUn4unkDOGYMrIJUThHrztWgYAQgGd36TDgVhiTSvbIBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+QcEwPZcRD08yAaIPpLgkcWqskkNi9cYn7hdhYysrDYoJty0
	rL257f9SG6OXIIYl1bXWmZ/BOlG8xbkVcilC9+jn+6Iur5+gG26v1OUIi22xOf/vn2GiPRDyhk5
	fMjwp
X-Gm-Gg: ASbGncsfPsT20xL8iLG1ojQyqvQ6Gl/zpuWGompMz70R2J8tPU1luc2gQmXmuCHygQ9
	r4zF1C+rEVXci3Ja9Bk9iEka8LKvqGtEy6S1S/L95/Xm06Vl1Wpv4XVs3SIZPRYynz3wicqzcXk
	GF8WqNFsXk0TLTi8qOvnjhdIJTuN7RJ2xa3sHqG4fSoT5s0PxJh0nFmqs8h31N9WdryQ/MWdCaR
	5oTIG4AgtxJqle6u6VbvEyAYAHnb6Z53CIRtio+HKbAhkUd96Q2a4lTgFyY4yUNFZU1X08ul438
	2Y8OaT/a82RYl6QGfeRgfROyk3IyZ19Qbe1e4844uHOIbcFWFhK6bN/qf0/OWqCCM2z9pJRYnaz
	gNFzWaD0gDG7O5QrsMnPd91fFU59hGAxm25OsXR7CzJvRHtpGb23YQ8S0AJ6+AW7YLR8U1/0doc
	jtXA+ojPJx3GnTUxVFrHRgCuTds0Yjgd0=
X-Google-Smtp-Source: AGHT+IF9MaPmbfKRH/ZEYxsCMKAKrKzmzWbh/CHlTqSr0teoUSfvgE/PLUzoI+UmwssaTSypsSev0w==
X-Received: by 2002:a05:600c:3487:b0:477:9671:3a42 with SMTP id 5b1f17b1804b1-47939e43a49mr86544935e9.35.1765204323488;
        Mon, 08 Dec 2025 06:32:03 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b132429sm142091665e9.4.2025.12.08.06.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:32:03 -0800 (PST)
Date: Mon, 8 Dec 2025 15:32:01 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Sun Shaojie <sunshaojie@kylinos.cn>, chenridong@huaweicloud.com, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
Message-ID: <3jkvuruuxdykpxjjdwhuqjfqi4nrtxojotswaoc7ehuwxp4s32@hfrvfato6q5b>
References: <f32d2f31-630f-450b-911f-b512bbeb380a@huaweicloud.com>
 <20251119105749.1385946-1-sunshaojie@kylinos.cn>
 <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>
 <ur4ukfqtqq5jfmuia4tbvsdz3jn3zk6nx2ok4xtnlxth6ulrql@nmetgsxm3lik>
 <d5d635df-94f3-4909-afe3-f2e6141afa32@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ry6ppl3gxnd6r2pn"
Content-Disposition: inline
In-Reply-To: <d5d635df-94f3-4909-afe3-f2e6141afa32@redhat.com>


--ry6ppl3gxnd6r2pn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
MIME-Version: 1.0

Hi Waiman.

On Wed, Nov 26, 2025 at 02:43:50PM -0500, Waiman Long <llong@redhat.com> wr=
ote:
> Modification to cpumasks are all serialized by the cpuset_mutex. If you a=
re
> referring to 2 or more tasks doing parallel updates to various cpuset
> control files of sibling cpusets, the results can actually vary depending=
 on
> the actual serialization results of those operations.

I meant the latter when the difference in results when concurrent tasks
do the update (e.g. two containers start in parallel), I don't see an
issue with the race wrt consistency of in-kernel data. We're on the same
page here.

> One difference between cpuset.cpus and cpuset.cpus.exclusive is the fact
> that operations on cpuset.cpus.exclusive can fail if the result is not
> exclusive WRT sibling cpusets, but becoming a valid partition is guarante=
ed
> unless none of the exclusive CPUs are passed down from the parent. The use
> of cpuset.cpus.exclusive is required for creating remote partition.
>=20
> OTOH, changes to cpuset.cpus will never fail, but becoming a valid partit=
ion
> root is not guaranteed and is limited to the creation of local partition
> only.
>=20
> Does that answer your question?

It does help my understanding. Do you envision that remote and local
partitions should be used together (in one subtree)?

Thanks,
Michal

--ry6ppl3gxnd6r2pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaTbhXxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Aih6wD/cjyA4xuIIdSHlZQv1tjO
E8fEVfV+kLp6i2x5+vWx4J4A/3oTNWRzkIq32YJE3qkJ0EM+NK+SYHT5TcQtvVY8
l3QF
=JM8+
-----END PGP SIGNATURE-----

--ry6ppl3gxnd6r2pn--

