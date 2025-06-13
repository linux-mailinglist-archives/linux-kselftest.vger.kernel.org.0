Return-Path: <linux-kselftest+bounces-34889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AD8AD89F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633FD1897A6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 11:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F412D23A5;
	Fri, 13 Jun 2025 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGhCIlUa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358082C15A5
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749812690; cv=none; b=uoKJWckPPQD4staB3XLVH0AW8y+naMVKhRHPz24Oo1UZ2QnNErZR7+RwVDSQ3bDcRP+q272ycjgqnv+buicvA0w9BhH2hD7+fNoQzm6GvZusu3A4NHxmYeRDAxvDUEnfkHRLgWFOrOQlZTxjuPkzxUM672t5EOXswi33qRR2wS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749812690; c=relaxed/simple;
	bh=fnUYXGWMp+rg6zQbPNOyMV/EBnNya0vOpq3jPnJvDb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUHhbZyL+pVLC/V68GJPGnTE6Ll9iQVRlyQ/MFQTM2F8S5aUN9VOETjAWLFGp2QiX1HdYnDDi6Rkq8pdDG7cFwPIYa5KRdU1/eftpEgzhOWcXvYAXXk+uPBWn6OhSPGsgAaaTDYslWm3tZmStgMdprDc6rTPQ1f37TjwUlhetIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGhCIlUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF501C4CEE3;
	Fri, 13 Jun 2025 11:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749812689;
	bh=fnUYXGWMp+rg6zQbPNOyMV/EBnNya0vOpq3jPnJvDb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGhCIlUaZTO3v558mkLaqNbQjwwPElg1UbSJr7RgVL1W0Ztyzrw9Q2V4hAYhgtgAo
	 ODlg/p8O/0rblABIMDt5JCq1rTvctF3shShFG7RPiSbf3k4/W2IAuTDvCcnXQu9icl
	 8UOFbdDPXPw+8C6AkGPA4kh5yj+HPxNrcLzD1C9r3YMfp+AtnGgP2dt+ELUalypkgD
	 fFKDYi+664qpWa/ZoFEryzoYH1DxBW6u+qVGYXVYkAkkJHNj4fvv8H9LxI6WzxbQLO
	 MukEIkYsU1KpcVr7WPkppWUlzxM38cxyMeI5TC788nozUgDyYaZmomc43tT/zVZ9Lu
	 Mg/4AoFW/1daQ==
Date: Fri, 13 Jun 2025 12:04:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
	vbabka@suse.cz, jannh@google.com, pulehui@huawei.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	aishwarya.tcv@arm.com, ryan.roberts@arm.com, donettom@linux.ibm.com
Subject: Re: [PATCH v2] selftests/mm: Add configs to fix testcase failure
Message-ID: <6de0297c-19b0-47a9-8479-36daae4a3c2d@sirena.org.uk>
References: <20250613034912.53791-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7pqutoTU73qMyt1j"
Content-Disposition: inline
In-Reply-To: <20250613034912.53791-1-dev.jain@arm.com>
X-Cookie: Use extra care when cleaning on stairs.


--7pqutoTU73qMyt1j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 09:19:12AM +0530, Dev Jain wrote:
> If CONFIG_UPROBES is not set, a merge subtest fails:
>=20
> Failure log:

Reviewed-by: Mark Brown <broonie@kernel.org>

--7pqutoTU73qMyt1j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhMBcsACgkQJNaLcl1U
h9CSPQf/Y1yGm1LsrqQD1C7WPvcSYPQWwvP2sSv/2wzSSav3Lv3FetKOsJHfjytD
Ag5VeGFwUMnOBZwHdLYwQB2JPmNG7pepaUJtRMf7Aer8v+Lf3S84pa7DRQa6Qm40
EGigld4arc4FAT50JkS3o/6khywcbz23yyu089+j7qqdtqE2Ex4uZq5yXc9qN/vg
VNVNzZENITT8tciptKZ1ZyFVzdr5ODmgbL93bjMZiKKveyDAvoVaVCsIXS3UN5ek
mX+yLdygLjOavP9fuklZkWwz/+WkiqUGu5dLDvyLCdeRfYsjhR0BnqqfnSASgAZ9
EqQFld/9YpdrmRfP/SMxFaTkCSyl9Q==
=WPhD
-----END PGP SIGNATURE-----

--7pqutoTU73qMyt1j--

