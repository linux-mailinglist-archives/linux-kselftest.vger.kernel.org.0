Return-Path: <linux-kselftest+bounces-9523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8266B8BD1A4
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 17:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AF81C223FF
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 15:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C91154C0A;
	Mon,  6 May 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="BEwZw+z+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D352F2C
	for <linux-kselftest@vger.kernel.org>; Mon,  6 May 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715009948; cv=none; b=sagMVL5oevK/6LH6D+kTa6xCG7vGX+j3Ea/6HBah1iz4Dd94ikpDI1sqhJk4DAaKYF3KY3YiJAQSy0/IZdYsJomfdlA+LdiYQGiUnFfo+BbyVbzrwax/KCpsRE2mjrJrEOM2Wrpj7CIxKng/332ZsdtIwYfNu2Szu62gZcfOca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715009948; c=relaxed/simple;
	bh=DnxwuoRJdwU0EK8YzdxglEJVZl4zYMCJBJmNeCyRKZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1pDVG6zU9SaOF8akSpnTz4nEWcVfPoxFkkm42JyflhmgtbJXj0N0p332z8KTNhChgoUWheFVNQ3J/vgAjS7R61gaauvEQwypLkvFUpfdPeszOzAFzV73t9/xRQIFhjSFPe91+Y3kKcRtCGxwfOVYuUIc1aUlL0Ty7H9M1XA7Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=BEwZw+z+; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 98ec550c-0bbe-11ef-93a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 98ec550c-0bbe-11ef-93a8-005056abbe64;
	Mon, 06 May 2024 17:37:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=QzxMfPdrMLsARpkjMh1WDjEpvWUOvqLCZoUmM/KqtcU=;
	b=BEwZw+z+Y1U0/WX10QCZvrbdL2acrp0YUkDmaeb7ql1iZI5/ZbzR/7bUmc3vPrCI6TWCY/hmc1kUq
	 SybcZjg/y7QgGEM6a7DJ6fwGFtrfeB+8/bTdsBitrGs7sEEiQVsHKiTOHP4pFMfIC4Zq01UPsq6zC+
	 MRGlKcDHGCWXWKoM=
X-KPN-MID: 33|W2NYngEXl0xLO1XPwqGEAMx6nwL7XDxAgHNJnX6mlnDudqQkmV5V448Uh6KWfDg
 kCEA0T5LRj4+bXnV2BC1S9AIbrXJrDjXot/Y0KZSm6OE=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|+RnBNADcfyOR1OrWqV101PniOZnmH6pArxf0AaHCVpILto3gR1DzXHYAuLMADGn
 ekmQO8ZA43asfXDmF5TY3YA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 9b467a53-0bbe-11ef-8130-005056ab1411;
	Mon, 06 May 2024 17:37:56 +0200 (CEST)
Date: Mon, 6 May 2024 17:37:54 +0200
From: Antony Antony <antony@phenome.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Shuah Khan <shuah@kernel.org>, devel@linux-ipsec.org
Subject: Re: [PATCH net-next v3 2/2] selftests/net: add ICMP unreachable over
 IPsec tunnel
Message-ID: <Zjj5UsGuaGGBni2N@Antony2201.local>
References: <cover.1714982035.git.antony.antony@secunet.com>
 <053f57d79058138d09a0e606c0500a40cb78596d.1714982035.git.antony.antony@secunet.com>
 <20240506062830.5d48ba48@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506062830.5d48ba48@kernel.org>

Hi Jakub,

On Mon, May 06, 2024 at 06:28:30AM -0700, Jakub Kicinski via Devel wrote:
> On Mon, 6 May 2024 10:05:54 +0200 Antony Antony wrote:
> > Add IPsec tunnel, aka xfrm state, tests with ICMP flags enabled.
> > IPv4 and IPv6, unreachable tests over xfrm/IPsec tunnels,
> > xfrm SA with "flag icmp" set.
> 
> Doesn't seem to work:

thanks. I am looking into it. I notice two issues.

 
> # selftests: net: xfrm_state.sh
> # ./xfrm_state.sh: line 91: test_: command not found
> # TEST: unreachable_ipv4IPv6 unreachable from router r3           [ FAIL ]

This appears to be an error from the v2 run, which was sent yesterday.
The v3 patch should have superseded it.

The branch net-dev-testing/net-next-2024-05-06--12-00 contains the v2 patch.
I wonder if net-dev testing recognized v3 patch.

git diff net-next-2024-05-06--12-00 net-next-2024-05-06--03-00 ./tools/testing/selftests/net/xfrm_state.sh
is missing the expected one line diff in  IFS.

> # ./xfrm_state.sh: line 91: test_: command not found
> # TEST: unreachable_gw_ipv6IPv6 unreachable from IPsec gateway s2 [ FAIL ]
> # ./xfrm_state.sh: line 91: test_: command not found
> # TEST: mtu_ipv6_r2IPv6 MTU exceeded from ESP router r2          [ FAIL ]
> # ./xfrm_state.sh: line 91: test_: command not found
> # TEST: mtu_ipv6_r3IPv6 MTU exceeded router r3                   [ FAIL ]
> not ok 1 selftests: net: xfrm_state.sh # exit=1

I suspect there is another another issue with 
tools/testing/selftests/net/config . It does not appear to support nftables 
match for ESP. Which this script assumes.

# ip netns exec ns_r2-39oUmE nft add rule inet filter FORWARD counter ip protocol esp counter log accept
#
# Error: Could not process rule: No such file or directory
# add rule inet filter FORWARD counter ip protocol esp counter log accept
#               ^^^^^^

I learning vng also. I will send v4 with change to config, then I hope the 
test runner will pick up the latest patch.

-antony

