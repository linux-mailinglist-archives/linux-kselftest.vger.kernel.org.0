Return-Path: <linux-kselftest+bounces-27634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46123A467A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 18:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389D53A28D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 17:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3C6224898;
	Wed, 26 Feb 2025 17:14:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E46192D63;
	Wed, 26 Feb 2025 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590085; cv=none; b=TG4Kcg27FxpIRuGuJZbtZXyATXor00G7d8+tE7+kDYB8ElEXjzzJTYShAYNp+1+9xHOxsYwKPWhzoXUvOJ1xrY0iNU+AF4ucOcvdISTSe6ulcLKWx/OiueCeZHxMroGxdAc/7SYsn7lPiuyjg16UlWq0CW7uyi5hqg/ZVFIkRKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590085; c=relaxed/simple;
	bh=KxFN3aNE7TxRGAXyhYwm0L9K2okbb+lZv7kvdmTMwlw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=TaoMBIn1HBnopVnntjq+8fJJ2qQRvNSIAKNZSERXrWjhJ+/eiX6H3uwESy4kFiebWUJpiyzE9z+bAE8Rksl0KKF7xUg3r4WV7kUYXx3PZTD8zq6czCO7w/U6tFP4uZUXofK0aiRImEBJPoEcdD9cz+q0OlBGe82mf0HHtgnbmg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tnKzE-000Kjt-53; Wed, 26 Feb 2025 18:14:20 +0100
Received: from [2a0d:3344:1523:1f10:f118:b2d4:edbb:54af]
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tnKzE-000CxP-0Q;
	Wed, 26 Feb 2025 18:14:19 +0100
Message-ID: <c2fc1cc2-b0e4-40de-9f0c-0e383c0fe1b3@hetzner-cloud.de>
Date: Wed, 26 Feb 2025 18:14:18 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, hawk@kernel.org
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
 <20250224152909.3911544-5-marcus.wichelmann@hetzner-cloud.de>
 <67be0cac4d366_25ccfc294e8@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Autocrypt: addr=marcus.wichelmann@hetzner-cloud.de; keydata=
 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
 wySmewx3h/yfMh0aFxHhvLPxrO2IEQ==
Subject: Re: [PATCH bpf-next v3 4/6] selftests/bpf: refactor
 xdp_context_functional test and bpf program
In-Reply-To: <67be0cac4d366_25ccfc294e8@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27561/Wed Feb 26 10:36:26 2025)

Am 25.02.25 um 19:32 schrieb Willem de Bruijn:
> Marcus Wichelmann wrote:
>> The existing XDP metadata test works by creating a veth pair and
>> attaching XDP & TC programs that drop the packet when the condition of
>> the test isn't fulfilled. The test then pings through the veth pair and
>> succeeds when the ping comes through.
>>
>> While this test works great for a veth pair, it is hard to replicate for
>> tap devices to test the XDP metadata support of them. A similar test for
>> the tun driver would either involve logic to reply to the ping request,
>> or would have to capture the packet to check if it was dropped or not.
>>
>> To make the testing of other drivers easier while still maximizing code
>> reuse, this commit refactors the existing xdp_context_functional test to
>> use a test_result map. Instead of conditionally passing or dropping the
>> packet, the TC program is changed to copy the received metadata into the
>> value of that single-entry array map. Tests can then verify that the map
>> value matches the expectation.
>>
>> This testing logic is easy to adapt to other network drivers as the only
>> remaining requirement is that there is some way to send a custom
>> Ethernet packet through it that triggers the XDP & TC programs.
>>
>> The payload of the Ethernet packet is used as the test data that is
>> expected to be passed as metadata from the XDP to the TC program and
>> written to the map. It has a fixed size of 32 bytes which is a
>> reasonalbe size that should be supported by both drivers. Additional
>> packet headers are not necessary for the test and were therefore skipped
>> to keep the testing code short.
>>
>> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> 
>> -	SYS(close, "ip addr add " RX_ADDR "/24 dev " RX_NAME);
> 
> Why remove the Rx and Tx addresses?

Because the testing methodology is changed from pinging and IP address
to sending a custom packet and handling it in XDP instead, the IP addresses
are no longer relevant for this test.
I removed them to reduce the testing code to only the setup tasks that are
needed for the test to do its job.

