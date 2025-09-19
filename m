Return-Path: <linux-kselftest+bounces-41974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1560B8A6E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 17:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D1B189D60F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0D231C56D;
	Fri, 19 Sep 2025 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOV8MwTf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51AE2C21F8;
	Fri, 19 Sep 2025 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297191; cv=none; b=AzI3f0YUDB9kLk3xhHmLtSwMpfmXlnsYgF3Zy123OW5MrIzXWvPtk6SESFp4O3p0zicRUiJ0k00i4iEoepGFeuQsh0YaqzixTxOkS8qHYsj0ZP8IZnrK8S6bsVXkSnd/mAiUFvqlWR5y/yT6qUET/M4VRDfXVCDb68zFqxKp5kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297191; c=relaxed/simple;
	bh=LY8UCU+64dez0iKU9byrdE3xtr9uB9iMyeO1oDOL/3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvBbwZGfXxhCV87uszwgaTr94SFnHK/JckYQLs8pGpFNqxXTFJfW+DQkm6s0Y5uNJuC/uK5Z6lyq0X0+KqfR0+Vw9dbR0Y5OwcsL+NuDTEvmJeQ0pOJOyjM40tP9qONQmU0wVSN9lcLnboONKm9ip0KB7A/nX1o0YDivUvO6fko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOV8MwTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B428BC4CEF0;
	Fri, 19 Sep 2025 15:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758297191;
	bh=LY8UCU+64dez0iKU9byrdE3xtr9uB9iMyeO1oDOL/3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOV8MwTfLG18DZwwAPFD7Rm3sJbkyFo6QukFWydz9vWeSc3v1IRTSVl/a7ocNxvwc
	 wMqEh/9o0j5TxAusXbyoSzPbete1PUJjByFf64KM1Z4oeTbiDTV+gYibMfkkeQMBwS
	 qbaBJOFWiRtx2AmG8a80m2G8+8EZ/dlJyp+QcYLrP3ReF30/gSvI0anIRYts6wkj/S
	 LM95N3RzmWzVm4wpTF4ARgK/7l+X4l7di8KcnVlEbS5A5ZBFw+umfAduBXS0e57DoH
	 dtEz7AaZT1SUQ3IYanPM99hXRfIAgGz3ZCkxozn+1RPQf91a4fmhmeZtmw1CJ6MWDM
	 j1kIgvB2pty8g==
Date: Fri, 19 Sep 2025 16:53:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v8 06/29] KVM: arm64: Introduce non-UNDEF FGT control
Message-ID: <d27a1c5a-9173-465b-90f9-fec528181ba7@sirena.org.uk>
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
 <20250902-kvm-arm64-sme-v8-6-2cb2199c656c@kernel.org>
 <87zfaqxymu.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vZXtN3VZj3O/Y/5x"
Content-Disposition: inline
In-Reply-To: <87zfaqxymu.wl-maz@kernel.org>
X-Cookie: Don't read everything you believe.


--vZXtN3VZj3O/Y/5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 19, 2025 at 04:14:49PM +0100, Marc Zyngier wrote:

> FGUs are uniform, because when something doesn't exist on a vcpu, it
> doesn't exist on *any* vcpu. Non-FGU use of FGTs, however, has to be
> more flexible because that's part of the emulation, and is actually
> pretty rare that we want to trap something at all times, on all vcpus.

> For the same reason, conflating the R and W registers doesn't work
> either. For the above example, I want to be able to trap write
> accesses to MDSCR_EL1, and not reads, just like the Ampere
> brain-damage.

> So please make this per-vcpu, decouple R and W FGTs, and convert the
> Ampere horror to this scheme.

OK, that makes more sense - it was a bit confusing that all the FGT
handling was done per VM not per vCPU without even any provision for
per-vCPU or distinct R/W stuff, it seemed strange.  Since the SME
requirement also ends up being per VM anyway I just tried to fit in with
what was there but if we don't want that behaviour it's certainly more
obvious to make it per-vCPU and to split read and write.

--vZXtN3VZj3O/Y/5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjNfGAACgkQJNaLcl1U
h9DpYwf9GkvMEDYrTVm6kitHOpS+F99swSxSDy+9IjuOkcqkQIm18C2AoZe1iD0A
ZOB8PfTlFDFJGW4gxWHcWHk5prOp89I4xC2kXlguPQYe3T8QHfcsDDAJFxwhX7Xb
C0ICRPJQC6+q1td6A51wmqsCQ+N7cWd5oBz4A02evYJBcQ/7ZGlF3ykFUZTRhW+1
c5HGNIW9RSsbdoFLFtSAJYzFmXfMSgDdJB/5AG6BJ1wdY9CF4cdRzNI9TyhmAWti
qh/oncDSwLMg6VU1rkNhaibL7vRbtKI/7D3RldFVPyXuf+gqRjp7rC991dMcSgh7
iXujfThG7ZrCubxYhsccwtS4pIR5Jw==
=0qCo
-----END PGP SIGNATURE-----

--vZXtN3VZj3O/Y/5x--

