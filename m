Return-Path: <linux-kselftest+bounces-41092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD50B50B00
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 04:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DA4189617F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 02:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745DB23C4F2;
	Wed, 10 Sep 2025 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0ddagmg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F5123CB;
	Wed, 10 Sep 2025 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757471168; cv=none; b=PBwokfRUQVso+P7PVmahzrCv4nYsk86v+Rc09WGD1voRTnhwVw1f25+M0z3277d2XhPrrKRkI1C3zyJwyYfgIuOEVQuYljSPqkPmgc3HJkHaVW60x9490xxIJBhW8gewFwx9pW0n19LDNgWamGvVMUdD5FNUPsOmqsmR5TYI+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757471168; c=relaxed/simple;
	bh=GxnvKUwX85agoJjvtTRn54fBAg9vLT1ovfRjs92Ns70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcAJzX+mi5V68YSZr0//eiGkuc50XRi/9xIaQgW3X1VeeIoD0rzcyXUpuxWkst5PMcxKyl+hH6pW6V2ujv8K+1ZBglgXwFew/DrPlL2kePvj1jTPT/uhxZg06UXF93QQHtPLscvWTlH6Kw+cckhU3mycFEAk2vY0a3SL1Tz2wYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0ddagmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E83EC4CEF4;
	Wed, 10 Sep 2025 02:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757471167;
	bh=GxnvKUwX85agoJjvtTRn54fBAg9vLT1ovfRjs92Ns70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L0ddagmgy+s8s3JEjKCyJ863LKjBOg5sgNP7YOQoffwnWXQX0m6CwbVMkzb/jV4Do
	 TIw2hrkJVbY0DJwY/VEScJVb59rTQ2c8C3zcqakcTv75WIMiYv6n+rRGJlRARg16FH
	 /4SbfzXXM42O64SCsOnqsycNGrp/K+AeU+9R/ATKanUjywqr4kAxAdM5glxZUAHczC
	 eWUb6YbbWxCwEPw7g/cqTgrM4ip3U58uepqYw04YI2AnC/r0UpEVR2G4ecFs8LUanM
	 nkr7F4Xf1/8W/YGUhmILOEJtjtKY7hMgQUNCVFTlRD2z7tF6R8v7K/MBQj+KWLlQuL
	 O4f5Wx2Ca2D3g==
Date: Tue, 9 Sep 2025 19:26:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 2/2] selftests: bonding: add vlan over bond testing
Message-ID: <20250909192606.6ac53aa4@kernel.org>
In-Reply-To: <aMDciKMGjr-_sW6E@fedora>
References: <20250908062802.392300-1-liuhangbin@gmail.com>
	<20250908062802.392300-2-liuhangbin@gmail.com>
	<20250909164600.04aa44c7@kernel.org>
	<aMDciKMGjr-_sW6E@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 02:03:52 +0000 Hangbin Liu wrote:
> On Tue, Sep 09, 2025 at 04:46:00PM -0700, Jakub Kicinski wrote:
> > On Mon,  8 Sep 2025 06:28:02 +0000 Hangbin Liu wrote:  
> > > Add a vlan over bond testing to make sure arp/ns target works.
> > > Also change all the configs to mudules.  
> > 
> > Why are you switching everything to module?
> > The series needs to go to net, we should avoid unnecessary cleanups.
> > And I think changing the config is unrelated to the selftest so it
> > should be a standalone patch in the first place?  
> 
> On my local testing, there will be a lot default interfaces if all modules
> build in. This could make the test environment more clean.
> But it's just my preference.

No strong opinion on my side. Your point is fair. On the other hand
sometimes dealing with modules is tricky (especially with vng when
building kernel with O=build/). But not sure how much we should care
about shortcomings of tooling which can be fixed. It's okay for our CI.

> As you said, we can do it with a stand alone
> patch. I will re-post and drop the config update.

Yup! For net we should avoid it.

