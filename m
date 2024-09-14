Return-Path: <linux-kselftest+bounces-17978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44534978F4D
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 11:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 762DDB24633
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 09:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108F914830D;
	Sat, 14 Sep 2024 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+5Sbrn9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F710E9;
	Sat, 14 Sep 2024 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726304398; cv=none; b=OSRD5wUSQG2QkfHE6Mu/iX3DJNwvIvAn0E2+52zNG/0hZntrntq2g9o+E9xytw/Q8xmUefQSVCfwim1ol1IHhX0YWk991III6WTFyDJVNC5LaTfrUPThW2gvcerLWulgYNf1Ikv11GUUDnEzUN28IBW5bctPbRtXe4EIocDTEio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726304398; c=relaxed/simple;
	bh=Lx4Uayf2bZvoedX3/yhCtCijyNoRRWxNLVzsgVEa+sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mq/HqeFvCczP+A9g67m8JnMSbrm09xsuxXebZrAmwK7WF0eH43FNf7nR/RUm8yLh+hCqU6Y/9Qi0Xe+fyRT2svXau0FO3LJR6OQJdPBLmAdJb5uuoLKJ7/BwyWnIAbYk7Hvq4yckrcv6mVik48bu/noU4kdQlzV2hPJmYF3M1PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+5Sbrn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7420FC4CEC0;
	Sat, 14 Sep 2024 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726304397;
	bh=Lx4Uayf2bZvoedX3/yhCtCijyNoRRWxNLVzsgVEa+sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+5Sbrn9GRSU609E9s8t5X48RYczSb1qlH6knHFzSwzS/aKA/7aQE3FJFWRO6mbIB
	 5O11H7pbI/yR4FI/vA+Tr3lR8y7CjA9q6WGW8eFeaouS90j7cnehlB0AzLOIhqKF1D
	 +oLg8kp2ya62DPCFxVxj3pNstfOGfJVb7SdD9n7LUscORddDftDpfp6OFOGAVLIe8i
	 bgfusueeOSH3HWZ2/vVPy1/jy+b0Z8qtk4pwwgIC89j0YYtK597GGkjYkEOyJ/9oww
	 zh5NSo0GjoZlOdGnFWiWzwySzq7l28DndZWwWfDeXvJMr49KlKmi1loaptgdOTpt1+
	 vdqQqWJSglP0g==
Date: Sat, 14 Sep 2024 09:59:50 +0100
From: Simon Horman <horms@kernel.org>
To: Tiago Lam <tiagolam@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>, kernel-team@cloudflare.com
Subject: Re: [RFC PATCH 2/3] ipv6: Run a reverse sk_lookup on sendmsg.
Message-ID: <20240914085950.GC12935@kernel.org>
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
 <20240913-reverse-sk-lookup-v1-2-e721ea003d4c@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913-reverse-sk-lookup-v1-2-e721ea003d4c@cloudflare.com>

On Fri, Sep 13, 2024 at 10:39:20AM +0100, Tiago Lam wrote:
> This follows the same rationale provided for the ipv4 counterpart, where
> it now runs a reverse socket lookup when source addresses and/or ports
> are changed, on sendmsg, to check whether egress traffic should be
> allowed to go through or not.
> 
> As with ipv4, the ipv6 sendmsg path is also extended here to support the
> IPV6_ORIGDSTADDR ancilliary message to be able to specify a source

Hi Tiago Lam,

Some minor nits from my side.

ancilliary -> ancillary

Likewise in patch 3/3.
Flagged by checkpatch.pl --codespell

> address/port.
> 
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
> ---
>  net/ipv6/datagram.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  net/ipv6/udp.c      |  8 ++++--
>  2 files changed, 82 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> index fff78496803d..4214dda1c320 100644
> --- a/net/ipv6/datagram.c
> +++ b/net/ipv6/datagram.c
> @@ -756,6 +756,27 @@ void ip6_datagram_recv_ctl(struct sock *sk, struct msghdr *msg,
>  }
>  EXPORT_SYMBOL_GPL(ip6_datagram_recv_ctl);
>  
> +static inline bool reverse_sk_lookup(struct flowi6 *fl6, struct sock *sk,
> +				     struct in6_addr *saddr, __be16 sport)
> +{
> +	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
> +	    (saddr && sport) &&
> +	    (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, saddr) || inet_sk(sk)->inet_sport != sport)) {

Please consider, where it can trivially be achieved, limiting Networking
code to 80 columns wide.

Checkpatch can be run with a flag to check for this.

> +		struct sock *sk_egress;
> +
> +		bpf_sk_lookup_run_v6(sock_net(sk), IPPROTO_UDP, &fl6->daddr, fl6->fl6_dport,
> +				     saddr, ntohs(sport), 0, &sk_egress);
> +		if (!IS_ERR_OR_NULL(sk_egress) &&
> +		    atomic64_read(&sk_egress->sk_cookie) == atomic64_read(&sk->sk_cookie))
> +			return true;
> +
> +		net_info_ratelimited("No reverse socket lookup match for local addr %pI6:%d remote addr %pI6:%d\n",
> +				     &saddr, ntohs(sport), &fl6->daddr, ntohs(fl6->fl6_dport));
> +	}
> +
> +	return false;
> +}
> +
>  int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
>  			  struct msghdr *msg, struct flowi6 *fl6,
>  			  struct ipcm6_cookie *ipc6)

...

