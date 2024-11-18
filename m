Return-Path: <linux-kselftest+bounces-22193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 457C29D17C0
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 19:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007B41F2222E
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 18:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3C81DED52;
	Mon, 18 Nov 2024 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq/vcwfl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7319DF4A;
	Mon, 18 Nov 2024 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731953570; cv=none; b=urTxlLjZrq9JJdq8cetkgl/0QV77LSONDdxjtHyjTp+oC0TVR8lTD5xY/5Ad/0CtGJ1JhEsvYBpgLn7AgpmUJ+c5+VjFKn8WvhRQgK+PcPC9+oHpcxVAaGXCjG+0ydCvs4mje2m68iGweY13efNxtMF+T1XCozBs4Y17JnnbaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731953570; c=relaxed/simple;
	bh=YwZjBB6hgO/g9UA0GSo0eqjMxLvqj//2HoPj9LGIuMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlgohCMkOewT1wOMagsJO1+XO7mP+WdwZBk/W504uQtDUmTPEe9UbVvndzh1km6MzmGBnv9DV/5eUiRLVWcdc968I58b7MwAQnn/mp6V6ci2p+wS5xDlLg3Ftxgh1ven7f2ntMh9vV4Vl1xN0HuQ5eNJSn37Ep8+giyUiy9cv/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tq/vcwfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EEDC4CECC;
	Mon, 18 Nov 2024 18:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731953570;
	bh=YwZjBB6hgO/g9UA0GSo0eqjMxLvqj//2HoPj9LGIuMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tq/vcwflmqImOGUZmEW9UM2uYdEbX4QKT+2zvTkCSQL7S3aQoPihoKL4uTCG7Fva3
	 CpBCn3ekbkvAeZw+3sYi5/4LPYYEre5LEIac+R2gKoECrmVLML/C2K/lDNxlRwhNIj
	 8OEb6KMT0GclJFfmiYAIXI+dTH5SLRv1xG36Panx6m4gplAbvhL92Lwk/DIniLT2G3
	 oro9AhKJMi08nPnf9TZ6MeHmbYR7nrQw26DTDHUPBnbh8GOnJ1YFjZu/rBxusUTm1d
	 /DUN3Q3eQfpYb7F2G7DElVKRJcmqvDbNg4zKDQq3sqFZXaa3j2sgTiZJvqH9q2jGXN
	 4IMB6bkylZgnw==
Date: Mon, 18 Nov 2024 18:12:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	linyunsheng@huawei.com, Andrew Morton <akpm@linux-foundation.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Linux-MM <linux-mm@kvack.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] mm: page_frag: fix a compile error when kernel
 is not compiled
Message-ID: <91e7e9c3-fbf9-40c7-9a7e-52fc800fe6a7@sirena.org.uk>
References: <20241116042314.100400-1-yunshenglin0825@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IaKl+DyrWtyGOQED"
Content-Disposition: inline
In-Reply-To: <20241116042314.100400-1-yunshenglin0825@gmail.com>
X-Cookie: Used staples are good with SOY SAUCE!


--IaKl+DyrWtyGOQED
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 12:23:13PM +0800, Yunsheng Lin wrote:
> page_frag test module is an out of tree module, but built
> using KDIR as the main kernel tree, the mm test suite is
> just getting skipped if newly added page_frag test module
> fails to compile due to kernel not yet compiled.
>=20
> Fix the above problem by ensuring both kernel is built first
> and a newer kernel which has page_frag_cache.h is used.

Tested-by: Mark Brown <broonie@kernel.org>

(for the case where we skip the build.)

--IaKl+DyrWtyGOQED
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc7g5wACgkQJNaLcl1U
h9DsvAf/bePfZQEkqvzyO5YOYn9KTkYZndX0ym/FzYdhPQwrMfr++Hrv8SgujAiE
IYM0Fxi/AVXCMFZCjfrdLdK4XGPuSMepPRSmu/EM+Yp0dwSksMHLReoUit23qAKK
zgeprOGfU0LYC2c4yWo7Ia5RnX+kbsGJg/7H0GGH80wlzzEwGPEnADZORpxymiln
KbLqOfg0jyPbuVR4Q1RDFzasY+1n347g9Umuj/g966D6HJeOsBWj8L3LOYH9IcOr
SsVqNhNUM4EKvn4N0rzcpiRqxCidlY5FWwzLF8Qn7JLG6D0kipTLzkx9j+tIKLSt
VYn/BdrtF97+2OeYiRgqm1sAkc4jqQ==
=M4um
-----END PGP SIGNATURE-----

--IaKl+DyrWtyGOQED--

