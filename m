Return-Path: <linux-kselftest+bounces-48744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6A5D12C84
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 14:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D504A3002848
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 13:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503A13590B7;
	Mon, 12 Jan 2026 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFq+3KXl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4A3590A3;
	Mon, 12 Jan 2026 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224449; cv=none; b=duVb41EoNYedE2ySSnPmFvUcJvOlt/x99+98ggXXRxrdFy/gqiZLc1PJ3XYLvtgBFjzTIeJqYLLRINr1Su1BsnB4qLcF+CBhSCoqvwPlmun1x0poKs6PqtpdrMmkUz8t5w48uQvgWIPGuGcF3Wt2r3gVuxsY546l/XslM8oiAVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224449; c=relaxed/simple;
	bh=L2Nn/rFs+RlJ6rgf4HFcLnQumCrLx6SGdVUMvPTDb4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpdNdG1EvBdXmwC7HAFSxkTFCFc9/ge5sNyUfGaEmZhLjmDXvjVDNPv9dgrBZugFMyuNG5ZWhIpGNU9dux4vxfJBhv6EFwn2qJ0LtVWTF6y63zibQLQqoaypLC6cn3tXlltfnvZmmxjwJm8z0EKh2jNg/nQoBWWFYrAUl/pUTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFq+3KXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969DAC16AAE;
	Mon, 12 Jan 2026 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768224448;
	bh=L2Nn/rFs+RlJ6rgf4HFcLnQumCrLx6SGdVUMvPTDb4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFq+3KXlA78iDGw1F5Bajo8t7XjXnnc4kzGGXyNlI0xIeCfSDq34uE+qXmjcE/tTf
	 WB9FpTPU28Wvsu6BxY+OGuD3KZsDXLTxwfaNSt4sTtaOtKkqgT8aMDtTWGV4xXYnNR
	 +k90qD5gvoqlG1sxaghZ+wIPVHrCu3U/HOGM00CkjLSpIqhm9/+zBFmqLPOmfhnZxf
	 Ls62qcIDfD7JuPO1Poc8MuSqDbTUiOtiiTiqCzxXUDfnhu6cq40YLNNhG8oTXv3pV2
	 vap+a0YG6Cxtug5VvVQGqPCzQnBd1/fbodfp0JFxi212YMLHz35ScbAVTR/mDOn95t
	 BF0kpa9ahS1sA==
Date: Mon, 12 Jan 2026 13:27:21 +0000
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
Subject: Re: [PATCH v9 14/30] KVM: arm64: Implement SME vector length
 configuration
Message-ID: <96efc90e-bf1f-4b87-ab7b-0e24970eb967@sirena.org.uk>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
 <20251223-kvm-arm64-sme-v9-14-8be3867cb883@kernel.org>
 <CA+EHjTw-6-BFcr60+tgDzOE-OfcetD7yQtbNMkqr7BgiMXfeJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RBS2qpD2qI92kXAR"
Content-Disposition: inline
In-Reply-To: <CA+EHjTw-6-BFcr60+tgDzOE-OfcetD7yQtbNMkqr7BgiMXfeJA@mail.gmail.com>
X-Cookie: Surprise due today.  Also the rent.


--RBS2qpD2qI92kXAR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 09, 2026 at 03:59:00PM +0000, Fuad Tabba wrote:
> On Tue, 23 Dec 2025 at 01:22, Mark Brown <broonie@kernel.org> wrote:

> > +
> > +#define vcpu_cur_sve_vl(vcpu) (vcpu_in_streaming_mode(vcpu) ? \
> > +                              vcpu_sme_max_vl(vcpu) : vcpu_sve_max_vl(vcpu))

> nit: This isn't really the current VL, but the current max VL. That
> said, I don't think 'cur_max` is a better name. Maybe a comment or
> something?

It is the current VL for the hypervisor and what we present to
userspace, EL1 can reduce the VL that it sees to something lower if the
hardware supports that but as far as the hypervisor is concerned the VL
is always whatever is configured at EL2.  We can obviously infer what
the guest is doing internally but we never really interact with it.  The
existing code doesn't really have a concept of current VL since with SVE
only the hypervisor set VL is always the SVE VL, it often refers to the
maximum VL when it means the VL the hypervisor works with.

> > +       if (WARN_ON(vcpu->arch.sve_state || vcpu->arch.sme_state))
> > +               return -EINVAL;
> > +

> Can this ever happen? kvm_arm_vcpu_vec_finalized() is checked above,
> and vcpu->arch.{sve,sme}_state are only assigned in
> kvm_vcpu_finalize_vec() immediately before setting the finalized flag.

I don't expect it to, hence why it's a WARN_ON.

--RBS2qpD2qI92kXAR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlk9rgACgkQJNaLcl1U
h9A2Dwf/azWkcrVrUODdNtqy170zbkUyq/kjAmL6y71Ep+9LW2Dwr9LGdow7/YUY
L23/xb3tTdT1jBA+vncQEbaotf1dKG0f7n2z7+f4AR/C8d8tFcPLsiDlk1W7axjl
6trxwIzWJ9ALOdJJ1ZAV906PWNnauRMZJ4S4d6J8B6GYM/g6hos1Zob4HUSTWNr0
YrtZWIUlcPX4b86MKLocEvm8TbgNmpH2/roaXKxnonYU4ZpiHpWsMOjGxkcWe5cM
CRPF7d8g56cHcCLQg1K2TYwGeVdpvfnahrQ4fhYa0/asAxpy+i3TXUlWQaymDCAQ
rnNgtS6mcPyMYMmARC9h+Bn0JnCubg==
=5u+f
-----END PGP SIGNATURE-----

--RBS2qpD2qI92kXAR--

