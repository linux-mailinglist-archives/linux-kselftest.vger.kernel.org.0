Return-Path: <linux-kselftest+bounces-38554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A877B1E7F6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 14:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E8B18C77C7
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 12:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201142673BE;
	Fri,  8 Aug 2025 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDuVOPba"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACEC2367B6;
	Fri,  8 Aug 2025 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654722; cv=none; b=Dd3uuPjP0KVX5kxppatXwJKMCI2phPOQzl7hYcXK70hXH2ho99rw8VU5h6PFSP7dJ+kiFrAPMlIeAi9apiqJ5FcCXGAiE12+2VobnvFw7gyv0l/jXtHScEipGiM3Josii5oPC/mDWhZi7bRsU5imYSSrd7u6wzI4d/2jRhfsyfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654722; c=relaxed/simple;
	bh=okAOZ1OZXDNLdQS8+y+ojELqtzlRQHXn0iFJZw+WtfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGYVx0vE8xbaIsdCKEhTb+NX+O7LEC3dVTp+vrhFId3DbN3Ll0DJg22AfozDbsNkDzrQSSZ382egAbVNmAqdinUCyLMQdcFZ6VP6B+TkQmBHxlDJugaUnvu+hNUzQPYRSwPTOPA8ah55gV8Q+VBbmlpAzXrDFC8O6e9nLki8iME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDuVOPba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2C6C4CEED;
	Fri,  8 Aug 2025 12:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754654720;
	bh=okAOZ1OZXDNLdQS8+y+ojELqtzlRQHXn0iFJZw+WtfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDuVOPbaXqhauqjuwvjo+RegfMk1odWWcnKa7n788sSa3zx7gOQj42MbHCDhQEWAN
	 jFVGaDmwPdn/j4rC+ba6lwWfxDFXmDcCmhb8h9ot0mXosiKajritWRpua//F2VkQKF
	 ZWJJkUfvCn9BMPAvpjnCARu8Qt6VRPhRvC9Qw/lFCxzdqoYKp6/++FvPMubBRfTW+l
	 bXZgTsCmabKpfJAdijwQw7TWztH/FnsmwyW3L3utjbpmmmxVg4QDho5oFuCXvLnvec
	 AOziUS/RylraXtcwOiXD/tDFB8ui8Utm7TrUCQEeTFhhz9p/DHgpdWye7iKAOZHDND
	 W5/t1I488x9bw==
Date: Fri, 8 Aug 2025 13:05:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: arm64: Check fread return value in
 exec_target
Message-ID: <4f2e8b38-4112-4dc6-82cf-51c33c2daee6@sirena.org.uk>
References: <a72e8741-a63a-487e-838e-daeed3458c0f@sirena.org.uk>
 <20250808080955.41735-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="re9NTMx0eutBKzqo"
Content-Disposition: inline
In-Reply-To: <20250808080955.41735-1-reddybalavignesh9979@gmail.com>
X-Cookie: What an artist dies with me!


--re9NTMx0eutBKzqo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 08, 2025 at 01:38:30PM +0530, Bala-Vignesh-Reddy wrote:
> Fix -Wunused-result warning generated when compiled with gcc 13.3.0,
> by checking fread's return value and handling errors, preventing
> potential failures when reading from stdin.
>=20
> Fixes compiler warning:
> warning: ignoring return value of 'fread' declared with attribute
> 'warn_unused_result' [-Wunused-result]

Reviewed-by: Mark Brown <broonie@kernel.org>

--re9NTMx0eutBKzqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiV5/sACgkQJNaLcl1U
h9AOYAf+PIjSO8FWmG6yjgk8l/Ib09wzXRxt8Cw48r9nogN2rqHzMn43s+A2YR5G
YGp6Jd9fGOD+UbVNdmSkQicz4UhlXGh2edRtExagl3kUJe+tOTEDKYwn5Fth/Zi9
MgduTuwK0E00JxFzkSGlnrrsz1GrTzABWyLDxFFGSJW86gtFbA+Q+Y2T9YT2jio1
HI8BoNLcYz8gSy7u6VLxfU450sCLh8Loze74fBSNP533UEMCwRpEknbAeEDpiC9A
8b44RNDXA4o6ZF4J4xoDMLjKOEtrGt2frkfIoj/fFRwhyUr297P2fgBKp0vD8U4B
SIhBCSVsn4w9WmiETpeLiiMLDRpyZw==
=DZio
-----END PGP SIGNATURE-----

--re9NTMx0eutBKzqo--

