Return-Path: <linux-kselftest+bounces-7810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8F98A3298
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5082F1C21CC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 15:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E9C1487CB;
	Fri, 12 Apr 2024 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBaBKL4M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613C2148313;
	Fri, 12 Apr 2024 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936254; cv=none; b=n5Z6nIhnOqToQlIKZBzDBKaPXY/WulqOp0BCjpRh2wWh/6DqF39TIm8QdogjecBIBJ1rZKOdN05hJOzMW8/pTS1IgsgJq3jUkqzZ1Rn5ds597GS7A33EQGDP9Uj4tTJ7dlM7K7SZ9UDcm2c68NoAbh/TZqN4kG2hCLxxGijpcV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936254; c=relaxed/simple;
	bh=+7fKYNlmPI9WeSK+ldwp0Cz+Dd4sgTRgXiJcDst6jp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P3etTUvAeJOh0k24FmSFzEpDg4YzMGrO/Eyb0KYIDmWpWg7+je+lCRUFyJSdYrEeq5QaNcxYUzqpS6xMNuxXPY9pz/ayd4b7DL4cdqAGMz7PDpEBU5WL2nlznkxp8uxOabjbp3B9QkDoobS0nXqBgnBbE4cAgw9aMEr6IQfzvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBaBKL4M; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41551639550so7040715e9.2;
        Fri, 12 Apr 2024 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712936251; x=1713541051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mSTJukRV5R6k9ti3FdjI+Mbv4tcOvhs2ESXqRNG4Ew=;
        b=gBaBKL4MTLq5RjTSzt/99o7XsVDO4RM94YNsF82o7jngeh5dtc5V2FH/cLr7ujS3nN
         lcxGVV4eavXosTeGORql6wxt6CShmhRKeU+3AJFXwOX/1X++whq0GCMOoPsk7YS46Szb
         /F8a5QLlv7RN06+PjD0kOPcLb7etmZNpz+cpjeIjKChBbiLoy5bJv86MUTZzaXB/bcxb
         nr3hIDIVHQmoRu6bn3+QA18U/08m+Xv0tyUs4bfgX0bRPNP/QxO7kVzxZcjbRr0CIKPu
         QG6MLmlE9axWgF6lKYJIWVJct7+IIi2sRswZ5tofQX7tYrb3uMucxXfJ1D52bPxhRkeP
         X2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712936251; x=1713541051;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/mSTJukRV5R6k9ti3FdjI+Mbv4tcOvhs2ESXqRNG4Ew=;
        b=o5Lw82O2ThwyG0ApiGUCFaKIRDED3sMlCihbJDxBDGBrAoS6NmKLp1ZdIDwxbmiLNP
         CBQydAH519u3OtsnBDt4UzgFFZONjgqem3Rk+v2fWUsoUS1V7Z7H2bKnkawIg14XN3cX
         E4PRMZmlzjm5l7A07ec0LTVQK0AREdJnOBFoisqqm0E/oRnsB0qT1v2VnfVt6VA6CzXt
         uZDHVHsFaXzY+ZVVWWaCANJcrt55bx6Lsc3LoEBsOb0XrqRH9mwQEd0Xgs1etKeXzkUd
         AJTlSOj1GECvNL0K8iRCOvOf57++IoNzzJa0LCY+1dbC5w+UXcimVScewbW5poRPMw5/
         4msw==
X-Forwarded-Encrypted: i=1; AJvYcCXDJ+h0mCBSZ3VRPpiYPynWY3Wuzo1VSfM8ePuppkOXhogjtmldc38vfySzZxwT+CbTE7pyHsYdSigw3r8ED30aagi0Fb5nGUx1BocdfgDsJ8wzQP1RTNDMBt+SS/KaqfmFQLLAqVz9ftCvtGhnEblFnmVLz0WWXOH4KV926gQP/dEFGGub
X-Gm-Message-State: AOJu0YwUJJTnvgX0yoN244HLqIJMZr/V9j1D2VLJMlCjEltIOlihPAxW
	V3zqYz2pXOy6ffYcyvnE+pViiNMnZgkrgaywJNouFjZmPuRVuA5e
X-Google-Smtp-Source: AGHT+IHfsW2Il9Sg+5tGryzaRwgxRLoX8Bbx+QxmPWEescPaU3kWBH9MgIk1GmjYzz6y/1nbCnVO2Q==
X-Received: by 2002:a05:600c:468a:b0:414:90c3:f5be with SMTP id p10-20020a05600c468a00b0041490c3f5bemr2337530wmo.36.1712936250533;
        Fri, 12 Apr 2024 08:37:30 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b00416b035c2d8sm9301955wmq.3.2024.04.12.08.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 08:37:30 -0700 (PDT)
