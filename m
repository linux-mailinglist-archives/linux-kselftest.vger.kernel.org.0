Return-Path: <linux-kselftest+bounces-45290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D63EC4CEE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABC91885669
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 10:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA034338911;
	Tue, 11 Nov 2025 10:12:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1A532BF32
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855953; cv=none; b=MDVO74gl04mjdddaHICSp4zXyuLEnPP+m3tpNK9SII78ERrBMDdrlmD1EwtJXLZRuKbGq7v5zVx7jx5mYOYKxu8b4CjnAR/cf6RxqEghnyPBqB3n3hZU3+AumIW5IUVU9BeW+z+yZFLr6GoVW4xAP67yi/O42hxHt5onIXWovvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855953; c=relaxed/simple;
	bh=WAj76DydZj4CIC9aQ/rvGOUH+A9Zbu1Qohl7CV2gKcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0PIDy2319DJC1v/yiQz6dIbsbMOqorLfOI/p5tLopIh6P0b8zz54f6okxDm4Nv1ZNYTbWRTKEC1n9lGAEmu70LfoCkGF7MRfmORKNRVRuKhu3+EfplEbSv105JqAawFxXkzP/xTFOvmhgjqGEGw5PRwRV5p/7gGBa0p+m/4dXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-44fa4808c15so577199b6e.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 02:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762855951; x=1763460751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d93P9SBrZbsmx5OIoldWG9QXDZwaWCjQ8D5gNZLMBrU=;
        b=tRnwaarsaQetASYIdDm0LwPeYsSdgoBQVfc+6Ujyxij+afYFxVgxsdSkEIyfmdTddf
         aElGluzjMshnB7L/PFr5ieGoT6t88NhCpZOWBBRTdL3XjpcmrJzygj0Wse8Ro7Lxs9ma
         O6aC4oZwdOVr/lMrzM+TF08Fhjuec4rxkUC6kTzaOV6PQ3MqQVU/f9Ob0uBaW9C7BQDA
         QV6S3+LWdlwVuPbTYFYgVTuIJL0rR4D53mKp2Lp1qRgHYb42xPXa7kLvutVL212a7QjA
         m6X7C25C+EwJ1FwFv1KWUGsASqyztZjbKt1PGBVVvaFsdMf7yRyavrYv7vkBtnPpK8uc
         Kr+A==
X-Forwarded-Encrypted: i=1; AJvYcCVfS19bGs0XI83ltAK7Qpb2olLzswSQ5gWlKVfjTwv2f2g2zEqhsv1vI+rEOX8EVu6Y2wO9c1c/f4VXjNO9I/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaMbQi873DWUoPKVrllvxJkhG0SoUbZutVBQNq5a+tD1YpHPTA
	plC7q+xZsdOTRdDQADEJR0rneNasPyVGXvF02y/vG30OJmBk9fuAUOjY
X-Gm-Gg: ASbGnctF7KNsi5q6tW/lX2C8R27uSpBF9vHcwjH/ovSUsXtPE3Qiwh9BNTvp/4LD/5e
	ePGVxEJf7sbE/0H5eSCTJOqOzjT1zylgUpD2OmObamXzQydsNVGZiBd5bwS0tglKhqN7N225py5
	376gi+Q5Vg6a8OrLBn2DIhdxXA9bwJdzDYep1l9J7IRZ1AWdGE0OU0QoS9qJcLYK6n2TqA1aJhu
	0TABFDDA98GYegZWWxYMAbEms5ud/rgGbOjBC41FIShfrURxmz8pKShW2aQZCXfH9obOnVvIelk
	kz8CE86s/k1VjCIvYS9T8+/3n/B6vs7X0KwzJucnOLF+IjBlShoNC0U4AAo66M9JxMxT84I6PO3
	G/a5D4Ek7rU4gorLEjwru/eRGosplXq1DeHddkxPH+TiM+cZdkuCagT4IwQh1kOgmpUDVtyoTxB
	GmOLkFTsNcjcumzg==
X-Google-Smtp-Source: AGHT+IH7+LY6boZXNhSOAKanHLT9JkTRtS0g/6VaSLyR6710lVl+xvo91GwsE75JjB1doJnEGSLx6A==
X-Received: by 2002:a05:6808:1924:b0:43f:2140:c5b7 with SMTP id 5614622812f47-4502a1d129amr5768112b6e.19.1762855950943;
        Tue, 11 Nov 2025 02:12:30 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c5713288sm6875102eaf.5.2025.11.11.02.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:12:30 -0800 (PST)
Date: Tue, 11 Nov 2025 02:12:26 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/6] netconsole: resume previously
 deactivated target
Message-ID: <e4loxbog76cspufl7hu37uhdc54dtqjqryikwsnktdncpqvonb@mu6rsa3qbtvk>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
 <20251109-netcons-retrigger-v3-5-1654c280bbe6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109-netcons-retrigger-v3-5-1654c280bbe6@gmail.com>

