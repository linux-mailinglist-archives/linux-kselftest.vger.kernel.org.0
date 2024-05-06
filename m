Return-Path: <linux-kselftest+bounces-9526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D2B8BD305
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 18:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C5FB212D7
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A56156960;
	Mon,  6 May 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0SKbmS9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8E713DDD8;
	Mon,  6 May 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013982; cv=none; b=QU6++bH4LeUbcYwURinvmkcd7L3hrIVeRJe8sWUTGLw7eBcfWt+V4sRy857ynhtth4XobEWqfEI39j3EjngLt6CWdY36NHp5+KlIWh7rb7YUsYSkiSJz7Y4jHcLm7gZOzXVIhYMYMS1Swuk3W1jfrqjjpXj6KSjvavtgeorK8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013982; c=relaxed/simple;
	bh=GOY7uF74aXtTWOzHLTtpIX38L22Nw4vV7OVkQIRNXrY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CjPno55+1RrWJFkm6RbByiCPUGByfh5tRfQIk4JxNDDLc7H5Ag8rzsS7Wq+VQSd0+FlDV0Y6W5KmElRA72IxyhqPBaNeU+yCvPvj5Wve0FHJdGvPmQ7CpOThuzkXh44iNbeYVHpApb+9gaJUJmn18eAtaVi9lTfC6LSRsqbLo0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0SKbmS9; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-69b50b8239fso21392856d6.0;
        Mon, 06 May 2024 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715013980; x=1715618780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzTio4TEar79DkyEXWbqorclupsXYPTSGL7v/jrECRU=;
        b=R0SKbmS9+RrK+17ALX/uTTzUIcJPqIkDgCsKfQ2KbzcuZ+MbzZOhI/OXXTNe92feOu
         x9KwMqgRSkbg38Bi4REhmvekBVfBso7hZHOQzeVdHmjWHZfI7R6wbrwOJT4K5mv6Q1W5
         oA7vPBUdpjlywN84koic/MFFsZz8zdlsmUII02hvJKfqeCyP5nCSkOuwS+QtkmFQznrO
         3A3yjrOoctfM2hbld9/U5mFLO2S2SepWoYmUC9w72k9YNm97QDZ1/RYzlhgskirHIIYA
         CtfvyWzVbmzv2YP39GBs/jLva2aAd7jfUyGkRw3VAv9BZRcF89JTGipm8PgMZMuyZNSU
         Qd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715013980; x=1715618780;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rzTio4TEar79DkyEXWbqorclupsXYPTSGL7v/jrECRU=;
        b=aTM/OUUsUBMN6mJtmwitWMKx3pkA/TC6DoNY0/wzFMefZXU/iRAmwbsnMlPJ240Bvv
         OruDLxQtVgkTi//dF3526uRXJpi32GV4PnuW7O1A14MAY6zUOFfN0ioOJwEI1wLsAMbf
         BpDhDEE6ooIXc+CARbAlD45+DZgw+KeQgvaqYync03FEK7Czd3Ts4/GRLVd6rJbpYa53
         gJqDPIy5aP1KLl5We1bH1Ueaf+ujO/GxDku4bIK+8+C0N/LSg0eED08K3P7gkrf2UmMg
         dmZ/yVUp1Ay2VveQfUpD7l6zPVVZJIY3cSIkVa3YBcfBGsAuYPtQOLbdKY9eJNPdvTHe
         RfqA==
X-Forwarded-Encrypted: i=1; AJvYcCVWdtOrE6J6fzEi30VSNe16hw9t0N5Q5HxgudOnn7LOtP2y7xBCHsW8l4gs0DBBilYKiXJXTozJv85C71zt9/NklGnzPptJL/fVY0wAOwymB/zkBl+SzHQnhYPhOpCT7/Kkp9/abFowJX4zu1XEvOEs60Tl18R8Bz/OXmXCxSjR87Obtpej
X-Gm-Message-State: AOJu0YzaNg3HKgAugJXp+7qc7PmQkCSL8s6WWgZF0fHhQcBXiXYovpJq
	bSSG7qZEMtxL9vkiyWNulQjzbQ72iJcu1x/W3xRoFdujtw8YEhkbdsFAWA==
X-Google-Smtp-Source: AGHT+IE3xtdUWGdZUHh2WDdnuoZ14EOUNPk8DJIeSttgiBQGOaGlyoUoPStBZlUyVBxOrITd/5wEug==
X-Received: by 2002:a05:6214:c84:b0:6a0:b3ec:9032 with SMTP id r4-20020a0562140c8400b006a0b3ec9032mr403317qvr.12.1715013979573;
        Mon, 06 May 2024 09:46:19 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id l13-20020ad4408d000000b006a0ee5b6ee6sm3869966qvp.123.2024.05.06.09.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 09:46:19 -0700 (PDT)
Date: Mon, 06 May 2024 12:46:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 alobakin@pm.me, 
 shuah@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Message-ID: <6639095ab4887_516de294d8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240506093550.128210-2-richardbgobert@gmail.com>
References: <20240506093550.128210-1-richardbgobert@gmail.com>
 <20240506093550.128210-2-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v8 1/3] net: gro: use cb instead of
 skb->network_header
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> This patch converts references of skb->network_header to napi_gro_cb's
> network_offset and inner_network_offset.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/gro.h        | 9 +++++++--
>  net/ipv4/af_inet.c       | 4 ----
>  net/ipv4/tcp_offload.c   | 3 ++-
>  net/ipv6/ip6_offload.c   | 5 ++---
>  net/ipv6/tcpv6_offload.c | 3 ++-
>  5 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/include/net/gro.h b/include/net/gro.h
> index c1d4ca0463a1..1faff23b66e8 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -181,12 +181,17 @@ static inline void *skb_gro_header(struct sk_buff *skb, unsigned int hlen,
>  	return ptr;
>  }
>  
> +static inline int skb_gro_network_offset(const struct sk_buff *skb)
> +{
> +	return NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark];
> +}
> +

The fact that .._receive sets encap_mark, but .._complete must read
encapsulation, due to the clear in udp_gro_complete, is non-obvious.

Can you add a comment to clarify this or rename this to
skb_gro_receive_network_offset?

>  static inline void *skb_gro_network_header(const struct sk_buff *skb)
>  {
>  	if (skb_gro_may_pull(skb, skb_gro_offset(skb)))
> -		return skb_gro_header_fast(skb, skb_network_offset(skb));
> +		return skb_gro_header_fast(skb, skb_gro_network_offset(skb));
>  
> -	return skb_network_header(skb);
> +	return skb->data + skb_gro_network_offset(skb);
>  }

