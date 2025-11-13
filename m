Return-Path: <linux-kselftest+bounces-45590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86426C5A3FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 22:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E163A2E39
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 21:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F352313E29;
	Thu, 13 Nov 2025 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fgFcjYQn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEB82D8783
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763070533; cv=none; b=Q2IS7o1+ZE2tCpc+wAdNOQN+aiLDOpkdDsx0GQ/VZCFD7qtB7OaoBSg0fIY1bf44wad0TQUq4c1lsrJKPFuZkrJnASEFzk6Vi7RGehhqIVQfRErmwMvTVg2DZcpCc1vDmAv8GIib0oOKbiR3uZwWEeInq7YFiO8mjXsOh/jxbfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763070533; c=relaxed/simple;
	bh=reUr5vr9UGxA/z5v5hvjsSRJR9k1NeomI4kvfTl5mRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gngPFK961FlSjvMk7u7DTd++vnwC89SqxgJsEtyakef/SgOn6FZU1r/bIhH/Rt3djBALGFFtATboVJv93g2NLUTFoWwjNS174yTH0ZBc2sJ1o+uWsedwVlZFEPZzuTePpiwKmf+VLYHOp1c620MBFrMLfBbG1/xh7GmgJA2mSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fgFcjYQn; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a92e2c4a-bfde-4a74-8bb5-5e2b8ca87199@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763070528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWxDrNld1/nw1/i6TIgWHQ0YjF/o5aVc62P7yzv+ZHI=;
	b=fgFcjYQnEUyDVhIeB5QDbAbARXGAxFYqOqQEvNDO5ZhsLMNZhWG968TwoTEdTyiJglExnl
	pRjkNIkkLGpyppjdDp+hkBDVrCknaPtJKfB4Sfz/AiivhqlEpo3yK1gNgKoYs66SnLl0bc
	6Immm6dOOxEXWE5eEYPyh7RT4EkwJts=
Date: Thu, 13 Nov 2025 13:48:40 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v5 3/3] selftests/bpf: Add mptcp test with sockmap
To: Jiayuan Chen <jiayuan.chen@linux.dev>,
 Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>,
 Peter Krystad <peter.krystad@linux.intel.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251111060307.194196-1-jiayuan.chen@linux.dev>
 <20251111060307.194196-4-jiayuan.chen@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251111060307.194196-4-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index f8eb7f9d4fd2..b976fe626343 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -6,11 +6,14 @@
>   #include <netinet/in.h>
>   #include <test_progs.h>
>   #include <unistd.h>
> +#include <error.h>

I changed to errno.h to be specific. I think you only need the values of 
an errno here.
>   #include "cgroup_helpers.h"
>   #include "network_helpers.h"
> +#include "socket_helpers.h"
>   #include "mptcp_sock.skel.h"
>   #include "mptcpify.skel.h"
>   #include "mptcp_subflow.skel.h"
> +#include "mptcp_sockmap.skel.h"
>   
>   #define NS_TEST "mptcp_ns"
>   #define ADDR_1	"10.0.1.1"
> @@ -436,6 +439,142 @@ static void test_subflow(void)
>   	close(cgroup_fd);
>   }
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
> +	if (!ASSERT_OK_FD(listen_fd, "sockmap-fb:start_mptcp_server"))
> +		return;
> +
> +	skel->bss->trace_port = ntohs(get_socket_local_port(listen_fd));
> +	skel->bss->sk_index = 0;
> +	/* create client without MPTCP enabled */
> +	client_fd1 = connect_to_fd_opts(listen_fd, NULL);
> +	if (!ASSERT_OK_FD(client_fd1, "sockmap-fb:connect_to_fd"))
> +		goto end;
> +
> +	server_fd1 = xaccept_nonblock(listen_fd, NULL, NULL);
> +	skel->bss->sk_index = 1;
> +	client_fd2 = connect_to_fd_opts(listen_fd, NULL);
> +	if (!ASSERT_OK_FD(client_fd2, "sockmap-fb:connect_to_fd"))
> +		goto end;
> +
> +	server_fd2 = xaccept_nonblock(listen_fd, NULL, NULL);
> +	/* test normal redirect behavior: data sent by client_fd1 can be
> +	 * received by client_fd2
> +	 */
> +	skel->bss->redirect_idx = 1;
> +	sent = xsend(client_fd1, snd, sizeof(snd), 0);
> +	if (!ASSERT_EQ(sent, sizeof(snd), "sockmap-fb:xsend(client_fd1)"))
> +		goto end;
> +
> +	/* try to recv more bytes to avoid truncation check */
> +	recvd = recv_timeout(client_fd2, rcv, sizeof(rcv), MSG_DONTWAIT, 2);

I removed the socket_helpers.h usage. The _nonblock, _timeout, and
MSG_DONTWAIT are unnecessary. I replaced them with the regular accept,
send, and recv. All fds from network_helpers.c have a default 3s
timeout instead of 30s in xaccept_nonblock. This matches how most of
the selftests/bpf are doing it as well.

I also touched up the commit message in patch 2 based on Matt's comment.

Applied. Thanks.

> +	server_fd = xaccept_nonblock(listen_fd, NULL, NULL);
> +	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
> +				  &zero, &server_fd, BPF_NOEXIST);