On Sun, Nov 09, 2025 at 11:05:55AM +0000, Andre Carvalho wrote:
> Attempt to resume a previously deactivated target when the associated
> interface comes back (NETDEV_UP event is received) by calling
> __netpoll_setup_hold on the device.
> 
> Depending on how the target was setup (by mac or interface name), the
> corresponding field is compared with the device being brought up.
> 
> Targets that are candidates for resuming are removed from the target list
> and added to a temporarily list, as __netpoll_setup_hold might allocate.
> __netpoll_setup_hold assumes RTNL is held (which is guaranteed to be the
> case when handling the event) and holds a reference to the device in case
> of success. This reference will be removed upon target (or netconsole)
> removal by netpoll_cleanup.
> 
> Target transitions to STATE_DISABLED in case of failures resuming it to
> avoid retrying the same target indefinitely.
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>
> ---
>  drivers/net/netconsole.c | 62 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 5a374e6d178d..50d6df101c20 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -135,10 +135,12 @@ enum target_state {
>   * @stats:	Packet send stats for the target. Used for debugging.
>   * @state:	State of the target.
>   *		Visible from userspace (read-write).
> - *		We maintain a strict 1:1 correspondence between this and
> - *		whether the corresponding netpoll is active or inactive.
> + *		From a userspace perspective, the target is either enabled or
> + *		disabled. Internally, although both STATE_DISABLED and
> + *		STATE_DEACTIVATED correspond to inactive netpoll the latter is>
> + *		due to interface state changes and may recover automatically.

 *		disabled. Internally, although both STATE_DISABLED and
 *		STATE_DEACTIVATED correspond to inactive targets, the latter is
 *		due to automatic interface state changes and will try
 *		recover automatically, if the interface comes back
 *		online.

>   *		Also, other parameters of a target may be modified at
> - *		runtime only when it is disabled (state == STATE_DISABLED).
> + *		runtime only when it is disabled (state != STATE_ENABLED).
>   * @extended:	Denotes whether console is extended or not.
>   * @release:	Denotes whether kernel release version should be prepended
>   *		to the message. Depends on extended console.
> @@ -1445,17 +1447,50 @@ static int prepare_extradata(struct netconsole_target *nt)
>  }
>  #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
>  
> +/* Attempts to resume logging to a deactivated target. */
> +static void maybe_resume_target(struct netconsole_target *nt,
> +				struct net_device *ndev)
> +{
> +	int ret;
> +
> +	ret = __netpoll_setup_hold(&nt->np, ndev);
> +	if (ret) {
> +		/* netpoll fails setup once, do not try again. */
> +		nt->state = STATE_DISABLED;
> +	} else {
> +		nt->state = STATE_ENABLED;
> +		pr_info("network logging resumed on interface %s\n",
> +			nt->np.dev_name);
> +	}
> +}

I am not sure that helper is useful, I would simplify the last patch
with this one and write something like:


	/* Attempts to resume logging to a deactivated target. */
	static void maybe_resume_target(struct netconsole_target *nt,
					struct net_device *ndev)
	{
		int ret;

		ret = __netpoll_setup_hold(&nt->np, ndev);
		if (ret) {
			/* netpoll fails setup once, do not try again. */
			nt->state = STATE_DISABLED;
			return;
		}

		netdev_hold(ndev, &np->dev_tracker, GFP_KERNEL);
		nt->state = STATE_ENABLED;
		pr_info("network logging resumed on interface %s\n",
			nt->np.dev_name);
	}

> +
> +/* Check if the target was bound by mac address. */
> +static bool bound_by_mac(struct netconsole_target *nt)
> +{
> +	return is_valid_ether_addr(nt->np.dev_mac);
> +}

Awesome. I liked this helper. It might be useful it some other places, and
eventually transformed into a specific type in the target (in case we need to
in the future)

Can we use it egress_dev also? If so, please separate this in a separate patch.

> +/* Checks if a target matches a device. */
> +static bool target_match(struct netconsole_target *nt, struct net_device *ndev)
> +{
> +	if (bound_by_mac(nt))
> +		return !memcmp(nt->np.dev_mac, ndev->dev_addr, ETH_ALEN);
> +	return !strncmp(nt->np.dev_name, ndev->name, IFNAMSIZ);
> +}
> +
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
> @@ -1475,11 +1510,26 @@ static int netconsole_netdev_event(struct notifier_block *this,
>  				stopped = true;
>  			}
>  		}
> +		if (nt->state == STATE_DEACTIVATED && event == NETDEV_UP &&
> +		    target_match(nt, dev))
> +			list_move(&nt->list, &resume_list);

I think it would be better to move the nt->state == STATE_DEACTIVATED to target_match and use
the case above. As the following:

	if (nt->np.dev == dev) {
		switch (event) {
		case NETDEV_CHANGENAME:
		....
		case NETDEV_UP:
			if (target_match(nt, dev))
				list_move(&nt->list, &resume_list);


>  		netconsole_target_put(nt);
>  	}
>  	spin_unlock_irqrestore(&target_list_lock, flags);
>  	mutex_unlock(&target_cleanup_list_lock);
>  

Write a comment saying that maybe_resume_target() might be called with IRQ
enabled.


> +	list_for_each_entry_safe(nt, tmp, &resume_list, list) {
> +		maybe_resume_target(nt, dev);
> +
> +		/* At this point the target is either enabled or disabled and
> +		 * was cleaned up before getting deactivated. Either way, add it
> +		 * back to target list.
> +		 */
> +		spin_lock_irqsave(&target_list_lock, flags);
> +		list_move(&nt->list, &target_list);
> +		spin_unlock_irqrestore(&target_list_lock, flags);
> +	}
> +
>  	if (stopped) {
>  		const char *msg = "had an event";
>  
Also, extract the code below in a static function. Similar to
netconsole_process_cleanups_core(), but passing resume_list argument.

Let's try to keep netconsole_netdev_event() simple to read and reason about.

