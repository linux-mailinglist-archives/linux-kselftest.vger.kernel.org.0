Return-Path: <linux-kselftest+bounces-37996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3C0B12227
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 18:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDA63A3F29
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 16:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901572EE975;
	Fri, 25 Jul 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWgDiHJP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D73BBF2;
	Fri, 25 Jul 2025 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461557; cv=none; b=CSR8ARAAzUYYKqfPRIOD+HW4Sm37zMMkFjZZNU2ZvtGe89v06yiUbUd9e+ohXtla9QUGkw+O+9M/QDe43TLlUQRV9YnMSLaVwMItmjpU4cf0Q5uDi6IdM54FwQENTuOiWFUnn4MpOCAOv4paxSVJvLrozSUhR/AbMZQhjznQOJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461557; c=relaxed/simple;
	bh=pF4lunaFqYdrewdH6GkDToqh/eM283/KV5aQ/8yrPMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Asre5FQQvIXSIiLzuwMLCpC+5iTUCNEMAHjw2RfSEZkFtrJtfw7f9o2ZWLETuUiEph/mx9ck6TCQPFPPax5xT2kjUkbu62ZUvgjOSnw+WFSq+JCzB29KyGcqY2QFnF44AerXPSVvrUOzrcz/uQwelfX2TGpiCHclvouA0zhVqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWgDiHJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A40CC4CEE7;
	Fri, 25 Jul 2025 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753461556;
	bh=pF4lunaFqYdrewdH6GkDToqh/eM283/KV5aQ/8yrPMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWgDiHJPG8S2mHa8wUfniNuw6zAthW2OBoNLgq9pkrAp/jpiJWnMp3QzrRI8ZJfLr
	 kypTbAzegglrxnYBASHgz1oXKT2soysAVu3o4/vhkiEahR/+GQRh8NxOzGrEmin+hs
	 J+KobOkQpzQSDBQp9jAf8qMIVzz1GIctXji/3ifCAnMYgFfNPkUjgTHwc+cQ1N5JGs
	 qLoAnqXnErMGuJTZYDT6uzQ2DF2V7oGd6bCdk5oNQKo4VOegUvWywoL4IsHtqPsLti
	 o7zGEum57Udc2tAktVf48Ht7lLAR/PZDkwNhTVNLWX063R93xGVBe+cz4Uxg1Z+WIz
	 Gc0G6T/8J49xA==
Date: Fri, 25 Jul 2025 17:39:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Crediting test authors
Message-ID: <aIOzMLPiC8gN5t2Y@finisterre.sirena.org.uk>
References: <20250725080023.6425488c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="79jlyhnSeLm+Ouc2"
Content-Disposition: inline
In-Reply-To: <20250725080023.6425488c@kernel.org>
X-Cookie: Do not cut switchbacks.


--79jlyhnSeLm+Ouc2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 25, 2025 at 08:00:23AM -0700, Jakub Kicinski wrote:

> Does anyone have ideas about crediting test authors or tests for bugs
> discovered?  We increasingly see situations where someone adds a test
> then our subsystem CI uncovers a (1 in a 100 runs) bug using that test.

> Using reported-by doesn't feel right. But credit should go to the
> person who wrote the test. Is anyone else having this dilemma?

Usually I'd do a reported-by for whoever actually looked at the test
system, triaged the issue and reported it.  Trying to credit test
authorship separately to the testsuite gets cumbersome over time, tests
get updated over time for a range of reasons (toolchain updates, adding
more coverage, improvements in the testsuite's frameworks...) so it's
often not just a single person.  Hopefully the testsuite is keeping
track of things well enough so mentioning the test will point people in
the right direction.

--79jlyhnSeLm+Ouc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiDsygACgkQJNaLcl1U
h9ANLwf+KrFsMmrl+/vvfwCKrbgLCgyN+NiEvXJuhjtuIu7K8J/zLlal7IAr9hEz
yR5CEQcBOXEiNv/LSqpYWXpBEIye9gkHW1oYHkzB1PeNe14KMAxrg5P3jxl2shxW
jh6q8HgIVDh5kFteE7D6+UnTIkSoD9M0hG7APga9y88YEG3YGeWcaGkKZmIk94xL
WrZMNauJJceZSmoNJZHVRqFJfVP6VZQj1Go4zJ5ZKD+g0zx3ONVI1lo/omuFg1vf
1wRUmKBa9Zn70pADOy01RTtWsTynb+USj3HnxEuQXSUu1EJyzLKJ4M28CK7+f5nW
24DWjp4S6bEidMREKpizRKiQA/bK3A==
=Dzig
-----END PGP SIGNATURE-----

--79jlyhnSeLm+Ouc2--

