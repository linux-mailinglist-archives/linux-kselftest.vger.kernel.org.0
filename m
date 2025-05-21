Return-Path: <linux-kselftest+bounces-33479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A61ABFD01
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 20:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7016B8C1BDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6373A253347;
	Wed, 21 May 2025 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q19jg+60"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B81381BA;
	Wed, 21 May 2025 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747853320; cv=none; b=UzmgMD6meHSeDjlCQYyADJqeD61/C9X7NvUZdMGV8QNoD9doPnh/9209FLB+lBW22egzvy4c48GRiFxVf/GJBg8Jl3ExxCrfXA0ToCE6ovqjStOwTuygNkTc/o1aCP7cF/RuQfdm69skeMMT8oLxO2s2gheHHKtJZ3fLzcEwJSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747853320; c=relaxed/simple;
	bh=+SDgkPsuW8atvb4ZDN/7K6R70SeeWuKOV3C3tPVuScg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyVk1jPC8JpPK+cpRdYghzroXQzRItPqb2cwEVON0So43lY8jysjcpsc0KCgJSzEXjyPzX2ul+/VeAxY45k6oztlxgZTWZ1Vug+fd+2rkiod2Jutx3Kqk7uX3NioSbVh4KMCmdAjCOOiUy3Pt39fQy5sWSWiopsxvNOuJ5QHG8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q19jg+60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37936C4CEE4;
	Wed, 21 May 2025 18:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747853319;
	bh=+SDgkPsuW8atvb4ZDN/7K6R70SeeWuKOV3C3tPVuScg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q19jg+60JIe2Y9J1lBfDCYCNtrGdlH9RebVOzWFZ6BS2ArUz7RgOSWb2f8fKVVMBT
	 NU8d4EeJ+Tu0IueiPN0jHfVAS9oCWo/9h1Wbnfbn9oWKp59soJ8ov23lk9mUeFmfbk
	 Jc+zmdE1Rc5PvCjQKWUJYbElEUgXtmuQsV8by3tepNuNlvEyg1w4mYmxmPEKhxZzvn
	 Naw5APZDe5zYIR8BJIrOkY2Goc5a5YYGCN/qu/ZIQx2kvZYR3D3NsAy6/QoH8eVWnz
	 UZkQj9hyqxTYvqvV+RZhwAAg/9Wwz9U9f5UQElQQg4o2L62gydVNE2wuDkFacDnveb
	 zJw7/K9xnvz0Q==
Date: Wed, 21 May 2025 19:48:35 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: Fix test result reporting in gup_longterm
Message-ID: <e7cb18c4-fed3-4fa5-bb51-228f2b018ce9@sirena.org.uk>
References: <20250515-selftests-mm-gup-longterm-dups-v1-1-05f8f731cf63@kernel.org>
 <f924f789-5269-4046-99a4-2991f9a3ab3c@redhat.com>
 <aCcvxaFc6DE_Mhr1@finisterre.sirena.org.uk>
 <58dbef73-6e37-46de-9092-365456306b27@redhat.com>
 <aCc5E-wB4nBwrKEP@finisterre.sirena.org.uk>
 <46d151d7-c04b-4538-9725-dc4f46ac8ac1@redhat.com>
 <aCd-8kEyDm2f2w0z@finisterre.sirena.org.uk>
 <8131ce62-0cee-455f-9eeb-e2bbed244402@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tXPModrryQ9N1T2N"
Content-Disposition: inline
In-Reply-To: <8131ce62-0cee-455f-9eeb-e2bbed244402@redhat.com>
X-Cookie: 42


--tXPModrryQ9N1T2N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 03:28:47PM +0200, David Hildenbrand wrote:
> On 16.05.25 20:07, Mark Brown wrote:
> > On Fri, May 16, 2025 at 04:12:08PM +0200, David Hildenbrand wrote:

> > [Converting to kselftet_harness]
> > > > That'd certainly work, though doing that is more surgery on the test
> > > > than I personally have the time/enthusiasm for right now.

> > > Same over here.

> > > But probably if we touch it, we should just clean it up right away. W=
ell,
> > > if we decide that that is the right cleanup. (you mention something l=
ike that
> > > in your patch description :)

> > OTOH there's something to be said for just making incremental
> > improvements in the tests where we can, they tend not to get huge
> > amounts of love in general which means perfect can very much be the

> I would agree if it would be a handful of small changes.

> But here we are already at

>  1 file changed, 107 insertions(+), 56 deletions(-)

So, I did have a brief poke at this which confirmed my instinct that
blocking a fix for this (and the other similarly structured tests like
cow) seems disproportionate. =20

The biggest issue is the configuration of fixtures, the harness really
wants the set of test variants to be fixed at compile time (see the
FIXTURE_ macros) but we're covering the dynamically discovered list of
huge page sizes.  I'm not seeing a super tasteful way to deal with that
mismatch of assumptions, the most obvious thing is to switch to having a
static list of possible huge page sizes and skipping if that size isn't
there but there's an awful lot of potential huge page sizes most of
which won't appear on any given system.  That'd be both ugly code and
bad ergonomics for anyone actively working with the test.

--tXPModrryQ9N1T2N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmguIAIACgkQJNaLcl1U
h9D0PAf8DZzGB9b1u4CO6VHCHIRfWIVJmgUByM3bLYGJLVXCi7i8dUDQlE5xS2o8
E1tEH5ivN9CMoWN2JU6yNQ8poc6LTLsRuek5yRR1Zmq6JPLi3WlO2eWeP5Qjx+rS
qBuVu8bDB9MN/wx98DOdAFiC0sjtVSyApOBzl05BuJr47OlhFW/a3y0TzWuR42Fd
OOIXBxLtN48u8Oa94q6S9u6ZX23tBvk6oaikVx+rLURUa8zl7oX5p/8ZMm1BFCwY
bgQmQK337NBiSeq7l08Wd34Ot9p7lpX5LR2swwd/hSaBKmYU6JIwl21vCixQUhOQ
CdwgC3YAnAP/HTAb9CWHTLRZJFROyg==
=qji1
-----END PGP SIGNATURE-----

--tXPModrryQ9N1T2N--

