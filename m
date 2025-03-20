Return-Path: <linux-kselftest+bounces-29533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ACFA6B13A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 23:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BAC5188DCE4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 22:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8237221B9D5;
	Thu, 20 Mar 2025 22:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaRfZqOV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599AD1B4138;
	Thu, 20 Mar 2025 22:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510942; cv=none; b=VuelaXZM5qT0xfm3SQ1RLuf7k3lKmf8d7FoRMaLYgpXpgZrxMKimgcLyETw/85DOZdApTCwuSM4sS5PzD1TaRaLBqVPOsIov0oqki7ejHaEnkZy/vFHnekVF1ze0U9ViPldR1ASGoaeidLNVBU8OuHB8xSw3n7xdg/g8SFDx0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510942; c=relaxed/simple;
	bh=mOksHU5qf4Adi6HtLZv4BnIl+JJRYljJuuqvM4c8BAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kep1sX0sPmmGmj0FMe/Ey7FQUfniINLrQ1YI05BAvcNolpcSBoQeKr6P69KUbd/dRfrn1BDRY9c0SujzpSizd7yTD+SOhpqGS6udjGPuV4B6urXaOLg8dToNi+1eE63W8zBIv96hMCLkW92D6sd4iJOYuUWhDCg7PDFWrCVEoWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaRfZqOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3512DC4CEDD;
	Thu, 20 Mar 2025 22:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742510941;
	bh=mOksHU5qf4Adi6HtLZv4BnIl+JJRYljJuuqvM4c8BAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JaRfZqOVIR58sZKmuHYI6UKg+1VjaCB3F5GOWLViBwLMRFhwdjZRXlAbugCN0hbmV
	 ENvtEUrHQ07Kj3fcCeu1euZ1RpHDl0+ZNJVpdOAwTyH2EKGHsKwVWRq7knxU1iLY8T
	 VfjOGPHsAjJtwHKEoa34Til1iETexXzYOF7tfDd/FMaRFH+xLEn2t4oBEd2KnjDwst
	 XK2sCJV+lkKuZ13h0hf4IgD2YL2LwZzIe9rSidPFGpCa5kH114rpE992D+VkA1+q+j
	 AamZaDHsyGCwhCHNYg2xo6jtUJCagR8KRByOG5OjLYq1BK9gGoGbKyHc55dhfP3RFS
	 SxhCUvvsQEGxQ==
Date: Thu, 20 Mar 2025 22:48:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: rf@opensource.cirrus.com, patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, simont@opensource.cirrus.com,
	ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev,
	davidgow@google.com, rmoar@google.com, johannes.berg@intel.com,
	sj@kernel.org
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling
 it
Message-ID: <a0fdd818-a4be-446e-b18e-0c655bc94c9a@sirena.org.uk>
References: <20250319230539.140869-1-npache@redhat.com>
 <618b8578-1897-45e4-83eb-b725102ab27d@sirena.org.uk>
 <CAA1CXcD4dOUWOXp0ODSEo4+g9_QQkJe1tmX3bVdcs3N_PPdSHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lvX71JSmq6TgqUlb"
Content-Disposition: inline
In-Reply-To: <CAA1CXcD4dOUWOXp0ODSEo4+g9_QQkJe1tmX3bVdcs3N_PPdSHQ@mail.gmail.com>
X-Cookie: Do not fold, spindle or mutilate.


--lvX71JSmq6TgqUlb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 04:21:16PM -0600, Nico Pache wrote:
> On Thu, Mar 20, 2025 at 1:14=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> > On Wed, Mar 19, 2025 at 05:05:39PM -0600, Nico Pache wrote:

> > >  config FW_CS_DSP_KUNIT_TEST
> > >       tristate "KUnit tests for Cirrus Logic cs_dsp" if !KUNIT_ALL_TE=
STS
> > > -     depends on KUNIT && REGMAP
> > > +     depends on KUNIT && REGMAP && FW_CS_DSP
> > >       default KUNIT_ALL_TESTS
> > > -     select FW_CS_DSP

> > This makes no sense to me, the select statement is forcing on the code
> > it's testing which is a library and so is selected by it's users, this

> Similarly to eb5c79828cfa ("firmware: cs_dsp: FW_CS_DSP_KUNIT_TEST
> should not select REGMAP"), We shouldnt force a feature on when using
> KUNIT_ALL_TESTS.

This feature is not user selectable, at an absolute minimum you would
need to make the library available in KUnit test builds.

> > change will just stop the tests being run unless someone does the dance
> > to enable a driver which relies on the library.  That is something that

> My config also sets the UML wrapper to enable this FW_CS_DSP config so
> it will continue to work in that environment.

Simply adding it to the all_tests.config will just result in it getting
turned off by Kconfig during the build since it's not a visible option
so that's not accomplishing anything.  all_tests.config is not UML
specific, it's for enabling all the KUnit tests that could run in UML no
matter how you're running them.

> > seems unlikely to change the outcome of the tests when run from KUnit
> > which is independent of any hardware.

> KUNIT is supported outside the UML environment, and some distros (like
> fedora, and downstream flavors), use KUNIT as modules, with
> KUNIT_ALL_TESTS=3Dm. We only want the tests that are supported by our
> config to be available, we dont want KUNIT going and enabling other
> features so the test works.

The point is not that KUnit is frequently run in UML (personally I
mostly run it with emulated hardware instead) but rather that this is a
library which can be tested independently of having a relevant DSP.

--lvX71JSmq6TgqUlb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfcm1cACgkQJNaLcl1U
h9BSyggAgOtuJ1v1/Q/s4ZEvVO91zrjG9GfdNmdYBv9p2+e8fKXDGPhvUx6x93l6
W5EvzGvJvjPS78WG5AxHNAzpePofF+Otl18WYv1yssm5RlgBxE7U+/b/wixLAyy3
veZH6iFjT6bJPfN9iL6y7Hrg30YKsRv7/mM0Eg3utQEiT2FQFIGsOlPIwTMrXRrT
5wWfy4OZMlhWeBB39TdheXOC7q2zAQCReFaxbWR8XQpNcX+7XoF4omVkSVUf7li9
PR5SQPNGyto6USKmY8wpL5odAwqZ3BAm9xpqfZNs6TcqYQT0cV5TjI+WUuEtS1Lo
JDqkvn8GtxUccXG55P+4TPYdARuP1A==
=i1OI
-----END PGP SIGNATURE-----

--lvX71JSmq6TgqUlb--

