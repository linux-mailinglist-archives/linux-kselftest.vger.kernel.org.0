Return-Path: <linux-kselftest+bounces-18612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA312989FB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90ADF2841A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFD918BBB0;
	Mon, 30 Sep 2024 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh82Jfa5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA4B65C;
	Mon, 30 Sep 2024 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693238; cv=none; b=hFhGFFg/pWwtrsz1ORzaXfBJC+UTV3/0wzoVEb3G/Zi8so1Ato5g8ahG7UkSz/WLV0jPf/RG+lVYXkvH3zvHGygommwSf9hu7o6vG/jx7+05hiB0ilahsl/cBWwLgadGUgg8wPZjnPg12fVsAoSEQ4DiA+QcmUN7fDJZ7bljgyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693238; c=relaxed/simple;
	bh=RD1va17Jbt35EjrjWUXzLXlmHcwbjcyl7NEwzPsMWNA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Hh842Zgexy5nQa8HhvsjY3tec9H3zhHw/iC5lnSWDrFiv6+/C1/lStF/TR1FcChMQq7xqHacN7Ii7NKma10oLeuiXS2Z1VIyUxo2mV4aYfH4Yumz1gLPZPxxniJjKojB1z1SN0zAUFF5Ex5GotTnSmy9f4WXhWuqO/m1dcMTE+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh82Jfa5; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cb2f344dbbso34586586d6.3;
        Mon, 30 Sep 2024 03:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727693236; x=1728298036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0u94IHt1BLB5zdPjjPogMXga2C6UPzIkgbNKBiUgS04=;
        b=Zh82Jfa5ggLGVMBsJBMzQ/XRGSvVy8p7LSUbghf2jzNaWvgDVeyLRc3TjNBhUxymep
         9Mw+km/xKQNPR8jSz3kEv0Ex08cDrXzWaAhIFGFni/JwIlWbXnD7KjRkGagvOjvq+H70
         Zw+zE50vJdWfZSTHRzPqpwzW/A5qzHJ2Y3N4r9F/dSkyB3WsBX6o0CwvuiLWtux4Qo73
         6AGn/+Kj7SdxfF9VTb/F4iwupdbiSGzwp0UnPdLupIi0qGl2516xBNygybxtMWzQq0hZ
         7dIAucq1hBNxOSVMtVPL7h69mywC221rtP40Oxc5qg4jjGsmx11oqxoqr4tvzRCmeH0S
         w9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727693236; x=1728298036;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0u94IHt1BLB5zdPjjPogMXga2C6UPzIkgbNKBiUgS04=;
        b=ZXVzql6qCzfgpA0PeBqFWDarQbs6InUJAwI6OX363RqyHzWepGYq/zpH0mFakiPIW7
         tDNVI44/T1GOlReqwgQX32euh7aaSkyO0uV6eTnqMbGr50zPTRw8+LdCrmxKSPmLsIDH
         2pfPxDbGxQZJmGJvDklbDUYgyfGKSppVKrIzUIM5VEDedhZT1JQhfgLUd6yfEWgJDzP/
         vAI3c/JcpSwtdnhW2N1rLG86J9ATVdoqTvxr9sylhY+MMMAzPh04AO6pfyGQf0hstCRm
         5faRUo+db7EF1j6ETD+FfFrMhqfopRawtqSZ3vl4zl+WmCVhad3SunzhROOjY9AGMKnT
         sE1w==
X-Forwarded-Encrypted: i=1; AJvYcCUNBHRP8hDjxexItVdYpUn4APda4kdKmWbzfig9ieuC99SOg8cIxHkTl5x/FiFpHrCjCim42e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxIYCGTFbQ15R7OFjI2zDTA+bxlfHa6Gh97vAIQDP99PB0dapn
	0E8EjCQrQ79JzJlYWoF5W/Xbc+HhcwSDqgO/aAI0xcTMynUZDXJz
X-Google-Smtp-Source: AGHT+IHLxcd9YdUCiWafl31MLlzf/keOW+AiZwpG/h9Yzn2AEuQrFaNWUYBqeU5aKr3f7tXidT7KSg==
X-Received: by 2002:a05:6214:5d82:b0:6cb:3a7b:96be with SMTP id 6a1803df08f44-6cb3b480d6emr212707976d6.0.1727693235859;
        Mon, 30 Sep 2024 03:47:15 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b5ff612sm38833316d6.9.2024.09.30.03.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:47:15 -0700 (PDT)
Date: Mon, 30 Sep 2024 06:47:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 willemb@google.com
Cc: linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66fa81b2ddf10_17948d294bb@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240930092416.80830-4-kerneljasonxing@gmail.com>
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
 <20240930092416.80830-4-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next 3/3] net-timestamp: namespacify the
 sysctl_tstamp_allow_data
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Let it be tuned in per netns by admins.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

+1 on the idea

> ---
>  include/net/netns/core.h   |  1 +
>  include/net/sock.h         |  2 --

also remove the static global from sock.c

>  net/core/net_namespace.c   |  1 +
>  net/core/skbuff.c          |  2 +-
>  net/core/sysctl_net_core.c | 18 +++++++++---------
>  5 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/netns/core.h b/include/net/netns/core.h
> index 78214f1b43a2..ef8b3105c632 100644
> --- a/include/net/netns/core.h
> +++ b/include/net/netns/core.h
> @@ -23,6 +23,7 @@ struct netns_core {
>  #if IS_ENABLED(CONFIG_RPS) && IS_ENABLED(CONFIG_SYSCTL)
>  	struct cpumask *rps_default_mask;
>  #endif
> +	int	sysctl_tstamp_allow_data;
>  };
>  
>  #endif
> diff --git a/include/net/sock.h b/include/net/sock.h
> index c58ca8dd561b..4f31be0fd671 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2808,8 +2808,6 @@ void sk_get_meminfo(const struct sock *sk, u32 *meminfo);
>  extern __u32 sysctl_wmem_max;
>  extern __u32 sysctl_rmem_max;
>  
> -extern int sysctl_tstamp_allow_data;
> -
>  extern __u32 sysctl_wmem_default;
>  extern __u32 sysctl_rmem_default;
>  
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index e39479f1c9a4..e78c01912c64 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -317,6 +317,7 @@ static __net_init void preinit_net_sysctl(struct net *net)
>  	 */
>  	net->core.sysctl_optmem_max = 128 * 1024;
>  	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
> +	net->core.sysctl_tstamp_allow_data = 1;
>  }
>  
>  /* init code that must occur even if setup_net() is not called. */
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 74149dc4ee31..ad727d924f73 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5506,7 +5506,7 @@ static bool skb_may_tx_timestamp(struct sock *sk, bool tsonly)
>  {
>  	bool ret;
>  
> -	if (likely(READ_ONCE(sysctl_tstamp_allow_data) || tsonly))
> +	if (likely(READ_ONCE(sock_net(sk)->core.sysctl_tstamp_allow_data) || tsonly))
>  		return true;

Let's switch order of the tests here too

