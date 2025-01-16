Return-Path: <linux-kselftest+bounces-24640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67446A1388B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 12:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284CC3A5A3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2939C1DD525;
	Thu, 16 Jan 2025 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGWig83e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B3F35968
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737025619; cv=none; b=cLJgFzv1xfQ6k10hUS3J62KV6TjcUu/y9EWhldNK3Ax7ROe3JDiLC/1KB5W6yYc3zfp4oYVZjhobQ8QU48A2lOjRMijDU74U5dAPbsmx/PzwXJ9P+LCGWLQwrz3BI1FIs6KGal8cNuUQ5VG0tCNjYk4lQAnHKDMWQR/JHtpu4iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737025619; c=relaxed/simple;
	bh=qKp3z4JMpyxDHEXYbnRXOikDAhQI5tqr+HNr1d1Knmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkcwCLQnMedAofTHaHSh6wl2hoYm8EDRDnWuWZLbEzKxGIi3418avqlgrCJ0E9Sppl+Gmx8MlzeQcpl7wjv94XLXJixHZR7m6CYRGJtpKircUgiiGubDu8EHdZDRnTQ25gk0p0Fzh+JnjkWaiTArzupDgNmCrXIwSZcCdX8Z0e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SGWig83e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737025616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nv7HOWzACKVg2N6gWvqQyDjzpd3I4hP/eBlBaHF3gw0=;
	b=SGWig83e6oXbSpqL97zY+xwXl1Tbxghy5oNj1vaIejWdK1pP3bAz3yqW5tbsjKr7I9/WcP
	BPIpJsP0LMXllDkQbiqZWRUyG66ZGRIHy/7MEuorwDhDXkl0+2i40+Dp+uOExvEEz58YMC
	xEWKnI31wolxvOiqOnbo4cs/SFEOJEw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-u9NJ15-VPgq8REOmY8fQPA-1; Thu, 16 Jan 2025 06:06:53 -0500
X-MC-Unique: u9NJ15-VPgq8REOmY8fQPA-1
X-Mimecast-MFC-AGG-ID: u9NJ15-VPgq8REOmY8fQPA
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d3d2cccbe4so829959a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 03:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737025612; x=1737630412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv7HOWzACKVg2N6gWvqQyDjzpd3I4hP/eBlBaHF3gw0=;
        b=spajsj8ZaQBMLH6d7+HNo3pRukQqvnWUSBU48F0/GhJp15X4oYIsNysEBSFXFN9Xfj
         0y0BpYGSfqYaNoX3QcVc4Ym78endQ6dA59NnZchTGpAl4l6Mipg7KDdxFdILJgyNu+zK
         Me5q7whcvahJYzsuINtxjnv3s4oblbflclKRnMy2a7B8pC1RYYy/2uMISSwgJs6ub4zT
         2kYhPCbLFyRwJtBLSsCEzTP0rKW25WcqP3RAc5RzVqsqN2g3k8fSsw598hKy6HsY3jug
         I84zyoy1ePvEhtLGgGcjhW+0DIRYDO7ucsHU+QMLoHn/JgviPO7mO9jtXZvAUvT+WZge
         xwmw==
X-Forwarded-Encrypted: i=1; AJvYcCXKbRMAfB6c6KQ8MhO4AJEaJRcHt2u7mfrTm2cXW/BIpJEMhHqmTq2EaiNHZpQtdH+ABXqshXcDvnhzUfiJkGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzea9YCxYJL89aI58uOiBcQfJsfKhJHSAPr3z9vAwz2KjMkjzE0
	W+tjOfvR2dBjFh+dbxYTl2UAKP4IRgRw48C4AICipsH47dro1gBxC4TARk3ljY3odPydLtoxRrJ
	c4p7Do4IiQLln7xJ8vQVfEzu+NphC9xgz/xg/Sj9cRcqNtAkOlOwZuPo0tBbgFKtLPA==
X-Gm-Gg: ASbGnctb/5DenfdDmh+BLVN7uz3TW8zBitr+HzZvusx9v/5lFmppyQQsqcWFoHLjP32
	oTtrOBNLUnkJFfWTqdnJflE9clftslWAv2I3v8vdWARD9gTO25Ptajx8BvvIZMHCmOQ/o02Dc9r
	Z3dAO/ZrnI1qrRAz/sCPSXO1S4o+KdG6O6LRPUg6mDJWGdem8oqYyf1m4LgKC2cdS1aCf1jFnAv
	f1xBJtGa3qAnWxxWf4InnZYUXk7vu7umjEw+vfDk249c2ug3Y8IpF1crkR+9+lx90v3mIgHgWlU
	wv0tkGCq5n0=
X-Received: by 2002:a05:6402:5006:b0:5d0:e877:7664 with SMTP id 4fb4d7f45d1cf-5d972e178f7mr30235230a12.19.1737025611944;
        Thu, 16 Jan 2025 03:06:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7+1RB3gyXIWLD3nNejq2NNpqGy7IPwbFJtkBypkOw2c2WJ5RjMN+wDjebJUHhRLb+a4Bx7A==
X-Received: by 2002:a05:6402:5006:b0:5d0:e877:7664 with SMTP id 4fb4d7f45d1cf-5d972e178f7mr30235204a12.19.1737025611530;
        Thu, 16 Jan 2025 03:06:51 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9900c3fccsm8627534a12.21.2025.01.16.03.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 03:06:51 -0800 (PST)
