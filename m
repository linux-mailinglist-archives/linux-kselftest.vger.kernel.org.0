Return-Path: <linux-kselftest+bounces-20195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D709A4DD7
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 14:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA663287111
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 12:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F5C1E0482;
	Sat, 19 Oct 2024 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YxPX3zU+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB22629D;
	Sat, 19 Oct 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729341807; cv=none; b=TJXCdgmFZKm6n2Fvq8ynpqiCcpN5XWAvr+Q3vfxH7niZTWs9oLIyzk49xK67HUixW279UhrSXI9sRh01xDRY6ryJwO2c35480rjHabZv38oo9iYctGQDC/7TRxhn7D1Hy+gO1XTx0O/F7QUhIRWwo+HgsmLUxbkugoyaBZWQRMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729341807; c=relaxed/simple;
	bh=MCECID1mMns7JnFmuQsykWtjlGQqgJ0LlFwOWLuAAgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYwcsPI50cDAFr/zVyzZolsaRWH3UYyXst5c3D4fyvEeQsq+zt4HxfdkFctRjifvOAsOGRON3SEM+4Avt6SN/GJWmnVg+drge7NU9tpr4zMZPBm4ffw3HdToOI0QfT0XXdaBROqyeYpisZjHWK8LlOH/GpD/Lr3ED6or5DmkdSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YxPX3zU+; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BAE5E1BF203;
	Sat, 19 Oct 2024 12:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729341801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WLdd6Is6r9a0Ysxdr4jYilHpYOiFvt9fjYlY3rJCk0o=;
	b=YxPX3zU+8ZH3tnMKQuGaMji+D3DkUhBuB/iWLf6UE7m7h/TL/IfOfFF4DVrMR499UtZyxc
	OmHbIxa/UEccD3UWZYO/+BfqIwF5TfYG21E284NfQUUeexdkyG2IysofXVXaE4xmeeNfKj
	e/9JmD0oFTRg8mY2bIcGJxgz+NZta0UEO9JPf+xdNGW6KAfLRB8d9vQFGZt/VBN+XLFuIO
	ek8+KIFbla/OXUmOR3jxm6a2fQ6hKhT+FAov726T1ZdO+B/CF8PZaXLNi6+W5U+U7JaNwp
	pAg4NWCQl2iz2X1GpboOs+0XjFZuvWC6v0kjEMPwjy6U5PfDbdfx5Y7hs7cXgw==
Message-ID: <b9f7bf76-d58f-4e65-82e7-551464b6b7df@bootlin.com>
Date: Sat, 19 Oct 2024 14:43:19 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/6] selftests/bpf: add ipv4 and dual ipv4/ipv6
 support in btf_skc_cls_ingress
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lorenz Bauer <lmb@cloudflare.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241016-syncookie-v1-0-3b7a0de12153@bootlin.com>
 <20241016-syncookie-v1-4-3b7a0de12153@bootlin.com>
 <43f0d39a-b353-4f38-85f7-e0a557f911f9@linux.dev>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <43f0d39a-b353-4f38-85f7-e0a557f911f9@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 10/19/24 02:30, Martin KaFai Lau wrote:
> On 10/16/24 11:35 AM, Alexis Lothoré (eBPF Foundation) wrote:

[...]

