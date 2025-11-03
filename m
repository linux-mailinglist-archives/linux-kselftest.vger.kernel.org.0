Return-Path: <linux-kselftest+bounces-44653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A58ABC2CF15
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 16:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C6714EDB72
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142933148AF;
	Mon,  3 Nov 2025 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoDaWuqj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A8C304969;
	Mon,  3 Nov 2025 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185210; cv=none; b=RyMCt4XGH7gY+vmvb5JXtlBj3C8n6SikIJMQnv5yLVBB2A8xz2x94y5MpPLmZYdyKjdci3529hmQsb8QN9RQuKra7OEy9OcQMGeFeO4AWTXXkdJsMR9EyMsK74T+ZuLZvt+ugf1ga1RYDjlypDt1qezuK3mB1aFakwRP3S4aiLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185210; c=relaxed/simple;
	bh=zlD987IYcgv0Lcs/dP07a3fW5+8vkcfzEITDz9joQpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9miuUIma+U8GUeYjLKq9+gS3QRKFpCFm40KWRuap5Qi3mwzsY0r20rkA+1pkrDJOprBpu241HdVuTUIEsM/My9DwO+Vq8G/0C6EonGmyLmOMtdMk5bud6XAdM5iD6rVghzA6+BhnykKCaOJBtO3gr236vsCPULaLOmoopaQDOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoDaWuqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8436DC4CEE7;
	Mon,  3 Nov 2025 15:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762185209;
	bh=zlD987IYcgv0Lcs/dP07a3fW5+8vkcfzEITDz9joQpc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YoDaWuqjSCLvmDCn+FWGs6npsxuTUyH4xdREcv27YJEPaSCucdcntn3hrejxFpaZP
	 SX9LJeCxDB8Xa46q93MGSLZ0Y3AI8BXFS/Xm5b2ZoMEGfe+bsz7T2nwU0nSjq7o0dS
	 snP23C15CTTMJC2cHsHTiAI3UV52OCK+Ba9Kvjip8EEbMDTHHNZmbJYWlKgxU8L8RV
	 qXY7uTV37A0qKrOXI0Vlw1i6s9PcjWDchiGhd911vmR9NbVJffgETkzggpaZkpQu3W
	 G+HIslil2WzmvbyfTUsflNNlXUPGn6C2ggAybWRLaFemFbXJ9L3MwXJyUOmLpe5N50
	 dza56b75pm/Ag==
Message-ID: <99bcc333-c451-4409-ae23-1ca3b38950fa@kernel.org>
Date: Mon, 3 Nov 2025 16:53:18 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v3 0/3] mptcp: Fix conflicts between MPTCP and sockmap
Content-Language: en-GB, fr-BE
To: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <14b565a1-0c2a-420d-ab2a-dc8a46dbf33c@kernel.org>
 <319c419455b73deb312b53d99c30217f6b606208@linux.dev>
 <bc5831bb-cfa3-4327-b129-30ca5d17b45e@kernel.org>
 <55049e76c1e86825ff963c381ef01e38cfc08b10@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <55049e76c1e86825ff963c381ef01e38cfc08b10@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jiayuan,

On 03/11/2025 13:34, Jiayuan Chen wrote:
> October 29, 2025 at 1:26 AM, "Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@kernel.org?to=%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E > wrote:
>> On 24/10/2025 06:13, Jiayuan Chen wrote:

(...)

>>> The current implementation rejects MPTCP because I previously attempted to
>>>  add sockmap support for MPTCP, but it required implementing many interfaces
>>>  and would take considerable time.
>>>  
>>>  So for now, I'm proposing this as a fix to resolve the immediate issue.
>>>  Subsequently, we can continue working on fully integrating MPTCP with sockmap.
>>>
>> It makes sense to start with the fix for stable, then the implementation
>> later. I think the implementation should not be that complex: it is just
>> that it has to be done at MPTCP level, not TCP. sockmap supports
>> different protocol, and it doesn't seem to be TCP specific, so that
>> should be feasible.
> 
> I agree with that. From a userspace perspective, we can't really manipulate subflow
> TCP directly, and I also think it's correct to handle this at the MPTCP layer.
> 
> But I didn't quite get your point about "it has to be done at MPTCP level." Currently,
> BPF provides 'sockops' capability, which invokes BPF programs in the protocol stack.
> The input parameter sk for the BPF program is actually a TCP sk (subflow).
> 
> Many helper functions (like sockmap) have no choice but to care about whether it's MPTCP
> or not.

