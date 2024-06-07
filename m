Return-Path: <linux-kselftest+bounces-11358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831A6900402
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBACFB2357E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C0190678;
	Fri,  7 Jun 2024 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWw6VAFA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1569F1E4A6;
	Fri,  7 Jun 2024 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764356; cv=none; b=S580EwLVYugvifgqsZlwFCCl9h4z5Xfp6ocbOF6cJfhGRRlS+OlaJ8zkrlnZFdNEl3aS89f+KEp59c5NeWsSeCIXl3nHPfONvmQlrlQlmbu+YpPpG0bxe7CZc80ZM+jhuxZ2y38ThrwXf/Yu9mHA+4XUBFvMeHte4FDNtnNB3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764356; c=relaxed/simple;
	bh=hF/X7KlomMHMzsJSKql8bn8fmbCPq2jCFmCqNF4eiBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smKHtwzvhEyhgnaBPyvfsk1QR54XiGmjnhgTksN/kEsNQZp5Ij/e8nx69mFT+PnOyuI6atnbZHMs9dL5sYdMHZOfd6zqSrKLDnu6T61nv/pehdHuaqtRaEDox70O7KBEcjmsXnRVuvRJqDX/HofaubHREaa4QS5xRM8DPqYLy28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWw6VAFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390CCC32782;
	Fri,  7 Jun 2024 12:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717764355;
	bh=hF/X7KlomMHMzsJSKql8bn8fmbCPq2jCFmCqNF4eiBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rWw6VAFAGBckJ7hTL5q/AvJTIoQ/0YX0C2it8XhCYEF5aqlE/pAfDP5czqJFeLfV5
	 vl9OjQL4sz2cG833SLcY92aqqdBjc7d6pnzuCHgLj+Cgk1mRwoNHHfAJaNYVV/HkiW
	 O91r0uJdN/lSwQLzc0iKDJ5YU02jBemVHayFKzPAlQmowI8lPjZ+BhpKY2z5NZE5/u
	 lx96/ZO5Hk17GC9Bx0yoUswVyL8+lUlrtYenKeCwAwuR3U4JEOfI5GZUuv8H7LwAC/
	 ljxwxLcisblwZJy9xBX0Dg7d2xc4HqE0a70UdJvizteTpmJNFJgxCO4ULF/i/iWZEH
	 65hzYOGf1UyxQ==
Date: Fri, 7 Jun 2024 13:45:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, oleg@redhat.com, stsp2@yandex.ru, mingo@kernel.org,
	tglx@linutronix.de, mark.rutland@arm.com, ryan.roberts@arm.com,
	suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com, AneeshKumar.KizhakeVeetil@arm.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: Rename sigaltstack to generic signal
Message-ID: <ZmMA-5HHglADRyXt@finisterre.sirena.org.uk>
References: <20240607122319.768640-1-dev.jain@arm.com>
 <20240607122319.768640-2-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AP7e/HaCWV227buw"
Content-Disposition: inline
In-Reply-To: <20240607122319.768640-2-dev.jain@arm.com>
X-Cookie: Your love life will be... interesting.


--AP7e/HaCWV227buw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2024 at 05:53:18PM +0530, Dev Jain wrote:

> Rename sigaltstack to signal, and rename the existing test to
> sigaltstack.c.

I think this is reasonable if we're going to add more generic signal
tests - sigaltstack is a fairly small bit of functionality and having it
covered as part of a broader signal suite and the overhead of setting up
the suite separately is probably not worth it.

Reviewed-by: Mark Brown <broonie@kernel.org>

--AP7e/HaCWV227buw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZjAPoACgkQJNaLcl1U
h9AHoQf9HyU8H1WUySjTBoUT1/goOoNOSEF6IKd8i/CDYIID059iLpTzjV8xlQPb
WDdj0ygVlgTnJi7m7AINkj8P6H26iLcZ352S9dBfHXHwxktRrDu7F27Sy80nkS+f
E5D1Y7/tgqaSDMN27+B2abbSFFPuMv+A75zavx4YIdvbbtAmHmRvRWy9WZJs6aII
seNZc6rQHtlRBpgulcRzwQOQFQ/jyAn/JGh4NITSJ0cDIvlWByEAFmxdIkNj2kQA
hTEQa6M3pu3HykKA/7tmWCGI2gpRarIUjF2Db8Z6XUAGK4tfvJBlROid4KFdObBM
WPBaRFPbYlwv2gS0TaIFvFbITOoB3A==
=C5Qv
-----END PGP SIGNATURE-----

--AP7e/HaCWV227buw--

