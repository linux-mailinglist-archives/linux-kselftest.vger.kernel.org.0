Return-Path: <linux-kselftest+bounces-48204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53600CF3ED5
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 14:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 993A4305D9AD
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 13:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F753451B3;
	Mon,  5 Jan 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk1GyY8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC6C3446D8;
	Mon,  5 Jan 2026 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617169; cv=none; b=KlcQ4fKMXRFdnQktWEQMudxC7AMELqc1/vyC7LUV0dhwhoT7Xn1L2OGDtYM2vUJaB2kBLtJmO18nvhyIlyEHR3KgXKQFaUUn/4zuCJ/pUq2cTuk5tGi1UHn4Tu4qNbZEUaExa/jl5RX2yvytFMmYyyZ3UeeaXERKI51WlSlA2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617169; c=relaxed/simple;
	bh=ql8wdMN032MrP8xavsv4jPuanq1kV6VysEAcsIRbjMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnvJ67x1rvBXx1tKwGQLSf+kXXBGuSyFo+fjTMOcE1Y/u56nBUYp4lw8t/W8TvS7FgQJkvkEv7cpMbID3Aw+dtjcrBzhfzThmN4P+wW8t1MoA7uwDO6Tv1+YjLhFqfPEoSxr1HLAR5l96EzcdysLP9i05H99T/HlYAXjqbgsgoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk1GyY8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A40C116D0;
	Mon,  5 Jan 2026 12:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767617168;
	bh=ql8wdMN032MrP8xavsv4jPuanq1kV6VysEAcsIRbjMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hk1GyY8poIzMwUg1Iu63Ub8SWVmdLS4TEm6OBkbOuil30njeic/+PyYniw19FvcfQ
	 akkAIC2dCBZpjG7mL+5tlswp55YzpRjO/r2CQ2P2icCNfqjFIC/Axp/X+aI/Gzqy4t
	 7DYXjBx4oQ4EWotSOuDKT6K/tdQ9CrmP4u6yeWgATKXWwyeKV/6HP+XIQFZP3kR2VX
	 NoBcM97/reHliukWwJASK0Ivj7chaFY7MJki7jZWxQDQRiZY4fna4e4eISENd0VNRE
	 ekfQvWw42zotZy6AniyKMrvCJuYsZOv9Hips04+ePO1QHQaYiSpIQx9Ygjpu4qQ03n
	 XuW6wtoAVoZdg==
Date: Mon, 5 Jan 2026 12:46:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH 1/4] selftests/mm: remove flaky header check
Message-ID: <2bc4e09a-045a-4d33-8857-1bdfe3281da2@sirena.org.uk>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
 <20251216142633.2401447-2-kevin.brodsky@arm.com>
 <5f866c1a-c8cd-4dc6-b312-9017cef89920@sirena.org.uk>
 <e971e44e-5539-4fc4-8128-0ce9c3d10a38@arm.com>
 <682f64d0-353c-47bb-808b-eacc2d4d6c00@sirena.org.uk>
 <9c97ac9c-b0df-42e7-84fc-7e0d986c7324@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ee3kU50VQDofGf6W"
Content-Disposition: inline
In-Reply-To: <9c97ac9c-b0df-42e7-84fc-7e0d986c7324@arm.com>
X-Cookie: So many women


--ee3kU50VQDofGf6W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 29, 2025 at 04:40:26PM +0100, Kevin Brodsky wrote:
> On 18/12/2025 15:25, Mark Brown wrote:

> > Well, there's also the selection of KDIR which for some reason defaults
> > to the installed kernel so we get:

> Overall the kselftests tend to assume that we're building on the same
> machine we'll run them, so at least that feels consistent. The same
> default is used for most other out-of-tree kselftests modules
> (livepatch, net/bench).

That's really not the expected usage pattern, I'd be surprised if a
non-trivial propoprtion of kselftest builds were intended to be run on
the system they're built on - a lot of people test interactively in VMs,
or on some other target hardware, and automated systems are going to be
building separately.  The two you've identified look like special
snowflakes TBH (livepatch in particular has a bunch of other issues due
to what it's trying to do).

> Maybe the documentation should be updated to recommend setting KDIR
> explicitly? Or maybe it could default to KDIR=$PWD or $(abspath
> $(KBUILD_OUTPUT)) when cross-compiling?

I think defaulting to something related to the current kernel build is
more sensible here.

--ee3kU50VQDofGf6W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlbsooACgkQJNaLcl1U
h9AHxQf/Z8Nc97ZwGUewBQVLOCUmYjLOtU4B6nWHPdZgpoANTtvhZOi/lqyJS7gV
WLscnoEUA266crkqIWb3oIoWkNERtD19h+s5H+IXm4Nz1V22lG6R5PDblt8YegSJ
lFYuGvGeeBKESvTsg7PQDpjmLaV75LorK6X3t8GSjrEXtPKTJKIBxXfefrDHfDWh
ZWCTb/j1DMDdBZ/hRcRYPtiti8f0mcsIDB0KfJ2RYP/9VpcaVMgnGSVA+8lYjOZZ
flWs7KSCcOoMG8qZcqKmICyAewMgEvgjq4JTQkwJ8nnTHysXHnK558HZ01lydGFK
lrN4yLX5KhvW7HkLN1/hjP0ihXbSkA==
=jLkm
-----END PGP SIGNATURE-----

--ee3kU50VQDofGf6W--

