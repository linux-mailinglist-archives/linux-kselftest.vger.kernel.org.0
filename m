Return-Path: <linux-kselftest+bounces-7716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635BD8A1C10
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 19:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD201C227B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E1615217C;
	Thu, 11 Apr 2024 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOX6F5ZF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2799152160;
	Thu, 11 Apr 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851646; cv=none; b=dESNgcBFUqT88JLSuK9BQi9soohYM5zdjb4XxYBXqvfuhsuxhsj7Qe0E+HSrusV8pmocgPE8TYbzoXDlraESuI2WBPXJfqqeKtU40cZPPQlKOHonNCGCU+j6JCqHIAIt4wEe1hd73Rz26jedsVoxlz7covIJiAXG0OnvEnECOBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851646; c=relaxed/simple;
	bh=gwdASi3hCoFHEfTMfnWOtRvHJtLoeC8FToYRqET1b5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZFUeqFIRe1yMsxYiPDsKyXRoUDarAV8CHlfGNJf+gY78PJbOhA+vBKMgZJd0QqJdpLrMJstM9m3kse+HVSJ+GNH6f1jiXaDtS4OBv1PfQ8/OFr/S0BIuhXE/S1e5EuZLwfvP9S/163+gbzkQhNxkjIw8sZgajI/diMm8fEdLW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOX6F5ZF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4167fce0a41so6195575e9.0;
        Thu, 11 Apr 2024 09:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712851643; x=1713456443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zc6hg2CYz2524rvKTk6iwGY4Cg5w2/pVyRvL3+/C1YQ=;
        b=HOX6F5ZFWvAu06cdMsCg7lqYfBv4ZuCY6AxBMLhcnnLFJn9nLWwyt5dkWSjPedT3TO
         O2co7oDaze5SOyy+KT7it/0qrBDfdYQjwF382kX5c1iKGrSHuIU11zJlyqTuyUjxWo4r
         16CpFvqDP/ZhUrZKfJhx7zBWCGr3GvEDzFxHZ0Q9ms0lkc48SPShSjP/Jz1lTA1CZben
         pIfDzmUIn6n73K27efpDAlTXMHoETvs72hwcgfbv3/5KLikidxgIohW4hYYY6kAqZSfo
         wfUP9zS1W7xBeZqWhmm5BdyGqbr9TSNj5KruBoRtySBEypUBJyOmAR15YTAVT0zQ0BZk
         XdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712851643; x=1713456443;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zc6hg2CYz2524rvKTk6iwGY4Cg5w2/pVyRvL3+/C1YQ=;
        b=f0N9u3Prv4QaG8XzmvqL0bRCWxv7cbK493gChriptOSCj2i1GXEWbHNgTo+9VtrjZs
         IuMPUTJQxjJK9sE8R58k0L613xv5e39TO3LKsUYb/dhcmhx3jGgWvrNpfjPbI3aNvkpH
         NxQlkM6M+MEq1+IYy9zmH1tmVmu9SD3DRbG1fu8CpbIZtr/Vfu7RUjBWDrSKU4CcFVZz
         zXfCfZ2lgXe1kI76bSAQcVXzlw85pBRcJX3T4oRDc/Nim+VhxsHCkYnlJK/KmgTNpJe/
         UrpjnwNQ2zTlPyzeehd9V9vQUgFmIjsxKbnf2UL/JsfCfvmSVAca2EFgVSupn0mcnQVx
         AY4g==
X-Forwarded-Encrypted: i=1; AJvYcCVYJlzMEt44y8ShEYzmnvT4UQtFg4Wc5REv5D0vYm3DYh4pvooTdinTvFDKDBJoGtldpLciKHgdaowyHUN+77UmkdbIaQ3Js8K5w/R064LpHamD9NNzg5+35KInpYVJ34fmJqqHrkP7pwjqOXjxTioPD4/+LLGxBD+XkOjLL54J6T5HOvNG
X-Gm-Message-State: AOJu0YysR/9fAxvtydK/LuCO/Wn79Q401tx5EVHMGnTBteRMon92lP79
	TZge5VBMRLoY9oxcrYPQWQVFiJ8Pcj5TZu2e9ODeS/9KAalXFXop