Message-ID: <b7305f0a-fe4d-4dd4-aaaf-77a08fd919ac@redhat.com>
Date: Thu, 16 Jan 2025 12:06:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v5] netlink: support dumping IPv4 multicast
 addresses
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20250114023740.3753350-1-yuyanghuang@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250114023740.3753350-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/25 3:37 AM, Yuyang Huang wrote:
> Extended RTM_GETMULTICAST to support dumping joined IPv4 multicast
> addresses, in addition to the existing IPv6 functionality. This allows
> userspace applications to retrieve both IPv4 and IPv6 multicast
> addresses through similar netlink command and then monitor future
> changes by registering to RTNLGRP_IPV4_MCADDR and RTNLGRP_IPV6_MCADDR.
> 
> This change includes a new ynl based selftest case. To run the test,
> execute the following command:
> 
> $ vng -v --user root --cpus 16 -- \
>     make -C tools/testing/selftests TARGETS=net \
>     TEST_PROGS=rtnetlink.py TEST_GEN_PROGS="" run_tests

Thanks for including the test!

> diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
> index 0d492500c7e5..7dcd5fddac9d 100644
> --- a/Documentation/netlink/specs/rt_link.yaml
> +++ b/Documentation/netlink/specs/rt_link.yaml
> @@ -92,6 +92,41 @@ definitions:
>        -
>          name: ifi-change
>          type: u32
> +  -
> +    name: ifaddrmsg
> +    type: struct
> +    members:
> +      -
> +        name: ifa-family
> +        type: u8
> +      -
> +        name: ifa-prefixlen
> +        type: u8
> +      -
> +        name: ifa-flags
> +        type: u8
> +      -
> +        name: ifa-scope
> +        type: u8
> +      -
> +        name: ifa-index
> +        type: u32
> +  -
> +    name: ifacacheinfo
> +    type: struct
> +    members:
> +      -
> +        name: ifa-prefered
> +        type: u32
> +      -
> +        name: ifa-valid
> +        type: u32
> +      -
> +        name: cstamp
> +        type: u32
> +      -
> +        name: tstamp
> +        type: u32
>    -
>      name: ifla-bridge-id
>      type: struct
> @@ -2253,6 +2288,18 @@ attribute-sets:
>        -
>          name: tailroom
>          type: u16
> +  -
> +    name: ifmcaddr-attrs
> +    attributes:
> +      -
> +        name: addr
> +        type: binary
> +        value: 7
> +      -
> +        name: cacheinfo
> +        type: binary
> +        struct: ifacacheinfo
> +        value: 6
>  
>  sub-messages:
>    -
> @@ -2493,6 +2540,29 @@ operations:
>          reply:
>            value: 92
>            attributes: *link-stats-attrs
> +    -
> +      name: getmaddrs
> +      doc: Get / dump IPv4/IPv6 multicast addresses.
> +      attribute-set: ifmcaddr-attrs
> +      fixed-header: ifaddrmsg
> +      do:
> +        request:
> +          value: 58
> +          attributes:
> +            - ifa-family
> +            - ifa-index
> +        reply:
> +          value: 58
> +          attributes: &mcaddr-attrs
> +            - addr
> +            - cacheinfo
> +      dump:
> +        request:
> +          value: 58
> +            - ifa-family
> +        reply:
> +          value: 58
> +          attributes: *mcaddr-attrs
>  
>  mcast-groups:
>    list:

IMHO the test case itself should land to a separate patch.

> diff --git a/include/linux/igmp.h b/include/linux/igmp.h
> index 073b30a9b850..a460e1ef0524 100644
> --- a/include/linux/igmp.h
> +++ b/include/linux/igmp.h
> @@ -16,6 +16,7 @@
>  #include <linux/ip.h>
>  #include <linux/refcount.h>
>  #include <linux/sockptr.h>
> +#include <net/addrconf.h>
>  #include <uapi/linux/igmp.h>
>  
>  static inline struct igmphdr *igmp_hdr(const struct sk_buff *skb)
> @@ -92,6 +93,16 @@ struct ip_mc_list {
>  	struct rcu_head		rcu;
>  };
>  
> +struct inet_fill_args {
> +	u32 portid;
> +	u32 seq;
> +	int event;
> +	unsigned int flags;
> +	int netnsid;
> +	int ifindex;
> +	enum addr_type_t type;
> +};

Why moving the struct definition here? IMHO addrconf.h is better suited
and will avoid additional headers dep.

> @@ -1874,6 +1894,23 @@ static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
>  	return err;
>  }
>  
> +static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
> +			    struct netlink_callback *cb, int *s_ip_idx,
> +			    struct inet_fill_args *fillargs)
> +{
> +	switch (fillargs->type) {
> +	case UNICAST_ADDR:
> +		fillargs->event = RTM_NEWADDR;

I think that adding an additional argument for 'event' to
inet_dump_addr() would simplify the code a bit.

> +		return in_dev_dump_ifaddr(in_dev, skb, cb, s_ip_idx, fillargs);
> +	case MULTICAST_ADDR:
> +		fillargs->event = RTM_GETMULTICAST;
> +		return in_dev_dump_ifmcaddr(in_dev, skb, cb, s_ip_idx,
> +					    fillargs);
> +	default:
> +		return 0;

Why not erroring out on unknown types? should never happen, right?

> @@ -1949,6 +1987,20 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
>  	return err;
>  }
>  
> +static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	enum addr_type_t type = UNICAST_ADDR;
> +
> +	return inet_dump_addr(skb, cb, type);

You can avoid the local variable usage.

> +}
> +
> +static int inet_dump_ifmcaddr(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	enum addr_type_t type = MULTICAST_ADDR;
> +
> +	return inet_dump_addr(skb, cb, type);

Same here.

Thanks!

Paolo


