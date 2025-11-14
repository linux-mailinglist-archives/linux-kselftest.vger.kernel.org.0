Return-Path: <linux-kselftest+bounces-45634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 726E4C5C6FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 11:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A14CB359BC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01375309EE1;
	Fri, 14 Nov 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhX5vnil"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC20A2D73A3;
	Fri, 14 Nov 2025 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763114453; cv=none; b=kSv3clbLPuyaAWreWKDKUoxdJj8kWW4SwzpKMpO3TS153mrul8NJd1Irm7klIOhP/hdFoO71NSCkK6lTufpH0uvj4ieey/g0m/czV0Ao4i8ABl6tKYoK4tW3f+/pBRP2lsQFqvyOsiBKrM/5XearHZLp0Sak9Dn5IjIc6HsMaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763114453; c=relaxed/simple;
	bh=yXdik3qblw9W6slk3JMRfjEQ0RUHvUCkdnP6MjfqTyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItqddqtER3MAESFdSQMnWzM7/twx40Zt1DGNbRf26myRJCSsi5vaKCWIZxfEzUL9PSDO51pjfPvi5UQaF3bmpnsiCxyxwIHdPUTkCQk+n+WuZBblZFFND2Hn43EGv8m8dtTZewOxD+zPP0zcXRIALGAYNKXH4hDWcheL1Wi8gNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhX5vnil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94636C4CEFB;
	Fri, 14 Nov 2025 10:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763114453;
	bh=yXdik3qblw9W6slk3JMRfjEQ0RUHvUCkdnP6MjfqTyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LhX5vnilJoGh37ITgXmtVtpeAIFV40wNBTpoHD95YQ7qYwJuirQ83Q+BZ/mEDesaP
	 cSThoCZCqjLJtEcQ7XYxw0c4OOgpTdVNXbv8eMB7L6UCGnMDLJrx5K0XQyWZxFlVBJ
	 GoNdEOcBj7YbIIkAAtv/DJDOAvOls5oa3AkK6thO5ISCDAbWUqepaGtFyeqFq6oARD
	 h1Fp6tICwFb39b0vWCNFMCTchszVJ/BarS/TVXU3xnxobEx/7lZ92RNOlN6ssaF0GL
	 wfduLhPtPw8gLgpeF5NJUwe9DdAqZu1LdJ0sQBcxubmB41ahQpdU8ioNeUGi3PdhKC
	 kkn4HBP/VzBjw==
Message-ID: <545ef721-8e86-4b1f-9333-41e37b46e4d6@kernel.org>
Date: Fri, 14 Nov 2025 11:00:42 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 3/3] selftests/bpf: Add mptcp test with sockmap
Content-Language: en-GB, fr-BE
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
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
 <a92e2c4a-bfde-4a74-8bb5-5e2b8ca87199@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a92e2c4a-bfde-4a74-8bb5-5e2b8ca87199@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Martin,

On 13/11/2025 22:48, Martin KaFai Lau wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/
>> testing/selftests/bpf/prog_tests/mptcp.c
>> index f8eb7f9d4fd2..b976fe626343 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>> @@ -6,11 +6,14 @@
>>   #include <netinet/in.h>
>>   #include <test_progs.h>
>>   #include <unistd.h>
>> +#include <error.h>
> 
> I changed to errno.h to be specific. I think you only need the values of
> an errno here.
>>   #include "cgroup_helpers.h"
>>   #include "network_helpers.h"
>> +#include "socket_helpers.h"
>>   #include "mptcp_sock.skel.h"
>>   #include "mptcpify.skel.h"
>>   #include "mptcp_subflow.skel.h"
>> +#include "mptcp_sockmap.skel.h"
>>     #define NS_TEST "mptcp_ns"
>>   #define ADDR_1    "10.0.1.1"
>> @@ -436,6 +439,142 @@ static void test_subflow(void)
>>       close(cgroup_fd);
>>   }
>>   +/* Test sockmap on MPTCP server handling non-mp-capable clients. */
>> +static void test_sockmap_with_mptcp_fallback(struct mptcp_sockmap *skel)
>> +{
>> +    int listen_fd = -1, client_fd1 = -1, client_fd2 = -1;
>> +    int server_fd1 = -1, server_fd2 = -1, sent, recvd;
>> +    char snd[9] = "123456789";
>> +    char rcv[10];
>> +
>> +    /* start server with MPTCP enabled */
>> +    listen_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
>> +    if (!ASSERT_OK_FD(listen_fd, "sockmap-fb:start_mptcp_server"))
>> +        return;
>> +
>> +    skel->bss->trace_port = ntohs(get_socket_local_port(listen_fd));
>> +    skel->bss->sk_index = 0;
>> +    /* create client without MPTCP enabled */
>> +    client_fd1 = connect_to_fd_opts(listen_fd, NULL);
>> +    if (!ASSERT_OK_FD(client_fd1, "sockmap-fb:connect_to_fd"))
>> +        goto end;
>> +
>> +    server_fd1 = xaccept_nonblock(listen_fd, NULL, NULL);
>> +    skel->bss->sk_index = 1;
>> +    client_fd2 = connect_to_fd_opts(listen_fd, NULL);
>> +    if (!ASSERT_OK_FD(client_fd2, "sockmap-fb:connect_to_fd"))
>> +        goto end;
>> +
>> +    server_fd2 = xaccept_nonblock(listen_fd, NULL, NULL);
>> +    /* test normal redirect behavior: data sent by client_fd1 can be
>> +     * received by client_fd2
>> +     */
>> +    skel->bss->redirect_idx = 1;
>> +    sent = xsend(client_fd1, snd, sizeof(snd), 0);
>> +    if (!ASSERT_EQ(sent, sizeof(snd), "sockmap-fb:xsend(client_fd1)"))
>> +        goto end;
>> +
>> +    /* try to recv more bytes to avoid truncation check */
>> +    recvd = recv_timeout(client_fd2, rcv, sizeof(rcv), MSG_DONTWAIT, 2);
> 
> I removed the socket_helpers.h usage. The _nonblock, _timeout, and
> MSG_DONTWAIT are unnecessary. I replaced them with the regular accept,
> send, and recv. All fds from network_helpers.c have a default 3s
> timeout instead of 30s in xaccept_nonblock. This matches how most of
> the selftests/bpf are doing it as well.
> 
> I also touched up the commit message in patch 2 based on Matt's comment.

Thank you for having applied the patches, and for the modifications you did!

> Applied. Thanks.
> 
>> +    server_fd = xaccept_nonblock(listen_fd, NULL, NULL);
>> +    err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
>> +                  &zero, &server_fd, BPF_NOEXIST);
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


