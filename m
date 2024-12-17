Return-Path: <linux-kselftest+bounces-23451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B63F9F4EED
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 16:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B9216448E
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2E31F707B;
	Tue, 17 Dec 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ey09IHrb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C61F4E3D;
	Tue, 17 Dec 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448234; cv=none; b=f29q2Nhwt/UC96+pw+g7TVXp4iSOziYfjd2Oobcfcm3LdbTQujlp2zFblpffTeLzSJRDAjRw/Gza42CHwbA+g8tHuN9MB8ZS65SutWA33B3pTa3uSfjKT0CsWWlHIXzWI2xKSizNIOIJSNATXJdurUOGk1iQJTVavH8BoBeig6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448234; c=relaxed/simple;
	bh=ks+Jrej2tEqHYg73tSV5p376J4HoYDZUNHAtN+M5N9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYROlxmD/VPrqHshYUBduDu9e4RTWA/j7kIenbdHKN6VMprxxhIat2qmvfJ0hfYraQNOJw90WTuOzkZHbn0f2iTaLZBjDJXeX8OqgLYzdCVGKm1gugpfI+XIYkk1lB1OpazFBcRE1aPhtpX3jbl1Qg3aLJCSbOFyZjYxRj5kj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ey09IHrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A822FC4CED3;
	Tue, 17 Dec 2024 15:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448234;
	bh=ks+Jrej2tEqHYg73tSV5p376J4HoYDZUNHAtN+M5N9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ey09IHrbr7Yeo/hHbNyOC1q8L2tFrcqYO6xRTNl0WBPcHSFEfq4JHrdHVZKjYSlI3
	 wf7PGFRu/34ToHvYjeTTTp4RxEGjSGIyuWD6vY5FbTqHdgqbfAuUWyYabU2ACW6Ekz
	 f1MErYPfWkPGztFitNV+RarkjaCEWLBh+id+sa6V+nCi15iKg0m10fZjpIY8uPp8WA
	 nnIslgDQftF2bzymJw7lxBAM/N7y7yieXwGsOmBFKRCyqr0WnGknBuSYGBsj7t1wRv
	 hTkvwmUBWpknSuYqPLSDkRL9tsBvjN/y2QBTyZKfTOnNd7H7NcAp8dtcaFkrsmNjO6
	 sY8Yrdk9ivDcw==
Date: Tue, 17 Dec 2024 15:10:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix set_id_regs selftest for ASIDBITS
 becoming unwritable
Message-ID: <b13b14df-00ee-4bee-8f65-d2cb7a9bfa6b@sirena.org.uk>
References: <20241216-kvm-arm64-fix-set-id-asidbits-v1-1-8b105b888fc3@kernel.org>
 <875xnisocy.wl-maz@kernel.org>
 <53b40aa8-f51c-4c4e-a4ad-e6a9512e5197@sirena.org.uk>
 <86v7viqusg.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z4QihPqeM7ahcPAw"
Content-Disposition: inline
In-Reply-To: <86v7viqusg.wl-maz@kernel.org>
X-Cookie: The sum of the Universe is zero.


--Z4QihPqeM7ahcPAw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2024 at 01:54:39PM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > The selftests are shipped as part of the kernel source and frequently
> > used for testing the kernel, it's all one source base and we want to
> > ensure that for example the test fix gets backported if the relevant
> > kernel patch does.

> That's not what Fixes: describes. If you want to invent a new tag that
> expresses a dependency, do that. Don't use these tags to misrepresent
> what the patches does.

No, this isn't a new use - a Fixes: tag indicates that the referenced
commit introduced the problem being fixed and that is exactly what's
going on here.  Like I say the selftests are not a completely separate
project, they are a part of the same source release as the rest of the
kernel and it is helpful to track information like this.

--Z4QihPqeM7ahcPAw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdhlGMACgkQJNaLcl1U
h9BuXAf/dx2R8YpYX3/jMtIRY2yeLN7a+p7w0DV7dBaLXFEcPUxaS9GC2Qv71kJS
XgZe44QxPXpIWnNMnlPWO+TsfX/Y9KLoXfiHQa7PLc4jegXgSE9t1cCd4DO//iqN
sPerZxeVN5K6flV6SRIjmwY+67zE+0m3aituAPK/6GKjr/Jr1GTCbr46LVPWaWr6
+Se2L+CiAPJIiYV+h1K0IPwjSkTChZAt/Ve43bKZY+3jcVbYx4unuWrSsyNGPjSD
Xg9+XnQfdvRoSTwaipg4T+I1+CYf29gzyze7fUZ61d1YHEnNQoMXSGlnDEEcyBFf
/OJ9bIk+wiiKn/luwRZn5hT33yU33g==
=qHT9
-----END PGP SIGNATURE-----

--Z4QihPqeM7ahcPAw--

