Return-Path: <linux-kselftest+bounces-45293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E24C4D1D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9560C4EE6E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 10:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5DD34EEED;
	Tue, 11 Nov 2025 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqea7ZSM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E0330B3E;
	Tue, 11 Nov 2025 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857328; cv=none; b=DuPzpecl8i4m6l5aguOm17riHWsdhCTt40BI8pZ4koCK7+Rb8JCxAUY1jiswYDLpYwnOuDzWTDbAiN95KfLEXTFaGEKkSxb2KD8g+L2/feWF+2X+fEs5aC4016UXR+1Cn5d+I5tJlmqTZJWtBrpWI+aRrbYrs+tVZ4ZLb9rS3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857328; c=relaxed/simple;
	bh=6klGeljGlw68LqBwaAYWoYFCW3C+WtLq3LWOJjf2a4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/QaOfDeTSQbcRKCn7zl+qt65lbGkGEG4ftHblVLMVoro5T8T6v3c8RkRUkJCcCVZ6rWJ049eVRt4uUZa76rxop2Lw2qhIAfJWAYRc0J5LjT5ZXB9KZRMjoYqmX5pKGIrwktmaZSyqwsTOhk7zHFLjNABTocWhxsJhmRfPXsu5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqea7ZSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9B8C4CEF7;
	Tue, 11 Nov 2025 10:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762857327;
	bh=6klGeljGlw68LqBwaAYWoYFCW3C+WtLq3LWOJjf2a4Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cqea7ZSMZa6ig3ryOSB46KU91Ta4nbJWfYP+VniuqlT89TOqxvaV6ELkrV7TSGZg3
	 Ru6GzTtp3kPxZTZ/j1EFDpesySr228Zm42Y6qh5KvWvJK/kj4h9WWQf7AwqXB0BVcu
	 LFq1r//OPnZWpoyGwin1U/SgdYO5x5uFCWYR0oDUbvIO3DzkGDdGuvy3MTWrgOFLfE
	 WdNibhCHo08qi7/Cf8k2vVqpYsp8q0SMp6vE5tp2QNSu7n/C6RSh6z3fvrgf+/2WWI
	 EzC32epFrF0nOiaFvvcolYuhamZjIzQcsWNgDUYYTHYr/6oPrDt5vTdUvzHHFoA+j7
	 A53j9uQNhlTGA==
Message-ID: <c826e72d-a845-4d39-aff4-ea262a62c6c7@kernel.org>
Date: Tue, 11 Nov 2025 11:35:13 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v5 2/3] net,mptcp: fix proto fallback detection with
 BPF
Content-Language: en-GB, fr-BE
To: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Peter Krystad <peter.krystad@linux.intel.com>,
 Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251111060307.194196-1-jiayuan.chen@linux.dev>
 <20251111060307.194196-3-jiayuan.chen@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20251111060307.194196-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jiayuan,

On 11/11/2025 07:02, Jiayuan Chen wrote:
> The sockmap feature allows bpf syscall from userspace, or based
> on bpf sockops, replacing the sk_prot of sockets during protocol stack
> processing with sockmap's custom read/write interfaces.
> '''
> tcp_rcv_state_process()
>   syn_recv_sock()/subflow_syn_recv_sock()
>     tcp_init_transfer(BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
>       bpf_skops_established       <== sockops
>         bpf_sock_map_update(sk)   <== call bpf helper
>           tcp_bpf_update_proto()  <== update sk_prot
> '''
> 
> When the server has MPTCP enabled but the client sends a TCP SYN
> without MPTCP, subflow_syn_recv_sock() performs a fallback on the
> subflow, replacing the subflow sk's sk_prot with the native sk_prot.
> '''
> subflow_syn_recv_sock()
>   subflow_ulp_fallback()
>     subflow_drop_ctx()
>       mptcp_subflow_ops_undo_override()
> '''
> 
> Then, this subflow can be normally used by sockmap, which replaces the
> native sk_prot with sockmap's custom sk_prot. The issue occurs when the
> user executes accept::mptcp_stream_accept::mptcp_fallback_tcp_ops().
> Here, it uses sk->sk_prot to compare with the native sk_prot, but this
> is incorrect when sockmap is used, as we may incorrectly set
> sk->sk_socket->ops.
> 
> This fix uses the more generic sk_family for the comparison instead.
> 
> Additionally, this also prevents a WARNING from occurring:
> 
> result from ./scripts/decode_stacktrace.sh:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 337 at net/mptcp/protocol.c:68 mptcp_stream_accept \
> (net/mptcp/protocol.c:4005)
> Modules linked in:
> ...
> 
> PKRU: 55555554
> Call Trace:
> <TASK>
> do_accept (net/socket.c:1989)
> __sys_accept4 (net/socket.c:2028 net/socket.c:2057)
> __x64_sys_accept (net/socket.c:2067)
> x64_sys_call (arch/x86/entry/syscall_64.c:41)
> do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> RIP: 0033:0x7f87ac92b83d
> 
> ---[ end trace 0000000000000000 ]---
> 
> Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing connections")

The previous Fixes tag you used in the previous versions was correct for
this second patch:

Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")

But well, in terms of backports, that will be the same. So I guess we
don't need a new version just for that.

Also, I guess you missed my comments from the two previous versions:

> please remove the 'net,' prefix from the title. And maybe good
> to mention 'sockmap', e.g.
> 
>   mptcp: fix proto fallback detection with sockmap

But same here, fine like that.

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

For next time: the Signed-off-by of the sender should be at the end. So
here, your SoB should go to the end, after the already sent RvB tags.

But again, I don't think we need a v6 for that, except if net
maintainers prefer to.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


