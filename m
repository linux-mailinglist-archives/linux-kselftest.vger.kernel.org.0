Return-Path: <linux-kselftest+bounces-36598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87642AF9953
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 18:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B703A3823
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69241E5B7B;
	Fri,  4 Jul 2025 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRwFBx/f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926219BBA;
	Fri,  4 Jul 2025 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751647852; cv=none; b=IHq5eCqMYZFx9kopCEho0QqjTfBPCIDmwVSG1/73aRpHeqQx5x2Q5IP2NllX1FFiHocEtmY02Dhegdjlx59cmB3aTv71zhpLnzIwiqDuietzYq5N/hes+zBFHQgCmXC9b7k1Qkb94pj+c8sJKCPeL3htiO9J+G9Jz463d07N/xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751647852; c=relaxed/simple;
	bh=z4xIqrxnxJb/VU6+2ATYNGE+j9z5mnmSIDSJ+6cCgqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4imdZmg52FFhX0sj/F0/Y7SvOSBoEtQs0hZokt5eIhZ5g9Y/HVtoJ+UjZFdBWFRMqan2qwddYKsMiN3vJgnCuXpoYCCRPfiCRoPHTywptBcZhQinhjz7dnxfkncQe8Rb4Y7AeZDwVeRUYFCB8i5tcK9cjCTshVZlmDqAzJHAzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRwFBx/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D703C4CEEE;
	Fri,  4 Jul 2025 16:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751647852;
	bh=z4xIqrxnxJb/VU6+2ATYNGE+j9z5mnmSIDSJ+6cCgqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRwFBx/fCbHOJNhDgzF1CP7cSmMOD7AvI/ezevCzbNVkhRRjSPw8g7a7PRiip3Ws5
	 xKmheH2WV6Gj+hWPcYucHPVvW5qL0i4ezRA+VvCvNWthfrhrK40QBq3YUkLF5lntFN
	 Lg61CB0wkVLdJ769VegGGteZSVpU1Ab4VN1FYDu+OO4CmJRTVKPqT1L25L4ROYlFiJ
	 DN5d5hWNZboc8wc22pc/3Zg5SAdg+NfXzBA17p6Sf8gKTHJwubaqY9IdfPlkfgKwzZ
	 X9+YxcVXNLzIJ3K2wOFLTgL6ezZz/WvhJgz7UI3AjKqB9D94i4sfWFnVN700Fdl04Y
	 CgDDxvg66qIPg==
Date: Fri, 4 Jul 2025 17:50:45 +0100
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] selftests: ethtool: Introduce ethernet PHY
 selftests on netdevsim
Message-ID: <20250704165045.GL41770@horms.kernel.org>
References: <20250702082806.706973-1-maxime.chevallier@bootlin.com>
 <20250702082806.706973-4-maxime.chevallier@bootlin.com>
 <20250704132019.GM41770@horms.kernel.org>
 <20250704153250.6ec18427@fedora.home>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704153250.6ec18427@fedora.home>

On Fri, Jul 04, 2025 at 03:32:50PM +0200, Maxime Chevallier wrote:
> On Fri, 4 Jul 2025 14:20:19 +0100
> Simon Horman <horms@kernel.org> wrote:
> 
> > On Wed, Jul 02, 2025 at 10:28:05AM +0200, Maxime Chevallier wrote:
> > > Now that netdevsim supports PHY device simulation, we can start writing
> > > some tests to cover a little bit all PHY-related ethtool commands.
> > > 
> > > So far we only test the basic use of "ethtool --show-phys", with :
> > >  - A simple command to get a PHY we just added
> > >  - A DUMP command listing PHYs on multiple netdevsim instances
> > >  - A Filtered DUMP command listing all PHYs on a netdevsim
> > > 
> > > Introduce some helpers to create netdevsim PHYs, and a new test file.
> > > 
> > > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>  
> > 
> > Hi Maxime,
> > 
> > We have recently started running shellcheck as part of our CI (NIPA).
> > Could you do so for the scripts added and modified by this patch?
> 
> Sure thing, I'll do that :)

Thanks.

> > > ---
> > >  .../selftests/drivers/net/netdevsim/config    |  1 +
> > >  .../drivers/net/netdevsim/ethtool-common.sh   | 15 +++++
> > >  .../drivers/net/netdevsim/ethtool-phy.sh      | 64 +++++++++++++++++++  
> > 
> > Should ethtool-phy.sh be added to TEST_PROGS the Makefile in
> > the same directory?
> 
> Ah yes I forgot that. So any file in that TEST_PROGS list will end-up
> being run in NAPI tests ?

I assume so.

