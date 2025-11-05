Return-Path: <linux-kselftest+bounces-44811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94C2C361E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 15:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17ED1188F901
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7B532ED24;
	Wed,  5 Nov 2025 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toIxm5f5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4132E140;
	Wed,  5 Nov 2025 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353636; cv=none; b=MWm/ZSNewDddXI0RTOcOcxdov6QmHy5a9nTkZOyiIwtzx33wuuRFGopaGthJoNMLYtHLsQlpys2C/hVVALufW/u1qs4UE7/ZEef7io1G/XySII8z+LAS8NR8t5iikcB++StolAGTp/jD3R7clXLiZlpEhapunoe6TqL4NQj5u/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353636; c=relaxed/simple;
	bh=pMttGpkkfeoluMHfyTi4oQM3hPzIQS+KBocEW/rgPTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ET9voH+ahgaye+94x0sEip6vNb6jtvhU5xw7qs/DhBPX6ix7EiPF5MOgESN69VXVYIsR8ZHiUy1NunIETbaPByyNY3KFF6QiGHm2ex+QwqHuxTSVBBdtc3+EMLrXkycLy5/ISxGOsaqzyIEZ4f0Y3DXQX6GHq9EGUOPslaPckys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toIxm5f5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAE3C4CEF5;
	Wed,  5 Nov 2025 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762353635;
	bh=pMttGpkkfeoluMHfyTi4oQM3hPzIQS+KBocEW/rgPTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=toIxm5f5vWaI0lvkyLXJ1YRYRAcfb85VeTyNIZp0BnDBQwLD46amy5sBV0p+lJfWP
	 wi4DCNudq051kfFBe0LI/wANATzdvQlVfr5AASBV7P8ypS8C1Jd/rxinhu0vO00xro
	 cd+efV5H0xzuuMYdCwMTnE/Jklc4wJMA6Gb0jHS0cgvqcQxJW64884k2H4tjo5fzRv
	 niT4NcbxJIyrOOYxXBNk94CXFzYd24i5cTZH+NVntjiWDem1UnA4k68gd0qJDS7Ibz
	 roOOcPvAp+bQZJZikssIkATNtHJi6P7l4C7EwnpQg0sbfCZ1SYX6MO7As/IMPClKXV
	 DgD3eCJ8kHmWg==
Message-ID: <665825df-b995-45ee-9e0c-2b40cc4897ee@kernel.org>
Date: Wed, 5 Nov 2025 15:40:24 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v4 3/3] selftests/bpf: Add mptcp test with sockmap
Content-Language: en-GB, fr-BE
To: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
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
 <20251105113625.148900-4-jiayuan.chen@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20251105113625.148900-4-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jiayuan,

Thank you for this new test!

I'm not very familiar with the BPF selftests: it would be nice if
someone else can have a quick look.

On 05/11/2025 12:36, Jiayuan Chen wrote:
> Add test cases to verify that when MPTCP falls back to plain TCP sockets,
> they can properly work with sockmap.
> 
> Additionally, add test cases to ensure that sockmap correctly rejects
> MPTCP sockets as expected.
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 150 ++++++++++++++++++
>  .../selftests/bpf/progs/mptcp_sockmap.c       |  43 +++++
>  2 files changed, 193 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sockmap.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index f8eb7f9d4fd2..56c556f603cc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -6,11 +6,14 @@
>  #include <netinet/in.h>
>  #include <test_progs.h>
>  #include <unistd.h>
> +#include <error.h>

Do you use this new include?

