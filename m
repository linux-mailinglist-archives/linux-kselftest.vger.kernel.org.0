Return-Path: <linux-kselftest+bounces-45980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78855C6ED4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 14:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 75D812EA5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 13:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA2535FF5E;
	Wed, 19 Nov 2025 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BgN076L5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7379335A13B
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558432; cv=none; b=PDcnCCu8x+cwKtSqAymLjhADb7y2AwnzA7dnf7TwT/grS4vak82EAahG/dmYFuZcZ3AsQPkoKOBEEBz6AFu77HClNY6xLL2la+viQzaoWF231MbMF/u1+eCiA4diqh+sgnzOP70c0cXUtWq3N34baP170p6LLSK7L6CShZf0x6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558432; c=relaxed/simple;
	bh=nm3sztzQa4S0D20Deg+k1S1+xIdqQFIVhZyb8SECxss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkAsAj7DErj2HdGf4sATnQtHB3W3Z+fJrN50A0PvV/5m2Gb7t7DlXYsOmhogq4hhx7aavLh4Z7shWVKAshHNn1ozEN9Yl2Nr0vnRKloW7lNBgtoajb7KbwQsqPHMOj9EP6zbfnd7NzRNJbHRYw3fmJEyxSyjOUhnaqsGWFrc+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BgN076L5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso47092755e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 05:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763558427; x=1764163227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PoxARgPM89Y9X6g97pK7NmdCJnjkyiIU/xTcdKp+qf0=;
        b=BgN076L5BEohZr7QL1FuLQJAxGvi2GEPEFhxWwTOE6Qz1Qfko7aWYapR3IcW8uFxV3
         JR/+BN453S0V5hSDoaJ5dVKqdFiRYWbN8tvIgd58H6mQr6xoK9PV5WtMIylec67fgKx6
         KqcoJZVU9bwpo5T00BBS/7rqccFrMu8x71V2yBVTckXAfpjWpnc/bHqubkevTNFla8Un
         0m4sg2Ny8RExczfpgOnr3jQJ107D2jmAWAoznMVJ9Wj65qiZF/MlT99zybDJ1+qkAeHM
         GOTiVKf3krtKtuzrW/YThzGq4fkjiZBGIj79iGFdbd9sR2qb3RYeB9AjJBradVeenSUB
         Ec4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763558427; x=1764163227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoxARgPM89Y9X6g97pK7NmdCJnjkyiIU/xTcdKp+qf0=;
        b=u4YweYYeI2X4Om+WqwVoY7l2fzunkPEK5AdXoWY5voT2444pfJe5n7ooFNrEV3jg4X
         pM1TbMXkaH6HWA1nWZqkaXhT/YIxVowW/x976FVkjwI6SVgVm7MLaPSxn7obc0KygUkM
         UfMkmwZa268oPEK6xdsbNvOBRIaVraTxg29soVeVGMotajhSnuL7AVvafQB6f1303Xeg
         5ana9Vmu86taFZzEEVGKT9RmDG4pTY1G/Q0yqJXMd22WN3D59UEsrEVrsVHxcdSs0ynq
         h02xJIYz/HpaJPZ7Cg9tcrcPUmxooFDQ+M12+16ytL49R4kqhZIveUx3NQ72hZT+299h
         EHOA==
X-Forwarded-Encrypted: i=1; AJvYcCWbppNebpM08AixugzPEsGOkGXV1j5Sof9U+3KI5AAqPSDe8oOsXzerIGCvA8iyyf8/C/PUXmqXmyWYX15U9Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4G/6D50sTv2sdrZUYJ4lGgQi/xtlWK5iNYpkx2s4N4zUyVGD6
	bEX80CASwKgmwUmXDou5jznhD9eEy+tymHssj2D93r8vV/N0M/EDvn30AssgFTuw9Ro=
X-Gm-Gg: ASbGncsxA/4Wf/kA9SMGhR1EhHVT+lrdsc8eXVNW4dXPOYKFBTSiJ7o30foRWMmz0OU
	Qjf0uYBYchXwRP25zRSWfz+ASBwR1pD3Az1Akt2O4rEoHZjDjMU4uW9yudNGuPW5AYqcZ6HNkTM
	Leg7bPCcoTeYljXY5TF38EtJeawmv49WZYkt5BobxDha8TJW/u1LrMSJ6mj46EeGfRUCZRp5jZk
	LSfa5GUHhQaKgJ5QgkxfgKShfNPLys1GDWN6YLN6/AIj6VrdeW2hzop0lVz/yOGGmgpInF8lDEy
	9uPoc59chsFshpSU3sB4WIxsOt3G7XDZboilVIUPFjh+6ZEhkbd55fy4Qr1Usl9PviJXTBHohiL
	e1K+pEOptf3X7GVx9e0Nnv2p59vSDZcR9mtTkjDqOQx1GvCYGsBHX6AQeNPo9HIVllFSVt9z/+n
	hYcTmqupSaiIPtNtRC+DDdOi48JfJb9Dc=
