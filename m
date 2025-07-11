Return-Path: <linux-kselftest+bounces-37069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9A8B015B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 10:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AEAF7B84B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB8C213E6D;
	Fri, 11 Jul 2025 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRh9y3+E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8C1FE470;
	Fri, 11 Jul 2025 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221512; cv=none; b=SMpD/TZyH3ILmX5uzbV97bLlA56mVrmU/OuXaHds6O+8mFlR2cn5gUnnMgtNxONyUPUXkr37V2xZn2t/LL+vv5Mvfo7IZ7hgRqtJ+/j6JM9bMcdCAYmEAH0HKN6aL6vGegXDrPfUB8uVPnqJL1KoN4BV0cBpfQ6K4qPmW5Fbabc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221512; c=relaxed/simple;
	bh=hBats0wOEkeXVrWJcZXz4Tib1MVX0DvTh0e9YuBEi/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjrQj9ZC1EUFKWYd8q5ZHX+ye7M5WKhuC5WVA49t9NVUipMI87ZdELDAAKxaAnQrKw3iEEErPm9Vr8SinMjuQHVOnv5b35qe+RvOpFAIUJZqsAQ31WhvR8ddeIjmSyc1LrHbLIiUpm1ldO8vCRkZZLcOwedhzzCoADEAWqA2KsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRh9y3+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8952C4CEED;
	Fri, 11 Jul 2025 08:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752221511;
	bh=hBats0wOEkeXVrWJcZXz4Tib1MVX0DvTh0e9YuBEi/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRh9y3+EuV+xzIfX2kJSHk/AZ/GwgX1guRRSw5leHLz7M8Muup3jJQ1ZXYiU7ahn1
	 CTjJmJlogTLdSvA+SM3VUFmtc1J1OIYAgSqbZWbxiPFYRVRzMKu+LjhSQKRnI/Bqov
	 tlQRoA1u4v/UrWVUuhZ0oblxYdWxlJcfZiH6qyJGFzwGIRfAmkVR87fwwxR/bHF0dy
	 /uspO+GVHrjXg7eyK77PmOga29jUtJp5CI+vsmvAPBRYEtfYRp4sbMGOCihcO9Gqy6
	 XJgn5MW+F6lpuuhgttqhaE5YyFTuvHoTqFfXSctImFwf0BWdHmbbdkKaDvqsmD4hKs
	 gVCykGhzf2eFQ==
Date: Fri, 11 Jul 2025 09:11:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: wang lian <lianux.mm@gmail.com>, akpm@linux-foundation.org,
	ziy@nvidia.com, david@redhat.com, sj@kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, shuah@kernel.org,
	Liam.Howlett@oracle.com, brauner@kernel.org, gkwang@linx-info.com,
	jannh@google.com, p1ucky0923@gmail.com, ryncsn@gmail.com,
	vbabka@suse.cz, zijing.zhang@proton.me
Subject: Re: [PATCH v4] selftests/mm: add process_madvise() tests
Message-ID: <aHDHQzzbtgCh6Ox3@finisterre.sirena.org.uk>
References: <20250710112249.58722-1-lianux.mm@gmail.com>
 <81f9a104-6d7d-4552-851e-8690d4a1b723@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+/IoXd4HsyHrPrR4"
Content-Disposition: inline
In-Reply-To: <81f9a104-6d7d-4552-851e-8690d4a1b723@lucifer.local>
X-Cookie: Do not cut switchbacks.


--+/IoXd4HsyHrPrR4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 10, 2025 at 05:57:23PM +0100, Lorenzo Stoakes wrote:
> On Thu, Jul 10, 2025 at 07:22:49PM +0800, wang lian wrote:

> > +#include <linux/pidfd.h>

> However, the pidfd tests already have a stub in so you can alternatively
> use:

> #include "../pidfd/pidfd.h"

> As is done in guard-regions.c.

One thing to watch out for with peering into the private header files of
other selftests is that it's a routine source of build and sometimes
runtime failures, people have a tendency to update one selftest without
thinking that other selftests might be peering at their code.  The cross
tree aspect can make it painful to deal with the resulting issues.

--+/IoXd4HsyHrPrR4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhwx0MACgkQJNaLcl1U
h9A/uAf+MIGVFcilIba7icBSDcbAcHzzgAbmbJUq82ekRCx2smLjWfU6ypbcQh1M
iK9OzYaU2ecoHTIEHgaFK0j+jn4y1dENcKs24bYk/1mOeOaV3neipktCUO85wRFQ
mBfyAUgBQAUVozPBB9B8idWIlPE3NeYCFEMQxg6qu9v/bhBVJQzantwXQwWCM7eO
f8bbyeopLKHx4XYzZTIJoPbiZDK0TlzxLEU8WIa9/yKeL4VkkiUPVgDvbulIW91A
F0cJFWm2hdbMY6hr21WmrFV4vkTcFKLmXnKVGUcQ33hCzXhRXVaA/7gICQrCio4J
jVcdZTOenc/2hGO2abDiB2daXoz2nw==
=rGrn
-----END PGP SIGNATURE-----

--+/IoXd4HsyHrPrR4--

