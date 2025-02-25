Return-Path: <linux-kselftest+bounces-27462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 865A9A44229
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B37188E5A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 14:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAD026A0F5;
	Tue, 25 Feb 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Do3lSfxw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F098E26A0D9;
	Tue, 25 Feb 2025 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492635; cv=none; b=DE+xP2KXbPsZQntUX7CG2/lQrfJYTmlyYCDxn2gORcGHjcOF9I81DbZlqEA/WyIsYHpYoe78EkdAe9t4j7XmBuGPl07esEIqsDx0rMC+KKZAxW1TvBb/Xpq8gsi9DYsa+kuQKEEP+7M8qdYMHzYe4zVPQ6T+Fhe5Mx8SXk8pq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492635; c=relaxed/simple;
	bh=bT05Wbf3bAalx+ImPn50rrNUf3u9v6QTKAoptAYU/SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik3c3BKmOr/TpD5lDzdH1wHYIFWQq+zP328OogfhagJ9PeMBLBz4TbyaXaBW6HZyBSOe2RdJedgc03G8vXJfS0lG3V+NmEbMDLwYBNpqdWPaGJjnPKFCKoMv0DqYsZ9fcHzSKmm7x2VghayVlGoH52CWMI0PERzixiGjolC7ng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Do3lSfxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAFAC4CEDD;
	Tue, 25 Feb 2025 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740492634;
	bh=bT05Wbf3bAalx+ImPn50rrNUf3u9v6QTKAoptAYU/SU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Do3lSfxwb8CmyAhbZwYghHZ934NLe5P4Nyau1SzA8mxeA4PDXZneTuQFi7nYsngVb
	 7dYl+rVbuccUFqVNd4C2+YKribRD1p1vLwhUkH0v2zPJ3051z0+yliZQgfmHfdE4P5
	 TXv7I9o2QdBQjRFXNVvC9X9Has5+Mqk1MPF22s05QlRrYQe10rOBPTPGIjrLjtCH5c
	 YvS3B8972KLKyzCKEtzyNwXKXJGYdVxlU9FcNn1frG03mx/bbk1avxk1dTYJYYbL9t
	 QQsqei0vAYySjvBJnrjzW+qCF5oob0Gm/jQYk4jQODKOzbf2o8jvquE3psKITyWUZi
	 q/1gyc1S0Go/w==
Date: Tue, 25 Feb 2025 14:10:29 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 5/7] netconsole: add task name to extra data
 fields
Message-ID: <20250225141029.GV1615191@kernel.org>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-5-21c86ae8fc0d@debian.org>
 <20250225101910.GM1615191@kernel.org>
 <20250225-doberman-of-scientific-champagne-640c69@leitao>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-doberman-of-scientific-champagne-640c69@leitao>

On Tue, Feb 25, 2025 at 03:17:33AM -0800, Breno Leitao wrote:
> Hello Simon,
> 
> On Tue, Feb 25, 2025 at 10:19:10AM +0000, Simon Horman wrote:
> > On Fri, Feb 21, 2025 at 05:52:10AM -0800, Breno Leitao wrote:
> > > This is the core patch for this whole patchset. Add support for
> > > including the current task's name in netconsole's extra data output.
> > > This adds a new append_taskname() function that writes the task name
> > > (from current->comm) into the target's extradata buffer, similar to how
> > > CPU numbers are handled.
> > > 
> > > The task name is included when the SYSDATA_TASKNAME field is set,
> > > appearing in the format "taskname=<name>" in the output. This additional
> > > context can help with debugging by showing which task generated each
> > > console message.
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  drivers/net/netconsole.c | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > > index 5a29144ae37ee7b487b1a252b0f2ce8574f9cefa..625f4c0be11d8deb454139b1c526abc842697219 100644
> > > --- a/drivers/net/netconsole.c
> > > +++ b/drivers/net/netconsole.c
> > > @@ -1179,12 +1179,22 @@ static int append_cpu_nr(struct netconsole_target *nt, int offset)
> > >  			 raw_smp_processor_id());
> > >  }
> > >  
> > > +static int append_taskname(struct netconsole_target *nt, int offset)
> > > +{
> > > +	if (WARN_ON_ONCE(!current))
> > > +		return 0;
> > 
> > Hi Breno,
> > 
> > I gather that theoretically this could occur, but it isn't expected
> > to happen in practice. Is that right?
> 
> That's correct. `current` isn't expected to be NULL in practice.
> I've been running this code on several servers for days and have never
> encountered this warning. 
> 
> While the taskname feature isn't enabled during early boot, netconsole
> might be active at that time, which is why I exercised extra caution
> here.
> 
> If you also think this is safe, I am more than happy to remove this
> check.

Thanks for the clarification.

Given the above explanation I would have added the check too.
So from my PoV we are good.

Reviewed-by: Simon Horman <horms@kernel.org>

