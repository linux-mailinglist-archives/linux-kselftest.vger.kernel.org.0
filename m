Return-Path: <linux-kselftest+bounces-1844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 016458115A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 16:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399702816C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A2C2FC51;
	Wed, 13 Dec 2023 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXfv4/Lq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C52FC43;
	Wed, 13 Dec 2023 15:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D54C433C7;
	Wed, 13 Dec 2023 15:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702479894;
	bh=nLxZSg/yD+znXZHWu4Vars8EQtCSP3KKevIj0nvJOvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXfv4/LqeVxml8cC8xOBVkj+C55XQsUDotUQ7wQUxQWoFbyIib8cxLn83khaDCc4k
	 TILfe0piJJA6WNjTiLEbHky3WCF3flzGtV+5xo0vYZQlBu4zRP3y29JPvzgpQlvpSX
	 vVpfhuu6luVuxCbLAUa4tNmNKCq0zOs07W4sF7mJyieBq7NX65GCPoLpF+ROydPe0K
	 Zz1W/D9mBRGgS/BsylPZd0XI4b2QIJ7IMKiVxK6Ho3Fi47X9WIOzlsYqJJ9ZFxueeg
	 udiK2Vi7fEU/qhifgMPuGQMc57/j6njhGJ4fwgdvcWN7OvaGicgLZv7oDBpNVisLX/
	 WMtM18XMSrccg==
Date: Wed, 13 Dec 2023 16:04:52 +0100
From: Maxime Ripard <mripard@kernel.org>
To: davidgow@google.com
Cc: Rae Moar <rmoar@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Stephen Boyd <sboyd@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Kees Cook <keescook@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 0/4] kunit: Add helpers for creating test-managed
 devices
Message-ID: <7rgeotye4grxdtbxip53fykjm4a3sudochsfzdvkmyqltvj7zv@qekkt42x2j25>
References: <20231208-kunit_bus-v2-0-e95905d9b325@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="znksof6fizamytva"
Content-Disposition: inline
In-Reply-To: <20231208-kunit_bus-v2-0-e95905d9b325@google.com>


--znksof6fizamytva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Dec 08, 2023 at 06:09:28PM +0800, davidgow@google.com wrote:
> KUnit tests often need to provide a struct device, and thus far have
> mostly been using root_device_register() or platform devices to create
> a 'fake device' for use with, e.g., code which uses device-managed
> resources. This has several disadvantages, including not being designed
> for test use, scattering files in sysfs, and requiring manual teardown
> on test exit, which may not always be possible in case of failure.
>=20
> Instead, introduce a set of helper functions which allow devices
> (internally a struct kunit_device) to be created and managed by KUnit --
> i.e., they will be automatically unregistered on test exit. These
> helpers can either use a user-provided struct device_driver, or have one
> automatically created and managed by KUnit. In both cases, the device
> lives on a new kunit_bus.
>=20
> This is a follow-up to a previous proposal here:
> https://lore.kernel.org/linux-kselftest/20230325043104.3761770-1-davidgow=
@google.com/
>=20
> (The kunit_defer() function in the first patch there has since been
> merged as the 'deferred actions' feature.)
>=20
> My intention is to take this whole series in via the kselftest/kunit
> branch, but I'm equally okay with splitting up the later patches which
> use this to go via the various subsystem trees in case there are merge
> conflicts.

Could you take (and apply eventually) that patch as part of your series?
https://lore.kernel.org/linux-kselftest/20231205090405.153140-1-mripard@ker=
nel.org/

Thanks
Maxime

--znksof6fizamytva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXnIFAAKCRDj7w1vZxhR
xbTWAQC3bH552498SP6tLXv7kKo878Z61Buc15OZAdQwh4kdXQEA9UZqLQkvJTrT
kQ13+qYaarJ8Jpvwt41WGCqAxaRt7gw=
=yRUg
-----END PGP SIGNATURE-----

--znksof6fizamytva--

