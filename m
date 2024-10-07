Return-Path: <linux-kselftest+bounces-19162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1D8993333
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CB1281BB4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 16:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9274B1DB531;
	Mon,  7 Oct 2024 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbgKcnUn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676221DA62C;
	Mon,  7 Oct 2024 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318472; cv=none; b=Uymt7fvO+mtmYtAmBxf/i8KPTQ5x6GYLeKKkF9wVGEw0qDfSBVHUWInZPqZRyE1ODEjWgy2Ly3IWO212KYoAsXRj8oq5H5dW9yKCe7B2d4/tQK4Qzecr30rpUrj+G7qTZnyyvdZv2xkDN/IHF3f++kzP2DxF9IjrEFHO8NjOtHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318472; c=relaxed/simple;
	bh=x1oW3n5t/b/A2xKX8m3gu11wJ95kYfjdEVRLVlS5QSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/CsTXY3vodpiQkVWys3Qld8IXPOMg4TXqyJcskAhlB1an5zKNa8Og973SfF89KnHqoSCNb3PzUHDbNR13zI5kRWU8XX79NrWbInhGbZgL0/hB5ABnLudgIymxzsak7Rbh2n37PNO8LOknVzpXgNgZEvlwIhdkNUjhDL7kevi9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbgKcnUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5458EC4CEC6;
	Mon,  7 Oct 2024 16:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728318471;
	bh=x1oW3n5t/b/A2xKX8m3gu11wJ95kYfjdEVRLVlS5QSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RbgKcnUnSFcRGlJ2vo+Z+PJk+mif54xbmJEmk3uVpQR9NUY7fImgKI8VvfYxkeHy1
	 iaJ5q16l5+PnYHR0+ZvtdRK3gE2v0SBQWPetWRsYWovrildMOGZK2nz1NEMFa6rcI7
	 33kgosgwEW424iwoC42WYUjgvF6OVviW5YGwZ61bKFmLlojv9KcjIt0jji/2mhSbij
	 /tv5fPzeNdoZl3EFbwLdWM0FmKv8L9DNmWUwmVYbfws8waZXZAlNxnNE8Nl3BfFWqr
	 lPe+GCYmDjuld0XCNLRK+H8nyc2UqRc9VwIofrCFMz9ciQG/BqjK9RsJQwjFHhtcoV
	 UfqNJpDmi09RA==
Date: Mon, 7 Oct 2024 17:27:01 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2] selftests: sched_ext: Add sched_ext as proper
 selftest target
Message-ID: <ZwQL1RkyCwNxyqVE@finisterre.sirena.org.uk>
References: <20241007073133.989166-1-bjorn@kernel.org>
 <ZwQBqlG6MShCkNrU@finisterre.sirena.org.uk>
 <87r08rnbra.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5SqJr+ARYPJxKn7Z"
Content-Disposition: inline
In-Reply-To: <87r08rnbra.fsf@all.your.base.are.belong.to.us>
X-Cookie: Editing is a rewording activity.


--5SqJr+ARYPJxKn7Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024 at 06:00:57PM +0200, Bj=F6rn T=F6pel wrote:
> Mark Brown <broonie@kernel.org> writes:

> > When building for arm64 with this applied on top of mainline or -next
> > I'm seeing:

> Thanks for taking it for a spin!

> >    make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -C tools/testin=
g/selftests TARGETS=3Dsched_ext SKIP_TARGETS=3D"

Oh, and for arm64 as previously noted the sched_ext config fragment
odesn't DTRT, merge_config.sh says:

Value requested for CONFIG_SCHED_DEBUG not in final .config
Requested value:  CONFIG_SCHED_DEBUG=3Dy
Actual value:    =20

Value requested for CONFIG_SCHED_CLASS_EXT not in final .config
Requested value:  CONFIG_SCHED_CLASS_EXT=3Dy
Actual value:    =20

Value requested for CONFIG_EXT_GROUP_SCHED not in final .config
Requested value:  CONFIG_EXT_GROUP_SCHED=3Dy
Actual value:    =20

Value requested for CONFIG_DEBUG_INFO not in final .config
Requested value:  CONFIG_DEBUG_INFO=3Dy
Actual value:    =20

Value requested for CONFIG_DEBUG_INFO_BTF not in final .config
Requested value:  CONFIG_DEBUG_INFO_BTF=3Dy
Actual value:    =20

--5SqJr+ARYPJxKn7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcEC9QACgkQJNaLcl1U
h9C3xAf6AwFHej9Yp+45Zx7N58Nweo6FPmkTT+Jshlja6vZYMeVf82rFI2+n5p3w
8bTCQ/Nf9OgyFrbJF9lDXUVCNAWh7/VnQvhvnINGTmNKLhsjQpWdCcTcHsuVR+Lt
g14lxMDvrqzE5t9UowfeB1CtFQDPyGzItMwFmZkXGmY+MBRUDTuw9Men4cTafqCr
025RguRmgBO6cbNhDkxEdbC41ZUbnNwGt/pV0P75EZxHqyjuUkFj3ajGEeXcJAP6
TpVIWd/2YR9RTAZMVLm0uth7Zi7zlmqxn4bKu19QYiKj6YQKQKjrZWaOWjxYA0UG
jLrjYvwY89ZEwnRNtI/ESEaqjJm+Vw==
=So6V
-----END PGP SIGNATURE-----

--5SqJr+ARYPJxKn7Z--

