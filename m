Return-Path: <linux-kselftest+bounces-2508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5438B81FA05
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 17:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81981F2290F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68572F4EC;
	Thu, 28 Dec 2023 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3Q0dp+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5952F508;
	Thu, 28 Dec 2023 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3366e78d872so5771183f8f.3;
        Thu, 28 Dec 2023 08:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703781980; x=1704386780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HL44JUUhIKonj5eVSNHWcy9AQst+n9F23ADYisb5HcY=;
        b=T3Q0dp+zuRevHOj3B6OCtBfWF8rFDh8uZ2ZgNagX3I5uLfGAPpEc6JMtCI7w0dr4FR
         Nbtmuw19pq7hDSQ6Uj/HExhMGaZ4fhKSMrNxap82OlPX2q/q4FwiHnpCNlt5bnKBKMnL
         7YUYQNyZXlG228O9T/UvhqVJiJ8qE7/XD6SyZ4LiQRYblOrVy/K7bKJg36EwCe1Fbos7
         Tbd1V2MFCR794B45V/aC2rxzDmy0UKsBN1VZnkgiaiQr8/WDozu+RrObji7dGao1eNrV
         NfOXsPjiRl1Qgc/X7IFCsW+nlhvmQEAm8Ml7NMSYN/9VyqynafJLFkpvZRFggKYGozyf
         xPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703781980; x=1704386780;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HL44JUUhIKonj5eVSNHWcy9AQst+n9F23ADYisb5HcY=;
        b=TyIOoX7/PB8TcsRw9YowaYwWf40RrZ1037Xxh2NP47w60AOpnZxBNRC9lYH8Fg6ovB
         NHb0Pmkf+oIjwWkB/NPCYadgqIqtx5QKw0UMIjpzkN/KrR999dXejwr00ucjEevM0J+2
         ku4OkVfhZnmwr0vUXX2wuiq1VMAyMty0IPqitQQZmFi3wvYzMQBUMsjsp1+Wz9XO16bZ
         +6DRG8LKyLdSZW7RbZSLMEZaQI7HL7NG9W9VXosfflHOyZmcbYW1qysnmy2KLGocEnFT
         t9KeNfGPeTJvAG1IQaHrPsqMqBtbe2e2X7bkm22OaH87KIdx/1OPVVMnhTNd701XjrVQ
         GYnQ==
X-Gm-Message-State: AOJu0YxRafWeRS7QLQRezsc5locmvhQ9eO5DNsc1eUmqwjlNABwGqoOV
	iuJzkowiFMDi6BcI1lvH0aA=
X-Google-Smtp-Source: AGHT+IGH9WSkQ04Dg6hqTXmMDXycqTobxQtdmxWU/EXdSWUi2D3m1GmUEPiVwPfwHfnaYFxsIE1nsQ==
X-Received: by 2002:adf:ab1b:0:b0:336:76f5:c7c7 with SMTP id q27-20020adfab1b000000b0033676f5c7c7mr2796013wrc.249.1703781979737;
        Thu, 28 Dec 2023 08:46:19 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id t18-20020a0560001a5200b0033699668c2dsm13820008wry.32.2023.12.28.08.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 08:46:19 -0800 (PST)
Message-ID: <40054646-09d9-0bd7-aaa6-24bbfe3d5f0c@gmail.com>
Date: Thu, 28 Dec 2023 17:46:44 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/3] net: gro: parse ipv6 ext headers without
 frag0
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <f4eff69d-3917-4c42-8c6b-d09597ac4437@gmail.com>
 <32febbc9-e603-4400-addd-bdb97ce56c1d@gmail.com>
 <658b4cd4241c8_5c2a929499@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <658b4cd4241c8_5c2a929499@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



