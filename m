Return-Path: <linux-kselftest+bounces-18413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDFD9878EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 20:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B23CB26BC8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B4115F41B;
	Thu, 26 Sep 2024 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZsGu4eHF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145913D889
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727374240; cv=none; b=aAPiOr0vLUBWc3WNuGsxsT6go3oEE1jBo7ToqUwNQJFWIKoJOZAGfPXzxvM11B2bcsiKxU3AT8frW2LBEoXpqjXlboqt3F9hhC1hnH+Jm8GBJebJPSHWCcG+hRymn2MwdTHQIgBv8OtEkoEZi/LP+qsvJQgke9fl20qU5jwi6uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727374240; c=relaxed/simple;
	bh=tEGhy1y3hxikKXA90z5wp7UYXddJC1lR3CMHAlfnVRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E06kSRXLUmK/otilby5vyduqKIDuQcy1lKJUJskB4snxDoi6hhrIyZh5wWI+4Kk5MoKE4CKrpkkj6rYnKmYXdea987fXWtIiBHA+OfiA0WVgAbGxNvKRoaXAJOYcDR5W1Qy8hf+T4Zp7C3FBUjgBVGL3OGvNxYcRbLXKTpBBARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZsGu4eHF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso184180766b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727374237; x=1727979037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEGhy1y3hxikKXA90z5wp7UYXddJC1lR3CMHAlfnVRw=;
        b=ZsGu4eHF11SqHfY8HcLgxBKM3+C+663yLaLGbHzilNFyNtnZ+jR6YHIs8g6qDslqDc
         n4vS3dVWn8LZf/k0HN4R9YTdzF6IYxGezD97u5/uOxxTxhG0PY3QEy7cSxNRkT0jIdr4
         s11Rd1sWrp30VcRc5rNcIQlSgV967ruir3h7pgeSbKJAGGLswocqFvkGqPZY0RjU8Cqi
         ZRmEfhksqfh0PciowAhVeNnnlhCxl/E0qz8tirlL512sGrgqHIrzVGz6mLiYzZmQ587h
         9Ny2LUpeWMMtYBbl/WCqlJ2nhyO5tGSrlJDwp/nIfw26XgYTJpH3PuljGtEG2AJrnJS5
         NsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727374237; x=1727979037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEGhy1y3hxikKXA90z5wp7UYXddJC1lR3CMHAlfnVRw=;
        b=cNABCEIC4BB2DjHVcTSTWaE4YyB5owC7wNbA3KnaW1SszDLSAxdxD+1b+L42f06oV+
         8a9uWy9otq+bydp2Ol+fwmYlX1zhEJOl5LY/feJTZTZ/SSoVKiV1xoAq9kLEuc6DrZci
         Vs3zolwd0bqOODKjfP3xcypm8Ek9D5GlXGONwF7eQQ5QFJknknJ8fXojiXWyOBSVLvXV
         GEcwL4WH7KrpqaRYtvYL64wAel2QtkSRQlFlylmUd05VT2fWf8V59q2iaXM1mVZwMH8a
         TjaRPl/RYqdC+/dw2vkM0s6N3nWVqhDzWhB8uZVTI9VGGhifQ7wiC7Mt7yaYhomypE7i
         /C0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQOgG8T7GicXwNVmtLtRzd+ZOeH5fcI/G72B1/e7Id/lfoA7botoZk3M3e+slxq+SD4YS9rXidHJBtzqLqnsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDrWuPPELKTcBAma1heDYDTiW2NSuMdqatr134x8GekM8cARn+
	faquS/zc+Qj4UtLSHK/2KzXxHxYfJsTR/35oeLO+qXXaDgpFMyKLJr73aVcgYfE=
X-Google-Smtp-Source: AGHT+IEfe8BpSSgYBcwUqahCkfmDSBMc3otDpIdlgBIMUSWhz79v6I4cHVtltnbs2o3FtkBUNGafGg==
X-Received: by 2002:a17:907:6d1a:b0:a86:a41c:29b with SMTP id a640c23a62f3a-a93c48e80bdmr36738166b.8.1727374236956;
        Thu, 26 Sep 2024 11:10:36 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c299861bsm23451366b.192.2024.09.26.11.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:10:36 -0700 (PDT)
Date: Thu, 26 Sep 2024 20:10:35 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, lizefan.x@bytedance.com, 
	shuah@kernel.org
Subject: Re: [PATCH v3 0/2] Exposing nice CPU usage to userspace
Message-ID: <qjbbaywlodoojlb5n3vavgck2jrffofnlzpf7pc5h7fsyu5y7o@oqh5vbuns7ve>
References: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o4xm45ommiv6myew"
Content-Disposition: inline
In-Reply-To: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>


--o4xm45ommiv6myew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 07:20:04AM GMT, Joshua Hahn <joshua.hahnjy@gmail.co=
m> wrote:
> From: Joshua Hahn <joshua.hahn6@gmail.com>
>=20
> v2 -> v3: Signed-off-by & renamed subject for clarity.
> v1 -> v2: Edited commit messages for clarity.

Thanks for the version changelog, appreciated!

=2E..
> Exposing this metric will allow users to accurately probe the niced CPU
> metric for each workload, and make more informed decisions when
> directing higher priority tasks.

Possibly an example of how this value (combined with some other?) is
used for decisions could shed some light on this and justify adding this
attribute.

Thanks,
Michal

(I'll respond here to Tejun's message from v2 thread.)

On Tue, Sep 10, 2024 at 11:01:07AM GMT, Tejun Heo <tj@kernel.org> wrote:
> I think it's as useful as system-wide nice metric is.

Exactly -- and I don't understand how that system-wide value (without
any cgroups) is useful.
If I don't know how many there are niced and non-niced tasks and what
their runnable patterns are, the aggregated nice time can have ambiguous
interpretations.

> I think there are benefits to mirroring system wide metrics, at least
> ones as widely spread as nice.

I agree with benefits of mirroring of some system wide metrics when they
are useful <del>but not all of them because it's difficult/impossible to ta=
ke
them away once they're exposed</del>. Actually, readers _should_ handle
missing keys gracefuly, so this may be just fine.

(Is this nice time widely spread? (I remember the field from `top`, still
not sure how to use it.) Are other proc_stat(5) fields different?

I see how this can be the global analog on leaf cgroups but
interpretting middle cgroups with children of different cpu.weights?)

--o4xm45ommiv6myew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvWjmQAKCRAt3Wney77B
SQ8WAQCp29FbziRN/KbfWQPcfAVt7SDahK/4JWtmK3cAW9Ev6AD/fINR453pWEMR
b2Nxw2R0JPWdmbAjsReOZPift5TgNg0=
=bl5O
-----END PGP SIGNATURE-----

--o4xm45ommiv6myew--

