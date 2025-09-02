Return-Path: <linux-kselftest+bounces-40610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7402EB40823
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 16:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2403B8736
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32531319877;
	Tue,  2 Sep 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqNTHpn2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25E42DFA26;
	Tue,  2 Sep 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824715; cv=none; b=CYduf4cQduJL/R8Cc+zM699jtNGAqkQXzRpGeGyE73jdbwJvD3ZkczsZdJh497bp1aOmbG8C9fD9mKis/JaIeiyernIfUBw7W2A6dR+Hfk6nWJGaZUFiMVx+GyXvgyZaWwXY+xXvK2LHE+vM2jWDVL6wFUaoMB9ejs4xMhhCqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824715; c=relaxed/simple;
	bh=U+dxRjSf6jIW2bglfWLHV6i6zgwzXBdE8U7BUJ6+/nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNKx7OJC5fC6NmFFq2mUvPX5uFTNAAhpk5kpKPks/7/KBeMc/6ORWgx4OGz8CI0i5MhKwIX4TcnTuLBaPIGkTL7seMb5fBABlyJC99kyKLXeuRag68a8/1I4hBN/zPe9pJc20ECyJI7yO6uFwGCQpt6GGkAGhKGSwl+VBqzd7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqNTHpn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADD5C4CEF5;
	Tue,  2 Sep 2025 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756824714;
	bh=U+dxRjSf6jIW2bglfWLHV6i6zgwzXBdE8U7BUJ6+/nY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aqNTHpn2ALOkuwXUyFyXWzRj7T5Z772S3TGgmk88SHljW6MWxiMTRxpj9+K9+ZB4F
	 7MGSxFm3pb/hzUFcFjxJ7YI7sERVFODsz7TGm7fUaiWQtcgSsXuSxdHwhNQkQXFaDU
	 cUTJKKiMOZ4/P+i19WcWhpqneZ7c3eIp15vPYm9rk9TMQtTh7JPynHVUIncqwJEGCq
	 bqcpCFWQ7qS1zRfyxV86Uy2NpcCu6ABpLcsq5v8o0UxTUwH/eMauDRjgFf1Az+j+MD
	 JW0QmIHSHfsr+s20IL7D6N9CNw8L8iACANdknVTpPpkckpxe3huqi2FCagdc2yfGAZ
	 A4sIrBPN/MoBA==
Message-ID: <834238b4-3549-4062-a29b-bf9c5aefa30f@kernel.org>
Date: Tue, 2 Sep 2025 16:51:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 0/6] mptcp: misc. features for v6.18
Content-Language: en-GB, fr-BE
To: Jakub Kicinski <kuba@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
 Christoph Paasch <cpaasch@openai.com>, Gang Yan <yangang@kylinos.cn>
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
 <20250902072600.2a9be439@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250902072600.2a9be439@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 02/09/2025 16:26, Jakub Kicinski wrote:
> On Mon, 01 Sep 2025 11:39:09 +0200 Matthieu Baerts (NGI0) wrote:
>> This series contains 4 independent new features:
>>
>> - Patch 1: use HMAC-SHA256 library instead of open-coded HMAC.
>>
>> - Patches 2-3: make ADD_ADDR retransmission timeout adaptive + simplify
>>   selftests.
>>
>> - Patch 4: selftests: check for unexpected fallback counter increments.
>>
>> - Patches 5-6: record subflows in RPS table, for aRFS support.
> 
> I don't see why, but kmemleak started to hit this with the join test
> 2 branches ago :\ Have you seen any kmemleak issues on your side?
> We also see occasional leaked skb in driver tests which makes no sense.
> 
> unreferenced object 0xffff8880029d3340 (size 3016):
>   comm "softirq", pid 0, jiffies 4297316940
>   hex dump (first 32 bytes):
>     0a 00 01 02 0a 00 01 01 00 00 00 00 9e b8 7d 27  ..............}'
>     0a 00 07 41 00 00 00 00 00 00 00 00 00 00 00 00  ...A............
>   backtrace (crc 3653d88c):
>     kmem_cache_alloc_noprof+0x284/0x330
>     sk_prot_alloc.constprop.0+0x4e/0x1b0
>     sk_clone_lock+0x4b/0x10d0
>     mptcp_sk_clone_init+0x2e/0x10d0
>     subflow_syn_recv_sock+0x9d1/0x1680
>     tcp_check_req+0x3a4/0x1910
>     tcp_v4_rcv+0x1004/0x30a0
>     ip_protocol_deliver_rcu+0x82/0x350
>     ip_local_deliver_finish+0x35d/0x620
>     ip_local_deliver+0x19c/0x470
>     ip_rcv+0xc2/0x370
>     __netif_receive_skb_one_core+0x108/0x180
>     process_backlog+0x3c1/0x13e0
>     __napi_poll.constprop.0+0x9f/0x460
>     net_rx_action+0x54f/0xda0
>     handle_softirqs+0x215/0x610

Thank you for this notification!

No, I didn't notice that on our side. For KMemLeak, now I'm waiting 5
seconds, then I force the scan, and check for issues once. On NIPA, I
see that there are still 2 scans + cat, and apparently, the issue was
always visible during the 2nd scan:


https://netdev-3.bots.linux.dev/vmksft-mptcp-dbg/results/279881/1-mptcp-join-sh/stdout

https://netdev-3.bots.linux.dev/vmksft-mptcp-dbg/results/280062/1-mptcp-join-sh/stdout

It is unclear why a second scan is needed and only the second one caught
something. Was it the same with the strange issues you mentioned in
driver tests? Do you think I should re-add the second scan + cat?

When looking at the modifications of this series, it is unclear what
could cause that.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


