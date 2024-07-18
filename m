Return-Path: <linux-kselftest+bounces-13906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BB69370C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 00:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7271C2166D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 22:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0213145A18;
	Thu, 18 Jul 2024 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OwOEyfvs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2280857CB1
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721342336; cv=none; b=LjXryLuF7ldhhL4OJnZX4xXtVuhxOW81CmhZ1Bo0xaS7OvU3jzxCgKHH7bc3w0ejfWDCJ8Vxxmo4Wx3vXoAurEMyKOt6pss916tXAH6sSlSqhwo/ua4Q5BA0o5t+l8PARbspjm4qwOveWKwk/BNYzlxqtzPPi1ZK+WwjlURcxzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721342336; c=relaxed/simple;
	bh=hflvTWoC+8MeCvWNFEsZeu4sCw7bwsGj+7qco/l3u+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUSgmv6fb0/uD2sVe4Cjr7V9ToaJ9PBkux6p6lbD7n7+lGoB/uV8rUlcK0fkwunEINrBy4huOJyZrICRurkXj6enW1dSFTb8KUFebySQohHJ1YtJ0/ViGFnhkLOOJ6CYflrCbjSEZV4W1F+BwFbWZpe0T19Gls5rAZQQfDScfr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OwOEyfvs; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721342333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qaoocFl9pRzqGg05LR4C0nKyWORCpYTZuSFIW/z6/FM=;
	b=OwOEyfvsPvyTb7x3tkNLdtDlSOn2E+rxgnJ9VUoGuWF1tbOPbTt7hQ6j9AXSvwIrp9YHrC
	rysJeuMZNkKW6arkRhsMyVPvc/l1aWhHoLDOGkeiu8Bayw0N5n+NiAzO9x/yHEmnKuh6yw
	DznIecOmVU4yHW5ustDrCtFy1lFOxYM=
X-Envelope-To: andrii@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: mykolal@fb.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: song@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: shuah@kernel.org
X-Envelope-To: tanggeliang@kylinos.cn
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
Message-ID: <12a1051a-1eab-4a5b-a25a-af897dc1b4c0@linux.dev>
Date: Thu, 18 Jul 2024 15:38:47 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 5/5] selftests/bpf: Drop make_socket in
 sk_lookup
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1721282219.git.tanggeliang@kylinos.cn>
 <bab06e6d0f71064dadb43f16e330b9e43fad1c95.1721282219.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <bab06e6d0f71064dadb43f16e330b9e43fad1c95.1721282219.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/17/24 11:22 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Use local helper make_client() in drop_on_lookup(), drop_on_reuseport()
