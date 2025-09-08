Return-Path: <linux-kselftest+bounces-40992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DF2B49B36
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 22:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6286618941E3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 20:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958D2DC35F;
	Mon,  8 Sep 2025 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="SfRhTp1a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CB61798F
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Sep 2025 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757364450; cv=none; b=TNdaxW5WTr1qgp4QMxUq1Mr8MKiqmQCDuMOwgJs9iY68IwImqJodwfiOONX7AFJP31vdTKZvUTRBBdYfnOd19aQUxpUAZxTj1sd9b1BXOKFKT4utYmQx9JbeDuB6tDfjc/X4cmgy455C/ohMjm0T4DGPoN1jZnT2WScvKjj1k90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757364450; c=relaxed/simple;
	bh=YKKxSwyTIBd9mjDB+qKz1REMUGLWEBaGpgrm4p7F3mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dc0m7BuDu8vdBvNnEFPBQh2c/6+rcWKYd0EScqXMX5j2ymDBd7QNM9ajSpFyjlF/yshOXZQs/sPPQKzg9fbfKURFBd+yAh2NLIzmrM96ZtHGKg4Mcn7B2039LhtBTvRjKYO6+BJNkU96dsqeuChNbP8TE0sAoPsOcmd82X/9lzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=SfRhTp1a; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24c89867a17so47385655ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Sep 2025 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1757364447; x=1757969247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iP4tQG17FxLA2u0B9bKbrzzkdZjZOjWIZIzpoM1+rjA=;
        b=SfRhTp1aWjGGnwudzM5EvCXwKyCAuJXLLzkSQGnXiLKEV+Pjfq1Rl4V47GJSuUmV+V
         74XKiDVO4QgWRL/bUY+4B5UfD0P5WKmC5pPn5uUKrYRyD0nFg18An+xSQF4XwgZP00I+
         9KBmTZWaahFdBb7dAjOqdpTdrbysmCx6S2VVTr5rqCOpOlBOUKxA5Gbe3AO5CSM3W4Qt
         7xv1X7W5aqHITbM7WlJ/JtbMRCh1pAqzVX2FpUPoIBstmPbrMRo7hu/RL3o9/DxxuyP0
         J4a3y4KrvQVSRn6otixitQGzz8P1AWGKxKlemIFWUeIpvB1c2MC/Wl7Yta2TkHV6D9hw
         OvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757364447; x=1757969247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP4tQG17FxLA2u0B9bKbrzzkdZjZOjWIZIzpoM1+rjA=;
        b=o3cWn7xVVmbBFJ/Dz7LOWXO6y5Cqkiy/h3KhHRXBCGRpjt2Tdu8Ve64GcI4PQ7lpuE
         Zf/GpDFGgErIBtUyhbTlqBnEcxi5kv/ZotDhUXJbN7PVc9BjwVkyaTTdlskZVoXVW54r
         6jzxh2PbLAVgkHoLkBp051GAsGgid+hxcTAcxMfM0UnKHx/FCPjQ8snWnJ3P1TPWRtAL
         i+BT9BgHUpize9f9lmFaF7JARaOp5S5Lc5Sd3ole1ea6zkaGoNcpnnK9NmZt8zV6yplp
         qm8x9T+rOBByFTcw2+BCBvHjJEE+9mwkvPwOVfDP+nGBXNtkItZFoguJDzj/jPmeXFWJ
         GI3g==
X-Forwarded-Encrypted: i=1; AJvYcCU1uv/gdZNo1mflMTEJy8pW5U/FJvTm6J4zt8/TFgbfKj6Tr0LiCFgLxEpheYYDc+hjc9mZR34Xo2QDZTx6Qmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLfg7gcfYpIQ1XhMU7ruoMDTtqDdSlDbHt3/a3vKs+xxNblVs
	cmGqRKG07nhSlfWYuzKegys9CnLi0eRMrYlfNYCZOTNQKjUJp0QQaJUNDjFl//skn34=
X-Gm-Gg: ASbGncvlEgXk40vKG+pMLN6fIx0XV6WAwedd0xGvJ3QlBEiq2Qk5V2Tg+9iKZFFIM4T
	jsetvXTaAgfiWUYf4bBw30D61vuqIvJzThbELuD6kemQY2VAT5bgHddAtVj7WsETR9Yr1MVzPEA
	FgwDW163p+Db7lL6I8xtYTt0Q8EUMQvRjC69PJXATZXkyXtnl02EgcZ135C7VvsK68oadplIkUf
	4zBkwrLjphVEH9/PUZoBYVHwrQegzxfHDEQ2GVHMGWj6Ye8wIP0h8hmyyw0re1Ej+nXu9AFpc15
	HjjCLrfCFcfpbHrqhOH3hjAnRf/y44G3m6tGwcW/apMn5JGH8ilCqx1v1MVAYgavgMjoqiFkkRL
	9hM1mXxU4kRbK/6AgZeiXlS76Fw7E4ZqMh0I=
