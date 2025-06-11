Return-Path: <linux-kselftest+bounces-34704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8948AD55BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E18B3A34BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713A02777F9;
	Wed, 11 Jun 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXro1T9M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C69D253F08
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645561; cv=none; b=pK9iU1Tbm4MrPapsdjL9nOSnTxkq0kNnWtNxKZ9JcweHm7NgnX/fzCrKfwQtdvcDccGjw3bk5db3FR0mfosTTqX/32xOUKOaTJ7PLRc0qRS4OHyZRshDTlEc26HvZnoORNoM+6uhZhCXjbUPqQAfMtBD2ITBRihL5dZ26Tx8A/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645561; c=relaxed/simple;
	bh=9KX26X6GW1iDgQ0uSkq3rTN6B5rLbx1VT6lq75S/Ju4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfIA0vkJ/Fl4+JyS2HMaiUL6FvGqSwtSqp7SNCwJoAJBYx47DUks7y8AGkDT7lVCNIli9juAXZUXm711VyCMtovcEGBVZJ7qhPUALjhWSoYqksvr7mBiwhRPjmGF/MlM5kJezaEoZi04FyvGAZ0SGSRQ760cG5OIPuZvDetuZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXro1T9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EC7C4CEEE;
	Wed, 11 Jun 2025 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749645561;
	bh=9KX26X6GW1iDgQ0uSkq3rTN6B5rLbx1VT6lq75S/Ju4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AXro1T9MJsigbHNSEuxgL2sFTPDsDUHWbLpWjpRp/479aLPglyUWKoVWGL/V8rstx
	 ZtVTuA6nzw1vRPLfqwbqn5ATn8Efg+WpEXJODoxIkclTw8TnDEVAZnsIokjnRShCwO
	 mv4WxISp2tQD4HitAvAxpuULQaswpuYuaIYhIYuRo1i8/t2v9TQaPald1PG7814ctT
	 Ijmor/B5u8gASr60MkP+0CqbSiycXNU+buRQGOj/15hz8qxPzHl0wwHxLEszEZWpbn
	 RlKaeoG+nACzUfbfqPMg3UBQLda1oHgBKQn9xSHvANQMYRqHUsRoTGtCW/BRujFc6Z
	 8VhtzIzn3Q5NQ==
Date: Wed, 11 Jun 2025 13:39:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
	vbabka@suse.cz, jannh@google.com, pulehui@huawei.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	aishwarya.tcv@arm.com, ryan.roberts@arm.com
Subject: Re: [PATCH] selftests/mm: Add CONFIG_FTRACE to config
Message-ID: <8e0925e3-70ae-4b00-9f70-3a0325fd1fae@sirena.org.uk>
References: <20250611121011.23888-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ZM+5O2byLW1Q9hb"
Content-Disposition: inline
In-Reply-To: <20250611121011.23888-1-dev.jain@arm.com>
X-Cookie: No skis take rocks like rental skis!


--5ZM+5O2byLW1Q9hb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 11, 2025 at 05:40:11PM +0530, Dev Jain wrote:

> If CONFIG_UPROBES is not set, a merge subtest fails:

...

> CONFIG_UPROBES is enabled by CONFIG_UPROBE_EVENTS, which gets enabled by
> CONFIG_FTRACE. Therefore add this config to selftests/mm/config so that
> CI systems can include this config in the kernel build.

> +++ b/tools/testing/selftests/mm/config
> @@ -8,3 +8,4 @@ CONFIG_GUP_TEST=y
>  CONFIG_TRANSPARENT_HUGEPAGE=y
>  CONFIG_MEM_SOFT_DIRTY=y
>  CONFIG_ANON_VMA_NAME=y
> +CONFIG_FTRACE=y

If we need UPROBES we should enable UPROBES explicitly, otherwise it
looks like we're just randomly enabling FTRACE even though it's not
used itself.  If it's a dependency for UPROBES and we also enable
UPROBES that's a bit more obvious.

--5ZM+5O2byLW1Q9hb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhJePEACgkQJNaLcl1U
h9DvZgf/bnaXT1vKg3ySOPSt6xSQ2LQKI6wkepKnc8XCT9rre3fbml1vBkMXBpGd
6XPDGIcOMnNBqJDSyl7XYHglAjW2Lj3KGtx8sCwbT9SR/nHX7NkE6wRucOFrNa65
uNZ/I3gvRyHiqo+Lf9Clr/1wwMlnBseWU7lBaXQJy+3qpxUkNoan5jN/xS/1/gRM
rgan9gRVyqxItL0y6o86mVV1dYJ11KDAKdfYDVv91y1czM875jQJFhU6fDs3qpo+
81bIhyqtkaeCePqo9Llas/R2oVvLZvyqVEdCfSvmL/QLg5sf4z/KhT98rBsn2XRB
Gi2Q5Tt5b3UIjFhve/MuAc+m7KwVoA==
=tUEy
-----END PGP SIGNATURE-----

--5ZM+5O2byLW1Q9hb--

