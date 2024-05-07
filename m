Return-Path: <linux-kselftest+bounces-9613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A196B8BE89E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 18:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2E9B24995
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957C416ABC1;
	Tue,  7 May 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUbo0p6S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6131649C8;
	Tue,  7 May 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098735; cv=none; b=acRQf9MB361SBs2pmiOTdxFExT1YnJXAozax1MYemHNddU3D5EhNIpYeJtzE4AnnPuVU8hboIk40UqHQFV3MPHfQ8slqd8Yr1qCvpsALIVx1a3bqVXs5B8haHsty3Tz4aIRegMIgK6387OGSAXZuemuRdUCOs0wqSOG1ZIJ1Scg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098735; c=relaxed/simple;
	bh=CXkhrGmVovd2iD+gew7vIJBjDRjYbrAoBFBuatO/EcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZBuWQgXBcakoADWG+7HdZXfe7lXyI0JbmpFbSDZSw2gm/NUHHleH5+NsjWQyPcDmSM/VfrE4UHbMlLwOioL5t5bqGbUQ8E5h2dLh5LF9xqR9yOLdquMNZS2Qlos6L8YS73iXRl8J7Uiq96FoNbdgLt1QPfw2HGAap0djBjB9a4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUbo0p6S; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34db6a299b8so2159887f8f.3;
        Tue, 07 May 2024 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715098732; x=1715703532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZwcVSwzOm1/6zNDN7V+zmSg9uLJaNbCLAg7xyWPCgg=;
        b=fUbo0p6SAYBXiJbbMee/iQBu5hDpznQgW1AkPNHPT6Kyc8uRE/Y9QjAI1dSTEkcGhM
         cbTQh/1MXU48EYXshTQs+LcQlwxSGNofuv7bvjSfmgbzEHX9tJhXAvro1toQ8b6PV37L
         NRxcow8Ge99KLk9TSJTnRno+mFQqSq7mwQRmB0jKToBbFqACoeyiKh+/BhanLeyBzeXt
         hoTmAqQbn2mXLTiCo/W8Zqr7ZkQoOKkQix0nuVpjc4XfXsT5zQE+cbIsgO/XUJMGfAFm
         ZdJErelqlfH8dsrVytGahjRdUriVe1M6DnDhnqkOLwhPfgtQVNMW6trJTqN9B5d9Vmi/
         9fFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715098732; x=1715703532;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lZwcVSwzOm1/6zNDN7V+zmSg9uLJaNbCLAg7xyWPCgg=;
        b=YWg6YjSyB+ni3X3BuNRYiyI0bIya1VC4JomuDxkFgMvQ1TfELHKLhHn4iErYdrkACj
         v8aqyAIaL2hXteXqzmVTQT3nfeHdNHj4JPT6Y0env+tVH1+3MnSHRaxeCOaumBjD1QTH
         FAlWRC+S47jxjybk+YUR9CMUewqI93Oh8wzqfJfQZL8uxj3oi2pQG3I7dBwsi9sZ+r+C
         oCk5h8x/5EjOUNDw6fPd+LVbXDdMdlSJ8eLBV04lG01sasY83e5gMqYzxcG6yTnoOusX
         xw7J3ozEBA2bjjnLbwl2C9T6ezj9QyLpH/9y7c5DLpf4c+Oj7DX7le3uI8Lswmc9Bh5Q
         m9rw==
X-Forwarded-Encrypted: i=1; AJvYcCXAY4G1CpMbgq7fSI4ehRuPU4yySy/9cP4yZuKHeOp7Ra5KjRulOo/1VccxqFvwhXKe7T6fz8aULS5l2mPyiRVgPjGiG4/mUEMqy7BMfxvnf0Wl2HindNIaa5BIX7tmA3QVIVv6YKlTN9+T2SJ9UbzixBAmMQ6FghzKo9sLru9pMrne3PwE
X-Gm-Message-State: AOJu0YyFLDGcPAvNRVX1yJ0nfxR/0SrDpkWnFENkLqDJ5lbFV7A9yZEm
	+cIO1HJsfswAoM8237WwVHlydi1Z128Nasa9oOVn5bjekMUB6gN6HeNd+g==