>  #include "cgroup_helpers.h"
>  #include "network_helpers.h"
> +#include "socket_helpers.h"
>  #include "mptcp_sock.skel.h"
>  #include "mptcpify.skel.h"
>  #include "mptcp_subflow.skel.h"
> +#include "mptcp_sockmap.skel.h"
>  
>  #define NS_TEST "mptcp_ns"
>  #define ADDR_1	"10.0.1.1"
> @@ -436,6 +439,151 @@ static void test_subflow(void)
>  	close(cgroup_fd);
>  }
>  
> +/* Test sockmap on MPTCP server handling non-mp-capable clients. */
> +static void test_sockmap_with_mptcp_fallback(struct mptcp_sockmap *skel)
> +{
> +	int listen_fd = -1, client_fd1 = -1, client_fd2 = -1;
> +	int server_fd1 = -1, server_fd2 = -1, sent, recvd;
> +	char snd[9] = "123456789";
> +	char rcv[10];
> +
> +	/* start server with MPTCP enabled */
> +	listen_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
> +	if (!ASSERT_OK_FD(listen_fd, "redirect:start_mptcp_server"))
> +		return;
> +
> +	skel->bss->trace_port = ntohs(get_socket_local_port(listen_fd));
> +	skel->bss->sk_index = 0;
> +	/* create client without MPTCP enabled */
> +	client_fd1 = connect_to_fd_opts(listen_fd, NULL);
> +	if (!ASSERT_OK_FD(client_fd1, "redirect:connect_to_fd"))
> +		goto end;
> +
> +	server_fd1 = xaccept_nonblock(listen_fd, NULL, NULL);
> +	skel->bss->sk_index = 1;
> +	client_fd2 = connect_to_fd_opts(listen_fd, NULL);
> +	if (!ASSERT_OK_FD(client_fd2, "redirect:connect_to_fd"))
> +		goto end;
> +
> +	server_fd2 = xaccept_nonblock(listen_fd, NULL, NULL);
> +	/* test normal redirect behavior: data sent by client_fd1 can be
> +	 * received by client_fd2
> +	 */
> +	skel->bss->redirect_idx = 1;
> +	sent = xsend(client_fd1, snd, sizeof(snd), 0);
> +	if (!ASSERT_EQ(sent, sizeof(snd), "redirect:xsend(client_fd1)"))
> +		goto end;
> +
> +	/* try to recv more bytes to avoid truncation check */
> +	recvd = recv_timeout(client_fd2, rcv, sizeof(rcv), MSG_DONTWAIT, 2);
> +	if (!ASSERT_EQ(recvd, sizeof(snd), "redirect:recv(client_fd2)"))
> +		goto end;
> +
> +end:
> +	if (client_fd1 > 1)
> +		close(client_fd1);
> +	if (client_fd2 > 1)
> +		close(client_fd2);
> +	if (server_fd1 > 0)
> +		close(server_fd1);
> +	if (server_fd2 > 0)
> +		close(server_fd2);

Why do you check if it is above 0 or 1? Should you not always check if
it is >= 0 for each fd?


> +	close(listen_fd);
> +}
> +
> +/* Test sockmap rejection of MPTCP sockets - both server and client sides. */
> +static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
> +{
> +	int client_fd1 = -1, client_fd2 = -1;
> +	int listen_fd = -1, server_fd = -1;
> +	int err, zero = 0;
> +
> +	/* start server with MPTCP enabled */
> +	listen_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
> +	if (!ASSERT_OK_FD(listen_fd, "start_mptcp_server"))

In test_sockmap_with_mptcp_fallback(), you prefixed each error with
'redirect:'. Should you also have a different prefix here? 'sockmap-fb:'
vs 'sockmap-mptcp:' eventually?

> +		return;
> +
> +	skel->bss->trace_port = ntohs(get_socket_local_port(listen_fd));
> +	skel->bss->sk_index = 0;
> +	/* create client with MPTCP enabled */
> +	client_fd1 = connect_to_fd(listen_fd, 0);
> +	if (!ASSERT_OK_FD(client_fd1, "connect_to_fd client_fd1"))
> +		goto end;
> +
> +	/* bpf_sock_map_update() called from sockops should reject MPTCP sk */
> +	if (!ASSERT_EQ(skel->bss->helper_ret, -EOPNOTSUPP, "should reject"))
> +		goto end;

So here, the client is connected, but sockmap doesn't operate on it,
right? So most likely, the connection is stalled until the userspace
realises that and takes an action?

> +	/* set trace_port = -1 to stop sockops */
> +	skel->bss->trace_port = -1;

What do you want to demonstrate from here? That without the sockmap
injection, there are no new entries added? Is it worth checking that here?

> +	client_fd2 = connect_to_fd(listen_fd, 0);
> +	if (!ASSERT_OK_FD(client_fd2, "connect_to_fd client_fd2"))
> +		goto end;
> +
> +	server_fd = xaccept_nonblock(listen_fd, NULL, NULL);
> +	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
> +				  &zero, &server_fd, BPF_NOEXIST);
> +	if (!ASSERT_EQ(err, -EOPNOTSUPP, "server should be disallowed"))
> +		goto end;
> +
> +	/* MPTCP client should also be disallowed */
> +	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
> +				  &zero, &client_fd1, BPF_NOEXIST);
> +	if (!ASSERT_EQ(err, -EOPNOTSUPP, "client should be disallowed"))
> +		goto end;
> +end:
> +	if (client_fd1 > 0)
> +		close(client_fd1);
> +	if (client_fd2 > 0)
> +		close(client_fd2);
> +	if (server_fd > 0)
> +		close(server_fd);

Same here: should it not be "*fd >= 0"?

> +	close(listen_fd);
> +}

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


