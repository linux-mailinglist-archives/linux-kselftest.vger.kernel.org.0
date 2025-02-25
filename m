Return-Path: <linux-kselftest+bounces-27439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7604A43D2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 12:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C674E7AE041
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084132673B8;
	Tue, 25 Feb 2025 11:09:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A99264A7C;
	Tue, 25 Feb 2025 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481766; cv=none; b=LT/QYMEF5T0uUEdtDC4PTPvUkZN9KRYKYi3nlNpO3Gu4nzANIDMlKoc3jIY9U56BwjZNjcjgLCnqOKZ6YbHZsKqj5OXgGVkldsOghVlbn+jEilAq2SS/5XNKceK4eZDC3CtcuRTN2vladxadJrjY5O7tY1TNwoApLZ5QcJz62a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481766; c=relaxed/simple;
	bh=TtBQCEIEL2mTq/30X9Qjp4A9+mPF9QER9TihXX7Hng8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkZjVI8VevC0q3mehy8jhSptuadGIvwpsI8TSMIISDAhahO6u7n1cPS1nzC1Ns2Jp+0T659EvgoqFAi+lCNCchY+XFtvsLFoAMAhFi5N/lwgliV6BxlQud8d/WDHMkRhYqCm3RTnMCnl/0LlK5aCVtfy8U6Aq1OL7zCMXwb0JwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so11670170a12.1;
        Tue, 25 Feb 2025 03:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481763; x=1741086563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HP9OZuJ6AU1JfkSYo6B6srazy0msILW/CieEyyhb2E=;
        b=JpYnkp+cLzs8KSyOIghHt1J/SsOOobj9vE3UHHAo4/zPPSdMjAoBMH+UomrAEXZBsn
         KPTrf3qOEC4qfy73VjJR/Xb4qWI4Qn0Fnef4kqiM6giFQR9iszgtkpm0KSETtxubpDn/
         bRGFtEx1BkwhheizlyPwG5MtnaRoHDrN+ZZYBnbNuu1qLBj6naG/5lCuK+1Je7pPgDDB
         AK+YQAqNYYmyIdXjxJZTn9+av73Kfeh/eFvKFI6Vpjn+EoNC1D1L9XwWu0u8h2Ft7tHb
         bDkhX6d7hL5h+f3Gg6P85sVxb4opUDKmLck77GPQLnrymdl7VWam8D/FRli+JW4Di3oc
         q46g==
X-Forwarded-Encrypted: i=1; AJvYcCV0ORY8thReyEB6FIchyHbWm8MA0XQ1WVXSFNHePJR1dyS4+l1nkgeoL05OUzFxGpAwTy54C3zHmHWvHAAK@vger.kernel.org, AJvYcCVd0ehRGZfRl2JmPIJxfAYhwEh6AfAjY/+VfKV4LHoqYMlLM7zLpqn3VrYzMXU5JzURv/WmNRUE/HA=@vger.kernel.org, AJvYcCVeQIoJxIykyLvNBN2+MkRAuAf3muGexVmKjx7Q2DRmceokiJhF5ZPa2Jr8hBmMww+VnVLdEZTx@vger.kernel.org, AJvYcCXJ37uYE0BzcDu2pSIpPDVrmP5HJAUxvwzAM42UvgX904r0mdFbzabc9IbmrHHgZH10mSiHiZdA9CkeNfqoICXa@vger.kernel.org
X-Gm-Message-State: AOJu0YyRi6Mprtmx8COUiTPVdmvhgV1OFlKodl8rySTfWKLbeLyRUqmW
	Egv9nkrr7ts/N1LO+YhWv7woxqOAT+0zb5dwbfdfPCz4//hl4BIg
X-Gm-Gg: ASbGncu0a+XLLERzJmy53fPfMwayQJqQOiNpW7u03gMpx2c22arD7fz3p51SCSSB9wM
	BzVqIprA0j6LsfQdQCGuBMyoVUntr08VZsAKDR7G1llCmcQDqBGUcKdnrcfL2RwvJPtDcyO5PST
	jJgmYOtPS7R+az0mc7OTUnIaonH9GmRota+dx+ujJAZjk7uPnmUSiGcsarhUpT8NAgku1de9p8o
	ahaGcy0sA1vcCRkb+6+z04ZD19VlZ7PLfIDkzdbtuOdpz7NlgzAvi/M//UDbREhJSWuuHceT5tW
	713IInsuoNUZJt8m
