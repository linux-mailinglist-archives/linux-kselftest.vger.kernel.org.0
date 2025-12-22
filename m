Return-Path: <linux-kselftest+bounces-47855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DACCD6882
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 16:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12FFB304843C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 15:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B845232BF5D;
	Mon, 22 Dec 2025 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WJQI3p3Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299532AAD2
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766417203; cv=none; b=HGYTZC1J3THE/9hJmM5RNzpqiGiSZIwK51cAbrV/WgWg4w9k1u3onJLOa/p63slIXqQIFVQlwAsi1493Ay+BZiJ98rhlMmbSEU32TTY1vNGEcISOON9bthDbQpHoXQHvA2VMWvcGgc69X7DmlDpAeT7ubVFW8IxRSAgtUpPJKTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766417203; c=relaxed/simple;
	bh=pwNdHHpa/mgCoIpKqTkujCQuzfwTh0JljZB8DKCH2/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFGf+QNG4fkFbGfADMlDGEKwu0Dx61imB6PiNbL2lA7cxk3lqqaqWqABLr5gGQYO7pictsP0D2pMQ3/FFKhgR2UdwdWPFe8CUhrja0R7MTqcci9CCniEClO7htbQY+r5m/kMTujZPv2vWKkk25Nb9A2MJpySEuFisXhO+WRFedI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WJQI3p3Z; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so25734415e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 07:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766417200; x=1767022000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjy1Kjs3/ZvkfmJuAkFjz2P1LbrD8XoaWU4C0z0fF0Y=;
        b=WJQI3p3ZBuwR32N916ckAsnefzTxY32fwEC4yHDoQZwu36RqmiWPzknpQhkpeZvJUa
         zOf71E+k+AF3jbNSKe8dij+NXC7kPYj9VvBEVgo/wTm2RfQU+tmoSlbUVL/BIWGyYp3b
         nPaRFflxvL26qvTKOaWnnCwhK7AK/yn62sVjRLR+9FROSjVsomQpIBo6jEHFStfAO87C
         fj2OSNh2eVGFCJdDY52ac0vmwFJy93KzRzCqP4KgOekIYonsPfhoP7CJLP9KTt5dFUix
         6y8vMrt5aGAnNjBc4v7DdPsQPzXB1tNL5neq5mTeo5hHe3tuSgRgtWsjocSVdC+9YCpb
         F8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766417200; x=1767022000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjy1Kjs3/ZvkfmJuAkFjz2P1LbrD8XoaWU4C0z0fF0Y=;
        b=eFzVXxR0RBblxjAXQiwqGu+FH7mEmtBT15t0T0M1kx25Rbo8vpF6iGLYtFHO9wek2F
         j6q4eVVhLJeMx6GIG2l0kTfzbTOIiNvBeLMBg/wr+MuhRL4i4ZsG/HrGWH44dWgPPe4W
         8V5d2yhMgV6zrz7v9cTufxBSWDgxEfqlC9/dts/3LjzNItCwCdSJridQ39FLZuB1eFZV
         /k5w1TIR1SCBhlYSZMN0nv8JXbpKoiGeWKYPbqRiljFB4xO7RA4/T97aRgHkcgK2tezV
         rrtx8hRAj34taNiNgfx9JptGezFHZllaWY6asJi55h0rr+uCHbuW7cQvWTQmY7R+vyd2
         us/w==
X-Forwarded-Encrypted: i=1; AJvYcCUzcMj1DoR7U//g0cm+r2f0CjUtrcZa05AUJM6KvTdooJdKBcbqzolw/XUSXpBny0xA7QfLsHQGsAvd/0RkXxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycvSIg3VkK9FNMKik8IRxkC4KOn+ieHuBm46k5LjaqFRBThKB3
	o+rld9lL3dkMSmq2jqJqdHjpF4ZZuLJd9OYzQeLpI8FD96yyS3y97tQnQuC2cR/eqQw=
X-Gm-Gg: AY/fxX60Dox9IhsuaQrW4z58YM58VzY4q1SNNmXs7PAQz5leRfs4Ci5imWo/sSdEk0y
	fUPsBrgLurdJP1LXc1yu+NQJSBtxtzQR26jcFSLEKKhVI9Bc7IJm4PjD/uoY1+SyjYxOYNdk8G1
	Idj2R/Qr16mAMS+cRK9NFWsmQl6D5czKo0iul3lGkSBqNyUjTaETsRHU4jd8Qi5IIGbIuL/mHtw
	ZCuifoKp0/Y5DDcUZwZRDqO7WsuDBm+YhN6nhMi6wc+phM+QdYqXyF3oNjtqOCPnb0DMk0JmBpA
	vmoHhKnA8eRajApJaQpzI2O2/Du8+V8bWFZ0E1a33uR8/tdB9TyJLJ2GfxqkhXM5bjBzViBo/BA
	mmR2QuVdv4azBv6qEjqGcyETn6YPloqwz9lWazQ66IgnuLoRAnatGtFa0OhU3vdDKBk5xcdY1Qv
	ZhsBZxLEm9HYBBKZYgU3AgCaVyxEoj7ig=
