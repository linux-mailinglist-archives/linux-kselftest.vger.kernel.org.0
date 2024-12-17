Return-Path: <linux-kselftest+bounces-23470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1A69F56D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 20:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BCF16D564
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 19:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1DB1F8EFF;
	Tue, 17 Dec 2024 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkIXFDJT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17A1F76C7;
	Tue, 17 Dec 2024 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463342; cv=none; b=CXofuSjqRrIAXgIV8ZjcM/PP7c8Oi3QR9ymYZGqmzkRQjeNPVYlnMZbO4EEfR68God7XM39tdNcV05qin+hZhdA7DsazPnIiFjm/T/GzdH0lIwFxldlfkVFUh1f+Qj4LfwnEH6K5XjPWCkp6if73Cq343jh4CjuUIvPGhz58Gyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463342; c=relaxed/simple;
	bh=9mNOA8/WNTIvajmOpeIQjXIZVIGGtLZcsx8KEPpiCsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ozjgu0CyYQPNgh5c8YsNxrJc5cnvS/EJxO3H2lW8t+iiU/7a7J4k6RK9Cu6gAZBeVV38sO4OADqe8jbvxlnu+U4Ng0QxjKf91RQytDuhKcvH6cYFb51k8JX90ayAilfAXMa6k5qzgwI/4lIjCS7cR0BjV40cNYZdslKQWJOknAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkIXFDJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA13AC4CED3;
	Tue, 17 Dec 2024 19:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734463340;
	bh=9mNOA8/WNTIvajmOpeIQjXIZVIGGtLZcsx8KEPpiCsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mkIXFDJTUssl2V6+nik/zcYBEbniOgN/ejXZqXsaBUKkIvtLGg7iodsVtHUa/YG3s
	 nsl0kmRA+DSsYmywJOLN7ICCvJyViwS4NTU4Khb/irkzeUFmkH4akAP3jaTZ4JIejC
	 Ox1Ae5Z8TInNWC2AaaEeD8W3kmnGqufIutlmKwetK1DTmxe2aKWKvc7N77GtDdAVYy
	 BYc+ptatgw07i6sWU8iRM/NjUhFD/VDGOXNtlVdUUNorPB+RzA7spd48cWjK8QcOai
	 LpGanlHJs+xA7jSyL3JhHYgG8o00dRivzklmG8u/kWoUUGJ25352nDKFxEVy8bK3Ev
	 LZA6SlPeY6tLg==
Date: Tue, 17 Dec 2024 19:22:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix set_id_regs selftest for ASIDBITS
 becoming unwritable
Message-ID: <9b657364-140b-482d-82fe-01c59711e764@sirena.org.uk>
References: <20241216-kvm-arm64-fix-set-id-asidbits-v1-1-8b105b888fc3@kernel.org>
 <875xnisocy.wl-maz@kernel.org>
 <53b40aa8-f51c-4c4e-a4ad-e6a9512e5197@sirena.org.uk>
 <86v7viqusg.wl-maz@kernel.org>
 <b13b14df-00ee-4bee-8f65-d2cb7a9bfa6b@sirena.org.uk>
 <Z2G8TFw4wg7bnwzB@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KSSckS5oYWmHvwuz"
Content-Disposition: inline
In-Reply-To: <Z2G8TFw4wg7bnwzB@linux.dev>
X-Cookie: The sum of the Universe is zero.


--KSSckS5oYWmHvwuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2024 at 10:00:44AM -0800, Oliver Upton wrote:
> On Tue, Dec 17, 2024 at 03:10:28PM +0000, Mark Brown wrote:

> > No, this isn't a new use - a Fixes: tag indicates that the referenced
> > commit introduced the problem being fixed and that is exactly what's
> > going on here.  Like I say the selftests are not a completely separate
> > project, they are a part of the same source release as the rest of the
> > kernel and it is helpful to track information like this.

> A Fixes tag suggests a bug in the referenced commit, which isn't the
> case here.

> I agree that having some relation between the two is useful for
> determining the scope of a backport, but conveniently in this case the
> test failure was introduced in 6.13.

While the patch introducing the test failure was introduced in -rc3 it
was tagged as a fix for d5a32b60dc18 ("KVM: arm64: Allow userspace to
change ID_AA64MMFR{0-2}_EL1") which was in v6.7 so I'm expecting to see
it being backported to relevant stable kernels, which will in turn cause
testsuite failures in those stable kernels if this change doesn't go
back with it.  Hopefully they'll find it from the commit message.

I would say there's a case that leaving the tests broken is a bug, it's
certainly some kind of problem.  Obviously we're sometimes a bit relaxed
on that within a series, though it's fortunately relatively rare.

--KSSckS5oYWmHvwuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdhz2YACgkQJNaLcl1U
h9CZ+Qf8CgogvpmIGkRfSWc1vGgw0N6bTzH396O9wr/88wFUL7jPGP1DKTMW4Bdw
K6lOtGL59M2SLDObeGZqQSShw7sQPOewW54CNZlyj0GIZzkz/ezfRG/+Jzb3Y33h
VNgyLvJ5g6twjzKTfDbo0TXFgAiBk5+wO8igobH7DWZlXEWaWku9w6fmoZhFkF4T
f4ne4D+3iSg0iihgcjth8ReHrIuGZ6Cx6vw9LwjCmFwBuJlRQxmDKeJKktEUKFrk
n2IGbzOiiq0ZPl2zNLX0fRYIFwP/+E7yyIwhtWbKJootYl5DAyJzJtDIFhP5tEBI
rxqQc5m7WTdNbZEedU0trXAx7uPrSA==
=V2CE
-----END PGP SIGNATURE-----

--KSSckS5oYWmHvwuz--

