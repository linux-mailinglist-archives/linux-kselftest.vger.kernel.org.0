Return-Path: <linux-kselftest+bounces-29456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF67A69907
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 20:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6465B1B802E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 19:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCD820DD63;
	Wed, 19 Mar 2025 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGt75Ix7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848A81CAA81;
	Wed, 19 Mar 2025 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411923; cv=none; b=pX03alFvuvIJrf4znol8dF2GOTlL/1gbNJhGXtKJWbAvVzL3fR8J2qhK61WpvGEd2D9Ff9kj4e0yaB7AXm7gbAB9QoXSA+fooj+xp5q0aEb0wxewSI0VGb8wYbrphMZlry/wz6bwZKp812QUGsBb2Cdm79Uaq8riDmIF9Om6+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411923; c=relaxed/simple;
	bh=fCd7elDZWM9TbF2caKdqFUMKsgXTTve7IgUD0O7aD7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4RCIJkDjWzC+njGXjvvkk8F66taeOHxo7cfUo7KGVOvzYtZBBL1cl30kG4x0VyTN/XHrcIkmQZKffHswKnY4WcXmN6evWkk74IR7umClEuJY4XnmM0yp/my0KW3jmDQFcFVg2WsEv7POFUQKtoGJgMHe0NIvDZInD+qZqsuMPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGt75Ix7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so9750966b.0;
        Wed, 19 Mar 2025 12:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742411920; x=1743016720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76rXdYGiosZcArDP+GPvRYX93rVBHSRF1s8ahqff0Xw=;
        b=DGt75Ix7vsr4Q3p+quSee+74O3UhzkNH2yfxL5/btYkGw7j+b5qycgFp/uel6pVzPT
         Bexng2y8bO+o8xgis8eV1Bm6to77VPXGbwbSqLZ0DVVcsQoe0wSf/7nl9AAFu6Ll2vKz
         NQEN46gt6RNM35Rt5WKKn6s/bbW7NL1qvKnb/Yb4Efrm8GGwaFv4PGPKX+XcGsdfZjHe
         +siC49fbrevprWpnbcx1dcDeK0aWdXFwet2yFZd2z742GHQ0jlCImuD6XTQrPNZzVG4T
         k8LUQz2Pfm3d14Gh7jXDODXWVG4rRq6xBlF1LCGJEWrrfcI2j2/lyCb3QTVjb1q6Pp8u
         bslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742411920; x=1743016720;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76rXdYGiosZcArDP+GPvRYX93rVBHSRF1s8ahqff0Xw=;
        b=eyP+wrLji8T/9LvQoAseIxTAfWcDXA83A+7nAi0tn5FG7znL/GQripgh6XvGOwsBYZ
         L974VdPnr9o/BAUO0o+BnX11P4H7GcgN3UvxziCMpz7HRO/pVCHLe2fmNnXGGG/yxfWL
         H5ZLre2xCzpFigAG9POz1lGJAfcxazhKrgSGIcgXyJrKes1bIN+OHdemfysYRkrT9swx
         lzsGUu1UmJxa7pRtbmkEQFwSqQbKX1ksJ8+waST/Spiac1CksCHDUu9Wu0OSL+QEUftF
         2eQRlwpantVRm41u/3o3UXVAphDwU7I+TKNSo8VJQtEqobmBZv94FCIs2GF5b0h/VQa9
         MERg==
X-Forwarded-Encrypted: i=1; AJvYcCVIXfZIcQhAUXxd1n2z6sBrPFUQ5CveXf2++P2SVLWITADFRb0HhO/19ysA7FY6ZGLkH6ok/X9C68vAxBiSnLc=@vger.kernel.org, AJvYcCWX8S/y1I4ckhNtMV+iFIfxRs8tGUh89eaLgUs+2oq/xKOhYNfFk1s0H9SyOItzqDtNLBTGCK1q6nDZIF/BCWWZ@vger.kernel.org, AJvYcCXkSRqja//E6VcEtA5CAqzOFJQaRg58eVbhqPFuw5A8m0Q4uXBfYszv5HJ8CX7l6KCcXA2zuPj3@vger.kernel.org
X-Gm-Message-State: AOJu0YwpuXh1yfQ7NKIcZRFjT18+zpa+tsjcSY/Y5HekP/V5fAzFYkO6
	4nOdrfA3y9BEQDBYwICEJRUtn2xmNwUqLDdDVEg4E/6U38lidxAx
