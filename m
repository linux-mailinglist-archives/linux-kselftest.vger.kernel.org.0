Return-Path: <linux-kselftest+bounces-41318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14603B54AC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 13:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6160A1CC851A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 11:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D5D2FF650;
	Fri, 12 Sep 2025 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy9CElOx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B2296BBC;
	Fri, 12 Sep 2025 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675647; cv=none; b=K/nNAapW0TrfdIBt3e9+TNUR27fvvA2eAYIoIbTd5Uf2TuxjgP2+GIaGl8pKhNQbTi2Vt5Cqqp//JIrSShwL02FgJG50l2CbxFKDCycP1mgIsOq54eV0DLLgUKAgr8OB42e5xBQt4XHWDMNFxo9RBoBrmZfOX6f464aCQg0VFdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675647; c=relaxed/simple;
	bh=mnsWNx9b9n/nFBpo4K7P536SZp3NTa4jUVY67kWtsXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8I/Ca8uPBURRY4NtMvZynEFgaW3xEo5vnZSKtsir2DASoOexH8PHWqvFyXOfC8PdSupTzYvev88TZx+vC9VJloxGo59AjXUZZNtzsoC2PXWYhnKs+yAJzhPbs7t5J1M0scGpgPQfj4E/VOeHLmxGNTykWvNsF0xdsiU3Ejutks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy9CElOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CCDC4CEF4;
	Fri, 12 Sep 2025 11:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757675646;
	bh=mnsWNx9b9n/nFBpo4K7P536SZp3NTa4jUVY67kWtsXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qy9CElOxO7TKTSvHZ+WBt2DYiefJEdBhwLqBjp5ZF4QHckz28dQ0t4E56EA8rcz3m
	 UhmaQYDN3QC63ASHmgBo6Lu9O6n2cSlGECU/f+Pwo894bDj7YE9cde7rpCa1rIctAo
	 Yw8ue56cJfaO9YHTU433AhnPWi1Gfrj/ySngq2SSNxBkiR26dkRigCnGT5C+DAS3gW
	 wdK9jgBLtaCK7dwAMTUuV5Pwi7YQ9dLB1pza0PXZzWx0l0UqRhgF4mtWUIPFSOVYxK
	 h87CeO9JLtuPr3Q3bP2txiqNerPZMTdThnazqfKaCcYmdl7LnAOabIO1IOyWnjFyJQ
	 Znjd585heQb8Q==
Date: Fri, 12 Sep 2025 12:14:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: next-20250909: selftests/arm64/gcs/basic-gcs.c:390:30: error:
 use of undeclared identifier 'HWCAP_GCS'
Message-ID: <a1dc9839-ab45-4dd6-9eeb-4bbc35bf8d90@sirena.org.uk>
References: <CA+G9fYv77X+kKz2YT6xw7=9UrrotTbQ6fgNac7oohOg8BgGvtw@mail.gmail.com>
 <1e331ebb-3315-4cbe-b194-ccbeeaded4da@t-8ch.de>
 <965c8d7e-c5f2-4bd8-ab7c-c3116632f015@sirena.org.uk>
 <5e4d9943-3a8d-4281-9007-f49bfc66dc6d@weissschuh.net>
 <b9b8b8cf-4920-4f9d-bcea-bea913058601@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1bnwqmLN9TK6wYkC"
Content-Disposition: inline
In-Reply-To: <b9b8b8cf-4920-4f9d-bcea-bea913058601@weissschuh.net>
X-Cookie: Your domestic life may be harmonious.


--1bnwqmLN9TK6wYkC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 01:07:58PM +0200, Thomas Wei=DFschuh wrote:

> The Makefile does *not* use -nostdinc, so the nolibc program probably fin=
ds the toolchain's glibc asm/hwcap.h.
> There also doesn't seem to be a static arm64 hwcap header in tools/includ=
e in the first place.
> I am still wondering how this works for the other tests.

make headers_install puts a copy in usr/include, probably we just need
to include that in the include path.

--1bnwqmLN9TK6wYkC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjEAHcACgkQJNaLcl1U
h9A1rAf9HVWRdnBd20hpputtVK81rxY+MZvY1yVTmrP8LNTIseS2cf8IdsA7k/z0
sJSWK/bj7P6ydPFBgpMkE0x4Ac1IMCL4uRUQIuPTPmmP3zf3/8XYzE+p5l4X/DAK
QxNUxjQAwe0RUTBwTqv+IlnjLJSsEdkSaQLkb2a/cYUobJ2zOiiIHEsuAtrwNc5J
hBM9bg+j2rTyUClmOODnnf1X60optmElY4qPpY/bvvJJjYR+vm5uMKe2rIjtuUOS
pEtsNvC+x9uQQJJEZAq7zE3mQhDxBNOuCxIt8aPJBBLUOMXyAC/ncXip2xz0pYzS
wkuXsLfyepD2oajCOYpck05zbisibA==
=o/dM
-----END PGP SIGNATURE-----

--1bnwqmLN9TK6wYkC--

