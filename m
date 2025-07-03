Return-Path: <linux-kselftest+bounces-36406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB6AF6CC8
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 10:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E3918983AE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D1C142E73;
	Thu,  3 Jul 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="da1qKQSs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFCC2C3768
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Jul 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531135; cv=none; b=AznesQkufYqRCg/Dgc8hDzAhKi1uNmKljYl2N6yZwWYlU/I2VZYSAeiNGNQmBwNG4q9aYY0nGz9zyxFVps7eAy5dmdvLcdlNgDL3LvAxE7ZIIyqj5TWGuIlyEvMGxmt/w+vT11EAbSfO5rbIHGzsncg5MKtZ8YTtJwdKbm/YC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531135; c=relaxed/simple;
	bh=WsMySF/XcB+enG7DyeH/BxabpZ75lzse82G/1yaBK/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyQBvTmIe/6lMWPjg8XBFA7EIyoGNAcchu5LP7zbM2EIpo0PxRV1EGRScTthpYjN+trHSofZ0jk/+pnZ0cA8aR18Tm6gsMcrFyB+tLerdCX74IahMJx8eqV/PYFhNkJQmTeHr7yNv/pZ5T7qoNu6DeQCJU2pdd3vSJsZRvzuo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=da1qKQSs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751531132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+hX6eInL9oS4rYK6xxO61v+vUhZrgAJU3jCZ1aDIZs=;
	b=da1qKQSsGw/sI95vUZpyBUBnm9D2o/KbaF0wyojOWIzshOdc7kZuesI1gVF1NrGHXQ7iit
	LuyxR4aVzgx55vH6wj1HQS8YZlX0sRLQbKPjBuS98rWKFCssEnPHY9yNWU4ZR6U89QCZ53
	7sDqVTduCJmeIDfr2lvxmQkpNqHUbGE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-qGEMGIQcP_6oYgspJXcppw-1; Thu, 03 Jul 2025 04:25:31 -0400
X-MC-Unique: qGEMGIQcP_6oYgspJXcppw-1
X-Mimecast-MFC-AGG-ID: qGEMGIQcP_6oYgspJXcppw_1751531130
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45311704cdbso34579095e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Jul 2025 01:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751531130; x=1752135930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+hX6eInL9oS4rYK6xxO61v+vUhZrgAJU3jCZ1aDIZs=;
        b=nvSu8P6VQBJxs6q+T38QWdwXkPGfpI++USXdcREHHsnygdvKcAe/tDcpvcI7k7RU1D
         401qj+T/TBoz0L9B8W2hVvgod0vax1o2j59tWCzuIM0Qj3UIxtYgs6Oc2M+Xk8Wx1SDs
         uiCozAWpxgm1o1fLUcNouTTpbnK5vAuGAdb0LgshzB4+TlPSEkdvxafwPTdZBxGQywiJ
         qWCnhoFbhmnmwKHhAuFn0DABal8f8EQnKfgzBaPCaqZKbzxFVefXCCUUZN8Sk6TjWCw/
         ADSKsexkW2U5nJM8gtOIStEulUTqPhsefGZuUSm7lTaGzMGPNbUwSAviPqVtn+Su0+Fg
         7jPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6xY+X6PrDK02I7Fm5E0l40TSXOOkWwee08FkxprKBByYPkHopLEJKS8ni9ZsBelW/sbB9HAnmHYAc0DjyEnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaY/D5bfdnP5v9qEr/N83S6jy1ZtgPfmH5W6vcVg6oORgC+Ttz
	NwKc+mjunOEPaLjMeuHvIGjiDD3h0vzR8BNI1+TJAge21aQs8kFojRJEM/IA5UgP28avzLoIwEL
	Ph2NNd69UQgXd3qccxNofS5Zgk4ulZsQgvEEoIzbgJqYQdY8YSwWVD/DVkjhntNFOcks+/g==
X-Gm-Gg: ASbGncvhD//fvN8X7F788Y+6sWY8yOHtdLbKWSh+Cm8Cqi32av66G8BubEIEM1GkR4p
	jby+eXp+J5D/IKhE/BRF8UHwfkydBvqMoUDQ9zS6GQQNXEDuKQulc3dAwL1hcHv4PpGWgEDaYNI
	3DeTwDImIpOJE7oTpeQ9IlIk/3uXN3ONqthsJtFu3kgWKFlXjXZdwgS+Xt+pk696y64WTlt/lwb
	HNUJLl1ypyRA04eu8h1BHMUIbvtDmeDgjtow77UeeTKFXkE38BlPSBftcA5n/ORPcLKhyv94T2X
	o/u/3zlQddVdeJfvyDlCdfbgdEnF43GkCOJdgr04VUCqtKwtUqqVgdjOAFbZqUqVRAs=
X-Received: by 2002:a05:6000:41f8:b0:3a4:cfbf:519b with SMTP id ffacd0b85a97d-3b200f21705mr5119905f8f.44.1751531129568;
        Thu, 03 Jul 2025 01:25:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt0wGhX/7QeWiSV7/qkFnswJ1nG7iTz3wiXK6fyl4Kn+gzD3l6Je4qzbU7ES8yFJrUvN2IHw==
