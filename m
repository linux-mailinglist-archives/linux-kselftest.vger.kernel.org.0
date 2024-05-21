Return-Path: <linux-kselftest+bounces-10481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835028CB293
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 19:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115E91F21AEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC88482D0;
	Tue, 21 May 2024 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OFL3511c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D9822F11;
	Tue, 21 May 2024 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310945; cv=none; b=nt4gW2p9xKtiOWn2GYVhfC6BOHdcXRBAWcuxcfjnw1b1RvT/VGz/PVVVmodSO+n4OqVa+JHX7ugxTzevkK1mUpdD3sLIcd7BpWi9x+QUtr51MqnX63T3u94M/WGYT1w3W+9ujvD2+Q3wIVpHJJrh1LpDl5/3w0uOhKvh7Ee/JeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310945; c=relaxed/simple;
	bh=QfCbhAaXGNQvLQcwCuJ2ZSPbopQAclQR/dAUyXbuIRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nzhw73/79Zo1ln0302neYjLobG45ATI6YRZSeZb3WUKdexjjPSK02IID1jJe9ertsCkh8YWkhLX7+w9PIVjIFnPNcRJRK6LPvoq0O446OfsYlST7JlZpNroc3nD8/9nu3RXV7GWHQwmqWkTvu/vkuy/1SutJI97BsUwGZs8QIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OFL3511c; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716310940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A373rHP5VMYLT7kGtqmoOMSg6eK0JOW8MjlxgdA1iU0=;
	b=OFL3511cdqJRB+KvAg7j0gbbm8m1UqFsQ8EJGt30cjsbcDA+pevuuNfkoMGqaExqGBvhvr
	ichNZGV6Fjc6KOGV8IRdbDiXs5e3TLQ18KatWv31BgAa+G67J2+1qraoEioVQunVRPicCD
	EZo447xWUV3Q4X0ePJLqRzYCzNsU2Q4=
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
Message-ID: <b4a654a3-6078-4aca-98f5-f98bc319240d@linux.dev>
Date: Tue, 21 May 2024 10:02:14 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: Use start_server_addr in
 bpf_tcp_ca
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
 <bc13f05ea454890af39ebefb7231b66b545f0486.1715745588.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <bc13f05ea454890af39ebefb7231b66b545f0486.1715745588.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/14/24 9:20 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch uses start_server_addr() in do_test() in prog_tests/bpf_tcp_ca.c
> to accept a struct network_helper_opts argument instead of using
> start_server() and settcpca(). Then change the type of the first paramenter
> of do_test() into a struct network_helper_opts one.
> 
> Define its own opts for each test, set its own cc name into cb_opts.cc, and
> cc_cb() into post_socket_cb callback, then pass it to do_test().
> 
> opts->cb_opts needs to be passed to post_socket_cb() in __start_server().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/network_helpers.c |  2 +-
>   .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 52 +++++++++++++++----
>   2 files changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index d97f8a669b38..6864af665508 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -94,7 +94,7 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
>   	if (settimeo(fd, opts->timeout_ms))
>   		goto error_close;
>   
> -	if (opts->post_socket_cb && opts->post_socket_cb(fd, NULL)) {
> +	if (opts->post_socket_cb && opts->post_socket_cb(fd, &opts->cb_opts)) {
>   		log_err("Failed to call post_socket_cb");
>   		goto error_close;
>   	}
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index 9bc909fa0833..25961ce850cb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> @@ -34,12 +34,18 @@ static int settcpca(int fd, const char *tcp_ca)
>   	return 0;
>   }
>   
> -static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
> +static void do_test(const struct network_helper_opts *opts,
> +		    const struct bpf_map *sk_stg_map)
>   {
> +	struct sockaddr_storage addr;
>   	int lfd = -1, fd = -1;
> +	socklen_t addrlen;
>   	int err;
>   
> -	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> +	if (make_sockaddr(AF_INET6, NULL, 0, &addr, &addrlen))
> +		return;
> +
> +	lfd = start_server_addr(SOCK_STREAM, &addr, addrlen, opts);

It is a tech debt that start_server does not take the "opts" argument.
It is pretty handy to have start_server as a helper that takes string address.

How about create a start_server_str() and start using it in this set. The other 
existing start_server() usages can be retired later.

int start_server_str(int family, int type, const char *addr, __u16 port,
		     const struct network_helper_opts *opts);


