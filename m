Return-Path: <linux-kselftest+bounces-9565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178438BD857
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 01:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5D81C2243B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 23:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2F415D5AB;
	Mon,  6 May 2024 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+w8Vt69"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D372C132C1C;
	Mon,  6 May 2024 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715039974; cv=none; b=FheP8uzpFDzpgiFzgzk7MNsw+3yEd8rD165qw2DDjLUCMjpMsxLU4UhjZy8CUKb+8HqbSqNObY/xmDogzQ7Y85STD4MMwzqab+NydxEAMbbW2s53fPi4++AY5kXTuXvYeF2Dc30hKxeI0nfjHMDbMUmTusBwdlWPxmJOIH/gCm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715039974; c=relaxed/simple;
	bh=7vk9cTjtMnO3Pvi7Uq319MbT5BAB9SZRUYJaPr0XT3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ujin0JTK7qcT8eRigbmmcyR7+sF8nLD+nztLGyuLjW36733MBNRc/p+Way3zTVbv7vQLj0lltC/GrBi45wcS33St/6Kpj0lAlsuaM9vLrvLs2nu7uhEgF0jQQDsMIuRVNzgpM1LAh4Uke5cADQbIjd/NR2svyZG4lSzVDMUKalo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+w8Vt69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26D3C116B1;
	Mon,  6 May 2024 23:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715039974;
	bh=7vk9cTjtMnO3Pvi7Uq319MbT5BAB9SZRUYJaPr0XT3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s+w8Vt69zAcuO4OXJnY1Jeo9IhXsB6GPi7V/2GVdist0TkGHuNGHvz/RJPSNB6+n6
	 myllvOTL6LJSLJ8XGVf+8GPnV9z9lkpE5ObUV2MSR9wDIYdg9/bPE5rusL+bxt4PCv
	 fQY2dcKucyr/th7edUs4wlkjdLjNjxxsk7G31iGqli4lnwf+VwwfLIMFcevi5PqH25
	 njUM5w5Hc0Fm8HcTwOnSZCkKUfOfLsI9WWiuTqehQjfjWBusGMTlUtxMZqPSwB+QSp
	 DhIG6drJ4dgcex6eq8qwoQwgLsQb39+9vnQPfhRbW1cwuN431JC4jDc+k2xLyUP66N
	 W4xXRdvByZm8A==
Date: Mon, 6 May 2024 16:59:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antony Antony <antony@phenome.org>
Cc: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
 <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Shuah
 Khan <shuah@kernel.org>, devel@linux-ipsec.org
Subject: Re: [PATCH net-next v3 2/2] selftests/net: add ICMP unreachable
 over IPsec tunnel
Message-ID: <20240506165932.06dd9e5a@kernel.org>
In-Reply-To: <Zjj5UsGuaGGBni2N@Antony2201.local>
References: <cover.1714982035.git.antony.antony@secunet.com>
	<053f57d79058138d09a0e606c0500a40cb78596d.1714982035.git.antony.antony@secunet.com>
	<20240506062830.5d48ba48@kernel.org>
	<Zjj5UsGuaGGBni2N@Antony2201.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 6 May 2024 17:37:54 +0200 Antony Antony wrote:
> This appears to be an error from the v2 run, which was sent yesterday.
> The v3 patch should have superseded it.
>=20
> The branch net-dev-testing/net-next-2024-05-06--12-00 contains the v2 pat=
ch.
> I wonder if net-dev testing recognized v3 patch.

You're right! I guess the pw-bot didn't discard v2 because of=20
the capitalization change in the subject of the cover letter.

> git diff net-next-2024-05-06--12-00 net-next-2024-05-06--03-00 ./tools/te=
sting/selftests/net/xfrm_state.sh
> is missing the expected one line diff in  IFS.
>=20
> > # ./xfrm_state.sh: line 91: test_: command not found
> > # TEST: unreachable_gw_ipv6IPv6 unreachable from IPsec gateway s2 [ FAI=
L ]
> > # ./xfrm_state.sh: line 91: test_: command not found
> > # TEST: mtu_ipv6_r2IPv6 MTU exceeded from ESP router r2          [ FAIL=
 ]
> > # ./xfrm_state.sh: line 91: test_: command not found
> > # TEST: mtu_ipv6_r3IPv6 MTU exceeded router r3                   [ FAIL=
 ]
> > not ok 1 selftests: net: xfrm_state.sh # exit=3D1 =20
>=20
> I suspect there is another another issue with=20
> tools/testing/selftests/net/config . It does not appear to support nftabl=
es=20
> match for ESP. Which this script assumes.
>=20
> # ip netns exec ns_r2-39oUmE nft add rule inet filter FORWARD counter ip =
protocol esp counter log accept
> #
> # Error: Could not process rule: No such file or directory
> # add rule inet filter FORWARD counter ip protocol esp counter log accept
> #               ^^^^^^
>=20
> I learning vng also. I will send v4 with change to config, then I hope th=
e=20
> test runner will pick up the latest patch.

=F0=9F=91=8D=EF=B8=8F

