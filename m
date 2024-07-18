Return-Path: <linux-kselftest+bounces-13903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCD6937031
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 23:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C3E282090
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 21:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1D48286A;
	Thu, 18 Jul 2024 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DoL9Q0ge"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F61478B60
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721339113; cv=none; b=lpsgh2e+LY+U8fOjbDck0+NKWQrs4tRXCyxL/Yob40D+IZ0thIbEpvBb8JwhXIDIR+pVyTdiQEyhHod3eM+MdQuDwSrX1PqNYNheh8xV1r/Q9DNvJAHaWho7lLiSdCxIAk0vo5YuE0JqOJLDyMDdHKQ3G9epewZl7TxdYtThEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721339113; c=relaxed/simple;
	bh=KHP5aBxnHzU2CH0cYkN94EtH2zXXduM0nlL9LwT6TcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m06zWlj6i2FBreRsDnTlsR27ezeD6aShIV6mD4oYcLbKvOJBo13lPWGdAsMajv+XqvH+x2sbP9kSJVD4wfL7XV73K52ZpqJyp0ty3UgMCVMhyj+7qLlN/wKCQpnwOOVAc3W1u6vZ7bPYRXAOkjH1Dq3Plv5mHG9IXdkLHmt+6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DoL9Q0ge; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721339109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9kOU8zyFItXfyWIS1C2bhk4F+Co2ex/wi3LAwR9izc=;
	b=DoL9Q0gelxvtPqpLoejxMJibSRtSWH0CBEFmmAFKvi7mvxKeRtvHweXk6ld7ARqwXCV4qx
	OYwIqKQO8ra2ES/o1Yt1CrXiz/mAGd83TPHNy2YlHMEpVKBxQ1qkBFuPk8/y9TMAkJtoz4
	nWa9OuzjwYxNwsdKdsZKrygIgk0/QEs=
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
Message-ID: <6f22c8bc-8681-4027-a69a-492f418f04e0@linux.dev>
Date: Thu, 18 Jul 2024 14:45:03 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/5] selftests/bpf: Use connect_to_addr_str in
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
 <a41193347fc775f934b60ad8e2dca4cf04177127.1721282219.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <a41193347fc775f934b60ad8e2dca4cf04177127.1721282219.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/17/24 11:22 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch uses the new helper connect_to_addr_str() in make_client()
> instead of using local defined function make_socket() + connect(). This
> local function can be dropped latter.
> 
> A new parameter "expect_errno" is added for make_client() too to allow
> different "expect_errno" is passed to make_client(). It is used to check
> with "errno" after invoking connect_to_addr_str().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   .../selftests/bpf/prog_tests/sk_lookup.c      | 26 +++++++------------
>   1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> index ae87c00867ba..beea7866b37f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> @@ -229,25 +229,19 @@ static int make_server(int sotype, const char *ip, int port,
>   	return -1;
>   }
>   
> -static int make_client(int sotype, const char *ip, int port)
> +static int make_client(int sotype, const char *ip, int port, int expect_errno)
>   {
> -	struct sockaddr_storage addr = {0};
> -	int err, fd;
> -
> -	fd = make_socket(sotype, ip, port, &addr);
> -	if (fd < 0)
> -		return -1;
> +	int fd;
>   
> -	err = connect(fd, (void *)&addr, inetaddr_len(&addr));
> -	if (CHECK(err, "make_client", "connect")) {
> +	fd = connect_to_addr_str(is_ipv6(ip) ? AF_INET6 : AF_INET,
> +				 sotype, ip, port, NULL);
> +	if (CHECK(fd < 0 && (!expect_errno || errno != expect_errno),
> +		  "make_client", "connect_to_addr_str")) {
>   		log_err("failed to connect client socket");
> -		goto fail;
> +		return -1;
>   	}
>   
>   	return fd;
> -fail:
> -	close(fd);
> -	return -1;
>   }
>   
>   static __u64 socket_cookie(int fd)
> @@ -646,7 +640,7 @@ static void run_lookup_prog(const struct test *t)
>   			goto close;
>   	}
>   
> -	client_fd = make_client(t->sotype, t->connect_to.ip, t->connect_to.port);
> +	client_fd = make_client(t->sotype, t->connect_to.ip, t->connect_to.port, 0);
>   	if (client_fd < 0)
>   		goto close;
>   
> @@ -1152,7 +1146,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
>   	if (server_fd < 0)
>   		return;
>   
> -	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT);
> +	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT, 0);
>   	if (connected_fd < 0)
>   		goto out_close_server;
>   
> @@ -1166,7 +1160,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
>   		goto out_close_connected;
>   
>   	/* Try to redirect TCP SYN / UDP packet to a connected socket */
> -	client_fd = make_client(sotype, EXT_IP4, EXT_PORT);
> +	client_fd = make_client(sotype, EXT_IP4, EXT_PORT, 0);

No errno is expected in all these cases. directly call connect_to_addr_str() 
instead of calling make_client.

>   	if (client_fd < 0)
>   		goto out_unlink_prog;
>   	if (sotype == SOCK_DGRAM) {


