Return-Path: <linux-kselftest+bounces-13334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F5F92AA4E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 22:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC060282F94
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 20:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392B238389;
	Mon,  8 Jul 2024 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QwKkC17W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F6A3BB47
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Jul 2024 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469184; cv=none; b=Y3qRwQEK18ewLwp/0s8qdYke/h+d2d9UMHj9slEkffry3vYauBtFAL78EPsm1ITe56+JbA80YrkqYqAZr8oNYI8eEDY7MZmmcF2xjUTbjRalhvUGV5zTJKBKijrXVcS2VvNunQ6PZ0wivrnZXWFqPqCw1wtc/xmQ7TxCGzjt3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469184; c=relaxed/simple;
	bh=3HqaP1yGUVpCwLBPvaAR3/AnbOS5c5Mo5BDZyBxm318=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/1pOwH3nBHO0IWlvHHXaaf9Oz9sRK+YHVQKxbK4BRytWhO1XXCohYKNfQVnA2lk5D9SrDXXWpGx51ttk5hZEAp2HoD4JuxwNBGrAA19m+tCVO0QZ5aZJWiZ6c+D8MTUTpQnZJsmDk/AZnnD4aCB3XcGCuHeB2S/cvrYiMECuMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QwKkC17W; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720469180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5qzgYdcUDIh4vYXAeJqQNAyma0qIhXueJOEbYdFHhc=;
	b=QwKkC17WM3a+pwvSrfqmokaAV4uTCeWg00enYW3XART3KXflh/PGa5apAo+OB6pGgQK5Ai
	5Vm/L5Klh5GuwuennMWbDXtpihq3vdFYF7aO6Qhz8/k7bDz8BSqTSzfQcwQCzh0+Qq05WE
	8YZ3Gy0eKp7GXiYFWZ5oPJej/nlNPbk=
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: andrii@kernel.org
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
Message-ID: <35634a5d-7e6e-4ab7-8de1-639f1af5fe5f@linux.dev>
Date: Mon, 8 Jul 2024 13:06:12 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 06/12] selftests/bpf: Add expect_errno for
 network_helper_opts
To: Geliang Tang <geliang@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1720405046.git.tanggeliang@kylinos.cn>
 <35ab4f6f094e3c700aa9ec20ee6d6d1a91284b5a.1720405046.git.tanggeliang@kylinos.cn>
 <5bbb91e1270a0d9d51e403847e74912aab95d484.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <5bbb91e1270a0d9d51e403847e74912aab95d484.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/8/24 12:15 PM, Eduard Zingerman wrote:
> On Mon, 2024-07-08 at 10:29 +0800, Geliang Tang wrote:
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
>> index fcda6b2333ad..14d161d35248 100644
>> --- a/tools/testing/selftests/bpf/network_helpers.h
>> +++ b/tools/testing/selftests/bpf/network_helpers.h
>> @@ -24,6 +24,7 @@ typedef __u16 __sum16;
>>   struct network_helper_opts {
>>   	int timeout_ms;
>>   	bool must_fail;
>> +	int expect_errno;
> 
> I think this option obfuscates actual test cases.
> Each helper that accepts network_helper_opts as a parameter, does
> multiple system calls. It is not obvious which of these calls is
> expected to fail.

+1

Please no. On top of that, handling specific errno is not something that belongs 
to the generic network_helpers.c. The individual test should check for the errno 
that it expects on the error path.

Is it for make_client()? The caller of make_client can check the errno instead, no?

[ The same goes for the existing "bool must_fail;" but it can be left for a 
separate cleanup patch ]

pw-bot: cr

> 
>>   	int proto;
>>   	/* The backlog argument for listen(), defines the maximum length to which
>>   	 * the queue of pending connections for sockfd may grow.
> 
> [...]