X-Google-Smtp-Source: AGHT+IF3C7gq6LiGSx2tyyH9qIWLwrqvuyyIU92gVC2nsYxSAWDhsioOPNiP+CZTOsQ5zahjmuCeWg==
X-Received: by 2002:a05:600c:45c7:b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-477b19ee2b2mr22992965e9.35.1763558427327;
        Wed, 19 Nov 2025 05:20:27 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9de4765sm39618955e9.10.2025.11.19.05.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:20:26 -0800 (PST)
Date: Wed, 19 Nov 2025 14:20:25 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: llong@redhat.com, chenridong@huaweicloud.com, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
Message-ID: <unk64xmcj5kt5c5gaauwaeld5qsshaldw7utgzk362w33y3zr7@s765trmj5ccs>
References: <f32d2f31-630f-450b-911f-b512bbeb380a@huaweicloud.com>
 <20251119105749.1385946-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="56pquggrhrxwrten"
Content-Disposition: inline
In-Reply-To: <20251119105749.1385946-1-sunshaojie@kylinos.cn>


--56pquggrhrxwrten
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
MIME-Version: 1.0

On Wed, Nov 19, 2025 at 06:57:49PM +0800, Sun Shaojie <sunshaojie@kylinos.c=
n> wrote:
> Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
> with its sibling partition, the sibling's partition state becomes invalid.
> However, this invalidation is often unnecessary. If the cpuset being
> modified is exclusive, it should invalidate itself upon conflict.
>=20
> This patch applies only to the following two cases=EF=BC=9A
>=20
> Assume the machine has 4 CPUs (0-3).
>=20
>    root cgroup
>       /    \
>     A1      B1
>=20
> Case 1: A1 is exclusive, B1 is non-exclusive, set B1's cpuset.cpus
>=20
>  Table 1.1: Before applying this patch
>  Step                                       | A1's prstate | B1's prstate=
 |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      =
 |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      =
 |
>  #3> echo "0" > B1/cpuset.cpus              | root invalid | member      =
 |
>=20
> After step #3, A1 changes from "root" to "root invalid" because its CPUs
> (0-1) overlap with those requested by B1 (0). However, B1 can actually
> use CPUs 2-3(from B1's parent), so it would be more reasonable for A1 to
> remain as "root."
>=20
>  Table 1.2: After applying this patch
>  Step                                       | A1's prstate | B1's prstate=
 |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      =
 |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      =
 |
>  #3> echo "0" > B1/cpuset.cpus              | root         | member      =
 |
>=20
> Case 2: Both A1 and B1 are exclusive, set B1's cpuset.cpus

(Thanks for working this out, Shaojie.)

>=20
>  Table 2.1: Before applying this patch
>  Step                                       | A1's prstate | B1's prstate=
 |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      =
 |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      =
 |
>  #3> echo "2" > B1/cpuset.cpus              | root         | member      =
 |
>  #4> echo "root" > B1/cpuset.cpus.partition | root         | root        =
 |
>  #5> echo "1-2" > B1/cpuset.cpus            | root invalid | root invalid=
 |
>=20
> After step #4, B1 can exclusively use CPU 2. Therefore, at step #5,
> regardless of what conflicting value B1 writes to cpuset.cpus, it will
> always have at least CPU 2 available. This makes it unnecessary to mark
> A1 as "root invalid".
>=20
>  Table 2.2: After applying this patch
>  Step                                       | A1's prstate | B1's prstate=
 |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      =
 |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      =
 |
>  #3> echo "2" > B1/cpuset.cpus              | root         | member      =
 |
>  #4> echo "root" > B1/cpuset.cpus.partition | root         | root        =
 |
>  #5> echo "1-2" > B1/cpuset.cpus            | root         | root invalid=
 |
>=20
> In summary, regardless of how B1 configures its cpuset.cpus, there will
> always be available CPUs in B1's cpuset.cpus.effective. Therefore, there
> is no need to change A1 from "root" to "root invalid".

Admittedly, I don't like this change because it relies on implicit
preference ordering between siblings (here first comes, first served)
and so the effective config cannot be derived just from the applied
values :-/

Do you actually want to achieve this or is it an implementation
side-effect of the Case 1 scenario that you want to achieve?


Thanks,
Michal

--56pquggrhrxwrten
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaR3EFRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Aj+eAD+J14AFyYgMq6PwY3tUvdv
+yJeyY2AzHSVfN4YYmOdkYIA+wZwO2bW660vCxGCI4qFDcSrI0RNqEm+EZg+dPyM
2TkG
=r/6p
-----END PGP SIGNATURE-----

--56pquggrhrxwrten--

