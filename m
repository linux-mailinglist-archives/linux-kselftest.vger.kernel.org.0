Return-Path: <linux-kselftest+bounces-37987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 115E7B11F17
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 14:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB8F1CE1ADB
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 12:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360092ED15F;
	Fri, 25 Jul 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPdO80B9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F52ED153;
	Fri, 25 Jul 2025 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753448326; cv=none; b=NBLN+8j6pkkk9uUUWVbo0BmO926cSfI3iJZ6WESEiIBqo1fuk28typUY92/PRKP1f8/F4o7nwYJ8SYGQaDCZBBs6jgurgBJPN5S3GOxbUD0+OIuA7a8i+8aLNmFWq3PX/k9TiFCEnxpdIxrD6oT26f4jNNCwbm16Y2O7TKxEzCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753448326; c=relaxed/simple;
	bh=U+l2daCSxoxZop8pSJd81XPpmelPZZWa2K/uyjIKm9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2O/2Q6uH9eiQ6m5ya1rlbbEwJuw/3JsboN0iOzlyOXfhSPglcWs0Ey0IonKiQt1MbjlufcUs1y7WclNMxP+xcyD7D6k1zBjlzIlLO0lcB3FNCGJG48HjaUE6G06bxDLLH5N0Aka6mkTbAPJjYjT9uWmsv5K4hRCi2OY2UZjknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPdO80B9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235e1d710d8so27074995ad.1;
        Fri, 25 Jul 2025 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753448323; x=1754053123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IRzi0ZZ7lzn256rqqzO9OVR+xH0dahkcse6WfaiH0cE=;
        b=nPdO80B9jTFuMzhve0uXt2bdD9x2G6QfzgLV5HZbNUMBz+RMEASlMICFTxwBmTMhQv
         g4Mdzr23ie3WsyMRI0KrEya6CCKuZojAkK2tMz53N5cjLQSgJd/eYD3iqS+NeHheIJBk
         JU0za/1HU4EfzIeNyW7tx3AcHibYe4CAm55kQxt6V6P+8aNWPmf4G4rbMeOJpFt35j/y
         N+naT1lgtzR8RzLGgGDZ2ydTmYhuVbkVkcZJiDAC1U0SaaG0tx3JqieoX2diMRK7TdyB
         mMc3RhX603aOTr1aRbBcdXjmvnS5E5JoDCCrubmW45Y/nd/oTUotRYUZliHnkkAcfg3M
         tbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753448323; x=1754053123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRzi0ZZ7lzn256rqqzO9OVR+xH0dahkcse6WfaiH0cE=;
        b=urY59oqh1UQcqJYrE3ktuvlXb8CwwGyjx8prBcXvZVLIebK5xcl/hI5lxNy9jb0ogJ
         sJfYCnsVPmGWlu7oRavvbHC4FzXsfBWbzc8Fbn9nbj4+DK0wjy6LtkJuTb/D6+womhMi
         uYojxSVgf4c8+Z7MfHtRL7yldF/hcGLUctgydleS/7fbAB3jjCFYw/XxVUSYXvv7BvDh
         SBQaQn5nL7fSWz3IFP1drdClzN0GWqSEBPWWELrQGjuA4v9SyR3RA3eBQCH++Ml7ljrh
         ROwuCg7eAGL2QPSB/Wfa65YebNiYaCXiq9wf1RtvSpbyu33aWPuRN1646+mvgTkTWMwN
         dxWg==
X-Forwarded-Encrypted: i=1; AJvYcCVNTsNCa/I5hd4RBHAoZIfDXwgLHtK8dDMTKJZY9lC2ry9Iuegz9jfobmrAoaVCE5GK31o51KoRdWM=@vger.kernel.org, AJvYcCWCEkjMs+JYZQzNR+//CJT8bBPZ28NqOiaZ28hBAVgFQsO7WAnWZrw8ZGd4pTv5wAW2CDF8gGH9Q10OHmbk@vger.kernel.org, AJvYcCWvYlIV+33YdHkMYM6POZLUmbwl8C5oV4dxPGdTtrv3hDtr4ZQop6Dmu2k5AQ86N8+wr2xmBC7kefZkyVbSyamV@vger.kernel.org
X-Gm-Message-State: AOJu0YzBohJtLNGygDs0PzKzYRWR4GJX+sGieLN3oX2EuKe+LZw5y2sO
	vdPxrnrYXlZgpXGV05EJCyE+Mot3ZVKwAs1iH0gXQc+2wzMyLxFIe8A8
X-Gm-Gg: ASbGncvx+vBvypUhglum1LKI+1gv1wCFU3vyN3+Arm5CULAqplffeECFUkjaVF8IA8p
	GZxEnAAi5sUVjLApp8CLypQGIELurbe4H3pQSqfkcBwf8Qbfp0Tu27mJ3u3+cjcqfzdDeidbmpS
	OtppZ1qFJhjijd/txFY+Ve+6h6tcCNMYCGWtfNkhDDeS58xcLpHjTCNra6p1yLp4cfdU8dlIPIu
	OqMIV5W+44vVHUDaeIz8ERWbdR3dJ4QnQUcVLc32ZvJOWKek+j8BZsAM2sk6w0dYWIiZA4yZqdq
	b6lzujEDE0xx+4xS3j9jLdissPR9nClrCPubooboc+5cAuBp/8nsd5XUzoQ3hSHnUk05Zg8p0w+
	fbKYD0UkCpTxTIAbIF1lK22Qcyf8=
