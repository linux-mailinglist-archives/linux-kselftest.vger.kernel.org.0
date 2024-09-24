Return-Path: <linux-kselftest+bounces-18331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBF2984F32
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 01:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0BE3B228B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 23:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154B1898FF;
	Tue, 24 Sep 2024 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JCJWHwoG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396AA14F9EE;
	Tue, 24 Sep 2024 23:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222312; cv=none; b=J3GAWxRa9ZVQYJg4aTjG24KiS4HeZZjz629q8/OTYoXgBS6MQQbDLqhInyABHJd4xYey391OGAqm9mT6zUqSsufa4aQpIhvFwjYNSYMkTx8WxNyQdjOjo5v6x7Bs1uT8pMyTCFv+Cu5D3oz/FLCS6RuufdVi6BLiQbAeKgaUuoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222312; c=relaxed/simple;
	bh=K9n+AavOkX7MxXFNd46/bNtSLpAWA69QCnjmfIck+Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsUUyXAhC7Wje/qw+8/XeQKbENzHZIDIzgFhP9e5ihrGfkRLBi55Ne2nKwBIMHHNqE3ETmj7oAbHeTZXtYZduqilKEuQd5i0SCk+OtweVQtkBkj6Ce01Oga/y+Nq7xOxoYBXRdI3BXzdIyA76sF5EMo+DKcHmuMP7I/i9mYR/CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JCJWHwoG; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0288caf4-3c9b-4eae-a2b4-f8934badc270@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727222308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJE52kWSLJz5Z0JKa0w5KuGxIC2eyIYAYGmmWOSFST4=;
	b=JCJWHwoGV68v2uahGUBKx3Hcx5Y5o0qp2/LrqjG9J4z4KaXLSE3utSm/IB5acOcIu3RNS7
	qxVKwvuJuRaB0DhlPNbWoSw4cS0hnN0+Fee3/xS/uJzRtiaeD+zLoZJklfMGLD2rfj+oKp
	yBZOzyP7CcwPR9tyUlmwxY0/bjTgpcg=
Date: Tue, 24 Sep 2024 16:58:19 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/3] ipv6: Run a reverse sk_lookup on sendmsg.
To: Tiago Lam <tiagolam@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
 kernel-team@cloudflare.com
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
 <20240913-reverse-sk-lookup-v1-2-e721ea003d4c@cloudflare.com>
 <d17da5b6-6273-4c2c-abd7-99378723866e@linux.dev> <ZumrBKAkZX0RZrgm@GHGHG14>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZumrBKAkZX0RZrgm@GHGHG14>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/17/24 6:15 PM, Tiago Lam wrote:
> On Fri, Sep 13, 2024 at 11:24:09AM -0700, Martin KaFai Lau wrote:
>> On 9/13/24 2:39 AM, Tiago Lam wrote:
>>> This follows the same rationale provided for the ipv4 counterpart, where
>>> it now runs a reverse socket lookup when source addresses and/or ports
>>> are changed, on sendmsg, to check whether egress traffic should be
>>> allowed to go through or not.
>>>
>>> As with ipv4, the ipv6 sendmsg path is also extended here to support the
>>> IPV6_ORIGDSTADDR ancilliary message to be able to specify a source
>>> address/port.
>>>
>>> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
>>> Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
>>> ---
>>>    net/ipv6/datagram.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>    net/ipv6/udp.c      |  8 ++++--
>>>    2 files changed, 82 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
>>> index fff78496803d..4214dda1c320 100644
>>> --- a/net/ipv6/datagram.c
>>> +++ b/net/ipv6/datagram.c
>>> @@ -756,6 +756,27 @@ void ip6_datagram_recv_ctl(struct sock *sk, struct msghdr *msg,
>>>    }
>>>    EXPORT_SYMBOL_GPL(ip6_datagram_recv_ctl);
>>> +static inline bool reverse_sk_lookup(struct flowi6 *fl6, struct sock *sk,
>>> +				     struct in6_addr *saddr, __be16 sport)
>>> +{
>>> +	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
>>> +	    (saddr && sport) &&
>>> +	    (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, saddr) || inet_sk(sk)->inet_sport != sport)) {
>>> +		struct sock *sk_egress;
>>> +
>>> +		bpf_sk_lookup_run_v6(sock_net(sk), IPPROTO_UDP, &fl6->daddr, fl6->fl6_dport,
>>> +				     saddr, ntohs(sport), 0, &sk_egress);
>>
>> iirc, in the ingress path, the sk could also be selected by a tc bpf prog
>> doing bpf_sk_assign. Then this re-run on sk_lookup may give an incorrect
>> result?
>>
> 
> If it does give the incorrect result, we still fallback to the normal
> egress path.
> 
>> In general, is it necessary to rerun any bpf prog if the user space has
>> specified the IP[v6]_ORIGDSTADDR.
>>
> 
> More generally, wouldn't that also be the case if someone calls
> bpf_sk_assign() in both TC and sk_lookup on ingress? It can lead to some
> interference between the two.
> 
> It seems like the interesting cases are:
> 1. Calling bpf_sk_assign() on both TC and sk_lookup ingress: if this
> happens sk_lookup on egress should match the correct socket when doing
> the reverse lookup;
> 2. Calling bpf_sk_assign() only on ingress TC: in this case it will
> depend if an sk_lookup program is attached or not:
>    a. If not, there's no reverse lookup on egress either;
>    b. But if yes, although the reverse sk_lookup here won't match the
>    initial socket assigned at ingress TC, the packets will still fallback
>    to the normal egress path;
> 
> You're right in that case 2b above will continue with the same
> restrictions as before.

imo, all these cases you described above is a good signal that neither the TC 
nor the BPF_PROG_TYPE_SK_LOOKUP program type is the right bpf prog to run here 
_if_ a bpf prog was indeed useful here.

I only followed some of the other discussion in v1 and v2. For now, I still 
don't see running a bpf prog is useful here to process the IP[V6]_ORIGDSTADDR. 
Jakub Sitnicki and I had discussed a similar point during the LPC.

If a bpf prog was indeed needed to process a cmsg, this should work closer to 
what Jakub Sitnicki had proposed for getting the meta data during LPC (but I 
believe the verdict there is also that a bpf prog is not needed). It should be a 
bpf prog that can work in a more generic way to process any BPF specific cmsg 
and can do other operations in the future using kfunc (e.g. route lookup or 
something). Saying yes/no to a particular local IP and port could be one of 
things that the bpf prog can do when processing the cmsg.

