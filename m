Return-Path: <linux-kselftest+bounces-23660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C9B9F9508
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DAF1892A09
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D29F215771;
	Fri, 20 Dec 2024 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2eWZhuCX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A917BD3;
	Fri, 20 Dec 2024 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707032; cv=none; b=Tew3S4s+1WL1fBBj5h8OtFowlRHZGFwsIY26jNBsyQ2RnIxXEhLZ5mmcaK/8zx1ZI8NtklmSPaNmU0c/RNRilCk8XBHu1T7BKeH8c+RUegp7GwWuEA3KJ0iKJM7GlTdmDfSHZ4bhZy9lLAub0MrC62GSkdnafo2gEwRMJXs6z3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707032; c=relaxed/simple;
	bh=IIrvS6bE8I4VqAoTJ0zTgKKQIR0xr0XqMKdkopPvGWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+6pomFj4O78X8CdrKeVw6TdLpRS7iM1cKfgJ3f8nTm4sEH3nMu5VCy1T+ClbMrzEAVz3hEoIXrKy5rdIGIVU8EQwGrcMOka/+FlF/+Lo6eTHzonR61o34qYC2NL2bIQBEzitCEzNgZDtH1R8K+pbMyVRSUR8Xfbeip/tSeeJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2eWZhuCX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iVMoHoNTNi5hVbcBRob/+E0/l17Qq0I66k/TdZixdJM=; b=2eWZhuCXHH/5X/czffI7RlUUpO
	nZSEagqxd7yRL7zx5tYgeYMwBh7UgkL21gSlDANZeRw3dHEbRzOBPze1YCEGpSiaNnS4GbFqALSBD
	3pi+LEnH1iuvR2aErYo/jjuVVPOfCh2xlf8BP6gUacEc8ewMLYrx5GI5bNue38p/zZk4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOeXT-0021qa-RK; Fri, 20 Dec 2024 16:03:39 +0100
Date: Fri, 20 Dec 2024 16:03:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org, willemb@google.com,
	petrm@nvidia.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: assume stats refresh is 0
 if no ethtool -c support
Message-ID: <c102ecbd-e1a6-4b89-bef5-110744345478@lunn.ch>
References: <20241220003116.1458863-1-kuba@kernel.org>
 <e933e67f-66f2-422b-b00e-09ae788ed51d@lunn.ch>
 <20241220062214.3e8823ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220062214.3e8823ac@kernel.org>

On Fri, Dec 20, 2024 at 06:22:14AM -0800, Jakub Kicinski wrote:
> On Fri, 20 Dec 2024 10:09:06 +0100 Andrew Lunn wrote:
> > > @@ -234,7 +234,12 @@ from .remote import Remote
> > >          Good drivers will tell us via ethtool what their sync period is.
> > >          """
> > >          if self._stats_settle_time is None:
> > > -            data = ethtool("-c " + self.ifname, json=True)[0]
> > > +            data = {}
> > > +            try:
> > > +                data = ethtool("-c " + self.ifname, json=True)[0]
> > > +            except CmdExitFailure as e:
> > > +                if "Operation not supported" not in e.cmd.stderr:
> > > +                    raise  
> > 
> > How important is this time to the test itself? 
> 
> Just to be clear (because unfortunately git doesn't do a good job of
> calling out Python method names in the diff :() this is part of a
> method called wait_hw_stats_settle() within the test env class. 
> It's used by various tests which use/check device stats.
> 
> > If it is not available,
> > can the test just default to 50ms and keep going? I would of thought
> > we find more issues by running the test too slowly, than not running
> > it at all, unless having the wrong timer makes it more flaky.
> 
> We already use zero for majority of driver which don't report stat
> refresh:
> 
>                  data.get('stats-block-usecs', 0) / 1000 / 1000
>                                               ^^^
> this patch just does the same thing not only if the driver doesn't
> report 'stats-block-usecs' but also if it doesn't support -c at all.

[Looks at it again] So the raise is if ethtool give an error other
than EOPNOTUPP, so a real error. O.K. Then i makes sense.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

