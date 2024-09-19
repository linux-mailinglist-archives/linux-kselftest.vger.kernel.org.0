Return-Path: <linux-kselftest+bounces-18135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA49397CB2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738A81F22B46
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B350919EECA;
	Thu, 19 Sep 2024 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6WtTGwOH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF7D19B59D;
	Thu, 19 Sep 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726757493; cv=none; b=ciFawbDpS0Coxd3vQWbLw90nd0OCh7KaoP7FIt6ZrEYDzdVJctvgHbkwKoe25PkO51OMT1+2SNIBAX6F0GVecwa5etgCK04h3GCFL0NpEYGXuGgLHyq1nH+VWLEqlCsVdweuZaWTD2owevLl17kS2gM87kE2uNoVbZ5CGwKDZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726757493; c=relaxed/simple;
	bh=gjmxknBAv7FJKj12gBxsUHfcRVcOIzHZjvAbLvF2YcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPdT1bxKAljaYyfb1J+b6u3sPyb4sNx5UQ/EW2eF6dh4l4iOf/zKLpnufvB+9hawZh7QyCsmq3sICKYp2F2QEv0qwoUVdiUpr1j5VKRiV/7mLU3G0M8qlTra8lvgF42mNcHFLWa9BVL3NVWcKlhcHSHRCn0VzQnjJaJ9W5qmO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6WtTGwOH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mRc9mlRvqxgEF26tCg7xDtkX37mQJMNMslM2tmjmTvI=; b=6WtTGwOHCa/qFYKfyF0yE8HGXP
	zcpkqS/sjWrQWc0QwZDGYx6/pJ3O1Uq4JzMVRIc80m07mFqVRSLhjnfwtuwZkFh/BUhKn+VDZW1OR
	GpowjjLAXh96YRveh6E9bzkxHQHH1Xz4JkCFESNpTzl1d11suLh9D0QgE9hywGbVNU9Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1srIV4-007ohD-4m; Thu, 19 Sep 2024 16:51:18 +0200
Date: Thu, 19 Sep 2024 16:51:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohan.Prasad@microchip.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	horms@kernel.org, brett.creeley@amd.com, rosenp@gmail.com,
	UNGLinuxDriver@microchip.com, willemb@google.com
Subject: Re: [PATCH net-next v2 1/3] selftests: nic_basic_tests: Add selftest
 file for basic tests of NIC
Message-ID: <55037ff4-aa06-4cd4-bbc1-b1e714fa1fd4@lunn.ch>
References: <20240917023525.2571082-1-mohan.prasad@microchip.com>
 <20240917023525.2571082-2-mohan.prasad@microchip.com>
 <5c8779db-31c4-4b93-986a-bd489720fa4b@lunn.ch>
 <DM6PR11MB4236AE79E97B4CBBA1A9812F83622@DM6PR11MB4236.namprd11.prod.outlook.com>
 <0d6c225e-358b-401e-a4aa-a1f7ea0f2652@lunn.ch>
 <DM6PR11MB42363E9DC481B09277369B5A83632@DM6PR11MB4236.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB42363E9DC481B09277369B5A83632@DM6PR11MB4236.namprd11.prod.outlook.com>

On Thu, Sep 19, 2024 at 10:44:11AM +0000, Mohan.Prasad@microchip.com wrote:
> Hello Andrew,
> 
> Thank you for the suggestion.
> 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> > content is safe
> > 
> > > > Since you have batteries included python:
> > > >
> > > > ethtool --json enp2s0
> > > > [sudo] password for andrew:
> > > > [ {
> > > >         "ifname": "enp2s0",
> > > >         "supported-ports": [ "TP","MII" ],
> > > >         "supported-link-modes": [
> > > > "10baseT/Half","10baseT/Full","100baseT/Half","100baseT/Full","1000b
> > > > aseT/
> > > > Full" ],
> > > >         "supported-pause-frame-use": "Symmetric Receive-only",
> > > >         "supports-auto-negotiation": true,
> > > >         "supported-fec-modes": [ ],
> > > >         "advertised-link-modes": [
> > > > "10baseT/Half","10baseT/Full","100baseT/Half","100baseT/Full","1000b
> > > > aseT/
> > > > Full" ],
> > > >         "advertised-pause-frame-use": "Symmetric Receive-only",
> > > >         "advertised-auto-negotiation": true,
> > > >         "advertised-fec-modes": [ ],
> > > >         "auto-negotiation": false,
> > > >         "master-slave-cfg": "preferred slave",
> > > >         "master-slave-status": "unknown",
> > > >         "port": "Twisted Pair",
> > > >         "phyad": 0,
> > > >         "transceiver": "external",
> > > >         "supports-wake-on": "pumbg",
> > > >         "wake-on": "d",
> > > >         "link-detected": false
> > > >     } ]
> > > >
> > > > You can use a json library to do all the parsing for you.
> > >
> > > I tried running the --json option with the ethtool ("ethtool --json enp9s0"),
> > however I am not getting the above output.
> > > Instead it always throws "ethtool: bad command line argument(s)"
> > > I am figuring out what might be missing (or any suggestions would be
> > helpful).
> > 
> > Are you using real ethtool, or busybox? What version of ethtool? I'm using
> > 6.10, but it looks like JSON support was added somewhere around 5.10.
> 
> I have been using ethtool 6.7, updating to ethtool 6.10 solved the problem.

It would be good to gracefully handle this. Have the test fail with a
human readable error indicating ethtool is too old, rather than just
throwing an exception etc.

Digging through the git history, it seems like 6.10 was actually the
first version that supported this:

commit bd1341cd2146bfb89e1239546299102339acbf4d
Author: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Date:   Fri Jul 19 10:55:44 2024 +0200

    add json support for base command
    
    Most subcommands already implement json support for their output. The
    base command (without supplying any subcommand) still lacks this
    option. This patch implments the needed changes to get json output,
    which is printed via "ethtool --json [iface]"
    
    The following design decision were made during implementation:
    - json values like Yes/No are printed as true/false
    - values that are "Unknown" are not printed at all
    - all other json values are not changed
    - keys are printed in lowercase with dashes in between
    
    Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>

	Andrew

