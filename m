Return-Path: <linux-kselftest+bounces-48554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E54D05BA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 20:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48D09301C918
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 19:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE44322B79;
	Thu,  8 Jan 2026 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EbK0dhYz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B01320CB1
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899049; cv=none; b=dkPEoL5gjf8S33GQDabFm7OfBPboSBfmcj40/CA7veVsc0597ZP56amRDOoatkbUBN4uqV/5Zlrh4J6nKlavaTqy96Q1aV2lOUXNr9IZ2NC7EseUmfeGqjTBwljXEZLwncgHYye3BFDa9tFaw0pUBl8xSizWcSuM2zA5XEUwXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899049; c=relaxed/simple;
	bh=S12pBgkM00sJgWSyCC4FkH4Wm/puv/dLWj/scQoC99g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVmtt6IvS5Hfh3XtiO30x0CjUm82uK2QeqY//saev/5doZW/K3D1aqQvIZtaSTdms+kinMr3smXsSI2Z8+MbLWJnV9vufnBkljT5DjfynIoXAae15+ZpMQbtIualDsTjLluofypiqE6dqvhS+zOH/J10LHF9gp1t5vVk+fd2hX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EbK0dhYz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-430f57cd471so1860185f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 11:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767899046; x=1768503846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZk8shAToyPHM8UaZssBAOmYkCAywr9xb/VP5NyVsRI=;
        b=EbK0dhYzVojwnPPj08VHnVT19WhzhbWlWPfkl99lgasOaAOE35Gr2ivnr4OPSK/k4v
         Wp5m/ddBsD3+g5RvY2zfV9QkTNYNkKxcpHT/ayK7R4AIgi+7DaOj22vvEfaNEGqJbVn5
         TD1b2yZmQRp5Uru9Kheb/NwtS4BYcW/Mjaib4/o5oD8VED4W89AicSezlMhi8leaVHh8
         0w2UV8CIWzVJilXtnbXiweq0jGuXNTfAVYnDr8RkYbUhN5zoaVpcuvhIpa36emfGWUU+
         UjTzR52WyS0OYe9MN+cTLvAEBxwgDr2qDkNBXy6LDO/gcGI75GEl2J53z+Fzj0whd7fS
         zFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899046; x=1768503846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZk8shAToyPHM8UaZssBAOmYkCAywr9xb/VP5NyVsRI=;
        b=T93XNr2ch/kt/9j1+2iFtcKzEuPGF23/8eGfabIP+04NGKl26v2vH/4jO5F+M83tIS
         NorGf4FtiiHAwiUF5YJyDUZ9f9/yOVk1dZViRUSyIjKWZa/bDI8UPYeQ/AVshU5VwydH
         uY2UtivTXkHl5ffQvEAk0VQuTjfe077iAGehhRs/8pixen4/9hIWTmejUsnZwmiUNEWT
         /Lg+fR/uv45r0rYI2L1GJwlAYSU5+2I/nIyQzt8qzupj8dRy0Kd/gFGoOkHaSO/njfob
         +sN3xhbU1vkVYyrNi77yYtcRlANqOV1WXAA8OncAqNz7swqrwbhJH/1NpdnzY4Al73Mq
         uyGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDinbICWvXNoF8NvgJwilLB2YxnVn1ssxJ9TaffEN2mHC3/tb2Yq2Q2+oBwL0wrp/3uWIUpBXO+MBTwC8Ro4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFosFRqcgFeFibE2UnqGk+I+lEKPgqyjz/r5e/MKfnIMyOVVyq
	aY2IdV4xHM3YIzFIGmBMAMRViwID8GX8wEADCrAeW7z8JMEFde0bA+EZQxsanNQqwos=