Willem de Bruijn wrote:
> Richard Gobert wrote:
>> This commit utilizes a new helper function, ipv6_gro_pull_exthdrs, which
>> is used in ipv6_gro_receive to pull ipv6 ext headers instead of
>> ipv6_gso_pull_exthdrs. To use ipv6_gso_pull_exthdr, pskb_pull and
>> __skb_push must be used, and frag0 must be invalidated. This commit
>> removes unnecessary code around the call to ipv6_gso_pull_exthdrs and
>> enables the frag0 fast path in IPv6 packets with ext headers.
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  net/ipv6/ip6_offload.c | 51 +++++++++++++++++++++++++++++++++---------
>>  1 file changed, 41 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
>> index 0e0b5fed0995..a3b8d9127dbb 100644
>> --- a/net/ipv6/ip6_offload.c
>> +++ b/net/ipv6/ip6_offload.c
>> @@ -37,6 +37,40 @@
>>  		INDIRECT_CALL_L4(cb, f2, f1, head, skb);	\
>>  })
>>  
>> +static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
>> +{
>> +	const struct net_offload *ops = NULL;
>> +	struct ipv6_opt_hdr *opth;
>> +
>> +	for (;;) {
>> +		int len;
>> +
>> +		ops = rcu_dereference(inet6_offloads[proto]);
>> +
>> +		if (unlikely(!ops))
>> +			break;
>> +
>> +		if (!(ops->flags & INET6_PROTO_GSO_EXTHDR))
>> +			break;
>> +
>> +		opth = skb_gro_header(skb, off + 8, off);
> 
> When changing this code, it would be great to make it more self
> documenting. It's not entirely clear what that 8 is based on.
> sizeof(*opth) is only 2. Probably an optimization to handle the most
> common extension headers in a single pskb_may_pull? If so, this new
> code does not have that concern, so can just use sizeof(*opth). Or
> else add a const int likely_max_opt_hdr_len = 8 or so.
> 
> 
>> +		if (unlikely(!opth))
>> +			break;
>> +
>> +		len = ipv6_optlen(opth);
>> +
>> +		opth = skb_gro_header(skb, off + len, off);
>> +		if (unlikely(!opth))
>> +			break;
>> +		proto = opth->nexthdr;
>> +
>> +		off += len;
>> +	}
>> +
>> +	skb_gro_pull(skb, off - skb_network_offset(skb));
>> +	return proto;
>> +}
>> +
>>  static int ipv6_gso_pull_exthdrs(struct sk_buff *skb, int proto)
>>  {
>>  	const struct net_offload *ops = NULL;
>> @@ -203,28 +237,25 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
>>  		goto out;
>>  
>>  	skb_set_network_header(skb, off);
>> -	skb_gro_pull(skb, sizeof(*iph));
>> -	skb_set_transport_header(skb, skb_gro_offset(skb));
>>  
>> -	flush += ntohs(iph->payload_len) != skb_gro_len(skb);
>> +	flush += ntohs(iph->payload_len) != skb->len - hlen;
>>  
>>  	proto = iph->nexthdr;
>>  	ops = rcu_dereference(inet6_offloads[proto]);
>>  	if (!ops || !ops->callbacks.gro_receive) {
>> -		pskb_pull(skb, skb_gro_offset(skb));
>> -		skb_gro_frag0_invalidate(skb);
>> -		proto = ipv6_gso_pull_exthdrs(skb, proto);
>> -		skb_gro_pull(skb, -skb_transport_offset(skb));
>> -		skb_reset_transport_header(skb);
>> -		__skb_push(skb, skb_gro_offset(skb));
>> +		proto = ipv6_gro_pull_exthdrs(skb, hlen, proto);
>>  
>>  		ops = rcu_dereference(inet6_offloads[proto]);
>>  		if (!ops || !ops->callbacks.gro_receive)
>>  			goto out;
>>  
>> -		iph = ipv6_hdr(skb);
>> +		iph = skb_gro_network_header(skb);
>> +	} else {
>> +		skb_gro_pull(skb, sizeof(*iph));
>>  	}
> 
> This code is non-obvious and has proven fragile (57ea52a8651). Changes
> are best as simple as they can be, with ample documentation. My
> attempt, as arrived at during review:
> 
> The existing always pulls the IPv6 header and sets the transport
> offset initially. Then optionally again pulls any extension headers
> in ipv6_gso_pull_exthdrs and sets the transport offset again on
> return from that call.
> 
> The new code adds a small optimization to only pull and set transport
> offset once.
> 
> The existing code needs to set skb->data at the start of the first
> extension header before calling ipv6_gso_pull_exthdrs, and must
> disable the frag0 optimization because that function uses
> pskb_may_pull/pskb_pull instead of skb_gro_ helpers. It sets the
> GRO offset to the inner TCP header with skb_gro_pull and sets the
> transport header. Then returns skb->data to its position before
> this block.
> 
> The new code is much simpler: it does not have to modify skb->data,
> as all operations are with skb_gro_ helpers.
> 
> Aside from the small comment above, and suggestion to include
> something like this summary in the code and/or avoid the extra
> optimization,
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 

Thanks for the review, I'll submit v2 with an extended commit message
summary as suggested.

>>  
>> +	skb_set_transport_header(skb, skb_gro_offset(skb));
>> +
>>  	NAPI_GRO_CB(skb)->proto = proto;
>>  
>>  	flush--;
>> -- 
>> 2.36.1
>>
> 
> 

