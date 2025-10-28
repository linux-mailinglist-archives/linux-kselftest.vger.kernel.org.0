Return-Path: <linux-kselftest+bounces-44200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A12C16271
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 18:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDCD550056C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 17:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB9C34C9A3;
	Tue, 28 Oct 2025 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxDFJcpx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48A346A19;
	Tue, 28 Oct 2025 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672377; cv=none; b=tsckdXQDvfot5Arq/xOtbi7eObAi7j/CDeQbywvrXMYT3App7ctQwgxr5/8cm9ycJkGuXTD9tf1h0JRvwUlxzgBszYAdJCcgeVp0v3yKA2HUQefySFXoSVzfeiVuJYT9XvbnP+KS7zb6OCGWeNhA/bedpXmbjkAi2yW9sYCOVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672377; c=relaxed/simple;
	bh=TPax0slGP7PiPUxCVpNjABnEC3k7GlA/DHa3fwFl7gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXYhR+uGeQ9eMqg1XkzT71MGzZP8MP+S4EdkI1cvZjXFWN1yyJOBeedjthThCvsa6r5qtjuDzUEGz+QrjV2WmfFQj8VgBBrgDYvITk/e+9T/JUuGgB6VPglB+66LjPMyOtGdGKrHYmesOdpuiZnCqvYkj69v5WiQsgWbbAMo7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxDFJcpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC551C4CEE7;
	Tue, 28 Oct 2025 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761672376;
	bh=TPax0slGP7PiPUxCVpNjABnEC3k7GlA/DHa3fwFl7gU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KxDFJcpx/HWC2pENdRtR/MkUxhf0BIKD6ANVc3e/buzQecZkDC22XPHSOcgkdwkSP
	 QUrJu/X+hO7IhpkwIlxDAWzLMUjcnf2l0wT16ZWxxFt0pckVpn/ekYH71HQHE+nvsd
	 S9BA1WiQzIMRT7bH8WXJ2YACgI+bf1gUVMG1lPVXzHlC+6EwW9raDc4OzQ0Jq27A4t
	 sRWZ4OJm3AfJZ1yIarHC3M35dZR3w7B8NcNYnNwpqYcTKxk+Wzwl3JgZ4Vygwn1UwY
	 AsF9w/bXgyPAkS0d93u477ovQdNMyfzA9AK0I7Co82YitMpMVBzSUjVbk7nAt+FGs+
	 NxjIyoCa/ZXBA==
Message-ID: <bc5831bb-cfa3-4327-b129-30ca5d17b45e@kernel.org>
Date: Tue, 28 Oct 2025 18:26:05 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <319c419455b73deb312b53d99c30217f6b606208@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jiayuan,

Thank you for your reply!

On 24/10/2025 06:13, Jiayuan Chen wrote:
> 2025/10/23 22:10, "Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@kernel.org?to=%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E > 写到:
> 
> 
>>>  MPTCP creates subflows for data transmission between two endpoints.
>>>  However, BPF can use sockops to perform additional operations when TCP
>>>  completes the three-way handshake. The issue arose because we used sockmap
>>>  in sockops, which replaces sk->sk_prot and some handlers.
>>>
>> Do you know at what stage the sk->sk_prot is modified with sockmap? When
>> switching to TCP_ESTABLISHED?
>> Is it before or after having set "tcp_sk(sk)->is_mptcp = 0" (in
>> subflow_ulp_fallback(), coming from subflow_syn_recv_sock() I suppose)?
> 
> 
> Yes, there are two call points. One is after executing subflow_syn_recv_sock():
> tcp_init_transfer(sk, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, skb);
> 
> So at this point, is_mptcp = 0. The other call point is when userspace calls
> the BPF interface, passing in an fd while it's not a subflow but a parent sk
> with its own mptcp_prot we will also reject it.

OK, thank you for the explanations! I think your commit message in patch
1/3 should then explain the conditions to have mptcp_fallback_tcp_ops()
being called with a different sk_prot. In short: MPTCP listening socket,
TCP request without MPTCP, sk_prot reset to TCP (subflow_syn_recv_sock)
when SYN RECV, then reset by sockmap when ESTABLISHED, then accept part
and sk_prot is not the expected one.

> You can refer to my provided selftest, which covers these scenarios.
> 
>> If MPTCP is still being used (sk_is_tcp(sk) && sk_is_mptcp(sk)), I guess
>> sockmap should never touch the in-kernel TCP subflows: they will likely
>> only carry a part of the data. Instead, sockmap should act on the MPTCP
>> sockets, not the in-kernel TCP subflows.
> 
> Yes, I agree.
> 
> For full functionality, we need to retrieve the parent socket from MPTCP
> and integrate it with sockmap, rather than simply rejecting.

We should be careful when adding such exceptions. I will add more
details below.

> The current implementation rejects MPTCP because I previously attempted to
> add sockmap support for MPTCP, but it required implementing many interfaces
> and would take considerable time.
> 
> So for now, I'm proposing this as a fix to resolve the immediate issue.
> Subsequently, we can continue working on fully integrating MPTCP with sockmap.

