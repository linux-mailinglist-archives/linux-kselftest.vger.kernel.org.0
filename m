Return-Path: <linux-kselftest+bounces-43881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F1FC01B1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 16:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DED25009EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 14:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F108831D758;
	Thu, 23 Oct 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGiDD3Jd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3F2314A73;
	Thu, 23 Oct 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228612; cv=none; b=ZjlVHVqiwSjbI8s6PxttJuJMwpJpfP5ud7G5SbYVcG8BckVxMNwH4Fm42QcAv0FPGM2OI3hKVLXr/jWSEE5xJbKnpSp6QjuXa1JRPznIWtyXGzmSRr/3pXuwTLqy9dGS1YSZHKLXS1gCmXhI5eb+7MPNDf4EwJwHUHoVv2UDFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228612; c=relaxed/simple;
	bh=+XL8RrDBOy9ArRyemNwKo8d/iWH9W5DEDpZfSsRIndU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smdlAcFABbLK8Ux0WYqI6bHz1EBZZkWGRNzvvXCv8JEZkNMoPnXK5dr31PK/RRCZhlOLArScw2vA1YOT+HOs5dL3SeQNa+fmPdBz7grzY/999Qeei+NpsbgFqiCxWVkB3Bj/vpq5JayJYSWmnQlUZaotplYaGEy1chw4msHUdG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGiDD3Jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79326C4CEF7;
	Thu, 23 Oct 2025 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761228612;
	bh=+XL8RrDBOy9ArRyemNwKo8d/iWH9W5DEDpZfSsRIndU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sGiDD3Jdhj93sq0zYZW/7j+rruafWfp8AnRgYMht4QGlDzB84Ns8Wv+DSC0e+L5Um
	 M/zWV59Vkslr0w3sUo2eEGzDywuV+pdvSGXggU6DWAOpRw9cjmFHShzQZzwRh6w+Sa
	 uimEZ9i5gG8qytwD1g9WvhZSjPtqRVkpGZ6JflFuDoN14trU1PIvSeaoU6F6OGmJ74
	 6mXTpXRjl0XrippNcE3vO1lZnMJ6assg2GIKs86WJifsoEIjuGqT0tCb1pYcBd+bPc
	 WSwq06mU2fVuOndqURbs7OT/sQqqALDDeeYaqLXxjXKF3sSAHhtMOYocpJjDBOEmyf
	 ZdYwsEFcaq5QQ==
Message-ID: <14b565a1-0c2a-420d-ab2a-dc8a46dbf33c@kernel.org>
Date: Thu, 23 Oct 2025 16:10:01 +0200
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
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20251023125450.105859-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jiayuan,

Thank you for the v3. Sorry, I didn't have the opportunity to react on
the v2.

On 23/10/2025 14:54, Jiayuan Chen wrote:
> Overall, we encountered a warning [1] that can be triggered by running the
> selftest I provided.
> 
> MPTCP creates subflows for data transmission between two endpoints.
> However, BPF can use sockops to perform additional operations when TCP
> completes the three-way handshake. The issue arose because we used sockmap
> in sockops, which replaces sk->sk_prot and some handlers.

Do you know at what stage the sk->sk_prot is modified with sockmap? When
switching to TCP_ESTABLISHED?

Is it before or after having set "tcp_sk(sk)->is_mptcp = 0" (in
subflow_ulp_fallback(), coming from subflow_syn_recv_sock() I suppose)?

If MPTCP is still being used (sk_is_tcp(sk) && sk_is_mptcp(sk)), I guess
sockmap should never touch the in-kernel TCP subflows: they will likely
only carry a part of the data. Instead, sockmap should act on the MPTCP
sockets, not the in-kernel TCP subflows.

There is one particular case to take into consideration: an MPTCP
connection can fallback to "plain" TCP before being used by the
userspace. Typically, that's when an MPTCP listening socket receives a
"plain" TCP request (without MPTCP): a "plain" TCP socket will then be
created, and exposed to the userspace. In this case, sk_is_mptcp(sk)
will return false. I guess that's the case you are trying to handle,
right? (It might help BPF reviewers to mention that in the commit
message(s).)

I would then say that sk->sk_prot->psock_update_sk_prot should not point
to tcp_bpf_update_proto() when MPTCP is being used (or this callback
should take the MPTCP case into account, but I guess no). In case of
fallback before the accept() stage, the socket can then be used as a
"plain" TCP one. I guess when tcp_bpf_update_proto() will be called,
sk_prot is pointing to tcp(v6)_prot, not the MPTCP subflow override one,
right?

> Since subflows
> also have their own specialized handlers, this creates a conflict and leads
> to traffic failure. Therefore, we need to reject operations targeting
> subflows.

