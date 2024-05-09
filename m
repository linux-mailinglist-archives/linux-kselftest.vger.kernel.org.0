Return-Path: <linux-kselftest+bounces-9897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DD58C17F6
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC69428125C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E262C82876;
	Thu,  9 May 2024 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sUGgyUTR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473BF82863
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287926; cv=none; b=BGaoUhx3r7apiHkhz1JwRZr7+qDsMxbo8HWrx6Qb5vg/Vk65Er3po0cwjUHaiRjzAv9D7qvrtS5zNdnAf2pZmc4FgToBUWPZC9MxKqkuNkKb3AECvoibREqrrxw1qsyf+PzmTSfj9f05U5gzYeVsP5EGK8kcwxWhFAxtpdS508U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287926; c=relaxed/simple;
	bh=8GKdlnhEh2sJ7tP4geEyRalZJQ9pIGkChfeP+/lJ+5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iv1VMAYhY7BWvOwkdnqbzcXDUqs7ZllzoydCatd9oFfgfgCBEFFUXALMAyVuwzWl8pDjI2Y4rspymyj+bFStrpgprBi+7GsAnEHB5dc9m8kDplxoLBVB+DDVj7aBiKnah3ZxTWT4NWPrg7Mt4I2pwfrE3F42ncdxk1kYcSokexU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sUGgyUTR; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fbdc9729-0c48-4894-858f-d294502c4032@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715287921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xd5tz04LEJEZwJBrn5k92cQ8p5d0btGjHa23s560374=;
	b=sUGgyUTR4QmLr4e2wDwsg60mxpImCOFZULp5fq6hDXmNj98FMqrRkNVm9jonOF5YvoQikM
	heqoU0OScsfIAXQQDhoLt/s3r5GDenHLd2ZzGgpAv5beBVp7wfd18LhUW1zKKC/Mwlvuk7
	wOXTbcg6dvBXwHxHuTfBK8y/gy5Zx9w=
Date: Thu, 9 May 2024 13:51:54 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/6] selftests/bpf: Use start_server_addr in
 sockopt_inherit
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
 <687af66f743a0bf15cdba372c5f71fe64863219e.1714907662.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <687af66f743a0bf15cdba372c5f71fe64863219e.1714907662.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/5/24 4:35 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Include network_helpers.h in prog_tests/sockopt_inherit.c, use public
> helper start_server_addr() instead of the local defined function
> start_server(). This can avoid duplicate code.
> 
> Add a helper custom_cb() to set SOL_CUSTOM sockopt looply, set it to
> post_socket_cb pointer of struct network_helper_opts, and pass it to
> start_server_addr().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   .../bpf/prog_tests/sockopt_inherit.c          | 32 +++++++------------
>   1 file changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
> index 917f486db826..ff0694ef5286 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include <test_progs.h>
>   #include "cgroup_helpers.h"
> +#include "network_helpers.h"
>   
>   #include "sockopt_inherit.skel.h"
>   
> @@ -98,23 +99,12 @@ static void *server_thread(void *arg)
>   	return (void *)(long)err;
>   }
>   
> -static int start_server(void)
> +static int custom_cb(int fd, const struct post_socket_opts *opts)
>   {
> -	struct sockaddr_in addr = {
> -		.sin_family = AF_INET,
> -		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
> -	};
>   	char buf;
>   	int err;
> -	int fd;
>   	int i;
>   
> -	fd = socket(AF_INET, SOCK_STREAM, 0);
> -	if (fd < 0) {
> -		log_err("Failed to create server socket");
> -		return -1;
> -	}
> -
>   	for (i = CUSTOM_INHERIT1; i <= CUSTOM_LISTENER; i++) {
>   		buf = 0x01;
>   		err = setsockopt(fd, SOL_CUSTOM, i, &buf, 1);

There is a close(fd) on the error case a few lines below (not in this diff 
context). The caller (network_helpers.c) will also close it. I removed the 
close(fd) from the custom_cb() here.

Thanks for the patches. Applied.

> @@ -125,20 +115,21 @@ static int start_server(void)
>   		}
>   	}
>   
> -	if (bind(fd, (const struct sockaddr *)&addr, sizeof(addr)) < 0) {
> -		log_err("Failed to bind socket");
> -		close(fd);
> -		return -1;
> -	}
> -
> -	return fd;
> +	return 0;
>   }
>   


