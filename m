Return-Path: <linux-kselftest+bounces-41903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B47B87180
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 23:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891333BFAB5
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 21:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36052E1754;
	Thu, 18 Sep 2025 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY+bDWTr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F25517BB21;
	Thu, 18 Sep 2025 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230272; cv=none; b=sz3mtpcjktOPlKvKotDhLoOmaa8WgrReqRXznGY380phvS7w3LVB9QRpUjIt8YSUyDbmb65i+cpojS0rk7wJ6DxoX3CLSGFmS0x+NEzCUCQpIllQS7UGs1YVgqAe2g53isHkcwzkPR2PVkZK51J2xOFBD8c3C5159esrLKhxxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230272; c=relaxed/simple;
	bh=fc6zzd2NFbc4n0qZ3WrDFi+otpxyFwSPEnO3pb1g+o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh1oU7z+P/M7IhElBptaSNXAhP8VGP/qEIUYsKbJpsLnjQt+RSwhskkdJggOSiLTO+nHFIm1Y2K0f7ygkyWUvzq2PO+vDmFaAtkvvIQvCmLSIW838iEcr080xlIZpDqTvCp48QpCR3ZNYG/dySgVDPvvzfqCm7mTMwpFrq7XZ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PY+bDWTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899B9C4CEE7;
	Thu, 18 Sep 2025 21:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758230272;
	bh=fc6zzd2NFbc4n0qZ3WrDFi+otpxyFwSPEnO3pb1g+o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PY+bDWTr3DHO8nXieZf7iFs+OlX+1OdO/LjogJt2uyongtZKaWYKtvMf37vFbv6jO
	 ONZG9F1bL4q2lmipxPt0jzliKbOuqqt1Y7ThT+p97VIYyv1h0gbb3xLfC/8tf3nhuY
	 7rUKlSQhxSoYz+2/auX1e/Ubhwzi8/AXoR4D1u8OutCN9vQwd4wz1ab9TaSj5euXXA
	 /sge3cSgDJbOmtUDy1HERQwSefZ4qH0p01fvFyQKNhta5HriRc1pI8F9mxRWbvZby0
	 N0R6f+iEI4LfrbBV7BxwUOkr2m3N1lvRkfYo9HVh9hKW8WXBSOuD6CfLBdGgQWZkac
	 BdVuDEq5NmjaA==
Date: Thu, 18 Sep 2025 22:17:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 1/2] KVM: arm64: Expose FEAT_LSFE to guests
Message-ID: <19b5816d-2720-4535-becd-18a3468051d6@sirena.org.uk>
References: <20250918-arm64-lsfe-v4-0-0abc712101c7@kernel.org>
 <20250918-arm64-lsfe-v4-1-0abc712101c7@kernel.org>
 <aMxyKbnVjS35YuQi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="16gKMbNZJBY0LNnH"
Content-Disposition: inline
In-Reply-To: <aMxyKbnVjS35YuQi@linux.dev>
X-Cookie: Victory uber allies!


--16gKMbNZJBY0LNnH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2025 at 01:57:13PM -0700, Oliver Upton wrote:

> We also need a test in set_id_regs.c selftest for the writability of
> this new feature field.

Sure.  We seem to be missing some existing fields from that register
too.

--16gKMbNZJBY0LNnH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjMdvoACgkQJNaLcl1U
h9Be6Af/TBs9wrBxy+VeK23RJ2+hMChN440Xk5kJc9GEu2ERR6D0ResdZGBMfhkP
2vHJxdn6RhX32+PhTi0WsUkRirE6+K79mrVjcWu2EWpl7QYcTSTs80pKORPTwe2t
6amYPm7ZUWuPf3Wk8yWex2ZFqeq+CEFQDBc3jJy3f9pyXRe2e8wNU72uE6eXiALm
jicbhS7kKd4AosMPjWwjlNjHgNxpJGS2lOF/ikcGc5Ayx5OQGRh+DzplmZsvexeN
yprP0TiVzHciGa5Xqm/7Wo7/ussYeXilx3O+mpSDs0jePKAHkidDAafz78dIKcsK
yMXMy2stYabVPmm6DTdh48Dz/t/7MA==
=/Bpf
-----END PGP SIGNATURE-----

--16gKMbNZJBY0LNnH--

