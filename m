Return-Path: <linux-kselftest+bounces-39595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DE5B3078C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 23:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D8CAC5865
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9C135FC0D;
	Thu, 21 Aug 2025 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pN65S0Hm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8635FC09;
	Thu, 21 Aug 2025 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809067; cv=none; b=cFfCVuAZN/K5b+SyWhZ9WKnwjVIzCBta2o9c2t5G9rjBelYx8aLekBwu18hK/eZZwtc2i+Uiwg72EI48v1h8lbUQ2bsFAl8khVVtwu1ADi/TQMb6u2VYCeU1ADbP0opHk0TPMoaJawJVFP0bzB3IeFi+nWh1gdSp4z4WOhl1OQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809067; c=relaxed/simple;
	bh=QGyQHv1jYZF3uVA7onjUxkDQan9RTUY4fxnZL00rGXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms3rGdFIo3JwL5S9HGCpGNdH2/h0h+1kspOxCHK7l/VBPVpakE8k5BIbHIh3BfyqjwaaphLbMHShwhgMoG8UyV7iAYkn1x9Ud9bSLPX/a9VttBg/OKVICn0p8qOUaWMIjmpP+mobY6zFvB7pkhyB8xZh7XKPAANPbo584hxdRZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pN65S0Hm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CFDC113D0;
	Thu, 21 Aug 2025 20:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755809066;
	bh=QGyQHv1jYZF3uVA7onjUxkDQan9RTUY4fxnZL00rGXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pN65S0Hm98/7eBQk2cyfAEh3nYjRLHVZAjZmP8LJZJoELf3EbpS+l1LIqzljo8U4m
	 HjWxJpslql+PBGVkeqxPE9n11kL4MRvMiggg7zCiHMdp78jo6VRLAjkVxe/dw6BkFU
	 G+UnH0makA9mu+VZU+SOu+Opf44USbiuhiXodj9hdWvl+RPvxynWgI64NuSf8qkiNJ
	 wbQtxTMswBVP200c+ukNe+EQA5zTOKHo4/SA+O9d9HAchukQt/pZTrSwZr3n5dndDB
	 OjPSC8CM+JBMOsfGNpVi7azWP8BWK4YbsVtytLl5AAk+ErosVxPo1mv62bmKx7VAi0
	 BjXbN96zvqrXw==
Date: Thu, 21 Aug 2025 21:44:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 4/6] KVM: arm64: Set PSTATE.EXLOCK when entering an
 exception
Message-ID: <ac3b2d52-5b24-441b-bcdc-463ae9c78b3d@sirena.org.uk>
References: <20250820-arm64-gcs-v15-0-5e334da18b84@kernel.org>
 <20250820-arm64-gcs-v15-4-5e334da18b84@kernel.org>
 <87ms7tk5y4.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+NFBeoT7qeYVduLe"
Content-Disposition: inline
In-Reply-To: <87ms7tk5y4.wl-maz@kernel.org>
X-Cookie: Warp 7 -- It's a law we can live with.


--+NFBeoT7qeYVduLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:02:11PM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > As per DDI 0487 RWTXBY we need to manage PSTATE.EXLOCK when entering an

> Nit: please use an underscore between the type of a statement and its
> "name", as it makes it a bit more readable (R_WTXBY).

Updated as you request.  I have seen both usages - the non _ version
plays nicer with searching the PDF to find the rules since you can just
copy it directly into a PDF viewer.

> > +	// EL, or to GCSCR_ELx.EXLOCKEN for an exception to the same
> > +	// exception level.  See ARM DDI 0487 RWTXBY, D.1.3.2 in K.a.
> > +	new |=3D enter_exception64_gcs(vcpu, mode, target_mode);
> > +
> >  	new |=3D PSR_D_BIT;
> >  	new |=3D PSR_A_BIT;
> >  	new |=3D PSR_I_BIT;

> But that's not the only case where we have to deal with EXLOCK, is it?
> What of ERET and its PAuth variants? R_TYTWB says:

> <quote>
> If in AArch64 state, any of the following situations can cause an
> illegal exception return:
>=20
> [...]
>=20
> - If the Effective value of GCSCR_ELx.EXLOCKEN is 1 and PSTATE.EXLOCK
>   is 0, the execution of an exception return instruction to return to
>   the current Exception level ELx.
> </quote>

> My reading of the spec is that this needs handling.

Am I right in thinking that this handling is needed for the NV case
only?

--+NFBeoT7qeYVduLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAminhSQACgkQJNaLcl1U
h9Ao0gf+I31dMh9CHMVH6wKHnBom98nMGxIPuirlnN5zM3f5tofXHJRgTQvJd6oS
LqRiqCSrp8MjmOFPti9rUMk6WRRzGGG4gHbTO1ANmaGrlY1frYhW91SH6i+03XH8
i79wMm5+COz/jk9DXmVFJzuk2PQTTs7xUy9+UW3ZXKpvauyeaU0QH0IBUdSHG+ks
QY8kAt7lp4hklpFTlrYnCjNMui2AU2+Pu+Wu+IF6Y12i6dJ7dk2RtvH/PkFLw4oG
8NCyFQuC4WX5tOIaGNpbzdmgPT5gRHs48CgNzRrI/BPWiWQ/Pbakceh5DN+pYPNl
donq5HcvHZXywx/jXKdRbBgUHgPFIw==
=xfXz
-----END PGP SIGNATURE-----

--+NFBeoT7qeYVduLe--