X-Google-Smtp-Source: AGHT+IHCWwWWu16oace00eetULfbyQ1yeoAIFkHbV1aagHIcMBr/qJSFaMSGj9gXlACcTBlm/9/a5w==
X-Received: by 2002:a05:600c:4686:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-47d1954ea05mr132516445e9.15.1766417199600;
        Mon, 22 Dec 2025 07:26:39 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b36fsm22585186f8f.5.2025.12.22.07.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:26:38 -0800 (PST)
Date: Mon, 22 Dec 2025 16:26:37 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: llong@redhat.com, cgroups@vger.kernel.org, chenridong@huaweicloud.com, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v6] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
Message-ID: <bzu7va4de6ylaww2xbq67hztyokpui7qm2zcqtiwjlniyvx7dt@wf47lg6etmas>
References: <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>
 <20251201093806.107157-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jhs6khkmokqkwfrw"
Content-Disposition: inline
In-Reply-To: <20251201093806.107157-1-sunshaojie@kylinos.cn>


--jhs6khkmokqkwfrw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
MIME-Version: 1.0

Hello Shaojie.

On Mon, Dec 01, 2025 at 05:38:06PM +0800, Sun Shaojie <sunshaojie@kylinos.c=
n> wrote:
> Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
> with its sibling partition, the sibling's partition state becomes invalid.
> However, this invalidation is often unnecessary.
>=20
> For example: On a machine with 128 CPUs, there are m (m < 128) cpusets
> under the root cgroup. Each cpuset is used by a single user(user-1 use
> A1, ... , user-m use Am), and the partition states of these cpusets are
> configured as follows:
>=20
>                            root cgroup
>         /             /                  \                 \
>        A1            A2        ...       An                Am
>      (root)        (root)      ...     (root) (root/root invalid/member)
>=20
> Assume that A1 through Am have not set cpuset.cpus.exclusive. When
> user-m modifies Am's cpuset.cpus to "0-127", it will cause all partition
> states from A1 to An to change from root to root invalid, as shown
> below.
>=20
>                            root cgroup
>         /              /                 \                 \
>        A1             A2       ...       An                Am
>  (root invalid) (root invalid) ... (root invalid) (root invalid/member)
>=20
> This outcome is entirely undeserved for all users from A1 to An.

s/cpuset.cpus/memory.max/=20

When the permissions are such that the last (any) sibling can come and
claim so much to cause overcommit, then it can set up large limit and
(potentially) reclaim from others.

s/cpuset.cpus/memory.min/

Here is the overcommit approached by recalculating effective values of
memory.min, again one sibling can skew toward itself and reduce every
other's effective value.

Above are not exact analogies because first of them is Limits, the
second is Protections and cpusets are Allocations (refering to Resource
Distribution Models from Documentation/admin-guide/cgroup-v2.rst).

But the advice to get some guarantees would be same in all cases -- if
some guarantees are expected, the permissions (of respective cgroup
attributes) should be configured so that it decouples the owner of the
cgroup from the owner of the resource (i.e. Ai/cpuset.cpus belongs to
root or there's a middle level cgroup that'd cap each of the siblings
individually).


> After applying this patch, the first party to set "root" will maintain
> its exclusive validity. As follows:
>=20
>  Step                                       | A1's prstate | B1's prstate=
 |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      =
 |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      =
 |
>  #3> echo "1-2" > B1/cpuset.cpus            | root         | member      =
 |
>  #4> echo "root" > B1/cpuset.cpus.partition | root         | root invalid=
 |
>=20
>  Step                                       | A1's prstate | B1's prstate=
 |
>  #1> echo "0-1" > B1/cpuset.cpus            | member       | member      =
 |
>  #2> echo "root" > B1/cpuset.cpus.partition | member       | root        =
 |
>  #3> echo "1-2" > A1/cpuset.cpus            | member       | root        =
 |
>  #4> echo "root" > A1/cpuset.cpus.partition | root invalid | root        =
 |

I'm worried that the ordering dependency would lead to situations where
users may not be immediately aware their config is overcommitting the syste=
m.
Consider that CPUs are vital for A1 but B1 can somehow survive the
degraded state, depending on the starting order the system may either
run fine (A1 valid) or fail because of A1.

I'm curious about Waiman's take.

Thanks,
Michal

--jhs6khkmokqkwfrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaUljKxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjK4gEAnmAgBR1zluxVRUWU0Xru
zJo9m6L+TLwXGPFVZC4ECHIA/0oinQGJZ9xsp1tBSb/gmb/xtN+FH6zyZye1Eppu
e1YL
=XUDG
-----END PGP SIGNATURE-----

--jhs6khkmokqkwfrw--

