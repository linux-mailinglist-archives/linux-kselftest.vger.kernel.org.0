Return-Path: <linux-kselftest+bounces-13257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A38928F02
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 23:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678EF1F23888
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 21:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE37146A73;
	Fri,  5 Jul 2024 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uNUukQjs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95AA145B12
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Jul 2024 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720216586; cv=none; b=ZRZTH3iMKgEHj0VXZ9jxM4PfVddpxEM16GbEKkbl6RvnKNaecloiGsmLeq7wWumMjI/bZNC1p9i+wzdn7R0GLE1OkH83FPVBcEY0fhTUV7nO8Ag42U5ONXaxh88WdGkcP4s/NkJN4+97DPQYRuoa5gNnmQKh3s/0Jwv9C3nP3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720216586; c=relaxed/simple;
	bh=nqaR1I9n7ng4ip76SwjbMFemVkPYXVERph0gLZ1Lnpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ay5lqIOR/PN61QAgpCFk+XOcUTLcobyS+weaiqRSTJ7jhHj7/RnWvkQoNpbKS6YeWkYfVUBTaF4aMmmCATZgu4jKjTDUC/yCnSXnvQOS6/dlap7T0UqrJ3m+0KakMEHAclj+v3G8nSh6Kj2KAbyV9Iz7tsjfFEyu4anaTJ2R9LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uNUukQjs; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720216580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZjkzDLhOWC5TiqV7wP3afmt0lky41yiZoAy/lDnU3M=;
	b=uNUukQjsaDZ/Wmm170QH/YNepK/2rwHJLh6DU9Hajgrlnq/iW8uK8iczjQuoxTAsvmAoZU
	YaBwjV4OC+o4NJ8N+89rLyEGx9SA1ILLfEZCKsNrFkeR8uYszHPhlYS+uQfvgUO+X+ZFf2
	kX9wnNcfkPE2GTOu3VF30q5OJF8vOF4=
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
Message-ID: <460ec092-32da-4e8d-a5e6-4ea6e8091b09@linux.dev>
Date: Fri, 5 Jul 2024 14:56:11 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 8/9] selftests/bpf: Use connect_to_addr in
 sk_lookup
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
References: <cover.1720147952.git.tanggeliang@kylinos.cn>
 <52c22148c66184baf5ba09d60c06d49a8a33d743.1720147953.git.tanggeliang@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <52c22148c66184baf5ba09d60c06d49a8a33d743.1720147953.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/4/24 7:58 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Use public network helpers make_sockaddr() and connect_to_addr() instead
> of using the local defined function make_socket() and connect().
> 
> This make_socket() can be dropped latter.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   .../selftests/bpf/prog_tests/sk_lookup.c      | 22 ++++++++-----------
>   1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> index ef4a3db34c5f..a436ed8b34e0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> @@ -231,23 +231,19 @@ static int make_server(int sotype, const char *ip, int port,
>   
>   static int make_client(int sotype, const char *ip, int port)
>   {
> +	int family = is_ipv6(ip) ? AF_INET6 : AF_INET;
> +	struct network_helper_opts opts = {
> +		.timeout_ms = IO_TIMEOUT_SEC,
> +	};
>   	struct sockaddr_storage addr = {0};
> -	int err, fd;
> +	socklen_t len;
> +	int err;
>   
> -	fd = make_socket(sotype, ip, port, &addr);
> -	if (fd < 0)
> +	err = make_sockaddr(family, ip, port, &addr, &len);
> +	if (!ASSERT_OK(err, "make_sockaddr"))
>   		return -1;
>   
> -	err = connect(fd, (void *)&addr, inetaddr_len(&addr));
> -	if (CHECK(err, "make_client", "connect")) {
> -		log_err("failed to connect client socket");
> -		goto fail;
> -	}
> -
> -	return fd;
> -fail:
> -	close(fd);
> -	return -1;
> +	return connect_to_addr(sotype, &addr, len, &opts);

You mentioned in v7 that ASSERT on the return value of the connect_to_addr() 
breaks the test.

However, the original code does CHECK which calls test__fail(). There are 
multiple tests call make_client() and some of them don't expect make_client() to 
fail. It is obvious that the failure will be hidden without the ASSERT. 
Something else needs to be adjusted for this refactoring. Please take a closer 
look first instead of hiding the potential future errors to pass the CI.

pw-bot: cr

>   }
>   
>   static __u64 socket_cookie(int fd)