X-Google-Smtp-Source: AGHT+IHx3+YiTxi1Fg/aMOoqKriaeDIKLF1dvzu0R4Y5PSwp5KwRB7ZCd9qeZFKdy4G+AcSQ1Nl9hw==
X-Received: by 2002:adf:fecf:0:b0:34c:6629:9962 with SMTP id ffacd0b85a97d-34fca42eb2cmr201491f8f.30.1715098731713;
        Tue, 07 May 2024 09:18:51 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id s3-20020adfe003000000b0034e8a10039esm10226719wrh.10.2024.05.07.09.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:18:51 -0700 (PDT)
Message-ID: <3514cd99-7bd2-49d9-a1b3-a26e727bcef8@gmail.com>
Date: Tue, 7 May 2024 18:18:18 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v8 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 alobakin@pm.me, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alexander.duyck@gmail.com
References: <20240506093550.128210-1-richardbgobert@gmail.com>
 <1ed21e6d-7cbc-43e3-8933-fc40562b70b2@gmail.com>
 <6639114eab050_516de29444@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <6639114eab050_516de29444@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
>> iph->id, ...) against all packets in a loop. These flush checks are used in
>> all merging UDP and TCP flows.
>>
>> These checks need to be done only once and only against the found p skb,
>> since they only affect flush and not same_flow.
>>
>> This patch leverages correct network header offsets from the cb for both
>> outer and inner network headers - allowing these checks to be done only
>> once, in tcp_gro_receive and udp_gro_receive_segment. As a result,
>> NAPI_GRO_CB(p)->flush is not used at all. In addition, flush_id checks are
>> more declarative and contained in inet_gro_flush, thus removing the need
>> for flush_id in napi_gro_cb.
>>
>> This results in less parsing code for non-loop flush tests for TCP and UDP
>> flows.
>>
>> To make sure results are not within noise range - I've made netfilter drop
>> all TCP packets, and measured CPU performance in GRO (in this case GRO is
>> responsible for about 50% of the CPU utilization).
>>
>> perf top while replaying 64 parallel IP/TCP streams merging in GRO:
>> (gro_network_flush is compiled inline to tcp_gro_receive)
>> net-next:
>>         6.94% [kernel] [k] inet_gro_receive
>>         3.02% [kernel] [k] tcp_gro_receive
>>
>> patch applied:
>>         4.27% [kernel] [k] tcp_gro_receive
>>         4.22% [kernel] [k] inet_gro_receive
>>
>> perf top while replaying 64 parallel IP/IP/TCP streams merging in GRO (same
>> results for any encapsulation, in this case inet_gro_receive is top
>> offender in net-next)
>> net-next:
>>         10.09% [kernel] [k] inet_gro_receive
>>         2.08% [kernel] [k] tcp_gro_receive
>>
>> patch applied:
>>         6.97% [kernel] [k] inet_gro_receive
>>         3.68% [kernel] [k] tcp_gro_receive
> 
> Thanks for getting the additional numbers. The savings are not huge.
> 
> But +1 on the change also because it simplifies this non-obvious
> logic. It makes sense to separate flow matching and flush logic.
> 
> Btw please include Alexander Duyck in the Cc: of this series. 

Thanks, will do that when I re-post.

