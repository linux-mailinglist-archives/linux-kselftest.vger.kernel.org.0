Return-Path: <linux-kselftest+bounces-30656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD2BA87854
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 09:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8A73AB496
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 07:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2061BD9C8;
	Mon, 14 Apr 2025 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6hGA2kE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27001B85CA;
	Mon, 14 Apr 2025 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744614138; cv=none; b=sEjPrlPFviDVtGG6Ri0ga9rpz2L1LMZ2uD3fDlCo6vTQibqDasBxmp3rMN3lSp5mB2gVEdeqdCCaPy+XHP0psCE6dwMdd78O8ypmEcaVeC1JZS9NF70H7wP9r+0EdtWD07k2E3/YajnHnmTTCUS7DN02QW+QWi3eGyGWcUKDzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744614138; c=relaxed/simple;
	bh=x+uSXNvn9FeBjHyDFM/li09nu7ZSVOMIL/PFUN+aRuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNZq7jKIO0D8uNiTUIA/HxbABAZtqk4mZGp/L4nZffI3yLc1Av2dAVM7sPukxGhz4kpbZKYs2kQkI/2R8xZ935OWsn0dZwbZxIdIY8ojkmexNtJa2XdvCEO5JIALw0FVNYJPdlrmllDy/W9qlLZ2Qn1kKLFe8yErbOiyOlDavNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6hGA2kE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2295d78b45cso54860855ad.0;
        Mon, 14 Apr 2025 00:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744614135; x=1745218935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plir7rmRtb7MsHHpJy0jinf92wikNIwAjXLhVwuX7rY=;
        b=j6hGA2kEcC3b7SepYcF9SGQLSUuNMDf/+Kf0k3t4fOw+JE9jhHV54llihWj5Q3291C
         FLIQuMUk1kHJLYsmdbTfFjFj9owNGvJZxaXL3956lycRHSgDmikwHqmzdJSwScEZ4mGn
         JOHbGcOahj2XJFkz5SQ4nqbIRRTO/FKzWUlCP/1ivsk42fhAD9bpjnqEX3o3DNZ7Awar
         6RXayEQZuSnsDvLvcYxy4Z5o4HSy6InbXZY/877xe0+tvrpwNWq+gA9OtgG5EIRyKJAB
         jyghSFicdXiGRgDxuhSxgHDPYL4H+FdqC7fq0kI+SxVbD4OyPfNZjXTNZOc0misU9o/p
         NgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744614135; x=1745218935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plir7rmRtb7MsHHpJy0jinf92wikNIwAjXLhVwuX7rY=;
        b=Pitv09ComIvCssxOI5cdEDpn1Rf4H8URR9UsrSDQpEEI+jwTjXoUkqon00ka5h5FBV
         1BFcTs26yVmj3eW7C9SWpSUlDi/D2Av8nA+/SSxlGs7OxGL+c6bnOkcoXrbMdoXbfQRO
         z7/wSeIaNdUJNA0yccuc/W10PPqRnva2ne9ElZkdvtJMAVqKo6gL+hU2QJNfYLhjFrVH
         a3XY8MHCzobRktUop8gXFN4RQRkHbGGCK9M51U+omSvAuBdo59OFzhLXPiu88Uur6yQv
         OzAU/t91m4JAbxQZDYLW2uSUbzv+/0QzSOmsZUQ7gCc0Tys/gabz+Edx2NiKLTXod7Kb
         LOiw==
X-Forwarded-Encrypted: i=1; AJvYcCXXOt5drBIeLSFsWQEe5RfbxZi3KiX7MO35yIPnJ44oOvL4Or8KJDA4iaU1vP5uoWOgsFm+vnCFrrbVOfixKHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rit4kb6zCYKeedj9Se6moR7/jUUh2xiewzB4csgKYK4lz5lI
	0RGtFk9EHvbzW7/fgblv87zsGS7VZC2iX8t3GHnxN+ISmyMxFxk4
