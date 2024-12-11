Return-Path: <linux-kselftest+bounces-23180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16AA9ECE78
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 15:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF072188887F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 14:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88B84964F;
	Wed, 11 Dec 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIBTgR/4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50D1CD3F;
	Wed, 11 Dec 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733926953; cv=none; b=tZkbwJxkUTqqfrOBAU8Dof0s5LnsOeiDPL87RbFKXVUHgPt1uTfXZnvTyXjToqWd8q8ygj23bVj+HL+FFsOOy+GCRLnq9WqxI8WB0dVl5gQktMDzFwkl3PLKwJFA6cjb7o3yQksrl+bYkCs2nnGtsKGkNqsMN2z5JTAJ6foEAaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733926953; c=relaxed/simple;
	bh=9GFGBRoKYbX3/BHaisqy6VQSKKdmiRV5MR8dYdoSLoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMMtWzDX0fQxNk+InmoN5Uy8mhugKnercc2bTEHybKrzyFMZwrAnqkSQaWDMWIsXdM+dopNBx4HEWkFYn9zbXEIBpkOMLJaety2eDcBPpnRW326uvl2XidTT+fQyIw3iGKmhE0OT2FaWHvw+U5zEEMfo0Kpv2WGNDPqMFtjwlP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIBTgR/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82021C4CED2;
	Wed, 11 Dec 2024 14:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733926953;
	bh=9GFGBRoKYbX3/BHaisqy6VQSKKdmiRV5MR8dYdoSLoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uIBTgR/4TwdzUGIzjJSjfptLWKWzXyBwEpMSwF8RNgMfq2JFTt/M6QzE04K8Hp1wL
	 I0WIipmMKes18WEkjok3ZQ5SWfpPmE06iyPG29rVDOL/3xVqNowImTU9/X6+xmr8Ba
	 ikCj4U1w1OZ6iy5gwnFgR0OsTZlu0J5mfpGAjgIN4JMOtDOLgkxRwy+wZNUbLfz/8J
	 8OKCWMqd29XdE1DKkryYzrkkZS5CNN3LZDcXrgcc6UKcParRnqg033OEOSX8rGorX0
	 ypPzlLLmo399cFBB3ZbtyCKIFwdHuw+TFVx5B9Gz+chr91XWfpTxeN5ALv/e8vPl4P
	 nz+UNpDYVZILA==
Date: Wed, 11 Dec 2024 14:22:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kselftest/arm64: abi: fix SVCR detection
Message-ID: <804c336a-30c7-4d4c-b8dd-24912de39808@sirena.org.uk>
References: <20241211111639.12344-1-o451686892@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bJ96iDhLkg2PwTh5"
Content-Disposition: inline
In-Reply-To: <20241211111639.12344-1-o451686892@gmail.com>
X-Cookie: Every path has its puddle.


--bJ96iDhLkg2PwTh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 11, 2024 at 07:16:39PM +0800, Weizhao Ouyang wrote:
> When using svcr_in to check ZA and Streaming Mode, we should make sure
> that the value in x2 is correct, otherwise it may trigger an Illegal
> instruction if FEAT_SVE and !FEAT_SME.

Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks for spotting this.

--bJ96iDhLkg2PwTh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdZoCMACgkQJNaLcl1U
h9BIUQf6A/rU3f0f91Pf47ZodZLzOxU/d/asQ8duMWLaCfvdxZLW1fzCLXCl85tn
2ExRdxuvM9yNmk//Wi/Tvs2aRebFCS/m5H5GUdaelrDDFFamRaLD263wPPg6CF8E
Yi06wd4eQdzm8m9THHEqno2sluJIwfUJbaoF6F/ne8VYSUWROVE4Wr3UY4OWU+Un
Z+8jIecDVaxSCeAlcwGDQR6po6YDopwXqmcOcZ87YndXecqnIBFPuhVD/zYQpNAL
XEW1GVqElH8THyIuOk7cNmZ5dgQ9p002FPW6fQ5FlM6HhX0AA/8wlPK/yPoE+URN
HBPjGuZ+8xKYm7AADFPoYvqjuPrdZw==
=xbKO
-----END PGP SIGNATURE-----

--bJ96iDhLkg2PwTh5--

