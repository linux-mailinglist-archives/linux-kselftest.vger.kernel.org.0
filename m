Return-Path: <linux-kselftest+bounces-38016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F985B12A32
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 13:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B2E7AB927
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 10:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E463244668;
	Sat, 26 Jul 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6DKezq2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2985243378;
	Sat, 26 Jul 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753527597; cv=none; b=qfBSdUhQPb5ok0k53tf4Bx1y6GtLIfTQfAIlmzNPa7sFe6BqUhmSdSUYotNUwSNVWSoPe4NoPpCZzhqu22/n9fJGzGLy1XKOa6MCgKE9J4gf5KRTm2CzzbQcXBWZN5XGdUWxb34l6+ozScq9zws8IHtGtZ8oglkoXWER14DFjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753527597; c=relaxed/simple;
	bh=aahVRAZ7YarZYp+zx9UXAEqg4elOZxAbYpT4hg7EVDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+Xk7/tMNG8QjQstTP+A4f3dWIBzz3z88Sv0hvyjVqWYEHTzMEaHU/6D16a/Si0vUwmeuEFOqJLXdSZXodahEik8iwLi3KCfuoPB2gv28iLuZAGpShEMBen8IDEz4lDg8mDtqqTTDG2V/ArzWh3xlSzZs2Um4WLcabNKcsdGkbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6DKezq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B4BC4CEED;
	Sat, 26 Jul 2025 10:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753527596;
	bh=aahVRAZ7YarZYp+zx9UXAEqg4elOZxAbYpT4hg7EVDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6DKezq2/e+XlkoT2ywvE6ywBUdRS6+vyX/HWPxWy/MdYcvpseQuaivgi1OvGt6Jr
	 6EBhT7gA1dc5zxGqE0pU+PKHfBvPaHRqRZeBfp6CdXEoX1MNVTLMVKZgJzxr9wBaMF
	 /+acEn6HiHf4arPSAlQ2OeaSR8c8OXZ+Gr53q857424alouZQR1oqzGXikOLJwWnvh
	 wKZfVABhBv98666IFhqjqbf3wK538VvgUoxcqpevt2+uZapMgvt5jHAZTrWj3r4gW/
	 Uen9jrH452IhCHdW/YSDaP98Z6oowj5kg1Gewj3pPw7GoKRrywOrifH3dJZxIY9qLQ
	 5g4Nu7Zm2XE8w==
Date: Sat, 26 Jul 2025 11:59:51 +0100
From: Simon Horman <horms@kernel.org>
To: Yi Chen <yiche@redhat.com>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shuah@kernel.org, coreteam@netfilter.org, fw@strlen.de,
	Hangbin Liu <haliu@redhat.com>
Subject: Re: [PATCH net v2] selftests: netfilter: ipvs.sh: Explicity disable
 rp_filter on interface tunl0
Message-ID: <20250726105951.GJ1367887@horms.kernel.org>
References: <20250724080653.20723-1-yiche@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724080653.20723-1-yiche@redhat.com>

+ Hangbin

On Thu, Jul 24, 2025 at 04:06:53PM +0800, Yi Chen wrote:
> Although setup_ns() set net.ipv4.conf.default.rp_filter=0,
> loading certain module such as ipip will automatically create a tunl0 interface
> in all netns including new created ones. In the script, this is before than
> default.rp_filter=0 applied, as a result tunl0.rp_filter remains set to 1
> which causes the test report FAIL when ipip module is preloaded.
> 
> Before fix:
> Testing DR mode...
> Testing NAT mode...
> Testing Tunnel mode...
> ipvs.sh: FAIL
> 
> After fix:
> Testing DR mode...
> Testing NAT mode...
> Testing Tunnel mode...
> ipvs.sh: PASS
> 
> Fixes: 7c8b89ec506e ("selftests: netfilter: remove rp_filter configuration")
> 
> v2: Fixed the format of Fixes tag.
> Signed-off-by: Yi Chen <yiche@redhat.com>
> ---
>  tools/testing/selftests/net/netfilter/ipvs.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

For future reference, there should be no blank line between
the Fixes and other tags. And, version information should go
below the scissors ('---').

Something like this:

Fixes: ...
Signed-off-by: ...
--- 
 diffstat goes here

v2: Fixed the format of Fixes tag.

And it is ok to have multiple scissors ('---'), sometimes tooling does that.
The main point is that what is above the first scissors will, generally,
show up in Git history, while what is below won't. While everything ends
up in mailing list archives and so on.

Also, if you do end up posting a v3 for some reason.
Please consider correcting the spelling of Explicitly in the subject.
This is flagged by checkpatch.pl --codespell

And, please generate the CC list for patches using
get_maintainer.pl this.patch. Which will include people
involved in the commit cited in the Fixes tag.
I've CCed Hangbin, to follow that pattern.

The above notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> 
> diff --git a/tools/testing/selftests/net/netfilter/ipvs.sh b/tools/testing/selftests/net/netfilter/ipvs.sh
> index 6af2ea3ad6b8..9c9d5b38ab71 100755
> --- a/tools/testing/selftests/net/netfilter/ipvs.sh
> +++ b/tools/testing/selftests/net/netfilter/ipvs.sh
> @@ -151,7 +151,7 @@ test_nat() {
>  test_tun() {
>  	ip netns exec "${ns0}" ip route add "${vip_v4}" via "${gip_v4}" dev br0
>  
> -	ip netns exec "${ns1}" modprobe -q ipip
> +	modprobe -q ipip
>  	ip netns exec "${ns1}" ip link set tunl0 up
>  	ip netns exec "${ns1}" sysctl -qw net.ipv4.ip_forward=0
>  	ip netns exec "${ns1}" sysctl -qw net.ipv4.conf.all.send_redirects=0
> @@ -160,10 +160,10 @@ test_tun() {
>  	ip netns exec "${ns1}" ipvsadm -a -i -t "${vip_v4}:${port}" -r ${rip_v4}:${port}
>  	ip netns exec "${ns1}" ip addr add ${vip_v4}/32 dev lo:1
>  
> -	ip netns exec "${ns2}" modprobe -q ipip
>  	ip netns exec "${ns2}" ip link set tunl0 up
>  	ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.arp_ignore=1
>  	ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.arp_announce=2
> +	ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.tunl0.rp_filter=0
>  	ip netns exec "${ns2}" ip addr add "${vip_v4}/32" dev lo:1
>  
>  	test_service
> -- 
> 2.50.1
> 

