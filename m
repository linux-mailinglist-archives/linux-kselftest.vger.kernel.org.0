Return-Path: <linux-kselftest+bounces-48886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC16D1AF3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 20:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E26343001627
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 19:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CE735B126;
	Tue, 13 Jan 2026 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFe+UyiA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EBF359FB3;
	Tue, 13 Jan 2026 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331316; cv=none; b=qPMbWcF6L1Otk60OgO73lqezvJpKEVhyos4hLSYONKyacX3bvGO8ZchvYcV+kfdSz300cyX/wfetWpJDwQoiscsDJ9TgQdP8i/5npIe2Kc5x0GywqvkMbqGUUsfi0FLnJRN657A6X6pJCavzAc1/Faol2AduVJI9i1Yhf5+f7BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331316; c=relaxed/simple;
	bh=BlG7Ssce28/FBGer2w45hjxLQrro3n1kR5hQ9PoxQUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEomG4BmjCWT5SklZDS1pR33d4zq8FxKJcE6g/tV5TAI6wtSChG8kvKb7GUP/sv6R/8O49Bl3SPWmY4nVHXOuZAWyGiqrqZssA+htPVuAVzqkujBJ3REpLPFjxRBZA5euEUUs+CfMppGeMlvqRQnZaZatBDQteuEl4WVcHuqrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFe+UyiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAC7C116C6;
	Tue, 13 Jan 2026 19:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768331315;
	bh=BlG7Ssce28/FBGer2w45hjxLQrro3n1kR5hQ9PoxQUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uFe+UyiAM8nw1RpAZ8dnDlZg7/u+WeSfZkLTq7hnyWk/FNs6VBsAtz048ZbbD5t9S
	 sMryJrpGRz4zXqNq/VugUWEiTtkVm407BclAEbyYBo8ZXLyYcRCP0kTrYmT/vBtZE1
	 ydoUfR7Y75lBJf8cLjhopc9HQWUwMMAGmE5PTe51i5DMO/Qcu8w4IWY/pN19OMiCuT
	 PbHW0nF0dSWtdmm6qJRxA94B4J62po295i/yIZaGjC8D93JhOS4K5ZuanffOipvgWc
	 P3BLm5C3i2DzEKJBiA6O3CrVWchyOJdcHOxkI8+fc0/cSnBSN51m/+k9rPsF0GanYs
	 +/G1hpujfSJSg==
Date: Tue, 13 Jan 2026 19:08:29 +0000
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
Subject: Re: [PATCH v9 18/30] KVM: arm64: Support SME priority registers
Message-ID: <24d06740-f8da-43d0-9e40-81323f6a9237@sirena.org.uk>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
 <20251223-kvm-arm64-sme-v9-18-8be3867cb883@kernel.org>
 <CA+EHjTwxc=+1TodVR7X96fnKu-mykivdFxMbB5nUrw_h4MGKHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hJ8Uz2qkTdkXhDSA"
Content-Disposition: inline
In-Reply-To: <CA+EHjTwxc=+1TodVR7X96fnKu-mykivdFxMbB5nUrw_h4MGKHg@mail.gmail.com>
X-Cookie: All models over 18 years of age.


--hJ8Uz2qkTdkXhDSA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 11:59:22AM +0000, Fuad Tabba wrote:
> On Tue, 23 Dec 2025 at 01:22, Mark Brown <broonie@kernel.org> wrote:

> > +       /*
> > +        * We block SME priorities so SMPRIMAP_EL2 is RES0, however we
> > +        * do not have traps to block access so the guest might have
> > +        * updated the state, overwrite anything there.
>=20
> nit: overwrite -> overwriting

> > +        */
> > +       __vcpu_assign_sys_reg(vcpu, SMPRIMAP_EL2, 0);
> >  }

My original is correct here - the action we are taking is that we will
overwrite the value.  To use overwriting we'd need something more like
"handle this by overwriting anything there".

--hJ8Uz2qkTdkXhDSA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlmmCwACgkQJNaLcl1U
h9DLzQf9ECKYlxB9v/nA6ULn595t/Ut+L10MjxH5UG+Bx55K2Z6nM9DNxKzi74iW
92pZ/UIu2DAB+mKumhcHsSGtFvDONyUqeZwfIUE5XYWH+VoBEMQC4DIdYRi2YDwb
zSfvAh2lqiySy9RHeI6orV6dKs9u3HVxF/eb85+XpPbswIiOej4OW5RECEPrPUmC
A4ohL7KRW4flNvHV7WrA6gPpy+dAbkkh2/zP2V1VhwhKydikY7gAEyt5ec2BmK8o
aREwbFcuMiRGJaXWU+LhNmgus3k0YGLjZTOrtd+YmDlwCYv5qTjdbtc4iU82BusN
bjR4dgGoOXiso3+khcbbpEsljh4Oiw==
=Xsd1
-----END PGP SIGNATURE-----

--hJ8Uz2qkTdkXhDSA--

