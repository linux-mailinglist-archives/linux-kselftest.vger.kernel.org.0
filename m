Return-Path: <linux-kselftest+bounces-17239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F6696DA9C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBD7288691
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 13:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2AB19D8B5;
	Thu,  5 Sep 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4s8pnt8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BBA19D891;
	Thu,  5 Sep 2024 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543903; cv=none; b=IrSuBzHWUPUD1mZ6/srReLMNt3H5ysX6CZ1ujvROWE8f/NZYyFo/ucEdIjs1RwzrfQXNAu7p1O3uKEGop+wB70gLRCAEOMJDvc5XcdivgLhxx/tVNfeM3CQ7xDkC+LyolGzD0RliNzXg/Tjvkub7lJ7rbOI9AJXVowZdeRPq+r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543903; c=relaxed/simple;
	bh=UywXeZjtfbMCktmGduebxY9v+409r4hw/bRtjdhx+kA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Q8ArO2ciAG+Gz8k7RIn6pBv7+R9QLmwDWdc/vnU7Dk2MBrm2q3TJNlS4yNKSkounFDUIneV2xs4NCmFXEZrZxyOcazjk34kZCfo7CED5AxdTP/Q/wt/JXfsPzRKQDMlYPayTchOQxGklD77F6Yo3fe9ecc+nXc5tkVS0ZFixXN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4s8pnt8; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a966f0a985so44394085a.3;
        Thu, 05 Sep 2024 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725543901; x=1726148701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6NlGpjZ9CN3CHioviLaEo/togUISt1TilQlZvW+jCM=;
        b=Z4s8pnt8ZW4pgiVy+uvoK9wrpCqjH0+KzruTyPBHA4Ly3PC7sKaYGb6io03sOCMEDj
         IFiUCYdZj/tWxAnUwgqUSRRRaMisjbIcBJnGpwbP9EeqNiDknNbFPk+gKlSzypkMJr9K
         abPUPHlFkLzIcaM3v50W7CjkzJ9EAKVoEpWV3rc1OeCTIUTanMoQuYoB7nx1+M2o1ubz
         HM7EYHt2KYzR4a9q4Ffjj0JX17eltDFKQAMli1RC0Pdj0u0u4ODWBOToyZoC9JrROw/p
         coKPKEGB0OX9nduJYKohd5Q1xZXtS1bNwlBozHicJJY9TwLycM0bdJz+lx+FMWe7E+6g
         hxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725543901; x=1726148701;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y6NlGpjZ9CN3CHioviLaEo/togUISt1TilQlZvW+jCM=;
        b=mPfRrTprBSPbtBh8vNSdn7IVbt6Z9BBNnmqwxidahOMiUfv1AIB1osawf3xCeqobaZ
         CncCB3jgUHaEJK6kl/SX2k9QWHKJv4ZtZa/DPSr5mYmQAONfbVn0dIi3F/mofWmftowm
         iA96Hm1s3/kYK1N/5LlZSLQBa7IggrJhCQbsm0z0WpJEWSXDG3RVUcsETuuNDx7Wa4Gu
         qkQeIdfvAOM+GCmCJ6GVT1ZnvuunuOHehT0GyCKInWQKo8E8yxXQ/kohpsw57RisGyac
         t8jgPDHyzMI0fedsEK0uQFLZSm3FuJ0fTpHlYud8dsJaG1SpDbJjbPjiYQTMr0o4au1m
         GieQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0P3AbSgYLs+nC9J+DFeAup9NeP6GrZ+AbCOBc0KVtORXkcxPSpEIFyAqoDeEEQokkf8ncBSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8XynTgM1lW6jhw6hjBSdCCd62QsflXDbUULmH6Yk875Wphj3
	mMW1aftZb3CplACkBNOSby0L8Qqo8ccixiHtYR+rcVhazLZVgr97
X-Google-Smtp-Source: AGHT+IFcs9TTAUHdLMA2+1/vGWAXeRKOsw/TblX6OMdHVc2DCYu5fpOjqbjnU3iGCoUN6WTZSmA7Cw==
X-Received: by 2002:a05:620a:4594:b0:7a6:68bc:3d17 with SMTP id af79cd13be357-7a97bc9bb37mr1102039085a.34.1725543900439;
        Thu, 05 Sep 2024 06:45:00 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef3b367sm75584585a.50.2024.09.05.06.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:44:59 -0700 (PDT)
