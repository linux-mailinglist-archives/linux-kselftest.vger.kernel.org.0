Return-Path: <linux-kselftest+bounces-35696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F663AE6C93
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 18:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941F71C22110
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3257C2E339E;
	Tue, 24 Jun 2025 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAeOARZV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010F626CE0D;
	Tue, 24 Jun 2025 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783107; cv=none; b=lRA/MbnRrWvqYJpkdHTy2nMsE4/qV/W0kBFGPRza/+6QIKj0feCL5y/XVHbo/rnt9b72ALVxbv3ThZ+ewW6de3cy9NZ/hu5gg0ux8vD7lTk4+VnJVhwywuF0BRR4ZT8XmuwZAgByL5iEAA7cqACu3NDZREvGbjdlq4Yyt7oucC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783107; c=relaxed/simple;
	bh=KgsDdKe3hPRmKASRX1tvEopcOOVxQEB9I5yYs6meOFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKwC6wgbXYVmjCVI4Jn6yzU2pQ0WBdGec6ExhJcmF1jK1cBIsSCjMFuWTrfNW7N5qflVA6JBsYkbFivLZSoXN4at1oEVkSuiOxZC42sU9svKW3pfdrP4wtonAcaxC7DieqZAc5kijCgjt0wz1sK5N0PBtz3McXfOm988iii2jMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAeOARZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC35CC4CEF2;
	Tue, 24 Jun 2025 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750783106;
	bh=KgsDdKe3hPRmKASRX1tvEopcOOVxQEB9I5yYs6meOFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gAeOARZVsL6lQWlK6TFQ12WU0ozheRG0RILxQ8Te18iiGYe587U8pKjaSKXakt3AE
	 TKpxhoUbHbqlXvJKjUX6qkSeZAFDYO8jUuUFH3TxY4hBoMHAxLhLGxh/6u5sh1pOcy
	 Ajlci+DIcXsQZgA+vVB3hVRZwOsj+lmk+Qwe4TMCTif6ep9IOUPv8TaF7IEhIZ7Est
	 O92jMVsdN2AeHJW5zmiqzA8S7yMxqqADnbNBBSP4YjfSntqR9qed38OjVpUNlTz4kJ
	 oI+9mcvEgT2f9TCibLHict2aU1evqW1tgv0k4YQT2zO09U7twpflqO89rFJWrt2Zxn
	 Zw8WqSYyqojRg==
Date: Tue, 24 Jun 2025 09:38:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, gustavold@gmail.com
Subject: Re: [PATCH net-next] selftests: net: add netpoll basic
 functionality test
Message-ID: <20250624093824.4c0dd380@kernel.org>
In-Reply-To: <aFq1z0BS6RCUCNwa@gmail.com>
References: <20250620-netpoll_test-v1-1-5068832f72fc@debian.org>
	<20250623183006.7c1c0cfc@kernel.org>
	<aFq1z0BS6RCUCNwa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Jun 2025 15:27:27 +0100 Breno Leitao wrote:
> > > +    try:
> > > +        for key, value in config_data.items():
> > > +            if DEBUG:
> > > +                ksft_pr(f"Setting {key} to {value}")
> > > +            with open(
> > > +                f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}/{key}",  
> > 
> > Could be personal preference but I think that using temp variable to
> > store the argument looks better than breaking out the function call
> > over 5 lines..  
> 
> I was not able to get what you mean here, sorry.
> 
> We have config_data, which is a dictionary that stores the netconsole
> keys (as in configfs) and their value, which will be set in the code below.
> 
> What would this temp variable look like, and how it would look like?

		path = f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}/{key}"
		with open(path, "r", encoding="utf-8") as f:
			...

> > > +def test_netpoll(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> None:
> > > +    """
> > > +    Test netpoll by sending traffic to the interface and then sending
> > > +    netconsole messages to trigger a poll
> > > +    """
> > > +
> > > +    target_name = generate_random_netcons_name()
> > > +    ifname = cfg.dev["ifname"]
> > > +    traffic = None
> > > +
> > > +    try:
> > > +        set_single_rx_tx_queue(ifname)
> > > +        traffic = GenerateTraffic(cfg)
> > > +        check_traffic_flowing(cfg, netdevnl)  
> > 
> > Any reason to perform this check? GenerateTraffic() already waits for
> > traffic to ramp up. Do we need to adjust the logic there, or make some
> > methods public?  
> 
> Not really. I can just remove this code, in fact, given
> GenerateTraffic() already waits for the code. Or, I can add under DEBUG.

Let's not put functional changes under DEBUG, just prints.
It could make it so that the test fails without DEBUG and passes with.

> As we discussed in the RFC thread, I will add support for bpftrace in
> the v2.

