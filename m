Return-Path: <linux-kselftest+bounces-10820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ACC8D2C56
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 07:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7AA1F24756
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 05:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3EA15B968;
	Wed, 29 May 2024 05:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xTWpyTi6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B613A412
	for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 05:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960097; cv=none; b=hnBYCczrRM4B2Nn/OcCadQ5qMTdVr6+AHY9cqX6oiL97s0YsnrxQ4zwWVBiEEhzwOO2g8nmPXasm/35twc7F8r9NCxAIq4uXPRAZhg1dBSDC4n3z3RSkpG+LLe8w5dZ34H6m3Gu0ox6wHGBHA1b82lD4cWeH8WDGgav+tqHYwl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960097; c=relaxed/simple;
	bh=AMUyskMn5U6yTE5gn7TbbvIbtBH+k2p76TxkBf6MHVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naJ2SRAyf27AxiZM6xyWIhDLTxelxMBzCD16aN4LSh16CI5CubflPa3p4+jOSiA4fLjP0oakWgGLMqnXrchsXkE+S9alIAe+tZR4kr6VEKd7Ur50NCWWm5x0p3ziq19VLAZLcA29YdCwhu1w584bdADaocQyL4mUQZGarEyvP1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xTWpyTi6; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716960093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kl8hGEW/2548XxDr0qdqYVQKMvRyGwuedu95b7k9cx8=;
	b=xTWpyTi6n09UjUuVdg7fDMqw92t36bnSHsaS82ZURMjjRNk2rjYrOfVGwmHHV5c5GK0sE7
	AI9Fbk4QVB3kHSS1ocC6mIKHjvxB8mH+0f4k9fZeKQ3dX0irdt8pfPDPyF4B1QJQLdmO+c
	EcsfB57w2yTDMFVOTqYWIiwiMcgZgAE=
X-Envelope-To: andrii@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: mykolal@fb.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: song@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: shuah@kernel.org
X-Envelope-To: tanggeliang@kylinos.cn
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
Message-ID: <7e9c544a-fd2a-4c19-b06b-d72b5e7fc543@linux.dev>
Date: Tue, 28 May 2024 22:21:24 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 6/7] selftests/bpf: Use connect_to_fd_opts in
 do_test in bpf_tcp_ca
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1716638248.git.tanggeliang@kylinos.cn>
 <bd55a421ab8e8b8bce4658840bc028d9aa6965c5.1716638248.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <bd55a421ab8e8b8bce4658840bc028d9aa6965c5.1716638248.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/25/24 5:08 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch uses connect_to_fd_opts() instead of using connect_fd_to_fd()
> and settcpca() in do_test() in prog_tests/bpf_tcp_ca.c to accept a struct
> network_helper_opts argument.
> 
> Then define a dctcp dedicated post_socket_cb callback stg_post_socket_cb(),
> invoking both cc_cb() and bpf_map_update_elem() in it, and set it in
> test_dctcp(). For passing map_fd into stg_post_socket_cb() callback, a new
> member map_fd is added in struct cb_opts.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 42 ++++++++++---------
>   1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index ebc7d4616880..9a7c3dc39008 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> @@ -25,6 +25,7 @@ static int expected_stg = 0xeB9F;
>   
>   struct cb_opts {
>   	const char *cc;
> +	int map_fd;
>   };
>   
>   static int settcpca(int fd, const char *tcp_ca)
> @@ -41,7 +42,6 @@ static int settcpca(int fd, const char *tcp_ca)
>   static void do_test(const struct network_helper_opts *opts,
>   		    const struct bpf_map *sk_stg_map)
>   {
> -	struct cb_opts *cb_opts = (struct cb_opts *)opts->cb_opts;
>   	int lfd = -1, fd = -1;
>   	int err;
>   
> @@ -49,25 +49,9 @@ static void do_test(const struct network_helper_opts *opts,
>   	if (!ASSERT_NEQ(lfd, -1, "socket"))
>   		return;
>   
> -	fd = socket(AF_INET6, SOCK_STREAM, 0);
> -	if (!ASSERT_NEQ(fd, -1, "socket")) {
> -		close(lfd);
> -		return;
> -	}
> -
> -	if (settcpca(fd, cb_opts->cc))
> -		goto done;
> -
> -	if (sk_stg_map) {
> -		err = bpf_map_update_elem(bpf_map__fd(sk_stg_map), &fd,
> -					  &expected_stg, BPF_NOEXIST);
> -		if (!ASSERT_OK(err, "bpf_map_update_elem(sk_stg_map)"))
> -			goto done;
> -	}
> -
>   	/* connect to server */
> -	err = connect_fd_to_fd(fd, lfd, 0);
> -	if (!ASSERT_NEQ(err, -1, "connect"))
> +	fd = connect_to_fd_opts(lfd, opts);
> +	if (!ASSERT_NEQ(fd, -1, "connect_to_fd_opts"))
>   		goto done;
>   
>   	if (sk_stg_map) {
> @@ -124,13 +108,30 @@ static void test_cubic(void)
>   	bpf_cubic__destroy(cubic_skel);
>   }
>   
> +static int stg_post_socket_cb(int fd, void *opts)
> +{
> +	struct cb_opts *cb_opts = (struct cb_opts *)opts;
> +	int err;
> +
> +	err = settcpca(fd, cb_opts->cc);
> +	if (err)
> +		return err;
> +
> +	err = bpf_map_update_elem(cb_opts->map_fd, &fd,
> +				  &expected_stg, BPF_NOEXIST);

Looking at it again, it is not very correct. At least this map update is 
unnecessary for the start_server_str() in do_test(). do_test() uses the same 
opts for start_server_str() and connect_to_fd_opts().

Also, the post_connect_cb in patch 8 is unnecessary for network_helpers.c. The 
connect_to_fd_opts helper is going to return the fd anyway. It is unnecessary to 
have the helper to do the post_connect_cb(fd). The caller (do_test here) can 
directly do that instead. Lets not add unnecessary post_connect_cb to the 
network_helpers.c now until there is a clear case that the caller cannot do it.

I would just add another "const struct network_helper_opts *cli_opts" to the
do_test() to do what patch 7 and patch 8 need to do. Separate it from the server 
"opts".

Patach 1 to 5 is applied. Thanks.


> +	if (!ASSERT_OK(err, "bpf_map_update_elem(sk_stg_map)"))
> +		return err;
> +
> +	return 0;
> +}
> +
>   static void test_dctcp(void)
>   {
>   	struct cb_opts cb_opts = {
>   		.cc = "bpf_dctcp",
>   	};
>   	struct network_helper_opts opts = {
> -		.post_socket_cb	= cc_cb,
> +		.post_socket_cb	= stg_post_socket_cb,
>   		.cb_opts	= &cb_opts,
>   	};
>   	struct bpf_dctcp *dctcp_skel;
> @@ -146,6 +147,7 @@ static void test_dctcp(void)
>   		return;
>   	}
>   
> +	cb_opts.map_fd = bpf_map__fd(dctcp_skel->maps.sk_stg_map);
>   	do_test(&opts, dctcp_skel->maps.sk_stg_map);
>   	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
>   


