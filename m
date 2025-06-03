Return-Path: <linux-kselftest+bounces-34216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E56ACC754
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 15:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA541893C87
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BAA22FDF2;
	Tue,  3 Jun 2025 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Svw4zhmS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE5022F16C;
	Tue,  3 Jun 2025 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748955929; cv=none; b=OsqOnBcN+fujHJpv87rEDEU4PCnNyH/myvsGO+N9dcXcr+LgtQgPKXXLgVF/7ojjxC8kbs7C9sCUVCW4tet7r40wwZzjrtaIkHfpy6bo/Tw/0f4qaFxh+tyU0+QxZ7YhUAllfKfr0pAeJOiepPNm/udqfvqwF00hkKTk2M0nlDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748955929; c=relaxed/simple;
	bh=CQR2F4P/WFuLDUfY7mMG0WsFnPiqWfcgBuMnmRlV4Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vENbYHaWb3jDIr+lQZboOKU95xuT04GgOzbdPnIK/paEP7D5wkrXS1NpaVBDuT7ELRXIU1YPREqdJcJOy6INfqvBgdpaJpqUEf1tO05d594RIJt/HhZiwnonA/34BsLzfKgvujzWx0YUhZqnCpa5QPTfQwmx0PoSZ54QESd24dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Svw4zhmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2651C4CEED;
	Tue,  3 Jun 2025 13:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748955928;
	bh=CQR2F4P/WFuLDUfY7mMG0WsFnPiqWfcgBuMnmRlV4Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Svw4zhmSwk5wlMEpy885E553vr9FZiwmTa06hHqVug9C3ZC+qBt57F1ya33rflZNo
	 t4HpISxklHGjZsVBP4Ad6v89xohy/Tbmk6r++MnwbcWUCy1HcTl7NBaYqbUXlD0+TD
	 SrFHr579GfoAFLB8dWZggToNmHpiQyMc8YUOEA5+bWn6mPhphgAcUp8dLXx25xs1fR
	 6z+AP6mf9+dMOZmNJLky/KQn+h1qtaY3ifxvW0GmRJoWylZgPKN6L33N5x260EC8te
	 vaBARCbkxOJlVldTLq/q86RSe8DvhVF78QYivga0I3HDIDlTHWFNNFymgMpsGcyLz9
	 rnbm7gmSHn+Zw==
Date: Tue, 3 Jun 2025 14:05:24 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
Message-ID: <7ea6e0bf-da88-41a4-b6a0-1b1ee15c8dd0@sirena.org.uk>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
 <7ca09fbb-8b10-4dea-9456-dce21ade2099@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/mJ9tvidvqv+qSmO"
Content-Disposition: inline
In-Reply-To: <7ca09fbb-8b10-4dea-9456-dce21ade2099@redhat.com>
X-Cookie: Avec!


--/mJ9tvidvqv+qSmO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2025 at 02:36:07PM +0200, David Hildenbrand wrote:
> On 27.05.25 18:04, Mark Brown wrote:

> > +	int result = KSFT_PASS;
> >   	int ret;
> > +	if (fd < 0) {
> > +		result = KSFT_FAIL;
> > +		goto report;
> > +	}

> Not a fan of that, especially as it suddenly converts
> ksft_test_result_skip() -- e.g., on the memfd path -- to KSFT_FAIL.

It looks like the memfd path was an outlier here, the others all failed
if they couldn't allocate the FD.

> Can we just do the log_test_result(KSFT_FAIL/KSFT_SKIP) in the caller?

Nothing stopping that, or doing it for the cases where we want to skip.
IIRC this simplified some of the other callers a little.

--/mJ9tvidvqv+qSmO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg+8xMACgkQJNaLcl1U
h9A1/Qf/Xl85W859yQaAXxzS9ufb4fK7OtXZ7yGVpwtzQmY5v8GLTRLRLJjgw3Jx
HnhtZCEwnrs2uqx7Z8nIGgOCZOhv1+TEiZurBY8BJgc9OY79InqKqvQuE5vIkkNl
BTpHyZlUxWXUCOetEE36of+aGWHi20qY1Qh8VaALARABdaqTc1I5i/VN6hOdOIG4
WKsHJIKi41FvrQzMsJoQSiA57OdcnOIpKOWYDdkVEtF4e0+H7ARBOEzmphxyri2l
sDfGkYmmwymn0JZSpVMWzSZnS47uzE0+EPLYWjpsPN/gNY/LV/vNnZYPIL+gTeAy
o/jX+FEiqUnwozeW8Vc99YtdDjG8PA==
=/ARE
-----END PGP SIGNATURE-----

--/mJ9tvidvqv+qSmO--