It makes sense to start with the fix for stable, then the implementation
later. I think the implementation should not be that complex: it is just
that it has to be done at MPTCP level, not TCP. sockmap supports
different protocol, and it doesn't seem to be TCP specific, so that
should be feasible.

>> There is one particular case to take into consideration: an MPTCP
>> connection can fallback to "plain" TCP before being used by the
>> userspace. Typically, that's when an MPTCP listening socket receives a
>> "plain" TCP request (without MPTCP): a "plain" TCP socket will then be
>> created, and exposed to the userspace. In this case, sk_is_mptcp(sk)
>> will return false. I guess that's the case you are trying to handle,
>> right? (It might help BPF reviewers to mention that in the commit
>> message(s).)
> 
> Yes, this is primarily the case we're addressing. I will add this description
> to the commit message.

Thanks!

>> I would then say that sk->sk_prot->psock_update_sk_prot should not point
>> to tcp_bpf_update_proto() when MPTCP is being used (or this callback
>> should take the MPTCP case into account, but I guess no). In case of
>> fallback before the accept() stage, the socket can then be used as a
>> "plain" TCP one. I guess when tcp_bpf_update_proto() will be called,
>> sk_prot is pointing to tcp(v6)_prot, not the MPTCP subflow override one,
>> right?
> 
> Yes, when tcp_bpf_update_proto is called the sk_prot is pointing to tcp(v6)_prot.
> subflow_syn_recv_sock
>  mptcp_subflow_drop_ctx
>   subflow_ulp_fallback
>    mptcp_subflow_ops_undo_override -> reset sk_prot to original one

I see, it would be good to add that in the commit message as well.

> So [patch 2/3] aims to prevent psock_update_sk_prot from being executed on subflows.
> 
> Actually, replacing the subflow's callbacks is also incorrect, as you mentioned earlier,
> because subflows only carry part of the data. By checking for subflows early and skipping
> subsequent steps, we avoid incorrect logic.
> 
> Furthermore, there's another risk: if an IPv6 request comes in and we perform the replacement,
> MPTCP will roll it back to inet_stream_ops. I haven't delved too deeply into the potential
> impact, but I noticed that inet6_release has many V6-specific cleanup procedures not present
> in inet_release.

That's why we have the WARN_ON_ONCE(): this sk_prot was not expected, a
fix in the code is required if another value is accepted.

>>> Since subflows
>>>  also have their own specialized handlers, this creates a conflict and leads
>>>  to traffic failure. Therefore, we need to reject operations targeting
>>>  subflows.
>>>
>> Would it not work to set sk_prot->psock_update_sk_prot to NULL for the
>> v4 and v6 subflows (in mptcp_subflow_init()) for the moment while
>> sockmap is not supported with MPTCP? This might save you some checks in
>> sock_map.c, no?
> 
> This seems like a reliable alternative I hadn't considered initially.
> 
> However, adding the check on the BPF side serves another purpose: to explicitly
> warn users that sockmap and MPTCP are incompatible.
> 
> Since the latest Golang version enables MPTCP server by default, and if the client
> doesn't support MPTCP, it falls back to TCP logic. We want to print a clear message
> informing users who have upgraded to the latest Golang and are using sockmap.
> 
> Perhaps we could add a function like sk_is_mptcp_subflow() in the MPTCP side?
> The implementation would simply be sk_is_tcp(sk) && sk_is_mptcp(sk).
> 
> Implementing this check logic on the BPF side might become invalid if MPTCP internals
> change later; placing it in the MPTCP side might be a better choice.

I can understand that adding an error message can be helpful, but I
don't think we should add MPTCP specific checks in sockmap for the moment.

>>> This patchset simply prevents the combination of subflows and sockmap
>>>  without changing any functionality.
>>>
>> In your case, you have an MPTCP listening socket, but you receive a TCP
>> request, right? The "sockmap update" is done when switching to
>> TCP_ESTABLISHED, when !sk_is_mptcp(sk), but that's before
>> mptcp_stream_accept(). That's why sk->sk_prot has been modified, but it
>> is fine to look at sk_family, and return inet(6)_stream_ops, right?
> 
> I believe so. Since MPTCP is fundamentally based on TCP, using sk_family to
> determine which ops to fall back to should be sufficient.
> 
> However, strictly speaking, this [patch 1/3] might not even be necessary if we
> prevent the sk_prot replacement for subflows at the sockmap layer.
> 
>> A more important question: what will typically happen in your case if
>> you receive an MPTCP request and sockmap is then not supported? Will the
>> connection be rejected or stay in a strange state because the userspace
>> will not expect that? In these cases, would it not be better to disallow
>> sockmap usage while the MPTCP support is not available? The userspace
>> would then get an error from the beginning that the protocol is not
>> supported, and should then not create an MPTCP socket in this case for
>> the moment, no?
>>
>> I can understand that the switch from TCP to MPTCP was probably done
>> globally, and this transition should be as seamless as possible, but it
>> should not cause a regression with MPTCP requests. An alternative could
>> be to force a fallback to TCP when sockmap is used, even when an MPTCP
>> request is received, but not sure if it is practical to do, and might be
>> strange from the user point of view.
> 
> Actually, I understand this not as an MPTCP regression, but as a sockmap
> regression.
> 
> Let me explain how users typically use sockmap:
> 
> Users typically create multiple sockets on a host and program using BPF+sockmap
> to enable fast data redirection. This involves intercepting data sent or received
> by one socket and redirecting it to the send or receive queue of another socket.
> 
> This requires explicit user programming. The goal is that when multiple microservices
> on one host need to communicate, they can bypass most of the network stack and avoid
> data copies between user and kernel space.
> 
> However, when an MPTCP request occurs, this redirection flow fails.

