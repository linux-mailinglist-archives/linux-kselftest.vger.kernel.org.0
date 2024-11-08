Return-Path: <linux-kselftest+bounces-21653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D599C1510
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 05:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DAD28218D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 04:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6642D126BE1;
	Fri,  8 Nov 2024 04:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZe/Ce91"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A79D28F1;
	Fri,  8 Nov 2024 04:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731038652; cv=none; b=MBYayT//Ckfd8zVBdf6nbdM9bKyS4qCJcFWCOO/D4DxZl+SqVc0btwcpyAJSUsnWnYRtOz3EIzLicRT01IYn2zFpAC4OMy8QeYuBB3PFtLOAtnelXt2DUxgIL8aNtbltaRaXRq5lYsS3wVashEj2NeWVvXUVx+w2b/Lc4K10xz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731038652; c=relaxed/simple;
	bh=bWuuRY9NEvwbGjyPMhgx3g0NP6egwrCWRhrBP75pKS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1jpZFMUwW9tbHBGeteD01o6lLb50KKmAHJK50B/6FXx8jHjpv73ac3daldbwCmOrOX9Mcdb9NWNDkeifa/rCWFRSRuatHLlpKTVwJsrO66DgevAFV4AAkYSq+n+VU5c4jglZIJw56X+3z3qmGIdlGMal7dgeshiuvMFf3zDZck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZe/Ce91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC92C4CECF;
	Fri,  8 Nov 2024 04:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731038651;
	bh=bWuuRY9NEvwbGjyPMhgx3g0NP6egwrCWRhrBP75pKS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SZe/Ce91v6xesjozh08KLQuI65LGkk5k8tHtp//ezcR46Pk1h16Pa60MliBVxKWRY
	 NhOVHyMRiySayi7b+AhLE1soGcPJmNoP0/fDqtTo9LjAt8SR4zEWDZEHJaNd8YeWlo
	 ZXUnHEluQ7KW6JlirXb46M3iG7fzVYI/WeWcs+iig4tBt6toqhYRl+2SSJVv+n1894
	 yeekbjB99T9OMp/gixNJ4G6D4Ml3SmORtFqTq0b6iSewP7+ZAhA2UZ54ZutIzpGtSv
	 ZkKMJwRxe1wwB39rD+3MT3W9mkAs5xO9uRkZR/o6GAsd+9/YZPoJ37BpAMYyETDTUt
	 XW6usm1XsmshA==
Date: Thu, 7 Nov 2024 20:04:10 -0800
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
Message-ID: <20241107200410.4126cf52@kernel.org>
In-Reply-To: <CABAhCOSvhUZE_FE4xFsOimzVBQpQYLNk51uYNLw+46fibzfM2Q@mail.gmail.com>
References: <20241107133004.7469-1-shaw.leon@gmail.com>
	<20241107133004.7469-6-shaw.leon@gmail.com>
	<CANn89iLvC0H+eb1q1c9X6M1Cr296oLTWYyBhqTAyGW_BusHA_A@mail.gmail.com>
	<CABAhCOS8WUqOsPCzQFcgeJbz-mkEV92OVXaH3E1tFe7=HRiuGg@mail.gmail.com>
	<20241107075943.78bb160c@kernel.org>
	<CABAhCOSvhUZE_FE4xFsOimzVBQpQYLNk51uYNLw+46fibzfM2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Nov 2024 00:53:55 +0800 Xiao Liang wrote:
> > > It is to control driver behavior at rtnl_ops registration time. I
> > > think rtnetlink
> > > attributes are too late for that, maybe? Can't think of a way other than
> > > module parameters or register separate ops. Any suggestions?  
> >
> > Step back from the implementation you have a little, forget that there
> > is a boolean in rtnl_link_ops. User makes a request to spawn an
> > interface, surely a flag inside that request can dictate how the netns
> > attrs are interpreted.  
> 
> IMO, this is about driver capability, not about user requests.

The bit is a driver capability, that's fine. But the question was how
to achieve backward compatibility. A flag in user request shifts the
responsibility of ensuring all services are compatible to whoever
spawns the interfaces. Which will probably be some network management
daemon.

> As you've pointed out earlier, probably no one would actually want
> the old behavior whenever the driver supports the new one.
> I added the module parameter just for compatibility, because ip_tunnels
> was not implemented to support src_net properly.

And I maintain that it's very unlikely anyone cares about old behavior.
So maybe as a starting point we can have neither the flag nor the
module param? We can add them later if someone screams.

> Yes it's possible to add an extra flag in user request, but I don't
> think it's a good approach.

There are two maintainers with opposing intuition so more data may be
needed to convince..

> BTW, I didn't find what's going on with module parameters, is there
> any documentation?

Not sure if there is documentation, but module params are quite painful
to work with. Main reason is that they are global and not namespace
aware. Plus developers usually default to making them read only, which
means they practically speaking have to be configured at boot.