X-Google-Smtp-Source: AGHT+IFhDLkByLfx6NOUxjkxXkl/jVzcbsfer/tFuPIPpCQMyKIrMErq5JCEFUUWxpGBv7JbA3tPGA==
X-Received: by 2002:a05:600c:35c5:b0:416:69cf:d5f8 with SMTP id r5-20020a05600c35c500b0041669cfd5f8mr3084869wmq.6.1712851643082;
        Thu, 11 Apr 2024 09:07:23 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c4e9300b00417d624cffbsm2524206wmq.6.2024.04.11.09.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 09:07:22 -0700 (PDT)
Message-ID: <24daf0f8-1e81-4bdb-81f3-0f95bf4392f4@gmail.com>
Date: Thu, 11 Apr 2024 18:07:13 +0200
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
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <66174ec5bbd29_2d6bc629481@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
>> iph->id, ...) against all packets in a loop. These flush checks are used
>> currently only in tcp flows in GRO.
>>
>> These checks need to be done only once in tcp_gro_receive and only against
>> the found p skb, since they only affect flush and not same_flow.
> 
> I don't quite understand where the performance improvements arise.
> As inet_gro_receive will skip any p that does not match:
> 
>       if (!NAPI_GRO_CB(p)->same_flow)
>               continue;
> 
>       iph2 = (struct iphdr *)(p->data + off);
>       /* The above works because, with the exception of the top
>        * (inner most) layer, we only aggregate pkts with the same
>        * hdr length so all the hdrs we'll need to verify will start
>        * at the same offset.
>        */
>       if ((iph->protocol ^ iph2->protocol) |
>           ((__force u32)iph->saddr ^ (__force u32)iph2->saddr) |
>           ((__force u32)iph->daddr ^ (__force u32)iph2->daddr)) {
>               NAPI_GRO_CB(p)->same_flow = 0;
>               continue;
>       }
> 
> So these checks are already only performed against a p that matches.
>  


Thanks for the review!

flush/flush_id is calculated for all other p with same_flow = 1 (which is
not always determined to be 0 before inet_gro_receive) and same src/dst
addr in the bucket. Moving it to udp_gro_receive_segment/tcp_gro_receive
will make it run only once when a matching p is found.

In addition, UDP flows where skb_gro_receive_list is called -
flush/flush_id is not relevant and does not need to be calculated. In these
cases total CPU time in GRO should drop. I could post perf numbers for
this flow as well.


>> Leveraging the previous commit in the series, in which correct network
>> header offsets are saved for both outer and inner network headers -
>> allowing these checks to be done only once, in tcp_gro_receive. As a
> 
> Comments should be updated to reflect both TCP and L4 UDP. Can
> generalize to transport callbacks.
> 
>> result, NAPI_GRO_CB(p)->flush is not used at all. In addition, flush_id
>> checks are more declarative and contained in inet_gro_flush, thus removing
>> the need for flush_id in napi_gro_cb.
>>
>> This results in less parsing code for UDP flows and non-loop flush tests
>> for TCP flows.
> 
> This moves network layer tests out of the network layer callbacks into
> helpers called from the transport layer callback. And then the helper
> has to look up the network layer header and demultiplex the protocol
> again:
> 
>     +		if (((struct iphdr *)nh)->version == 6)
>     +			flush |= ipv6_gro_flush(nh, nh2);
>     +		else
>     +			flush |= inet_gro_flush(nh, nh2, p, i != encap_mark);
> 
> That just seems a bit roundabout.

IMO this commit could be a part of a larger change, where all
loops in gro_list_prepare, inet_gro_receive and ipv6_gro_receive can be
removed, and the logic for finding a matching p will be moved to L4.  This
means that when p is found, the rest of the gro_list would not need to be
traversed and thus would not even dirty cache lines at all. I can provide a
code snippet which would explain it better.

