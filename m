Return-Path: <linux-kselftest+bounces-17236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D841996DA81
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95018285ACC
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 13:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC1819CCE2;
	Thu,  5 Sep 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6NSEVlv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DCC1E481;
	Thu,  5 Sep 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543442; cv=none; b=G1v1XHRd3YlLVAHdO6TaD5qEQZ/dm1RSeiY6f7M7xfhhCgFzfK/4wtW/TQCS76umLm53u6go7dvpaz6C8wtW64fD/EBhaSuRZfe/3A/C8T4Ib59Y8jv3lgz42kHnTcxJC6XQecksNjwvuXLi6X7mv9yfy/BR3fezQKVvdyuHwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543442; c=relaxed/simple;
	bh=jlB1no2721uU9hVpuh5Zp2+qjFhM0iyP5FmTOp7Ajkc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mK0Me+7Mgg3+ns4wI+ks0kJ7ngu9mvpbgKgbYf4+etsr8giniTBmH6CdxEGjG+1tilye+x58wpfSOaBshLea79klaJtwI1ymmBPKM9nPqOXmy0wvtSQ80xOcA3A/uviopkJlr9kbfWxhcueX+Q5amnopz5+YUMGo9b/mDMB1svE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6NSEVlv; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a8160a710aso49925085a.1;
        Thu, 05 Sep 2024 06:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725543440; x=1726148240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtS7bt1aAN0GIuirSopYZGH6El4De1Pg3KFWNrEoxjo=;
        b=i6NSEVlvsWC3DW/vgKnDU9W3pzV5TnsdnNdSVDYbO3G1rFqlFrFpzb6Z58yLcgTbo4
         hWCiWsN0AjypV4GuEByrv3jXWrW59imPonhtbcFoYkylriMZ/nTglYlwLon6ruw9IZJM
         9Q5RAZq9A0DIHNDBKSnyEqk4WahAIqBy3UzFnzvLzYmImUUJVAfcw29QRFqvyenaZsqp
         xzMQ7DN1IzJrQOzfU08OS7urttVtC2AtUstk2zf3Tim7i7PCO7RC9KCSMEVj31bpJNir
         fCWTO1QVm1tQjmtWEfIM4zuoslDPC98/8AaPW+ZgQCdsI5Ns7W/RXEJUVFqT1YxiG4kD
         V/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725543440; x=1726148240;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RtS7bt1aAN0GIuirSopYZGH6El4De1Pg3KFWNrEoxjo=;
        b=EOlJT9kNYa/szxTC/p2zZ8+kB4ephDnAu/b4qGkme+6KMkXjdfOdnuNdiVF4t0VG/f
         /xS3C10hSFScURDVlWF8pQdrkIgVhPBFJMyZNHP7gaa4rRRgHeiwYtRLrSLuoG9tVe8z
         O7Z4vdAR2TXxorNIBHEOjYxspMELLUYdYYS+4M4I6CDlZ3YdfCiwlS/iwVp0hGAtKsH0
         zWebRlIYw/qAh86xqAnI1N5v1PilEgTdgrxkh/JspRtyg5+ECrymRweZmdjm1GGyY+VO
         WhsMzyXeJ/l7ndsNc0BHzR1KNEy6vmY8CsYIrzUeW8oiHUV9aogzEuzvY7bFB0JtCg8b
         NWHA==
X-Forwarded-Encrypted: i=1; AJvYcCU0+GzAx16aNVzO7B9/YBqD1blHvxhN7QPyfoSgQ0D5JBAUoIZBggCLCjXh+NrnVFum09qxN8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy94b48ZSewZtJfeQqyG00OYzlKBed49Q+gDH4taNAiUARNrY4O
	cIpBhRVcPRVmJPeepdauXQYiC/MOO8Enoazr7ndF2f0l2aWLMLpRLCedOg==
X-Google-Smtp-Source: AGHT+IFF/CC1Od5w9jAoQVm02I/p501Tah2WwiOBOTU85JqxidlRSEjK1o14CNAWtp/aaNluqogbTw==
X-Received: by 2002:a05:620a:1909:b0:7a1:e20c:186e with SMTP id af79cd13be357-7a8a3e308acmr2073254785a.15.1725543439710;
        Thu, 05 Sep 2024 06:37:19 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef1cfd9sm75710885a.16.2024.09.05.06.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:37:19 -0700 (PDT)
Date: Thu, 05 Sep 2024 09:37:18 -0400
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
Message-ID: <66d9b40ecd086_18ac212943@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240905071738.3725-2-kerneljasonxing@gmail.com>
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
 <20240905071738.3725-2-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v4 1/4] net-timestamp: filter out report when
 setting SOF_TIMESTAMPING_SOFTWARE
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
> In this way, we have two kinds of combination:
> 1. setting SOF_TIMESTAMPING_SOFTWARE|SOF_TIMESTAMPING_RX_SOFTWARE, it
> will surely allow users to get the rx software timestamp report.
> 2. setting SOF_TIMESTAMPING_SOFTWARE|SOF_TIMESTAMPING_OPT_RX_FILTER
> while the skb is timestamped, it will stop reporting the rx software
> timestamp.
> 
> Another thing about errqueue in this patch I have a few words to say:
> In this case, we need to handle the egress path carefully, or else
> reporting the tx timestamp will fail. Egress path and ingress path will
> finally call sock_recv_timestamp(). We have to distinguish them.
> Errqueue is a good indicator to reflect the flow direction.
> 
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

nit: Reviewed-by tags are only sticky if no changes are made.

> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
> index 5e93cd71f99f..37ead02be3b1 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -266,6 +266,18 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
>    two separate messages will be looped to the socket's error queue,
>    each containing just one timestamp.
>  
> +SOF_TIMESTAMPING_OPT_RX_FILTER:
> +  Used in the receive software timestamp. Enabling the flag along with
> +  SOF_TIMESTAMPING_SOFTWARE will not report the rx timestamp to the
> +  userspace so that it can filter out the case where one process starts
> +  first which turns on netstamp_needed_key through setting generation
> +  flags like SOF_TIMESTAMPING_RX_SOFTWARE, then another one only passing
> +  SOF_TIMESTAMPING_SOFTWARE report flag could also get the rx timestamp.

This raises the question: why would a process request
report flag SOF_TIMESTAMPING_SOFTWARE without generate flag
SOF_TIMESTAMPING_RX_SOFTWARE? The only sensible use case I see is when
it sets SOF_TIMSETAMPING_TX_SOFTWARE. Probably good to mention that.

May also be good to mention that existing applications sometimes set
SOF_TIMESTAMPING_SOFTWARE only, because they implicitly came to depend
on another (usually daemon) process to enable rx timestamps systemwide.

> +
> +  SOF_TIMESTAMPING_OPT_RX_FILTER prevents the application from being
> +  influenced by others and let the application choose whether to report
> +  the timestamp in the receive path or not.
> +

I'd drop this paragraph. It's more of a value statement.


