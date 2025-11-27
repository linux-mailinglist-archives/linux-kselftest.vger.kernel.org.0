Return-Path: <linux-kselftest+bounces-46636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2EEC8E2B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 13:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5316344137
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 11:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FD032E121;
	Thu, 27 Nov 2025 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6p6D/R8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC61932D0F3;
	Thu, 27 Nov 2025 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764244755; cv=none; b=u8xkC0s+dCgr+ocM9aAsgB8GrvWFXwXyu6k1DrLmtMjasYG6FUa4rFs678tSm4pDYISOfGTBHIoKfmCXS/kT9rhn+UNULSas4GfMyT+mOoBATUI2+7MZAUqBcI7ozpXHePX2PMTTRC81xyNBAT/kNqhUHSAXes/nc+aZ9vM91bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764244755; c=relaxed/simple;
	bh=2qB2eCl0eofbsnFLkh+Ilr9d7zdr+w4aA12A5by3Bdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtXZ/40Ok3pAccTm5+0dbN0i09Vv7+DSDSZNuwwuB1mAF2LRXi6fbIp00/Du5ZBcgHbBlKXsrcLtN/X2ZwHM+A9EA+y7r2EwPLZIK+7tdOHHyJRNCk/X+CpQJL9u7GU43A48mmabTSuvSc8Sfrqg0JSoA6tllKq0fRdn99b/0LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6p6D/R8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB51FC4AF09;
	Thu, 27 Nov 2025 11:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764244754;
	bh=2qB2eCl0eofbsnFLkh+Ilr9d7zdr+w4aA12A5by3Bdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6p6D/R8ZqqzaDSp4+inzrveJKOqEy+1LY5Uq7GgsrcK/Gk8p3gp66kBshTJkyx5w
	 92uEwSYZ1wd02R9B6ni+7MBbSLlm7RcaXd795ou70ajPjNRqR7BCHZYJE7vu5Ux2H+
	 RMUzdpS9pHvwpvbKBHahLTyw0sBgp+gMVFfi12Zqt19SinolKvB+gwR563iEXlTUOZ
	 wVItBOQPqZVtESc8sYYpc+SIiS426V7pCGO8pFkbSE2bGDpHrcuMbu/I89kLMlZU5m
	 yfDoXaSt/vBn2VIdsr29W8JkZ4tAXgrPxTdkfmNktHoMgd36c3riuy/Y8xPM3mPOxP
	 Gp24sf9Vn+SGA==
Date: Thu, 27 Nov 2025 11:59:09 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next] selftests: netfilter: nft_flowtable.sh: Add the
 capability to send IPv6 TCP traffic
Message-ID: <aSg9DbG4_NlLxEcy@horms.kernel.org>
References: <20251122-nft_flowtable-sh-ipv6-tcp-v1-1-4480d3c863a2@kernel.org>
 <aSgllQoIqNHIXqrs@horms.kernel.org>
 <aSg1MWLUx0GyCWij@lore-desk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSg1MWLUx0GyCWij@lore-desk>

On Thu, Nov 27, 2025 at 12:25:37PM +0100, Lorenzo Bianconi wrote:
> > On Sat, Nov 22, 2025 at 07:41:38PM +0100, Lorenzo Bianconi wrote:
> > > Introduce the capability to send TCP traffic over IPv6 to
> > > nft_flowtable netfilter selftest.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  .../selftests/net/netfilter/nft_flowtable.sh       | 47 +++++++++++++++-------
> > >  1 file changed, 33 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
> > > index 1fbfc8ad8dcdc5db2ab1a1ea9310f655d09eee83..24b4e60b91451e7ea7f6a041b0335233047c6242 100755
> > > --- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
> > > +++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
> > > @@ -127,6 +127,8 @@ ip -net "$nsr1" addr add fee1:2::1/64 dev veth1 nodad
> > >  ip -net "$nsr2" addr add 192.168.10.2/24 dev veth0
> > >  ip -net "$nsr2" addr add fee1:2::2/64 dev veth0 nodad
> > >  
> > > +ip netns exec "$nsr1" sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
> > > +ip netns exec "$nsr2" sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
> > >  for i in 0 1; do
> > >    ip netns exec "$nsr1" sysctl net.ipv4.conf.veth$i.forwarding=1 > /dev/null
> > >    ip netns exec "$nsr2" sysctl net.ipv4.conf.veth$i.forwarding=1 > /dev/null
> > > @@ -153,7 +155,9 @@ ip -net "$ns1" route add default via dead:1::1
> > >  ip -net "$ns2" route add default via dead:2::1
> > >  
> > >  ip -net "$nsr1" route add default via 192.168.10.2
> > > +ip -6 -net "$nsr1" route add default via fee1:2::2
> > >  ip -net "$nsr2" route add default via 192.168.10.1
> > > +ip -6 -net "$nsr2" route add default via fee1:2::1
> > >  
> > >  ip netns exec "$nsr1" nft -f - <<EOF
> > >  table inet filter {
> > > @@ -352,8 +356,9 @@ test_tcp_forwarding_ip()
> > >  	local nsa=$1
> > >  	local nsb=$2
> > >  	local pmtu=$3
> > > -	local dstip=$4
> > > -	local dstport=$5
> > > +	local proto=$4
> > > +	local dstip=$5
> > > +	local dstport=$6
> > >  	local lret=0
> > >  	local socatc
> > >  	local socatl
> > > @@ -363,12 +368,12 @@ test_tcp_forwarding_ip()
> > >  		infile="$nsin_small"
> > >  	fi
> > >  
> > > -	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsb" socat -4 TCP-LISTEN:12345,reuseaddr STDIO < "$infile" > "$ns2out" &
> > > +	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsb" socat -${proto} TCP${proto}-LISTEN:12345,reuseaddr STDIO < "$infile" > "$ns2out" &
> > 
> > Hi Lorenzo,
> > 
> > Some minor nits:
> > 
> > 1. This line is (and was) excessively long.
> >    Maybe it can be addressed as the line is being modified anyway.
> > 
> >    Flagged by checkpatch
> > 
> > 2. Prior to this patch, variables on this line were enclosed in "" to
> >    guard against word splitting when expansion occurs.
> >    This is no longer the case.
> > 
> >    Flagged by shellcheck
> > 
> > >  	lpid=$!
> > >  
> > >  	busywait 1000 listener_ready
> > >  
> > > -	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsa" socat -4 TCP:"$dstip":"$dstport" STDIO < "$infile" > "$ns1out"
> > > +	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsa" socat -${proto} TCP${proto}:"$dstip":"$dstport" STDIO < "$infile" > "$ns1out"
> > >  	socatc=$?
> > 
> > Likewise here.
> > 
> > >  
> > >  	wait $lpid
> > 
> > Otherwise this LGTM.
> 
> Hi Simon,
> 
> ack, fine. Is it ok to address them in subsequent patch or do you prefer to
> address them here?

Hi Lorenzo,

No preference on my side.
And feel free to include the following either way.

Reviewed-by: Simon Horman <horms@kernel.org>

> @Pablo: what do you prefer?

