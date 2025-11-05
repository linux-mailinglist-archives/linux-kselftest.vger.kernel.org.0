Return-Path: <linux-kselftest+bounces-44810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4026CC361CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 15:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B90F534ECF0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD21331A44;
	Wed,  5 Nov 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1+/CXAN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB6F330D5D;
	Wed,  5 Nov 2025 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353616; cv=none; b=tOCyDOmXkbbHsTG7uf9LkdLtJfTlpAHadqMZoUEqkL0B407/AtPaBwEMNdEIITPezmK2sacUJFGE/L7H3CzK9/7petEVn3wQ83gPKmhE/ENEUhgfzC9iWyPPSAMRImu3KgLIKWR6XRFj5IAudOJ0s3IBCm4X225tjWshsdqAyfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353616; c=relaxed/simple;
	bh=LxC6JZ6IAYufFfV+Ica6Pr8L7xM0hnP5X9lUGFFM+nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U61v3ofmxxVuZs9kRCdZDrt0QchErEO2lXIpMaJzXPbtuz2PvI9IsVXtN7XKnYIrnM06EdrzLAzJPXUFvqqRmN4WH+Wg8xOmtY92HDxSkhAH/79sRbjZJyTb73jjeaZKXoZyxoepo/oakzrBZK0AcSXN34xs32BJ8FxkKWy9T0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1+/CXAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C13C4CEF5;
	Wed,  5 Nov 2025 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762353615;
	bh=LxC6JZ6IAYufFfV+Ica6Pr8L7xM0hnP5X9lUGFFM+nA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B1+/CXAN+vz6Q7YS8cfEmCja3mv5g4DVUw07fdp2vNVG6yIpZ6QWRJR2VW/Xfhznp
	 SZfpgIluWNKNKZgr6XZ2oGmyaKJ/MdqB+C+IAcLEUK9G73rdGnrHghDVdxrcDk5Ccl
	 pZjauUN9ozGCQBSQuidTYDv6VuD9jo1Ppf3UpqDrsWjtMDStIOSAn8n1VsNA22DfkA
	 LZvQ+RO3wlWqSTTZ0U/UJsxbSQyekmHhteZbIaxHvCKYT9F4DGb1ShgWKPejOLh4+r
	 okDXuOijZ0jjG4BI3tOtvRKuWe0NatBKfrr9BM5JDelQHmwoXmli7vB3umXUYp2EqE
	 sLyL84TjAc/ag==
Message-ID: <7d12a5fb-f923-4176-901a-8dc967eda52e@kernel.org>
Date: Wed, 5 Nov 2025 15:40:03 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v4 2/3] net,mptcp: fix proto fallback detection with
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
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251105113625.148900-1-jiayuan.chen@linux.dev>
 <20251105113625.148900-3-jiayuan.chen@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20251105113625.148900-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jiayuan,

On 05/11/2025 12:36, Jiayuan Chen wrote:

If you need to send a v5, please remove the 'net,' prefix from the
title. And maybe good to mention 'sockmap', e.g.

  mptcp: fix proto fallback detection with sockmap

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
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 388 at net/mptcp/protocol.c:68 \
> mptcp_stream_accept+0x34c/0x380
> Modules linked in:
> RIP: 0010:mptcp_stream_accept+0x34c/0x380
> RSP: 0018:ffffc90000cf3cf8 EFLAGS: 00010202
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  do_accept+0xeb/0x190
>  ? __x64_sys_pselect6+0x61/0x80
>  ? _raw_spin_unlock+0x12/0x30
>  ? alloc_fd+0x11e/0x190
>  __sys_accept4+0x8c/0x100
>  __x64_sys_accept+0x1f/0x30
>  x64_sys_call+0x202f/0x20f0
>  do_syscall_64+0x72/0x9a0
>  ? switch_fpu_return+0x60/0xf0
>  ? irqentry_exit_to_user_mode+0xdb/0x1e0
>  ? irqentry_exit+0x3f/0x50
>  ? clear_bhb_loop+0x50/0xa0
>  ? clear_bhb_loop+0x50/0xa0
>  ? clear_bhb_loop+0x50/0xa0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> 
> result from ./scripts/decode_stacktrace.sh:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 337 at net/mptcp/protocol.c:68 mptcp_stream_accept \
> (net-next/net/mptcp/protocol.c:4005)
> Modules linked in:
> ...
> 
> PKRU: 55555554
> Call Trace:
> <TASK>
> do_accept (net-next/net/socket.c:1989)
> __sys_accept4 (net-next/net/socket.c:2028 net-next/net/socket.c:2057)
> __x64_sys_accept (net-next/net/socket.c:2067)
> x64_sys_call (net-next/arch/x86/entry/syscall_64.c:41)
> do_syscall_64 (net-next/arch/x86/entry/syscall_64.c:63 \
> net-next/arch/x86/entry/syscall_64.c:94)
> entry_SYSCALL_64_after_hwframe (net-next/arch/x86/entry/entry_64.S:130)
> RIP: 0033:0x7f87ac92b83d
> 
> ---[ end trace 0000000000000000 ]---

If you need to send a v5, please remove the non-decoded stacktrace, only
the decoded one is interesting. You can also remove the 'net-next/'
prefix in the paths. So only to keep 'net/mptcp/protocol.c:4005' for
example.

> 
> Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  net/mptcp/protocol.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4cd5df01446e..b5e5e130b158 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -61,11 +61,13 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
>  
>  static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
>  {
> +	unsigned short family = READ_ONCE(sk->sk_family);
> +
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -	if (sk->sk_prot == &tcpv6_prot)
> +	if (family == AF_INET6)
>  		return &inet6_stream_ops;
>  #endif
> -	WARN_ON_ONCE(sk->sk_prot != &tcp_prot);
> +	WARN_ON_ONCE(family != AF_INET);

I wonder if it would be interesting to return NULL if the family is not
AF_INET{,6}. But I guess this will cause a crash quickly after, no?

If yes, probably better to continue returning &inet_stream_ops here.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

>  	return &inet_stream_ops;
>  }
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


