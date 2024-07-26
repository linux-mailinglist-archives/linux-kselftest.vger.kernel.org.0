Return-Path: <linux-kselftest+bounces-14272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C0893D4F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 16:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE971C23470
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C1AD531;
	Fri, 26 Jul 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ch18Qs3t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF77C2FC
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003410; cv=none; b=DGb53UlvkIErcFQl2s8HMQ8m5Amdax2mUpjF5JYgZ043hmlp4DdfBK1EvhDX6qUyA3GI7yRrQ1DzedgGh1Fjw9DHsuCRdcqGd72C3lUeD+3aRcQl/FJ+Ea+K5L2TOa05vBi6vOUNZaoAAC/Ugxszf53qizatJ2PtF4o3RWZvJZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003410; c=relaxed/simple;
	bh=/aRBj8gcVySAUOhon8d8YEQA80L7jcgkcO62EB32xcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkWkQniMv2qPZkMlJj/1u9ruKJ0bWaMLwPiYJB+p4MU/E919tPKoPAwRV6u9E84Dg61gEwNPlCcZgOnJ5SvfF6YPhKgBf7hcRgioG7/NSLysD95DJn5PoFCly7u0T0kqzEi0X9Urz3jmBhV7zQ7l3d0EUA6O/HBccfG4slZ32hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ch18Qs3t; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so15715151fa.1
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722003406; x=1722608206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=emG34p2KtXPh2/ovuwXCfVp++qU/JuZyzHPenM9H+PY=;
        b=Ch18Qs3tjR29iDaueXBuy29axdGM/bg/ZABY6GhVN16+gUn0JUlKSqHcz+O1IIWX/R
         235OeEjwy1pnAdqnqwwDgDAN5iGt6wo3jfYJjD2Bn8eehONrO8SvKF+JJcWp4ibMISPs
         +DpIrWcv1FyAtPYXhMuO+44kVZ7iUcy7czc1qmTsuhSDCCIdm/oYqTe5GqpKuv3xxdeo
         NTvJ3DPw/sA+0ks7nN+VOapIyj2/1MKUmDSAIEW0XMuO4gKmQa6gMBIn41iIKB81gd8+
         C3gd9FjMGjXJnHRVwNCNoch2c3wInCtLTWZRdafuTSQYv2bvRIuqcDcGytfPQCzRD8Vm
         jKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722003406; x=1722608206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emG34p2KtXPh2/ovuwXCfVp++qU/JuZyzHPenM9H+PY=;
        b=Mz5AchqPZYJxGzkGpOJpttRW8oiGYHVkhbFJJKGa5FuwtgMQjYBsenMpNslAziUUpD
         PUkPh5pyNJ9Nmrck7SKsTiKyHHUWCFD3Czo7P8qnx2hxbny4tBbMxQ/SmJ10xSET56RH
         7kh/D/6x39FdJLgw9OEou7wSrj30Xf74fd7qUn9IzL+lI+onP0iE6OU0pGhA6sCIn4F+
         RqdJY+s0BegVawgvaruY1RACeH8u61NSnjZNUgapUehsYmJX0PCBbOZaazzLIVgPDyqP
         0xRfc+0SRAp12h0yrXiOAK47I8RLuFvoPtNo/9Lo94lMABiZJ+wxSkKeHp5pcz2HJKNn
         6lZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE/z7NMeO15U45GF/FGYqGMrSCpWG0v8zFfGcV6eb15p68mGqHPoLC77qGtXrLZGRKOg6kHuBB1wz+v4yRWExFJvtn05LuwnnuC/Kekbvi
X-Gm-Message-State: AOJu0YykFHg2rB6e62E1U7XixwKL2CNd8BcaNi87iaLAPKrgYixPCwPj
	RUpxaHEGAikKYoiSmcbxOYutwN32FG5uDOu9iX84zeRKCVVH/9kLd+2kyqrb3Rc=
X-Google-Smtp-Source: AGHT+IGHaC/vCMAwHQtpOlOyOmOZd/8WjC/q/CatNKzI+1VerIf0vdYnC2mTlv+ySWYpRDYmYfilhQ==
X-Received: by 2002:a2e:9f13:0:b0:2ee:87e9:319d with SMTP id 38308e7fff4ca-2f03dbf2872mr39751641fa.48.1722003405879;
        Fri, 26 Jul 2024 07:16:45 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c7b0b3sm3538344a91.15.2024.07.26.07.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 07:16:44 -0700 (PDT)
Date: Fri, 26 Jul 2024 16:16:33 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: David Finkel <davidf@vimeo.com>
Cc: Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 1/2] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <5xlwzzz3gs4rk5df32kfh7fx5ftj3a4iwryqxdb4c3oniuehwk@d5kum5xr4uw6>
References: <20240724161942.3448841-1-davidf@vimeo.com>
 <20240724161942.3448841-2-davidf@vimeo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="okcpuwvp3anv55ri"
Content-Disposition: inline
In-Reply-To: <20240724161942.3448841-2-davidf@vimeo.com>


--okcpuwvp3anv55ri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David.

On Wed, Jul 24, 2024 at 12:19:41PM GMT, David Finkel <davidf@vimeo.com> wro=
te:
> Writing a specific string to the memory.peak and memory.swap.peak
> pseudo-files reset the high watermark to the current usage for
> subsequent reads through that same fd.

This is elegant and nice work! (Caught my attention, so a few nits below.)

> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -775,6 +775,11 @@ struct cgroup_subsys {
> =20
>  extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
> =20
> +struct cgroup_of_peak {
> +	long			value;

Wouldn't this better be unsigned like watermarks themselves?

> +	struct list_head	list;
> +};


> --- a/include/linux/page_counter.h
> +++ b/include/linux/page_counter.h
> @@ -26,6 +26,7 @@ struct page_counter {
>  	atomic_long_t children_low_usage;
> =20
>  	unsigned long watermark;
> +	unsigned long local_watermark;

At first, I struggled understading what the locality is (when the local
value is actually in of_peak), IIUC, it's more about temporal position.

I'd suggest a comment (if not a name) like:
        /* latest reset watermark */
> +	unsigned long local_watermark;


> +
> +	/* User wants global or local peak? */
> +	if (fd_peak =3D=3D -1UL)

Here you use typed -1UL but not in other places. (Maybe define an
explicit macro value ((unsigned long)-1)?)

> +static ssize_t peak_write(struct kernfs_open_file *of, char *buf, size_t=
 nbytes,
> +			  loff_t off, struct page_counter *pc,
> +			  struct list_head *watchers)
> +{
=2E..
> +	list_for_each_entry(peer_ctx, watchers, list)
> +		if (usage > peer_ctx->value)
> +			peer_ctx->value =3D usage;

The READ_ONCE() in peak_show() suggests it could be WRITE_ONCE() here.

> +
> +	/* initial write, register watcher */
> +	if (ofp->value =3D=3D -1)
> +		list_add(&ofp->list, watchers);
> +
> +	ofp->value =3D usage;

Move the registration before iteration and drop the extra assignment?

Thanks,
Michal

--okcpuwvp3anv55ri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqOvvwAKCRAt3Wney77B
SSX4AP0RNpLzSpS7VepJJSXO0cnglvhT9aA/V5Q9ijokaiYGuwEAgKlJXbpvECDK
iorTeuqInwN7G90wCzeqJItD9aQVAA0=
=/LdG
-----END PGP SIGNATURE-----

--okcpuwvp3anv55ri--

