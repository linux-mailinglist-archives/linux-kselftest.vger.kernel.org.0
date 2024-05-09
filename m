Return-Path: <linux-kselftest+bounces-9816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367BB8C1523
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 21:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A43283158
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0835F7F7F5;
	Thu,  9 May 2024 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX23izYS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0DA653;
	Thu,  9 May 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715281375; cv=none; b=MFlhV7UOj2J9WjEt/Vw0v0+u1+cp33IDisL7KcorK4fiq+LcWQ2TDV5tnt4e+br1X9Oh1IsyibjsfFftnp/qAxeSwIPwGhpaGlyzVz2ANz94nEMJE9i4/+IUtEeSdGAZAcZrUcvfAwuAVyKxQg+0XvJw/c43VExEa/hP+F9pJHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715281375; c=relaxed/simple;
	bh=z8BjbZ0KhLr5lDThTCUSNLL0I0h3odrN0f1OqSGaQhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Na3uD1vTVTqLy/1iRogEiT8/bxFyLgRslXRwjVDdkhy7txAMLZ5bXkdQXTdPEbocq/yGkx4l1YZpqumpRfUfo7fpo7Sst1EOvju0qynHmqhMWXI9yzfMPsv9f/ZF8T1Um0KmDcbHdgJffF6VGFTRiXFgTCW3fGE/A6hfY5BZyLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EX23izYS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41c7ac71996so8589185e9.3;
        Thu, 09 May 2024 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715281372; x=1715886172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0mCUgWpAxxdQAlqmk3AkXAPrSMFLi4xORwnVMsbd4A=;
        b=EX23izYSb9GqA4m3K4KiBPV3til2EuQJX7/f8M63qGXvMUPX/RB8epuy6Yv0Xg7xNQ
         28/orNAS0Mkx8wN4/u94JuMajxp8RQP90L46sMA0Shee1rct2en4wp/iWB1d7un7Xb8Y
         qvB5rCLBEAniQ2eJg+nl73tdVFblIOWANYKBpFUmlPW2elwuhaSJTXNyOrn9B8jm86vB
         ketOmtZNkVGI2C2qaaYc6SlKZzTeZ/KUU502sHnuUSZy7amsrOIxdzGrSQ4p2+FbLYx6
         Nw4HgyCT4uSoQj/DxZoN+5HKyx+fHKk8vkpkxK8P0Y8grsgV2m6SgUldeCrGBhdJLOHA
         Tzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715281372; x=1715886172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K0mCUgWpAxxdQAlqmk3AkXAPrSMFLi4xORwnVMsbd4A=;
        b=PlNijU5xXRYEjk2CNfWDR9kHxC4kvumJRg2byrF760An0G7P51L8MR9vUVeWtKnS5F
         R2mplioI/QPatNQ+FjwVHxQiserbq7PPXxnaMJQhsrtcwAr1jqU1/womf4v8NW6wGuhe
         3mnsxEfb4cVM4eD5LhRw1R0lCpGnLuCnbVPerD/ct93QZzYaYQA1Q5uTwxPARW5G37zx
         4Kzclq00KMTdiNKPKqY8reBHP82mSU98sx6KmB60kaT3Aesh2fv/qkkdLi8mS0JX8cyv
         7+fwnS+HMU9rLTq/9PoHM4UdDvjzdqw2CLbuY3TMYi+9PNQX4KltH/xu2ysgPvYaoP9O
         ioqg==
X-Forwarded-Encrypted: i=1; AJvYcCWRiDXO+uFJLCKV4ZaKMmqdUjLu4XReEprZJ4ojrxtbRrR9tEy5BF46kxSqkfg0ZoyMfvtmvPYEh6eO5a/eJMOOuPb8dpptpXqhVBzA2FM+3efXIh7fCjDFUKEQ/AeSLlCvI6LkrPmRmhljSKwOll7coL8btN4Ht0nCpxCrVs1TtcB0SgTQ
X-Gm-Message-State: AOJu0YyXMDpuRfiJQPckAjvT4moKkgRx52Cp1IXA3elDZqJsUqjWr01v
	/9r9OfvawsHS1/PpReT+elEyHfAkgfzF7/iok9DvTUS87IJJg0q1
X-Google-Smtp-Source: AGHT+IE0riKnDu956AcGU2f7+WCkij2yDXQzO02wiZCWSJbPC/Nbi/I9scUCCWNWAfXr1C5eSakvpg==
X-Received: by 2002:adf:e981:0:b0:34c:f5d2:528d with SMTP id ffacd0b85a97d-3504a9580demr296333f8f.43.1715281372304;
        Thu, 09 May 2024 12:02:52 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fdcdd5788sm20977835e9.13.2024.05.09.12.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 12:02:51 -0700 (PDT)
Message-ID: <39829bfe-72d6-45de-bbbb-f487df090973@gmail.com>
Date: Thu, 9 May 2024 21:02:37 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v9 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: alexander.duyck@gmail.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org
References: <20240507162349.130277-1-richardbgobert@gmail.com>
 <20240507163021.130466-1-richardbgobert@gmail.com>
 <663cdcb73953_126914294b5@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <663cdcb73953_126914294b5@willemb.c.googlers.com.notmuch>
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
>> (gro_receive_network_flush is compiled inline to tcp_gro_receive)
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
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> 
>> +static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
>> +				 struct sk_buff *p, bool outer)
>> +{
>> +	const u32 id = ntohl(*(__be32 *)&iph->id);
>> +	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
>> +	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
>> +	const u16 count = NAPI_GRO_CB(p)->count;
>> +	const u32 df = id & IP_DF;
>> +	int flush;
>> +
>> +	/* All fields must match except length and checksum. */
>> +	flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
>> +
>> +	if (outer && df)
>> +		return flush;
> 
>     if (flush)
>             return 1;
> 
> To be able to avoid the two flush | below?
> Or to avoid adding a branch
> 
>     if (flush | (outer && df))
>             return 1;
> 
>> +
>> +	/* When we receive our second frame we can make a decision on if we
>> +	 * continue this flow as an atomic flow with a fixed ID or if we use
>> +	 * an incrementing ID.
>> +	 */
>> +	if (count == 1 && df && !ipid_offset)
>> +		NAPI_GRO_CB(p)->ip_fixedid = true;
>> +
>> +	if (NAPI_GRO_CB(p)->ip_fixedid && df)
>> +		return flush | ipid_offset;
>> +
>> +	return flush | (ipid_offset ^ count);
> 
> And then simply
> 
>     if (NAPI_GRO_CB(p)->ip_fixedid)
>             return ipid_offset;
>     else
>             return ipid_offset ^ count;
> 
> Since NAPI_GRO_CB(p)->ip_fixedid is only set if DF is set on the first
> two segments, and df ^ id2 & IP_DF is tested above, no need to test
> that again.
> 
>> +}

I like the idea, it is more readable.
We just need to return flush, and not 1 to make it correct (since flush
could be 0 while outer && df set):

if (flush | (outer && df))
		return flush;

Not setting NAPI_GRO_CB(p)->ip_fixedid when flush==1 is a slight change
from the previous behaviour.
AFAIU it is ok since it doesn't change GRO logic - p will be flushed from
gro_list and NAPI_GRO_CB becomes irrelevant.
Removing the DF check is nice, I also think we can avoid a branch
while keeping the code readable as follows:

return ipid_offset ^ (count * !NAPI_GRO_CB(p)->ip_fixedid);

