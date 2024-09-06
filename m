Return-Path: <linux-kselftest+bounces-17432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 820FE96FE6C
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 01:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86F11F23A43
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 23:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F5315B137;
	Fri,  6 Sep 2024 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9HWouLQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860C715990E;
	Fri,  6 Sep 2024 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665069; cv=none; b=ID879FpmIMh8GQq8N0bb12+tYMav9M4e0BsTL/Xwh/MzK/wwdH32g5NEmA3b5HkW0dJ/X+/FC8j8nwvmVI9K/oAlfPWTj1DqdPnxTYLBGvCNlI9BpLXPdR/tL47A3l0gLZBKjVvVzLnDdrniXWpt535lBIlswXzXBSpAxwiP9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665069; c=relaxed/simple;
	bh=8Lc4DxYvzjHZrefhAqr2ufn7iNlvPDBwf8zDZ89FKIM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GmBTdzRu1c7UMZS0X8nMFHURfML+1axoJDloptERqKFxbuf4OUXjidxEq17FuJXJC17b1xdQfJE91K9DsjGKlM2AKp4Fj3aQzuTkNvGpEYgJ8J5x6OuM9Hf5pREfW1NnpFoRL2gj1JvOthtGGC2wqW7LWAOMkYmw1gWU9aN9ReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9HWouLQ; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5dcd8403656so1794809eaf.1;
        Fri, 06 Sep 2024 16:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725665066; x=1726269866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOgw/fVdI/07FyZVisdpVjY/HlaG684C/g5rUZ9OCmE=;
        b=Q9HWouLQ88E1/7EHZGm0ZrhWDo/gZXNNYRX876U/dnJweLuohW1lMQjvJGsKj0VWyX
         S1HPlCE26EyVD2tzK3+so3ctaSTtkqgxwOHXu4zHKBH2UwAwrUBsJDkyGkV5Vww8HYIk
         VJPsksYSCiapXs17hRo5ZI+Wrkv28oOtbPZPD/u/YnpZ5JXiTP4jcqw7W4EJvipTCAB9
         I9GKhFTtjt32Lat5b0VqRB1jJCjxrD2SgWUofZ3J/05uSqPV6p+XUk+F0lOavHrtt+4n
         RE8MTWKh65D5sqI6uXJNcxHnysYeemkrXncRq7nwbBe3FmBEnwY3MXvIoAGL4bzR/0yv
         zYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725665066; x=1726269866;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tOgw/fVdI/07FyZVisdpVjY/HlaG684C/g5rUZ9OCmE=;
        b=DqwQiEWD9X+kC3sX6uBVFephPojHzUBZ/Jn6vFHPPtd9ceI+OPtJA+lzVKa39g2foN
         O5GHOnY/HdxSnI3ctWEtIiRsaqmI4/izoCGTJ87XgRJ5A3zYkqJoZsrrbeNwZRAJ2atk
         gqSjJFlcenZcAcJOSUHXN8Az3sA/7oN67xJHYdbQ4Et+qfANAlrOLW0gMTXByupZWJC0
         F7XDacTwHDS5LjlEs4H1s2L7GS+hohjaOCDFBjuJ0otT4V49iRS53oKmIbJQg21saaH5
         p7gLJYFsJbLUAiRTwIkgwUJu8k8y2lfM70V78ctm4pv2cJlyVEdn8MkxMz2Z56do3JsN
         arAA==
X-Forwarded-Encrypted: i=1; AJvYcCX/I+14FNq1DMeaVrPVBfIjIcnV6rYGK9jRiT0K7MjR0vpe9FCSjCHkXTAOfNYMwUya1vpT/40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKqDsWMNXQ7arV3UBFWjyab1IGpohGWiHWprSyeeOGywpSQ0AK
	Oi3TTHyZGgCTGu8WPrNTX+DZxA/LWM8gbtaD9TiD7YIEl0eO+/P3
X-Google-Smtp-Source: AGHT+IFs9VPaEshO98QUhC5RRDF0Mkoo6i7yhLz8vpCE9vFzUdt7U1dA3tk9cQz6by9TmYJONiDouA==
X-Received: by 2002:a05:6870:e0c6:b0:277:d932:deb1 with SMTP id 586e51a60fabf-27b9d852322mr1010016fac.18.1725665066368;
        Fri, 06 Sep 2024 16:24:26 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7946ae4sm2263285a.26.2024.09.06.16.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 16:24:25 -0700 (PDT)
Date: Fri, 06 Sep 2024 19:24:25 -0400
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
Message-ID: <66db8f293dbd1_2a33ef294b3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240906095640.77533-2-kerneljasonxing@gmail.com>
References: <20240906095640.77533-1-kerneljasonxing@gmail.com>
 <20240906095640.77533-2-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v5 1/2] net-timestamp: introduce
 SOF_TIMESTAMPING_OPT_RX_FILTER flag
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
> introduce a new flag SOF_TIMESTAMPING_OPT_RX_FILTER in the receive
> path. User can set it with SOF_TIMESTAMPING_SOFTWARE to filter
> out rx software timestamp report, especially after a process turns on
> netstamp_needed_key which can time stamp every incoming skb.
> 
> Previously, we found out if an application starts first which turns on
> netstamp_needed_key, then another one only passing SOF_TIMESTAMPING_SOFTWARE
> could also get rx timestamp. Now we handle this case by introducing this
> new flag without breaking users.
> 
> Quoting Willem to explain why we need the flag:
> "why a process would want to request software timestamp reporting, but
> not receive software timestamp generation. The only use I see is when
> the application does request
> SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE."
> 
> Similarly, this new flag could also be used for hardware case where we
> can set it with SOF_TIMESTAMPING_RAW_HARDWARE, then we won't receive
> hardware receive timestamp.
> 
> Another thing about errqueue in this patch I have a few words to say:
> In this case, we need to handle the egress path carefully, or else
> reporting the tx timestamp will fail. Egress path and ingress path will
> finally call sock_recv_timestamp(). We have to distinguish them.
> Errqueue is a good indicator to reflect the flow direction.
> 
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

High level: where is the harm in receiving unsolicited timestamps?
A process can easily ignore them. I do wonder if the only use case is
an overly strict testcase. Was reminded of this as I tried to write
a more concise paragraph for the documentation.

Otherwise implementation looks fine, only the tiniest nit.

> @@ -946,11 +946,17 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
>  
>  	memset(&tss, 0, sizeof(tss));
>  	tsflags = READ_ONCE(sk->sk_tsflags);
> -	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> +	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> +	     (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> +	     skb_is_err_queue(skb) ||
> +	     !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&

Nit: these statements should all align on the inner brace, so indent
by one character.

>  	    ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
>  		empty = 0;
>  	if (shhwtstamps &&
> -	    (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
> +	    (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
> +	    (tsflags & SOF_TIMESTAMPING_RX_HARDWARE ||
> +	    skb_is_err_queue(skb) ||
> +	    !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
>  	    !skb_is_swtx_tstamp(skb, false_tstamp)) {
>  		if_index = 0;
>  		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
> -- 
> 2.37.3
> 



