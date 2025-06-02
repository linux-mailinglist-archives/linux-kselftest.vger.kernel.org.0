Return-Path: <linux-kselftest+bounces-34131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D739ACACA5
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 12:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28A640052C
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 10:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7C81FDA6D;
	Mon,  2 Jun 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/WtcJn6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77AB1E885A;
	Mon,  2 Jun 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860693; cv=none; b=NKq68kZ2Ezu0j/mySFH5JEWBmwaI3AXu03o46ZIR1/smHEtDgkFaOtrNQS/KAN9sLDQEfB4hQ3nyuTAjr9JJ2HgnH/iRGU+gLqqE5gHCg0sroCiUE2pRRgaw7saPFoGce6jijnvaXWZhMDUd8Dg2ygoL1SQqxKfiFUpkfrw2tCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860693; c=relaxed/simple;
	bh=wnfxgeV2+Nx8bb8Q/EudZq79LVi2eoHfCjsmRDx8fRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PouMP6PeHSfNR0r9sHx9c9o5k3HmVtqOneeVaPN3ipGvA1YnL/6uXAUbvIIknEThX0FsqqcPmuEX/tY+MFv+QU+U7fBdMCye5w0xjtLKv4l1HLiQuQ9C3GsUN9qpYv/4YaEvXHzpNLdGuJV6TG6/wHkR9kN9ZbLZm60CDhCXsGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/WtcJn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF692C4CEEB;
	Mon,  2 Jun 2025 10:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748860693;
	bh=wnfxgeV2+Nx8bb8Q/EudZq79LVi2eoHfCjsmRDx8fRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/WtcJn6ywsGgn6xG2+lnOTIOzqLVWzBK/jZm63Ts692trCCstRIoBDipEzx2s+89
	 s0sLePXX4Mj8c2C+kcD2oepiewSWsmdyDYagYGahWUd3SrLDY4SMrXMGJUfK/GlBwK
	 ZYoklQUZgJyGDFA7iczo4l4IJPKmP3gyBrQUpkw0xZc5tERioWqpzWly2jrMTAuIhO
	 g/p9Pcn5nBn+OY6yUocXzAsAFhKg4ckzcY6VoRAe9+s5XhrzQ62Cmo15enGYjZOh1u
	 se/kEsz374B1lQwbDdAOSllgcmT82oP8nx1lDZZ/AWijfHD/kwNhVHmXxncVB/4voD
	 hFjHJevCCE4SQ==
Date: Mon, 2 Jun 2025 12:38:10 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>, 
	Alessandro Carminati <acarmina@redhat.com>, linux-kselftest@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, Daniel Diaz <daniel.diaz@linaro.org>, 
	David Gow <davidgow@google.com>, Arthur Grillo <arthurgrillo@riseup.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Ville Syrjala <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>, 
	Alessandro Carminati <alessandro.carminati@gmail.com>, Jani Nikula <jani.nikula@intel.com>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Linux Kernel Functional Testing <lkft@linaro.org>, 
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning
 backtraces
Message-ID: <20250602-vegan-lumpy-marmoset-488b6a@houat>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-2-acarmina@redhat.com>
 <20250529090129.GZ24938@noisy.programming.kicks-ass.net>
 <CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com>
 <20250530140140.GE21197@noisy.programming.kicks-ass.net>
 <202505301037.D816A49@keescook>
 <20250531102304.GF21197@noisy.programming.kicks-ass.net>
 <8C5E309E-03E5-4353-8515-67A53EC6C9E3@kernel.org>
 <20250602075707.GI21197@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="gz5gnfgrkb7kaqe5"
Content-Disposition: inline
In-Reply-To: <20250602075707.GI21197@noisy.programming.kicks-ass.net>


--gz5gnfgrkb7kaqe5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning
 backtraces
MIME-Version: 1.0

On Mon, Jun 02, 2025 at 09:57:07AM +0200, Peter Zijlstra wrote:
> On Sat, May 31, 2025 at 06:51:50AM -0700, Kees Cook wrote:
>=20
> > It's not for you, then. :) I can't operate ftrace, but I use kunit
> > almost daily. Ignoring WARNs makes this much nicer, and especially for
> > CIs.
>=20
> I'm thinking you are more than capable of ignoring WARNs too. This
> leaves the CI thing.
>=20
> So all this is really about telling CIs which WARNs are to be ignored,
> and which are not? Surely the easiest way to achieve that is by
> printing more/better identifying information instead of suppressing
> things?

You might also want to test that the warn is indeed emitted, and it not
being emitted result in a test failure.

And I can see a future where we would fail a test that would trigger an
unexpected WARN.

Doing either, or none, would be pretty terrible UX for !CI users too.
How on earth would you know if the hundreds of WARN you got from the
tests output are legitimate or not, and if you introduced new ones
you're supposed to fix?

Maxime

--gz5gnfgrkb7kaqe5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaD1/DgAKCRAnX84Zoj2+
dkcNAYDRykjQZnQJ9I1TqZMMKBhdtgNAHmto7fYUijF31+RVpwfRIGYmYqqXbZcI
JEnuf2IBfjBb+xrr69rT4ryXPEMvQgSsUkPfXxPAFAbU//3Omx2Xpm1mYEUB/c4Q
6/gTVbD4cA==
=Nss+
-----END PGP SIGNATURE-----

--gz5gnfgrkb7kaqe5--

