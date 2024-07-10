Return-Path: <linux-kselftest+bounces-13499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CFC92D8BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 21:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DF11C21DAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 19:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44169197549;
	Wed, 10 Jul 2024 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WeshQ2Tq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A57619347B
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638281; cv=none; b=bSaGzLaXwPRf6CzOSatIH0TbXXypUVMF8MDX0SKLPodtJa4hhL8pQlPiCotj5f5M82rFLCb8zDk83iY5h5AJlZyRt0mSyX/L0MtQRq0tXdBA+EJ+Vupt2EZ2Tltqf+h0FkdS3aCLqlGuKEp2hwVbhhtxkX5vsMOEQTn2ymqa4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638281; c=relaxed/simple;
	bh=ZiOhbA1u5BelG2kEnTBkDnUpISDK0zTiAvPW0PWoiRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cY4t+B4hGR+1LoPBh66xukuUapZmlnXOQvcXM1JNa6xdL9ve14g75iin45x2U0mRX4Hw1aaUMIwEjqGhS4VWV5wqTpweBoZPximZdt5HfVtqisi3qJpx8aYf2SmHfbc7luXNVvjquBrEy524QgqEbwh+pHQTkInpptdkdYgAsvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WeshQ2Tq; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720638277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKoLL9NsNM6lKR0E5gO2maHkZ/FbQ4Wt0lGqlaDmq9Y=;
	b=WeshQ2TqjsFjHJeIRCKiSPIYvkcbhtXQfnsR6pQUE1LG0hdB6iwjyhZYk+tB6ADoeH6jpF
	SBiekcvF9MFx31srbQWrEF6LBERW9kNQulf+4eGH4nfsbdiYsgroVKnh22B0SYVcxSwWVQ
	XwWyOVhjPa9Ws8mhbrR2b3pK9BvZRyY=
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
X-Envelope-To: sdf@fomichev.me
Message-ID: <18302cf6-8861-4bc5-83b8-323a49ad057e@linux.dev>
Date: Wed, 10 Jul 2024 12:04:29 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 6/9] selftests/bpf: Use connect_fd_to_fd in
 sk_lookup
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>
References: <cover.1720515893.git.tanggeliang@kylinos.cn>
 <7077c277cde5a1864cdc244727162fb75c8bb9c5.1720515893.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <7077c277cde5a1864cdc244727162fb75c8bb9c5.1720515893.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/9/24 2:16 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch uses public helper connect_fd_to_fd() exported in
> network_helpers.h instead of using getsockname() + connect() in
> run_lookup_prog() in prog_tests/sk_lookup.c. This can simplify
> the code.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> index 386e482be617..ad3f943cc2bd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> @@ -633,9 +633,6 @@ static void run_lookup_prog(const struct test *t)
>   	 * BPF socket lookup.
>   	 */
>   	if (t->reuseport_has_conns) {
> -		struct sockaddr_storage addr = {};
> -		socklen_t len = sizeof(addr);
> -
>   		/* Add an extra socket to reuseport group */
>   		reuse_conn_fd = make_server(t->sotype, t->listen_at.ip,
>   					    t->listen_at.port,
> @@ -643,12 +640,8 @@ static void run_lookup_prog(const struct test *t)
>   		if (reuse_conn_fd < 0)
>   			goto close;
>   
> -		/* Connect the extra socket to itself */

This comment is still valid after this change.

> -		err = getsockname(reuse_conn_fd, (void *)&addr, &len);
> -		if (CHECK(err, "getsockname", "errno %d\n", errno))
> -			goto close;
> -		err = connect(reuse_conn_fd, (void *)&addr, len);
> -		if (CHECK(err, "connect", "errno %d\n", errno))
> +		err = connect_fd_to_fd(reuse_conn_fd, reuse_conn_fd, 0);
> +		if (!ASSERT_OK(err, "connect_fd_to_fd"))
>   			goto close;
>   	}
>   