X-Gm-Gg: AY/fxX74Lh3i/FDFwfkgRoSf+3lq7FQ1j/ihgnxxJPOYqNz8nWAt7tdY7IcErKUoJgh
	x3vym1Os+Fi6B/1bo6HSlK705vl0/DlFtOyG9f98JpfibZ5AciWhYZV5+7Tm3Y4EmUCy45nASsD
	eDcBBmkHEJkm3UrjfpAGJjYlzMfVyc5OrzF4E3vVpMPePpOaMFXX2YCZluOk6B7TTpUvzDmyuCf
	ipdNwh+Zs6ReGoMk9JoAgV4RYRBUqV3aLrqzHZSVqXx8AZ9KShvMVYkddrgpT44XkpAmGJWPF1V
	hyxN5eP5Ia7/tMZQEaZC38+hXOLqYyV/OZZM2Kq7xvn7CzS0sPAIagydrzrl69K1pEsW0goLzSq
	Ttgn1ajIfmcZ/XmzwJ0yaXtVo0tLn3mT95o98CZrwGMts3Ct/sgB9qR3LYzW80JradEms1jVmig
	0ENf1f4i2vO1Q5TeNC8lKItNHFn1i+fpA=
X-Google-Smtp-Source: AGHT+IE4b6xRdNURXAWWpyFhWm/3C4nzAZftETaWGTbobTlLIsQkJxHqXKOQjLz13Zvy5+0CZcW5yw==
X-Received: by 2002:a05:6000:290b:b0:431:266:d150 with SMTP id ffacd0b85a97d-432c3761103mr10035954f8f.44.1767899045993;
        Thu, 08 Jan 2026 11:04:05 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5dfa46sm17922112f8f.27.2026.01.08.11.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 11:04:05 -0800 (PST)
Date: Thu, 8 Jan 2026 20:04:04 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Sun Shaojie <sunshaojie@kylinos.cn>, Chen Ridong <chenridong@huaweicloud.com>
Subject: Re: [cgroup/for-6.20 PATCH v2 4/4] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
Message-ID: <chijw6gvtql74beputm3ue2zu2vmrwvtg5a2bn3wabgkqldq4d@obrdh4znejaw>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-5-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ixtbe63ri56p3pp"
Content-Disposition: inline
In-Reply-To: <20260101191558.434446-5-longman@redhat.com>


--2ixtbe63ri56p3pp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cgroup/for-6.20 PATCH v2 4/4] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
MIME-Version: 1.0

Hi.

On Thu, Jan 01, 2026 at 02:15:58PM -0500, Waiman Long <longman@redhat.com> =
wrote:
> Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
> with the cpuset.cpus/cpuset.cpus.exclusive of a sibling partition,
> the sibling's partition state becomes invalid. This is overly harsh and
> is probably not necessary.
>=20
> The cpuset.cpus.exclusive control file, if set, will override the
> cpuset.cpus of the same cpuset when creating a cpuset partition.
> So cpuset.cpus has less priority than cpuset.cpus.exclusive in setting up
> a partition.  However, it cannot override a conflicting cpuset.cpus file
> in a sibling cpuset and the partition creation process will fail. This
> is inconsistent.  That will also make using cpuset.cpus.exclusive less
> valuable as a tool to set up cpuset partitions as the users have to
> check if such a cpuset.cpus conflict exists or not.
>=20
> Fix these problems by strictly adhering to the setting of the
> following control files in descending order of priority when setting
> up a partition.
>=20
>  1. cpuset.cpus.exclusive.effective of a valid partition
>  2. cpuset.cpus.exclusive
>  3. cpuset.cpus


>=20
> So once a cpuset.cpus.exclusive is set without failure, it will
> always be allowed to form a valid partition as long as at least one
> CPU can be granted from its parent irrespective of the state of the
> siblings' cpuset.cpus values. Of course, setting cpuset.cpus.exclusive
> will fail if it conflicts with the cpuset.cpus.exclusive or the
> cpuset.cpus.exclusive.effective value of a sibling.

Concept question:=20
When a/b/cpuset.cpus.exclusive =E2=8A=82 a/b/cpuset.cpus (proper subset)
and a/b/cpuset.cpus.partition =3D=3D root, a/cpuset.cpus.partition =3D=3D r=
oot
(b is valid partition)
should a/b/cpuset.cpus.exclusive.effective be equal to cpuset.cpus (as
all of them happen to be exclusive) or "only" cpuset.cpus.exclusive?

