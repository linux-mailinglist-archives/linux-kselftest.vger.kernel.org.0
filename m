Return-Path: <linux-kselftest+bounces-48963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9AFD20C92
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 19:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48D8230AC976
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 18:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF1933555D;
	Wed, 14 Jan 2026 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnv936Pw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4666C2F39D7;
	Wed, 14 Jan 2026 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414932; cv=none; b=l8eLWoXzKhsGJYu+iZoAANRRJsDqQTF4aDv25nVsZUfEx4UPCwnVtkeX6r8bJFmMVfwdbjMFhtPo9WvjLn4C/Xal8k2BW/PYxgGioWxQI1EWrCnfWJkmhQQh16TrAPpq4MDlG5PuvTrkPMKhueoyEQ+q4WQMWaW8MI6Y1UqiqOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414932; c=relaxed/simple;
	bh=tcknC6iemaw7J5r4is+1RFQMsTj8mbkEYsrSA6D6Saw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeGh2TkGZ+xujEu49iTscHhbDPLCHQLyS3huzF9AERfRBpM3IXosH3KqCGiWSFO1S5X/I56GvkkgnXEjxJ4y5Sdht7LGqHvGzevl7mcCIePaINQ7AqVBI3JPwe57awqWBQsgZK4be+OA6fORRQFja+rXsXv6xu+hTplHZQa4Azs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnv936Pw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6A5C19421;
	Wed, 14 Jan 2026 18:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768414931;
	bh=tcknC6iemaw7J5r4is+1RFQMsTj8mbkEYsrSA6D6Saw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gnv936PwAOYqla2o5RLnSGyPnWK7eepNYoigSv3xXJ9tqfUVL17uGzncwmmSr8jmA
	 fh4eTYbjwkRZaR/lWB4BeQFZeI321YENVp8PuJFL27WkKn6hGS7oxQ3cluEXsJKnUf
	 e+CWfzWOQOHbIi1FxuPUJvknfYFlCBcidWhMHmmDTsRmlcrzYEpjBMYMaEoTVksV3U
	 fApWuGawlIvleBifk6rYfDE4Q+QM7Y/6v3afg+uN1IThtpoL1Pr8o8yr+UBntNCr1j
	 6RfbmLF9dPh2zIAHhUCaPHd+V49mgU2eFN3GXxpC4hWgyf7Rz4pazXUXqAZC71JL5u
	 nbaDt7DOD7v/Q==
Date: Wed, 14 Jan 2026 18:22:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Oliver Upton <oupton@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v9 25/30] KVM: arm64: Expose SME to nested guests
Message-ID: <2498896a-78cb-4184-82ac-6497b1e9bd03@sirena.org.uk>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
 <20251223-kvm-arm64-sme-v9-25-8be3867cb883@kernel.org>
 <CA+EHjTwZCcMFT6gAM2oaQz5V_vqEBmVuggFBbABbXPvC+U919Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GsOJE4+Rwb8rI0F1"
Content-Disposition: inline
In-Reply-To: <CA+EHjTwZCcMFT6gAM2oaQz5V_vqEBmVuggFBbABbXPvC+U919Q@mail.gmail.com>
X-Cookie: Absence makes the heart grow frantic.


--GsOJE4+Rwb8rI0F1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2026 at 02:37:57PM +0000, Fuad Tabba wrote:
> On Tue, 23 Dec 2025 at 01:23, Mark Brown <broonie@kernel.org> wrote:

> >         case SYS_ID_AA64PFR1_EL1:
> > -               /* Only support BTI, SSBS, CSV2_frac */
> > +               /* Only support BTI, SME, SSBS, CSV2_frac */
> >                 val &= ~(ID_AA64PFR1_EL1_PFAR           |
> >                          ID_AA64PFR1_EL1_MTEX           |
> >                          ID_AA64PFR1_EL1_THE            |
> >                          ID_AA64PFR1_EL1_GCS            |
> >                          ID_AA64PFR1_EL1_MTE_frac       |
> >                          ID_AA64PFR1_EL1_NMI            |
> > -                        ID_AA64PFR1_EL1_SME            |

> Should we also limit this to SME2, i.e.

> + val = ID_REG_LIMIT_FIELD_ENUM(val, ID_AA64PFR1_EL1, SME, SME2);

> That said, we don't do anything similar to SVE, but it might also be
> worth doing that there.

This feels like a general approach issue with these registers that's out
of scope for this series, it's not just the vector extensions which
could introduce new state or anything else that requires explicit
support.  AIUI the theory here is that we bootstrap from the host's
sanitised registers so the time to add any required limits on future
values would be when enabling them for the host kernel, assuming KVM
support isn't added simultaneously.

--GsOJE4+Rwb8rI0F1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmln3swACgkQJNaLcl1U
h9D5Awf+IRsqdR9I7nYCFQPlwzCHBQBbuNnWwG5/UXXDqIc3+6wyvcIQNcpbea0/
TQLaQPJEdkXSt9dQkg0iKdV3YBSDo8IW8JMvqDcgNueXpfuJdIPFDerneL0HTO/l
/80XNxIjRpwrR71w+bFdSGWj6TpDcgtNYQj4z1wT6wRQ3VoQxnRsNiZoxObmnM8A
t1DLEPg1EigeOwvBt12Q6yOVBiAM+lAF04JU7Kq28s3Nho38aMBGrMkiz9zLY/bv
Lk+KVaDLIh5KmecygdX5rm/EEyT96tV/fj+NXrctDs2+/ktqa2JYtF2PpuQuNXZx
6dDmflaX69rqabPcKmADbMedkpxJRA==
=kw66
-----END PGP SIGNATURE-----

--GsOJE4+Rwb8rI0F1--

