Return-Path: <linux-kselftest+bounces-27461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B2EA44221
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 15:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AE31893681
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 14:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B675626A0F8;
	Tue, 25 Feb 2025 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfpNrfvf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866FC2698A2;
	Tue, 25 Feb 2025 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492498; cv=none; b=Bsg3BRHjHg/ukSFgRdJnl8fOT+AfLVVh+QFHTLrxAqSnW1igCC5uRVlnsHpCDo5yNHsVQkkTxW2Zwl/5wX63y1nV0mqtb2wwSxwpOSAh9YIogoUta/4G1rXzBk1/YcUq5ZHNV24qQo3Gb/uFOUcKOsSB1624nZJ9K9l3dKadWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492498; c=relaxed/simple;
	bh=agLMng6UV0rzQJfX3gB/TEHY9nLHE/M+0WctUU7L3p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ig7Kvm3F+HIFp3VjmSXK35GP6Ge7dFzUgLCSlxGldBjqPxARWbezaTXKXTVKYaq8jEwSstI9LvVxdmnqDpu8SgwdD5d2APwc9iTPK+H+JB9zi4vZrFbjZ5nh5I9WzctlPTgRrJKfA+VD0uAOoUCnlvUF914TI9tJ6Ybwmno7i/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfpNrfvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C31C4CEDD;
	Tue, 25 Feb 2025 14:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740492498;
	bh=agLMng6UV0rzQJfX3gB/TEHY9nLHE/M+0WctUU7L3p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfpNrfvfIigB/A0z/RS3QwyHB6692+C8GbgY+b2HE1jfQpcEssFeHl8D63nfv5PFm
	 IKU3P+dHBocLEP96eRaOckIcW3RomNy9Oc+kRiE7xl5X/SRCWU8jWGBQ9bVmbeYX4r
	 Z7GdO4554ffptxCp1c8VkV7dJaKmcPbrX0kyjMRs/+z0nkj90gPVKQTRrKySFdW5Zb
	 ObePE0pbW+yFzQu83m8qHRfj8Z4rIQAUqqn/8JmiZiE9wygy00VBWPzdgMnOM/iYGS
	 38HGOPL2SpmJPx3Pff1fWAUiyNbiYnFAZ0Kujx19lwkhw58bUNVtHDYoOPIeAhpEUB
	 rbLXiHYP/G3vg==
Date: Tue, 25 Feb 2025 14:08:13 +0000
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
Subject: Re: [PATCH net-next 2/7] netconsole: refactor CPU number formatting
 into separate function
Message-ID: <20250225140813.GU1615191@kernel.org>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-2-21c86ae8fc0d@debian.org>
 <20250225101748.GL1615191@kernel.org>
 <20250225-diamond-gaur-of-anger-b0f77e@leitao>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-diamond-gaur-of-anger-b0f77e@leitao>

On Tue, Feb 25, 2025 at 03:09:20AM -0800, Breno Leitao wrote:
> Hello Simon,
> 
> On Tue, Feb 25, 2025 at 10:17:48AM +0000, Simon Horman wrote:
> > On Fri, Feb 21, 2025 at 05:52:07AM -0800, Breno Leitao wrote:
> > > Extract CPU number formatting logic from prepare_extradata() into a new
> > > append_cpu_nr() function.
> > > 
> > > This refactoring improves code organization by isolating CPU number
> > > formatting into its own function while reducing the complexity of
> > > prepare_extradata().
> > > 
> > > The change prepares the codebase for the upcoming taskname feature by
> > > establishing a consistent pattern for handling sysdata features.
> > > 
> > > The CPU number formatting logic itself remains unchanged; only its
> > > location has moved to improve maintainability.
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  drivers/net/netconsole.c | 18 +++++++++++-------
> > >  1 file changed, 11 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > > index c086e2fe51f874812379e6f89c421d7d32980f91..26ff2ed4de16bce58e9eeaf8b5b362dfaafaca0a 100644
> > > --- a/drivers/net/netconsole.c
> > > +++ b/drivers/net/netconsole.c
> > > @@ -1117,13 +1117,21 @@ static void populate_configfs_item(struct netconsole_target *nt,
> > >  	init_target_config_group(nt, target_name);
> > >  }
> > >  
> > > +static int append_cpu_nr(struct netconsole_target *nt, int offset)
> > > +{
> > > +	/* Append cpu=%d at extradata_complete after userdata str */
> > > +	return scnprintf(&nt->extradata_complete[offset],
> > > +			 MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",
> > > +			 raw_smp_processor_id());
> > > +}
> > > +
> > >  /*
> > >   * prepare_extradata - append sysdata at extradata_complete in runtime
> > >   * @nt: target to send message to
> > >   */
> > >  static int prepare_extradata(struct netconsole_target *nt)
> > >  {
> > > -	int sysdata_len, extradata_len;
> > > +	int extradata_len;
> > >  
> > >  	/* userdata was appended when configfs write helper was called
> > >  	 * by update_userdata().
> > > @@ -1133,12 +1141,8 @@ static int prepare_extradata(struct netconsole_target *nt)
> > >  	if (!(nt->sysdata_fields & SYSDATA_CPU_NR))
> > >  		goto out;
> > >  
> > > -	/* Append cpu=%d at extradata_complete after userdata str */
> > > -	sysdata_len = scnprintf(&nt->extradata_complete[nt->userdata_length],
> > > -				MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",
> > > -				raw_smp_processor_id());
> > > -
> > > -	extradata_len += sysdata_len;
> > > +	if (nt->sysdata_fields & SYSDATA_CPU_NR)
> > > +		extradata_len += append_cpu_nr(nt, nt->userdata_length);
> > 
> > Hi Breno,
> > 
> > As this is the only caller of append_cpu_nr() I'm wondering
> > if it would be nicer if nt was the only argument to append_cpu_nr().
> 
> Yes, I can do it. I just kept both functions the same:
> 
>   static int append_taskname(struct netconsole_target *nt, int offset)
>   static int append_cpu_nr(struct netconsole_target *nt, int offset)
> 
> Another option is to use extradata_len as the second argument, instead
> of nt->userdata_length. That might(?) make the code easier to read? it
> would look like the following:
> 
>           extradata_len = nt->userdata_length;
>           if (nt->sysdata_fields & SYSDATA_CPU_NR)
>                   extradata_len += append_cpu_nr(nt, extradata_len);
>           if (nt->sysdata_fields & SYSDATA_TASKNAME)
>                   extradata_len += append_taskname(nt, extradata_len);
> 
> What would you write yourself?

I think that I would reduce the number of parameters of append_cpu_nr() and
append_taskname(). But really, any of the options, including this patch
as-is, are fine. So please chose whichever you think is best.