This part bothers me a bit. Does it mean that when the userspace creates
a TCP listening socket (IPPROTO_TCP), MPTCP requests will be accepted,
but MPTCP will not be used ; but when an MPTCP socket is used instead,
MPTCP requests will be rejected?

If yes, it might be clearer not to allow sockmap on connections created
from MPTCP sockets. But when looking at sockmap and what's happening
when a TCP socket is created following a "plain TCP" request, we would
need specific MPTCP code to catch that in sockmap...

> Since the sockmap workflow typically occurs after the three-way handshake, rolling
> back at that point might be too late, and undoing the logic for MPTCP would be very
> complex.
> 
> Regardless, the reality is that MPTCP and sockmap are already conflicting, and this
> has been the case for some time. So I think our first step is to catch specific
> behavior on the BPF side and print a message
> "sockmap/sockhash: MPTCP sockets are not supported\n", informing users to either
> stop using sockmap or not use MPTCP.
> 
> As for the logic to check for subflows, I think implementing it in subflow.c would be
> beneficial, as this logic would likely be useful later if we want to
> support MPTCP + sockmap.

Probably yes.

> Furthermore, this commit also addresses the issue of incorrectly selecting
> inet_stream_ops due to the subflow prot replacement, as mentioned above.

(indeed, but this seems to happen only when sk_prot has been replaced by
sockmap :) )

>>> A complete integration of MPTCP and sockmap would require more effort, for
>>>  example, we would need to retrieve the parent socket from subflows in
>>>  sockmap and implement handlers like read_skb.
>>>  
>>>  If maintainers don't object, we can further improve this in subsequent
>>>  work.
>>>
>> That would be great to add MPTCP support in sockmap! As mentioned above,
>> this should be done on the MPTCP socket. I guess the TCP "in-kernel"
>> subflows should not be modified.
> 
> 
> I think we should first fix the issue by having sockmap reject operations on subflows.
> Subsequently, we can work on fully integrating sockmap with MPTCP as a feature
> (which would require implementing some handlers).

OK for me!

>>> [1] truncated warning:
>>>  [ 18.234652] ------------[ cut here ]------------
>>>  [ 18.234664] WARNING: CPU: 1 PID: 388 at net/mptcp/protocol.c:68 mptcp_stream_accept+0x34c/0x380
>>>  [ 18.234726] Modules linked in:
>>>  [ 18.234755] RIP: 0010:mptcp_stream_accept+0x34c/0x380
>>>  [ 18.234762] RSP: 0018:ffffc90000cf3cf8 EFLAGS: 00010202
> [...]
>>>
>> Please next time use the ./scripts/decode_stacktrace.sh if possible.
>> (and strip the timestamps if it is not giving useful info)
>> Just to be sure: is it the warning you get on top of net or net-next? Or
>> an older version? (Always useful to mention the base)
> 
> Thank you, Matthieu. I will pay attention to this.
> 
> 
>>>
>>> ---
>>>  v2: https://lore.kernel.org/bpf/20251020060503.325369-1-jiayuan.chen@linux.dev/T/#t
>>>  Some advice suggested by Jakub Sitnicki
>>>  
>>>  v1: https://lore.kernel.org/mptcp/a0a2b87119a06c5ffaa51427a0964a05534fe6f1@linux.dev/T/#t
>>>  Some advice from Matthieu Baerts.
>>>
>> (It usually helps reviewers to add more details in the notes/changelog
>> for the individual patch)
> 
> Thank you, Matthieu. I will provide more detailed descriptions in the future.

Thanks!

So for the v4, patch 2/3 would be replaced by one setting ...

  tcp_prot_override.psock_update_sk_prot = NULL;
  (...)
  tcpv6_prot_override.psock_update_sk_prot = NULL;

... in mptcp_subflow_init(). (+ more details for patch 1/3).

From there, we can discuss with other maintainers what to do with the
MPTCP listening socket + sockmap case. And in parallel, we can also
discuss MPTCP support with sockmap. WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

pw-bot: cr


