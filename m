Return-Path: <linux-kselftest+bounces-18105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A047B97BBE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 14:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42731C21B16
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 12:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3B417DE35;
	Wed, 18 Sep 2024 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2aVeggtd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731983C3C;
	Wed, 18 Sep 2024 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726661152; cv=none; b=qXqmv7VC2AyLUgg7VLtx95QlyiE4Ty09jjVLAiA7CYTlH56+JsOwRAItxV8Co7gpVNEWRiOYB09or/sp3cuVmH+JEdLtNepcPbAaUui3gvS/tYHAI6L42gr14ReV1FRPCzAPNevsM53fe7gsux4xs/iq94k53pkl7+ZCklcMq/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726661152; c=relaxed/simple;
	bh=0wCH4uv3redhEcHHuYiuzuM7Rdny48XwywXOBm7vI6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddrZx0O0OR7kFJNijSwT/+725cP8eHJbSebhdYsq7EAxZcKRYUO11ibsBUo+YTpptkMxDnowUjZOxLt6RYb8EZOYm0W+g5MORLHtSqFIjRujwqDQWCsTgOc4Sgrogap788M/1BZN0Gp7FoEsnZRpaIrWDPOYKtljVO7ePdkMoo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2aVeggtd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WpIM5EuhtQd3n5jXwIDdy7KPR5nYcbunBzw5fio2hHo=; b=2aVeggtdlWwKf+bnHgugnsiFPW
	aCnJ8m2UdLUvgK8FAE2KvX6fzIaLXFraLMTBC46plSl0ipxD9BKD+kzN8RBb4oCFHaRvqFPOBvbta
	e/HU8tN+1JBw4ndQs7w7PZvkSXbfrT0n16z5CZZVivS4Usk+QrTFsjYMGzMLYXr+UOaE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sqtR8-007iDk-HI; Wed, 18 Sep 2024 14:05:34 +0200
Date: Wed, 18 Sep 2024 14:05:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohan.Prasad@microchip.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	horms@kernel.org, brett.creeley@amd.com, rosenp@gmail.com,
	UNGLinuxDriver@microchip.com, willemb@google.com
Subject: Re: [PATCH net-next v2 1/3] selftests: nic_basic_tests: Add selftest
 file for basic tests of NIC
Message-ID: <0d6c225e-358b-401e-a4aa-a1f7ea0f2652@lunn.ch>
References: <20240917023525.2571082-1-mohan.prasad@microchip.com>
 <20240917023525.2571082-2-mohan.prasad@microchip.com>
 <5c8779db-31c4-4b93-986a-bd489720fa4b@lunn.ch>
 <DM6PR11MB4236AE79E97B4CBBA1A9812F83622@DM6PR11MB4236.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4236AE79E97B4CBBA1A9812F83622@DM6PR11MB4236.namprd11.prod.outlook.com>

> > Since you have batteries included python:
> > 
> > ethtool --json enp2s0
> > [sudo] password for andrew:
> > [ {
> >         "ifname": "enp2s0",
> >         "supported-ports": [ "TP","MII" ],
> >         "supported-link-modes": [
> > "10baseT/Half","10baseT/Full","100baseT/Half","100baseT/Full","1000baseT/
> > Full" ],
> >         "supported-pause-frame-use": "Symmetric Receive-only",
> >         "supports-auto-negotiation": true,
> >         "supported-fec-modes": [ ],
> >         "advertised-link-modes": [
> > "10baseT/Half","10baseT/Full","100baseT/Half","100baseT/Full","1000baseT/
> > Full" ],
> >         "advertised-pause-frame-use": "Symmetric Receive-only",
> >         "advertised-auto-negotiation": true,
> >         "advertised-fec-modes": [ ],
> >         "auto-negotiation": false,
> >         "master-slave-cfg": "preferred slave",
> >         "master-slave-status": "unknown",
> >         "port": "Twisted Pair",
> >         "phyad": 0,
> >         "transceiver": "external",
> >         "supports-wake-on": "pumbg",
> >         "wake-on": "d",
> >         "link-detected": false
> >     } ]
> > 
> > You can use a json library to do all the parsing for you.
> 
> I tried running the --json option with the ethtool ("ethtool --json enp9s0"), however I am not getting the above output.
> Instead it always throws "ethtool: bad command line argument(s)"
> I am figuring out what might be missing (or any suggestions would be helpful).

Are you using real ethtool, or busybox? What version of ethtool? I'm
using 6.10, but it looks like JSON support was added somewhere around
5.10.

	Andrew

