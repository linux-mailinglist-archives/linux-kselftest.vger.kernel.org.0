Return-Path: <linux-kselftest+bounces-37414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A159B07395
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 12:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B61147ADC6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7156123FC42;
	Wed, 16 Jul 2025 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzhtJfg0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499051953BB;
	Wed, 16 Jul 2025 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662228; cv=none; b=Zky03lHNPPMMOr96PV8gsUaTxmYvCzR/0wx2uftSlsg28CQ61PUh8723Tq/p3jdY4vVg2966THAMJ4+ygVTdI6swyEaR30Rs2kN2iFNhWj8+ZhxpoG6E14ur8RttfzWET2UX/JrZJnQlubhg9Z75x5VXeUXvm9eUC9vvtDnBxGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662228; c=relaxed/simple;
	bh=j8kv5dfLRfwnaSS0W2qeEJ+Bh2ETTIYU9oxV9ZBlXjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBTrLjJlWlnRARGqPZoHotJxCeM57EZk6hTYr5EJABXnXUfZQ6cYJLlGMj5NNcAIyjkYrdv6GzJTP7rA5uvjh4eLJym/HJGEQRG95A7EMlreQ0pk2xsVKE+iMMAdMTMD8NKuBiPW37LuH/7YlX3MTnAOqcF9lxRgDYr3EGQEduU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzhtJfg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C7DC4CEF1;
	Wed, 16 Jul 2025 10:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752662228;
	bh=j8kv5dfLRfwnaSS0W2qeEJ+Bh2ETTIYU9oxV9ZBlXjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzhtJfg0CmGUiIWofiXXu/5QgT+f/nYyONOSNO1X0ZK7XeQiTNBxxOJ+oalSp/gtX
	 xEP6GO8GyCF+EYhBvive4tkJSwqSqLsUxB2yTl+oRhtybtKZkSu4wekrmtwZpaZVD8
	 M8JQoSRD42Z//5lsUfqTS+trx99mUhnl48zr2F1C77LguPJu9rqqcY9LWfin9TWyRm
	 FxHQgp9/2jIa0tvjDRFDm+Wg1cUGhEsng02abmQxsl4dkaMF+9AFhAm6/gYtWyTFnH
	 5OsFfkNxSG3EmIOt7wboOgvpM3ROM/mMRkLaJewPHYvTcdJlfLboIobj5VMKQ91S80
	 oZ4bXwkfum7zA==
Date: Wed, 16 Jul 2025 11:37:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm4: Provide local defines for AT_HWCAP3
Message-ID: <d8755ea7-cbec-4669-b3cb-2652d5e1fbd0@sirena.org.uk>
References: <20250715-arm64-selftest-bodge-hwcap3-v1-1-541b54bc43bb@kernel.org>
 <a717d6ee-3b24-47de-a1fc-90a4ad0a020d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5kCLaUznQgiWpTag"
Content-Disposition: inline
In-Reply-To: <a717d6ee-3b24-47de-a1fc-90a4ad0a020d@arm.com>
X-Cookie: osteopornosis:


--5kCLaUznQgiWpTag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 16, 2025 at 08:04:54AM +0530, Anshuman Khandual wrote:
> On 16/07/25 2:41 AM, Mark Brown wrote:

> >  #define TESTS_PER_HWCAP 3

> > +#ifndef AT_HWCAP3
> > +#define AT_HWCAP3 29

> Just wondering - would it be better to add a comment that this is a
> temporary construct till libc headers pick up AT_HWCAP3 definitions.

Possibly?  We tend to be against comments for this stuff in the tests
though.  We don't 100% need people's libcs updating, if we can work out
how to get the kernel header picked up in favour of the libc one
robustly that'd be fine too.

--5kCLaUznQgiWpTag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh3gM8ACgkQJNaLcl1U
h9BdhQf/fXXinBuS1YPKnswjW+xhZEzJ4w71pBnxGflHRm2ENLBmsYG+8cavaq2V
+xjYo6AtBUlYxXMCRTTBYjzomp/8fdoorOgUL+U7BgqNSlByQyA4H5gwo4geWveo
jn/DE6zpOXxm3d/vsWFmL9i+61AoXr71YioCzO3PAB8+EBQ8bcCN/dNmX5e1ZF/z
Kk7EbZ3JWwbgquPPGQyo5PK69J6s/lsRwm8giklYJEnZ9CRh4KbLU+Fd6zhy/dlA
JneKgR66XIzLlo0WMr8z6R2yROHE/aQCNi02L+uCyGMES5So6n8+n0osoAFBlqka
x7DjDbr97QU3jsw6iVfsX5YKvzY19Q==
=7P+i
-----END PGP SIGNATURE-----

--5kCLaUznQgiWpTag--

