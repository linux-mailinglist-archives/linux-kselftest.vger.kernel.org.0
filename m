Return-Path: <linux-kselftest+bounces-46521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC69BC8AA0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C836B4E8337
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 15:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBE03328F5;
	Wed, 26 Nov 2025 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hENwIPBm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DC1331A63;
	Wed, 26 Nov 2025 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170688; cv=none; b=jprp02r+7cOv4sHzNBzsNQXKTO9Qxf98Wk/iXzVED1Z3Br4XP2Bdb8hureg7ZD0+Ep2CXAauVyxzmQaBxqgFotx5J2lBobdYNeRV1sC8NQEPbxYJGUe2HqkqbARxLaSfWOyxe75Hl2qt0uODLgafwPbg36PCjGUfTSQJwV5jcPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170688; c=relaxed/simple;
	bh=wAvDKyglR4m9vT8x0sHCs+uKoN8sOn6AnjsZ8Szp+Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lx1q3KV6ncs3nbdgBq2vzAh8ClTIdCPzo4x2ilKQQ210AwFk37JOxBkaJZskBP9OJeM6lg5FYTLSdiD47DfVNTsejEHquo95RH4mRHMtjDekv5cnSM5jhcgrx2l/lj14P4vWMA8xA+IGAdJ94S7ErxN1vmIh50OTl9H+yRtveGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hENwIPBm; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4d8120f7-f3b6-4654-9b14-0ee7da5f87ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764170674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlXVYH2N0uf4TuTCjfA55TOuKuKC8GW35Olp9oQqllc=;
	b=hENwIPBm43Kfz1cLH0FSUAnRheIQNhinWcOnnLpYijMYsZqYzFdUn/HKhrlKDHl9CPTIf5
	qMEIJ4cDL9rja3MMzSs6Q3/FpJaooakAvHHmt9RrUTFZfY1fUCRFNNUp7FIp8gZA9r5P4S
	0xNtqNUpEYQQuqBN0qIWYV9OOGAdqbY=
Date: Wed, 26 Nov 2025 23:24:09 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v12 2/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_array maps
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jolsa@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, martin.lau@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, shuah@kernel.org, kerneljasonxing@gmail.com,
 chen.dylane@linux.dev, willemb@google.com, paul.chaignon@gmail.com,
 a.s.protopopov@gmail.com, memxor@gmail.com, yatsenko@meta.com,
 tklauser@distanz.ch, kernel-patches-bot@fb.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20251126145039.15715-3-leon.hwang@linux.dev>
 <07707b44fc9032398db551041498d6265ccf0a0313ecd8779bd1fa82a7d96409@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <07707b44fc9032398db551041498d6265ccf0a0313ecd8779bd1fa82a7d96409@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/26 23:11, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index d84af3719..01a99e3a3 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index 1eeb31c5b..67e9e811d 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
> 
> [ ... ]
> 
>> @@ -398,10 +405,11 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
>>  	u32 index = *(u32 *)key;
>>  	void __percpu *pptr;
>> -	int cpu, off = 0;
>> +	void *ptr, *val;
>>  	u32 size;
>> +	int cpu;
>>
>> -	if (unlikely(map_flags > BPF_EXIST))
>> +	if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS))
>>  		/* unknown flags */
>>  		return -EINVAL;
>>
>> @@ -409,7 +417,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>>  		/* all elements were pre-allocated, cannot insert a new one */
>>  		return -E2BIG;
>>
>> -	if (unlikely(map_flags & BPF_NOEXIST))
>> +	if (unlikely(map_flags == BPF_NOEXIST))
>                               ^^
> 

?

No such change in this version.

It seems that this change was inferred from v11 to v12 by AI itself.

Thanks,
Leon

> Does changing this from bitwise-AND to equality break flag combination
> handling? The old code checked (map_flags & BPF_NOEXIST), which would
> trigger for any flag combination including BPF_NOEXIST. The new code only
> checks (map_flags == BPF_NOEXIST), so if userspace passes
> (BPF_F_CPU | BPF_NOEXIST), the BPF_NOEXIST flag gets silently ignored
> instead of returning -EEXIST as before.
> 
> While all elements in percpu_array maps are pre-allocated and BPF_NOEXIST
> should always fail anyway, silently ignoring a flag the user explicitly set
> seems inconsistent with the principle of rejecting invalid flag combinations
> at validation time.
> 
>>  		/* all elements already exist */
>>  		return -EEXIST;
>>
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19708012130


