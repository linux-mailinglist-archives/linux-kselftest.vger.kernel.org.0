Return-Path: <linux-kselftest+bounces-10480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 680078CB28B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 18:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE28B1F2236D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 16:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C617580B;
	Tue, 21 May 2024 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lL10cmY/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816F7F46C
	for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310604; cv=none; b=Wkoq2xO4k5tYUFgZNvRcANZvm1kKcgDSboDyNRZ15iwoQoOuqwDqEsHR/ggPaeS2XNkAbEHsSDrogp1pwLpQlI2mbEHcDx/4eL0ypV1Dh8iwWMYE7W5Zk/ofBD2sUR7wYagfH7/K2LxxFxjfjtRxO6JLkjVT9Mny2XkO7hZZ7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310604; c=relaxed/simple;
	bh=oB7MzplTbKVCh14+79NAxqy62U4C88ms9HxhSAs6yNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAy/1y+wL3aVPQtIX37Vgz+1IvTvOF2rzhp5fHNhG9lPkhTveipGgsN6YSzH4R+T3r6bVqoc1kYiUnxpCUVLxO/2XiwdK3zrDqIeRCWlX+EVfYvU1dG1DFR668ZjLr4uh0aOCSJfsWSKQ6wQow+cJMdsL8tfUQ4MwkYOoNtgHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lL10cmY/; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716310600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmM/aNE8tI5vtI0prsxo11rjvbiNagTdGhDgFn6+HZg=;
	b=lL10cmY/pB451EZHvDHXUKYA2iA9dFbwjmkKmeM5+rr6Ul6QtPefxGiWarPRZDpFch+D6c
	CpEinw+XyjbgzXLpyymFqZPg4jtpvueepC/ddfb1pOLaAGvOf/OQkb9yvRL5zuUKLRngFp
	QSlB4Xfe+chlWaDNB9iLUgMqz4vRSqM=
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
Message-ID: <a4db3afb-4dc6-4aea-8424-a1c9cc9563bf@linux.dev>
Date: Tue, 21 May 2024 09:56:29 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: Use post_socket_cb in
 connect_to_fd_opts
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
References: <cover.1715745588.git.tanggeliang@kylinos.cn>
 <0de05f2ffdfa4adb832fb87d08e6d1c56bef62b2.1715745588.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <0de05f2ffdfa4adb832fb87d08e6d1c56bef62b2.1715745588.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/14/24 9:20 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Since the post_socket_cb() callback is added in struct network_helper_opts,
> it's make sense to use it not only in __start_server(), but also in
> connect_to_fd_opts(). Then it can be used to set TCP_CONGESTION sockopt.
> 
> Add a post_socket_opts type member cb_opts into struct network_helper_opts,
> then cc can be moved into struct post_socket_opts from network_helper_opts.
> Define a new callback cc_cb() to set TCP_CONGESTION sockopt, and set it to
> post_socket_cb pointer.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/network_helpers.c       | 5 ++---
>   tools/testing/selftests/bpf/network_helpers.h       | 6 ++++--
>   tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 9 ++++++++-
>   3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 35250e6cde7f..d97f8a669b38 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -338,9 +338,8 @@ int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
>   	if (settimeo(fd, opts->timeout_ms))
>   		goto error_close;
>   
> -	if (opts->cc && opts->cc[0] &&
> -	    setsockopt(fd, SOL_TCP, TCP_CONGESTION, opts->cc,
> -		       strlen(opts->cc) + 1))
> +	if (opts->post_socket_cb &&
> +	    opts->post_socket_cb(fd, &opts->cb_opts))
>   		goto error_close;
>   
>   	if (!opts->noconnect)
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index 883c7ea9d8d5..e44a6e5d8344 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -21,16 +21,18 @@ typedef __u16 __sum16;
>   #define VIP_NUM 5
>   #define MAGIC_BYTES 123
>   
> -struct post_socket_opts {};
> +struct post_socket_opts {
> +	const char *cc;
> +};

 From looking its usage in this set, it has cc name and map fd in it. It becomes 
clear that it is not possible to have one generic/common "struct 
post_socket_opts" for all tests.

>   
>   struct network_helper_opts {
> -	const char *cc;
>   	int timeout_ms;
>   	bool must_fail;
>   	bool noconnect;
>   	int type;
>   	int proto;
>   	int (*post_socket_cb)(int fd, const struct post_socket_opts *opts);
> +	struct post_socket_opts cb_opts;

It is better to have the individual test define its own callback opts struct. 
Something like this:

/* network_helpers.h */
struct network_helper_opts {
	/* ... */
	int (*post_socket_cb)(int fd, void *opts);
	void *post_socket_opts;
};

/* bpf_tcp_ca.c */
struct cb_opts {
	const char *cc;
	int map_fd;
};

struct cb_opts cb_opts = {
	.cc = "bpf_dctcp",
	.map_fd = fd,
};

struct network_helper_opts opts = {
	.post_socket_cb = stg_post_socket_cb,
	.post_sock_opts = &cb_opts,
};

pw-bot: cr

>   };
>   
>   /* ipv4 test vector */
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index 0aca02532794..9bc909fa0833 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> @@ -81,6 +81,12 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
>   	close(fd);
>   }
>   
> +static int cc_cb(int fd, const struct post_socket_opts *opts)
> +{
> +	return setsockopt(fd, SOL_TCP, TCP_CONGESTION, opts->cc,
> +			  strlen(opts->cc) + 1);
> +}
> +
>   static void test_cubic(void)
>   {
>   	struct bpf_cubic *cubic_skel;
> @@ -172,7 +178,8 @@ static void test_dctcp_fallback(void)
>   {
>   	int err, lfd = -1, cli_fd = -1, srv_fd = -1;
>   	struct network_helper_opts opts = {
> -		.cc = "cubic",
> +		.cb_opts.cc = "cubic",
> +		.post_socket_cb = cc_cb,
>   	};
>   	struct bpf_dctcp *dctcp_skel;
>   	struct bpf_link *link = NULL;