X-Google-Smtp-Source: AGHT+IEFBuInL+DneJcr3VRDS17E6y4PwmSKDTAiiJ6BGt+ppjgTDkzNHMg5bs1Pf238HenN9lXafg==
X-Received: by 2002:a17:903:2286:b0:24a:f7dc:caa3 with SMTP id d9443c01a7336-251715f33f7mr111877765ad.37.1757364447508;
        Mon, 08 Sep 2025 13:47:27 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccd655823sm119166405ad.114.2025.09.08.13.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 13:47:27 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:47:24 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	asantostc@gmail.com, efault@gmx.de, kernel-team@meta.com,
	stable@vger.kernel.org, jv@jvosburgh.net
Subject: Re: [PATCH net v3 1/3] netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Message-ID: <aL9A3JDyx3TxAzLf@mozart.vkv.me>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
 <20250905-netconsole_torture-v3-1-875c7febd316@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905-netconsole_torture-v3-1-875c7febd316@debian.org>

On Friday 09/05 at 10:25 -0700, Breno Leitao wrote:
> commit efa95b01da18 ("netpoll: fix use after free") incorrectly
> ignored the refcount and prematurely set dev->npinfo to NULL during
> netpoll cleanup, leading to improper behavior and memory leaks.
> 
> Scenario causing lack of proper cleanup:
> 
> 1) A netpoll is associated with a NIC (e.g., eth0) and netdev->npinfo is
>    allocated, and refcnt = 1
>    - Keep in mind that npinfo is shared among all netpoll instances. In
>      this case, there is just one.
> 
> 2) Another netpoll is also associated with the same NIC and
>    npinfo->refcnt += 1.
>    - Now dev->npinfo->refcnt = 2;
>    - There is just one npinfo associated to the netdev.
> 
> 3) When the first netpolls goes to clean up:
>    - The first cleanup succeeds and clears np->dev->npinfo, ignoring
>      refcnt.
>      - It basically calls `RCU_INIT_POINTER(np->dev->npinfo, NULL);`
>    - Set dev->npinfo = NULL, without proper cleanup
>    - No ->ndo_netpoll_cleanup() is either called
> 
> 4) Now the second target tries to clean up
>    - The second cleanup fails because np->dev->npinfo is already NULL.
>      * In this case, ops->ndo_netpoll_cleanup() was never called, and
>        the skb pool is not cleaned as well (for the second netpoll
>        instance)
>   - This leaks npinfo and skbpool skbs, which is clearly reported by
>     kmemleak.
> 
> Revert commit efa95b01da18 ("netpoll: fix use after free") and adds
> clarifying comments emphasizing that npinfo cleanup should only happen
> once the refcount reaches zero, ensuring stable and correct netpoll
> behavior.

This makes sense to me.

Just curious, did you try the original OOPS reproducer?
https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/

I wonder if there might be a demon lurking in bonding+netpoll that this
was papering over? Not a reason not to fix the leaks IMO, I'm just
curious, I don't want to spend time on it if you already did :)

The discussion on v1 isn't enlightening either:
https://lore.kernel.org/lkml/0f692012238337f2c40893319830ae042523ce18.1404172155.git.decot@googlers.com/

Thanks,
Calvin

> Cc: stable@vger.kernel.org
> Cc: jv@jvosburgh.net
> Fixes: efa95b01da18 ("netpoll: fix use after free")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/core/netpoll.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 5f65b62346d4e..19676cd379640 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -815,6 +815,10 @@ static void __netpoll_cleanup(struct netpoll *np)
>  	if (!npinfo)
>  		return;
>  
> +	/* At this point, there is a single npinfo instance per netdevice, and
> +	 * its refcnt tracks how many netpoll structures are linked to it. We
> +	 * only perform npinfo cleanup when the refcnt decrements to zero.
> +	 */
>  	if (refcount_dec_and_test(&npinfo->refcnt)) {
>  		const struct net_device_ops *ops;
>  
> @@ -824,8 +828,7 @@ static void __netpoll_cleanup(struct netpoll *np)
>  
>  		RCU_INIT_POINTER(np->dev->npinfo, NULL);
>  		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
> -	} else
> -		RCU_INIT_POINTER(np->dev->npinfo, NULL);
> +	}
>  
>  	skb_pool_flush(np);
>  }
> 
> -- 
> 2.47.3
> 

