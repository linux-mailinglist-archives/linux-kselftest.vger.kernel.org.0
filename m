Return-Path: <linux-kselftest+bounces-13633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4791392F33E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 02:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDED1F225CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 00:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D5C624;
	Fri, 12 Jul 2024 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="USrEnTyi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C626FB0
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2024 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720745854; cv=none; b=ngFMCCg3fjIQyYR4J2XyBnQkf3SGKKkiv0BVBuV8UOvehjU+vccOnQ0shCJ+Gng0vaE7HUs02UVuIbliBz0dsl9JkTCV1mKHSO/5yvHUqRM9Dz7bKJXaVroGvwmUcyGOFoihHDhuE8URgmV+1HH+4tyol1sOqks3q3fZsAAHzrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720745854; c=relaxed/simple;
	bh=WrlXniTsoAnX8gw4RZuBgsAOqCOZBaGa4aZ9y9pTW1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUNsmPnucWhGn7CKR2+V68eQa4Oprntbd8kmNqvn+GN34Fi6toCjRAJmglSQ8KZbkAXL3ZAcTf0wOzX8MI9/I7vfxJeRhC7GUtphglzwnTLFtGeEAcq+T2pTsmjFwmLfbm1/DIIRL5uuzyl1Xu5GVgcNearidIbLhnC4ggO4BCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=USrEnTyi; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720745849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbgq3lN0h4Yn3IUr5jBhW81RXKB35fGAxj6bEe+wND4=;
	b=USrEnTyimhbBAr3CD61UgpzfcX2BVzBXcHNWkC1Y+YwOm+dNqlwKMxr6SiGCn4m/4eusmO
	0mZVfA2SPRCCoAjOYvgOdFne1VLl+wQsaX/vFA7XpLO/qBqgWqCnXzB16DU6nkXpxtIlax
	heCAdHCYTW4dDbrI1GBJNmR/JxRPpIA=
X-Envelope-To: tanggeliang@kylinos.cn
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
X-Envelope-To: martin.lau@kernel.org
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
Message-ID: <24449fad-b1c3-494c-a220-2161d566e5f9@linux.dev>
Date: Thu, 11 Jul 2024 17:57:20 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: Drop must_fail from
 network_helper_opts
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <cover.1720664658.git.tanggeliang@kylinos.cn>
 <009c7c136773462cc71c73ed8da84d58df2e1e3f.1720664658.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <009c7c136773462cc71c73ed8da84d58df2e1e3f.1720664658.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/10/24 7:52 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The struct member "must_fail" of network_helper_opts() is only used in
> cgroup_v1v2 tests, it makes sense to drop it from network_helper_opts.
> 
> Return value (fd) of connect_to_fd_opts() and the expect errno (EPERM)
> can be checked in cgroup_v1v2.c directly, no need to check them in
> connect_fd_to_addr() in network_helpers.c.
> 
> This also makes connect_fd_to_addr() function useless. It can be replaced
> by connect().
> 
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/network_helpers.c | 31 ++-----------------
>   tools/testing/selftests/bpf/network_helpers.h |  1 -
>   .../selftests/bpf/prog_tests/cgroup_v1v2.c    |  6 ++--
>   3 files changed, 4 insertions(+), 34 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 15e0e0bb7553..48c27c810db7 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -277,33 +277,6 @@ int client_socket(int family, int type,
>   	return -1;
>   }
>   
> -static int connect_fd_to_addr(int fd,
> -			      const struct sockaddr_storage *addr,
> -			      socklen_t addrlen, const bool must_fail)
> -{
> -	int ret;
> -
> -	errno = 0;
> -	ret = connect(fd, (const struct sockaddr *)addr, addrlen);
> -	if (must_fail) {
> -		if (!ret) {
> -			log_err("Unexpected success to connect to server");
> -			return -1;
> -		}
> -		if (errno != EPERM) {
> -			log_err("Unexpected error from connect to server");
> -			return -1;
> -		}
> -	} else {
> -		if (ret) {
> -			log_err("Failed to connect to server");
> -			return -1;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>   int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
>   		    const struct network_helper_opts *opts)
>   {
> @@ -318,7 +291,7 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
>   		return -1;
>   	}
>   
> -	if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
> +	if (connect(fd, (const struct sockaddr *)addr, addrlen))
>   		goto error_close;
>   
>   	return fd;
> @@ -383,7 +356,7 @@ int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
>   		return -1;
>   	}
>   
> -	if (connect_fd_to_addr(client_fd, &addr, len, false))
> +	if (connect(client_fd, (const struct sockaddr *)&addr, len))
>   		return -1;
>   
>   	return 0;
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index 5b548c0c60de..f39eeb5a4594 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -23,7 +23,6 @@ typedef __u16 __sum16;
>   
>   struct network_helper_opts {
>   	int timeout_ms;
> -	bool must_fail;
>   	int proto;
>   	/* +ve: Passed to listen() as-is.
>   	 *   0: Default when the test does not set
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
> index addf720428f7..eda67b629c67 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
> @@ -9,9 +9,7 @@
>   
>   static int run_test(int cgroup_fd, int server_fd, bool classid)
>   {
> -	struct network_helper_opts opts = {
> -		.must_fail = true,
> -	};
> +	struct network_helper_opts opts = {};
>   	struct connect4_dropper *skel;
>   	int fd, err = 0;
>   
> @@ -33,7 +31,7 @@ static int run_test(int cgroup_fd, int server_fd, bool classid)
>   	}
>   
>   	fd = connect_to_fd_opts(server_fd, &opts);
> -	if (fd < 0)
> +	if (fd < 0 && errno != EPERM)


The if test is incorrect.

>   		err = -1;
>   	else
>   		close(fd);

Beside close(-1) which is not good, it does not treat an OK_FD as an error and 
that is the whole test trying to catch.

pw-bot: cr


