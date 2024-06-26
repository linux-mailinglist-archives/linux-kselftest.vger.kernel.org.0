Return-Path: <linux-kselftest+bounces-12821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D309187F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 18:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B92E281291
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFF418F2FB;
	Wed, 26 Jun 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6WTeWn0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518F71F94C;
	Wed, 26 Jun 2024 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420901; cv=none; b=JIqRYPVRTcu9od4QJEI0eSQkxPlat43EgKUIOX14+XXdi1o5Pzyy1SSP3fjg1rJpPBAuL0KEEIZcU8IB7luzDj94pU3lrSL3zp9SL1/2ZQHnfwPpQ7WLSrgG1bIuBLKc2CqH5vQHZ2R1GNisNlOfkA9/39VtvRyfjUMczgilNU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420901; c=relaxed/simple;
	bh=guTEOVrfyugyFbl4bTnst/wvSCcXeILGp5gqdzHoRbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dukXDHjSzQESqPN3Lw2SGXfP2mLpxeU3E+Kve9bDx0VNxfx6ueN9N0uU9yOJ+h9k4XUdKBBpN2SA74ugIaszVQ5Fzl3qftp/RuBWCAaWJgfZWs614qJs0/FRyMPoFpANcVjir6AS95Rv7ABmyFqdx5TyYy5GVw5QedhQubDJ/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6WTeWn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69285C116B1;
	Wed, 26 Jun 2024 16:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719420900;
	bh=guTEOVrfyugyFbl4bTnst/wvSCcXeILGp5gqdzHoRbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F6WTeWn0h/Zrswno15KKNmdcaNuoMu516iIBTN3mNiUj/aQj6CrCoE47x3nQ43tN6
	 SOOV5owGQZoh6/xyw3Bf2ikI9VBkRPKSIRRzu+FLbtsSuuzLiRqCBxop3eN0yQHvEn
	 LufDBsHf+zAvDFVmYbf1hiwXW8F93FjtAHSCxZVevshIKmB+MUn2ucWp9IBA9yQD9K
	 rWp8cfKJIPuhgBw4tSbJCuXJ4ezPgBp05JjsmdibLvy04Yo4Ihm6hf3veRYG98KGst
	 fbT8oHEFIH822B8PRX5xTXMRHpRZ85KYu6Qrk8tTie0zaQcNQwJqO5lZYmJMnZbluu
	 iodm2HMIqepyQ==
Date: Wed, 26 Jun 2024 17:54:55 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>,
	=?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
Subject: Re: [PATCH net-next v3 6/7] selftests: net: Use the provided dpctl
 rather than the vswitchd for tests.
Message-ID: <20240626165455.GA3104@kernel.org>
References: <20240625172245.233874-1-aconole@redhat.com>
 <20240625172245.233874-7-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625172245.233874-7-aconole@redhat.com>

On Tue, Jun 25, 2024 at 01:22:44PM -0400, Aaron Conole wrote:
> The current pmtu test infrastucture requires an installed copy of the
> ovs-vswitchd userspace.  This means that any automated or constrained
> environments may not have the requisite tools to run the tests.  However,
> the pmtu tests don't require any special classifier processing.  Indeed
> they are only using the vswitchd in the most basic mode - as a NORMAL
> switch.
> 
> However, the ovs-dpctl kernel utility can now program all the needed basic
> flows to allow traffic to traverse the tunnels and provide support for at
> least testing some basic pmtu scenarios.  More complicated flow pipelines
> can be added to the internal ovs test infrastructure, but that is work for
> the future.  For now, enable the most common cases - wide mega flows with
> no other prerequisites.
> 
> Enhance the pmtu testing to try testing using the internal utility, first.
> As a fallback, if the internal utility isn't running, then try with the
> ovs-vswitchd userspace tools.
> 
> Additionally, make sure that when the pyroute2 package is not available
> the ovs-dpctl utility will error out to properly signal an error has
> occurred and skip using the internal utility.

Hi Aaron,

I don't feel strongly about this, but it does feel like the
change to ovs-dpctl.py could live in a separate patch.

> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Aaron Conole <aconole@redhat.com>

The above not withstanding,


Reviewed-by: Simon Horman <horms@kernel.org>

I have tested pmtu.sh with this change on Fedora 40 both
with python3-pyroute2 installed, which uses ovs-dpctl,
and without, which uses ovs-vswitchd userspace tools.

Tested-by: Simon Horman <horms@kernel.org>

...