X-Gm-Gg: ASbGncttgxRG5+MrC8Rd0fY3CC7e0LBCZj8dsryz8Y3yQYysM86qR8Xt9g3s8OFEiX6
	vqTDAQIzeA7kQv0bDc7B2T1ycepw55UgkSEkXi5mvt/4p0Mk4X3rAF6Ih6z29ONdJoQZ6WXJsRD
	CG0v1Rc2yecNNFOp25vcCNKmBxkqWizTM8SVWAsZdKY35u0cEMMPr3rwdaMxru4ljQhGR6ka/S2
	KoRXdV+w7/0J4JnjksAQd5PebGH85HsHoWOyYcyfXMwPlsBYljzPO8JJw2YxT0Kl1LupQQ3hTjq
	dTC33V525Jp98RlTQh8l6kF2hYGyaLwEyYhXu48mBiJAdg==
X-Google-Smtp-Source: AGHT+IEK1O22aNB0eKKTPhWz3Ft05m1zE4K6+TWwl5hUjLMJaTp+MWO7fU/xLicld4E0gAy6XTcaGw==
X-Received: by 2002:a17:902:d2c2:b0:227:e6fe:2908 with SMTP id d9443c01a7336-22bea50bd27mr152267275ad.48.1744614134683;
        Mon, 14 Apr 2025 00:02:14 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c971b4sm93001735ad.116.2025.04.14.00.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 00:02:14 -0700 (PDT)
Date: Mon, 14 Apr 2025 07:02:05 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Etienne Champetier <champetier.etienne@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 1/3] ipvlan: fix NETDEV_UP/NETDEV_DOWN event handling
Message-ID: <Z_yy7WpZQWJiScJl@fedora>
References: <20250403085857.17868-1-liuhangbin@gmail.com>
 <20250403085857.17868-2-liuhangbin@gmail.com>
 <Z-5i5rsrIyE0fM-V@krikkit>
 <Z-6IbvorOVx6hpxM@fedora>
 <Z-6ifi46d2JmnIch@krikkit>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-6ifi46d2JmnIch@krikkit>

On Thu, Apr 03, 2025 at 05:00:14PM +0200, Sabrina Dubroca wrote:
> 2025-04-03, 13:09:02 +0000, Hangbin Liu wrote:
> > Hi Sabrina,
> > On Thu, Apr 03, 2025 at 12:28:54PM +0200, Sabrina Dubroca wrote:
> > > Hello Hangbin,
> > > 
> > > 2025-04-03, 08:58:55 +0000, Hangbin Liu wrote:
> > > > When setting the lower-layer link up/down, the ipvlan device synchronizes
> > > > its state via netif_stacked_transfer_operstate(), which only checks the
> > > > carrier state. However, setting the link down does not necessarily change
> > > > the carrier state for virtual interfaces like bonding. This causes the
> > > > ipvlan state to become out of sync with the lower-layer link state.
> > > > 
> > > > If the lower link and ipvlan are in the same namespace, this issue is
> > > > hidden because ip link show checks the link state in IFLA_LINK and has
> > > > a m_flag to control the state, displaying M-DOWN in the flags. However,
> > > > if the ipvlan and the lower link are in different namespaces, this
> > > > information is not available, and the ipvlan link state remains unchanged.
> > > 
> > > Is the issue with the actual behavior (sending/receiving packets,
> > > etc), or just in how it's displayed by iproute?
> > 
> > The upper link in netns up while lower link down will cause the traffic break
> > in the pod.
> 
> That seems like the correct behavior based on the actual (not
> displayed) state of the links.

Hmm, since this behavior is controversial, do you think if we should
drop this until some users request?

> 
> 
> I wonder if netif_stacked_transfer_operstate should consider the admin
> state of the lower device as well as link state:
> 
> @@ -10724,7 +10724,7 @@ void netif_stacked_transfer_operstate(const struct net_device *rootdev,
>  	else
>  		netif_testing_off(dev);
>  
> -	if (netif_carrier_ok(rootdev))
> +	if (netif_carrier_ok(rootdev) && rootdev->flags & IFF_UP)
>  		netif_carrier_on(dev);
>  	else
>  		netif_carrier_off(dev);
> 
> 
> but I haven't looked at all the consequences and possible side
> effects.

I'm not sure. Only sync link carrier seems reasonable too.

Thanks
Hangbin

