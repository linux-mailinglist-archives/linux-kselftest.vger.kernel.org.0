Return-Path: <linux-kselftest+bounces-18412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF0D9878ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 20:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F21B26742
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8803B16F839;
	Thu, 26 Sep 2024 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MgU89LUC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3616A959
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727374227; cv=none; b=PWitl02YSxFOw/mu4mikdcJDAC2vN8liiEeoNNmMv3a/7nWX8P5bq7DTp6FxlyRuCS/DgvtFQWQ1nSIh0W4y1TCQIUGpXzatS/54iYqzYYgt9vNkpcbQrYGkxV1PGQeywcE/uMPM/5h/ONqzlMRMPzKQwBYHLfLgGQxRH6BYvi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727374227; c=relaxed/simple;
	bh=ewnJTqnhr/D1CRYjfoJKuDqklGxLFox1zcCUvqUgiSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKEOow33jFu0dm9VanlaYp06o8R6MO+zC7VCeHdM+uyKSY7r6IyfEaoLCJwx/sukikS6OnZUBVj3KtyICmi6WYR0ZSodiR1z5gvqTog4E0/zynj97E7Na5gCzFoc7fClkK6QXrnoxHmMXGjPHUiX8FCEPQR0Y0XdOO/v0Wif8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MgU89LUC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so452421966b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727374223; x=1727979023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TFMfHyAtnvp83pY9c5uE9rNeM6aAhBd46UItlapyOVE=;
        b=MgU89LUCpd9HR+iiYuXMX/vgGIA/uNrZnDOgsf8Y9+PFLFj9Ypy9ZkG/c1w/hoHQKp
         rsH8RtoSiSj8zTRYeXvx73Z8M5FuieI4uhubS/o6A0/TszdQ/bAo5nv8hYUvcs6RWcBz
         QSp3WYQ8xUkSwrYZYJ5YuZg5tqbiTu68J5BQxgA8qLc4aAXiA60jNc5VYWZMA1b982XQ
         mGG4Fh4QJX5OADLFQE4a1FWFLU+9bgJNvdsM3dYtdf6B8VjjHTUcYEK3D1ZCGiAvD16X
         p4TyFBAN2or7NOKdpuidNTfsYkJHbvL3lBfCTrwYpI3RZ3dG2UEMAclzWNGvbBUNPbB0
         AABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727374223; x=1727979023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFMfHyAtnvp83pY9c5uE9rNeM6aAhBd46UItlapyOVE=;
        b=f5iRIIB/BqhbJblWAGvD5yZEM2HMDC7Zr3KmySGcH1HnTI38ewV3J827H3qFTzy2VR
         29ap0fPFSLyWsoPv1kaESW0GIvwt2TWYkiavaYDJqbzA1Wo6hkdw4+LNteA2R5uHFLG1
         +eVOjrLn5b6oH+sL158Z02bsNPOHj28WEpu0M/ht4hNxZb8Lg0DnzMhksXaEW1LeGy0G
         UzeFqg7f8DeqxIa8gb5PqC4IvfID7AK+ezpgCWtCkWoB33j7zzMbkhUvtyqbAFQtmQJi
         WAYKS1j8Kew8o0AytWSSKI6pvdxSrVKeu1CGdwDa0p3OMPyQBCapsY+bTTrKGK9fAo4S
         MS1A==
X-Forwarded-Encrypted: i=1; AJvYcCV/y9otqWh+x11vsxvaH2kbPHl6pYyGGdoqsel7ys6mhtd8na2GkHuaUNyFKZyf3Schs9qJwe0ELJPr4PMPaTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNI962LdHUDRpNmJSRyDMeFmdW2z0Mi7Eu8TzsnyKEyuKdujq0
	OV7MBW4BYnt3B8gWgwp1YR2HiYw24jev5Va43yAsu/CJkF+KbnUhnW4hJCpIouw=
X-Google-Smtp-Source: AGHT+IGSAkzsS8Xu3kSgehbo+Kc62PdcMlBDc5sKOoL9L8oOO4i5AH4GfZHKbbi0hFbj0uSmfRvN1w==
X-Received: by 2002:a17:906:7955:b0:a91:15dc:3607 with SMTP id a640c23a62f3a-a93b165d143mr506219866b.20.1727374223023;
        Thu, 26 Sep 2024 11:10:23 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2997f50sm22955266b.198.2024.09.26.11.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:10:22 -0700 (PDT)
Date: Thu, 26 Sep 2024 20:10:21 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, lizefan.x@bytedance.com, 
	shuah@kernel.org
Subject: Re: [PATCH v3 1/2] cgroup/rstat: Tracking cgroup-level niced CPU time
Message-ID: <tdwyqv3qqbecnxhps5qkdux2atei7ydbduvx5uzm5q6ouw52y6@lqx2bity5fci>
References: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>
 <20240923142006.3592304-2-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ietadeycgrbucgg5"
Content-Disposition: inline
In-Reply-To: <20240923142006.3592304-2-joshua.hahnjy@gmail.com>


--ietadeycgrbucgg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 07:20:05AM GMT, Joshua Hahn <joshua.hahnjy@gmail.co=
m> wrote:
>  static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
> @@ -535,7 +537,10 @@ void __cgroup_account_cputime_field(struct cgroup *c=
grp,
> =20
>  	switch (index) {
>  	case CPUTIME_USER:
> +		rstatc->bstat.cputime.utime +=3D delta_exec;
> +		break;
>  	case CPUTIME_NICE:
> +		rstatc->bstat.ntime +=3D delta_exec;
>  		rstatc->bstat.cputime.utime +=3D delta_exec;
>  		break;

Nit: slightly better diffstat is possible with fallthrough:

        rstatc =3D cgroup_base_stat_cputime_account_begin(cgrp, &flags);

        switch (index) {
-       case CPUTIME_USER:
        case CPUTIME_NICE:
+               rstatc->bstat.ntime +=3D delta_exec;
+               fallthrough;
+       case CPUTIME_USER:
                rstatc->bstat.cputime.utime +=3D delta_exec;
                break;
        case CPUTIME_SYSTEM:

> @@ -622,16 +629,19 @@ void cgroup_base_stat_cputime_show(struct seq_file =
*seq)
=2E..
> =20
>  	seq_printf(seq, "usage_usec %llu\n"
>  		   "user_usec %llu\n"
> -		   "system_usec %llu\n",
> -		   usage, utime, stime);
> +			 "system_usec %llu\n"
> +			 "nice_usec %llu\n",
> +			 usage, utime, stime, ntime);

This seems to be different whitespace alignment than user_usec above.

(Implementation looks good, I only have some remarks to the concept,
reply to cover letter.)

Michal

--ietadeycgrbucgg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvWjhwAKCRAt3Wney77B
SZlQAQCcWwdx5Biqb3trKtvBHvn97iDBn4qIVILVuUwhu+ghFQD9Gja7eSXmdpys
O+AyC9kJJjLIBxsAzTJgDzbTXit9TA4=
=qO1h
-----END PGP SIGNATURE-----

--ietadeycgrbucgg5--

