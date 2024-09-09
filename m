Return-Path: <linux-kselftest+bounces-17526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E79FE971D6A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 17:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AAF1F235E5
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D211BC49;
	Mon,  9 Sep 2024 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="heo2ntQQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15614295
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Sep 2024 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894161; cv=none; b=qLSa8XRBs0hFucqilFCJcBRsrDYugOaFDyv05AkCZaQJlACMfUxeH9ImhzP/neA7ZS2ec+MhzFPxwmbE7X4hxeLAM/50urPbdyQYMhWA+u7c9XGNlHqS546fd8W90TRpiprcJDEkbXXU9emfRFY/Kd0Q1jDWaK/Mc7ADpnQTrUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894161; c=relaxed/simple;
	bh=yOrzAeJULCp8CNbN800/DZvDmE7I+QRQGaJGd427FOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwWlqU90Wp8yr2kvyWdIFoK5r92mPHywdolUWydVS6/p7DgDhGIS54rn7KVV3g/xjgS2AvsuCm/HGW+2/TkCXEKxHwrCKsv44bGDF6Ys92Wz1/ewp3ShESoh7kww9zz4vjTlNc0h/eglmTA+XXPZ2qnq5e85B5TbGlqFOm7iI4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=heo2ntQQ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9d5bf385-2ef0-435d-b6f9-1de55533653b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725894156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBUjCWXMIdE3euI/x+021PTEDizxiCwvnMj/e5Rujcg=;
	b=heo2ntQQ3tgC68+7TwArPLkMV9HabzTYMWrA7eX0M5pIufYoF/2Spzb6U/1P0X46hpDB+B
	dl6bLBX0SPNaHx4wM7YqSkd2m+p3iypgwyOzqRJH+IlCfCBYxX/Cao5tbxU6O9KKBanigf
	/mlJ0BvSIFd9fkEUqgNVIFpiw+aJHJM=
Date: Mon, 9 Sep 2024 11:02:30 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] selftests: net: csum: Fix checksums for packets with
 non-zero padding
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20240906210743.627413-1-sean.anderson@linux.dev>
 <66dbb4fcbf560_2af86229423@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <66dbb4fcbf560_2af86229423@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/6/24 22:05, Willem de Bruijn wrote:
> Sean Anderson wrote:
>> Padding is not included in UDP and TCP checksums. Therefore, reduce the
>> length of the checksummed data to include only the data in the IP
>> payload. This fixes spurious reported checksum failures like
>> 
>> rx: pkt: sport=33000 len=26 csum=0xc850 verify=0xf9fe
>> pkt: bad csum
> 
> Are you using this test as receiver for other input?
> 
> The packet builder in the test doesn't generate these, does it?

It's added by the MAC before transmission.

This is permitted by the standard, but in this case it actually appears
to be due to the MAC using 32-bit reads for the data and not masking off
the end. Not sure whether this is a bug in the driver/device, since
technically we may leak up to 3 bytes of memory.

That said, it would be a nice enhancement to generate packets with
non-zero padding as well, since they are an interesting edge case.

> Just trying to understand if this is a bug fix or a new use for
> csum.c as receiver.

Bug fix.

>> Technically it is possible for there to be trailing bytes after the UDP
>> data but before the Ethernet padding (e.g. if sizeof(ip) + sizeof(udp) +
>> udp.len < ip.len). However, we don't generate such packets.
> 
> More likely is that L3 and L4 length fields agree, as both are
> generated at the sender, but that some trailer is attached in the
> network. Such as a timestamp trailer.

Yes, as noted above we don't generate packets with differing L3 and L4
lengths.

>> Fixes: 91a7de85600d ("selftests/net: add csum offload test")
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> Found while testing for this very bug in hardware checksum offloads.
>> 
>>  tools/testing/selftests/net/lib/csum.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
>> index b9f3fc3c3426..e0a34e5e8dd5 100644
>> --- a/tools/testing/selftests/net/lib/csum.c
>> +++ b/tools/testing/selftests/net/lib/csum.c
>> @@ -654,10 +654,16 @@ static int recv_verify_packet_ipv4(void *nh, int len)
>>  {
>>  	struct iphdr *iph = nh;
>>  	uint16_t proto = cfg_encap ? IPPROTO_UDP : cfg_proto;
>> +	uint16_t ip_len;
>>  
>>  	if (len < sizeof(*iph) || iph->protocol != proto)
>>  		return -1;
>>  
>> +	ip_len = ntohs(iph->tot_len);
>> +	if (ip_len > len || ip_len < sizeof(*iph))
>> +		return -1;
>> +
>> +	len = ip_len;
>>  	iph_addr_p = &iph->saddr;
>>  	if (proto == IPPROTO_TCP)
>>  		return recv_verify_packet_tcp(iph + 1, len - sizeof(*iph));
>> @@ -669,16 +675,22 @@ static int recv_verify_packet_ipv6(void *nh, int len)
>>  {
>>  	struct ipv6hdr *ip6h = nh;
>>  	uint16_t proto = cfg_encap ? IPPROTO_UDP : cfg_proto;
>> +	uint16_t ip_len;
> 
> nit: payload_len, as it never includes sizeof ipv6hdr

OK

--Sean

>>  	if (len < sizeof(*ip6h) || ip6h->nexthdr != proto)
>>  		return -1;
>>  
>> +	ip_len = ntohs(ip6h->payload_len);
>> +	if (ip_len > len - sizeof(*ip6h))
>> +		return -1;
>> +
>> +	len = ip_len;
>>  	iph_addr_p = &ip6h->saddr;
>>  
>>  	if (proto == IPPROTO_TCP)
>> -		return recv_verify_packet_tcp(ip6h + 1, len - sizeof(*ip6h));
>> +		return recv_verify_packet_tcp(ip6h + 1, len);
>>  	else
>> -		return recv_verify_packet_udp(ip6h + 1, len - sizeof(*ip6h));
>> +		return recv_verify_packet_udp(ip6h + 1, len);
>>  }
>>  
>>  /* return whether auxdata includes TP_STATUS_CSUM_VALID */
>> -- 
>> 2.35.1.1320.gc452695387.dirty
>> 
> 
> 

