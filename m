Return-Path: <linux-kselftest+bounces-153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D307EC7D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 16:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB1CB207AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9B7433C8;
	Wed, 15 Nov 2023 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMot+BPS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53007433C4;
	Wed, 15 Nov 2023 15:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AEAC433C7;
	Wed, 15 Nov 2023 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700063443;
	bh=AxRQ9Y/RrzRtP29GRL6CccyXYunQ633DeTBzGsCyGQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMot+BPSYUpgf34K5i4JQ4ytk8SMMk5K04pNrSisd4s52Sgg3qskLmpuuaxeqgnRP
	 avc6wU1wKa0XdWVGrLU8iWAPY0EjnnZythPnnuWVEYCGYdqPbHF3o8ow8W8Qiwl+Iw
	 gNkYj9UY/fVTbP4J8CHROmI2LBIvrLHbpqOOBVHtwDNAgG/ofmLka5ea9J7pQP1Wuf
	 OJauXAq4mew6jupJKgFp8jlZWqJkyRgzWmMCmnADYqyu39eNtK0e+TXn3h2cYz/q4s
	 8m59XLl/PZ8VUtx+RFs1KHwRrpaS7XJCd7I8/bEV9vDzuZy+ZALLQV6N7j2uxKykNE
	 bNvNb6MI7HmzQ==
Date: Wed, 15 Nov 2023 16:50:41 +0100
From: Maxime Ripard <mripard@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, dlatypov@google.com, Arthur Grillo <arthurgrillo@riseup.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, 
	Sami Tolvanen <samitolvanen@google.com>, kunit-dev@googlegroups.com, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Benjamin Berg <benjamin.berg@intel.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	linux-kernel@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Emma Anholt <emma@anholt.net>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/tests: Use KUNIT_DEFINE_ACTION_WRAPPER()
Message-ID: <6gfqtuhscq2z2obvx3xh6ve4kj5hrqniyegfywldtx2vowdp5z@ikix547w3vff>
References: <20231110200830.1832556-1-davidgow@google.com>
 <20231110200830.1832556-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n3zmtdttqoymp72e"
Content-Disposition: inline
In-Reply-To: <20231110200830.1832556-2-davidgow@google.com>


--n3zmtdttqoymp72e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Sat, Nov 11, 2023 at 04:08:27AM +0800, David Gow wrote:
> In order to pass functions to kunit_add_action(), they need to be of the
> kunit_action_t type. While casting the function pointer can work, it
> will break control-flow integrity.
>=20
> drm_kunit_helpers already defines wrappers, but we now have a macro
> which does this automatically. Using this greatly reduces the
> boilerplate needed.
>=20
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>=20
> This patch should be a no-op, just moving to use a standard macro to
> implement these wrappers rather than hand-coding them.
>=20
> Let me know if you'd prefer to take these in separately via the drm
> trees, or if you're okay with having this whole series go via
> kselftest/kunit.

You can merge it through your tree with

Acked-by: Maxime Ripard <mripard@kernel.org>

For the patches 2 and 3

Maxime

--n3zmtdttqoymp72e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZVTo0QAKCRDj7w1vZxhR
xQeXAP9Cc0Xaqj0i9btSv7+sdwGcJtBfv0nHvQIAVwKgmgijaAEA+a3M3Ed+B0yC
CAa0ilav0pfJVeTj5jGOnK+886mpQw4=
=9flX
-----END PGP SIGNATURE-----

--n3zmtdttqoymp72e--

