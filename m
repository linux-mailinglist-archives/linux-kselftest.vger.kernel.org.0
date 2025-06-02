Return-Path: <linux-kselftest+bounces-34132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C8BACACB5
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 12:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A7E07A3626
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 10:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A235B1F4165;
	Mon,  2 Jun 2025 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4kk0B7F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785B72C3264;
	Mon,  2 Jun 2025 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748861282; cv=none; b=U4suxPtXJ9P5rRH4W07KbyNQtR1ZAyPNq1eD56EpmnjtYnSv9FTJR0kgzZiO9FqYUDNYJJivKmnLVV22kIy3mMa2dsDIDmC9jPcuOBzkg6mgKMHax+MwYQP0O0u/8evDJmqARUwVbdp64q/LzfYHDiGtmpK6g/9PFmXaDxpEPhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748861282; c=relaxed/simple;
	bh=Wty6Wq68ewqvz7Tt1hRI0LScGyWfS4wxoxNlHZ5WXU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9PD+1G+/IOA1Zfczn3OJZsFPKFpAmS+kMaksC8YCwyMN5jhI5GUeI2WWtpVnYEGhc/mHh2Bkt9sR0BoVlft75iR9A/Y+n+P+vJgNnQq/0pPdLEGXzVdnlWEfUAfBeUg11+nbfjwfOGQDHGonunkXxhtAmpeQasElFzZCB7OxaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4kk0B7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73003C4CEEB;
	Mon,  2 Jun 2025 10:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748861281;
	bh=Wty6Wq68ewqvz7Tt1hRI0LScGyWfS4wxoxNlHZ5WXU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h4kk0B7FNN1ZWr9IWZzltdeaBe0qWfnLlcEMgdhEwFJNkNnT2LuieXSkAIjPSeJLm
	 vh8e7PueCedUKuMw0OEEI2Ln9T8EID4npDcPbYzZMn0Aeqkcusw2RuNevc1wg6L5az
	 GGYiY7uI5CQoZsQXNAvSqUxIHrJb/RBhRlmBjMRMB4iobjmAuTIFLR8bCoD7+VQA3e
	 DD7qw/dy8dBdoXbnM41U6tAl785b+pAkKE1e+SLmB884KnplLOfdkbpyoTLNsMKBMT
	 2odQhjvO8z6TATn/rb24eixdNpkEsTuV42fCn97yHTiv8PnvelUOlGO2yAoJPf5l7V
	 vpBR+36pz1aTQ==
Date: Mon, 2 Jun 2025 12:47:59 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alessandro Carminati <acarmina@redhat.com>, 
	linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Daniel Diaz <daniel.diaz@linaro.org>, David Gow <davidgow@google.com>, 
	Arthur Grillo <arthurgrillo@riseup.net>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Ville Syrjala <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Guenter Roeck <linux@roeck-us.net>, Alessandro Carminati <alessandro.carminati@gmail.com>, 
	Jani Nikula <jani.nikula@intel.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Linux Kernel Functional Testing <lkft@linaro.org>, 
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] kunit: Add support for suppressing warning
 backtraces
Message-ID: <20250602-polar-gray-toucanet-a68a41@houat>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <aD1Roe-z6o1Y5K2V@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="lvmkbabpg6illdhp"
Content-Disposition: inline
In-Reply-To: <aD1Roe-z6o1Y5K2V@stanley.mountain>


--lvmkbabpg6illdhp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 0/5] kunit: Add support for suppressing warning
 backtraces
MIME-Version: 1.0

On Mon, Jun 02, 2025 at 10:24:17AM +0300, Dan Carpenter wrote:
> I like suppressing warning messages but there are still many cases, such
> as mm/kasan/kasan_test_c.c where printing the warning message is the
> whole point.
>=20
> We should create a standard way that test bots can filter out deliberate
> errors from unintentional errors.  This would also help humans who have
> to look at test results.
>=20
> #define intentional_warning_marker(type) do {				\
> 	pr_err("Triggering intentional %s warning!", type);		\
> } while (0)
>=20
> intentional_warning_marker("KASAN");

I understand what your usecase is, and would definitely appreciate
something like that too, but I don't think this is the right way to do
it.

Once we have the basic infrastructure in place to flag which warnings
are legitimate and which aren't, I believe a better way to achieve what
you're asking for would be to treat as failures any warning with a WARN,
and any test expecting a warn that didn't trigger any.

This would bring kunit on par with pretty much every other unit test
frameworks out there, and would make it pretty obvious to any users (CI
and humans) when it works and when it doesn't.

Maxime

--lvmkbabpg6illdhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaD2BXwAKCRAnX84Zoj2+
drLwAYDKoxTUiusghkG4/DVOcfFiLWP8RIQ7MwBrgQX33S75ABf2lkV/jtSOd+vB
nydVLEoBfjnS1T5PyeXGeC1wvJOrdYpF3Pnuk4fGn/aoyenjNNsyIbj92pw0fPHy
ybYZj0r0mA==
=r4oE
-----END PGP SIGNATURE-----

--lvmkbabpg6illdhp--

