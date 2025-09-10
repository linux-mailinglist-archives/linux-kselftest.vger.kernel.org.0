Return-Path: <linux-kselftest+bounces-41193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2EEB51F96
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 19:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A141C270A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5683376AB;
	Wed, 10 Sep 2025 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH+6MLhC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C180335BD0;
	Wed, 10 Sep 2025 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527140; cv=none; b=hDLhzEaSQ2iFqWg9t6FG0EM4M7yqvvntJz6uUeJtpT97aYHP4VTMU9bcCJqTj6KClPR7CoQTL4/C0UDpZaJujmh4fnDIWAu6x4CxXVxCNkx+A6F3RRjVVle/uNHx80IbkZINACNjxmtsFU5xR3mYgxRYgpJ94b0xtjUzKMqPPgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527140; c=relaxed/simple;
	bh=3OB/1/72wpDUqru7+1lTnbYAH1kOUgOBvd4nyep3M+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQxZfkUiMEGaPA6Lk3ptbSi2emN9FITCbmmUEZ8h1A5U3yUe/+qsaAu8/P55lhaaeVuSJPk6IlFIOmnJzOR4r2JL8nlv+0Ik++iid38sjMr3j/iBBqJwTaqxsGug+S3tZ4XZIcCOG2ygUtWpgn/KvZwPuUJyZtyDSYUSSDt9W9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aH+6MLhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DE8C4CEF0;
	Wed, 10 Sep 2025 17:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757527139;
	bh=3OB/1/72wpDUqru7+1lTnbYAH1kOUgOBvd4nyep3M+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aH+6MLhCiTLp+wcLENeAQnSaoWiN6EoIINKbn2FryQMIC5MHBxTg9XsVpuG+y7GzA
	 oWI28v9zBjfAbjTne2el34PVx8v0MupyesTwYeZhTKwGvzTssG+BHPLKJkdRz+C3U/
	 17LlR6pb1vKaDF3AVshE2WgLu5fJ8ec/z/zPbLyrCLYunvpwo9JkWXYZsg1Fuim65x
	 AwLBuwwjUKLmaIKnuA3SN/rze55snN8nHAl3/0S4u8KCiTAGxtMnwg5qyxN70CQnBw
	 cksIUSCtjCeCDlSY1AVCLLhvKip61op49hcNAVI1VWu8qhvkF8S8gMec1MdWss1SZC
	 WdQlY6CasUVsA==
Date: Wed, 10 Sep 2025 10:58:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Calvin Owens <calvin@wbinvd.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>, david decotigny
 <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 kernel-team@meta.com, stable@vger.kernel.org, jv@jvosburgh.net
Subject: Re: [PATCH net v3 1/3] netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Message-ID: <20250910105858.083ca8df@kernel.org>
In-Reply-To: <jibftqm5ihdgazmk3p5gsjhlc536itqaq7r5uag5fuiqtth6cp@abihzyykh4gy>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
	<20250905-netconsole_torture-v3-1-875c7febd316@debian.org>
	<aL9A3JDyx3TxAzLf@mozart.vkv.me>
	<20250908182958.23dc4ba0@kernel.org>
	<kmvkrqkkrbfctpramlchpwqikg2x3btb3debshabqctt7azu2j@tv4ziqd4gldh>
	<20250909161625.470d2835@kernel.org>
	<jibftqm5ihdgazmk3p5gsjhlc536itqaq7r5uag5fuiqtth6cp@abihzyykh4gy>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 07:12:03 -0700 Breno Leitao wrote:
> On Tue, Sep 09, 2025 at 04:16:25PM -0700, Jakub Kicinski wrote:
> > On Tue, 9 Sep 2025 13:17:27 -0700 Breno Leitao wrote:  
> > > On Mon, Sep 08, 2025 at 06:29:58PM -0700, Jakub Kicinski wrote:  
> > > > On Mon, 8 Sep 2025 13:47:24 -0700 Calvin Owens wrote:    
> > > > > I wonder if there might be a demon lurking in bonding+netpoll that this
> > > > > was papering over? Not a reason not to fix the leaks IMO, I'm just
> > > > > curious, I don't want to spend time on it if you already did :)    
> > > > 
> > > > +1, I also feel like it'd be good to have some bonding tests in place
> > > > when we're removing a hack added specifically for bonding.    
> > > 
> > > Do you prefer to have a separated bonding selftest, or, is it better to
> > > add some bond operations in the torture selftest?  
> > 
> > Normal test is preferable, given the flakiness rate and patch volume
> > I'm a bit scared of randomized testing as part of CI.  
> 
> Ok, I will create a selftest to cover the netpoll part of bonding, as
> soon as my understanding is good enough. I don't think it will be quick,
> but, it is on my hi-pri todo list.
> 
> Do you want to have the selftest done before merging this patch, or, can
> they go in parallel?

I said "it'd be good to have some bonding tests in place when we're
removing a hack added specifically for bonding."
"In place" means part of CI when we're merging this fix.
Please read emails more carefully.

