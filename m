Return-Path: <linux-kselftest+bounces-29566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04889A6BEBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 16:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC8F173A55
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965061F12F8;
	Fri, 21 Mar 2025 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3WqwVYP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696FF1E98ED;
	Fri, 21 Mar 2025 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572289; cv=none; b=azycLCNJLa8WxOhi96KwDh8aFtYdG+Ov56KVV/RuXHEZ4m2g9Y2Xy7m4ph8Pchg1muTFTR649nJBmDIJiQwFZ1jOQmO1rg/mMPETjR7NCCZEFR99syrPmcyE4CI/KUFI5E7KrNTGOC+KsHg+NbEHdwGjysUaigVuRr7iGWNCyWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572289; c=relaxed/simple;
	bh=7T+weLd2mgUWwCqJQTaTI73IsyO3zKdE4HInBen1i+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR8EXjtCo1Z5abBSMQVogczA+vyY6Ha++pfwPHsaZ4w+8XpSuy/Yi+pJAygBt/25MdRGkbuFGnYIknksCfLrWbc5Em0wda3K9fY192nOktQrOQidj1Q3yjVHmt7sitB96kFB8doGdlp5wSY6dFhpzqnOhEyTJx2zJkq/p4HSfvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3WqwVYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88050C4CEEA;
	Fri, 21 Mar 2025 15:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742572288;
	bh=7T+weLd2mgUWwCqJQTaTI73IsyO3zKdE4HInBen1i+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3WqwVYPjdOAoqljEnokpk+GiukFjIe57k4dI04EJumvr6JeCUtyB1X8Zly+WJSmg
	 bWM0hhDL1aywwL896SgthkMh6II1rsabVveTKP+7LwgMFopKc8Gg3bto8w76TluwdZ
	 bYY5qSuz2LW64PB7elpttf/zEDROu9xR+AdGSB3pIiJB77mKwOsjNLRzaX9YcrKsZA
	 PLpQKeVWxQ0wn6p4KDEAbsUntI4U2556dOeosdA9vU95yjcXfmp0hldo3wND5IL2Rf
	 dQRonQ01AvKX2Sk9aJsQjhJWQOEMH+seTb7JPbXKgNlDL381PeY8Ss4Rl5KRDVN+Mo
	 G83c95aZtQGJA==
Date: Fri, 21 Mar 2025 15:51:25 +0000
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
Message-ID: <Z92K_azA7A7RoQ0T@finisterre.sirena.org.uk>
References: <20250319230539.140869-1-npache@redhat.com>
 <618b8578-1897-45e4-83eb-b725102ab27d@sirena.org.uk>
 <CAA1CXcD4dOUWOXp0ODSEo4+g9_QQkJe1tmX3bVdcs3N_PPdSHQ@mail.gmail.com>
 <a0fdd818-a4be-446e-b18e-0c655bc94c9a@sirena.org.uk>
 <CAA1CXcDPg7Na9biCMOx4i_xwXZ5Y_qq-7SiYEU82v2a6TFpMJA@mail.gmail.com>
 <Z918-4psPV3j9c-d@finisterre.sirena.org.uk>
 <CAA1CXcD4GRQhUf6BZ+STdKTpvzGKTA-kVidbcGZsKabu=_y6Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q5A2uEVY7mg+0cj5"
Content-Disposition: inline
In-Reply-To: <CAA1CXcD4GRQhUf6BZ+STdKTpvzGKTA-kVidbcGZsKabu=_y6Sw@mail.gmail.com>
X-Cookie: Well begun is half done.


--q5A2uEVY7mg+0cj5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 09:01:35AM -0600, Nico Pache wrote:
> On Fri, Mar 21, 2025 at 8:51=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:

> > That user select should only be visible if KUnit is enabled though,
> > it really is library code so shouldn't actually be user selectable.  I'm
> > not sure if there's some other strategy other KUnit tests for libraries
> > use.

> I'm a little confused how the FW_CS_DSP config which was added in
> v5.16 is reliant (library code that is only used by KUNIT) on a config
> that was added in v6.14. Presumably the library is not just for the
> KUNIT test. What was the purpose of this config before the
> introduction of the KUNIT test. Im guessing it was not user selectable
> back then too.

This is support code for DSPs that Cirrus have in some of their devices,
the drivers for devices that have these DSPs select it - a git grep will
show the selects.

--q5A2uEVY7mg+0cj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfdivoACgkQJNaLcl1U
h9A4lQf/fjT3TzI4n4lut6GR4oZC2wn4Jk3pzsQnkRRLLgISJT41Xq4m7pahjqFq
+BTmiQtrm8wOjR5AtnebpkavOjbxJcGGKQHCTvh/VRDKTgURv8WgUrbPyF5fztc2
jYaNQ3EpPp0jJi7TJ0qWnFrZ6xX2rcMe2zPAmxxnJEZSb9s6fJZ+GR8KGM2wsN6Q
vay/IMNhIPzO61+vImdkXzwEvBTit2qHNFl3DQYrPgE1Uxe54uVm6hJI2upTV8rE
qtYoLKRgeXdaCnsBEjUU0tA3H0LNzdyIg/1ok34o0BGKSWBwNBiePIqDA3UFwVMm
yT89QhnGXul4K0TZw29RpwWO7C3EKQ==
=ZQbP
-----END PGP SIGNATURE-----

--q5A2uEVY7mg+0cj5--

