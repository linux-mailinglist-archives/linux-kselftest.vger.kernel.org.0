Return-Path: <linux-kselftest+bounces-29622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B24A6D12B
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Mar 2025 22:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3CD16F683
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Mar 2025 21:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00E41A23A4;
	Sun, 23 Mar 2025 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="WB43qXFF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B454378F3A;
	Sun, 23 Mar 2025 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742764239; cv=none; b=G1VqT1Oxv4OjazDVnqwFvKjt5bMoXR3/ChE5pC72n+A5hyP1Qr1V/A4NDGYhbgHBGOPcjaBR47n5X87IPlM7bvj6QO1JIkwJS7j8BV9oZcoJ+RWoW1ew9iXq7T/CsjUiMD//psFesz3Cz03i8UbaWYdIv24my4AaKWkKcuvXFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742764239; c=relaxed/simple;
	bh=7LalIgnLlFdyiecmffWjKAQIo+gu1xd02ZJmfEqdekY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaadkTI1AVOemlrUEFKCdsUyE5NcHqDg9ISFf4uVSLJLpl9ydR+8TlB7TRwI4NRQ6vVketg62KWFVSATJuaizrurgrJdxa8ooHcxAakn5ZVlnLvpfjFTbknFb6EYqgwf041GcrCAfFdknIfsxQPzW9s8pUft7nBymPvmjCpSxWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=WB43qXFF; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/T/hpX5aJNmpqnR9NK2A+cGQ1FWYHUdQ6owTEm+NkC8=; b=WB43qXFFdYFHyR5t/uK9qx1+4L
	rMbG4BjFktbrOKNCnj0rC/+DPOXYzmEtUIZP9RNv1gl1enBQ2ZOY+sha3VxzkWbBDrLLAcv2iq40a
	vt+geQae7IZrwG8UDt+vcCJWt3K6tqcJdHbpkKItmmTmqgsJcQuZQifLJoL/oTrm0slRlCh45oaBr
	+mAretfpZExXb6pVCtyj9qaizsC2Vm4j1r8SguPSOs27ub2XVGg3az/oaW7z/e4dm5OkqOArKpntV
	Utr18Ccaf6xXXBs2PVB/WoCrnwI9rfF2tWX+VsgDnQ7m4jDDuKcYTeUaBX+JdMW51Zf3FwpRkUVO6
	sCwsJpnA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1twSaX-000000006Pj-16rX;
	Sun, 23 Mar 2025 22:10:33 +0100
Date: Sun, 23 Mar 2025 22:10:33 +0100
From: Phil Sutter <phil@nwl.cc>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 net-next 1/2] wireguard: selftests: convert iptables to
 nft
Message-ID: <Z-B4yfBvm2aXW_Ar@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250322093016.16631-1-liuhangbin@gmail.com>
 <20250322093016.16631-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322093016.16631-2-liuhangbin@gmail.com>

On Sat, Mar 22, 2025 at 09:30:15AM +0000, Hangbin Liu wrote:
> Convert iptabels to nft as it is the replacement for iptables, which is used
          ~~~~~~~~

Typo, but I would write "Convert the selftest to nft ..." instead since
that is what you're converting, iptables is just replaced. :)

> by default in most releases.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/wireguard/netns.sh | 29 ++++++++++++++--------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
> index 55500f901fbc..8b840fef90af 100755
> --- a/tools/testing/selftests/wireguard/netns.sh
> +++ b/tools/testing/selftests/wireguard/netns.sh
> @@ -75,6 +75,11 @@ pp ip netns add $netns1
>  pp ip netns add $netns2
>  ip0 link set up dev lo
>  
> +# init nft tables
> +n0 nft add table ip wgtest
> +n1 nft add table ip wgtest
> +n2 nft add table ip wgtest
> +
>  ip0 link add dev wg0 type wireguard
>  ip0 link set wg0 netns $netns1
>  ip0 link add dev wg0 type wireguard
> @@ -196,13 +201,14 @@ ip1 link set wg0 mtu 1300
>  ip2 link set wg0 mtu 1300
>  n1 wg set wg0 peer "$pub2" endpoint 127.0.0.1:2
>  n2 wg set wg0 peer "$pub1" endpoint 127.0.0.1:1
> -n0 iptables -A INPUT -m length --length 1360 -j DROP
> +n0 nft add chain ip wgtest INPUT { type filter hook input priority filter \; policy accept \; }

You may skip the 'policy accept \;' part in all 'add chain' commands as
this is the default for all chains. Unless you prefer to explicitly
state the chain policy, of course.

Cheers, Phil