Date: Thu, 05 Sep 2024 09:44:59 -0400
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
Message-ID: <66d9b5db807aa_18ac2129468@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240905071738.3725-4-kerneljasonxing@gmail.com>
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
 <20240905071738.3725-4-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v4 3/4] net-timestamp: extend
 SOF_TIMESTAMPING_OPT_RX_FILTER for hardware use
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
> In the previous patch, we found things could happen in the rx software
> timestamp. Here, we also noticed that, for rx hardware timestamp case,
> it could happen when one process enables the rx hardware timestamp
> generating flag first, then another process only setting
> SOF_TIMESTAMPING_RAW_HARDWARE report flag can still get the hardware
> timestamp.
> 
> In this patch, we extend the OPT_RX_FILTER flag to filter out the
> above case for hardware use.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> Link: https://lore.kernel.org/all/20240903121940.6390b958@kernel.org/
> ---
>  Documentation/networking/timestamping.rst | 15 +++++++++------
>  net/core/sock.c                           |  5 +++--
>  net/ipv4/tcp.c                            |  3 ++-
>  net/socket.c                              |  3 ++-
>  4 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
> index ac57d9de2f11..55e79ea71f3e 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -268,12 +268,15 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
>    each containing just one timestamp.
>  
>  SOF_TIMESTAMPING_OPT_RX_FILTER:
> -  Used in the receive software timestamp. Enabling the flag along with
> -  SOF_TIMESTAMPING_SOFTWARE will not report the rx timestamp to the
> -  userspace so that it can filter out the case where one process starts
> -  first which turns on netstamp_needed_key through setting generation
> -  flags like SOF_TIMESTAMPING_RX_SOFTWARE, then another one only passing
> -  SOF_TIMESTAMPING_SOFTWARE report flag could also get the rx timestamp.
> +  Used in the receive software/hardware timestamp. Enabling the flag
> +  along with SOF_TIMESTAMPING_SOFTWARE/SOF_TIMESTAMPING_RAW_HARDWARE
> +  will not report the rx timestamp to the userspace so that it can
> +  filter out the cases where 1) one process starts first which turns
> +  on netstamp_needed_key through setting generation flags like
> +  SOF_TIMESTAMPING_RX_SOFTWARE, or 2) similarly one process enables
> +  generating the hardware timestamp already, then another one only
> +  passing SOF_TIMESTAMPING_SOFTWARE report flag could also get the
> +  rx timestamp.

I think this patch should be squashed into patch 1.

Else SOF_TIMESTAMPING_OPT_RX_FILTER has two subtly different behaviors
across its lifetime. Even if it is only two SHA1s apart.

It also avoids such duplicate changes to the same code/text blocks.

More importantly, it matters for the behavior, see below.

>  
>    SOF_TIMESTAMPING_OPT_RX_FILTER prevents the application from being
>    influenced by others and let the application choose whether to report
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 6a93344e21cf..dc4a43cfff59 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -908,8 +908,9 @@ int sock_set_timestamping(struct sock *sk, int optname,
>  	    !(val & SOF_TIMESTAMPING_OPT_ID))
>  		return -EINVAL;
>  
> -	if (val & SOF_TIMESTAMPING_RX_SOFTWARE &&
> -	    val & SOF_TIMESTAMPING_OPT_RX_FILTER)
> +	if (val & SOF_TIMESTAMPING_OPT_RX_FILTER &&
> +	    (val & SOF_TIMESTAMPING_RX_SOFTWARE ||
> +	     val & SOF_TIMESTAMPING_RX_HARDWARE))
>  		return -EINVAL;

There may be legitimate use cases of wanting to receive hardware
receive timestamps, plus software transmit timestamp, but
suppress spurious software timestamps (or vice versa):

    SOF_TIMESTAMPING_RAW_HARDWARE | \
    SOF_TIMESTAMPING_RX_HARDWARE | \
    SOF_TIMESTAMPING_SOFTWARE | \
    SOF_TIMESTAMPING_TX_SOFTWARE | \
    SOF_TIMESTAMPING_OPT_RX_FILTER

Admittedly this seems a bit contrived. But it's little hassle to
support it?

We just can no longer use the branch simplification that Jakub
pointed out.


