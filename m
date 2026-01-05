Return-Path: <linux-kselftest+bounces-48203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9ADCF37E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 13:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A7AF300384D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 12:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D303358BF;
	Mon,  5 Jan 2026 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoiCfFp/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D472286408;
	Mon,  5 Jan 2026 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615328; cv=none; b=JM01hh5qGZq2V3q43YRvSWi9xyj4lUTmrsIvHM74l0KcN7lzoLcxyebOPIpEKeF5otghm2mFOXgWvJJpQlJ9yyEhHwlTKRwJE4X4MeFI3m+2M+hkIEbUg5kTcD5Pw45SOZfSpIVC9pKNfZT18vqe7i0Ei2jTY//bOsUbUfeiQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615328; c=relaxed/simple;
	bh=g7riX2VqIGy0ZpqnkS1w4HiY4vb+qABQS3L7IQZHGDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWT7+gWtZh5U9piNfkol6FEObWieQhptxtNRGFTesHXRAILEsJhLxCIOvIy9bhxtqsi4ygyjadw6X48lZXbSrKYdvXQtnQjnL8lU/TytGrGVmqTgeBi6HkXh5hBIXZqN9ZtI/KZdOpMJtWQH6K42V9FUlR4MtTQj0CsEtddzIA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoiCfFp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C1DC116D0;
	Mon,  5 Jan 2026 12:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767615327;
	bh=g7riX2VqIGy0ZpqnkS1w4HiY4vb+qABQS3L7IQZHGDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XoiCfFp/wSyuhaeas9riVl/kkZRVQlQo3wXXez3u1chk5kYSGHx3E9eHqm3gR6THG
	 hCMtU9LSDWhYB6/qVn99rx5gh5QMPIfK2CO7LayXgpbxTtOHRv17o8uiyZ7mED2F2Y
	 Q1+gtk/oTdSZiAa3ZPbAtP9egWoBJiqA+F2Ga0lSrSZSlEDnfuEkTWWVlgGOcEiznQ
	 n9D56FOxJP4oC/a596C1rKKD0xvP9QipYzPT8/c7NdcdFjRsSZVxhWCW6MwST14ByT
	 dAcDgdLqdrmhAXk2u5fdHFxuGY9KO0Fh15Y+leLFBQd/RYLnDI6NmQzCAkgydnE59j
	 rG9WuuQkWHk6Q==
Date: Mon, 5 Jan 2026 12:15:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Ben Horgan <ben.horgan@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] KVM: selftests: arm64: Make set_id_regs bitfield
 validatity checks non-fatal
Message-ID: <0056f0ca-7f9a-4eb4-a16b-b1ba3eb21832@sirena.org.uk>
References: <20251219-kvm-arm64-set-id-regs-aarch64-v3-0-bfa474ec3218@kernel.org>
 <20251219-kvm-arm64-set-id-regs-aarch64-v3-3-bfa474ec3218@kernel.org>
 <89fd9661-731c-4335-bee8-575a7c221390@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BIDSB1JZrnBn413u"
Content-Disposition: inline
In-Reply-To: <89fd9661-731c-4335-bee8-575a7c221390@arm.com>
X-Cookie: So many women


--BIDSB1JZrnBn413u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 02, 2026 at 02:45:04PM +0000, Ben Horgan wrote:
> On 12/19/25 19:28, Mark Brown wrote:
> > Currently when set_id_regs encounters a problem checking validation of
> > writes to feature registers it uses an immediately fatal assert to report
> > the problem. This is not idiomatic for kselftest, and it is also not great

> This one also looks good to me. I'm not aware of why the asserts have
> been favoured previously though.

The older KVM selftests and the KVM specific selftest framework don't
work with the kselftest framework inside the test programs and instead
just run a single test within each test program and die immediately if
there's some issue.  This is fine so long as each test only does one
thing but falls apart when you've got multiple tests in a single program
like this one, there the kselftest framework helps a lot.  It looks like
the program is mixing the two idioms.

--BIDSB1JZrnBn413u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlbq1kACgkQJNaLcl1U
h9CXRAf+NbYdUS/FF1ZammJpdArzKQFlNAuZaEcgy42dYSaeojFbLNsK2xVPCyab
M8zhG1bcCF49wHDCiSMgW5HX7fL7uc6HTwlj1EQIi2QUFor+7s6LCeMv1C7sKNUF
LlB/2sNtkI2Z1cRTbR73JvDg6MnNTrDakb6C4FV2J/Wc/7yB34GOHjoDY9GXWnS4
93F6bRFd4QDUTuOR0t812tWsTzHOkOq3M6OiwcYHUUi8aFliUcPhzXvXV51LPEi9
+htiID3s/XHU7QamnYRmq1dgIXssqtXaqm6v5iaw3gDNfQtM6MDHIhB1R9H3vTBM
VXLb/mySruiIfLCoWSe0ccqhEUWKlQ==
=OyR8
-----END PGP SIGNATURE-----

--BIDSB1JZrnBn413u--

