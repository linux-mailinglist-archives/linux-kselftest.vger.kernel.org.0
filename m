Return-Path: <linux-kselftest+bounces-33500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B09D9AC0898
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 11:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9271B67574
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838D82686AF;
	Thu, 22 May 2025 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ3wMS6T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8B2638BC;
	Thu, 22 May 2025 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905839; cv=none; b=N6t2O252RAgVkNZ1MK8CmG1D5cx8MB2H/P4BawrgZuXGX9PeHGcf4ysH6VhxkpkQzxPyn2mcOHFnag5w3/cB8jDJdBC1MSzG0iva88Ri4wCvJ7x1U+LxywK0fhfEeQ3+DeFe034KgENyCS3yNQSaaxcP1OMro+SnQ/N7lJp+fAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905839; c=relaxed/simple;
	bh=eXAlb49JkCb+TQz9exx3hf5fNZb3kP86w2z33zlM7Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Is/g2edGqgO5TDwFDDn5ttoElmw3o/ZuYcyRhuJIhiOJ/s+rU5Lq1LFvao8L+gz0eIwZKVTPCKHgrGhngHQ7j1qvxg35EZE8k5+tTzTIM+N/9peD/lYlO+XwAa1pY6cDdoHpVYQ+8zzQ9AIM7O7CFaPkX+/mJb0DS2aFEUh5/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ3wMS6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB9BC4CEE4;
	Thu, 22 May 2025 09:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747905838;
	bh=eXAlb49JkCb+TQz9exx3hf5fNZb3kP86w2z33zlM7Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQ3wMS6T0pfisADnNRP2uPa31VU+qtbXzfiwWoygKXDQliDo35SJyyoKHXV7oyt0O
	 MJ9xlgSXX5R9dfkDq/Hq3QjbBrxJ4wGDuQVHw9dJpMpRrw1HTU+w2Xszb/xtWWf+F6
	 fREJkAQEUuSo72YJTNzVs5z4G+tv/LrHNZiVFTYVlWgRPAkYE5q3+R0zZxUx41okBf
	 tKp2e3Q8Fjsl4VEWRe7PjcpYUvp8fw8fB2yl+WEIT3OVLpIp44Xn9hnAylgvG3ahbI
	 CpOA8SD8w4FvpQ0MN+EbZC8gI7nWu8TopVaV6dMOPVQpwlrTnxvmuqr3ogvrlmy3xB
	 8IUB+8qbaS78Q==
Date: Thu, 22 May 2025 10:23:54 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: Fix test result reporting in gup_longterm
Message-ID: <0f0622f7-2630-40f4-8556-99bd479d1aff@sirena.org.uk>
References: <20250515-selftests-mm-gup-longterm-dups-v1-1-05f8f731cf63@kernel.org>
 <f924f789-5269-4046-99a4-2991f9a3ab3c@redhat.com>
 <aCcvxaFc6DE_Mhr1@finisterre.sirena.org.uk>
 <58dbef73-6e37-46de-9092-365456306b27@redhat.com>
 <aCc5E-wB4nBwrKEP@finisterre.sirena.org.uk>
 <46d151d7-c04b-4538-9725-dc4f46ac8ac1@redhat.com>
 <aCd-8kEyDm2f2w0z@finisterre.sirena.org.uk>
 <8131ce62-0cee-455f-9eeb-e2bbed244402@redhat.com>
 <e7cb18c4-fed3-4fa5-bb51-228f2b018ce9@sirena.org.uk>
 <f6cf8a99-48b0-46f7-b11b-574d1544fa24@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1STrL/W39KMKSBxv"
Content-Disposition: inline
In-Reply-To: <f6cf8a99-48b0-46f7-b11b-574d1544fa24@redhat.com>
X-Cookie: Beware of dog.


--1STrL/W39KMKSBxv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 10:42:50AM +0200, David Hildenbrand wrote:

> Probably, one might be able to revert the logic: instead of running each
> test for each size, run each size for each test: then, the tests are fixed
> and would be covering all available sizes in a single logical test.

Yeah, that should work - it'd lose a bit of resolution in the test
results for automation but I'm not sure how often that's likely to be
relevant and the information would still be there for humans. =20

> I agree that that really is a bigger rework. Let me take a look at your
> original patch later (fairly busy today, please poke me if I forget).

Thanks.  I'll take a look at the other similar tests like cow using the
same approach I've used here.

--1STrL/W39KMKSBxv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgu7SkACgkQJNaLcl1U
h9ASlQf/cRLMEkBxUlfbfTgzQ+8TLtGOObYAhPQyrMYAQOdor65OEzy35eYR94iV
d5T1hf0KzpFeZ9eGyZlpIJx7SeUWlAHsj486xpc+kDhmj0HOBrw9aPjseaOuVmNp
bfnzh8jpNOBpQ95Y/7oXvC8iQTjbB452hrUtF0UMdV7dYzYdEumg/zMAKZZdlDi7
TTOEDfdMqcRQUDlhHVLnPcBNydzGsZbAmaJofT8+L20pRPrDuVthuPM67/XFDN4P
HVbDn+2PGwz189ms892GBoaYc9Bq5eJKiqNTGzywL62AZMfCIVESFndjfzrAxK0l
yhWcd/A+J45cI+ASY+FlwqRB5qXJpw==
=Wtd4
-----END PGP SIGNATURE-----

--1STrL/W39KMKSBxv--

