Return-Path: <linux-kselftest+bounces-13691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18749930066
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 20:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83ED286303
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 18:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526D3224D6;
	Fri, 12 Jul 2024 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQI8qW35"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225ED2232A;
	Fri, 12 Jul 2024 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720808378; cv=none; b=TpmvQL5KAATSYmPQ8g5P96Aqxt2VV0skFkZykhmZEsJEYZp9qH+2+rsAYVC1/UmUrsHuO27I1V2J/pX+ojyEEd9ALVlvYgn0bTUkfYY1f30HhrfHcYyxAbUeNpjJx5X2/Cb7aCqFg0LzjCzhGacIh59xPiJfTGjuQsIXQSC58i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720808378; c=relaxed/simple;
	bh=4qXCwhc3Ht324DPghKg9o1bQweXFtYyDMdOwIxYAexg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7ZLc1jBHgLPcqm4UbqhllKcsrBgBc8E7m1x35Bl4a9KtcORfqQDO9pysNws1Q1wKsxnWeWoBlQ09TqEwc/L3/ZQiA8jr84n6jzD7XyA3WSixGKlMhtWiGHnwCKAWyhyZz2a5vluLPu8oP5thMYswLKOv/LJsSffSRuYmqxEixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQI8qW35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0745EC4AF07;
	Fri, 12 Jul 2024 18:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720808377;
	bh=4qXCwhc3Ht324DPghKg9o1bQweXFtYyDMdOwIxYAexg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQI8qW35NrXllSjy0JuiLhzn0HS9/1BSaOnRCXeH3DkXosjMPoNmthgca9OSu61ak
	 F8su8lZOR6TVx5ZdZXrY1AnogutvRdSiEviND2V+WEw0CSPxvqTT5UjKsUNLRGAOfG
	 7oISj27lMOx8bJB0KLPO1wmahYSFkMa4F2aUSFdv9aPY+hH5rTGT/NIiB9DKOMLmyX
	 BSPk6xqDKa1F7sJW8VsWUUQYr2Nw2wk0EdJvJ1xVJZV37tfDKGm4PmSyNPMUI9ii+H
	 ESE4IazYd0pLyV6PPwySYJ2NxvaMhUSJ55NyPH2mqfRCOurrDdlvHj4u9kMEjYiP9v
	 ZF6v0Bk4HltLA==
Date: Fri, 12 Jul 2024 19:19:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>, linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Use card name rather than number in test
 names
Message-ID: <31e73e81-e60f-4d0b-b0ac-118f1dc72610@sirena.org.uk>
References: <20240711-alsa-kselftest-board-name-v1-1-ab5cf2dbbea6@kernel.org>
 <7cd921b3-fed9-4b0c-9ba8-381e45ef4218@perex.cz>
 <b3fdbb63-067b-4ff4-8fd8-1c2455a553a5@sirena.org.uk>
 <877cdrt3zc.wl-tiwai@suse.de>
 <e4962ea0-3f03-43b5-b773-68abe1d73cc9@perex.cz>
 <bb42afb8-48a7-4daf-b28b-b82bd5c77d57@sirena.org.uk>
 <c1be6bec-90f5-4bb3-b6b0-8524095fc490@perex.cz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GVDNSq3mvasxxHGo"
Content-Disposition: inline
In-Reply-To: <c1be6bec-90f5-4bb3-b6b0-8524095fc490@perex.cz>
X-Cookie: Individualists unite!


--GVDNSq3mvasxxHGo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2024 at 06:25:21PM +0200, Jaroslav Kysela wrote:
> On 12. 07. 24 15:00, Mark Brown wrote:

> > The trouble with the ID field is that it's too short and seems likely to
> > create collisions, for example HDA stuff just seems to default to NVidia
> > for nVidia cards which seems very likely to create collisions if someone
> > has two graphics cards in their system.

> The default IDs are always unique - see snd_card_set_id_no_lock() in
> sound/core/init.c . Basically, the suffix will follow the device probe order
> in this case.

Sure, but the genesis of this patch is that probe order isn't
sufficiently stable and we want to avoid names based on it...  using the
ID will be more likely to work out stable than just pure probe order but
it's still got the same issue.

--GVDNSq3mvasxxHGo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaRc7QACgkQJNaLcl1U
h9Ad/Qf/bEIAL3IjEmfQSY110JrjxgHzIskjULbaZWwIlHfRu4ijZ6mCyeQ4JHOR
eMJT+OWX7rXBsZOHRNKB0f1decsJbb6yixfeq29mEiAriZ8yIri7kd17xM9girp9
X6mvTvBcWGK3O4yG1gDdkRsNFRt5kLjGGnTmyQ5d2c/0D2li1eM+8KiIpHsKIfFi
KYFeqeonr5aH0SX/Fv6JLiJMozPl2+0aY+O1LjOlls6heJhmmLqpYQgNA2tcwBWF
3sqBXid+TcyYl/AkadBZ9bG4VEZzJAidFSm4Oe2qWPquUDKWi/A133oFDqbV62uD
opkNiHNpJiQFzeZxt9ZJ435v5WE7+w==
=jt7Y
-----END PGP SIGNATURE-----

--GVDNSq3mvasxxHGo--

