Return-Path: <linux-kselftest+bounces-325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41CF7F172F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 16:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDA31F24DA1
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD8B1D537;
	Mon, 20 Nov 2023 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sK17G8fl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [IPv6:2001:41d0:203:375::b7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD425CF
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 07:23:11 -0800 (PST)
Message-ID: <14c7dea0-242c-4b47-929c-7cbd1d7e202a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700493788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiHEeRIW4PiYmJMxEUYlbJ9aO6ly6BInuCc931k4EN8=;
	b=sK17G8fl/Gww8T6qBYhVT6o7jYn3w9ZawQPkHKsYWKEdHz88crw/aEDIcWtpoQWWVHrN5v
	86XXo4wLHDLhzzwYn/fw8QJZBxHIAF4kGbFT3TJPbyvA3o48+lIQP3wjR0t6CdGDkUYYrX
	8/2PnvIbOrZ/SGqMJCMIWk3CxWEWPME=
Date: Mon, 20 Nov 2023 07:22:59 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: Replaces the usage of
 CHECK calls for ASSERTs in bpf_tcp_ca
Content-Language: en-GB
To: Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, andrii.nakryiko@gmail.com, mykolal@fb.com,
 ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <GV1PR10MB6563A7938B9B403861CA88F3E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <GV1PR10MB6563A7938B9B403861CA88F3E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/18/23 1:42 PM, Yuran Pereira wrote:
> bpf_tcp_ca uses the `CHECK` calls even though the use of
> ASSERT_ series of macros is preferred in the bpf selftests.
>
> This patch replaces all `CHECK` calls for equivalent `ASSERT_`
> macro calls.
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 50 +++++++++----------
>   1 file changed, 23 insertions(+), 27 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index 4aabeaa525d4..6d610b66ec38 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> @@ -20,15 +20,14 @@
>   
>   static const unsigned int total_bytes = 10 * 1024 * 1024;
>   static int expected_stg = 0xeB9F;
> -static int stop, duration;
> +static int stop;
>   
> [...]
> @@ -108,26 +107,27 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
>   	sa6.sin6_family = AF_INET6;
>   	sa6.sin6_addr = in6addr_loopback;
>   	err = bind(lfd, (struct sockaddr *)&sa6, addrlen);
> -	if (CHECK(err == -1, "bind", "errno:%d\n", errno))
> +	if (!ASSERT_NEQ(err, -1, "bind"))
>   		goto done;
> +
>   	err = getsockname(lfd, (struct sockaddr *)&sa6, &addrlen);
> -	if (CHECK(err == -1, "getsockname", "errno:%d\n", errno))
> +	if (!ASSERT_NEQ(err, -1, "getsockname"))
>   		goto done;
> +
>   	err = listen(lfd, 1);
> -	if (CHECK(err == -1, "listen", "errno:%d\n", errno))
> +	if (!ASSERT_NEQ(err, -1, "listen"))
>   		goto done;
>   
>   	if (sk_stg_map) {
>   		err = bpf_map_update_elem(bpf_map__fd(sk_stg_map), &fd,
>   					  &expected_stg, BPF_NOEXIST);
> -		if (CHECK(err, "bpf_map_update_elem(sk_stg_map)",
> -			  "err:%d errno:%d\n", err, errno))
> +		if (!ASSERT_OK(err, "bpf_map_update_elem(sk_stg_map)"))
>   			goto done;
>   	}
>   
>   	/* connect to server */
>   	err = connect(fd, (struct sockaddr *)&sa6, addrlen);
> -	if (CHECK(err == -1, "connect", "errno:%d\n", errno))
> +	if (!ASSERT_NEQ(err, -1, "connect"))
>   		goto done;
>   
>   	if (sk_stg_map) {
> @@ -135,14 +135,13 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
>   
>   		err = bpf_map_lookup_elem(bpf_map__fd(sk_stg_map), &fd,
>   					  &tmp_stg);
> -		if (CHECK(!err || errno != ENOENT,
> -			  "bpf_map_lookup_elem(sk_stg_map)",
> -			  "err:%d errno:%d\n", err, errno))
> +		if (!ASSERT_NEQ(err, 0, "bpf_map_lookup_elem(sk_stg_map)") ||

!ASSERT_ERR(err, "bpf_map_lookup_elem(sk_stg_map)")
might be simpler than !ASSERT_NEQ(..).

> +				!ASSERT_EQ(errno, ENOENT, "bpf_map_lookup_elem(sk_stg_map)"))
>   			goto done;
>   	}
>   
>   	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
> -	if (CHECK(err != 0, "pthread_create", "err:%d errno:%d\n", err, errno))
> +	if (!ASSERT_OK(err, "pthread_create"))
>   		goto done;
>   
>   	/* recv total_bytes */
> @@ -156,13 +155,12 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
>   		bytes += nr_recv;
>   	}
>   
> -	CHECK(bytes != total_bytes, "recv", "%zd != %u nr_recv:%zd errno:%d\n",
> -	      bytes, total_bytes, nr_recv, errno);
> +	ASSERT_EQ(bytes, total_bytes, "recv");
>   
>   	WRITE_ONCE(stop, 1);
> -	pthread_join(srv_thread, &thread_ret);
> -	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
> -	      PTR_ERR(thread_ret));
> +	err = pthread_join(srv_thread, &thread_ret);
> +	ASSERT_OK(err, "pthread_join");

The above is not equivalent to the original code.
The original didn't check pthread_join() return as it
is very very unlikely to fail. And check 'thread_ret'
is still needed.

> +
>   done:
>   	close(lfd);
>   	close(fd);
> @@ -174,7 +172,7 @@ static void test_cubic(void)
>   	struct bpf_link *link;
>   
>   	cubic_skel = bpf_cubic__open_and_load();
> -	if (CHECK(!cubic_skel, "bpf_cubic__open_and_load", "failed\n"))
> +	if (!ASSERT_OK_PTR(cubic_skel, "bpf_cubic__open_and_load"))
>   		return;

[...]


