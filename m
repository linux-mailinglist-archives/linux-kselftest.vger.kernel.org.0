Return-Path: <linux-kselftest+bounces-32831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93130AB2FD5
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 08:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15D216747B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62037255F42;
	Mon, 12 May 2025 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZQSAymog"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8970B2550AE;
	Mon, 12 May 2025 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747032029; cv=none; b=i9i9szMLuf5i0I0SZXvnb7rlAsicVLqknVXxnIZVpOIbddzlUYCr2vPd2gG//WDrtP9zEgBropT6osON9hsAI/LBWvFeR6FVfHti1ZkpC1swskRloe963Zd1E7JPVdv70FQF6LrbSXyj5AAZDKgWo+usiSroDnOwNp7QCA+fw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747032029; c=relaxed/simple;
	bh=3YA3dyA7fc/Ouhhp+VM8Zd1IJ48oa+kRBjWppAACdkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oB1RLWS0lltsJQBv5E1ZUX22b97NWeCmYexCfT1CZik/gQRRiewvwex8rCmPm4CfGbpsJVgzXA3XqRmMxBNqciUI3vIU1c7yB+SDy9StoFPkUE6ka6Mh5oIzXR6imkR+yrXnJeqhILrdiRBGHXwrGUa49fBF1EqKZllmaYzsOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ZQSAymog; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1747032022;
	bh=3YA3dyA7fc/Ouhhp+VM8Zd1IJ48oa+kRBjWppAACdkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZQSAymog4yTGdUmTPYv5NA2Lls2DaVwWQ0mZK37+lOXJJaEq6jt+f59bAqI7Ka6j6
	 n0vFhBRTSgcNhq79s7VdaPHNkJsXmHTKx/V6JlGbRxugXgFq9ppiRTQmNN1WN6WjGy
	 bsNt2mOTsrxz5ko5qHA5zxHtVX4tddP5mpkPbUzzhqsYlMZo7xlqhzG1z5rU1iANfB
	 WBxFz02MfjnO6yv1WdsUWh3coxNhQ917lqIsIRi7bYnOpViCt5ZSWQz52tsd9qnmpN
	 XOAXAMqRScvYdO/JBC/vTdcsGvJoKy4bIehDRA8b8EEj6qpaigtENuPLigSBaCCdir
	 OOP4PYcLkirFg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Zwqjc6J7lz4wcy;
	Mon, 12 May 2025 16:40:20 +1000 (AEST)
Date: Mon, 12 May 2025 16:40:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-stm32@st-md-mailman.stormreply.com, Linux-Next Mailing List
 <linux-next@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Hari
 Bathini <hbathini@linux.ibm.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] selftests/bpf: Fix bpf selftest build error
Message-ID: <20250512164020.55eb30f7@canb.auug.org.au>
In-Reply-To: <aCGGZ9gApo+QwSMD@linux.ibm.com>
References: <20250509122348.649064-1-skb99@linux.ibm.com>
	<CAADnVQKBQqur68RdwbDVpRuAZE=8Y=_JaTFo-36d_4vr2DNVyw@mail.gmail.com>
	<20250510110455.10c72257@canb.auug.org.au>
	<aCGGZ9gApo+QwSMD@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nLXLLJNx8i0XWRzr=BN1g7o";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/nLXLLJNx8i0XWRzr=BN1g7o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Saket,

On Mon, 12 May 2025 10:55:59 +0530 Saket Kumar Bhaskar <skb99@linux.ibm.com=
> wrote:
>=20
> Apologies for missing the Fixes tag. Would you like me to resend the patc=
h with the=20
> Fixes tag included?

Yes, please, but send it to Greg (keeping the ccs) so that he can apply
it to the driver-core tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/nLXLLJNx8i0XWRzr=BN1g7o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmghl9QACgkQAVBC80lX
0Gxjogf8CwRo3iw1LLROG/ll6OqsWmpdaFegvG57rScdZeaWHH1xMCOl/GmBTJu2
gp1/6uX5sx7/87CFLgEWAIjT6h7ijKj5V5d4F3wM6HHR04BC0lzUWtO99rn20FMU
Mxg1/jTzDcHqsMmakFCiFPkxQQmcuy7+TMY+1UsC2ouyvdsOgtE4wf7YSmiTRJLl
Q2tlLWAYHIZTsDUxng2h4eq9d19f1QZvlfntpAfvfblkKuaM/gzEiQcJnC2iG159
RZyQCPMEbySj2XUJqx8slBUvS853/uTL9Ms2ggrt1t2pf7uKdcCRNtHF+pFxJPbm
6jOW5Bu8Ncm0+xSJaiFB+z29byxL2A==
=xLJ7
-----END PGP SIGNATURE-----

--Sig_/nLXLLJNx8i0XWRzr=BN1g7o--