> and run_multi_prog_lookup() instead of using make_socket() + connect().
> Then make_socket() and inetaddr_len() can be dropped.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   .../selftests/bpf/prog_tests/sk_lookup.c      | 58 ++-----------------
>   1 file changed, 6 insertions(+), 52 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> index beea7866b37f..3d1c315841b7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> @@ -108,46 +108,6 @@ static int attach_reuseport(int sock_fd, struct bpf_program *reuseport_prog)
>   	return 0;
>   }
>   
> -static socklen_t inetaddr_len(const struct sockaddr_storage *addr)
> -{
> -	return (addr->ss_family == AF_INET ? sizeof(struct sockaddr_in) :
> -		addr->ss_family == AF_INET6 ? sizeof(struct sockaddr_in6) : 0);
> -}
> -
> -static int make_socket(int sotype, const char *ip, int port,
> -		       struct sockaddr_storage *addr)
> -{
> -	struct timeval timeo = { .tv_sec = IO_TIMEOUT_SEC };
> -	int err, family, fd;
> -
> -	family = is_ipv6(ip) ? AF_INET6 : AF_INET;
> -	err = make_sockaddr(family, ip, port, addr, NULL);
> -	if (CHECK(err, "make_address", "failed\n"))
> -		return -1;
> -
> -	fd = socket(addr->ss_family, sotype, 0);
> -	if (CHECK(fd < 0, "socket", "failed\n")) {
> -		log_err("failed to make socket");
> -		return -1;
> -	}
> -
> -	err = setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeo, sizeof(timeo));
> -	if (CHECK(err, "setsockopt(SO_SNDTIMEO)", "failed\n")) {
> -		log_err("failed to set SNDTIMEO");
> -		close(fd);
> -		return -1;
> -	}
> -
> -	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
> -	if (CHECK(err, "setsockopt(SO_RCVTIMEO)", "failed\n")) {
> -		log_err("failed to set RCVTIMEO");
> -		close(fd);
> -		return -1;
> -	}
> -
> -	return fd;
> -}
> -
>   static int setsockopts(int fd, void *opts)
>   {
>   	struct cb_opts *co = (struct cb_opts *)opts;
> @@ -856,8 +816,7 @@ static void test_redirect_lookup(struct test_sk_lookup *skel)
>   
>   static void drop_on_lookup(const struct test *t)
>   {
> -	struct sockaddr_storage dst = {};
> -	int client_fd, server_fd, err;
> +	int client_fd, server_fd, err = 0;
>   	struct bpf_link *lookup_link;
>   	ssize_t n;
>   
> @@ -870,12 +829,11 @@ static void drop_on_lookup(const struct test *t)
>   	if (server_fd < 0)
>   		goto detach;
>   
> -	client_fd = make_socket(t->sotype, t->connect_to.ip,
> -				t->connect_to.port, &dst);
> +	client_fd = make_client(t->sotype, t->connect_to.ip,
> +				t->connect_to.port, ECONNREFUSED);
>   	if (client_fd < 0)
>   		goto close_srv;
>   
> -	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
>   	if (t->sotype == SOCK_DGRAM) {
>   		err = send_byte(client_fd);
>   		if (err)
> @@ -970,7 +928,6 @@ static void test_drop_on_lookup(struct test_sk_lookup *skel)
>   
>   static void drop_on_reuseport(const struct test *t)
>   {
> -	struct sockaddr_storage dst = { 0 };
>   	int client, server1, server2, err;
>   	struct bpf_link *lookup_link;
>   	ssize_t n;
> @@ -994,12 +951,11 @@ static void drop_on_reuseport(const struct test *t)
>   	if (server2 < 0)
>   		goto close_srv1;
>   
> -	client = make_socket(t->sotype, t->connect_to.ip,
> -			     t->connect_to.port, &dst);
> +	client = make_client(t->sotype, t->connect_to.ip,
> +			     t->connect_to.port, ECONNREFUSED);
>   	if (client < 0)
>   		goto close_srv2;
>   
> -	err = connect(client, (void *)&dst, inetaddr_len(&dst));
>   	if (t->sotype == SOCK_DGRAM) {
>   		err = send_byte(client);
>   		if (err)
> @@ -1209,7 +1165,6 @@ struct test_multi_prog {
>   
>   static void run_multi_prog_lookup(const struct test_multi_prog *t)
>   {
> -	struct sockaddr_storage dst = {};
>   	int map_fd, server_fd, client_fd;
>   	struct bpf_link *link1, *link2;
>   	int prog_idx, done, err;
> @@ -1242,11 +1197,10 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
>   	if (err)
>   		goto out_close_server;
>   
> -	client_fd = make_socket(SOCK_STREAM, EXT_IP4, EXT_PORT, &dst);
> +	client_fd = make_client(SOCK_STREAM, EXT_IP4, EXT_PORT, t->expect_errno);
>   	if (client_fd < 0)
>   		goto out_close_server;
>   
> -	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
>   	if (CHECK(err && !t->expect_errno, "connect",

I haven't looked at the details in run_multi_prog_lookup(). I am quite sure this 
CHECK is wrong or at least unnecessary. "err" does not have the return value of 
connect() now but the t->expect_errno is for connect(), so what is the CHECK 
testing?

imo, burying the errno checking in make_client is confusing.

On top of removing make_socket, lets remove the make_client() also. Directly 
call connect_to_addr_str() instead. The caller of connect_to_addr_str() can 
handle the returned fd and errno. The drop_on_{lookup, reuseport} should handle 
them differently based on SOCK_STREAM or SOCK_DGRAM.

In the next respin, please take time to change the error handling properly after 
the refactoring/cleanup.

I am going to apply patch 1-3 with the small nits related to "log_err" in patch 2.