> Partition can still be created by setting only cpuset.cpus without
> setting cpuset.cpus.exclusive. However, any conflicting CPUs in sibling's
> cpuset.cpus.exclusive.effective and cpuset.cpus.exclusive values will
> be removed from its cpuset.cpus.exclusive.effective as long as there
> is still one or more CPUs left and can be granted from its parent. This
> CPU stripping is currently done in rm_siblings_excl_cpus().
>=20
> The new code will now try its best to enable the creation of new
> partitions with only cpuset.cpus set without invalidating existing ones.

OK. (After I re-learnt benefits of remote partitions or more precisely
cpuset.cpus.effective.)

> However it is not guaranteed that all the CPUs requested in cpuset.cpus
> will be used in the new partition even when all these CPUs can be
> granted from the parent.
>=20
> This is similar to the fact that cpuset.cpus.effective may not be
> able to include all the CPUs requested in cpuset.cpus. In this case,
> the parent may not able to grant all the exclusive CPUs requested in
> cpuset.cpus to cpuset.cpus.exclusive.effective if some of them have
> already been granted to other partitions earlier.
>=20
> With the creation of multiple sibling partitions by setting
> only cpuset.cpus, this does have the side effect that their exact
> cpuset.cpus.exclusive.effective settings will depend on the order of
> partition creation if there are conflicts. Due to the exclusive nature
> of the CPUs in a partition, it is not easy to make it fair other than
> the old behavior of invalidating all the conflicting partitions.
>=20
> For example,
>   # echo "0-2" > A1/cpuset.cpus
>   # echo "root" > A1/cpuset.cpus.partition
>   # echo A1/cpuset.cpus.partition
>   root
>   # echo A1/cpuset.cpus.exclusive.effective
>   0-2
>   # echo "2-4" > B1/cpuset.cpus
>   # echo "root" > B1/cpuset.cpus.partition
>   # echo B1/cpuset.cpus.partition
>   root
>   # echo B1/cpuset.cpus.exclusive.effective
>   3-4
>   # echo B1/cpuset.cpus.effective
>   3-4
>=20
> For users who want to be sure that they can get most of the CPUs they
> want,

Slightly OT but I'd say that users want:
a) confinement (some cpuset.cpus in leaves)
b) isolation (cpuset.cpus.exclusive in leaves)
c) hierarchical organization
  - confinment generalizes OK
  - children can only claim what parent allowed

Conflicting exclusivity configs should be no users intention or a want :-p


> cpuset.cpus.exclusive should be used instead if they can set
> it successfully without failure. Setting cpuset.cpus.exclusive will
> guarantee that sibling conflicts from then onward is no longer possible.

I think the background idea of the paragraph (shift away from local to
remote partitions, also mentioned the other day) could be somehow fitted
into the Documentation/ hunks.

> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> ...
> @@ -2632,6 +2641,9 @@ Cpuset Interface Files
> =20
>  	The root cgroup is always a partition root and its state cannot
>  	be changed.  All other non-root cgroups start out as "member".
> +	Even though the "cpuset.cpus.exclusive*" control files are not
> +	present in the root cgroup, they are implicitly the same as
> +	"cpuset.cpus".

Even "cpuset.cpus" have CFTYPE_NOT_ON_ROOT, so this formulation might be
confusing. Maybe it's same as "cpuset.cpus.effective"?

Thanks,
Michal

--2ixtbe63ri56p3pp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaV//ohsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjFcgD/befAIpWDsnrIRvSGMNh7
2ZNzdia/UxMmNfbALez+7vQBAOiQ6u9XV7+K0KdPF27pphDL7Ro9/wghUgiQ+qBM
f+kN
=RCBX
-----END PGP SIGNATURE-----

--2ixtbe63ri56p3pp--

