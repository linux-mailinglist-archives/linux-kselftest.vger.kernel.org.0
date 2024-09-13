Return-Path: <linux-kselftest+bounces-17939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D6C977F4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 14:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D1A1C2283D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9626B1D9324;
	Fri, 13 Sep 2024 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tJ/HlPiy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB61C175F;
	Fri, 13 Sep 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229439; cv=none; b=gsSFQ3rOondOT3FgrWT90cZA7fznPcTn+Kk3KfRLLDdgQ+LXMUjKI61mRNozUnQHw4pGZRPUNjrbt9twmWb8jXtXmaps0envqfe8a9vO5wXZzBl8EDlJ6OWX43nJpZVos7FzJ0ZFnqqFHCBuURRQmdtb6PqAnyLVEiHLNLuVE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229439; c=relaxed/simple;
	bh=eKQp8WFIivIlz81KoAc08q+LcLeM6mnKsSpVWLX81KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPk5nlogtF4lF05ltEOrEshELdUND6KSuaqlCgRxgOo0GvcmhVLXQxhUqA1qN8Z2vTh+HUcsHC2jsqRkuES0xhATiS+X+ixXu6d8ehNWf29i8w1gAcsnJfCg4jHRfHNDXj+1GECyWV5vtf4gDTz3O5zSdxHt0rdTYQtnzh6Efvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tJ/HlPiy; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726229428; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=p9RxojJzKbhCDZ6wrWjhZvZmrSV8ktXcTQ8diFhFAdU=;
	b=tJ/HlPiy+ZyoFbPBKnvDUHx6+Cle+ChCWkuhjl90CaCOBTCE056za0+UMx2H8fg6Q+o2XdSnRwCU7Qqw29lJTVsvqtDE8765m4PFSjewyKqRy8TREl8bqt1UlcKpvX4yarc299pOhcvU1AChfK1r8It0yvGHIu/VgRMN47mpiMU=
Received: from 30.221.128.100(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WEurYQC_1726229425)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 20:10:26 +0800
Message-ID: <8d5469d2-7525-420b-b506-8de2ecf04734@linux.alibaba.com>
Date: Fri, 13 Sep 2024 20:10:24 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] bpf: Add sk_lookup test to use ORIGDSTADDR cmsg.
To: Tiago Lam <tiagolam@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Jakub Sitnicki <jakub@cloudflare.com>, kernel-team@cloudflare.com
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
 <20240913-reverse-sk-lookup-v1-3-e721ea003d4c@cloudflare.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <20240913-reverse-sk-lookup-v1-3-e721ea003d4c@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tiago,

On 2024/9/13 17:39, Tiago Lam wrote:
> This patch reuses the framework already in place for sk_lookup, allowing
> it now to send a reply from the server fd directly, instead of having to
> create a socket bound to the original destination address and reply from
> there. It does this by passing the source address and port from where to
> reply from in a IP_ORIGDSTADDR ancilliary message passed in sendmsg.
> 
> Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 70 +++++++++++++++-------
>   1 file changed, 48 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> index ae87c00867ba..b99aff2e3976 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> @@ -75,6 +75,7 @@ struct test {
>   	struct inet_addr listen_at;
>   	enum server accept_on;
>   	bool reuseport_has_conns; /* Add a connected socket to reuseport group */
> +	bool dont_bind_reply; /* Don't bind, send direct from server fd. */
>   };
>   
>   struct cb_opts {
> @@ -363,7 +364,7 @@ static void v4_to_v6(struct sockaddr_storage *ss)
>   	memset(&v6->sin6_addr.s6_addr[0], 0, 10);
>   }
>   
> -static int udp_recv_send(int server_fd)
> +static int udp_recv_send(int server_fd, bool dont_bind_reply)
>   {
>   	char cmsg_buf[CMSG_SPACE(sizeof(struct sockaddr_storage))];
>   	struct sockaddr_storage _src_addr = { 0 };
> @@ -415,26 +416,41 @@ static int udp_recv_send(int server_fd)
>   		v4_to_v6(dst_addr);
>   	}
>   
> -	/* Reply from original destination address. */
> -	fd = start_server_addr(SOCK_DGRAM, dst_addr, sizeof(*dst_addr), NULL);
> -	if (!ASSERT_OK_FD(fd, "start_server_addr")) {
> -		log_err("failed to create tx socket");
> -		return -1;
> -	}
> +	if (dont_bind_reply) {
> +		/* Reply directly from server fd, specifying the source address and/or
> +		 * port in struct msghdr.
> +		 */
> +		n = sendmsg(server_fd, &msg, 0);
> +		if (CHECK(n <= 0, "sendmsg", "failed\n")) {
> +			log_err("failed to send echo reply");
> +			return -1;
> +		}
> +	} else {
> +		/* Reply from original destination address. */
> +		fd = socket(dst_addr->ss_family, SOCK_DGRAM, 0);
> +		if (CHECK(fd < 0, "socket", "failed\n")) {
> +			log_err("failed to create tx socket");
> +			return -1;
> +		}
>   
Just curious, why not use start_server_addr() here like before?

> -	msg.msg_control = NULL;
> -	msg.msg_controllen = 0;
> -	n = sendmsg(fd, &msg, 0);
> -	if (CHECK(n <= 0, "sendmsg", "failed\n")) {
> -		log_err("failed to send echo reply");
> -		ret = -1;
> -		goto out;
> -	}
> +		ret = bind(fd, (struct sockaddr *)dst_addr, sizeof(*dst_addr));
> +		if (CHECK(ret, "bind", "failed\n")) {
> +			log_err("failed to bind tx socket");
> +			close(fd);
> +			return ret;
> +		}
>   
> -	ret = 0;
> -out:
> -	close(fd);
> -	return ret;
> +		msg.msg_control = NULL;
> +		msg.msg_controllen = 0;
> +		n = sendmsg(fd, &msg, 0);
> +		if (CHECK(n <= 0, "sendmsg", "failed\n")) {
> +			log_err("failed to send echo reply");
> +			close(fd);
> +			return -1;
> +		}
> +
> +		close(fd);
> +	}

nit: "return 0" missed.

>   }
>   

-- 
Philo