Would it not work to set sk_prot->psock_update_sk_prot to NULL for the
v4 and v6 subflows (in mptcp_subflow_init()) for the moment while
sockmap is not supported with MPTCP? This might save you some checks in
sock_map.c, no?

> This patchset simply prevents the combination of subflows and sockmap
> without changing any functionality.

In your case, you have an MPTCP listening socket, but you receive a TCP
request, right? The "sockmap update" is done when switching to
TCP_ESTABLISHED, when !sk_is_mptcp(sk), but that's before
mptcp_stream_accept(). That's why sk->sk_prot has been modified, but it
is fine to look at sk_family, and return inet(6)_stream_ops, right?

A more important question: what will typically happen in your case if
you receive an MPTCP request and sockmap is then not supported? Will the
connection be rejected or stay in a strange state because the userspace
will not expect that? In these cases, would it not be better to disallow
sockmap usage while the MPTCP support is not available? The userspace
would then get an error from the beginning that the protocol is not
supported, and should then not create an MPTCP socket in this case for
the moment, no?

I can understand that the switch from TCP to MPTCP was probably done
globally, and this transition should be as seamless as possible, but it
should not cause a regression with MPTCP requests. An alternative could
be to force a fallback to TCP when sockmap is used, even when an MPTCP
request is received, but not sure if it is practical to do, and might be
strange from the user point of view.

> A complete integration of MPTCP and sockmap would require more effort, for
> example, we would need to retrieve the parent socket from subflows in
> sockmap and implement handlers like read_skb.
> 
> If maintainers don't object, we can further improve this in subsequent
> work.

That would be great to add MPTCP support in sockmap! As mentioned above,
this should be done on the MPTCP socket. I guess the TCP "in-kernel"
subflows should not be modified.

> [1] truncated warning:
> [   18.234652] ------------[ cut here ]------------
> [   18.234664] WARNING: CPU: 1 PID: 388 at net/mptcp/protocol.c:68 mptcp_stream_accept+0x34c/0x380
> [   18.234726] Modules linked in:
> [   18.234755] RIP: 0010:mptcp_stream_accept+0x34c/0x380
> [   18.234762] RSP: 0018:ffffc90000cf3cf8 EFLAGS: 00010202
> [   18.234800] PKRU: 55555554
> [   18.234806] Call Trace:
> [   18.234810]  <TASK>
> [   18.234837]  do_accept+0xeb/0x190
> [   18.234861]  ? __x64_sys_pselect6+0x61/0x80
> [   18.234898]  ? _raw_spin_unlock+0x12/0x30
> [   18.234915]  ? alloc_fd+0x11e/0x190
> [   18.234925]  __sys_accept4+0x8c/0x100
> [   18.234930]  __x64_sys_accept+0x1f/0x30
> [   18.234933]  x64_sys_call+0x202f/0x20f0
> [   18.234966]  do_syscall_64+0x72/0x9a0
> [   18.234979]  ? switch_fpu_return+0x60/0xf0
> [   18.234993]  ? irqentry_exit_to_user_mode+0xdb/0x1e0
> [   18.235002]  ? irqentry_exit+0x3f/0x50
> [   18.235005]  ? clear_bhb_loop+0x50/0xa0
> [   18.235022]  ? clear_bhb_loop+0x50/0xa0
> [   18.235025]  ? clear_bhb_loop+0x50/0xa0
> [   18.235028]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   18.235066]  </TASK>
> [   18.235109] ---[ end trace 0000000000000000 ]---

Please next time use the ./scripts/decode_stacktrace.sh if possible.
(and strip the timestamps if it is not giving useful info)

Just to be sure: is it the warning you get on top of net or net-next? Or
an older version? (Always useful to mention the base)

> ---
> v2: https://lore.kernel.org/bpf/20251020060503.325369-1-jiayuan.chen@linux.dev/T/#t
>     Some advice suggested by Jakub Sitnicki
> 
> v1: https://lore.kernel.org/mptcp/a0a2b87119a06c5ffaa51427a0964a05534fe6f1@linux.dev/T/#t
>     Some advice from Matthieu Baerts.

(It usually helps reviewers to add more details in the notes/changelog
for the individual patch)

> Jiayuan Chen (3):
>   net,mptcp: fix proto fallback detection with BPF sockmap

(detail: you can use the "mptcp:" prefix, no need to add "net,")

>   bpf,sockmap: disallow MPTCP sockets from sockmap
>   selftests/bpf: Add mptcp test with sockmap
> 
>  net/core/sock_map.c                           |  27 ++++
>  net/mptcp/protocol.c                          |   9 +-
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 150 ++++++++++++++++++
>  .../selftests/bpf/progs/mptcp_sockmap.c       |  43 +++++
>  4 files changed, 227 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sockmap.c
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


