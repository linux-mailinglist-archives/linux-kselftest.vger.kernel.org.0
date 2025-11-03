Return-Path: <linux-kselftest+bounces-44667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAF8C2D349
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 17:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2480346704
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA763191D1;
	Mon,  3 Nov 2025 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBVbreQj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B701264614;
	Mon,  3 Nov 2025 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188174; cv=none; b=SXFD5DZbwmy/Fs49OD5GpOKVbB8vWrqQ6vTTf3NvuSJLQqHPpQgOg24m5SKgzwqk0pM+ujiJ3LcTSqFHOvXdFtUF0sj2xzZi89UWjXjqFKytW2xhQiBSt5dB9Z2/uIFCQqtLhw7UIXBZwrDRPWHKTEtnjtU0XWq3xNBcI9NGhxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188174; c=relaxed/simple;
	bh=pYpE/o8QeVnvKWPaYcPJE1tYaZ7Vi13aXpPbvbysa7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goIXRhxV0m/AYuKh0MprpJesBfdBlQrW6QZ61qToOtxKickY/pdCKAmhqTWadA/bTALhZRvxJloTUPQkb/GZ6TB3e8dSaMcMSg2kJotp3x8Bp5B62uhEsroEWj2DJT+h4vJLpVHbB0FvIiTyci4IrTX+eO7rWAqOUymJcfNUoUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBVbreQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63513C4CEE7;
	Mon,  3 Nov 2025 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188174;
	bh=pYpE/o8QeVnvKWPaYcPJE1tYaZ7Vi13aXpPbvbysa7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBVbreQjg37cDVv0mGvX9dbU9+n08cbq6ZzOFDSiW6enAmiVfVYCyGNcGGp4+vvTC
	 DCDPxeJW9+EoKUqPzu6kcExrXZyKFYtkt7V0NoTfp0Md8uXB60buGicnmPTIt57IwI
	 syA0XqyVDb/lvrd4sTJQImXC4kHd/SCzdmzL7AmI2JTUtGs9Z3kZAUxykwq6J/PsS/
	 jQ2qFU0312rEPhkXayASbbsvhHt+qCIWlQ1hI3jmKbiuFNahkM40CQECEtUbgZFgJY
	 qsg6Y00CMlYCAu8c8SjFbUVO79jh61/mMate8J7VrZ54LSf+vs97sGymcDgRelmtZc
	 eH4dbDzM0sgEw==
Date: Mon, 3 Nov 2025 16:42:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, miko.lenczewski@arm.com,
	kevin.brodsky@arm.com, ardb@kernel.org, suzuki.poulose@arm.com,
	lpieralisi@kernel.org, yangyicong@hisilicon.com,
	scott@os.amperecomputing.com, joey.gouly@arm.com,
	yuzenghui@huawei.com, pbonzini@redhat.com, shuah@kernel.org,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v10 2/9] KVM: arm64: expose FEAT_LSUI to guest
Message-ID: <aQjbiyNWZxrjRLQd@finisterre.sirena.org.uk>
References: <20251103163224.818353-1-yeoreum.yun@arm.com>
 <20251103163224.818353-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SsaoZEtYAOX1mTlI"
Content-Disposition: inline
In-Reply-To: <20251103163224.818353-3-yeoreum.yun@arm.com>
X-Cookie: If in doubt, mumble.


--SsaoZEtYAOX1mTlI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2025 at 04:32:17PM +0000, Yeoreum Yun wrote:

> expose FEAT_LSUI to guest.

You should also update the set_id_regs test to cover this (the addition
of ID_AA64ISAR4_EL1 was applied now).

--SsaoZEtYAOX1mTlI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkI24cACgkQJNaLcl1U
h9ADVwf/SkI01bIU3sqijvh+m3ciwOMaw8AQTOZ21rAp8NHnf0xynHjwbIP0GLzh
z8Y19mBYMVtFkTkSAsPsHauHZbzaCRgN/Uje2OhNJTvJK9sRmEJr/Zvr5TgedGq4
5ypibycxN20qO9Zkhf6bVvclZ2Q35qHuM5ZQz8Vkbad8TmoZLS4x5rIcf26AFRS4
Cf4Zl5DoA5jFOesZmz6jKxYGVMPz73zOF4owaL/Hake4ZvG+JO6ijjqOGcPFjWP5
Bhs9DTIzOQzG4Ff2WfQw6VwWL3pZP+dMAKyL1cQnUkl7MaBHbDhVQjRsZhpxUNLh
2eTrRDfBp0Wez31IZmTh1EH2AMIobA==
=Vduu
-----END PGP SIGNATURE-----

--SsaoZEtYAOX1mTlI--

