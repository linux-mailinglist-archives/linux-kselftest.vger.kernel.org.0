Return-Path: <linux-kselftest+bounces-5734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9694186E3E2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 16:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3607FB2203B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31F63A8F8;
	Fri,  1 Mar 2024 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdvvhqT5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29831C33;
	Fri,  1 Mar 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305376; cv=none; b=KzW+lEUHFUG4m4UIzyB0ktAVdEp+D9VYsiNfzRB5XmGhTk8QVqw3IzeYACfXy00Vw80IgIa23DorY43cYfR2Zk1AwAkwdcAYHzNJBw7dtO9/BAF/+RGiR5b6SBXk4KdGPcveFY2IAfgWmT9avW5EKluyDz64RgZ7F117Loq2hzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305376; c=relaxed/simple;
	bh=iAO65WgB4KgPDeH34KBkH8XenXcHBUEjtlarWO4AjMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhrwVRAwvAUqcSP+oNlKI4T9o7n5g0lV094a6v3wW2Jra5iIz3nDHd3+pHP02codJFeWBVjhlaumgseFNX8gtzVQK0aaAkv73zSnjO4yjpP4sZy9VeTwMc3ZoTTh4GVhC/NTqDT5twF32Qiv+E5P9DZHgkH5qXpyl/3oetwlhi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdvvhqT5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412ce4f62f8so603285e9.0;
        Fri, 01 Mar 2024 07:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709305373; x=1709910173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXEv9EP2Y22NukxIhiLYf8BGk4fGYg5i0JkzdzS8yhk=;
        b=ZdvvhqT5IVMBmY7/xDACy3t1BuLoFJ1g70OTFL0x4LUqM6C27ur7UmvP+p3OdFt4HT
         aEsjGMVgRqasME05qCODpS67hYhgr8mvJttLFpk3eS2D86hD25FdbqDocO2Jv8DCnVeT
         lkuOYlClL4CHJASwT7zqMpfvvF5AZW1Qx5v4wcUoBbpiI5maN8IuwpBJMTV3TaadahWb
         qTte9cz7KDmBPoGqoNLdKnyyyfnmOG2Ruf7quSreQysM3Jrm+j+/90V2F58d11IKw+kx
         SEQNfCIH2VN4iGRRKoPhQXKs54NhKj2wKEPLvptZUfv7cWPapyrRVLiEpv6vFO0mdBod
         cZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709305373; x=1709910173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TXEv9EP2Y22NukxIhiLYf8BGk4fGYg5i0JkzdzS8yhk=;
        b=CyAl3QxKXfvuo4/kwv60XR0e3mwGAetw5AXaWazJ6tOmOeUiF95rcxltXBP1nkEH/w
         l1nQLKiNxwqcpQpzvQU6lu2uYT51v9/hOrf18NFzMUWVQrWQAOFOvfT+XaI7YPGRt2xn
         3yWmNl1yT/g8vG4rB01cjtY1GgfZDh55Az3qvv5Crl9SNFHS18/UGErl6QCVfWtFqGnT
         RyxKftEBIspMMiWYtVuGZOAr58TmWiQm9vRDQDp5AGb5g4+24D2kA4/3IZp4lcfb9OGn
         xzT6Ev+vvYs+htZJs9Jn0QVhppXlXoW1FZwq4AAU7XWVbgQIO96Acwwc7seGXrS9CNjf
         I0Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWGovptbQm27XOJ6lnYsZCs857h69P+IHmtIi/s8sz0K6EK3VPeWZLd/KErwWk5ERYLNBmA2XpQepvjaoBWVVwLPufIf6t+3gt533U6shgI/ZBBUvpNAqDHi21NncTX7a1x+WM82ic9rEZWV5ZVuULHJx+1UErfBW9nSdG3pDcDszNYXbJZ
X-Gm-Message-State: AOJu0YzqXiP5Y/UzDUTRAZ442dzgjZjg2q0NwGFMYCS7gDL9DmHWe4Si
	YY/DAMcdx2u2s/fDU4OjfpSxk+20cEQAFIVgYTzO4/qxKtqcGOs+
