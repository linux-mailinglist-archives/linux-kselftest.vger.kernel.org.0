Return-Path: <linux-kselftest+bounces-29494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A583FA6A4F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 12:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 369D67A4C83
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 11:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD07A21CFF7;
	Thu, 20 Mar 2025 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="UFEH0HG2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BE121CA10
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470112; cv=none; b=EbfxBxQ5vZ4N1dA5cWbp3iS71pJC+ywvKLHjmFe76okayQi+9zfmlDzHXVLLUskIpTcDQYsPgfYg01IL8FAqqQlJq1B2V6pgBqqKpbpEJW3oy4mY/PGycAXv5AmzV2xHF0jat0IM+Vx3A/rUsyKZ+G5qc2SguKP/fnesSkyj6HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470112; c=relaxed/simple;
	bh=xaKR6n1k4bb0jvx4wjBIdk7JBCxnAZee/O2iM7onpgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKMcvj92KMgmTcRv7NDF7ip6nHE/F1qtPYGMRBiGpGdMwdrwo0h94cix8iICYpsb0941Uudk95CCwP2s4HjHOG4nG0XcbYiiHP3+saHQg3q0ElINAlu4j1i9pI5+VeR8qs2pwaBrN5O8s+qFWSppa3RNZS1Pd7u67IEyuIO6GZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=UFEH0HG2; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=xaKR
	6n1k4bb0jvx4wjBIdk7JBCxnAZee/O2iM7onpgU=; b=UFEH0HG24zqrI/R7b6L7
	AdaKKBNtrdAnNnZFvUAQF/Ld6O/H6x9Cv0yKCtai1Z98wh/7yflf4meS7AyOSV8n
	LFlYODzcbUn65r2Jeg8SGqOIjp25gzDGfj+9X42LYHyho7cY6owRgB+fHO+alMdL
	8cegg6nGzN7uNSCLGhSlA72IdrTEii6X9M5stsiTc9zoKPh3Lq/ddfWLcez1MS6e
	OILdd6SI3IqeQmqEvW4OdyKUAkvExRQAafVeMyxJv6OcGpz2tYShmhVwBRkGgQCg
	JXtXutlULU4j51hgG7hTykB+/gL70TLagI81PYRr+UI3p01eBTIDkCwMFYGEdba4
	mg==
Received: (qmail 632991 invoked from network); 20 Mar 2025 12:28:28 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Mar 2025 12:28:28 +0100
X-UD-Smtp-Session: l3s3148p1@8gTQb8QwoowgAwDPXyTHAJp038nK7dx+
Date: Thu, 20 Mar 2025 12:28:27 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shuah Khan <shuah@kernel.org>, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH] rtc: remove 'setdate' test program
Message-ID: <Z9v720fSbvKN_0ii@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shuah Khan <shuah@kernel.org>, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
References: <20250320103433.11673-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdVwVyyZWfgFi12ujvSj8bVtDZyZvj+QMZ_iQbPbRDNHQQ@mail.gmail.com>
 <Z9v550Kbt8tjYst3@shikoro>
 <CAMuHMdVwNE-o2_eq_Fu4FXiSnJn5rsg9P28PusYn3DKNdszOwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U2qfeExht+Dr295e"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVwNE-o2_eq_Fu4FXiSnJn5rsg9P28PusYn3DKNdszOwA@mail.gmail.com>


--U2qfeExht+Dr295e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I found it, because you provided a link in the diffstat ;-)

Which is basically the only way to find it IMHO. No loss if it is gone.


--U2qfeExht+Dr295e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmfb+9gACgkQFA3kzBSg
KbYr1Q//Z3VNzKgLCnjfHQMZvS9TweYESWgLfHJroRTcoV8yUiW+LG4+T3xIoIm9
cKh2WMFlp3FnhRyRXIXNyR+wEJL2P0PHtlvApjKCTpYRs2IVW8E92ai/ovbaZYSF
sjZGR1R3BpHzX5m5QcSipyrtmDMHNK98yoUNnPh8ht227v2ju7uPoo1FGkQk3E7s
rpudh/4PR0IcExNgexjYg6jJrPVeVoUSJzC4qeTN2MFi/ymXNcBPZGRasrHYFa1p
l7mtqICL36Q1d3DiiwXW5a8qmhobAcr/4tVP+IbWvZpL78+/lAMVB8oYLWFK/50D
SiMYP16MPnUd/T8s1r/yEn9l2oajQwh98D8lKEGo6Kc3c3ZnKZBX7bHd6xsVGuUq
tMzSxtdOfkHFq5w4iR92cuhgfKyt6AuhlHSpqtEyrSZfQ9WbFQIL/Rr9N/0P2yUB
tlItMFYyJJugKQBqR8nyKKt/Ukk+uAt9KLVOOPQAW7mw8ywRZcq20zig6wogMJGz
22GCYrn4Ip7nQKWojNfDihh57CGIIx00j0axX5edrusgvxA3MGQa0wqfAP2iGbd1
6DRUrF/b7MuzZbxNvYDa48q6ZV111DC7/eIkWShbQGjQAT8XHKJeYb235X7sqJ/a
4LJsyBQrYWtLQnT20NAqMJTPV2w4rzNguj4vSR9M7LiPzgTPjjc=
=mPk4
-----END PGP SIGNATURE-----

--U2qfeExht+Dr295e--