X-Gm-Gg: ASbGncu0Wk9TLEL1oaZczk4b/aZh378U3hDVn1Kfy+xswifPb4+3JRl9I8X5xQWFunn
	w8dUnFH1luaXSzLHW1FQOHiier3/KSOQzd81O29saPYgFs9OM54jzN74sYzB6dQy69511IHkC2p
	pmDupaPi2waARxNb7mU3cKVH0qU0iL0BWv+O7h7Tu7W7pmz6/XNlGua1/rRMK9LOJV8RxeWgjRU
	wc6isDmKTjM84/lcP0DbnhPIA9SPoeZgVh7uiqOAQMJRQtRklgtE06Pzf5xsgI7dBZsluaQPxVa
	OiIlDb9re0MKuEyRFHXgNeLI8dAHX65HsnykTG/WBvxtn1sO22DX+HI74gtUi+b5vDTY6JSqeac
	iKvLzK16Ojz1YU5nj7NWNhcCT9HnOlu7VKMMYWv1C0F68t+25T2+w2BPiVt8qRtw6dmEKEjX1Le
	Ky/sibVcr/Vr2UKKCzMhE=
X-Google-Smtp-Source: AGHT+IFsH9Vg/8XWJJyAcoTa3h82RYSbCaCHm7YY/12jziTpQuEDgAGkZsZYd7f8xxPAv4Yo7aJb1g==
X-Received: by 2002:a17:907:bb4c:b0:ac1:fbf8:6ae7 with SMTP id a640c23a62f3a-ac3b7c02376mr489571266b.13.1742411919425;
        Wed, 19 Mar 2025 12:18:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afe26bsm9467228a12.72.2025.03.19.12.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 12:18:38 -0700 (PDT)
Message-ID: <8a30aec8-fcc0-4d5f-b4e8-4cb60fe36725@gmail.com>
Date: Wed, 19 Mar 2025 20:18:36 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 nf-next 2/3] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 netfilter-devel@vger.kernel.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250315200033.17820-1-ericwouds@gmail.com>
 <20250315200033.17820-3-ericwouds@gmail.com> <Z9n8GHYfuhTFZB3p@calendula>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <Z9n8GHYfuhTFZB3p@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/19/25 12:04 AM, Pablo Neira Ayuso wrote:
> Hi,
> 
> On Sat, Mar 15, 2025 at 09:00:32PM +0100, Eric Woudstra wrote:
>> This adds the capability to evaluate 802.1ad, QinQ, PPPoE and PPPoE-in-Q
>> packets in the bridge filter chain.
>>
>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
>> ---
>>  net/netfilter/nft_chain_filter.c | 20 +++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
>> index 19a553550c76..7c7080c1a67d 100644
>> --- a/net/netfilter/nft_chain_filter.c
>> +++ b/net/netfilter/nft_chain_filter.c
>> @@ -232,11 +232,27 @@ nft_do_chain_bridge(void *priv,
>>  		    struct sk_buff *skb,
>>  		    const struct nf_hook_state *state)
>>  {
>> +	struct ethhdr *ethh = eth_hdr(skb);
>>  	struct nft_pktinfo pkt;
>> +	int thoff;
>>  
>>  	nft_set_pktinfo(&pkt, skb, state);
>>  
>> -	switch (eth_hdr(skb)->h_proto) {
>> +	switch (ethh->h_proto) {
>> +	case htons(ETH_P_PPP_SES):
>> +		thoff = PPPOE_SES_HLEN;
>> +		ethh += thoff;
> 
> This pointer arithmetics does not look correct, ethh is struct ethhdr,
> neither void nor char.
> 
>> +		break;
>> +	case htons(ETH_P_8021Q):
>> +		thoff = VLAN_HLEN;
>> +		ethh += thoff;
> 
> Same here.
> 
>> +		break;
>> +	default:
>> +		thoff = 0;
>> +		break;
>> +	}
>> +
>> +	switch (ethh->h_proto) {
> 
> This switch will match on the wrong offset.
> 
>>  	case htons(ETH_P_IP):
>>  		nft_set_pktinfo_ipv4_validate(&pkt);
>>  		break;
>> @@ -248,6 +264,8 @@ nft_do_chain_bridge(void *priv,
>>  		break;
>>  	}
>>  
>> +	pkt.thoff += thoff;
> 
> And only transport offset is adjusted here.
> 
>>  	return nft_do_chain(&pkt, priv);
>>  }
>>  
>> -- 
>> 2.47.1
>>

I will sort this out and send a new version after the merge window.

