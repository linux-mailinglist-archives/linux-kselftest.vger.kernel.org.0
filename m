Return-Path: <linux-kselftest+bounces-8254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5951A8A8562
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 15:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CE91F216B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E769B140397;
	Wed, 17 Apr 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjDipzf5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A812DDB2;
	Wed, 17 Apr 2024 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362258; cv=none; b=oy4gObZoPRSaYYSc3ifipupSbkUfWaRFr3gpDHqxmLM3ovvkToROuuqWH0IvW6153aYHd6DWH5kD9LthmpBfkF8hOL1u8rV/jBoZ7wdYtSIln9u4cQg4yN837yrTwiAqRIkBHQrgIlJMjaShlUl9MZg3rpelMOp7ljCN+CdKstI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362258; c=relaxed/simple;
	bh=GfdDaJaF6I8I6t+sUUjDGTmD1djsk6nhZvqhE3RJWXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X/U3Elmge6V9oX5anonZtBuo7SgmzLeNA1IkBgj2rhn2utvMhbM6oLAO3r7LsPz3GsgPdi/OQxrD3uKUzESUV26lT3FiHrj3RJSApCOIes2Zd9ySi17khE3Opd0jVXviH15rxIfVKhVgmJrqR+Y9+KNnaFb8LjHnEJIZXD8yp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjDipzf5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41551500a7eso31744365e9.2;
        Wed, 17 Apr 2024 06:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713362255; x=1713967055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bq6F5jb5Kt/vGqlutFyQe3zVfOLe7mptq1iSMaQ2i2g=;
        b=HjDipzf5LwqhDiqcK/Axd/fz8gXYKumJ0ESvD5KIL+XJnim5BCINi2cqkF51z5b5qm
         Gka3Uo31H2IUTen0d+CCi2NNfmV8ZMTVm5ygNNlyvRlhNfWuZcSaRYVmzbfdNlJr5KcD
         rvY3YHX7GGcO/RtA0tUYceP3fVTVCSVfpVAmlBSdOLUVz29TXU40wRIADkX4uVkrUbPh
         qofbpDPc5b0dqX+fNsfKdiYQWXVcxLvLQx4oSUAirJkdDWK4IydtH6ow0u6YA4aEBoUE
         rsWiZQptBYit2bWJnt3w9mPw1WPgkbfKDLLRYIUCVmJXD+9wlp/pKRIrs5Z1LTrzF+Zl
         MzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713362255; x=1713967055;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bq6F5jb5Kt/vGqlutFyQe3zVfOLe7mptq1iSMaQ2i2g=;
        b=Yg74TJGTwKwKfg2RkHSI5zm3hFqb9KHpwiEtjh3iA7QarACo2I+3oKFDlLxjIq/L4m
         p0k5q0LqLZ08UKujTbOenB5/A5bmZW5lALyDKfCYoZ363r0NTl6QQCXPfFlz0r8xeyMz
         gF8pvyWLNuxPLPddfTHyfi6JAdzSA6ZXlJ3UNaGolp4T+0tYrVGWW2vKhM6L34WScfBd
         +I88iCs8h9wW2IfOn84/tx6fKKQOBCGHbWR4RvemitXSGYqUy5OG74sC6eo/GbMBC4i+
         ax8NJkvMlXCksk7AYjRobwoDGByC6ua3IB5b6pKBpsVvY+pJ7GPysgevkffCipWN96jE
         HV6A==
X-Forwarded-Encrypted: i=1; AJvYcCUmyA1YnIFXzg4ffKTXItUh3u1D78g7XF8J5zalffSRe07NK/wY/5LzlHxF2Tyo0XmWhVdJuGh9cg4m7CiOvrBipMhHZX+oIm37zJWksI7kBuFPw1BMhqwtQCXEdaf6VuOHbzM7uCnYbLyiTzNL6ZM4YAeSG9ZJmMBZjHbegvR39BrcK15v
X-Gm-Message-State: AOJu0YzA4Jn/CU63HFDcNqcD7olfPLbHtA5G0FP84kKPnF5s5yj73HtI
	cha24/7oM/vUKYJyHSDN2u8TJ7SF0t5IKVeDNeI7jMWB9J8pso3h