X-Google-Smtp-Source: AGHT+IHC2s7wvqmklz0Axg33a4MUM1hHFtWw1cVqjlcY2Fbt7Oa9Hzilb0sussISrfWRUAlvPCnNXw==
X-Received: by 2002:a05:600c:190a:b0:412:c9e6:fcfd with SMTP id j10-20020a05600c190a00b00412c9e6fcfdmr1116333wmq.23.1709305372934;
        Fri, 01 Mar 2024 07:02:52 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id 14-20020a5d47ae000000b0033cf80ad6f5sm4911569wrb.60.2024.03.01.07.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 07:02:52 -0800 (PST)
Message-ID: <e803766b-6a3d-4eab-8335-d415518392e0@gmail.com>
Date: Fri, 1 Mar 2024 16:02:26 +0100
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
 <a10b6d19-232c-4b6d-bd71-eb3451675f64@gmail.com>
 <CANn89iK8rDOc14HMGMq=sw0zECcg88Mb=67044r_OA=mSh=xtQ@mail.gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <CANn89iK8rDOc14HMGMq=sw0zECcg88Mb=67044r_OA=mSh=xtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Eric Dumazet wrote:
> On Thu, Feb 29, 2024 at 2:22 PM Richard Gobert <richardbgobert@gmail.com> wrote:
>>
>>
>>
>> Eric Dumazet wrote:
>>>
>>> My intuition is that this patch has a high cost for normal GRO processing.
>>> SW-GRO is already a bottleneck on ARM cores in smart NICS.
>>>
>>> I would suggest instead using parameters to give both the nhoff and thoff values
>>> this would avoid many conditionals in the fast path.
>>>
>>> ->
>>>
>>> INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int
>>> nhoff, int thoff)
>>> {
>>>  const struct ipv6hdr *ipv6h = (const struct ipv6hdr *)(skb->data + nhoff);
>>>  struct udphdr *uh = (struct udphdr *)(skb->data + thoff);
>>> ...
>>> }
>>>
>>> INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int
>>> nhoff, int thoff)
>>> {
>>>        const struct ipv6hdr *iph =  (const struct ipv6hdr *)(skb->data + nhoff);
>>>        struct tcphdr *th = (struct tcphdr *)(skb->data + thoff);
>>>
>>> Why storing in skb fields things that really could be propagated more
>>> efficiently as function parameters ?
>>
>> Hi Eric,
>> Thanks for the review!
>>
>> I agree, the conditionals could be a problem and are actually not needed.
>> The third commit in this patch series introduces an optimisation for
>> ipv6/ipv4 using the correct {inner_}network_header. We can remove the
>> conditionals; I thought about multiple ways to do so. First, remove the
>> conditional in skb_gro_network_offset:
>>
>>     static inline int skb_gro_network_offset(const struct sk_buff *skb)
>>     {
>>         const u32 mask = NAPI_GRO_CB(skb)->encap_mark - 1;
>>         return (skb_network_offset(skb) & mask) | (skb_inner_network_offset(skb) & ~mask);
>>     }
> 
> I was trying to say that we do not need all these helpers, storing
> state in NAPI_GRO_CB(skb),
> dirtying cache lines...
> 
> Ideally, the skb network/transport/... headers could be set at the
> last stage, in gro_complete(big_gro_skb),
> instead of doing this for each segment.
> 
> All the gro_receive() could be much faster by using additional
> parameters (nhoff, thoff)
> 
> skb_gro_offset() could be replaced by the current offset (nhoff or
> other name), passed as a parameter.
> 
> Here is a WIP for gro_complete() step, this looks large but this is
> only adding a 2nd 'offset' parameter
> 
> Prior offset (typically network offset), called p_off
> Old argument nhoff, (renamed thoff if that makes sense), pointing to
> the current offset.
> 

You're right, it seemed to me like a broad change but it is mainly
cosmetic. I'll finish your version and submit it to fix the bug.

I still believe that setting inner_network_header is a valuable change.
For example, although skb_gro_network_offset is used - setting it in
encapsulation protocol functions (such as ipip_gro_receive) allow us to
remove conditionals from {ipv6,inet}_gro_receive gro_list loop and remove
flush_id from napi_gro_cb as written in the 3rd commit.
What are your thoughts about it as a separate patch?

