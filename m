Return-Path: <linux-kselftest+bounces-29564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6932A6BD9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 15:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8C9160567
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1011D54D1;
	Fri, 21 Mar 2025 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrkoEdc5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605E3154426;
	Fri, 21 Mar 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568703; cv=none; b=cCO18ga1Hw5DKIT/P9F6B9R4m4yMUCpeBCZdzOrlpylQUusTzjSCt76rfdE5uralL17ZljMwlR5yfQ4XRzukg+HV/5JMLmWbWiypwErF0da/e9kKEQ5SoeaylJum6sldYrNd0MdU2iNAscjy6+4/h8PEyFuWWtOCLap6EeGw0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568703; c=relaxed/simple;
	bh=PhuVuMchyJ3HJTMtCg1H6MJB1Gn7Kg0keWLQLs0iu9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2T9o/AnHtyu+UvNvirJU0HFAjSLxfxEoKu75CsQgjaHqc//ie5HHsnT9DNXj0u/TBBa+hZBnTkdnVSy343BFKP2NcXkr08oD2dp8bMhPcrRgwXdpoelvL2pPWm2zFJh5Ca76Bwq39R8hC7wRhx0lYPv8Q5yJs1pBh5O3BWvQjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrkoEdc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45722C4CEE3;
	Fri, 21 Mar 2025 14:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742568702;
	bh=PhuVuMchyJ3HJTMtCg1H6MJB1Gn7Kg0keWLQLs0iu9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrkoEdc5u2lqcHeV05xrtf40mrquBkRW9n/fzn4LZGdFNHSQ8gmOE0cie+9+qOZFb
	 px/pwhq+h+SQuXUmMJkVUCfO9IXqdLBiSFMCyLg2brK2YdcJF3xKsh3cuFV9IzbMw6
	 8NNvCtAdpWvucPoPz/2RenkeGryO/Arw460MehktKmJkdDngHzGVo0InxYOfMvGg3A
	 +ouSKWParfQld/grByeo1gPBIIuO9DUs9ztvOJGhP6jo4R/zNW5Iklk4De5J5JQ6kf
	 cdZD2b15GbiVlW7px4k7YJ8fsNcQZ+jrFqmB1YX3ydldNZU3SncODZCXCp8WYzU/IT
	 Gscc5KYbfqdbQ==
Date: Fri, 21 Mar 2025 14:51:39 +0000
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
Message-ID: <Z918-4psPV3j9c-d@finisterre.sirena.org.uk>
References: <20250319230539.140869-1-npache@redhat.com>
 <618b8578-1897-45e4-83eb-b725102ab27d@sirena.org.uk>
 <CAA1CXcD4dOUWOXp0ODSEo4+g9_QQkJe1tmX3bVdcs3N_PPdSHQ@mail.gmail.com>
 <a0fdd818-a4be-446e-b18e-0c655bc94c9a@sirena.org.uk>
 <CAA1CXcDPg7Na9biCMOx4i_xwXZ5Y_qq-7SiYEU82v2a6TFpMJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="44Vt4as3XnXLhDhy"
Content-Disposition: inline
In-Reply-To: <CAA1CXcDPg7Na9biCMOx4i_xwXZ5Y_qq-7SiYEU82v2a6TFpMJA@mail.gmail.com>
X-Cookie: Well begun is half done.


--44Vt4as3XnXLhDhy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 05:37:50AM -0600, Nico Pache wrote:
> On Thu, Mar 20, 2025 at 4:49=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > Simply adding it to the all_tests.config will just result in it getting
> > turned off by Kconfig during the build since it's not a visible option
> > so that's not accomplishing anything.  all_tests.config is not UML
> > specific, it's for enabling all the KUnit tests that could run in UML no
> > matter how you're running them.

> So would the correct approach be allowing users to select FW_CS_DSP,
> then apply these changes?

That user select should only be visible if KUnit is enabled though,
it really is library code so shouldn't actually be user selectable.  I'm
not sure if there's some other strategy other KUnit tests for libraries
use.

> It also looks like FW_CS_DSP_KUNIT_TEST_UTILS and FW_CS_DSP_KUNIT_TEST
> are redundant.

Possibly there's more tests to come that'll use them?

--44Vt4as3XnXLhDhy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfdfPoACgkQJNaLcl1U
h9D9wwgAggSj6DC9vV8bIsmlbXcAIQQ+ae2h9tlW7pLq+3MPqtKUcsHOpNZp0cfR
EyOVUIOnhovRvqBu/q4PEfqdlNBArIlOZT9rI8YsJspAviayPPSw+XCRtPucpU4/
11mzcrDAg4LxhIUg2Gj/Pj0iuUDfEHgH4kuNUM0gX/SJzvQfEYxYrwSWylh1907X
gNq3d1S/4H0FQ8Im81I5bPlhkgLRFcYNNtSTFFHnKE+rmvLT8wn1+ryUlNFwYtSX
scihIsl9KMz8lWEhuLXM84YD9FUc9vYjZy4Wa7qZYEo0XOqlZslZiBU7G8CQ8S38
gCJYp7V0if04dtb5Vh6EmGH0G06A1Q==
=EvbZ
-----END PGP SIGNATURE-----

--44Vt4as3XnXLhDhy--

