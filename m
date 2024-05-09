Return-Path: <linux-kselftest+bounces-9893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C28C1781
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B44DB2720B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F85F80027;
	Thu,  9 May 2024 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TFqsHI+K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029A779F2
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715286494; cv=none; b=cl/qt5E+lid/t8qlsZEGSwfC40HtfJnSQpq11wOT3L+EqWLoMLY8mE/3tWBSRkdJfxea8pRUevjblpyDuxAJUajUOTGs6VcVc6fjMcKOmCj02TX8L5+OmkJ4s0ewP5soQLVDge1kvJ49zWHzG7MUl11tvvl0b/y0Qe8eg36L4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715286494; c=relaxed/simple;
	bh=t3PSYjrrm0kB97nHt5SsTIKmZ4lnb3Atsn16i/rxpss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhZr5WKrM7xTI9mCx5TBKdTN+Wlt2jf++su9X6HAHVnT36YHa+F/pYuOnrx97znIg/sIJYDpmFH0R3heL1nZwz6Bm0ncj72yxjnDt7eCcoMnugX6F0C1Th+yQPH/9lZHm2iJ5Ex5Xpk46lMS6n8BWhXU5BHDaLI/STfsuOpl6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TFqsHI+K; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0d07ca72-8353-47a2-afc6-bb18a80846b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715286489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVdoedZ6iLjyHOw3qwJFcT4NZ3zIZ6uozx4v6pAcp4o=;
	b=TFqsHI+K+wXE/hmMQ/HoFgFiTQgAw4kzv2NYILt+4pUofHwZElBdPUTWKvIelEPrutGloX
	OgIjuBHXfXCyAAGnh2Lq8We9ppR5Q2BWHJwmZoc+i4V7IUCiAXfQnbQ+5bRcekUptgT8mR
	bnYyeh6iPI4C8zcknkN0sZ/b86zFKhY=
Date: Thu, 9 May 2024 13:28:02 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/6] selftests/bpf: Add post_socket_cb for
 network_helper_opts
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>, Geliang Tang
 <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1714907662.git.tanggeliang@kylinos.cn>
 <470cb82f209f055fc7fb39c66c6b090b5b7ed2b2.1714907662.git.tanggeliang@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <470cb82f209f055fc7fb39c66c6b090b5b7ed2b2.1714907662.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/5/24 4:35 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> __start_server() sets SO_REUSPORT through setsockopt() when the parameter
> 'reuseport' is set. This patch makes it more flexible by adding a function
> pointer post_socket_cb, together with 'struct post_socket_opts cb_opts'
> for future extension into struct network_helper_opts. Then 'reuseport'
> parameter can be dropped.
> 
> Now the original start_reuseport_server() can be implemented by setting a
> newly defined reuseport_cb() function pointer to post_socket_cb filed of
> struct network_helper_opts.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/network_helpers.c | 25 ++++++++++++-------
>   tools/testing/selftests/bpf/network_helpers.h |  4 +++
>   2 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 054d26e383e0..a7ab05baedb6 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -81,9 +81,8 @@ int settimeo(int fd, int timeout_ms)
>   #define save_errno_close(fd) ({ int __save = errno; close(fd); errno = __save; })
>   
>   static int __start_server(int type, const struct sockaddr *addr, socklen_t addrlen,
> -			  bool reuseport, const struct network_helper_opts *opts)
> +			  const struct network_helper_opts *opts)
>   {
> -	int on = 1;
>   	int fd;
>   
>   	fd = socket(addr->sa_family, type, opts->proto);
> @@ -95,9 +94,9 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
>   	if (settimeo(fd, opts->timeout_ms))
>   		goto error_close;
>   
> -	if (reuseport &&
> -	    setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &on, sizeof(on))) {
> -		log_err("Failed to set SO_REUSEPORT");
> +	if (opts->post_socket_cb &&
> +	    opts->post_socket_cb(fd, &opts->cb_opts)) {
> +		log_err("Failed to call post_socket_cb");
>   		goto error_close;
>   	}
>   
> @@ -132,7 +131,14 @@ int start_server(int family, int type, const char *addr_str, __u16 port,
>   	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
>   		return -1;
>   
> -	return __start_server(type, (struct sockaddr *)&addr, addrlen, false, &opts);
> +	return __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
> +}
> +
> +static int reuseport_cb(int fd, const struct post_socket_opts *opts)
> +{
> +	int on = 1;
> +
> +	return setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &on, sizeof(on));
>   }
>   
>   int *start_reuseport_server(int family, int type, const char *addr_str,
> @@ -140,6 +146,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
>   {
>   	struct network_helper_opts opts = {
>   		.timeout_ms = timeout_ms,
> +		.post_socket_cb = reuseport_cb,
>   	};
>   	struct sockaddr_storage addr;
>   	unsigned int nr_fds = 0;
> @@ -156,7 +163,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
>   	if (!fds)
>   		return NULL;
>   
> -	fds[0] = __start_server(type, (struct sockaddr *)&addr, addrlen, true, &opts);
> +	fds[0] = __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
>   	if (fds[0] == -1)
>   		goto close_fds;
>   	nr_fds = 1;
> @@ -165,7 +172,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
>   		goto close_fds;
>   
>   	for (; nr_fds < nr_listens; nr_fds++) {
> -		fds[nr_fds] = __start_server(type, (struct sockaddr *)&addr, addrlen, true, &opts);
> +		fds[nr_fds] = __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
>   		if (fds[nr_fds] == -1)
>   			goto close_fds;
>   	}
> @@ -183,7 +190,7 @@ int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t l
>   	if (!opts)
>   		opts = &default_opts;
>   
> -	return __start_server(type, (struct sockaddr *)addr, len, 0, opts);
> +	return __start_server(type, (struct sockaddr *)addr, len, opts);
>   }
>   
>   void free_fds(int *fds, unsigned int nr_close_fds)
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index c62b54daa914..887075fbf6ec 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -21,6 +21,8 @@ typedef __u16 __sum16;
>   #define VIP_NUM 5
>   #define MAGIC_BYTES 123
>   
> +struct post_socket_opts {};
> +
>   struct network_helper_opts {
>   	const char *cc;
>   	int timeout_ms;
> @@ -28,6 +30,8 @@ struct network_helper_opts {
>   	bool noconnect;
>   	int type;
>   	int proto;
> +	int (*post_socket_cb)(int fd, const struct post_socket_opts *opts);
> +	struct post_socket_opts cb_opts;

I am going to remove cb_opts from network_helper_opts for now. Lets wait for the 
first use case of post_socket_opts comes up. NULL is always passed to 
post_socket_cb for now.

>   };
>   
>   /* ipv4 test vector */