X-Google-Smtp-Source: AGHT+IHJOn4Zu63iPcjn4/f8ultHn+Ei3MuSj6R1wtla6HZQDiM9H7h81GA6gbC6L6CdKgk8EFUAeA==
X-Received: by 2002:a05:600c:4e91:b0:418:1083:d2a0 with SMTP id f17-20020a05600c4e9100b004181083d2a0mr10442466wmq.21.1713362255319;
        Wed, 17 Apr 2024 06:57:35 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c154600b00418a02674edsm2949498wmg.38.2024.04.17.06.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 06:57:35 -0700 (PDT)
Message-ID: <265469cf-2dea-41fd-8d3e-d1fef7781673@gmail.com>
Date: Wed, 17 Apr 2024 15:57:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7 1/3] net: gro: add {inner_}network_offset to
 napi_gro_cb
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240412155533.115507-1-richardbgobert@gmail.com>
 <20240412155533.115507-2-richardbgobert@gmail.com>
 <661b2e2ef3396_3cb63829493@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <661b2e2ef3396_3cb63829493@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> This patch adds network_offset and inner_network_offset to napi_gro_cb, and
>> makes sure both are set correctly. In the common path there's only one
>> write (skb_gro_reset_offset).
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  drivers/net/geneve.c           |  1 +
>>  drivers/net/vxlan/vxlan_core.c |  1 +
>>  include/net/gro.h              | 18 ++++++++++++++++--
>>  net/8021q/vlan_core.c          |  2 ++
>>  net/core/gro.c                 |  1 +
>>  net/ethernet/eth.c             |  1 +
>>  net/ipv4/af_inet.c             |  5 +----
>>  net/ipv4/gre_offload.c         |  1 +
>>  net/ipv6/ip6_offload.c         |  8 ++++----
>>  9 files changed, 28 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/ipv4/gre_offload.c b/net/ipv4/gre_offload.c
>> index d4520c3f7c09..ae596285d78c 100644
>> --- a/net/ipv4/gre_offload.c
>> +++ b/net/ipv4/gre_offload.c
>> @@ -224,6 +224,7 @@ static struct sk_buff *gre_gro_receive(struct list_head *head,
>>  	/* Adjusted NAPI_GRO_CB(skb)->csum after skb_gro_pull()*/
>>  	skb_gro_postpull_rcsum(skb, greh, grehlen);
>>  
>> +	NAPI_GRO_CB(skb)->inner_network_offset = hlen;
>>  	pp = call_gro_receive(ptype->callbacks.gro_receive, head, skb);
>>  	flush = 0;
> 
> Nice that this even works for ETH_P_TEB, as eth_gro_receive will
> overwrite the offset written here.
>   
>   
>>  	list_for_each_entry(p, head, list) {
>>  		const struct ipv6hdr *iph2;
>> @@ -327,6 +325,7 @@ static struct sk_buff *sit_ip6ip6_gro_receive(struct list_head *head,
>>  	}
>>  
>>  	NAPI_GRO_CB(skb)->encap_mark = 1;
>> +	NAPI_GRO_CB(skb)->inner_network_offset = skb_gro_offset(skb);
>>  
>>  	return ipv6_gro_receive(head, skb);
>>  }
>> @@ -342,6 +341,7 @@ static struct sk_buff *ip4ip6_gro_receive(struct list_head *head,
>>  	}
>>  
>>  	NAPI_GRO_CB(skb)->encap_mark = 1;
>> +	NAPI_GRO_CB(skb)->inner_network_offset = skb_gro_offset(skb);
> 
> Do we still need encap_mark, or is it always set at the same time that
> inner_network_offset becomes non-zero?
> 

This would require setting inner_network_header to 0 before dev_gro_receive
which would not be favorable to the common case. (As opposed to encap_mark
which is already set to 0 as being part of NAPI_GRO_CB->zeroed). In my
opinion, it might also be less readable.

