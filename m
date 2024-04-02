Return-Path: <linux-kselftest+bounces-7013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E95D89603E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 01:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D521F22BB7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 23:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54679626A0;
	Tue,  2 Apr 2024 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOz2VT5k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD6B47A7A;
	Tue,  2 Apr 2024 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101011; cv=none; b=LHldC0l+pjNqKTjTBHeaUnluHHBSSQ6xnDbXcec2vnTWbibXIfVeY78+z0fPZbiOETqE4LXZ1WX2j7zdAq5ZusY4Pgw9KM4HmjKZjti/icP8EXHf2f3IPKpJIQzV0bsLIZDpS9RItb/YlanySjL0HdMVuFakdAuwgxG+q2IDO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101011; c=relaxed/simple;
	bh=Dpyjy7FbNMVlaBP9LefRx5qTyMXKApH7CZ86AbTlxhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9EQw8hvoEps5cp28+QZLp9ez7oW3x3ldwK1RT2fVvAsVhFGfE2DxAmVkI5HdPMS3X/Z+ipP1s77+X5Foj1xcfTHGCVrr/8HpqJdkevrCo8lLv7hhvTfuy6AYhpSFwAhtY2iyEyH+zSo5gpNxSsVFo3/LNXJxcjwxJLgFRQ2y/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOz2VT5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA2EC43394;
	Tue,  2 Apr 2024 23:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712101010;
	bh=Dpyjy7FbNMVlaBP9LefRx5qTyMXKApH7CZ86AbTlxhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vOz2VT5kWvZXtN+BYpqYBB2Rn9eMgN4iRDfoFI3AdSqdcjwdYJLmsLdq7wEjOTGJ1
	 SaPlC8J+1s8XfU/t7nS3oCg81dM9VV16bqbiByEC4Ho0PfUY5W67Ljsx4wv3aID6Cx
	 zPeD90H3Bj5KAvhDO5kEsZ79xslKJCVOaT55BMn7tXGTTV8Af8wWEdfqKJ2ztC0hzB
	 9Ko8IljPtQ8JNrcRgODoL+Q2NmcOszyjWZbC7olZsqyrw0ihFwAAcHzoUXqixkC+/A
	 L2Y3bTSe5SacTsNJ6sk1fh/CC5pL6Kv8nsgSfX25lLCKgmYTEb8EB/0nxiQOW0V4no
	 i5wj/UXqra4og==
Date: Tue, 2 Apr 2024 16:36:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
 <donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 7/7] testing: net-drv: add a driver test for
 stats reporting
Message-ID: <20240402163649.4fdc2d3b@kernel.org>
In-Reply-To: <8734s3idys.fsf@nvidia.com>
References: <20240402010520.1209517-1-kuba@kernel.org>
	<20240402010520.1209517-8-kuba@kernel.org>
	<87bk6rit8f.fsf@nvidia.com>
	<20240402103111.7d190fb1@kernel.org>
	<8734s3idys.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 00:04:14 +0200 Petr Machata wrote:
> > Yes, I was wondering about that. It must be doable, IIRC 
> > the multi-threading API "injects" args from a tuple.
> > I was thinking something along the lines of:
> >
> >     with NetDrvEnv(__file__) as cfg:
> >         ksft_run([check_pause, check_fec, pkt_byte_sum],
> >                  args=(cfg, ))
> >
> > I got lazy, let me take a closer look. Another benefit
> > will be that once we pass in "env" / cfg - we can "register" 
> > objects in there for auto-cleanup (in the future, current
> > tests don't need cleanup)  
> 
> Yeah, though some of those should probably just be their own context
> managers IMHO, not necessarily hooked to cfg. I'm thinking something
> fairly general, so that the support boilerplate doesn't end up costing
> an arm and leg:
> 
>     with build("ip route add 192.0.2.1/28 nexthop via 192.0.2.17",
>                "ip route del 192.0.2.1/28"),
>          build("ip link set dev %s master %s" % (swp1, h1),
>                "ip link set dev %s nomaster" % swp1):
>         le_test()
>
> Dunno. I guess it makes sense to have some of the common stuff
> predefined, e.g. "with vrf() as h1". And then the stuff that's typically
> in lib.sh's setup() and cleanup(), can be losslessly hooked up to cfg.

I was thinking of something along the lines of:

def test_abc(cfg):
    cfg.build("ip route add 192.0.2.1/28 nexthop via 192.0.2.17",
              "ip route del 192.0.2.1/28")
    cfg.build("ip link set dev %s master %s" % (swp1, h1),
              "ip link set dev %s nomaster" % swp1)

optionally we could then also:

     thing = cfg.build("ip link set dev %s master %s" % (swp1, h1),
                       "ip link set dev %s nomaster" % swp1)

     # ... some code which may raise ...

     # unlink to do something else with the device
     del thing
     # ... more code ... 

cfg may not be best here, could be cleaner to create a "test" object,
always pass it in as the first param, and destroy it after each test.

> This is what I ended up gravitating towards after writing a handful of
> LNST tests anyway. The scoping makes it clear where the object exists,
> lifetime is taken care of, it's all ponies rainbows basically. At least
> as long as your object lifetimes can be cleanly nested, which admittedly
> is not always.

Should be fairly easy to support all cases - "with", "recording on
cfg/test" and del.  Unfortunately in the two tests I came up with
quickly for this series cleanup is only needed for the env itself.
It's a bit awkward to add the lifetime helpers without any users.

