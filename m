Return-Path: <linux-kselftest+bounces-16697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D02964B6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 18:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04456282989
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 16:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7901B5EC5;
	Thu, 29 Aug 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBwpJXxC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663A1B0132;
	Thu, 29 Aug 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948215; cv=none; b=W+ynAmii1LWSHLf9AvrdO1shSnS7Mb2pBfZwkxmXtKrTHdu0JFnnA45ebOBVJdnIRoAW8qAYO2AkQcF+NPzSrDFAX7TkbfYZbR2kNLLXd+vgqeAFQ7lxVnGnsoo6rWpugzQLJhohR4OhCAan9SPamWZdeUi9GWfQY/95CLinNZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948215; c=relaxed/simple;
	bh=vIfDg6+86JXqFZXXwkgT2lAhGXfy0iYhn+O9aNgu0II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Szb0+BuCBZw8GK32ktm55F2ELB7P1nbUM7kO0YaKgzLCAkwzR+PSLsjhrKgoe6Pd8teiblZcU9GpFOYoxjsr1KZd9apBeQEyw4N5cvTEjWnCXoOR7sxKm6lI4x3yacp2RSmpaYu0Mu2qlqwkVNG9kHJ5iRvEDptG0noodPHw6iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBwpJXxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26529C4CEC1;
	Thu, 29 Aug 2024 16:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724948214;
	bh=vIfDg6+86JXqFZXXwkgT2lAhGXfy0iYhn+O9aNgu0II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBwpJXxC475L6gtzuSz0dziTR5saTkGcwJxmo7V8Q2lrUcg+ksrAQbw2EjSzNKMHw
	 OhnKb5N9icz9xx9wkZhSye6k4LIy2dXBykbZfUBLgDsoFAhrTwVEi/1ryhdpqex71s
	 yK/jN4SGf6gby76+vFiCkQOh8NsC11KjAtiNQnsMWYAEzy4SoRqE4voAb6IBnmpXnP
	 5FB9tUdnPLesZtQzfmhC88Ouao1uwAoJBrB1WLNyWsWfqzpfDQcpJ+yeP8Us1pnP8m
	 s7N3tCNrQNoPpTQmkkJa5jyTLj5bzxZvShcKrCG/a3kDra1kW7rWCsvL4dKT6XjGnK
	 dSjGRJIg6NqLQ==
Date: Thu, 29 Aug 2024 17:16:50 +0100
From: Mark Brown <broonie@kernel.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org,
	pedro.falcato@gmail.com, rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v1 2/2] selftests/mm: mseal_test add more tests
Message-ID: <293ce8ff-10c3-46b8-a56b-a1bddc7aa37c@sirena.org.uk>
References: <20240828225522.684774-1-jeffxu@chromium.org>
 <20240828225522.684774-2-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fk2NVf2lDvQOFni9"
Content-Disposition: inline
In-Reply-To: <20240828225522.684774-2-jeffxu@chromium.org>
X-Cookie: Baby On Board.


--fk2NVf2lDvQOFni9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 28, 2024 at 10:55:22PM +0000, jeffxu@chromium.org wrote:

> Add more testcases and increase test coverage, e.g. add
> get_vma_size to check VMA size and prot bits.

I think this needs to be split into multiple patches, for example the
new test cases done separately to the additions to the existing ones,
possibly as multiple patches (eg, should the size changes be split from
the prot ones?).

--fk2NVf2lDvQOFni9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbQnvEACgkQJNaLcl1U
h9BvhQf/Vi/ekKe6Yq/5eKAJnz2APhu40fJaFN87eHbuBkbXvvVWQqasDXn7h3VU
OVWDdiFk3j95VYErDfiZSG3XckxdzYwzjSIhSvtrVrst85zuUxD7CYcT00e9vaK1
EX2ZrrFPnD8SwbtEmK5OsPllGkQNi1GdyDwUs1x+kw/nO/A75bwKKluBj1aCAtP0
FDHTSCtfGIDV61U/7CbfxpW6ucPqcjOrWiVIflRDGaEz9C+PSBOO2WjxtTa0cWbj
VJZeof3ubm3OijFV+fUplRewFUjG3HXZY3a1fEGJ+zb5frQTzqxSSx0umHLnyesh
0JamzgLhg4JjPBkC2lZAXId9gMXGzw==
=69gj
-----END PGP SIGNATURE-----

--fk2NVf2lDvQOFni9--

