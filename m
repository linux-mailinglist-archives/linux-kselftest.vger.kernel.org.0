Return-Path: <linux-kselftest+bounces-48739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 362DBD1212A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 11:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03F3B3036AD4
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A545234DB53;
	Mon, 12 Jan 2026 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FbpRmhZx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F41134D4EF
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215074; cv=none; b=El2mexJwyM/zBl+Frr8+Mg90tkI1RqVM7fjW9N+WD4Edo0qzp2IzrdoimsbbckT5EW9vok0O/VjuT1OblsDrlYE4MiL2IFFg4/pFkb3czKkcgG5OO/PEYWMwox1ztJZFftd35QsUvIT3l8UJYEYx2mahF5Nuu9NXBFCtO7tszWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215074; c=relaxed/simple;
	bh=d2stOG09yHhXfcz1z58368ywCaRrCh7SQR2/JCWJnCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cvl0NGdNICH3mmDkREaXBGRuko+gMPLAiZH7tLKLJrbHI2ByTyrIGXa36GJTQ6gwYgN9b8qz156GruUaW5EIA7EXYsKJ3tEElcoX1vsUnpBeDua68j1DW2YiCR+VfmuqrRby9Ame/sH6UzEjJhkog51MrFQE5RF5fMz2g1elQr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FbpRmhZx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso67127785e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 02:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768215071; x=1768819871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BbnNA/ao8/3Ln3FmkTUo19ha4VBC3QnDgXcQ8RvPuJA=;
        b=FbpRmhZxFqFL4BpKaF3UEL0Q6vVK6GuyNq7JavFW9XJ3pxnlDCHmrx5x8ZxwbzEtV9
         Xsn2dVnCvn99BqVK/22Yh6g2gTSUewOZqP7hywuEblaHLTMNBdxf2mYCMbS9KxbUMBXH
         3sqTMSr6skz7eXU6nNTWyKfmnNo2BmhtwbrF8Jgt3MMQ+xhMymRdhFGBj1duMNfVUVXw
         yo0HfKcqpSAsUCeaYaJAFPIlWBA/sOf730153MXOi7SS3me+IP4VBxqU3yHn5plzwDef
         B4eJynKe+BGQdzXlod/ed7790FXejMXtMwA/iVe7E7bqTtcgDMe56eH5dbsrFRh5E6fR
         4RRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768215071; x=1768819871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbnNA/ao8/3Ln3FmkTUo19ha4VBC3QnDgXcQ8RvPuJA=;
        b=tGKBc/8jwOIlAxoeWtxqKLkMlkmXGrt7Fx5ULEsGuR6mmDLHOtcZZSCNnWgyQcX/1w
         lczTMXxMS53+cmGQuthB922miwMoMkjsTrmdvyRpeyd4H3HjgM3tmRLG/i+3LyGHl9xS
         c7l3s6LJhQAlslDIcsR3go40jX2/M0RUnPYl5/6kPqOy05fWHJLc9N5l9KT71uiztRz+
         ckUGuCgHyU/SARzne1RpvluJwnBob6+rdXEbxT0LukvNCgDUG0s7Xc5X74ggVG+eTh0Q
         1Y/LOyTK1jrsFc77Qh4WpGntVsBicD+0sp7jfKxZmOTeLdL17FbJ13YnfBabdbaMybMZ
         Lozg==
X-Forwarded-Encrypted: i=1; AJvYcCVY0Qt36R7RmdgiaiLLzXSbajckpbcldu24Ft6KekG/Qpw3is9LfOHkkA3824q97uRdRerpzSlFPR0+7nIzsog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxgHujzNpnAPCLr6zAJ09C8wluixBXSg8HHs+Pm5y1WjN71BGB
	BGmCQa3H4fazViyT8M2ra4ivol9U/AGHX71U3i2l0qDBFQXB0VSETIUpV046PvaTP7g=
X-Gm-Gg: AY/fxX6PBXZoEqNF2IYSNaJqeBdpXT1R/grDyc88T7xCRerZ4Y+UehAh6lRDTwRJs5V
	olEn0ccLJ6Cn36yTYV36VXeO4gJ04f903Z6/XT2IkNOMaE1B7lHhgNMb8TcFqmSdCdTiJJUXAUI
	pm6hsQ1RQEu4pAIC0JUGTUOyuiM4DZxZljHDUqrD0eDGyCtyBitquXZTCQLEhpoc4DuREYwp8Ss
	mJq4O45EJuOsOIeEichnA65TKESoTqRXFLgJum9epnVihhLxsIOgHP9Fo5xVXUbtgx/txVoxujs
	3Njro3FhYUrs3a/pYTrnhyyzKiwuwd/SfkOCya+OkHeBkfF/eeeCBJPxAtJp+X+PoH5nUfu0EzT
	1LF1OdtokEfOjZI7NXogQMHI57kFk4Q1mlgxYyZ/UfN43tHCWFj3ncmi6vzboh7ApiI618MeSr6
	Rw+mvjZunsmXYccJEwsIQf65BYO0FG82Q=
X-Google-Smtp-Source: AGHT+IH+Khm6su1F8LUf1cesIsikszUVjZeLHQaUjpzyZCvwEGQobilC3JrtRYG8ZH5GDGKVjZ91jg==
X-Received: by 2002:a05:6000:613:b0:431:855:c791 with SMTP id ffacd0b85a97d-432c378a0e4mr20292971f8f.3.1768215070936;
        Mon, 12 Jan 2026 02:51:10 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e1adbsm38477364f8f.17.2026.01.12.02.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:51:10 -0800 (PST)
Date: Mon, 12 Jan 2026 11:51:08 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Sun Shaojie <sunshaojie@kylinos.cn>, Chen Ridong <chenridong@huaweicloud.com>, 
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH cgroup/for-6.20 v4 4/5] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
Message-ID: <2naek52bbrod4wf5dbyq2s3odqswy2urrwzsqxv3ozrtugioaw@sjw5m6gizl33>
References: <20260112040856.460904-1-longman@redhat.com>
 <20260112040856.460904-5-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5j3aaen3y3pbtxcu"
Content-Disposition: inline
In-Reply-To: <20260112040856.460904-5-longman@redhat.com>


--5j3aaen3y3pbtxcu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH cgroup/for-6.20 v4 4/5] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
MIME-Version: 1.0

On Sun, Jan 11, 2026 at 11:08:55PM -0500, Waiman Long <longman@redhat.com> =
wrote:
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
=2E..
> @@ -2632,6 +2641,9 @@ Cpuset Interface Files
> =20
>  	The root cgroup is always a partition root and its state cannot
>  	be changed.  All other non-root cgroups start out as "member".
> +	Even though the "cpuset.cpus.exclusive*" control files are not
> +	present in the root cgroup, they are implicitly the same as
> +	"cpuset.cpus".

cpuset.cpus.effective (that one is on root cpuset cg)

(This was likely lost among my v2 comments.)

--5j3aaen3y3pbtxcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWTSGhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhAKQEA5MnoTf/ZgNMJd2RCvY+5
T8yKXr1El8dcvCqPe2apCssA/Rojz8LiubJgbDgSox/wtvX4dX+cs6YxgNKyvD3E
COQJ
=UJle
-----END PGP SIGNATURE-----

--5j3aaen3y3pbtxcu--