X-Google-Smtp-Source: AGHT+IFtEU/qbtI5q4s+/3i4tDPt/bCCUO0KkhYar0f3IBw5ANItfNk//tImV+wtlwslPGilHyVkQQ==
X-Received: by 2002:a17:907:c015:b0:abb:61b0:faa5 with SMTP id a640c23a62f3a-abbeda27eacmr2004055666b.4.1740481763220;
        Tue, 25 Feb 2025 03:09:23 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20b81a0sm120938266b.180.2025.02.25.03.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:09:22 -0800 (PST)
Date: Tue, 25 Feb 2025 03:09:20 -0800
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
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
Message-ID: <20250225-diamond-gaur-of-anger-b0f77e@leitao>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-2-21c86ae8fc0d@debian.org>
 <20250225101748.GL1615191@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225101748.GL1615191@kernel.org>

Hello Simon,

On Tue, Feb 25, 2025 at 10:17:48AM +0000, Simon Horman wrote:
> On Fri, Feb 21, 2025 at 05:52:07AM -0800, Breno Leitao wrote:
> > Extract CPU number formatting logic from prepare_extradata() into a new
> > append_cpu_nr() function.
> > 
> > This refactoring improves code organization by isolating CPU number
> > formatting into its own function while reducing the complexity of
> > prepare_extradata().
> > 
> > The change prepares the codebase for the upcoming taskname feature by
> > establishing a consistent pattern for handling sysdata features.
> > 
> > The CPU number formatting logic itself remains unchanged; only its
> > location has moved to improve maintainability.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/netconsole.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index c086e2fe51f874812379e6f89c421d7d32980f91..26ff2ed4de16bce58e9eeaf8b5b362dfaafaca0a 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -1117,13 +1117,21 @@ static void populate_configfs_item(struct netconsole_target *nt,
> >  	init_target_config_group(nt, target_name);
> >  }
> >  
> > +static int append_cpu_nr(struct netconsole_target *nt, int offset)
> > +{
> > +	/* Append cpu=%d at extradata_complete after userdata str */
> > +	return scnprintf(&nt->extradata_complete[offset],
> > +			 MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",
> > +			 raw_smp_processor_id());
> > +}
> > +
> >  /*
> >   * prepare_extradata - append sysdata at extradata_complete in runtime
> >   * @nt: target to send message to
> >   */
> >  static int prepare_extradata(struct netconsole_target *nt)
> >  {
> > -	int sysdata_len, extradata_len;
> > +	int extradata_len;
> >  
> >  	/* userdata was appended when configfs write helper was called
> >  	 * by update_userdata().
> > @@ -1133,12 +1141,8 @@ static int prepare_extradata(struct netconsole_target *nt)
> >  	if (!(nt->sysdata_fields & SYSDATA_CPU_NR))
> >  		goto out;
> >  
> > -	/* Append cpu=%d at extradata_complete after userdata str */
> > -	sysdata_len = scnprintf(&nt->extradata_complete[nt->userdata_length],
> > -				MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",
> > -				raw_smp_processor_id());
> > -
> > -	extradata_len += sysdata_len;
> > +	if (nt->sysdata_fields & SYSDATA_CPU_NR)
> > +		extradata_len += append_cpu_nr(nt, nt->userdata_length);
> 
> Hi Breno,
> 
> As this is the only caller of append_cpu_nr() I'm wondering
> if it would be nicer if nt was the only argument to append_cpu_nr().

Yes, I can do it. I just kept both functions the same:

  static int append_taskname(struct netconsole_target *nt, int offset)
  static int append_cpu_nr(struct netconsole_target *nt, int offset)

Another option is to use extradata_len as the second argument, instead
of nt->userdata_length. That might(?) make the code easier to read? it
would look like the following:

          extradata_len = nt->userdata_length;
          if (nt->sysdata_fields & SYSDATA_CPU_NR)
                  extradata_len += append_cpu_nr(nt, extradata_len);
          if (nt->sysdata_fields & SYSDATA_TASKNAME)
                  extradata_len += append_taskname(nt, extradata_len);

What would you write yourself?

Thank you very much for the review,
--breno

