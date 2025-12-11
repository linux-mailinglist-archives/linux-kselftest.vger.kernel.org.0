Return-Path: <linux-kselftest+bounces-47396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1961CB5201
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 09:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0C6E300A360
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 08:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD362DCF6B;
	Thu, 11 Dec 2025 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="TdY9dR7O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5AD27055F
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442229; cv=none; b=lsAaUn3m1VN9P8T7ZseuLR2OV06xYBegRGP5bzJFBTNHC0kLNJ7tWo8+fttEhztz3G9ytmAXkWjL1nAO9twdxnLBC8aa9S2X2/AKWWF72sAvmbVPumcV/Fd1ESDcfXs5G4TG4dhd1XFuF9kBCa9h7RsGJBnTVjiAUK3qDDyhA4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442229; c=relaxed/simple;
	bh=MRJJwLn4uh/XMl9TnspM7YsDLZmHZfGvUAGICZFre+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSg9Y0mOnUOBhCv01nz0MxW82khLc+6GpuWJl7S6lYul7W6pYr4DRbaXCXnL5qjdO4/XjKAhNMsvmJg+TSZYsUdwPb1MrloQdcYkPJwgRDOS+Gd7Df0tF0BtJh4x/zcoBdyE7vRp9ty1zhsy7ZxfZklcdk0q75BJMVF7urMd0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=TdY9dR7O; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=MRJJ
	wLn4uh/XMl9TnspM7YsDLZmHZfGvUAGICZFre+A=; b=TdY9dR7OCendndt04aC3
	3d5vFDW7fF8pM3P8q3RUHL0QjAjkAG3huPqDdZi9t6Lsqr98RssZykgtuu7WFXGU
	dCVyqVImQRDbndtyiXwUml/5vTXRwmE+GikFLEQctVufqQnrMCYMAqsPApD+aeqo
	OaUOpWjsCf6m1a5UYWjwdF7Vxe8WnIcmHFZ9tcp7YpifHJVuHoVoaRURdn4O4kJg
	EGxdXh30qRiy4FNyMuMZgm9Q/nKt79SjS66NEtDEGUWfmEHlO2Gn1+F4MB7ds48n
	4ugQobUHEIBfm0Yz0Tf7C2PRhgbBDzzTd8yU5DdUDHIm4I47FjgrzWTXIPGJ5jY3
	2g==
Received: (qmail 3685892 invoked from network); 11 Dec 2025 09:37:02 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Dec 2025 09:37:02 +0100
X-UD-Smtp-Session: l3s3148p1@6SdfDKlFBKogAQ9wBwAkACQ4Xrn/InjS
Date: Thu, 11 Dec 2025 17:36:57 +0900
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <aTqCqab1pGB9LNZy@shikoro>
References: <aPT-7TTgW_Xop99j@tzungbi-laptop>
 <20251020115734.GH316284@nvidia.com>
 <aPcQ99MZse5zmv3o@google.com>
 <20251021121536.GG316284@nvidia.com>
 <aPo6CZyT_IGWmu-O@tzungbi-laptop>
 <20251023145131.GI262900@nvidia.com>
 <2025102321-struggle-fraying-52ff@gregkh>
 <20251211032306.GO28860@pendragon.ideasonboard.com>
 <aTo-xErTTiJcribR@shikoro>
 <20251211080517.GA28411@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I5KFRALLzEEVNkB3"
Content-Disposition: inline
In-Reply-To: <20251211080517.GA28411@pendragon.ideasonboard.com>


--I5KFRALLzEEVNkB3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Isn't there even prototype code from Dan Williams?
> >=20
> > "[PATCH 1/3] cdev: Finish the cdev api with queued mode support"
> >=20
> > https://lkml.org/lkml/2021/1/20/997
>=20
> I mentioned that in my LPC talk in 2022 :-) I think we should merge that
> (or a rebased, possibly improved version of it). I've meant to try
> plumbing that series in V4L2 but couldn't find the time so far.

Yes, you mentioned it in 2022 but maybe not everyone in this thread is
right now aware of it ;) The patch above got changes requested. I talked
to Dan very briefly about it at Maintainers Summit 2023 and he was also
open (back then) to pick it up again.


--I5KFRALLzEEVNkB3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmk6gqUACgkQFA3kzBSg
KbZgsxAAtQIZKT58nTJW456b5Y/ghv9NnPSmQQRL79ZHZcXMyzkfSu2MF4KrWFWz
OVNJ1tKwc95vyqKevzqIPkImZI5AFHW7vcokoo3Hh8K48b7KMMgmsWT7nJNQm2e/
sNhK98mdfwDKhJAc+5ww1+er32CEwTU+Y4XjQbd7FYxRvMEwksvnFiBzlA0O5ehi
rR4Y2mi1IV1ohLOWD0hGJJDTTG3LtNBMaSjrFX3JUG+DLz7hBE9il2bwot1LQyjR
Nj5a/B/tQa4hSJYYUIKH+XHgvwAvs9Ascjl4n21yyOws/GzwSgWAMBtVRIn4sutT
H0lToRyBqq/HoDAP6R3c0a7lLG9CPY14VoTfSxMgO6EzWRehZ70rgQ+Xuvj/Aeiu
fd3MKr2zMXEopV33iQkMoSBGOu4LZ82Iy/ek1eGVL9pFHsAAMR3+f4YR1ZMLidqq
5tl5o7XEAEvwJ4qxk/hjpQ1uE6+3GwqhZGPXqj21lRaIbWMZR0CR8H0T/vmMBoEp
uuItFBZoVZlwEXpwdkmTsetLeJXbyEA3C+zP2vVhQM/VZhvOSw4bANyZaQSKrK3M
cHfhPT/CN1sBSORpfxnWY6VMlZqup3SyjJSw1GIgZmocfMJF2A2BhAauzqKInti4
FTMn6hpc7p+6laiaQb6HQyGPwVoZiP5IcSWa8nMW0LTzSj6mDpE=
=VUlo
-----END PGP SIGNATURE-----

--I5KFRALLzEEVNkB3--

