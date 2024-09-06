Return-Path: <linux-kselftest+bounces-17391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC8396F403
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 14:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCDF1F2520A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034121CBEBF;
	Fri,  6 Sep 2024 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ei0Zyt9S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D041C8FC7;
	Fri,  6 Sep 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624517; cv=none; b=BByqTdtNaOY1cuVM7fBxxBu7AVge5bDuwAccrLtzyvv5/WSLFzrUZLi53clhYWN/O2gw0PAb2wCVcgmAyqAYKcP2A3IfGh4jWKXIO6yLJUfwzVKVjVt70XWaQlNxbHvT/jQBjXm9V36rIMUQ1VYpGbmOfQn0h6Oa0UaviPasptE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624517; c=relaxed/simple;
	bh=+MltUoWtkDA31pBLxthIt+jGiMrHeqKRG8qfBB6Vjaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCwpIL0a8rdtPPU9iq9c7NP4XIqpD2jYJg0T44VBUkwyEvpVNDwMJcdICZk1AT0ws+LHeD2Po2jSriOEdBDvlseWjDJOdY1fIGADKIwVrP4el72o9hyvs4bEdPoHQtaz0YZ4pTFJBv/Kl4q7EbaoN96kkY5OQqY3SpktFtqbI8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ei0Zyt9S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9zOz1zuie0KWW0qaT3+I6qA7SK5UR5Fwx0qGChaoev8=; b=ei0Zyt9SugeLTsg2K8xLm9IiyD
	U63nUz0mBIfJvBdITFB8AQGnyspXD8kcVv5nHZ3F9N9SAcEg3iNNYtuw9bEW0KEoXclH8ftbQkdz5
	r/4F0kK3WszLBsr7tZlJVwxgYtcSOnnbm5lxyxcZeaQR8+gCVA7m39ssdLgF42J5zq8M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smXlM-006nqR-CT; Fri, 06 Sep 2024 14:08:28 +0200
Date: Fri, 6 Sep 2024 14:08:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohan.Prasad@microchip.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	shuah@kernel.org, Bryan.Whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, horms@kernel.org,
	brett.creeley@amd.com, rosenp@gmail.com
Subject: Re: [PATCH net-next 0/3] lan743x: This series of patches are for
 lan743x driver testing
Message-ID: <96e017b8-3702-4b39-a44f-91c8b4ebec89@lunn.ch>
References: <20240903221549.1215842-1-mohan.prasad@microchip.com>
 <7cbdcb2b-37d8-45b6-8b4e-2ab7e7850a38@lunn.ch>
 <DM6PR11MB4236D1B92E9FDF1A4640DA68839E2@DM6PR11MB4236.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4236D1B92E9FDF1A4640DA68839E2@DM6PR11MB4236.namprd11.prod.outlook.com>

On Fri, Sep 06, 2024 at 06:45:53AM +0000, Mohan.Prasad@microchip.com wrote:
> Hello Andrew,
> 
> Thank you for your review comments.
> 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> > content is safe
> > 
> > On Wed, Sep 04, 2024 at 03:45:46AM +0530, Mohan Prasad J wrote:
> > > This series of patches are for testing the lan743x network driver.
> > > Testing comprises autonegotiation, speed, duplex and throughput checks.
> > > Tools such as ethtool, iperf3 are used in the testing process.
> > > Performance test is done for TCP streams at different speeds.
> > 
> > What is specific to lan743x? Why won't the autoneg test work for any
> > interface which says it supports autoneg? Is duplex somehow special on the
> > lan743x?
> > 
> > Where possible, please try to make these tests generic, usable on any NIC. Or
> > clearly document why they cannot be generic.
> > 
> 
> As suggested, I will change the testcases to generic form and document them accordingly in the next version.

Great.

How much time do you have?

ethtool eth0
Settings for eth0:
	Supported ports: [ TP	 MII ]
	Supported link modes:   10baseT/Half 10baseT/Full
	                        100baseT/Half 100baseT/Full
	                        1000baseT/Half 1000baseT/Full
	Supported pause frame use: Symmetric Receive-only
	Supports auto-negotiation: Yes
	Supported FEC modes: Not reported
	Advertised link modes:  10baseT/Half 10baseT/Full
	                        100baseT/Half 100baseT/Full
	                        1000baseT/Half 1000baseT/Full
	Advertised pause frame use: Symmetric Receive-only
	Advertised auto-negotiation: Yes
	Advertised FEC modes: Not reported
	Link partner advertised link modes:  10baseT/Half 10baseT/Full
	                                     100baseT/Half 100baseT/Full
	                                     1000baseT/Full

You can see that both the local device and the peer support
auto-neg. You can see what link modes both the local and peer
supports. The local device has 1000BaseT/Half where the peer does not,
which is reasonably common. So you could use this as a basis for the
test, ensurer 5 link modes do pass auto-neg, and one fails.

If you can, please try to avoid hard coding any link modes. There will
be some data centre NICs with a lowest speed to 10GBaseX, for example.
There are some automotive devices with 10BaseT-1L which does not
support autp-neg etc. It would be nice if the test could be used on
any interface and the test will decide itself what can be tested, or
if it should skip everything?

And by the way, thanks for working on tests. We need more people like
you contributing to them.

	Andrew

