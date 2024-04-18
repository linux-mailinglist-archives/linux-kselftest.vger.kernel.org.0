Return-Path: <linux-kselftest+bounces-8341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CBC8A9E00
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 17:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747D71F21513
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401ED16C444;
	Thu, 18 Apr 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFxETBMW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E99168AE3;
	Thu, 18 Apr 2024 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452977; cv=none; b=DkBF1VvU6m56GDPuG/k+j1KXq2BybxggX3bswNiaekb3yJWqZ77Yyx81YN4wJh6q3ISo5A1wz4dHM6N941dQ1siP7H3VdS/GRfz21S/uxhAuwJG43SJuwTtJWN3XMKxYK8WjX8W+n3ZboIpp8Cq313EvOB3LnWLt0PR8pW87y2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452977; c=relaxed/simple;
	bh=5V/8SD/HulFx4j7iUDTwTCRIQaTsnJpjphSUueb4kLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ybv1/tFvvTMJJxK0lihDQItO4FEmRWP65LRHE2TynjlBew9w9fVqHE6sNjCKrncajtZq4DKAHliM0eQKFtuyepjhGM1LPiB99kqvTNJChOB7aAIj75grmvXfWrg6dfo77mqCUOitwSqVddMOuBXTIctoMZQ7Mfv4QMO1YcYQQwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFxETBMW; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-343d2b20c4bso730258f8f.2;
        Thu, 18 Apr 2024 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713452974; x=1714057774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/4uukz7S3lJHc8p/Wazomkdz7qo+fUYZ/Ax/hIr994=;
        b=EFxETBMWJLT6aKLcIYwGEc0D5vPzinx7ZeNR2vAmZ051VUVUoIWBttmkLSsshpRSlD
         0HrLZdJu9SItHt3KUcgw7/YVoEY5LJUXDN8xCYHxj35dkKR4ZqTbm+a/+LukEItIv4rL
         bASxthHwpvStRrUTjnaFjuXrbU+nQ+25lCzWZTqZnhYcTNyc/SmujwJ8hi9svXDvUp8x
         hgMe7PRQnmqQBEV+RrUzV1h1K6YExO60dWx0R5HntlNK0i44KgQBPKqVyd+e0vr1jntI
         l8ytvJ3ct0h0Ej2cWGI21//ASjq9+jhpBGZL6ishhxGqKO8CIbhxVxbZuozV8ByeRVXP
         kavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452974; x=1714057774;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e/4uukz7S3lJHc8p/Wazomkdz7qo+fUYZ/Ax/hIr994=;
        b=D4Oy5txgiire4KY15dFdSP2oMOyvauMEImAIwqQTM/2yYpdDRo6GiGm42wqsOzNPPg
         L/YKUP/c6OtQLoe+Q4rP2ctMRz2QUwbdDlYq0C5PpW+iKh/FA3B9uxmH3ys8f57xVnBw
         frFT2n+V+Iwwyy2E6UzPKwRpv/dEFiFo0gBq8sntRpz73clfqhzBtLGhgDDLKlEWIFy1
         r6jsN5bLgfwNiaRoeeztexAf/vmIAoRYcujT326ebD71nze1LGs9BGs97vn9jR6B+ge3
         KkrsoDaDfAsHRav2WBXGSJYwqf0JQgANwop99axgWHPm6YYAqpAmRuxFdIrn1sw+Huhr
         7G0A==
X-Forwarded-Encrypted: i=1; AJvYcCUFBKavgPx/x00gvFQcAWZxfBVs5co/zKGDVD2KXsIskEllD0JhtXbPbm3W3CKjtGU3WbdlyMjItWNbJAp5QbWlph2j4TOANXOwaf8gyrHo6Oz/Wz9ZaDkljsA7XaWszr7a9UNrDPoUaE/V8iKIk2OqvUi6qQQsz1ZjXcg/9XJLMtKxKG38
X-Gm-Message-State: AOJu0Yy624hYT26jo9SZiPOWNiFhei9t5D/TmzG23pfT1HuPPj9SzaaZ
	ynkLVL/iaueE2wzUBGpwBjUPW2awuHmSRiGAdnn6DtCrDcgKKBqn
X-Google-Smtp-Source: AGHT+IHrs0oQ2LBEHPBjoqFp7Zn0xluXjWNAhtVqPhUzD8fzS6C0IOdJRiasHU1NnZnBtIz+RVHZJg==
X-Received: by 2002:a5d:6d8a:0:b0:346:bbd8:d512 with SMTP id l10-20020a5d6d8a000000b00346bbd8d512mr2641308wrs.9.1713452973658;
        Thu, 18 Apr 2024 08:09:33 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id u6-20020a5d6da6000000b00346ab3c372bsm2072060wrs.73.2024.04.18.08.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 08:09:33 -0700 (PDT)
Message-ID: <ae2f3e8b-7566-4ba9-ad83-31ff75fd28c6@gmail.com>
Date: Thu, 18 Apr 2024 17:09:22 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7 1/3] net: gro: add {inner_}network_offset to
 napi_gro_cb
To: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 willemdebruijn.kernel@gmail.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240412155533.115507-1-richardbgobert@gmail.com>
 <20240412155533.115507-2-richardbgobert@gmail.com>
 <49dafb7c4d4aef2946dac86296c29dc4c9b993d4.camel@redhat.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <49dafb7c4d4aef2946dac86296c29dc4c9b993d4.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On Fri, 2024-04-12 at 17:55 +0200, Richard Gobert wrote:
>> This patch adds network_offset and inner_network_offset to napi_gro_cb, and
>> makes sure both are set correctly. In the common path there's only one
>> write (skb_gro_reset_offset).
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> 
> Does not apply cleanly to net-next. You have to wait until the net
> dependency is merged into net-next before posting.
> 
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
>> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
>> index 9c18a39b0d0c..a6256ea1f5bc 100644
>> --- a/drivers/net/geneve.c
>> +++ b/drivers/net/geneve.c
>> @@ -545,6 +545,7 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
>>  	if (!ptype)
>>  		goto out;
>>  
>> +	NAPI_GRO_CB(skb)->inner_network_offset = hlen;
>>  	pp = call_gro_receive(ptype->callbacks.gro_receive, head, skb);
>>  	flush = 0;
>>  
>> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
>> index 6fb182d9d6e7..9fb93c3953c1 100644
>> --- a/drivers/net/vxlan/vxlan_core.c
>> +++ b/drivers/net/vxlan/vxlan_core.c
>> @@ -754,6 +754,7 @@ static struct sk_buff *vxlan_gpe_gro_receive(struct sock *sk,
>>  
>>  	vh = vxlan_gro_prepare_receive(sk, head, skb, &grc);
>>  	if (vh) {
>> +		NAPI_GRO_CB(skb)->inner_network_offset = skb_gro_offset(skb);
>>  		if (!vxlan_parse_gpe_proto(vh, &protocol))
>>  			goto out;
>>  		ptype = gro_find_receive_by_type(protocol);
> 
> What about vxlan_gro_receive? and fou/gue?
> 

No need to write in fou/gue functions, as both functions call
{inet,inet6}_offloads, which means if there's an IP/IPv6 header after
fou/gue - ipip_gro_receive will be called (or ip6ip6_gro_receive, or
sit_ip6ip6_gro_receive, etc), in which inner_network_offset is written.

vxlan_gro_receive calls eth_gro_receive, in which inner_network_offset
is written as well.

> Side note: the latter apparently exist mainly to make UDP-related
> changes more difficult, can we deprecated them once for all?
> 
> Thank,
> 
> Paolo
> 