>> +static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
>> +				 struct sk_buff *p, bool outer)
>> +{
>> +	const u32 id = ntohl(*(__be32 *)&iph->id);
>> +	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
>> +	const u16 flush_id = (id >> 16) - (id2 >> 16);
>> +	const u16 count = NAPI_GRO_CB(p)->count;
>> +	const u32 df = id & IP_DF;
>> +	u32 is_atomic;
>> +	int flush;
>> +
>> +	/* All fields must match except length and checksum. */
>> +	flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
>> +
>> +	if (outer && df)
>> +		return flush;
> 
> Does the fixed id logic apply equally to inner and outer IPv4?
> 

Fixed id logic is not applied equally to inner and outer IPv4. innermost
IDs are checked, but outer IPv4 IDs are not checked at all if DF is set.
This is the current logic in the code and this patch preserves it. To my
understanding this is explained as intentional by the original commit author
(20160407223218.11142.26592.stgit@ahduyck-xeon-server)

Alexander - could you maybe elaborate further?

>> +
>> +	/* When we receive our second frame we can make a decision on if we
>> +	 * continue this flow as an atomic flow with a fixed ID or if we use
>> +	 * an incrementing ID.
>> +	 */
>> +	NAPI_GRO_CB(p)->is_atomic |= (count == 1 && df && flush_id == 0);
>> +	is_atomic = (df && NAPI_GRO_CB(p)->is_atomic) - 1;
>> +
>> +	return flush | (flush_id ^ (count & is_atomic));
> 
> This is a good time to consider making this logical more obvious.
> 
> First off, the flush check can be part of the outer && df above, as
> flush is not modified after.
> 
> Subjective, but I find the following more readable, and not worth
> saving a few branches.
> 
>         if (count == 1 && df && !flush_id)
>                 NAPI_GRO_CB(p)->is_atomic = true;
> 
> 	ip_fixedid_matches = NAPI_GRO_CB(p)->is_atomic ^ df;
> 	ipid_offset_matches = ipid_offset - count;
> 
> 	return ip_fixedid_matches & ipid_offset_matches;
> 
> Have to be a bit careful about types. Have not checked that in detail.
> 

ip_fixedid_matches should also account for checking whether flush_id is 0
or not, if we're going for readability I'd suggest checking "which check"
should be done (fixedid or offset) and do only the appropriate one.

	if (count == 1 && df && !ipid_offset)
		NAPI_GRO_CB(p)->is_atomic = true;

	if (NAPI_GRO_CB(p)->is_atomic && df)
		return flush | ipid_offset;

	return flush | (ipid_offset ^ count);

> And while nitpicking:
> ipid_offset may be a more descriptive variable name than flush_id, and
> ip_fixedid  than is_atomic. If changing those does not result in a lot
> of code churn.
> 

I also think is_atomic is not the best name, I'll change both names in the
next patch.

>> +}
>> +
>> +static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr *iph2)
>> +{
>> +	/* <Version:4><Traffic_Class:8><Flow_Label:20> */
>> +	__be32 first_word = *(__be32 *)iph ^ *(__be32 *)iph2;
>> +
>> +	/* Flush if Traffic Class fields are different. */
>> +	return !!((first_word & htonl(0x0FF00000)) |
>> +		(__force __be32)(iph->hop_limit ^ iph2->hop_limit));
>> +}
>> +
>> +static inline int gro_network_flush(const void *th, const void *th2, struct sk_buff *p, int off)
>> +{
>> +	const bool encap_mark = NAPI_GRO_CB(p)->encap_mark;
> 
> Is this correct when udp_gro_complete clears this for tunnels?
> 

gro_network_flush is called in receive flow, so udp_gro_complete cannot be
called after gro_network_flush. I think the function name should be changed to
gro_receive_network_flush.

>> +	int flush = 0;
>> +	int i;
>> +
>> +	for (i = 0; i <= encap_mark; i++) {
>> +		const u16 diff = off - NAPI_GRO_CB(p)->network_offsets[i];
>> +		const void *nh = th - diff;
>> +		const void *nh2 = th2 - diff;
>> +
>> +		if (((struct iphdr *)nh)->version == 6)
>> +			flush |= ipv6_gro_flush(nh, nh2);
>> +		else
>> +			flush |= inet_gro_flush(nh, nh2, p, i != encap_mark);
>> +	}
> 
> Maybe slightly better for branch prediction, and more obvious, if
> creating a helper function __gro_network_flush and calling
> 
>     __gro_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offsets[0])
>     if (NAPI_GRO_CB(p)->encap_mark)
>             __gro_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offsets[1])
> 
>> +
>> +	return flush;
>> +}
>> +
>>  int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb);
>>  

