Return-Path: <linux-kselftest+bounces-36531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E75E0AF8D79
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524281C201AA
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3962F546D;
	Fri,  4 Jul 2025 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C/9UCwZR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF32D9ED1
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Jul 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619561; cv=none; b=uuj0inPJSVbGurchHz8RGYt790idjxMPIuSgFOSJGKST6sm3BWoEahpUuY2nKASO6pTmQZJbcgO0bk4E749q45R691yVgC9Xx16fYe7mb39WJYMABxiexx4yqS9Tz41KnHZmG88rXoZ6+YNRlsrIdY9hZLmnJAf8HHg3qq3CLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619561; c=relaxed/simple;
	bh=RtBX/y+Ve5mo6ucrAlWB0PpuZcZ3vU5B/8m0+PvvwUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJvXPQlDK6+MVdLdlTkOuNNFmG3C4mWg8kPLqoE5aQl8Ol78Qa1Kixe8OvKLvjqs94BHQsku+MKtii0a0XjAZlTKCRJMePot+8cnfc89pOaTbaNOYiszbefBnKl+giL+1SD8sSWR3Jd5l66WHy3Hdk31YldEV2LGzazMa98N59k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C/9UCwZR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4538a2fc7ffso12686625e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Jul 2025 01:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751619558; x=1752224358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RtBX/y+Ve5mo6ucrAlWB0PpuZcZ3vU5B/8m0+PvvwUY=;
        b=C/9UCwZRhzh2h9VFjukR1sGrscYv6RT4DFoWoL++PXX0vgS0tW33fL9R8hQt2yq7Pa
         GVF+vNUeKlWZVuqQ2gsrEIR/cK2UP1iWK6tx8kBGzzLpElOkkck+vw8bkiVL40kCUKmu
         dfgBKO0kNnlsWsCFu9IGmGmjMJiJFB9PWUwlpbZqMsfkBkbIEdFNy5XwFyPPqnOHjWVT
         dSEQVGQyc8VrOO7/38SK373J5snJs+0Lc/C0NowLXLg/0yq/oZ1hr7zKuuDoiiXHzr0P
         sU2nbv/XEO/g/rPnsa1NpOaDr9f4Vs/KmikF30l9RS/aF2Vin225xHS1Jx3CYs9adoTj
         6Y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751619558; x=1752224358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtBX/y+Ve5mo6ucrAlWB0PpuZcZ3vU5B/8m0+PvvwUY=;
        b=bnwFYb6dfJrcxSCXJOj8KWJ2MLgUO2F3RYyJj1WLn9x6VPoK8iNWwmOCIIUTzP7Mr8
         zsyhR/9l6xx3xy1uWwEhNnp7YEHcZCgnRp4FC3efwN9F7+4oBjHal+Myb6TnCVzgzBjv
         mBNyEktucKylzn4qR9OX9k24JG+ambZiGQH8lr7pxGucdfNhgYznBSYDLwPEordI7EWy
         zlyNrL2JmW16t20WYPfGC0hrmUqGRcmpA4XrEeXBMOczjMgriL1ZOhea5gIiG3pXefZB
         9ZVBBMb38pJlq3Xbw4tObuDYIlwBrCYN7lpxL4/BgS6OokGK7ikeCpAWIeAZVKbnyXPv
         tn+g==
X-Forwarded-Encrypted: i=1; AJvYcCX3ZWEA9TRpXU/I8qOFavW5PizfrURVKYjKQVmNpdVneRAqPGu4wV5XrcTsmD1k9K9nKOstNvkrTwRUTFfuRoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDp9FkYk3fPMze2wFc2aPs0M3BetVJgyqyhkDsZEdHKI5V8l3F
	l1/SKGwh3i1WqYN0uynm0SiIDnyz5a6YzEPUM4jRGCjtLqNiCdxNXVaqQ+JWoJNgmKk=
