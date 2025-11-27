Return-Path: <linux-kselftest+bounces-46661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A823C8F542
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 16:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4863AAD39
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C448823BD17;
	Thu, 27 Nov 2025 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH6TtGyl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9791391;
	Thu, 27 Nov 2025 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258459; cv=none; b=eNULqMOhnKPxxlW0xKeOxuiWNqGkMmoIPtF0XIKjf9Sc5r6Nqf2fJM/UO5FxN+Qzho6N9r/1WCIOyLk1/4ilWHikr4WdVYo+2MEUT3CkW2LH4IiwY2zQ9ojcwkh6HNW3iXBk3gzx1DiA1FL3QADO8VVwzOvWnu+gddpWYTzkHhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258459; c=relaxed/simple;
	bh=zimSNrPNbWALPjHaZb84EtxwZFuvvZtvIH/PBijM8S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1TAu1ak7ArRYOakl+8TpUjcLNoMGrdYbzlWNg8ej8yrFMHLXYHPgQBVZrIc3VZOWSGhKEzxiLXblx4t1xppBCg8RavlgOo5iafS1qqKQtErKiBtOOE+mf6FhSHQySJG597O8kyembhSXxLJVKCAAhPLAvgytHyjPSTTlMmv+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH6TtGyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD71C4CEF8;
	Thu, 27 Nov 2025 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764258459;
	bh=zimSNrPNbWALPjHaZb84EtxwZFuvvZtvIH/PBijM8S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YH6TtGylzkH0hTUqSYooUxBPgNrHxvjlNBXCZXXU3A0oMUJqsJ9kRP4xcRXRwHqwY
	 u4OzAKiU+6vTF/QHkqb5Zx83lrKP0/FNe5DojJqH1/hwpKZ+JlXSiloHd81HDQw+zV
	 Xl0SeAjacSu+qmb29eOJaWrsUicY3XB0Tdt9H7dd6vpCI4Zhw2K1LjvfJDP+SMS9wR
	 xXDaB8zMuHYNr2xtg/gw7i5moRI67uLTTd/dPAeNgynml1phdjL6DUvrQ0lj/jJIU/
	 xbQgAy026KW6FE3g3CrDjv+Y+JHcSqIVF52ARbXHJtnKcbgBF49XxfgkJqvtDqj0lr
	 hBRBFXON/3HJA==
Date: Thu, 27 Nov 2025 15:47:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v8 11/29] KVM: arm64: Document the KVM ABI for SME
Message-ID: <562a8b3e-b663-4588-8594-059874939749@sirena.org.uk>
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
 <20250902-kvm-arm64-sme-v8-11-2cb2199c656c@kernel.org>
 <CAFEAcA_GJ7gzn7aMCZYxHnJWvx4tHSHBKsOxtQ7NTb4gPjkMJQ@mail.gmail.com>
 <df712591-397e-422b-b9c9-fbf080cad9aa@sirena.org.uk>
 <CAFEAcA8LGwm-6JEhtKTq1E_da-T=H-aBX9-8LMJOAQpK5J+NfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q3s/7AjDkfVHD/Ey"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8LGwm-6JEhtKTq1E_da-T=H-aBX9-8LMJOAQpK5J+NfQ@mail.gmail.com>
X-Cookie: But they went to MARS around 1953!!


--Q3s/7AjDkfVHD/Ey
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 27, 2025 at 03:06:50PM +0000, Peter Maydell wrote:
> On Mon, 24 Nov 2025 at 20:13, Mark Brown <broonie@kernel.org> wrote:

> > That was deliberate and I agree it is awkward, it was introduced as a
> > result of earlier review comments.  I had originally implemented an ABI
> > where the VL for the vector registers was the maximum of the SVE and SME
> > VLs but the feedback was that the ABI should instead follow what the
> > architecture does with the vector length and potentially presence of the
> > vector registers depending on the current streaming mode configuration.
> > It sounds like you would prefer something more like what was there
> > originally?

> Yes, that's what I would prefer. The "varies by current CPU state"
> approach seems to me to be not the way we do things right now,
> and to be awkward for the VMM side, so it ought to have a really
> strong justification for why we need it.

> Generally the VMM doesn't care about the actual current state of the
> CPU, it just wants all the data (e.g. to send for migration). We don't
> make the current SVE accessors change based on what the current SVE
> vq length is or whether the guest has set the SVE enable bits -- we
> have "if the vcpu supports SVE at all, data is always accessed via
> the SVE accessors, and it's always the max_vq length, regardless of
> how the vcpu has set its current vq length".

OK, that's clear - that was my expectation for what userspace would want
too FWIW.

> What's the benefit of making the way KVM exposes the data
> bounce around based on the current CPU state? Does that
> make things easier for the kernel internally?

Yes, it makes life easier for the kernel internally.  If we expose the
registers to userspace with a potentially non-native format then we need
to keep track of the format things are currently stored in and rewrite
the data between the format we're exposing and the format we're going to
load/save to/from the hardware when those differ.  It's not an issue in
the normal fast path for running guests, it's only a concern when
userspace actually interacts with the affected registers.

This won't have come up in the SVE case since what's exposed is the
hypervisor view of the registers which doesn't change based on what the
guest does so you just need a bit of configuration of ZCR_ELx.LEN, with
SME the current value of PSTATE.SM changes the view of the registers for
all ELs.

--Q3s/7AjDkfVHD/Ey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkocpMACgkQJNaLcl1U
h9Bn3wf8CSMhGABD9kbCE3/pGrY7nWpZoFrW2t/gAZw214NnYmfjLDEktLE9i6C0
n8vkzzgjgOe8FpQQSj4nX3S88xmywapULp5ff10lC64KBNsiAcZVDtNvtzY5At3z
NeYolcx5mDHxgZ31ZJigqgjGUpBT0FAD4zfJXU5qeSRAlKUngC4mFhRuv1rj1oTg
J1WLpHDDdDtQDy+QH2cAV36hPWkwWhoS50m0+AKzSRRY09jlpwv/vHJCPxtN6yC0
XIjJl4b1m+G5izroyNqAV4sG6RQTrF8rSBuMgB64bon9y06FMFiCjeUw2WRQBgWG
UrqDMRuG3YduaM/CTwnfxhqgx3HaBA==
=oDq9
-----END PGP SIGNATURE-----

--Q3s/7AjDkfVHD/Ey--

