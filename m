Return-Path: <linux-kselftest+bounces-27453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E6BA44064
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 14:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F96017EE03
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 13:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592F02690DB;
	Tue, 25 Feb 2025 13:12:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F04A2690CF;
	Tue, 25 Feb 2025 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489167; cv=none; b=HwzfMwe1XQfxvhzSsPLwXrzhJA7cFb2+XY8dbWkCLsVTYHOjWgiELypYjffrMz3NQafct3KYu5SSEf34pe6wmJnf5wF4+wEadvCGf0GJj6+Uqzk552ags41clIJZzWN+sdQ+nT//CGr5YTzHqw3S5PTRkJ71bF71IGgHFCFA3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489167; c=relaxed/simple;
	bh=3WjxgzbN4yGK9NfJVETwPvCEg4jcFsjHzAIqxYBtDuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFMv6WAHpFhEJ33ir+wgF5WZ8QAA2i7bobvtpjrMtZI7pBZzt7zmD3T9eCB+u2bIt5w9WmyNDipFgcwZy44sFfCDqbD+c7gzGpYjuKPyszusdhyiAVOfvrzakmlwp5K651l0ZKfBsWmt10aQMS6clS/6di23reWorpEgcBHZm4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e05780509dso7873066a12.2;
        Tue, 25 Feb 2025 05:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489164; x=1741093964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huyKeKicvAsO+vZpf8pNQmuBsQVHWr+7B6dkrLsJZHE=;
        b=i5SPtjS29YKjSK3A6OFokznpbkHo88irxGwV2KMKqRNHW6Xsi6TCha2P2KcrSNVn+6
         qZt6KhxKoeJy8ZqM7RKdyCTi9VDESOagQOiI43RnKZOTJOVlVTGM6Mm/oz3epBoMBhRo
         Dz1Lc4qRLu0LjewD4Ki0j9vHePqueWfb9Co/IgOMfdyhqwL6b0Mv/L3wneaDDKYoxm6J
         8PAa9ixGJwj5FFqrpSPfXdwztazida1SVhbTlZY12bN8ZppTdrfo83tTMbYPHSPb4Gq8
         /bc62AIEzwLF8oaM7VkP6LhYagskPxPNDWvsk4PWoZ9ZZBmGoqNSdKdt6s2xUCkilsmD
         vXAA==
X-Forwarded-Encrypted: i=1; AJvYcCVk/Cx1TZM/8mJLHKvNo8nHT/U8lY4KC3lmOWCfO9KLggpv8duUrcfjgSHtuoAWBkI8jzbsdd/ujvuyfJ7wwdte@vger.kernel.org, AJvYcCWE3MEufr8X7nqLAfXqucsWHl6PjVf1KaITgmGjqvT04prE1H0ld/7OfqaHaXWyBs/G+IAwhVHKcug=@vger.kernel.org, AJvYcCWU8aOL0Q25dqUxnSSSu2lcI1c4dfTaQ2RNSC/fNfhWvwLgfec1kQLgATjJSbV/8gnUmQ5eCCyrEh/o/3V2@vger.kernel.org, AJvYcCWbTB0ja6xLPkJSeuEpnnGuBJlt6vRKhUG/W4GPlwyQqGRYMfNoC40pHNq/QsPHwErY9NfCBFhj@vger.kernel.org
X-Gm-Message-State: AOJu0YxJNji9mVw7T2REL8gzj0MBKtr0hT+dm/nDBo05Xb5vcy++LMLd
	K61vXykTyxxBJlJm3BgCs41BHL4+TiUaJs8kOlwydwhx50hMQQzd
