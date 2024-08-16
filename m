Return-Path: <linux-kselftest+bounces-15546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAA9954F8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9791C21460
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F50D1C0DD9;
	Fri, 16 Aug 2024 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz98clF7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD2B1BF33D
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828083; cv=none; b=RkjlXy3qubQK/Qu7BXhWk3x9mogfv9bkQkW/S6DBD3ahrisS9iRdSkq1iotHXfkFfAeG22TTeoVcxAj9SB4+2HDe0970WJ+tJ2+g8NOPGP8M953ontBqwFDTr6V2w7mJ68y0TsTPTv1xwxqhM0E50HWaUxjdHSsTwmCcmn4+qAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828083; c=relaxed/simple;
	bh=8CFGkKppoJ1Oj4O+/W8uX2x7PXfWfKOKFFdlLyu3WLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od3UVvk8w5lRi/WAHrVG6S/5WVbgXHwdk2dj1HvPlieHpFzf7l2CUNC/kFPGW4fF59jTBfpnUWIitrp3205B6w7PXpL6Ni3CqkXEPDEAmvkzApKtDEGukYTIp5/Xi9B3uxECSSCnAMc9jx0JyrRB7Ihb2LFoEbw03GIVv8nvM/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz98clF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1015C32782;
	Fri, 16 Aug 2024 17:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723828083;
	bh=8CFGkKppoJ1Oj4O+/W8uX2x7PXfWfKOKFFdlLyu3WLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pz98clF7PX84kEBGB6fxQtw561paXCvu5T1ghHrDT1yfsCIXX26Jk1b/tD8O5Yj9J
	 j2p8+Ymye9l3wW3o6rC6K95q/wXnbY7EzVAa7rJLkP/esKx9nZt/TOsLUyXBL7fyUS
	 z5xDape7SxGtLquQLFksfKUhR9sugCfcsxLOBacjNzH2T5FHyVi3MFX94OXBXEGqRA
	 7yA5pgxiZr0Eof50Y2+FgQ2+wxSyaPWA4GMMMx7VsPzvW5njsCY9WCGkgvejV4w191
	 c8OC2oL0N/dpY4dV5X0hHwbmSomNYPjaxdQYl2eYle1OQxLFmlvIqauMwARgoU6OD1
	 pm1c83rrqrF9w==
Date: Fri, 16 Aug 2024 18:07:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 5/8] kselftest/arm64: mte: fix printf type warning about
 mask
Message-ID: <943897a1-aa54-4bae-8ded-29652d7b2966@sirena.org.uk>
References: <20240816153251.2833702-1-andre.przywara@arm.com>
 <20240816153251.2833702-6-andre.przywara@arm.com>
 <1afb487d-b5ba-499e-bae1-8579d7b3303c@sirena.org.uk>
 <20240816175548.01b0c515@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Buwi57v9MmrW+VO"
Content-Disposition: inline
In-Reply-To: <20240816175548.01b0c515@donnerap.manchester.arm.com>
X-Cookie: A Smith & Wesson beats four aces.


--4Buwi57v9MmrW+VO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 05:55:48PM +0100, Andre Przywara wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Aug 16, 2024 at 04:32:48PM +0100, Andre Przywara wrote:

> > >  		ksft_print_msg("Got %x, expected %x\n",
> > > -			       (ret & PR_MTE_TCF_MASK), mask);
> > > +			       (ret & (int)PR_MTE_TCF_MASK), mask);

> > TBH my inclination is that this is worse than letting the value be
> > promoted, casts (particularly casts of constants) are just obviously
> > suspect in a way that printf() formats aren't.

> Fair enough, I wasn't sure about this either, and indeed this down-cast of
> a constant smells dodgy. So shall I just use %lx, and rely on the
> promotion (so the MASK being defined as UL), or cast "ret" to long?

My inclination would be to go with the former.

--4Buwi57v9MmrW+VO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/h20ACgkQJNaLcl1U
h9CYdQf+MaQnuDlPLwGFflqj3k4aR4TK7UBof09OPFv9GXd9gy+way++5Y2pq2Fw
kl9igyb0UBGL48ZkElURWKixGZjkk9qOMT00GGHl0VxqjUVYhGkvw+8Fd2YLPLTq
kGpzooX4+jsM39pxp9SYzTQmLqXthM75RtuAw2/oruT1ylcn+V7ydEF7bWa6c6mT
QISFq8FZmXkgL8HYLAJ1H5Xq0jjcrhJM3fr9xVJOSInfvUZwGd3whU3zJnlrxOQ7
2n27Lm486Kjy3tqOzzEtEkdN01WfvjECJUapv8nljlHM92JDKx1NBC7ORnUIlbIY
GwfzVqZkj3No0hhdmuukyN/IMaP20w==
=HUls
-----END PGP SIGNATURE-----

--4Buwi57v9MmrW+VO--

