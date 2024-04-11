Return-Path: <linux-kselftest+bounces-7735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6748A219C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 00:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407BA2829DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 22:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E1B3D0D0;
	Thu, 11 Apr 2024 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KofOAfKU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C353BBC3
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873469; cv=none; b=Jb/rqGXZ6GrCGQ0KQx13ix5PYrvwGLcJqkApvxVoDKpG9qY0/SFEE21kdJ8bJenUOVwl5e/2CazSdASo0gvDTkI/P1yfsUpzAnfQ3cAXjB+lp+UcvhvWQlQVGaQHF0gamGcbjVTZXRF2AdDmIjVbuhK5BsNnbgZJCklBc/CJYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873469; c=relaxed/simple;
	bh=YovsqAjWOCgiX3y7T70jgLTQVBbxF5anD9vAfnfYdhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=miWsDP89FKlFI6t4GXjdLwZpxNL3eYYp3JDA6o+bJofVA6/+rxEkTn6ceA27XDar0ciTXr6p7Q39mbDYKhc/J8COrBe6QiEozJsEuaiMVksuBnlgw9T5NNFLU1Of6NlW0ZZzP0gHWxXQbNWLbpmJFNLKQPwUT4I/Z/tNuEgt92Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KofOAfKU; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4d19829e-6e96-445f-8e2a-47f58b921281@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712873464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfS9cBg99UiFImxcmuWdb++52NGG618WTFy3c2EUH2g=;
	b=KofOAfKUsTJDEgaAXM9gbut2zlXhSB4zn9jN4bmjnTDzX6rKzBVihrjsnYSOXOw/CYkza/
	5dsWdKdN0nVGoN2bk8cs3VEQ+xLgCc0iFebXGKJ1bzQ4TGkCR4lXOTcuHgAZQy1uUDqKsz
	pV0JPGbnXUsH82+2m7txubW7xItCrc8=
Date: Thu, 11 Apr 2024 15:10:56 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 11/14] selftests/bpf: Use
 start_server_setsockopt in sockopt_inherit
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1712796967.git.tanggeliang@kylinos.cn>
 <cf65883b5ad52bfe99e0dc02b6213aa0eaf51ead.1712796967.git.tanggeliang@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <cf65883b5ad52bfe99e0dc02b6213aa0eaf51ead.1712796967.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/10/24 6:03 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Include network_helpers.h in prog_tests/sockopt_inherit.c, use public
> helpers make_sockaddr() and start_server_setsockopt() instead of the
> local defined function start_server(). This can avoid duplicate code.
> 
> Add a helper setsockopt_loop() to set SOL_CUSTOM sockopt looply, and
> pass it to start_server_setsockopt().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   .../bpf/prog_tests/sockopt_inherit.c          | 33 ++++++++-----------
>   1 file changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
> index 917f486db826..f000d9229765 100644
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
> +static int setsockopt_loop(int fd, int val)
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
> @@ -125,13 +115,18 @@ static int start_server(void)
>   		}
>   	}
>   
> -	if (bind(fd, (const struct sockaddr *)&addr, sizeof(addr)) < 0) {
> -		log_err("Failed to bind socket");
> -		close(fd);
> -		return -1;
> -	}
> +	return 0;
> +}
>   
> -	return fd;
> +static int start_server_lo(void)
> +{
> +	struct sockaddr_storage addr;
> +	socklen_t addrlen;
> +
> +	if (make_sockaddr(AF_INET, "127.0.0.1", 0, &addr, &addrlen))
> +		return -1;
> +	return start_server_setsockopt((struct sockaddr *)&addr, addrlen,
> +				       SOCK_STREAM, (void *)setsockopt_loop, 0);

The start_server_setsockopt is only limited to integer socket option. It is not 
very flexible. It seems this is the only test that will be useful. Lets drop 
start_server_setsockopt addition from this set for now and discuss it separately.

>   }
>   
>   static void run_test(int cgroup_fd)
> @@ -160,7 +155,7 @@ static void run_test(int cgroup_fd)
>   	if (!ASSERT_OK_PTR(link_setsockopt, "cg-attach-setsockopt"))
>   		goto close_bpf_object;
>   
> -	server_fd = start_server();
> +	server_fd = start_server_lo();
>   	if (!ASSERT_GE(server_fd, 0, "start_server"))
>   		goto close_bpf_object;
>   