Message-ID: <e07ddcbb-2a4e-4f0e-80c0-b9baa2a4c80d@gmail.com>
Date: Fri, 12 Apr 2024 17:37:16 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 5/6] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 dsahern@kernel.org, aduyck@mirantis.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240410153423.107381-1-richardbgobert@gmail.com>
 <20240410153423.107381-6-richardbgobert@gmail.com>
 <66174ec5bbd29_2d6bc629481@willemb.c.googlers.com.notmuch>
 <24daf0f8-1e81-4bdb-81f3-0f95bf4392f4@gmail.com>
 <6618578fc34fa_36e52529429@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <6618578fc34fa_36e52529429@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Willem de Bruijn wrote:
>>> Richard Gobert wrote:
>>>> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
>>>> iph->id, ...) against all packets in a loop. These flush checks are used
>>>> currently only in tcp flows in GRO.
>>>>
>>>> These checks need to be done only once in tcp_gro_receive and only against
>>>> the found p skb, since they only affect flush and not same_flow.
>>>
>>> I don't quite understand where the performance improvements arise.
>>> As inet_gro_receive will skip any p that does not match:
>>>
>>>       if (!NAPI_GRO_CB(p)->same_flow)
>>>               continue;
>>>
>>>       iph2 = (struct iphdr *)(p->data + off);
>>>       /* The above works because, with the exception of the top
>>>        * (inner most) layer, we only aggregate pkts with the same
>>>        * hdr length so all the hdrs we'll need to verify will start
>>>        * at the same offset.
>>>        */
>>>       if ((iph->protocol ^ iph2->protocol) |
>>>           ((__force u32)iph->saddr ^ (__force u32)iph2->saddr) |
>>>           ((__force u32)iph->daddr ^ (__force u32)iph2->daddr)) {
>>>               NAPI_GRO_CB(p)->same_flow = 0;
>>>               continue;
>>>       }
>>>
>>> So these checks are already only performed against a p that matches.
>>>  
>>
>>
>> Thanks for the review!
>>
>> flush/flush_id is calculated for all other p with same_flow = 1 (which is
>> not always determined to be 0 before inet_gro_receive) and same src/dst
>> addr in the bucket. Moving it to udp_gro_receive_segment/tcp_gro_receive
>> will make it run only once when a matching p is found.
> 
> So this optimization is for flows that are the same up to having the
> same saddr/daddr. Aside from stress tests, it seems rare to have many
> concurrent flows between the same pair of machines?
> 

Yes exactly, sorry if I wasn't clear enough earlier. Multiple connections
with the same srcaddr+dstaddr are not necessarily rare (e.g. devices behind
a large NAT network all connecting to the same servers, thus sharing the
same IP srcaddr).

>>
>> In addition, UDP flows where skb_gro_receive_list is called -
>> flush/flush_id is not relevant and does not need to be calculated. 
> 
> That makes sense
> 

I ran a UDP forwarding benchmark similar to how I did in the commit
message. GRO's flush/flush_id values were not relevant as all packets
reached skb_gro_receive_list instead of skb_gro_receive.

These numbers show CPU utilization under the same load (64 concurrent
IP/UDP connections):

net-next:
        3.03%  [kernel]  [k] inet_gro_receive

patch applied:
        2.78%  [kernel]  [k] inet_gro_receive

And under encapsulated load, 64 concurrent IP/IP/UDP connections:
net-next:
        10.50%  [kernel]  [k] inet_gro_receive

patch applied:
        8.19%  [kernel]  [k] inet_gro_receive

Total time spent in GRO reduced significantly due to fewer opcodes and
branches in inet_gro_receive :)

