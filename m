Return-Path: <linux-kselftest+bounces-47660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CFBCC6FBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 11:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87E6630393E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B733434B1B7;
	Wed, 17 Dec 2025 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxaavKtF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D12534B197;
	Wed, 17 Dec 2025 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765966129; cv=none; b=G142S+GVMFpftdQJ3sPKNuksi+mFan5b6m6GeEC3MRwp+U0lCmCQz8kUicBEXk5ASKtYYr1LuQW0bArNA7+nPF0ckQCQEtVOtdBG094ftVmYM8lfjWji/mTQ6Wyr72zo9VjRan3jJ6pEipdV0T4obXZT5O9ifNgOQhEMpuIE+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765966129; c=relaxed/simple;
	bh=X8MKDeUVfw3OZB5ABjVJIvLfdbW93JOXK+rfZHGoMJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmi95hW3w9iCwcYMXzUUjherjRgkwe50l07i4vGBDoRL9tCubp/VSC02cxkUh9JfWr3ojXyBzTQcPLJRSKy9quUV/nPTMsvTXgoHH5TooXZ2/BCtkVLDamD7C9xYN0cwCbmhsf2VqKnJueBd0lDFMPjmtJPfcGqeoFj31sOOCdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxaavKtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD105C116B1;
	Wed, 17 Dec 2025 10:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765966129;
	bh=X8MKDeUVfw3OZB5ABjVJIvLfdbW93JOXK+rfZHGoMJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxaavKtFFcBhvYnzUKNDaDYeYryHGC/WzcqZ79C4+IcZBzCcExa5KinVQzCFGxbxM
	 gU8EJc6W3luQ6eYl1+TIft06Qr2FLagp96N8FIDE8lHKoMKkfe8KwqcBnAmanA9Dsg
	 ZlYqcL0SGWifCHB9376NHx3x4FVpvpYqURlZbE/9vZSRFkGTV11Y56axnHy4gSIwpv
	 nUnHMfI3hLuFHFqfkkrX7jxWZwxWydSyDdIM1EPp4Xmhm0Kf0oOuhA/lVog/dAz8rl
	 8CnXIdHSbZK8WaJjEJUymbn/Vsm6h9Wt+sOW6waaxLQ2qEomXqkr46ilgMZef3ZgQi
	 zxjmBKcerudxQ==
Date: Wed, 17 Dec 2025 10:08:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
	Usama Anjum <Usama.Anjum@arm.com>
Subject: Re: [PATCH 4/4] selftests/mm: fix exit code in pagemap_ioctl
Message-ID: <67e61dd6-2a44-42f5-980e-e9196d672540@sirena.org.uk>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
 <20251216142633.2401447-5-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t/5ZkYiwUFTRW9SY"
Content-Disposition: inline
In-Reply-To: <20251216142633.2401447-5-kevin.brodsky@arm.com>
X-Cookie: To err is human, to moo bovine.


--t/5ZkYiwUFTRW9SY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 16, 2025 at 02:26:33PM +0000, Kevin Brodsky wrote:
> pagemap_ioctl always reports success, whether the tests succeeded or
> not. Call ksft_finished() to report the right status.

> While at it also fix the exit code in unexpected situations:

This is a general sign that you should have muliple patches...

> - Report FAIL if we failed to open /proc/self/pagemap (returning
>   -EINVAL from main() is meaningless)

If you do a new version it's probably worth noting that this is a
non-optional feature introduced a long time ago so the open should never
fail.

Reviewed-by: Mark Brown <broonie@kernel.org>

--t/5ZkYiwUFTRW9SY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCgSkACgkQJNaLcl1U
h9BIZAf8CjLi+jiPeYVUBYqds8b9OmmeB8XkCEyL0M5hPBsqY2/kDzeZimziH9XO
Qw/OC4nY9wuPBpB3oIXS9DepB+1FKfu52OCaMJvlTyyLoJ+cmCghU+SGM2/c8xAi
ATmIz1z4W1zOeh9BAordLtgA29AmuWbGZw7zUKVtTzKWxkh2ppHinT9KlnKuiQjO
PhwOMWhv0hQYjn8qE/xfZIyOljbebU8uPJ1/ic01NYZpfV02153XV5QlTiCTIBE+
4mBn13VFWVqA92WHd0OczoiRsLy/tgB/L8sGBmDV+0m5BvFU3mg6GfAsMUvQDcu4
S2+duB9Czrzwn4vcHQPd+xrCaaMFSw==
=g9QH
-----END PGP SIGNATURE-----

--t/5ZkYiwUFTRW9SY--

