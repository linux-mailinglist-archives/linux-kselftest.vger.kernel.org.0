Return-Path: <linux-kselftest+bounces-8287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D085F8A8FE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 02:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B508282360
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 00:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC434181;
	Thu, 18 Apr 2024 00:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J7Sg8i5x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD2376
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 00:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399362; cv=none; b=THRZh8YmuqtZVgllfwm1Lzg4OxrlRUqADReWb+25xd0fZeaNLSlZUFZDjpvUP5yf4gZWOSjSkTRzhu/zYKUX+0xq2HhhnfOY9TlSsrOM/vOH6CqKzGrnVvGVo0CeHi37MWcNOw1Eui0uYNR3HcLxzqQIqLt3GK1Y74Mp7OH5g10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399362; c=relaxed/simple;
	bh=o1xkt8wUyN4PWItU746ccnK3CBHkubQxIGktOE5spck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pF8EebiczIl1etqywrH6ABQHU6vDPpL73yFCnACwX8fQ8tyqLUmyCnMx/adIjHe6plAZ66tgOZHXmiXunKlGxH614Z58eUsBm4lsOJUtmWCDA+uv0Qy9ZgFvM03Yga5AjPvlQ9g1XMnyosGWE+F0DRMe4Crpha+6B3Mt+xO7kZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J7Sg8i5x; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1eb9a17e-ae76-4082-9ac1-2f7a71063483@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713399359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrZU8kD0+IMsJ9et7JJBL/IecKY4dehOEs9MDO/8u48=;
	b=J7Sg8i5xUUUJXTZmwRoDoBYEXCb6DnFA/twespeppRxFB4Ate1nYL2yXkSb2SM2recP/Nb
	/tCouBZJx4bL4wv1i6FTQfI1uPGkWUHdPDJKINTmRwwmuXbRjJ4VzGCMqKEDB45hAbC1E4
	UewMR8KtsOIZOO2ml57Axe/JJUuOD8M=
Date: Wed, 17 Apr 2024 17:15:51 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 06/14] selftests/bpf: Use connect_to_addr in
 sk_assign
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Eduard Zingerman <eddyz87@gmail.com>
References: <cover.1713262052.git.tanggeliang@kylinos.cn>
 <b918f3e9b4f5cac694982add59e4da575516b9e7.1713262052.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <b918f3e9b4f5cac694982add59e4da575516b9e7.1713262052.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/16/24 3:13 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch uses public helper connect_to_addr() exported in
> network_helpers.h instead of the local defined function connect_to_server()
> in prog_tests/sk_assign.c. This can avoid duplicate code.
> 
> The code that sets SO_SNDTIMEO timeout as timeo_sec (3s) can be dropped,
> since connect_to_addr() sets default timeout as 3s.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   .../selftests/bpf/prog_tests/sk_assign.c      | 26 +------------------
>   1 file changed, 1 insertion(+), 25 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> index fa8f757c0edd..766fc56f5fc7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> @@ -23,8 +23,6 @@
>   #define NS_SELF "/proc/self/ns/net"
>   #define SERVER_MAP_PATH "/sys/fs/bpf/tc/globals/server_map"
>   
> -static const struct timeval timeo_sec = { .tv_sec = 3 };
> -static const size_t timeo_optlen = sizeof(timeo_sec);
>   static int stop, duration;
>   
>   static bool
> @@ -74,28 +72,6 @@ configure_stack(void)
>   	return true;
>   }
>   
> -static int
> -connect_to_server(const struct sockaddr *addr, socklen_t len, int type)
> -{
> -	int fd = -1;
> -
> -	fd = socket(addr->sa_family, type, 0);
> -	if (CHECK_FAIL(fd == -1))
> -		goto out;
> -	if (CHECK_FAIL(setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeo_sec,
> -				  timeo_optlen)))

I think Eduard has also pointed out in v2 that the existing connect_to_addr() 
does not set the timeout and suggested to add the opts arg also.

One option is to just modify the connect_to_addr() to set the default timeout 
(3s) without needing to add the opts arg. Since we are changing the signature of 
connect_to_addr() anyway, lets just add the opts argument also. When opts is 
NULL or opts->timeout_ms is 0, then use the default 3s timeout like other 
helpers do.

something like,

int connect_to_addr(int type, const struct sockaddr_storage *addr,
		    socklen_t addrlen, const struct network_helper_opts *opts);