X-Received: by 2002:a05:6000:41f8:b0:3a4:cfbf:519b with SMTP id ffacd0b85a97d-3b200f21705mr5119870f8f.44.1751531129068;
        Thu, 03 Jul 2025 01:25:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f923sm17612340f8f.89.2025.07.03.01.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 01:25:28 -0700 (PDT)
Message-ID: <807503bf-4213-4423-b38b-ffdc11aaaeee@redhat.com>
Date: Thu, 3 Jul 2025 10:25:26 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: netfilter: Add IPIP flowtable SW
 acceleration
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jozsef Kadlecsik <kadlec@netfilter.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 linux-kselftest@vger.kernel.org
References: <20250627-nf-flowtable-ipip-v2-0-c713003ce75b@kernel.org>
 <20250627-nf-flowtable-ipip-v2-1-c713003ce75b@kernel.org>
 <aF6ygRse7xSy949F@calendula> <aF-6M-4SjQgRQw1j@lore-desk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aF-6M-4SjQgRQw1j@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/25 11:47 AM, Lorenzo Bianconi wrote:
>> On Fri, Jun 27, 2025 at 02:45:28PM +0200, Lorenzo Bianconi wrote:
>>> Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
>>> infrastructure.
>>> IPIP SW acceleration can be tested running the following scenario where
>>> the traffic is forwarded between two NICs (eth0 and eth1) and an IPIP
>>> tunnel is used to access a remote site (using eth1 as the underlay device):
>>>
>>> ETH0 -- TUN0 <==> ETH1 -- [IP network] -- TUN1 (192.168.100.2)
>>>
>>> $ip addr show
>>> 6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>>>     link/ether 00:00:22:33:11:55 brd ff:ff:ff:ff:ff:ff
>>>     inet 192.168.0.2/24 scope global eth0
>>>        valid_lft forever preferred_lft forever
>>> 7: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>>>     link/ether 00:11:22:33:11:55 brd ff:ff:ff:ff:ff:ff
>>>     inet 192.168.1.1/24 scope global eth1
>>>        valid_lft forever preferred_lft forever
>>> 8: tun0@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue state UNKNOWN group default qlen 1000
>>>     link/ipip 192.168.1.1 peer 192.168.1.2
>>>     inet 192.168.100.1/24 scope global tun0
>>>        valid_lft forever preferred_lft forever
>>>
>>> $ip route show
>>> default via 192.168.100.2 dev tun0
>>> 192.168.0.0/24 dev eth0 proto kernel scope link src 192.168.0.2
>>> 192.168.1.0/24 dev eth1 proto kernel scope link src 192.168.1.1
>>> 192.168.100.0/24 dev tun0 proto kernel scope link src 192.168.100.1
>>>
>>> $nft list ruleset
>>> table inet filter {
>>>         flowtable ft {
>>>                 hook ingress priority filter
>>>                 devices = { eth0, eth1 }
>>>         }
>>>
>>>         chain forward {
>>>                 type filter hook forward priority filter; policy accept;
>>>                 meta l4proto { tcp, udp } flow add @ft
>>>         }
>>> }
>>
>> Is there a proof that this accelerates forwarding?
> 
> I reproduced the scenario described above using veths (something similar to
> what is done in nft_flowtable.sh) and I got the following results:
> 
> - flowtable configured as above between the two router interfaces
> - TCP stream between client and server going via the IPIP tunnel
> - TCP stream transmitted into the IPIP tunnel:
>   - net-next:				~41Gbps
>   - net-next + IPIP flowtbale support:	~40Gbps
> - TCP stream received from the IPIP tunnel:
>   - net-next:				~35Gbps
>   - net-next + IPIP flowtbale support:	~49Gbps
> 
>>
>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>> ---
>>>  net/ipv4/ipip.c                  | 21 +++++++++++++++++++++
>>>  net/netfilter/nf_flow_table_ip.c | 28 ++++++++++++++++++++++++++--
>>>  2 files changed, 47 insertions(+), 2 deletions(-)
>>>
> 
> [...]
> 
>>>  static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
>>>  				       u32 *offset)
>>>  {
>>>  	struct vlan_ethhdr *veth;
>>>  	__be16 inner_proto;
>>> +	u16 size;
>>>  
>>>  	switch (skb->protocol) {
>>> +	case htons(ETH_P_IP):
>>> +		if (nf_flow_ip4_encap_proto(skb, &size))
>>> +			*offset += size;
>>
>> This is blindly skipping the outer IP header.
> 
> Do you mean we are supposed to validate the outer IP header performing the
> sanity checks done in nf_flow_tuple_ip()?

Yes.

Note that we could always obtain a possibly considerably tput
improvement stripping required validation ;)

I guess this should go via the netfilter tree, please adjust the patch
prefix accordingly.

Also why IP over IP specifically? I guess other kind of encapsulations
may benefit from similar path and are more ubiquitous.


/P