>>   +    switch (ip_mode) {
>> +    case TEST_MODE_IPV4:
>> +        sock_family = AF_INET;
>> +        srv_addr = SERVER_ADDR_IPV4;
>> +        addr = (struct sockaddr_storage *)&srv_sa4;
>> +        addr_len = sizeof(srv_sa4);
>> +        break;
>> +    case TEST_MODE_IPV6:
>> +        opts.post_socket_cb = v6only_true;
>> +        sock_family = AF_INET6;
>> +        srv_addr = SERVER_ADDR_IPV6;
>> +        addr = (struct sockaddr_storage *)&srv_sa6;
>> +        addr_len = sizeof(srv_sa6);
>> +        break;
>> +    case TEST_MODE_DUAL:
>> +        opts.post_socket_cb = v6only_false;
>> +        sock_family = AF_INET6;
>> +        srv_addr = SERVER_ADDR_DUAL;
>> +        addr = (struct sockaddr_storage *)&srv_sa6;
>> +        addr_len = sizeof(srv_sa6);
>> +        break;
>> +    default:
>> +            break;
> 
> nit. indentation is off.

True, and for some reason checkpatch does not raise any warning here. This will
be fixed in v2 for all switch cases

> better directly "return;", in case future something complains vars are not init.

ACK. I'll also add a PRINT_FAIL call in those default statements.

> 
>> +    }
>> +
>>       if (write_sysctl("/proc/sys/net/ipv4/tcp_syncookies", tcp_syncookies))
>>           return;
>>   -    listen_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
>> +    listen_fd = start_server_str(sock_family, SOCK_STREAM, srv_addr,  0,
>> +                     &opts);
>>       if (!ASSERT_OK_FD(listen_fd, "start server"))
>>           return;
>>   -    err = getsockname(listen_fd, (struct sockaddr *)&srv_sa6, &addrlen);
>> +    err = getsockname(listen_fd, (struct sockaddr *)addr, &addr_len);
>>       if (!ASSERT_OK(err, "getsockname(listen_fd)"))
>>           goto done;
>> -    memcpy(&skel->bss->srv_sa6, &srv_sa6, sizeof(srv_sa6));
>> -    srv_port = ntohs(srv_sa6.sin6_port);
>> +
>> +    switch (ip_mode) {
>> +    case TEST_MODE_IPV4:
>> +        memcpy(&skel->bss->srv_sa4, &srv_sa4, sizeof(srv_sa4));
>> +        srv_port = ntohs(srv_sa4.sin_port);
>> +        break;
>> +    case TEST_MODE_IPV6:
>> +    case TEST_MODE_DUAL:
>> +        memcpy(&skel->bss->srv_sa6, &srv_sa6, sizeof(srv_sa6));
>> +        srv_port = ntohs(srv_sa6.sin6_port);
>> +        break;
>> +    default:
>> +            break;
> 
> indentation off. also "goto done;"

I can add the goto done as a safety net (eg in case someone modifies the test
later and miss some details), but with the return added on the switch above
(also done on ip_mode), the goto should never be executed.

[...]

>>   -static int handle_ip6_tcp(struct ipv6hdr *ip6h, struct __sk_buff *skb)
>> +static int handle_ip_tcp(struct ethhdr *eth, struct __sk_buff *skb)
>>   {
>> -    struct bpf_sock_tuple *tuple;
>> +    struct bpf_sock_tuple *tuple = NULL;
>> +    unsigned int tuple_len = 0;
>>       struct bpf_sock *bpf_skc;
>> -    unsigned int tuple_len;
>> +    struct ipv6hdr *ip6h;
>> +    void *iphdr = NULL;
>> +    int iphdr_size = 0;
>> +    struct iphdr *ip4h;
> 
> nit. All new "= 0;" and "= NULL;" init should not be needed.

I added those "by default" because my last series raised some build errors with
clang while building fine with gcc (but in the end, there was indeed code paths
possibly using those variables uninitialized). ACK, I'll remove those initializers.

[...]

>> +    }
>>   -    /* Is it the testing traffic? */
>> -    if (th->dest != srv_sa6.sin6_port)
>> +    if (!tuple) {
> 
> !tuple should not be possible. can be removed.

I initially added that check because of the verifier complained about tuple
being scalar. But I have checked and removed it again and it is now... accepted
? I guess I was still missing some other parts when I got this error, very
likely the `return TC_ACT_OK` in the default case. I'll then remove this check
in v2.

[...]

>>   -    if (ip6h->nexthdr == IPPROTO_TCP)
>> -        return handle_ip6_tcp(ip6h, skb);
>> +    return handle_ip_tcp(eth, skb);
>>         return TC_ACT_OK;
> 
> The last double return should have been removed also.

That's indeed a miss, I'll remove it.

Thanks,

Alexis


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

