Return-Path: <linux-kselftest+bounces-44825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD3DC36BED
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 17:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40D92501599
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 16:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649262248BE;
	Wed,  5 Nov 2025 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXy3o1HA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156C310777;
	Wed,  5 Nov 2025 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360150; cv=none; b=fO03+xFI8Z1UjJsVySogj3L4hIUZ4rNA0w8UVDHEkRLeiaIEBM9HvPBQWOM4cvVb9S91wQplrIVxLllf+oq45m5ByfOAQ7Z909ehJYmni9Sn7R8Wg3yOTTOd/K0kIEo8QDxZ7l3nzUv7l312hoAd1sAdEdzyBuBPWEJRoklg8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360150; c=relaxed/simple;
	bh=E2LyBpj7sEAtFQd7gW1xNRb7UeJ1t4NfeX3b6rOxki0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8B/ORUAsuTrZBmdcxqGU2dZAYxvdWR8zzEZwCXjcG23lIGtdY6nuXe/BiUwatpOfMIz09wwlj2bUA+Rufzyg1aLxE+PfZg5DnDsXtJcbKFpL+z/+LU6TwbwLO+fbYDUdtaxTFrLNB9KdJfPyJOge+/24ieQAu7nkmkcChzwQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXy3o1HA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB4AC4CEF5;
	Wed,  5 Nov 2025 16:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762360147;
	bh=E2LyBpj7sEAtFQd7gW1xNRb7UeJ1t4NfeX3b6rOxki0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uXy3o1HAc6d9NI/8sxdtsN8Od/IF2mKpBo2M1OC8+7a3rPFFJIZE/1xZhMQdHrQgp
	 B5ceNVcaf6DRseXBTphigutFYu/etkAPJ7PfbuTl8mE2KfMCBcFGj2Wz4qhUc5bryP
	 NT43pikoDUCd7b8GznCic56vIWh/SXcB2c6HrjnwL+WV18Z8WsrLyE3BT2geKicNmH
	 p3HjuaYnQzdgCDq7btUjfzN9ArS3DsgRn67LpXTmd4vyCZNw5kUHmVg6YDWHz/0UB9
	 zAk3ljAqawT4zm3+WCQ+u8HBOx5H7bnBFEsQ7ZnTLC2afkeaZnZyr4DTRzxDE9mDEW
	 ubpy0w4WfFllg==
Message-ID: <cc5017b8-5802-4cf5-93b1-18b1e2bd8ae5@kernel.org>
Date: Wed, 5 Nov 2025 17:28:57 +0100
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
 <665825df-b995-45ee-9e0c-2b40cc4897ee@kernel.org>
 <b5f67a681be12833efa12e68fc3139954b409446@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b5f67a681be12833efa12e68fc3139954b409446@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/11/2025 17:12, Jiayuan Chen wrote:
> November 5, 2025 at 22:40, "Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@kernel.org?to=%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E > wrote:
> 
> 
>>
>> Hi Jiayuan,
>>
>> Thank you for this new test!
>>
>> I'm not very familiar with the BPF selftests: it would be nice if
>> someone else can have a quick look.
> 
> Thanks for the review. I've seen the feedback on the other patches(1/3, 2/3) and will fix them up.

Thanks!

>> On 05/11/2025 12:36, Jiayuan Chen wrote:
>>
>>>
>>> Add test cases to verify that when MPTCP falls back to plain TCP sockets,
>>>  they can properly work with sockmap.
>>>  
>>>  Additionally, add test cases to ensure that sockmap correctly rejects
>>>  MPTCP sockets as expected.
>>>  
>>>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>>  ---
>>>  .../testing/selftests/bpf/prog_tests/mptcp.c | 150 ++++++++++++++++++
>>>  .../selftests/bpf/progs/mptcp_sockmap.c | 43 +++++
>>>  2 files changed, 193 insertions(+)
>>>  create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sockmap.c
>>>  
>>>  diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>  index f8eb7f9d4fd2..56c556f603cc 100644
>>>  --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>  +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>  @@ -6,11 +6,14 @@
>>>  #include <netinet/in.h>
>>>  #include <test_progs.h>
>>>  #include <unistd.h>
>>>  +#include <error.h>
>>>
>> Do you use this new include?
> 
> "EOPNOTSUPP" I used was defined in error.h.

Ah OK. I usually only include 'error.h' to use 'error()'.
Is it not 'errno.h' (or 'linux/errno.h') you want instead?

I'm just surprised it is not already included but another one above. But
OK if it is not.

(...)

>>> + return;
>>>  +
>>>  + skel->bss->trace_port = ntohs(get_socket_local_port(listen_fd));
>>>  + skel->bss->sk_index = 0;
>>>  + /* create client with MPTCP enabled */
>>>  + client_fd1 = connect_to_fd(listen_fd, 0);
>>>  + if (!ASSERT_OK_FD(client_fd1, "connect_to_fd client_fd1"))
>>>  + goto end;
>>>  +
>>>  + /* bpf_sock_map_update() called from sockops should reject MPTCP sk */
>>>  + if (!ASSERT_EQ(skel->bss->helper_ret, -EOPNOTSUPP, "should reject"))
>>>  + goto end;
>>>
>> So here, the client is connected, but sockmap doesn't operate on it,
>> right? So most likely, the connection is stalled until the userspace
>> realises that and takes an action?
>>
> 
> It depends. Sockmap usually runs as a bypass. The user app (like Nginx)
> has its own native forwarding logic, and sockmap just kicks in to accelerate
> it. So in known cases, turning off sockmap falls back to the native logic.
> But if there's no native logic, the connection just stalls.

Good to know, thanks!

So MPTCP request might still be handled by the "native logic" if any?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


