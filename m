Return-Path: <linux-kselftest+bounces-10004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3697D8C2310
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 13:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E631B28289E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 11:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC5B16DEAA;
	Fri, 10 May 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UakbpR3T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7377454662;
	Fri, 10 May 2024 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340032; cv=none; b=BxIdXOD/kLZdPyUL0BrULxMPVeAIF9vF/isuQxVWiyJkKHPvbd5uQItNpW5jazJQEQ8zhgX+nIjBCif8ghY+f0LymWQOhmaTb9IiY+EJ6EpBB/9AagHyUaZYr+W6gY0/wqmGIACQD73ogDW5O8Drtc6yGUcWnXOKooRNrSmVuNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340032; c=relaxed/simple;
	bh=SQwwA9wyysyHiNBB6w7RkMHU+mPG8xq/RDeviEh9MXk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W9rxC5ohYPzWO4VHFVDfRPDUWJFkHi2MbdSPTwObIjw555J3GJ9sqcuBd8qBMr46gInxElgLKfD3G4c5esZJYtj93bqM81IHuh5vHM2OqxcFE/+N9BdeNeSrUKybs/LZH5e56VcWxxgoRBHcQJRUx761t68Nz0NxQ8TZbJMMlek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UakbpR3T; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715340028;
	bh=SQwwA9wyysyHiNBB6w7RkMHU+mPG8xq/RDeviEh9MXk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=UakbpR3TJ28+qmztK/kRuEiv8VQ5JVn1O6Jh7oooZ9E1tiL2jCwl/mNZST9Z6PfvX
	 0oNJl2CdZydIeWA0a1ADrgggike+lcNMHOVGx37r3yZTtIhpAHfAczi8HYo4q6WNl7
	 bcBNFxKBJQT4dv/xuygREoM3eVIR36PcYwffLfgmrEhAywD5/Waps3TM4e1bH7kgwR
	 /YcMQreBEyJ81Cn+etuDplvnpRltof+YudwKi0cN8FsDuToxBvo0hlaSaTjq3f8BH7
	 AAdSI7Y8XMzGt/PC5CFhQN8pTxUTsx06YD/pIyiwxLhU62uSIC5r6N9Eh0s9V9uasA
	 83Jpe90mllcsA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C282C3782185;
	Fri, 10 May 2024 11:20:23 +0000 (UTC)
Message-ID: <a6172c6e-3b5b-43e5-8678-9dc4e428cf94@collabora.com>
Date: Fri, 10 May 2024 16:20:47 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: Add some null pointer
 checks
To: kunwu.chan@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, kunwu.chan@hotmail.com
References: <20240510095803.472840-1-kunwu.chan@linux.dev>
 <20240510095803.472840-2-kunwu.chan@linux.dev>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240510095803.472840-2-kunwu.chan@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/24 2:58 PM, kunwu.chan@linux.dev wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> There is a 'malloc' call, which can be unsuccessful.
> This patch will add the malloc failure checking
> to avoid possible null dereference.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 89ff704e9dad..ecc3ddeceeeb 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -582,6 +582,11 @@ int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
>  
>  	val_buf1 = malloc(stack_trace_len);
>  	val_buf2 = malloc(stack_trace_len);
> +	if (!val_buf1 || !val_buf2) {
> +		err = -ENOMEM;
Return from here instead of going to out where free(val_buf*) is being called.

> +		goto out;
> +	}
> +
>  	cur_key_p = NULL;
>  	next_key_p = &key;
>  	while (bpf_map_get_next_key(smap_fd, cur_key_p, next_key_p) == 0) {
> @@ -1197,6 +1202,8 @@ static int dispatch_thread_send_subtests(int sock_fd, struct test_state *state)
>  	int subtest_num = state->subtest_num;
>  
>  	state->subtest_states = malloc(subtest_num * sizeof(*subtest_state));
> +	if (!state->subtest_states)
> +		return -ENOMEM;
>  
>  	for (int i = 0; i < subtest_num; i++) {
>  		subtest_state = &state->subtest_states[i];

-- 
BR,
Muhammad Usama Anjum

