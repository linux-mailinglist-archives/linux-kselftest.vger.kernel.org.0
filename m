Return-Path: <linux-kselftest+bounces-5639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C51886CA2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 14:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DCFAB25679
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3286B8626B;
	Thu, 29 Feb 2024 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYNfFbex"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733937F47E;
	Thu, 29 Feb 2024 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212958; cv=none; b=DIjjAR17sGXxGfdzEf3U+SwPjSlGqQvRm9wEBRpjHeGxFNdYswYHGPY8Kmnoezsa6Qcc1jyB5N8dcKsV7pIzahmTxEiqYLMElfhH2uTYKQoW4WSrvxFo6f9kNh4d6wBWD0/6NyJSYpE3xoweZCUz18UX8/s9rML0Zu3UYjg5iK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212958; c=relaxed/simple;
	bh=t/gQZkp/mL8aUTpOBAVPj1+00+2UWc7hLQA1HfFua/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0QjQqp7ex19Jjg0TVAIwSeI++6B44JWvazQiYvGb23ztx3tfZdNbHk+knweZlx8+gr9kHU5m73UO1vXBcVAuY0BiDN6vMN2sb093MyfyMHPmCSXVA5e+evhJim6GJz2WTSM8ce4iwUoFa8OpsF4MR0daXbGTd39lpa8ugd8eaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYNfFbex; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33dcad9e3a2so598549f8f.3;
        Thu, 29 Feb 2024 05:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709212954; x=1709817754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fp+uUnnUZzHMNBvM+VQhYNMJGX0ap5VPiBLO8+JsLNM=;
        b=bYNfFbexp6Doc7nexgdGczt6z1gRaZEMRNpRRdHGXGhQKpehIoXI78rz63/YJCkqn0
         Yjy62JXKO2XRDJINUtzlaatpPgqyqn/AQWqTKJQIBV+OOZtdGM1Jql3l2XAy7lGs3jeg
         vxlOhSc4aIWpvVRjdoLVps/vxobGNyBA4aHZiIWqtHonzP9h4jpbBqF3qc4BB0SRydpx
         TPU2cfa3oQgHaQAf/2DNuYUAcmF2lX6lwbqhZEgu0ECn/6+2SGTWjABVk+HbbgOHLM6Y
         ZinvrYX4HbKwZbkJnLVhXW+3b6nIkZHpv27zIrprqymWu5yJlyOiLukqN8Rl7tPar7TY
         OFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709212954; x=1709817754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fp+uUnnUZzHMNBvM+VQhYNMJGX0ap5VPiBLO8+JsLNM=;
        b=kn/wMdPCmoVY6j4YgtSg/2OwO2ts3ScsIB3lfCCuK8ra/nzdf097rIILdVir1kh0Bg
         CDxZSvyH2Cya8q6Ekr7SOOUd3Wu8pv/srEQ9p6yw4fAwqKIEJfUEZZiPvnGgp3NfQEJx
         U3p7DN14svdp1Qgb5ZXQ1vo421VToq81syRS6iZ7YFWTCpKp4/k+qwHfC3NT6Xd2CRqC
         /sVxHvEILdxu7DfB88X4lKMQy5agj6ngq4ie7+DGCt9uyLM3l8LomNn+FP1VYS+xNKg6
         6pe6W+PEK9lyntTRSpcz26n9pqONaeO3kNXm2AHhdTdQ1PX0XloW6//fBNgNt+92yj9B
         c9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWV7xxQV+tx044jxQFquUb0vbUgsNvFipDbsvNxWlCphVH1PtVw3iIkxuKDQU/PaQQ1YLIpbpLQsHGyxJ63F6u+H0dyHFWPMmPTgg62mMEsTFae50z+MMK4LhrXGIBQp2FSkoCDYDWp3kr7Fj/csEa83a8VAWhMTcXeZppUJkJdJ0qS1r7o
X-Gm-Message-State: AOJu0YwGQ2zlQbdTc/zrUAoTSwTRsl1sdctdhfrTB05j+QCtRvWp61ow
	mAykvpBtVA/5MrWraF8CXEf3mIvT04sTByoS+A2erJOfUezLzWjN
