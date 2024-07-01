Return-Path: <linux-kselftest+bounces-12994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DD191DAEC
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 11:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A31B254DC
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F44783CD2;
	Mon,  1 Jul 2024 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ra/k4bWf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ABA7CF39;
	Mon,  1 Jul 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824423; cv=none; b=MzHBlFvx8+D2ylogYIs7GnHetrQ9HPSyvX61WH7fNeA8MGiFayDwbzC8Rym7jXuD3eOINW0kv0q4xrxo4zWvlnniGVvKFMksEh3XHj5IJjj7ykVbUnxOWoNhD2RKGVwsFc97hhd44jbhqS7wZxmDvK6O14MNBcGdvslBOdfCjQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824423; c=relaxed/simple;
	bh=xUkxAusGk9/Qw6q8jmjJR4Ku+OMgNTKRh5xehrBoSOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnRhuGGNzrF4iOIZKcpNRxx3J1GhliW5c2e5+E3bgnK9XO/HEFlgI8198KDAnVqyNu4+hLV9W4zhCnZw5TA6LPIBamehIkjfNsDeWgqHY8cpm2UX/neURB26NZoS1+X3RMklBxYoYlbZBGstGSFcfVRITCueNhZSpVH1Fvl4NFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ra/k4bWf; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719824418; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=l5lmapBeZhT3E2/y8+mzkM2aHa//cBtzt7v6JkMhiec=;
	b=Ra/k4bWfoITEwtXbynqR1KXOzhJO99GpKTlC2vM/5bOWiX8w5u7ziPsLnudf/Xo5gZvP+X2lORplhKTqiuBRksdf9P3hKfbqBjLd3Jt+Scn/EqttIx/vaigtF+rQfdNScPgqPTxM6VEOrn/2KyMF/OS409VHvITIUUKVhtrwoXM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=29;SR=0;TI=SMTPD_---0W9c7q0U_1719824406;
Received: from 30.221.145.205(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W9c7q0U_1719824406)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 17:00:13 +0800
Message-ID: <70d94a71-2654-4647-97f3-1017adee1fd4@linux.alibaba.com>
Date: Mon, 1 Jul 2024 17:00:05 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] skmsg: bugfix for sk_msg sge iteration
To: Geliang Tang <geliang@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, David Ahern <dsahern@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Mykyta Yatsenko <yatsenko@meta.com>, Miao Xu <miaxu@meta.com>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1719553101.git.tanggeliang@kylinos.cn>
 <56d8ec28df901432e7bde4953795166ce2edd472.1719553101.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <56d8ec28df901432e7bde4953795166ce2edd472.1719553101.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/28/24 1:47 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Every time run this BPF selftests (./test_sockmap) on a Loongarch platform,
> a Kernel panic occurs:
>
> '''
>   Oops[#1]:
>   CPU: 20 PID: 23245 Comm: test_sockmap Tainted: G     OE 6.10.0-rc2+ #32
>   Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK2018
>   ... ...
>      ra: 90000000043a315c tcp_bpf_sendmsg+0x23c/0x420
>     ERA: 900000000426cd1c sk_msg_memcopy_from_iter+0xbc/0x220
>    CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
>    PRMD: 0000000c (PPLV0 +PIE +PWE)
>    EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
>    ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
>   ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
>    BADV: 0000000000000040
>    PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
>   Modules linked in: tls xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
>   Process test_sockmap (pid: 23245, threadinfo=00000000aeb68043, task=...)
>   Stack : ... ...
>           ...
>   Call Trace:
>   [<900000000426cd1c>] sk_msg_memcopy_from_iter+0xbc/0x220
>   [<90000000043a315c>] tcp_bpf_sendmsg+0x23c/0x420
>   [<90000000041cafc8>] __sock_sendmsg+0x68/0xe0
>   [<90000000041cc4bc>] ____sys_sendmsg+0x2bc/0x360
>   [<90000000041cea18>] ___sys_sendmsg+0xb8/0x120
>   [<90000000041cf1f8>] __sys_sendmsg+0x98/0x100
>   [<90000000045b76ec>] do_syscall+0x8c/0xc0
>   [<90000000030e1da4>] handle_syscall+0xc4/0x160
>
>   Code: ...
>
>   ---[ end trace 0000000000000000 ]---
> '''
>
> This crash is because a NULL pointer is passed to page_address() in
> sk_msg_memcopy_from_iter(). Due to the difference in architecture,
> page_address(0) will not trigger a panic on the X86 platform but will panic
> on the Loogarch platform. So this bug was hidden on the x86 platform, but
> now it is exposed on the Loogarch platform.
>
> This bug is a logic error indeed. In sk_msg_memcopy_from_iter(), an invalid
> "sge" is always used:
>
> 	if (msg->sg.copybreak >= sge->length) {
> 		msg->sg.copybreak = 0;
> 		sk_msg_iter_var_next(i);
> 		if (i == msg->sg.end)
> 			break;
> 		sge = sk_msg_elem(msg, i);
> 	}
>
> If the value of i is 2, msg->sg.end is also 2 when entering this if block.
> sk_msg_iter_var_next() increases i by 1, and now i is 3, which is no longer
> equal to msg->sg.end. The break will not be triggered, and the next sge
> obtained by sk_msg_elem(3) will be an invalid one.
>
> The correct approach is to check (i == msg->sg.end) first, and then invoke
> sk_msg_iter_var_next() if they are not equal.
>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   net/core/skmsg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 44952cdd1425..1906d0d0eeac 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -378,9 +378,9 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
>   		/* This is possible if a trim operation shrunk the buffer */
>   		if (msg->sg.copybreak >= sge->length) {
>   			msg->sg.copybreak = 0;
> -			sk_msg_iter_var_next(i);
>   			if (i == msg->sg.end)
>   				break;
> +			sk_msg_iter_var_next(i);
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
>   			sge = sk_msg_elem(msg, i);
>   		}
>   



