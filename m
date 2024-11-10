Return-Path: <linux-kselftest+bounces-21734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E7B9C3030
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 01:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46363B20952
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 00:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C34946F;
	Sun, 10 Nov 2024 00:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyeXHKam"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C01611E;
	Sun, 10 Nov 2024 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731200349; cv=none; b=Sj+nU+UWogSsth4aG2UtGqE8gfU8GGJ0aoQYZuWfYnvBPzYnVIudSBG7rKDIO4o6L7IxPvCEMlmlZOeVjnDySWRGYP29CkTXzRPATj7tfXyM8g8F5go5mOOOIfEJrW1bdMMaOXzjsUghzoV1VkTAB6LV/P9Yo20EQxxsAdQ/7I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731200349; c=relaxed/simple;
	bh=eI4NrvYWCzY8jT56L2G03qeev6Tssv52JXBZuJzg/m8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTSy35RP0SeDvWZ5HpC069jtJpn9Q3Q+MyHfMDiPLwDnoohYbROlw+Cs8+NoljILYMAV9JBpNq+rpDcxePLTMTmiuK+mOhr3/i1zM+rYcmgXvRzgi2LgbT7F943DAQbLZQyn+ezmaOf2grX/GXBICO+aIrH3Jz0woLGhfOOiblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyeXHKam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E51C4CECE;
	Sun, 10 Nov 2024 00:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731200349;
	bh=eI4NrvYWCzY8jT56L2G03qeev6Tssv52JXBZuJzg/m8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cyeXHKamel7zxzso4MJjVcv5eVvRG2B/Z+PAXKIuoeqd8cQKPbFUatKQdtBBN8ePO
	 Ch3nVHLWTJVy9rRxVS1Iibvg4COShjE4vGJr6V68GXs7gy5S0ifjmSJdCGizq2kuFb
	 v/Xm5NWRNKPpQxSAI2uCFckuNdpJ2Ekf+erwEnoD+SvnY+8aoyVissres+tMpz+uC8
	 5+lzgXKHxlfHWBeHEEsU01zCfKGt7pHd4Kt8LYnLOg1bcuLgvFFTtxO7JzFMiRZFl5
	 tezmonZUao18zfVxkxBfie8praEh9a9vZ3wO/NAlxeGb1ssbenBSXhegPwTiQLUG77
	 w64VUKdFeZCfw==
Date: Sat, 9 Nov 2024 16:59:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Donald
 Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCH net-next v2 5/8] net: ip_gre: Add netns_atomic module
 parameter
Message-ID: <20241109165907.4e9611a9@kernel.org>
In-Reply-To: <CABAhCOSyG6sTWfDfoYDCbiXesDbGiWYFrK4OGi+3zFgO-CZPxA@mail.gmail.com>
References: <20241107133004.7469-1-shaw.leon@gmail.com>
	<20241107133004.7469-6-shaw.leon@gmail.com>
	<CANn89iLvC0H+eb1q1c9X6M1Cr296oLTWYyBhqTAyGW_BusHA_A@mail.gmail.com>
	<CABAhCOS8WUqOsPCzQFcgeJbz-mkEV92OVXaH3E1tFe7=HRiuGg@mail.gmail.com>
	<20241107075943.78bb160c@kernel.org>
	<CABAhCOSvhUZE_FE4xFsOimzVBQpQYLNk51uYNLw+46fibzfM2Q@mail.gmail.com>
	<20241107200410.4126cf52@kernel.org>
	<CABAhCOSyG6sTWfDfoYDCbiXesDbGiWYFrK4OGi+3zFgO-CZPxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Nov 2024 14:44:37 +0800 Xiao Liang wrote:
> > On Fri, 8 Nov 2024 00:53:55 +0800 Xiao Liang wrote:  
> > > IMO, this is about driver capability, not about user requests.  
> >
> > The bit is a driver capability, that's fine. But the question was how
> > to achieve backward compatibility. A flag in user request shifts the
> > responsibility of ensuring all services are compatible to whoever
> > spawns the interfaces. Which will probably be some network management
> > daemon.  
> 
> OK. So I think we can change the driver capability indicator in rtnl_ops
> to a tristate field, say, "linkns_support".
> If it is
>   - not supported, then keep the old behavior
>   - supported (vlan, macvlan, etc.), then change to the new behavior
>   - compat-mode (ip_tunnel), default to old behavior and can be changed
>     via an IFLA flag.
> Is this reasonable?

Let's start with annotating the drivers which need the old behavior.
It seems like something that was done as a workaround for old drivers,
maybe there isn't that many of them and we can convert them all in one
series.