X-Google-Smtp-Source: AGHT+IGAlITfVYzd8DhScqugYjRH2Umn84vSkWnZzDqtOwuyZIYx5kzZZ3ufcrPHnIufB7PqwcJY1w==
X-Received: by 2002:a17:903:4405:b0:23d:da20:1685 with SMTP id d9443c01a7336-23fb3065804mr32846585ad.4.1753448322695;
        Fri, 25 Jul 2025 05:58:42 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fadc8f669sm16852005ad.12.2025.07.25.05.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 05:58:42 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:48:58 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] bonding: support aggregator selection based
 on port priority
Message-ID: <aIN9OtPcnPtkqrks@fedora>
References: <20250724081632.12921-1-liuhangbin@gmail.com>
 <20250724081632.12921-3-liuhangbin@gmail.com>
 <d5b2f8df-8a2e-4319-809a-ec06d8381038@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5b2f8df-8a2e-4319-809a-ec06d8381038@blackwall.org>

On Fri, Jul 25, 2025 at 12:02:02PM +0300, Nikolay Aleksandrov wrote:
> > diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> > index 4a1b2f01fe37..6f8a406ed34a 100644
> > --- a/drivers/net/bonding/bond_3ad.c
> > +++ b/drivers/net/bonding/bond_3ad.c
> > @@ -747,6 +747,20 @@ static int __agg_active_ports(struct aggregator *agg)
> >  	return active;
> >  }
> >  
> > +static unsigned int __agg_ports_priority(struct aggregator *agg)
> 
> const agg?
> 
> > +{
> > +	struct port *port;
> > +	unsigned int prio = 0;
> 
> reverse xmas tree or alternatively you can save a line below with
> port = agg->lag_ports above

Thanks, I will fix this.

Hangbin
> 
> > +
> > +	for (port = agg->lag_ports; port;
> > +	     port = port->next_port_in_aggregator) {
> > +		if (port->is_enabled)
> > +			prio += port->actor_port_priority;
> > +	}
> 
> minor nit: {} are unnecessary
> 
> > +
> > +	return prio;
> > +}
> > +
> >  /**
> >   * __get_agg_bandwidth - get the total bandwidth of an aggregator
> >   * @aggregator: the aggregator we're looking at
> > @@ -1695,6 +1709,9 @@ static struct aggregator *ad_agg_selection_test(struct aggregator *best,
> >  	 * BOND_AD_COUNT: Select by count of ports.  If count is equal,
> >  	 *     select by bandwidth.
> >  	 *
> > +	 * BOND_AD_PRIO: Select by total priority of ports. If priority
> > +	 *     is equal, select by count.
> > +	 *
> >  	 * BOND_AD_STABLE, BOND_AD_BANDWIDTH: Select by bandwidth.
> >  	 */
> >  	if (!best)
> > @@ -1713,6 +1730,14 @@ static struct aggregator *ad_agg_selection_test(struct aggregator *best,
> >  		return best;
> >  
> >  	switch (__get_agg_selection_mode(curr->lag_ports)) {
> > +	case BOND_AD_PRIO:
> > +		if (__agg_ports_priority(curr) > __agg_ports_priority(best))
> > +			return curr;
> > +
> > +		if (__agg_ports_priority(curr) < __agg_ports_priority(best))
> > +			return best;
> > +
> > +		fallthrough;
> >  	case BOND_AD_COUNT:
> >  		if (__agg_active_ports(curr) > __agg_active_ports(best))
> >  			return curr;
> > @@ -1778,6 +1803,10 @@ static int agg_device_up(const struct aggregator *agg)
> >   * (slaves), and reselect whenever a link state change takes place or the
> >   * set of slaves in the bond changes.
> >   *
> > + * BOND_AD_PRIO: select the aggregator with highest total priority of ports
> > + * (slaves), and reselect whenever a link state change takes place or the
> > + * set of slaves in the bond changes.
> > + *
> >   * FIXME: this function MUST be called with the first agg in the bond, or
> >   * __get_active_agg() won't work correctly. This function should be better
> >   * called with the bond itself, and retrieve the first agg from it.
> > diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> > index 2b8606b4e4f5..708ca1f18a00 100644
> > --- a/drivers/net/bonding/bond_options.c
> > +++ b/drivers/net/bonding/bond_options.c
> > @@ -163,6 +163,7 @@ static const struct bond_opt_value bond_ad_select_tbl[] = {
> >  	{ "stable",    BOND_AD_STABLE,    BOND_VALFLAG_DEFAULT},
> >  	{ "bandwidth", BOND_AD_BANDWIDTH, 0},
> >  	{ "count",     BOND_AD_COUNT,     0},
> > +	{ "prio",      BOND_AD_PRIO,      0},
> >  	{ NULL,        -1,                0},
> >  };
> >  
> > diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
> > index bf551ca70359..34495df965f0 100644
> > --- a/include/net/bond_3ad.h
> > +++ b/include/net/bond_3ad.h
> > @@ -26,6 +26,7 @@ enum {
> >  	BOND_AD_STABLE = 0,
> >  	BOND_AD_BANDWIDTH = 1,
> >  	BOND_AD_COUNT = 2,
> > +	BOND_AD_PRIO = 3,
> >  };
> >  
> >  /* rx machine states(43.4.11 in the 802.3ad standard) */
> 

