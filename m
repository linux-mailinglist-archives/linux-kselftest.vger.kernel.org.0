Return-Path: <linux-kselftest+bounces-45708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7418CC61D53
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Nov 2025 22:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 21EC028A2F
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Nov 2025 21:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAB7255F2C;
	Sun, 16 Nov 2025 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOEhQRE5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12E11DED4C
	for <linux-kselftest@vger.kernel.org>; Sun, 16 Nov 2025 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763327396; cv=none; b=ItvfYs3RD0SpdMEg8eHrb9XlCp0zl2PFY49baDcPB37AtZKqu9bY7k5hDOJ+YXF3TVMYd/dC1KuFKAFbFb5QYyE76bGu+vLiGixmosVsbUKR6+Tl0VfCGH/w8IcC79At/Ufq1F1KZu6YBy2lFsHYNgtJUtaGIC7WfhbD7lHrNX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763327396; c=relaxed/simple;
	bh=w/758PrXfx8cJrtqndnSeU8XTnQskHpy/iy3f20Umvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xgy95pNlYpJHqFmPAaXGlF7nmkT/Mr5AmqjqfYG1AXZBqHCX+gW6ltmg73VPybfai7IYeofr0ukR0riYkVnlSnM3o8UMffBfJW/f4xvn4JVvkcIWg0KsyGGZfZ1AvN/lUEt2wEOrYKLLRom/SnYPwGNyRRpRwYQyuD4vrHr10KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOEhQRE5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47758595eecso19659025e9.0
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Nov 2025 13:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763327393; x=1763932193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F2EU+vr+r5HB39GgG3nHo3kDktkAyR50NweAgWjvrFg=;
        b=QOEhQRE5zmsuMpQBsx9yFjLBcBDLeeOOkElhiEL/ASDdOW3CnYVOFPdRF88Hg0npZ9
         rAwgZ+A6CamzkSChu7Z815ySZTRC1HAM2SugkgkBZ1lu+GZHcHHwF3WGuBCdbH04M+vl
         pDhPajuBhveHPp0FbR80C4eEoOOJRM16xrTeIgRUitQoXMNwGdmHMXSTY1YC/E7c5cdk
         3smexSt8Ipxsjk7wPgGIMofqoz304o8ZPbS8JOlJrzR4J4o7AsgoTT03acNm+/yI7yJv
         Jyc8ruzFfpcyH0Y5L38AlLqC6GeK+Is+ZzKkI8/gng1UNmlRwg85Vf2kyn75qlA99MX8
         CDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763327393; x=1763932193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2EU+vr+r5HB39GgG3nHo3kDktkAyR50NweAgWjvrFg=;
        b=rjlrZHXXU4Ox/aW/lDhPtREMcssxq0gQYMOH7nj7cAu3fSI8F6R2JPUl3Ft4Q/IymO
         vDHZksQnGCNQCOiyaWFKShKR2Zu8P0uLgS7P3vb9xl9hcMV7RpykeaaIwY3I06SBYVBn
         37cWyNl30ASdagvaYa9Xj5MWcgMyPQIDuoFKL31TtTowXWAdnEHWL9pgqzg98Y3hEBMC
         Qc8ESaI8cR/llnCvG03Y3gBqakOn2FxV8LZPk+uqfavjdoWJacrJgUTaVk7xu1c8gD0f
         uRVwMwjjdidbYTeZ2bdZDEnYudF5pVN9rfGz7devHQUyH421xME53I12EO+g8UL4AdFf
         llTw==
X-Forwarded-Encrypted: i=1; AJvYcCVoZ/G/DKlF0SnoUA7DuFXuCB9aIXOJ/xMlqTo/XPtHBNvsP7h5AlykS4D7wGvzrtAGzN7esZr1YwiOWZc8XPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9BxbMRXkI5SC42VlLnwFDhCScb+ZQQUbtl0lSkYbADn2Y3A2X
	pRDyh43de4EewBbQU/R0KYBP4uYxB3ygyhZxN5EyvEBNB34zoo0OK8uo