I see. Maybe new MPTCP equivalent hooks will be needed then?

(...)

>>>> A more important question: what will typically happen in your case if
>>>>  you receive an MPTCP request and sockmap is then not supported? Will the
>>>>  connection be rejected or stay in a strange state because the userspace
>>>>  will not expect that? In these cases, would it not be better to disallow
>>>>  sockmap usage while the MPTCP support is not available? The userspace
>>>>  would then get an error from the beginning that the protocol is not
>>>>  supported, and should then not create an MPTCP socket in this case for
>>>>  the moment, no?
>>>>
>>>>  I can understand that the switch from TCP to MPTCP was probably done
>>>>  globally, and this transition should be as seamless as possible, but it
>>>>  should not cause a regression with MPTCP requests. An alternative could
>>>>  be to force a fallback to TCP when sockmap is used, even when an MPTCP
>>>>  request is received, but not sure if it is practical to do, and might be
>>>>  strange from the user point of view.
>>>>
>>>  
>>>  Actually, I understand this not as an MPTCP regression, but as a sockmap
>>>  regression.
>>>  
>>>  Let me explain how users typically use sockmap:
>>>  
>>>  Users typically create multiple sockets on a host and program using BPF+sockmap
>>>  to enable fast data redirection. This involves intercepting data sent or received
>>>  by one socket and redirecting it to the send or receive queue of another socket.
>>>  
>>>  This requires explicit user programming. The goal is that when multiple microservices
>>>  on one host need to communicate, they can bypass most of the network stack and avoid
>>>  data copies between user and kernel space.
>>>  
>>>  However, when an MPTCP request occurs, this redirection flow fails.
>>>
>> This part bothers me a bit. Does it mean that when the userspace creates
>> a TCP listening socket (IPPROTO_TCP), MPTCP requests will be accepted,
>> but MPTCP will not be used ; but when an MPTCP socket is used instead,
>> MPTCP requests will be rejected?
> 
> "when the userspace creates a TCP listening socket (IPPROTO_TCP), MPTCP requests will be accepted,
> but MPTCP will not be used"
> --- Yes, that's essentially the logic behind MPTCP fallback, right? In this case, it should work
> fine with sockmap as well. That's exactly what this patch aims to achieve.

That's an MPTCP fallback to TCP for the client side here: the client
requests to use MPTCP, but the server doesn't support it. In this case,
MPTCP options will be ignored, and a "plain" TCP SYN+ACK will be sent
back to the client. In this case, the server using sockmap doesn't
handle MPTCP, because it created an IPPROTO_TCP.

In other words, the situation you had before GO 1.24, right?

> "but when an MPTCP socket is used instead, MPTCP requests will be rejected?"
> --- Exactly. Currently, because sockmap operates directly on the subflow sk, it breaks the MPTCP
> connection. The purpose of this patch is to explicitly return an error when users try to replace
> certain handlers of the subflow sk.

I don't think a message at that point is that useful. Ideally, the
userspace should get an error or a notice when setting sockmap up. But I
understand sockmap are not really attached to listening sockets, and it
doesn't seem possible to block sockmap at setup time because it is going
to be used with "accept()ed" connection created from an MPTCP listening
socket.

So I guess we will still need patch 1/3 (with a better commit message),
and patch 2/3 should be restricted to remove psock_update_sk_prot for
MPTCP subflows.

> This way, users at least get a clear error message instead of just experiencing a mysterious connection
> failure.
> 
>> If yes, it might be clearer not to allow sockmap on connections created
>> from MPTCP sockets. But when looking at sockmap and what's happening
>> when a TCP socket is created following a "plain TCP" request, we would
>> need specific MPTCP code to catch that in sockmap...
> 
> I know what you're concerned about, and I also don't want to add any MPTCP-specific checks on the
> sockmap or BPF side :).
> 
> I will try to set psock_update_sk_prot to NULL first.

Thanks!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


