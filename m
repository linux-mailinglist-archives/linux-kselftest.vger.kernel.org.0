Return-Path: <linux-kselftest+bounces-29768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A5FA707C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 18:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57DB7A4D27
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 17:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191CA25F98B;
	Tue, 25 Mar 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AveRPtLW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B31A0BFE;
	Tue, 25 Mar 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922655; cv=none; b=jyMr0pZmRf0AvtPILznZJXE3liW8HKgXC8MyiTdkqqsGxn5ACG71lEPB5IEYCXH6h9EQxkTjSLrib62gLJLSc3Gl1+pqmwd+uAyflzj4KX5muP+/ZJ/yd5tMysQZCErCAMJE3F+LStA2MUsEvDx/wnromAsBj5EZQZIL/tN2nU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922655; c=relaxed/simple;
	bh=GNqENFQaTr7pvnN27Xev/R/FfH7qw+nT7Ttp27/8aIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rW7Qdbeo5r3CGzIdTi6nhhC1Z7Djen5RAvhr5W071ebpTdYFNmwHZGZCPmYvFmOwGeIyVuJPKTyLK3zl6r5g05JhJ1Ou6XxVjjekLu3cw1tS2YFUUI6psyaNAHbj1ChV+aSy6HhsEaxXsxto40MvvyWrwxwuE7wVm8sy2784Als=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AveRPtLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B43C4CEE4;
	Tue, 25 Mar 2025 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742922654;
	bh=GNqENFQaTr7pvnN27Xev/R/FfH7qw+nT7Ttp27/8aIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AveRPtLW8iwTMOgYDEmSrCG4Kr9UFnf9W4EpzpxIWsxlTEYpZr1GoX9Iy/x4bSGy4
	 CgQK5G21DwIr4dGGS33VmnA4nBYAiJmxZyUjVON8wuC6vfCT95a/NY2JX2hxUmrP1Y
	 M1N5MrmtOXAU5pmZFGwsGRK+1hUNuxqnjMUOjeKdrnmDQk/tJVlLjGUmec1eXeButL
	 4C3pMWzW9/Ab6vswbh5qK0UgGYlclj+6YJqQOY5PcWjFMc3FTBTOk+TG9cNvUqMt7f
	 I31n7BigTqc9bCDJbltm4d5rHpzrmR0hT/RNqLgXBAkSMSEQF99JYkJb8MmkQR/WQ+
	 aVnQjSXgEbjbw==
Date: Tue, 25 Mar 2025 17:10:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Nico Pache <npache@redhat.com>, patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, simont@opensource.cirrus.com,
	ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev,
	davidgow@google.com, rmoar@google.com, johannes.berg@intel.com,
	sj@kernel.org
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling
 it
Message-ID: <67e46328-3a8a-4fc9-8ec3-6c7bc224d6da@sirena.org.uk>
References: <20250319230539.140869-1-npache@redhat.com>
 <CAA1CXcD2g=sRRwgLSudiOAqWXq3sCj+NPuE1ju7B2gFXXefjXA@mail.gmail.com>
 <d8fc1f66-f220-42fb-b58f-f5f9c7d30100@opensource.cirrus.com>
 <CAA1CXcA460xfy48JMNeX5rNTfUqsahER8SDF6tWu82V35ripLg@mail.gmail.com>
 <CAA1CXcD2RF6aXNH0ix=GN1+LTR9+dV7yRz-HGKZfUbSu+8ZM_w@mail.gmail.com>
 <4cc16ecf-d498-44a6-99b2-eee840cff63d@opensource.cirrus.com>
 <9d6831c7-053e-4414-ba9f-f5e71c690588@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HPN+G74z3uWNF37H"
Content-Disposition: inline
In-Reply-To: <9d6831c7-053e-4414-ba9f-f5e71c690588@opensource.cirrus.com>
X-Cookie: Visit beautiful Vergas, Minnesota.


--HPN+G74z3uWNF37H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 22, 2025 at 07:02:26PM +0000, Richard Fitzgerald wrote:
> On 22/3/25 10:11, Richard Fitzgerald wrote:

> > I got lucky on all the UM, X86 and ARM builds I tested.

> It looks like that bugfix has got lost.
> Mark sent an email on 20 Feb to say it has been merged into his
> sound tree. But that patch isn't in torvalds/master.

It was queued for -next rather than as a fix.

--HPN+G74z3uWNF37H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfi45gACgkQJNaLcl1U
h9DlAgf+NxfHOGfvo+VFOD75XLJkVKcL8K0dfEtpMMxBuzGtTAC5v6V8zk4PYCmN
kv/Xs0jLwZCSoIKjbNFOOEZHqWwjXlGz4b8FB+1BnhFaF5T0A6c+cLSC3ieFX40r
2d7N2Cgt7R7F1Bq9LbQbRFtt0tkEw9JW76tL9sanG60DdLwmw++nLiD3PM9Rq3Mn
XZRFmRko/V1Wsyc3JrKCHGIaotgWtee7ESYzWQb7Y6MHcltAAHh4R8yg3VdMukUk
wNnVfcpDF8wlUKOh175JUanvCPJi3n5RP6oV+0EWpmN2zUyVfGVzD8Cj6p9L2Qoj
scQsC00CLr9fi3kqVuAyO+EHFl8hCQ==
=uve9
-----END PGP SIGNATURE-----

--HPN+G74z3uWNF37H--