X-Gm-Gg: ASbGnct1WR2ny5hWy9/uopyTdcb2TkO7voingJntE+LlLb4PeZabSRXtqT83MfuNmLz
	kJyCkqpxGcxo6/fjoG1uAn+HOXNyU7dvt0uos6de18ErlPyqDGJ5RaspCu8G82eq8TdhixK2OQR
	yWs259A8GjWLz7eO0w28kk/VNNOVPEZUKDV1CT1aGZ9L3C99XuU7tXQacJLI2dlrDMumE792CJh
	LmKelgXMVBM4O99R4GHBOOoiPmFtnKTnvt31ceRtMkeeaoMvZWsDqehewugoQSnYAF0LYUpE4C+
	T+QvSFKghzvp2QNHsenmefdV6At/m77Fr701XeMQ4M2rt13qofxHoId6m5KqfKTxkeCaq2iSxSI
	zyk2G2B2bDmORI5gMbM6CV55x+wKlIK4ik/V7wak+Q9CrRzyfqoq6CjvsecoUSgPVIYWkdJixlc
	AhCV/0PKs2ZKgu+CZzPw==
X-Google-Smtp-Source: AGHT+IGYuuWX8ruQJ/vpBiUKI4FE5rGixyPIWWtvN9lIgcCm1rOXiN8drsz5iuWkKo1E0NePXOOc4A==
X-Received: by 2002:a05:600c:3550:b0:477:7946:dcf4 with SMTP id 5b1f17b1804b1-4778fe95b17mr92120905e9.24.1763327392989;
        Sun, 16 Nov 2025 13:09:52 -0800 (PST)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e84b12sm23533566f8f.15.2025.11.16.13.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 13:09:52 -0800 (PST)
Date: Sun, 16 Nov 2025 21:09:50 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/5] netconsole: resume previously
 deactivated target
Message-ID: <jzehwqghd7fgtsco6atgxhsttlwy4ydrlr4tage2d7i7z5qhgj@dktcsfhppyeh>
References: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
 <20251116-netcons-retrigger-v4-4-5290b5f140c2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116-netcons-retrigger-v4-4-5290b5f140c2@gmail.com>

On Sun, Nov 16, 2025 at 05:14:04PM +0000, Andre Carvalho wrote:
>  /* Handle network interface device notifications */
>  static int netconsole_netdev_event(struct notifier_block *this,
>  				   unsigned long event, void *ptr)
>  {
> -	unsigned long flags;
> -	struct netconsole_target *nt, *tmp;
>  	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +	struct netconsole_target *nt, *tmp;
> +	LIST_HEAD(resume_list);
>  	bool stopped = false;
> +	unsigned long flags;
>  
>  	if (!(event == NETDEV_CHANGENAME || event == NETDEV_UNREGISTER ||
> -	      event == NETDEV_RELEASE || event == NETDEV_JOIN))
> +	      event == NETDEV_RELEASE || event == NETDEV_JOIN ||
> +	      event == NETDEV_UP))
>  		goto done;
>  
>  	mutex_lock(&target_cleanup_list_lock);
> @@ -1475,6 +1537,11 @@ static int netconsole_netdev_event(struct notifier_block *this,
>  				stopped = true;
>  			}
>  		}
> +		if (event == NETDEV_UP && deactivated_target_match(nt, dev))
> +			/* maybe_resume_target is IRQ unsafe, remove target from
> +			 * target_list in order to resume it with IRQ enabled.
> +			 */
> +			list_move(&nt->list, &resume_list);
>  		netconsole_target_put(nt);
>  	}

I've noticed the test failure in CI (test #4 in netcons-over-bonding-sh) 
and I'm able to reproduce it locally. I was only running 'drivers/net' and missed
'drivers/net/bonding' netconsole tests locally - will adjust my tests to always
include those. They are certainly related to this changes.

Looking at logs, it seems like we re-enable the target before the interface is enslaved:

[   28.707460] netconsole: netconsole: local port 6665
[   28.707472] netconsole: netconsole: local IPv4 address 192.0.2.1
[   28.707479] netconsole: netconsole: interface name 'nsim950'
[   28.707483] netconsole: netconsole: local ethernet address '00:00:00:00:00:00'
[   28.707487] netconsole: netconsole: remote port 6666
[   28.707490] netconsole: netconsole: remote IPv4 address 192.0.2.2
[   28.707494] netconsole: netconsole: remote ethernet address 4a:00:f1:39:50:c4
[   28.707502] netpoll: netconsole: device nsim950 not up yet, forcing it
[   28.717516] netconsole: network logging started
[   28.740938] netconsole: network logging stopped on interface nsim950 as it is joining a master device
[   28.741034] netconsole: network logging resumed on interface nsim950
[   28.741076] bond_tx_25: (slave nsim950): Enslaving as an active interface with an up link
[   28.752003] printk: legacy console [netcon_ext0] disabled

I'll debug some more to understand this a bit better and think how to address it. Perhaps the
target needs to be DISABLED instead of DEACTIVATED when handling NETDEV_JOIN.

-- 
Andre Carvalho

