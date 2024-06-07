Return-Path: <linux-kselftest+bounces-11378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8859890053E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1861C22DB7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 13:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8277194158;
	Fri,  7 Jun 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO7unoDI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B119408C;
	Fri,  7 Jun 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767759; cv=none; b=E78CX80UrpVleXPGJ11ZTzJ9kACoc2L5wT4RxHcva3JRJYCSDChuBNYw+DDN1C+J3dy9CirKQrm4yeoVSvoIrnSczPtRbNcZzh69bMU5ShaAQJyYCO2qp+R3vOFbxu25wjhQCF+bdxcdjnStxMDWeZUSDkVc5APIg6euXwQch5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767759; c=relaxed/simple;
	bh=Vt6jpiH9ADYFtr0cAmgrb7rm3OgSF3b7+JR9pacgeeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=radX2HKg09AiyWcR4r3LllzPQWVnQVHd/5EbqUN1X2OS26qCToRf64rWysTvb17s1GRgMe9wQ9fIPX3eJdrjGG5lLGYjIwh4TSuKlbgYyOWeyalhjlwZ/5t23g8svRAT+vxFMiZUtKzmO2eemxbUiCMZ6z6bv2HWZtG1d9CZzig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO7unoDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AD8C2BBFC;
	Fri,  7 Jun 2024 13:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717767759;
	bh=Vt6jpiH9ADYFtr0cAmgrb7rm3OgSF3b7+JR9pacgeeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mO7unoDIpdAG0MF9YJm4mY0c2GhPhcdQYW/OtaBQJxkToajgbZkyZTkEIwOT+J1bq
	 KG4jYSVkuBRgcyo8673S9t0zSA3dCO66By7BwfXfC8msHMi7Jt1kdI2TEtLY634uxk
	 zMOxGjmIYFfQVAIgDW1+3HU+k5S2bRcdBG5LqJ+D0lE1p59B9Zvr5jYTSCgibtbwVQ
	 u/n0oNPNd6r15AzfwxKNR//aCHQko7o2AXkjVByojBlwq3irTd9hjLpBEm3Z8ox9fu
	 4eXHTFZksM8EHFEZlO/Dy1x1U7O/0g5Y6ybxrk5bgtzq5oR9hsZRPDxAiwZdjvItDv
	 U36fgb5pkgo0Q==
Date: Fri, 7 Jun 2024 14:42:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, oleg@redhat.com, stsp2@yandex.ru, mingo@kernel.org,
	tglx@linutronix.de, mark.rutland@arm.com, ryan.roberts@arm.com,
	suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com, AneeshKumar.KizhakeVeetil@arm.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: Add a test mangling with uc_sigmask
Message-ID: <ZmMOOOEg06SWQ05m@finisterre.sirena.org.uk>
References: <20240607122319.768640-1-dev.jain@arm.com>
 <20240607122319.768640-3-dev.jain@arm.com>
 <ZmMHNZcYfNMW1Ft7@finisterre.sirena.org.uk>
 <5d26ac17-a50a-46c4-8fcb-68eaa6d0ce2a@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KdpYJiuDislmVCvA"
Content-Disposition: inline
In-Reply-To: <5d26ac17-a50a-46c4-8fcb-68eaa6d0ce2a@arm.com>
X-Cookie: Your love life will be... interesting.


--KdpYJiuDislmVCvA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2024 at 06:53:27PM +0530, Dev Jain wrote:
> On 6/7/24 18:42, Mark Brown wrote:
> > On Fri, Jun 07, 2024 at 05:53:19PM +0530, Dev Jain wrote:

> > > + * Test describing a clear distinction between signal states - delivered and
> > > + * blocked, and their relation with ucontext.

> > This would be clearer if it said more positiviely what the relationship
> > between these things is actually expected to be and how they're tested.
> > Right now it's a bit hard to tell what the test is actually verifying.

> I thought I had described that quite well in the code comments.

> Anyways, I shall incorporate some detail into the initial test
> description too.

If the overview is confusing and people have to read the code to figure
out what it means then that's an issue...

--KdpYJiuDislmVCvA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZjDjcACgkQJNaLcl1U
h9AImgf/a1wxtfKdUfwR7J0Cwo6VJYBSYn+dtTzBjhLAThbVpCClJm+TL11ij1vh
u+eV3XGaXWT81O+QtY3PVYKokM1UcGaX8+HTFPQbqSehpgxlpHMIUuoTVn8LS/ZS
dewUr3B+ed2nGSkDoNwvQMKRMEH7LfPPtbD4Svn/9rvC2yjwbzbp7prDoUZ+OdT2
yFU8gJy8bmjsodYkDi48SZrvZ3biLot1Oc5QCcM6GDra6d/v1RuS6JpIAhtgx0pF
yZ0tXur+Dce2hDmgDC9jx+7q230dxSlkHhaXZmhTizs6flsUsB2p2GquOba4y2u4
DZMSvwueWkHWDskke9iE08/547j3Bw==
=cJgK
-----END PGP SIGNATURE-----

--KdpYJiuDislmVCvA--

