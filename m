Return-Path: <linux-kselftest+bounces-34390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE6ACF540
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 19:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA0E67A76F6
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F9C275861;
	Thu,  5 Jun 2025 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/Or4xx9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC41EB5CE;
	Thu,  5 Jun 2025 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143946; cv=none; b=VQTQ3bNDYjZbANn3zXhPtaNFzdlVhvMxYI8yC3YvpUYSX6qcH5pcqd1XswbxgkEDtYmqQumsflfXUgK5dNeUR5jBAhJwmXB1AZtonaOe/FyQymzA20hkoNPqqwuM717zcEWR52idFT3um9I4fChYx1mMx7XGz1GGkIoud/EdliE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143946; c=relaxed/simple;
	bh=xCg9FEDKTtf3vgEKMxIzLSqhN3C9kcE2FIyIYFBrXO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FePbF/oof7YMh6o2uTASh8kDsuWXZSXpA0zc6nCYFGrL/xK/cwpQqzkbuQb84q67NnXr9uc92dMRZH9aF7VOnr5Mm9GR2WBylOFt6sEuY6x5khKLmRsK/hcbkf1CTkzhn3z2yGeoJPe1J9vTQvio6o5Z8mVriP0swOJu+yHvVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/Or4xx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB5FC4CEE7;
	Thu,  5 Jun 2025 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749143944;
	bh=xCg9FEDKTtf3vgEKMxIzLSqhN3C9kcE2FIyIYFBrXO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N/Or4xx9tvbtr9+eiQwdd6CVnIQNajAKUUJYDj6KC5xhn2BBiftLbYl16k1QvKqhP
	 ZMmcd1+CW7EEBd1yXWLiDYjt1To5AbFcX07xfA84hgTaDIpEroHuqDSqsQNZawJfi4
	 +1wEgHha4pMQLPXuVPFr5cYFuqpw2+Vsr3lmI5D9dPMhFWJvNjUawjZsrtgIzFxHUh
	 CHxnV9Yyf/SC3dENM+XsHdSwUCgn8hz8RN386uf4gpqoyT4pGLHnv9CWDEMMZqjQwS
	 A0IKfKRjEGzvbzEGz0HhmnNikyXgDrKbbAqJVpGZIkZqIW3XiRdWXV+fJXgjjYhmoE
	 kRA6kVpBBevkg==
Date: Thu, 5 Jun 2025 18:19:00 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
Message-ID: <d039ca05-da2f-4317-be04-34edb7ad3496@sirena.org.uk>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
 <a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local>
 <722628a8-f3fd-4fb9-ae04-2313a52ffb36@sirena.org.uk>
 <66db3d9e-73a6-4fcd-8abd-db65cfff49ab@lucifer.local>
 <661fc4ce-839f-4c47-bc3a-0c864e846324@sirena.org.uk>
 <077b6af0-bef3-4f1f-b785-9e351d01a89f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xgLCgah/58nynGKp"
Content-Disposition: inline
In-Reply-To: <077b6af0-bef3-4f1f-b785-9e351d01a89f@redhat.com>
X-Cookie: That's no moon...


--xgLCgah/58nynGKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 05, 2025 at 06:55:53PM +0200, David Hildenbrand wrote:
> On 05.06.25 18:42, Mark Brown wrote:

> > I can't remember off hand, sorry.

> I assume in ... my review to patch #4?

Oh, yeah - it's there.  I did look there but the "not a fan" bit made me
think it was one of the stylistic things as I quickly scanned through.

> What an unpleasant upstream experience.

TBH this has been a lot better than the more common failure mode with
working on selftests where people just completely ignore or are openly
dismissive about them :/ .  Probably room for a middle ground though.

--xgLCgah/58nynGKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhB0YMACgkQJNaLcl1U
h9BK5Qf/fpHXvEbHQRvJzqX8a/QCO94vPB2OwXy8cSOSokQohN3ZULM13g+tnQw2
5BJmHheHkQlqu8VykO3C8BbWyAmR6anJAOeAYaQOPH7itzqrSNnhsoI8pylVPhgK
hiYQ8jmIcRkdHPfachihGaHmmrAvF8xZDtRUITnL75f3YlwOmAy+uh1Zj11clYqL
mXQZEopwVJWi0DGJyfCFBiMrda86ck9da0KhBDMh0b1vHw9xKOBZpt6Ukt/gsVAh
zJXj4R1OnanUjhrxSKuDppSwbSSHGzic6f7LY6WSg4Kno06t0RHPED6vxBGvY++N
D00VBYOYo/23HOGZJ3NHG8f8xAajSg==
=YRar
-----END PGP SIGNATURE-----

--xgLCgah/58nynGKp--

