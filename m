Return-Path: <linux-kselftest+bounces-10832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1615D8D36A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474761C21B72
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 12:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218E618131D;
	Wed, 29 May 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="lhTJlA8e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7818131A;
	Wed, 29 May 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986646; cv=none; b=Nxdn7WTIscNhIBMQJ9ej3nqFqCJ2QiGTFJGpQ4AAcFDy+2HQS50byWwZ/b9RJRQuVU3oYkZp3Aq8SHJapVwzaFEBpUqv4XTJyX8uBtRmR2y8VeRMEmLRD/aabR0mw2b+kJYixIu70ceJov5Jtqg77gj2T8Kd8+qUlIk/D80zGWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986646; c=relaxed/simple;
	bh=HRqov3Sa5/L4s82tqEXJGzJO1GXEAXyDmpW8rtS3pHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dc+4Kofh83I/ivREvIt7s6hcHYBkYMBUlSbYOA5/nrDUCaVcWLBLO8zF+cIFmpjk89PnngXEKXV+Rm+5xG2Qh6722fJl+WktLQjkugTK3vUSo8RLwztKJM1Rfj45yyrKARMZUch80xqg68Zhlqps1uhMYEvT64cZ5QfM38DpwgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=lhTJlA8e; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BDDFF883A1;
	Wed, 29 May 2024 14:43:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716986636;
	bh=HHHH4mjOBme/bWtP6IROpkp0jbobhmqEdOu6R28KqDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lhTJlA8ebjeFFCnxQW19UjgzypT64S6aGJ/Pm7vqq+OtGOuWHpAWA34vcNUqojvhn
	 Gyc3lZ0TpslsN7KU+bTq2fnPAB3WqXqrJg+hmUbexwA7iAVrJ45cPi2ED2q7Ws6Wgz
	 +Bu3PIdo1hkkwEIFYX3rQbjkAzp2I2OGqboTAdv/akBRD+7ZkZKiaqxv4VmObKn9Ma
	 lv2/CSvJmBV+zvHJ4bG00spVLDNOQjxZ2FtNvlkWmRiZgp7gHHxUu0VN3pRkGcsEQg
	 qn5hGcEkORogId5c04Jcrp8o532juZ0NAm1PYjLmfIKNO2JVQaHO5jGvv9qat2Td9D
	 zLGKY2rxnOo+g==
Date: Wed, 29 May 2024 14:43:51 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Geliang Tang <geliang@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Hangbin Liu <liuhangbin@gmail.com>,
 Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2] selftests: hsr: Fix "File exists" errors for
 hsr_ping
Message-ID: <20240529144351.44719939@wsk>
In-Reply-To: <6485d3005f467758d49f0f313c8c009759ba6b05.1716374462.git.tanggeliang@kylinos.cn>
References: <6485d3005f467758d49f0f313c8c009759ba6b05.1716374462.git.tanggeliang@kylinos.cn>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//x1Vo1wzjmAzVKYxRf+WmaX";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_//x1Vo1wzjmAzVKYxRf+WmaX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

First of all - thanks for spotting and fixing this error.

> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> The hsr_ping test reports the following errors:
>=20
>  INFO: preparing interfaces for HSRv0.
>  INFO: Initial validation ping.
>  INFO: Longer ping test.
>  INFO: Cutting one link.
>  INFO: Delay the link and drop a few packages.
>  INFO: All good.
>  INFO: preparing interfaces for HSRv1.
>  RTNETLINK answers: File exists
>  RTNETLINK answers: File exists
>  RTNETLINK answers: File exists
>  RTNETLINK answers: File exists
>  RTNETLINK answers: File exists
>  RTNETLINK answers: File exists
>  Error: ipv4: Address already assigned.
>  Error: ipv6: address already assigned.
>  Error: ipv4: Address already assigned.
>  Error: ipv6: address already assigned.
>  Error: ipv4: Address already assigned.
>  Error: ipv6: address already assigned.

Interestingly, on the QEMU setup with -4 switch this error was not
present.

Instead, the not re-initialized name space caused some subtle errors
when tc's netns and netem were run (a few packets got dropped).

>  INFO: Initial validation ping.
>=20
> That is because the cleanup code for the 2nd round test before
> "setup_hsr_interfaces 1" is removed incorrectly in commit 680fda4f6714
> ("test: hsr: Remove script code already implemented in lib.sh").
>=20
> This patch fixes it by re-setup the namespaces using
>=20
> 	setup_ns ns1 ns2 ns3
>=20
> command before "setup_hsr_interfaces 1". It deletes previous
> namespaces and create new ones.
>=20
> Fixes: 680fda4f6714 ("test: hsr: Remove script code already
> implemented in lib.sh") Reviewed-by: Hangbin Liu
> <liuhangbin@gmail.com> Signed-off-by: Geliang Tang
> <tanggeliang@kylinos.cn> ---
> v2:
>  - re-setup the namespaces as Hangbin suggested.
> ---
>  tools/testing/selftests/net/hsr/hsr_ping.sh | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh
> b/tools/testing/selftests/net/hsr/hsr_ping.sh index
> 790294c8af83..3684b813b0f6 100755 ---
> a/tools/testing/selftests/net/hsr/hsr_ping.sh +++
> b/tools/testing/selftests/net/hsr/hsr_ping.sh @@ -174,6 +174,8 @@
> trap cleanup_all_ns EXIT setup_hsr_interfaces 0
>  do_complete_ping_test
> =20
> +setup_ns ns1 ns2 ns3
> +
>  setup_hsr_interfaces 1
>  do_complete_ping_test
> =20


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_//x1Vo1wzjmAzVKYxRf+WmaX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmZXIwcACgkQAR8vZIA0
zr2JRQf+PBYEqgIH9Dg2V6mOTfPDJF/svHzEnJkf0xZMQw/je4zEvz4Muy+UH8sW
qgeBAizTxEy6pcCViVJU/vtxNIXgTzUwR8tEboEgO6H0Zd44WunHGY2IsD4JpIRq
ZnK55Z4REKx5RnaaD1Q4zj/gLQMsi88E86lZGULY7Zft83f9Xx4aIvQdr2KDZLYH
bvD2whwv5dVemkomM4mKTkAkGfU23YBueYMnRcypxbKPJKablf/y8eMm2/pzExgs
hqx9p93S8c2IEaabZmmiZUdC3+j2shBPQvkw3RAvIPcbB5EfkoRknCbwQ2f+wtRm
nVEsppIrQgNM/FO67tpmGC34uL2AQg==
=q6R/
-----END PGP SIGNATURE-----

--Sig_//x1Vo1wzjmAzVKYxRf+WmaX--

