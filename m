Return-Path: <linux-kselftest+bounces-4925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7973A85A1C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 12:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1041C20F17
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 11:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC6D2C191;
	Mon, 19 Feb 2024 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="mNm0yZV2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF80028DD2;
	Mon, 19 Feb 2024 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341500; cv=none; b=igdU/4BqfuxFPf/8KLW2AekSThE2RMiys1kjANcVO/1J8CKl3a1vvuY0806s7vgtSAY6C73UGBuGnvXFW0u5xaPrXkCV27rUFLWZXeyDhJms96Bos10B/LY3y1Tt3/U/EcdCJezqTDxgNyFcfKh++uKsgFlDZJBkGN3uH/7FMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341500; c=relaxed/simple;
	bh=/a/hjVeGi6TuuWHevLBmftl0dE9+L5XpYnN6/mutY2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjQIQUFclGIWV3QJm/5zjqv3LOmgtRA8zjWzF2GAv/BMUiQFEwUEJzoxF5MIGiGMxcZdmGLGEwqGCs3nX2LYOUL/MHuWyHQdLbhYUqwyujKIcHlEL2VD6wiusIlBeufPDeqis8JH2Llxzil7ASDCPZfytlLkUwK34tEwMKeNq8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=mNm0yZV2; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.38] (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 49A54200C962;
	Mon, 19 Feb 2024 12:18:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 49A54200C962
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708341489;
	bh=6DkiwY1/oZd3nYoHLT4En6bSLBbAgoN0ZstZmoG4ktk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mNm0yZV2gWvCKe4F8CNSBd9sBJn8uGHco5E5KPRL6Pa2DBoyFtgPguUPiteGS7Mo8
	 ty1ZM2SQt0VWz+XOwiMv6nWShwpood8jg84g+mfAUH/s0N275jJ+W/erlWX4741gv4
	 q4nsRuN/qoqwPPfbKVu4a6Ja2NJfxEAci9rRV+G/I11L2esowH6RdS06xCo2ZEXBlJ
	 FGJNe2Xsh/tTBKHWfOzRXaKQvSt9YsPdqIKF1hyBGTuaYVJdiD7pmhcStMSzTjOnEf
	 gMIrXfhfcnKo2g1gvpZzs+q8AZO4PRVuFNHvPVDetX1y3v+hRhPccQQtwG+egPvLft
	 1lbgWLsceMyjA==
Message-ID: <6fb6a4c3-9703-4ab3-ab93-06c8c62bb99a@uliege.be>
Date: Mon, 19 Feb 2024 12:18:08 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ioam6: fix write to cloned skb in ipv6_hop_ioam()
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240216234356.32243-1-justin.iurman@uliege.be>
 <20240216234356.32243-2-justin.iurman@uliege.be>
 <e92bea31ff921ea072de86acc2694621fd11a016.camel@redhat.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <e92bea31ff921ea072de86acc2694621fd11a016.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/24 10:05, Paolo Abeni wrote:
> On Sat, 2024-02-17 at 00:43 +0100, Justin Iurman wrote:
>> ioam6_fill_trace_data() writes inside the skb payload without ensuring
>> it's writeable (e.g., not cloned). This function is called both from the
>> input and output path. The output path (ioam6_iptunnel) already does the
>> check. This commit provides a fix for the input path, inside
>> ipv6_hop_ioam().
>>
>> Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace ")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
>> ---
>>   net/ipv6/exthdrs.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
>> index 4952ae792450..f68e5faab3aa 100644
>> --- a/net/ipv6/exthdrs.c
>> +++ b/net/ipv6/exthdrs.c
>> @@ -943,6 +943,14 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
>>   		if (!skb_valid_dst(skb))
>>   			ip6_route_input(skb);
>>   
>> +		if (skb_cloned(skb)) {
>> +			if (pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
>> +				goto drop;
> 
> My personal preference would be for using skb_ensure_writable() here,
> with write_len == optoff + hdr->opt_len.

OK, will do!

>> +
>> +			hdr = (struct ioam6_hdr *)(skb_network_header(skb) + optoff);
>> +			trace = (struct ioam6_trace_hdr *)((u8 *)hdr + sizeof(*hdr));
> 
> Note that this can potentially change the network header ptr and the
> caller - ip6_parse_tlv() - has cached such value in 'nh'. You also need
> to update ip6_parse_tlv() to reload such pointer.

+1, I completely missed it, thanks!

> Side note: a bunch of self-tests are apparently stuck after this
> series. I think it's an unrelated problem. I'll try to have a better
> look.

Can you share the config to observe such behavior? I'll try to 
investigate too.

> Cheers,
> 
> Paolo
> 

