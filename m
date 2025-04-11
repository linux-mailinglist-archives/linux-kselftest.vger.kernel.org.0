Return-Path: <linux-kselftest+bounces-30616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C11A7A864AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 19:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38C88A4C99
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 17:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3D4230BEF;
	Fri, 11 Apr 2025 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fKnj3fFD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196E5230BF2
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392174; cv=none; b=AF8KvUNOeOvfkeBrMS5KJ56XNBCp7ZAkfrXauq5SLTQGBiYJk8Eg2gZhIzHgxeaK/2b0fOEYvuco4euTJwtHMPSDhKPjG0exz4CZ7DRA+z6iM1fL9lTFMOuKa8M9DhJQQ8kKayZsy3YL3TclrOk0DYAXBeHLzIKI9R4zrW0uBi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392174; c=relaxed/simple;
	bh=Oc4xdSup33Ao3nyy/kmkHgKqOdaTNT3JHZQu3SVOEbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijREjq6+EV5l+SLdMkap+OrmNiYJF+2BGAb82JPqiM+sGIDtg2HKDZV4e98fPAyI2JmtYNodKHrlUOlSGe4uZJ0Uu2uUIHfIEFW6CjI6Ye1/qzu7Fwr89qi58BNcbbvhe6CUJydaDzaMgY1r/FkI17AuVwjfPAjZVL96tPr+yRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fKnj3fFD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394a823036so22758275e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 10:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744392170; x=1744996970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HU2gsnS9ySnckXz9WXV/Vzi+SMdE2T2Oy6WWzpMls7c=;
        b=fKnj3fFDeUHlv56PJnuWYqqLvnxftV7k554Ypp4k0281DepnW1n/zw/r/GabY7GX3L
         ZpAYhT6ofNGF2xKgZjVuz1k0j3accS9FOmmacpV1fnxI405zIgep2XzzgHEAxub4kABD
         lIRa+UaRBX8sp1YpP+zUuuFCpZyfmaLBkrCnpptIqr2kim3z/sL5DL8bnJ5zd760twnO
         RNnSgyoTFmIiyeyi5I5ZzKkA4CnozkSBCetaLeI66mmN8PKfGBIWfLm0gVnEuNVNFPKR
         g5HzegKHXP/9PxUKMsH1SiYNU/IcObEmTfHty4OoDbEcgpFP+mdVU4YlfSlNo0OwvpFI
         WWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744392170; x=1744996970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HU2gsnS9ySnckXz9WXV/Vzi+SMdE2T2Oy6WWzpMls7c=;
        b=scMuyw5uoLiY3LEasWxYyCzGITforpKiMzX4x3O7SI7buO97YdVdA+YxofRmIGRz4h
         IaNNhGcq/udhXFQYJlABTvdD/qndqpAL6+1jSDXpseE5/Kbb8c42OFqOn2z5tKYWwikW
         kduTQRpllpUjaTZEzEKk8WwRwHoQBGi78E27/0zWmwn7OODC0tlE9AglI11/dpfORsiW
         rjQg2blXUldOvsBLgGWTI2mcgTavsIJomaTtxQ7/Bzjp9MibkGqj+jSvtH+K7DAlClqx
         z6t23s1O1O72mVgTefYPyRVgMcdwURURBK/Aa3bpwGstBUVJBXoG65b66FqYED/bs0zh
         SnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTPhYAYYT+7R3d00pFCYPIOSjFCHUNXW8MwdnfPMYK2hPg41/25HKTilcHOn1hNKQQFI0OEKE2sl7fGJ2G2Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWAleK2WXcSniEQ0cIBoTregzqbh49djalX2aDAtsPTKbZuDi0
	KDCdqs2c2B22CbVT2MbmNvAiikQi1sR/MEmiSamd7ep8/mLeJplLim8m5zh5uho=