I can add a note about this to the commit message.

>> [...]
>>   
>> -	tc_prog = bpf_object__find_program_by_name(skel->obj, "ing_cls");
>> -	if (!ASSERT_OK_PTR(tc_prog, "open ing_cls prog"))
>> -		goto close;
>> -
>> -	tc_opts.prog_fd = bpf_program__fd(tc_prog);
>> +	tc_opts.prog_fd = bpf_program__fd(skel->progs.ing_cls);
> 
> This refactor seems irrelevant to the goal of this patch? Same below.

Fair point. These were drive-by cleanups to make the testing code less
verbose. But you're right, they are not relevant and just inflate the diff.
I'll remove them from the patch.

>> [...]
>> @@ -179,9 +231,18 @@ void test_xdp_context_functional(void)
>>   	if (!ASSERT_OK_PTR(nstoken, "setns tx_ns"))
>>   		goto close;
>>   
>> -	SYS(close, "ip addr add " TX_ADDR "/24 dev " TX_NAME);
>> +	SYS(close, "ip link set dev " TX_NAME " arp off");
>>   	SYS(close, "ip link set dev " TX_NAME " up");
> 
>>   SEC("tc")
>>   int ing_cls(struct __sk_buff *ctx)
>>   {
>> -	__u8 *data, *data_meta, *data_end;
>> -	__u32 diff = 0;
>> +	void *data_meta = (void *)(unsigned long)ctx->data_meta;
>> +	void *data = (void *)(unsigned long)ctx->data;
>>   
>> -	data_meta = ctx_ptr(ctx, data_meta);
>> -	data_end  = ctx_ptr(ctx, data_end);
>> -	data      = ctx_ptr(ctx, data);
> 
> Similarly: why these changes?
> 
> In general, please minimize your patch to the core purpose. Avoid
> including "cleanups" or other such refactors. Or justify the choice
> explicitly in the commit message.

I had rewritten the function bodies of these two BPF programs from
scratch because the functionality changed significantly. That's where
this comes from.
I'll try to reuse more of the existing code to make the diff shorter.

>> -
>> -	if (data + ETH_ALEN > data_end ||
>> -	    data_meta + round_up(ETH_ALEN, 4) > data)
>> +	if (data_meta + META_SIZE > data)
>>   		return TC_ACT_SHOT;
>>   
>> -	diff |= ((__u32 *)data_meta)[0] ^ ((__u32 *)data)[0];
>> -	diff |= ((__u16 *)data_meta)[2] ^ ((__u16 *)data)[2];
>> +	int key = 0;
>> +
>> +	bpf_map_update_elem(&test_result, &key, data_meta, BPF_ANY);
>>   
>> -	return diff ? TC_ACT_SHOT : TC_ACT_OK;
>> +	return TC_ACT_SHOT;
>>   }
>>   
>>   SEC("xdp")
>>   int ing_xdp(struct xdp_md *ctx)
>>   {
>> -	__u8 *data, *data_meta, *data_end;
>> -	int ret;
>> -
>> -	ret = bpf_xdp_adjust_meta(ctx, -round_up(ETH_ALEN, 4));
>> +	int ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
>>   	if (ret < 0)
>>   		return XDP_DROP;
>>   
>> -	data_meta = ctx_ptr(ctx, data_meta);
>> -	data_end  = ctx_ptr(ctx, data_end);
>> -	data      = ctx_ptr(ctx, data);
>> +	void *data_meta = (void *)(unsigned long)ctx->data_meta;
>> +	void *data = (void *)(unsigned long)ctx->data;
>> +	void *data_end = (void *)(unsigned long)ctx->data_end;
>>   
>> -	if (data + ETH_ALEN > data_end ||
>> -	    data_meta + round_up(ETH_ALEN, 4) > data)
>> +	void *payload = data + sizeof(struct ethhdr);
>> +
>> +	if (data_meta + META_SIZE > data || payload + META_SIZE > data_end)
>>   		return XDP_DROP;
>>   
>> -	__builtin_memcpy(data_meta, data, ETH_ALEN);
>> +	__builtin_memcpy(data_meta, payload, META_SIZE);
>> +
>>   	return XDP_PASS;
>>   }
>>   
>> -- 
>> 2.43.0
>>