X-Gm-Gg: ASbGncuOWxnNdd2UfSyt3ch3ETgV3TjvGVs0T34imt6HO7c9X7y5NOmNyDOu9y1t6EP
	bWHtHSd570Tvu1fkkETMokjnYxvs74v8qIV5cDafmQAPY3TKJl+dAlmyAi8A/+1p9tHLAeDBtnx
	gfySrcY2cbf83/cpgGqk1UHfmWvLaceEyYC4xpKaII7/TZn5z0jHRV91ZBrj/7hGt99nCyxkQMm
	nfj4VSGqdsbOZqLbRkLTR7z1YPZQvEbv+ccnv+ptcEwpjU1v+BBV2ZBBNChOkRv3J/3Xif12ibF
	NJLLHbWvQwn5k7Oe
X-Google-Smtp-Source: AGHT+IFlxa/+8iEwcPmxNR8k8h8OkLnc2bi5Cian4c/8JlV7dVrkWbU9Bfqx1Ids2urTRQbj+bOtvg==
X-Received: by 2002:a17:907:7d8e:b0:ab7:ef48:1668 with SMTP id a640c23a62f3a-abed10feb98mr355246166b.57.1740489163680;
        Tue, 25 Feb 2025 05:12:43 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdbe0asm139551366b.36.2025.02.25.05.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:12:43 -0800 (PST)
Date: Tue, 25 Feb 2025 05:12:40 -0800
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 4/7] netconsole: add configfs controls for
 taskname sysdata feature
Message-ID: <20250225-persimmon-narwhal-of-management-41bafb@leitao>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-4-21c86ae8fc0d@debian.org>
 <7309e760-63b0-4b58-ad33-2fb8db361141@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7309e760-63b0-4b58-ad33-2fb8db361141@redhat.com>

On Tue, Feb 25, 2025 at 12:41:50PM +0100, Paolo Abeni wrote:
> On 2/21/25 2:52 PM, Breno Leitao wrote:
> > Add configfs interface to enable/disable the taskname sysdata feature.
> > This adds the following functionality:
> > 
> > The implementation follows the same pattern as the existing CPU number
> > feature, ensuring consistent behavior and error handling across sysdata
> > features.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/netconsole.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 1b109f46512ffb7628c6b34c6efdfc301376dd53..5a29144ae37ee7b487b1a252b0f2ce8574f9cefa 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -426,6 +426,20 @@ static ssize_t sysdata_cpu_nr_enabled_show(struct config_item *item, char *buf)
> >  	return sysfs_emit(buf, "%d\n", cpu_nr_enabled);
> >  }
> >  
> > +/* configfs helper to display if taskname sysdata feature is enabled */
> > +static ssize_t sysdata_taskname_enabled_show(struct config_item *item,
> > +					     char *buf)
> > +{
> > +	struct netconsole_target *nt = to_target(item->ci_parent);
> > +	bool taskname_enabled;
> > +
> > +	mutex_lock(&dynamic_netconsole_mutex);
> > +	taskname_enabled = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
> > +	mutex_unlock(&dynamic_netconsole_mutex);
> > +
> > +	return sysfs_emit(buf, "%d\n", taskname_enabled);
> > +}
> > +
> >  /*
> >   * This one is special -- targets created through the configfs interface
> >   * are not enabled (and the corresponding netpoll activated) by default.
> > @@ -841,6 +855,40 @@ static void disable_sysdata_feature(struct netconsole_target *nt,
> >  	nt->extradata_complete[nt->userdata_length] = 0;
> >  }
> >  
> > +static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
> > +					      const char *buf, size_t count)
> > +{
> > +	struct netconsole_target *nt = to_target(item->ci_parent);
> > +	bool taskname_enabled, curr;
> > +	ssize_t ret;
> > +
> > +	ret = kstrtobool(buf, &taskname_enabled);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_lock(&dynamic_netconsole_mutex);
> > +	curr = nt->sysdata_fields & SYSDATA_TASKNAME;
> 
> Minor nit:
> 	curr = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
> 
> would be preferable, and more robust if later on other SYSDATA_ bits are
> added, 'moving down' SYSDATA_TASKNAME definition.
> 
> Also it would be more consistent with previous usage in
> `sysdata_taskname_enabled_show()`

Good point, in fact. I will update!

Thanks for the review,
--breno