X-Gm-Gg: ASbGncuh2zwGynLCiyJW0a54eZXUzoix6ogOpmcc4BKA2zoBOGyLDKb70TWEB3HTJDE
	Cuv2msoCZd1dh6k8cS13lcqhncUSKCWPYljzsHbwtxJxE859bBXArWsHmuT6poY+RflHgui5bBu
	7IScqk90cpjW5+Aas/GCOtn/zBfgsC79pCFhbh2RMWkgYbm9BNjo3ajTGnRFVF514xjCwD/vBUS
	+jfEm6whlLEgSETWdfJHu5/AerD7O+lDOXvEM1vb5wa2IpPRK/+bVX5QtEQKehKqsC1JAT2qW4L
	dkZxKVARIQHJuFnV9lPmF5ZwbcTyODi7h0GBp556l+YESoKHpRj70jSJ4MLPw1ZV
X-Google-Smtp-Source: AGHT+IHk+/ZtizhuGIV28UjPzSfcidKD4/ilLS1E945vX5eRGKp0+eSorZPrB0dr5aqNr1TTDTMsJA==
X-Received: by 2002:a05:600c:c173:b0:451:df07:d8e0 with SMTP id 5b1f17b1804b1-454b26d5305mr20631295e9.11.1751619557692;
        Fri, 04 Jul 2025 01:59:17 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b168664bsm20865265e9.20.2025.07.04.01.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 01:59:17 -0700 (PDT)
Date: Fri, 4 Jul 2025 10:59:15 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v2] selftests/cgroup: improve the accuracy of cpu.max
 tests
Message-ID: <wnoymxwdikh6iawrcvhewq6er4si75oqzjdbibhl6n57swq3ff@glkzfmbaots7>
References: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
 <20250703120325.2905314-1-shashank.mahadasyam@sony.com>
 <l3sal6zkvo4lqnfs6fepxytnrmqmqwfvtxudnjm53oigtuatpd@7czfeursgwyh>
 <aGcf0Prl-hVX2j4Q@JPC00244420>
 <aGd5lrUvm9Bhh-b8@JPC00244420>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cgb7i3ddllgbyu6p"
Content-Disposition: inline
In-Reply-To: <aGd5lrUvm9Bhh-b8@JPC00244420>


--cgb7i3ddllgbyu6p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] selftests/cgroup: improve the accuracy of cpu.max
 tests
MIME-Version: 1.0

On Fri, Jul 04, 2025 at 03:49:58PM +0900, Shashank Balaji <shashank.mahadas=
yam@sony.com> wrote:
> > 1. We don't need to separately check user_usec because it'll always be
> > less than user_usec^W usage_usec, and usage_usec is what's directly
> > affected by throttling.

When kernel is not preemptible, I'd expect the system time may more
easily excess the quota, so I considered the user_usage check less prone
to false results. But...

> > 2. I changed the >=3D to > because, not that it'll ever happen, but we =
can
> > let usage_usec =3D expected_usage_usec pass. Afterall, it's called
> > "expected" for a reason.
>=20
> Hmm, here is something interesting. The following patch adds printfs to t=
he
> existing code to see what user_usec, usage_usec, the expected_usage_usec =
used in
> the code, and the theoretical expected_usage_usec are. On running the mod=
ified test
> a couple of times, here is the output:

=2E..thanks for checking. I was misled by the previous test implementation
(the expected_usage_usec had no relation to actual throttled usage in
there). What you observe is thus likely explained by the default
sched_cfs_bandwidth_slice (5 times the tested quota) and CONFIG_HZ.

So I'd say keep only the two-sided tolerant check. (I want to avoid the
test to randomly fail when there's no gaping issue.)

Thanks,
Michal

--cgb7i3ddllgbyu6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaGeX1wAKCRB+PQLnlNv4
CDdMAQD0QmAwbde3igaQ/8POl0VsZg2u5gJzrJWD6ze4/rwyjgD+IVyNr8dbp46k
jKAf0PBvwEitji6q94unBh1qxC0ZgAw=
=Aigg
-----END PGP SIGNATURE-----

--cgb7i3ddllgbyu6p--