X-Gm-Gg: ASbGncv5t7tNPuFzQ3dUjUvwFZOrTUzaafi807okvlY5ig7UYHF32WcYFhLJbTH8IEo
	OrSYWlz+94wtSU6K7Luo+uzJqC1fwDPdTKkLJ9Wh3gX+OwOLRJ2Ir0S1fdazG6a04uwBhOOVXQS
	nGu/UdRFhWNf89ujXR4MJC1zBdbi8082VOnOuAlJuMA6C2/ABbbWKXecxxdDiqGURZRf5XAiUEZ
	+xKhfppX6NUxUymej/dQ1EEXjvoHBvd+0qC3s0+rhrXwYbhY1YtTUpvQ8Eiy0wf5riIy2Htgf4n
	xTmHAQBlzKFmADnAufAd2xRrFbzMfhCJOWf0loguSoI=
X-Google-Smtp-Source: AGHT+IH5Ui2XolRBPBso1SUsosYlFQ732rqt/TsDuV+AdqLa5keAYbHPUYE8a/OQyeY9sUFkldpWiA==
X-Received: by 2002:a05:600c:5008:b0:43c:f87c:24d3 with SMTP id 5b1f17b1804b1-43f3a9a68c9mr30732585e9.20.1744392170167;
        Fri, 11 Apr 2025 10:22:50 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20626c0csm96273275e9.14.2025.04.11.10.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:22:49 -0700 (PDT)
Date: Fri, 11 Apr 2025 19:22:48 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 2/2] selftests: memcg: Increase error tolerance of
 child memory.current check in test_memcg_protection()
Message-ID: <pcxsack4hwio6ydm6r3e36bkwt6fg5i7vvarqs3fvuslswealj@bk2xi55vrdsn>
References: <20250407162316.1434714-1-longman@redhat.com>
 <20250407162316.1434714-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="flingjnfq7xpj56j"
Content-Disposition: inline
In-Reply-To: <20250407162316.1434714-3-longman@redhat.com>


--flingjnfq7xpj56j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/2] selftests: memcg: Increase error tolerance of
 child memory.current check in test_memcg_protection()
MIME-Version: 1.0

On Mon, Apr 07, 2025 at 12:23:16PM -0400, Waiman Long <longman@redhat.com> =
wrote:
>   Child   Actual usage    Expected usage    %err
>   -----   ------------    --------------    ----
>     1       16990208         22020096      -12.9%
>     1       17252352         22020096      -12.1%
>     0       37699584         30408704      +10.7%
>     1       14368768         22020096      -21.0%
>     1       16871424         22020096      -13.2%
>=20
> The current 10% error tolerenace might be right at the time
> test_memcontrol.c was first introduced in v4.18 kernel, but memory
> reclaim have certainly evolved quite a bit since then which may result
> in a bit more run-to-run variation than previously expected.

I like Roman's suggestion of nr_cpus dependence but I assume your
variations were still on the same system, weren't they?
Is it fair to say that reclaim is chaotic [1]? I wonder what may cause
variations between separate runs of the test.

Would it help to `echo 3 >drop_caches` before each run to have more
stable initial conditions? (Not sure if it's OK in selftests.)

<del>Or sleep 0.5s to settle rstat flushing?</del> No, page_counter's
don't suffer that but stock MEMCG_CHARGE_BATCH in percpu stocks.
So maybe drain the stock so that counters are precise after the test?
(Either by executing a dummy memcg on each CPU or via some debugging
API.)

Michal

[1] https://en.wikipedia.org/wiki/Chaos_theory#Chaotic_dynamics

--flingjnfq7xpj56j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/lP5gAKCRAt3Wney77B
STuPAP9qtXHRJuw6fswvLPcE6FAyBPPV35k6ECqWkmzYm2zgJgD/Q60WvtRy+kc1
RSJih7a7z5QbobgKcZhdynqI/a5/iQI=
=SyIA
-----END PGP SIGNATURE-----

--flingjnfq7xpj56j--