>> In these
>> cases total CPU time in GRO should drop. I could post perf numbers for
>> this flow as well.
>>
>>
>>>> Leveraging the previous commit in the series, in which correct network
>>>> header offsets are saved for both outer and inner network headers -
>>>> allowing these checks to be done only once, in tcp_gro_receive. As a
>>>
>>> Comments should be updated to reflect both TCP and L4 UDP. Can
>>> generalize to transport callbacks.
>>>
>>>> result, NAPI_GRO_CB(p)->flush is not used at all. In addition, flush_id
>>>> checks are more declarative and contained in inet_gro_flush, thus removing
>>>> the need for flush_id in napi_gro_cb.
>>>>
>>>> This results in less parsing code for UDP flows and non-loop flush tests
>>>> for TCP flows.
>>>
>>> This moves network layer tests out of the network layer callbacks into
>>> helpers called from the transport layer callback. And then the helper
>>> has to look up the network layer header and demultiplex the protocol
>>> again:
>>>
>>>     +		if (((struct iphdr *)nh)->version == 6)
>>>     +			flush |= ipv6_gro_flush(nh, nh2);
>>>     +		else
>>>     +			flush |= inet_gro_flush(nh, nh2, p, i != encap_mark);
>>>
>>> That just seems a bit roundabout.
>>
>> IMO this commit could be a part of a larger change, where all
>> loops in gro_list_prepare, inet_gro_receive and ipv6_gro_receive can be
>> removed, and the logic for finding a matching p will be moved to L4.  This
>> means that when p is found, the rest of the gro_list would not need to be
>> traversed and thus would not even dirty cache lines at all. I can provide a
>> code snippet which would explain it better.
> 
> These loops are exactly the mechanism to find a matching p. Though
> with all the callbacks perhaps not the most efficient model. The
> hashtable should have solved much of that.
> 
> Yes, please share a snippet to understand how you would replace this.
> 

This is still a rough idea, and I still think the current patch is
significant by itself due to its performance gains and more readable code.

The idea is that an skb from gro_list will be loaded to cache only when GRO
is trying to find out if it matches the current skb, avoiding the current
multiple list traversals design in GRO for IP-TCP.

For a simple IP-TCP packet, gro_list_prapare will not be called from
dev_gro_receive anymore:

@@ -450,8 +489,6 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
        if (netif_elide_gro(skb->dev))
                goto normal;
 
-       gro_list_prepare(&gro_list->list, skb);

The matching loop from inet_gro_receive is removed as well:

@@ -1507,27 +1506,6 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 
        NAPI_GRO_CB(skb)->proto = proto;
        flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
-
-       list_for_each_entry(p, head, list) {
-               struct iphdr *iph2;
-
-               if (!NAPI_GRO_CB(p)->same_flow)
-                       continue;
-
-               iph2 = (struct iphdr *)(p->data + off);
-               /* The above works because, with the exception of the top
-                * (inner most) layer, we only aggregate pkts with the same
-                * hdr length so all the hdrs we'll need to verify will start
-                * at the same offset.
-                */
-               if ((iph->protocol ^ iph2->protocol) |
-                   ((__force u32)iph->saddr ^ (__force u32)iph2->saddr) |
-                   ((__force u32)iph->daddr ^ (__force u32)iph2->daddr)) {
-                       NAPI_GRO_CB(p)->same_flow = 0;
-                       continue;
-               }
-       }
-

and change tcp_gro_receive such that p is retrieved from gro_list using a new function:

--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -215,24 +215,12 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
        len = skb_gro_len(skb);
        flags = tcp_flag_word(th);
 
-       list_for_each_entry(p, head, list) {
-               if (!NAPI_GRO_CB(p)->same_flow)
-                       continue;
-
-               th2 = tcp_hdr(p);
-
-               if (*(u32 *)&th->source ^ *(u32 *)&th2->source) {
-                       NAPI_GRO_CB(p)->same_flow = 0;
-                       continue;
-               }
+       if (!(p = gro_list_find(head, skb, &flush)))
+               goto out_check_final;
 
-               goto found;
-       }
-       p = NULL;
-       goto out_check_final;
+       th2 = tcp_hdr(p);
 
-found:
-       flush = (__force int)(flags & TCP_FLAG_CWR);
+       flush |= (__force int)(flags & TCP_FLAG_CWR);
        flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
                  ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
        flush |= (__force int)(th->ack_seq ^ th2->ack_seq);


The first time gro_list is traversed is in tcp_gro_receive.  gro_list_find
is very similar to gro_list_prepare - but it also matches L3 & L4 (UDP and
TCP port offsets are identical), and it returns L3 flush value as well.

The main difference between the current design and what I propose is that
once a matched p is found - there's no need to keep traversing the rest of
gro_list (as opposed to gro_list_prepare and inet_gro_receive for example),
and that's why certain checks are saved especially under load.  This way
less data is loaded to cache overall for every skb entering dev_gro_receive.

> In the meantime, I do suggest sending the first two patches to net,
> as they have Fixes tags. And then follow up with this for net-next
> separately.

Just submitted the first two commits to net.
Thanks.

