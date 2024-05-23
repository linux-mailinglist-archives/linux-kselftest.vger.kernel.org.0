Return-Path: <linux-kselftest+bounces-10629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEEB8CDA65
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 21:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5841F21CE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 19:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE538289E;
	Thu, 23 May 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SrkRVSXj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6ED82863
	for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491200; cv=none; b=ggVvsW0g7tzjn9Jfja/2ND1Q6c6TpYe6xJyGJu0ChRH1GD/uFCoQ/Bgvza76ftiYl4KH8gJEzK/XJ/2mQ+j5z7AaIFEHVXfnu02ZOSPfqNcKUPj/fc9ryzcnD2qsBwGE1EjUDRHbl1Ffs/7Rwq2C0DOeePxq5x3QKMVs3WSXeCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491200; c=relaxed/simple;
	bh=j3flo5l00FtdW96ZfTYmz3Ii+MzBsr13pNH0ETvfftg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BF0kck7T/U2fl8fWz6JS/Pd0BbRXA6A2O2e3Z3jqI4lVFhT0rslBq/a9Oe2mEFkESXbd4VZx5wUm3lGeXkIzut/2Ef6yRzxXD33MERVpjrPs7soU/o/ZXsDjg6ZgjbhDxi2n9cMzCsOmF9MZagRiolMmv9AfZyUfrqdlEGkH0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SrkRVSXj; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716491196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gd8SEEEwJ/GbynmyIxCgVpoqrktcLO7iOrDAG1e0Zeo=;
	b=SrkRVSXjJYHgDqTioVSSWUFlF0MHU3yIhgHILFvCjuqxE5TaQ6F/snGsR0tPouy+1FX7mc
	FdcFBlpcTZbW2blsxeHfOjdb1yJCqp+s2eo5L4uMbqH8OWaFrU8Nc4VfssiRZB5CR3pSEh
	voR08CHyQQwA5anLKsN43C/t3g7b1zk=
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
Message-ID: <5c6beff5-2fb0-489b-917d-688a98f51175@linux.dev>
Date: Thu, 23 May 2024 12:06:29 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/8] selftests/bpf: Drop type parameter of
 start_server_addr
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
References: <cover.1716369375.git.tanggeliang@kylinos.cn>
 <65dd42dd91d678740e9c05e32852f5e01ba2b7bc.1716369375.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <65dd42dd91d678740e9c05e32852f5e01ba2b7bc.1716369375.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/22/24 2:23 AM, Geliang Tang wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> index 0b9bd1d6f7cc..517d1186e386 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> @@ -255,6 +255,9 @@ void test_sk_assign(void)
>   
>   	for (i = 0; i < ARRAY_SIZE(tests) && !READ_ONCE(stop); i++) {
>   		struct test_sk_cfg *test = &tests[i];
> +		struct network_helper_opts opts = {
> +			.type = test->type,

I think dropping the type arg from the start_server_addr (and other existing 
helpers) is wrong.

"type" is the common case that tests usually want to specify here (at least 
between SOCK_STREAM and SOCK_DGRAM). It becomes optional (opts) now and have a 
more complicated way to pass it to the the start_server_addr, connect_to_addr...etc.

imo, the opts.{type, proto, noconnect} is at least a bit non intuitive or 
unnecessary. The only use case now is in test_bpf_ip_check_defrag_ok which ends 
up bypassing most (or at least some) of the connect_to_fd_opts() logic. May be 
that test should have its own connect_to_fd_opts() instead. However, lets leave 
this potential cleanup out for later and not complicate this set further.

Please keep type as the individual arg to the helper functions.

pw-bot: cr

> +		};
>   		const struct sockaddr *addr;
>   		const int zero = 0;
>   		int err;
> @@ -263,9 +266,8 @@ void test_sk_assign(void)
>   			continue;
>   		prepare_addr(test->addr, test->family, BIND_PORT, false);
>   		addr = (const struct sockaddr *)test->addr;
> -		server = start_server_addr(test->type,
> -					   (const struct sockaddr_storage *)addr,
> -					   test->len, NULL);
> +		server = start_server_addr((const struct sockaddr_storage *)addr,
> +					   test->len, &opts);