X-Google-Smtp-Source: AGHT+IG4hAbPjfSDDmuIHLfqFc2hRkyWuJY9twtb2NiQ2LLHM5NAPwk81DlW8kF9uFjt9YOyC+P32w==
X-Received: by 2002:a5d:4441:0:b0:33e:fd3:8f4c with SMTP id x1-20020a5d4441000000b0033e0fd38f4cmr1014350wrr.1.1709212954434;
        Thu, 29 Feb 2024 05:22:34 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id v13-20020adfd04d000000b0033d202abf01sm1760299wrh.28.2024.02.29.05.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 05:22:34 -0800 (PST)
Message-ID: <a10b6d19-232c-4b6d-bd71-eb3451675f64@gmail.com>
Date: Thu, 29 Feb 2024 14:22:16 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/3] net: gro: set {inner_,}network_header in
 receive phase
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, shuah@kernel.org, liujian56@huawei.com,
 horms@kernel.org, aleksander.lobakin@intel.com, linyunsheng@huawei.com,
 therbert@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <e1d22505-c5f8-4c02-a997-64248480338b@gmail.com>
 <446695cb-50b8-4187-bf11-63aedb6e9aed@gmail.com>
 <CANn89iJxCT0Bcmqjdd1kp4VCf5i3Me7yATsZXO7SkYTPQ9BOAA@mail.gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <CANn89iJxCT0Bcmqjdd1kp4VCf5i3Me7yATsZXO7SkYTPQ9BOAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



Eric Dumazet wrote:
> 
> My intuition is that this patch has a high cost for normal GRO processing.
> SW-GRO is already a bottleneck on ARM cores in smart NICS.
> 
> I would suggest instead using parameters to give both the nhoff and thoff values
> this would avoid many conditionals in the fast path.
> 
> ->
> 
> INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int
> nhoff, int thoff)
> {
>  const struct ipv6hdr *ipv6h = (const struct ipv6hdr *)(skb->data + nhoff);
>  struct udphdr *uh = (struct udphdr *)(skb->data + thoff);
> ...
> }
> 
> INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int
> nhoff, int thoff)
> {
>        const struct ipv6hdr *iph =  (const struct ipv6hdr *)(skb->data + nhoff);
>        struct tcphdr *th = (struct tcphdr *)(skb->data + thoff);
> 
> Why storing in skb fields things that really could be propagated more
> efficiently as function parameters ?

Hi Eric,
Thanks for the review!
 
I agree, the conditionals could be a problem and are actually not needed.
The third commit in this patch series introduces an optimisation for
ipv6/ipv4 using the correct {inner_}network_header. We can remove the
conditionals; I thought about multiple ways to do so. First, remove the
conditional in skb_gro_network_offset:
 
    static inline int skb_gro_network_offset(const struct sk_buff *skb)
    {
        const u32 mask = NAPI_GRO_CB(skb)->encap_mark - 1;
        return (skb_network_offset(skb) & mask) | (skb_inner_network_offset(skb) & ~mask);
    }
 
And for the conditionals in {inet,ipv6}_gro_receive I thought about two
ideas. The first is to move set_inner_network_header to encapsulation gro
functions like ipip_gro_receive, this way there's one less write (in
comparison to main) in these functions:

    static struct sk_buff *ipip_gro_receive(struct list_head *head,
                        struct sk_buff *skb)
    {
        ...
 
        NAPI_GRO_CB(skb)->encap_mark = 1;
        skb_set_inner_network_header(skb, skb_gro_offset(skb));
 
The second way is to always write to inner_network_header:

    INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
                                struct sk_buff *skb)
    {
        ...
        skb_set_inner_network_header(skb, off);
        ...
 
What do you think is better? I think the 1st is more beneficial for the
fast path.

We could then use the {inner_}network_header separation to optimise the
receive path, such as in the 3rd commit in this patch series.
 
Regards,
Richard

