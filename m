Return-Path: <linux-kselftest+bounces-34062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA64CAC920E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 17:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BC21C04569
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2EF235079;
	Fri, 30 May 2025 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8p5xHB7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3E21CA0A;
	Fri, 30 May 2025 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617762; cv=none; b=NK/o8khvnjFQgl3xXVmdZocNuKKJtNgt11/QhUjjD5CUlJXPxNwJl6cGZgnxSFIi4M3fepjZDDFJf1EOYGLqofMQsSp4UcU73rVViciwlw8tnjtJk3JhAXW4sYsMeEXNpR1tRnLK01tBjazKuwybVJPWuFjt5EM7f6ZXK9gIrWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617762; c=relaxed/simple;
	bh=V0gWy4GTPYgrQerlCIgXsFzcohXqXtutEpCf5eYx9f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCXHKiKnC7IjpR4h7vdq6pq3kIdezoUVn1eeL6kvWfbGfC7hlXdGA+5KsRbfUIDEeesDrMbnkHXQHkX7nBpIw4MFeU/3RHDhCuhEQ39Mq1pRPk9zOS141QPFRpN2MFfg1FfNZToe84GpQroFF2kim6KC5PcOsPWjvOfrUIODOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8p5xHB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4430C4CEE9;
	Fri, 30 May 2025 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748617762;
	bh=V0gWy4GTPYgrQerlCIgXsFzcohXqXtutEpCf5eYx9f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8p5xHB7bH7ctY758Z1GqiqiYfnaXFVLJoZiN/fb8zzX4N3nYNasEKGYP3t/7IQv2
	 hhg+xB80eB588kN3O4Kswo1HVHVH5F0FH4Fj/MvKEMKFmhpn/9t2G5bH/dq0PkeIKu
	 oj0RR6neLemHpvytXaT6ABZPZ9vNW3xDrE5m8r4KDW6MN/fX6AhvInIELcAYRU6Hf+
	 FlsHd8UHjHMxawUgRwrwl/s8lq4dA++09GKuCwq5IkUKL+UexXBbcjgphL9eFav/YU
	 2E4hspWZmIx1SA7VwIQx9ilKZyXh30O+pEQG1XLBPTXk1LDypHrOMIWLpPm40kKXn+
	 eDY+1Ecs32Yqw==
Date: Fri, 30 May 2025 16:09:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, brendan.higgins@linux.dev,
	davidgow@google.com, rmoar@google.com, rf@opensource.cirrus.com,
	mic@digikod.net, skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH net] Revert "kunit: configs: Enable
 CONFIG_INIT_STACK_ALL_PATTERN in all_tests"
Message-ID: <aDnKH1LiYiuWhLA6@finisterre.sirena.org.uk>
References: <20250530135800.13437-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NKsdAFi2Psg0BfMv"
Content-Disposition: inline
In-Reply-To: <20250530135800.13437-1-kuba@kernel.org>
X-Cookie: Well begun is half done.


--NKsdAFi2Psg0BfMv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 06:58:00AM -0700, Jakub Kicinski wrote:
> This reverts commit a571a9a1b120264e24b41eddf1ac5140131bfa84.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

> The commit in question breaks kunit for older compilers:

> $ gcc --version
>  gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5)
>=20
> $ ./tools/testing/kunit/kunit.py run  --alltests --json --arch=3Dx86_64
>  Configuring KUnit Kernel ...
>  Regenerating .config ...
>  Populating config with:
>  $ make ARCH=3Dx86_64 O=3D.kunit olddefconfig
>  ERROR:root:Not all Kconfig options selected in kunitconfig were in the g=
enerated .config.
>  This is probably due to unsatisfied dependencies.
>  Missing: CONFIG_INIT_STACK_ALL_PATTERN=3Dy

This seems like there's a bigger issue here - this sort of thing will
keep happening if you're running with older compilers and it's also
going to be prevent the addition of any coverage that's specific to
architectures.  It would seem better to fix this by warning only and not
erroring out, perhaps splitting the config fragments into must succeed
and can be dropped sections.

--NKsdAFi2Psg0BfMv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg5yhwACgkQJNaLcl1U
h9Br/gf9HKMFfm4g+sAPKU+HWRsiOTUFSbPHH99H3XmXrCiFFH9a8okr61cf9koR
uVP4QCAHD0r/77f961q6a3Jy3FA50vwhv4SZ5A9tJszbAUe7WU62lbHR7llr9SCp
6TSf6FePK3XvmmAL5MofWYq7TMVr4ImAFksCYyu+hrI364M8yCSTiiCdIXgynKGu
fwpDEz7SCUiBnsEk2Pwyyeyvq58Ktdpj0cr12XLYfe/kn55iVfI7nhS/ve1o6XNw
b8yr0J7HYflgWrUJpaS/7fOClwz7qjnZLKAXF6+HBVeUt16Ok3VwuMhG+2gt0rvN
RPIbJaac3NWcrN9pNOB9c4GuHUNV+A==
=9vCI
-----END PGP SIGNATURE-----

--NKsdAFi2Psg0BfMv--

