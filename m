Return-Path: <linux-kselftest+bounces-13671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729D392FAD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 15:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCCB28433B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BFD16FF2A;
	Fri, 12 Jul 2024 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrQGy8xf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895DE16F8EF;
	Fri, 12 Jul 2024 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720789209; cv=none; b=A3sThCHyOqia7xuMpVwj0Z3nRVnTBxB7+UQiNYrWZIBSo3E0SofjkK6V3dsDYRHTYUjcs8lPq65o/olB5W9QbtWGj6AaK7K1VlDVJUbc1QeA+3LH8O6hYaq/bk87G/8KvZ/6K5glZ9KjDR2uAofgu4p1LRIYjIyHlOniFwEPvu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720789209; c=relaxed/simple;
	bh=jSLWfMXDwjEp+gRw22pYaQy0XJ5CPA338Dsd4mGvswk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efMYdfWk2+PybVmAM2uu96FmaArYRdbxBFJhYCGFLGu2wcFOFHQFg0J0yhxn4lY3v70Bd4lmnUPCOAJEBAKHWjad06AP9A2CcuBsQYBv644aHgnjc1efes3g/3WZeIMEV0/EiJg6MOM4CKMw6tBP0kCQ+BpnF4+qnxDhB/8C4rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrQGy8xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FBCC32782;
	Fri, 12 Jul 2024 13:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720789209;
	bh=jSLWfMXDwjEp+gRw22pYaQy0XJ5CPA338Dsd4mGvswk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrQGy8xfk/Rwc1Tid+q0DBz6FZJclmQYV/Ghxt2tjMABTmSZqHJawUMgJpOa7SM8v
	 XETVI9aJobWAZEB0WTWDtn8A+aQpthcxVpFdEDQdL1LUVHRlUPMWNo6P9a2McysXqg
	 Z1K6Dl5YduRNSChPnLqLs2nhr7Pux8Qdm110W4YibqOS/40JrFdk2qaZ9H3lzKw1ol
	 CL2HMhtjEiGDirS7Ji/4baVV4JMPhOYgDikBcqJw67noNhdV24igulxyGoi7sVv99Y
	 6HVSwL5KsE8nas730o7VCqgv2+5lHYN9+R71xC3HIM7nJURolrNT4SIxMWt9C6vA5/
	 1HekyagRuCgQg==
Date: Fri, 12 Jul 2024 14:00:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>, linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Use card name rather than number in test
 names
Message-ID: <bb42afb8-48a7-4daf-b28b-b82bd5c77d57@sirena.org.uk>
References: <20240711-alsa-kselftest-board-name-v1-1-ab5cf2dbbea6@kernel.org>
 <7cd921b3-fed9-4b0c-9ba8-381e45ef4218@perex.cz>
 <b3fdbb63-067b-4ff4-8fd8-1c2455a553a5@sirena.org.uk>
 <877cdrt3zc.wl-tiwai@suse.de>
 <e4962ea0-3f03-43b5-b773-68abe1d73cc9@perex.cz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tSYM6AG5MREuAaH3"
Content-Disposition: inline
In-Reply-To: <e4962ea0-3f03-43b5-b773-68abe1d73cc9@perex.cz>
X-Cookie: Individualists unite!


--tSYM6AG5MREuAaH3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2024 at 11:20:05AM +0200, Jaroslav Kysela wrote:
> On 12. 07. 24 10:21, Takashi Iwai wrote:

> > OTOH, longname can be really ugly to read, and it can vary because it
> > often embeds address or irq numbers in the string.

Capturing that variation is one of the goals - it should mostly be
stable between runs.

> > If a general name is the goal, how about using shortname instead?

> > Or use id field, as Jaroslav suggested, but without the card number
> > suffix; then it's unique among multiple cards.

> I prefer this (use only ID field). This string can be also set in the user
> space using sysfs/udev, so the administrator may change it if the default is
> not ideal.

The trouble with the ID field is that it's too short and seems likely to
create collisions, for example HDA stuff just seems to default to NVidia
for nVidia cards which seems very likely to create collisions if someone
has two graphics cards in their system.

--tSYM6AG5MREuAaH3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaRKNIACgkQJNaLcl1U
h9BjbQf/XNo2rNpuzL+vTJldIG6ZmLJnvm/MnskfeadVXHiWUvTMs7p16ZX2FXn8
C0curxs+gWgr84gD/0VW0/1Ff7BTh5zzgfc3PnxNB7yfvHmookWwqCUcdtunFqL9
3kfhDjX8DZHRUq5AW+S5DxybGNbsB6sMY4e0sHZI3xfYv40ZAptB/iptDBJ/Q6rs
PuFneE4kD/1EOtLV0SQ9tt5BVMff7aS50pN83e4IkNvvOb2RQw49kcf2fP+muRf4
8qqOotyA7swHp/Zxx7Aj9spvF0mW82w5YN5wtFS5AC9WP3IVJkuuMT2piXJX/lrE
yg05nHobsyVhNlUQHpok51BjUJCZog==
=x3Qu
-----END PGP SIGNATURE-----

--tSYM6AG5MREuAaH3--

