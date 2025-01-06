Return-Path: <linux-kselftest+bounces-23948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBC5A02B3B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 16:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E085165A77
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF71A157E82;
	Mon,  6 Jan 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOPSfCMa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998888634A;
	Mon,  6 Jan 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178065; cv=none; b=d25exPetQmVx96KGb2FRR0HPiITVm+BBuiUMElkJQJ6AJz4Yf4686/s0iB4i1MisNIjn6cSYzdn9UXhX0Fnm3ZQTSqisMzWqs2BBEuFz5rHjPQEF3QMgYUKFs7W+a5INd0tkWsk04EdE11S0m3wIxA43btR4awrPE1x5Cn8jCy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178065; c=relaxed/simple;
	bh=YCndhVDLKZjnwTG8mS8bpu7KInGtrVYpRIQjzsUrScc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nf4vU/W7yibr37UOshfONghUVhckH+beO8uW4b3E3XRv4e2ftOxALSVU6a9OthWWpjWGeHQ3taXNA9Hg97XaCoS1Edbmt+QdytTm2ac1gbStv3+6FgZFcAI3lXTNUz+etGZwBKETWHk0w2a1Ig7TXW+5qjlqDhG/Fa0wUH0rcLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOPSfCMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37A3C4CED2;
	Mon,  6 Jan 2025 15:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736178065;
	bh=YCndhVDLKZjnwTG8mS8bpu7KInGtrVYpRIQjzsUrScc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aOPSfCMaBUyE5Mp3yTEdqD8rHHVEUGBW+ISrtUDD5/EXfWAU20J0iHQL4SiSSE94I
	 fe8GKtCJ4MtM1KQ6rWsDxeYR8MTDDDZwi6qhZCAJQdFZvXHP9e7bHbUwi2e0Y1O8JZ
	 qO2qlGX5CSuSgeWYxwpix7SFU6EbOmY/tP8UZNowDNwCqs7uIlhZxpTN6okaGTd0E8
	 eKtcJkcjSKFaK3jNo5uwBQjRHnGad2Ryy6+oWRxnvv+Y1jINMBY+pHMeM2f1IYr6QO
	 PAzHG/uWH27139UDwkoxnhTXe6o0v90A9rR4GgzpijTCsl5bEOuxhkwbpVW3fIm/xP
	 0dSSu8IiQ2XzA==
Date: Mon, 6 Jan 2025 07:41:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, willemb@google.com, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: test drivers sleeping in
 ndo_get_stats64
Message-ID: <20250106074104.7fdf837f@kernel.org>
In-Reply-To: <677aab862c9b3_15102629427@willemb.c.googlers.com.notmuch>
References: <20250105011525.1718380-1-kuba@kernel.org>
	<677aab862c9b3_15102629427@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Jan 2025 10:55:50 -0500 Willem de Bruijn wrote:
> Two tiny comments, neither cause for respin.

Let me respin, not much work since comment changes shouldn't need 
a re-test..

> > +@ksft_disruptive
> > +def procfs_downup_hammer(cfg) -> None:
> > +    """
> > +    Reading stats via procfs only holds the RCU lock, drivers often try
> > +    to sleep when reading the stats, or don't protect against races.
> > +    """
> > +    # Max out the queues, we'll flip between max an 1  
> 
> s/an/and/
> 
> > +    channels = ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
> > +    if channels['combined-count'] == 0:
> > +        rx_type = 'rx'
> > +    else:
> > +        rx_type = 'combined'
> > +    cur_queue_cnt = channels[f'{rx_type}-count']
> > +    max_queue_cnt = channels[f'{rx_type}-max']
> > +
> > +    cmd(f"ethtool -L {cfg.ifname} {rx_type} {max_queue_cnt}")
> > +    defer(cmd, f"ethtool -L {cfg.ifname} {rx_type} {cur_queue_cnt}")
> > +
> > +    # Real test stats
> > +    stats = __run_inf_loop("cat /proc/net/dev")
> > +    defer(stats.kill)
> > +
> > +    ipset = f"ip link set dev {cfg.ifname}"
> > +    defer(ip, f"link set dev {cfg.ifname} up")  
> 
> unimportant: could reference ipset here too, as in below.

Ha, that's what I did initially, but then running it I discovered
that ip() adds the initial "ip", so we end up executing:

 ip ip link set...
-- 
pw-bot: cr

