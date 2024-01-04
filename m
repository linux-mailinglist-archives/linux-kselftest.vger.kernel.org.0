Return-Path: <linux-kselftest+bounces-2637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3F882442F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 15:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FB71C2177D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 14:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B8123752;
	Thu,  4 Jan 2024 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUtfcXe6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E617422F1E;
	Thu,  4 Jan 2024 14:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EC1C433C7;
	Thu,  4 Jan 2024 14:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704380071;
	bh=E9L91yMKm/IOnJapy8qxMAwMEzDJHXCfOiSiBSjhfFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUtfcXe6/fVl4KzcO4zqbk+ezOlXlOHUIdxba4GzIpiYFkC8stCxHEbe5iLtrgj5v
	 bQbK3GPSL8bYDR4fdjFOK4gh18bJeeinlXDy9Q4G6h63o8TdNlQoALqVppa4wyP3ZT
	 xecqrjDXgeECmWK1o0nhW7A6lR5KfCheqwoGPvKfQhZZIz339BO9BJI+cvoAnQTaYg
	 N7reFTJ70hxYQg1frSZL6ewEIKoDmVxw1b59Ezmyn84bNKOU6fSAMqxfE3Yxhuhtoy
	 iQU6/bfaxrwIkbspVkX3R+rE1rLWOQFxIqcJSXMZawpHjdQW30xHS1ORJ3I3rOYmn2
	 u0lmrGg6mse1g==
Date: Thu, 4 Jan 2024 14:54:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, kernelci@lists.linux.dev,
	kernel@collabora.com, Tim Bird <Tim.Bird@sony.com>,
	linux-pci@vger.kernel.org, David Gow <davidgow@google.com>,
	linux-kselftest@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Doug Anderson <dianders@chromium.org>, linux-usb@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>,
	Guenter Roeck <groeck@chromium.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/3] Add test to verify probe of devices from
 discoverable busses
Message-ID: <ded0cce0-3462-4c40-96e5-ca53b2028767@sirena.org.uk>
References: <20231227123643.52348-1-nfraprado@collabora.com>
 <3271d300-74c9-4ef3-b993-a8ddeda6076c@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g/NlNyEnSF48Q/hE"
Content-Disposition: inline
In-Reply-To: <3271d300-74c9-4ef3-b993-a8ddeda6076c@suswa.mountain>
X-Cookie: Q:	Are we not men?


--g/NlNyEnSF48Q/hE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 02, 2024 at 10:45:59AM +0300, Dan Carpenter wrote:

> Life hack: Don't put RFC in the subject.  Especially if it's a v2 or
> higher.  No one reads RFC patches.

RFC does tend to be useful in cases where you know that there are
substantial problems with the patches but are posting to solicit
feedback of some kind - otherwise people will tend to get annoyed when
they notice the problems.

--g/NlNyEnSF48Q/hE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWWxpsACgkQJNaLcl1U
h9A4RggAgLG7ZcjiZWpD080jcXJXiUSTKdDw2ybN7fZmObKI60MTc35hGtxZd9g7
vMyfr3rjtJLW7OZzrvMa902sWVyadOAjxIq3PbuvcZ34ISgR+GZ7ofyk/+sk/MDm
klzDi5pvQ99GuUuryAiJvnzXZCsltchdPfVlSjy3vNRQvBIm/dG7MGoO89PF5zEc
BE8PXyPfvJtaaFfjXlF9urVd5xbRX6ebg84HCOpW/Mn1m8Kmmd/B6Pb95cR2xRTx
1JYRXWGcMWyPi8RKoHl5EBvH1FLXXYy8j3VgFvr7P7S78J7iHxfwhaT5FSuKVkfV
ALy6TqkVvQjeFeoBOvSfZNtNzrtCPA==
=Cz3a
-----END PGP SIGNATURE-----

--g/NlNyEnSF48Q/hE--

