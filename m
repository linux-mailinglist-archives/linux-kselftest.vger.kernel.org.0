Return-Path: <linux-kselftest+bounces-14913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BCD949EC7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 06:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6C2B21312
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 04:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1DD18FDDB;
	Wed,  7 Aug 2024 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddrroFdY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB472D7BF;
	Wed,  7 Aug 2024 04:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723003973; cv=none; b=Y6ZsNUoQawVzSrRiqI0xWUa+zGOn405ymtDjaGRZNga0AHXZ9a/qPtlq0YWDlCK7V6IZu80e+5lM5+CcUi9s/rD2Y5Ycfu0LcXUkatcL0Q2xSw+8wd7T/gQq5LQbqq2Gj5YTM35dcEiiLwuKRzzS3cUpE6Rtn7n1JF/DULYLBe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723003973; c=relaxed/simple;
	bh=e3w7Tv9RVOWiTbR8VTSVCaCJTczDbNY9MtMB3hA3reE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I6MS0G6OGLTYggwM6Azndp94mueuSRC9X8V9Ssbpn2VHUr0srW0gn5J0KKb75cwKB/4ZTbgAhd5OMd+A6/Ba/loH98NWDZ18WRlAg33WGywqU7aJ968q9aCh2/wQdpYXLy5U/pC1achzuTee+4FO3yZrXJ57cnbEE/3L2Moe4ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddrroFdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2045C32782;
	Wed,  7 Aug 2024 04:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723003973;
	bh=e3w7Tv9RVOWiTbR8VTSVCaCJTczDbNY9MtMB3hA3reE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ddrroFdYxJov15J3jglu0vX4f5Q2a1Pn7TcOy5fSxa61XRkvmxfkhUuBA0M3gMGaq
	 yqNVa2LtIOaH3blI/xxntjf4W4ICodJlQG5J5C+GUUQ+Xu10VbnRC+oEOxQg7W2+ZR
	 rEzNkR6YhqtzpKY99SHvdy00fmosXYhqFESjGyJVhrT8ZtoOy484uato5Xrk88lvYx
	 Dh3XFfQV1l0IeX6w1mHCai/2rPKdJxGmNwMOSgWY4lE+fYa4BY30Aq97q1v3Pux9Kz
	 u/w7oFcC+XqMRArIgRwrnTaBoRArPYmOyI4oKxu0IEIQKP46fYi4Z6kREADeKAdF+s
	 HZ55C3Z69PkFA==
Message-ID: <b101e751984e3064e67f870515f6ab550c7f0d09.camel@kernel.org>
Subject: Re: [PATCH net-next] selftests: forwarding: lib.sh: ignore "Address
 not found"
From: Geliang Tang <geliang@kernel.org>
To: nicolas.dichtel@6wind.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>, Petr Machata
 <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,  Benjamin Poirier
 <bpoirier@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko
 <jiri@resnulli.us>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Wed, 07 Aug 2024 12:12:47 +0800
In-Reply-To: <3bcdec5a-a93c-45c4-83a1-e941a39cf1fd@6wind.com>
References: 
	<764585b6852537a93c6fba3260e311b79280267a.1722917654.git.tanggeliang@kylinos.cn>
	 <3bcdec5a-a93c-45c4-83a1-e941a39cf1fd@6wind.com>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-08-06 at 09:34 +0200, Nicolas Dichtel wrote:
> Le 06/08/2024 à 06:20, Geliang Tang a écrit :
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > So many "Address not found" messages occur at the end of forwarding
> > tests
> > when using "ip address del" command for an invalid address:
> > 
> > TEST: FDB limits interacting with FDB type local                   
> > [ OK ]
> > Error: ipv4: Address not found.
> > 
> > ... ...
> > TEST: IGMPv3 S,G port entry automatic add to a *,G port            
> > [ OK ]
> > Error: ipv4: Address not found.
> > Error: ipv6: address not found.
> > 
> > ... ...
> > TEST: Isolated port flooding                                       
> > [ OK ]
> > Error: ipv4: Address not found.
> > Error: ipv6: address not found.
> > 
> > ... ...
> > TEST: Externally learned FDB entry - ageing & roaming              
> > [ OK ]
> > Error: ipv4: Address not found.
> > Error: ipv6: address not found.
> > 
> > This patch gnores these messages and redirects them to /dev/null in
> typo: s/gnores/ignores or 'hides'

It is indeed a typo. Thanks for pointing it out. Will update this in
v2.

-Geliang

> 
> Nicolas
> 
> > __addr_add_del().
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  tools/testing/selftests/net/forwarding/lib.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh
> > b/tools/testing/selftests/net/forwarding/lib.sh
> > index ff96bb7535ff..8670b6053cde 100644
> > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > @@ -839,7 +839,7 @@ __addr_add_del()
> >  	array=("${@}")
> >  
> >  	for addrstr in "${array[@]}"; do
> > -		ip address $add_del $addrstr dev $if_name
> > +		ip address $add_del $addrstr dev $if_name &>
> > /dev/null
> >  	done
> >  }
> >  


