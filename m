Return-Path: <linux-kselftest+bounces-46574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD00C8C327
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 23:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53A813426CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 22:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42062D77FA;
	Wed, 26 Nov 2025 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a+eUVchy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BEF201278
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195622; cv=none; b=kCfibAmOh0nrMPBjKihVvuV9zE5FMxOqfsZw/Qqgy/4S+urlts3vCJScsbxH5qT5UTUwYyj6b19/APoBcqulViA/CBKrxiDr5kkUICKCxImad+uwOWUy3rokX2c0TrruoJfpk0+O7DAB9Kesj+S2DR9CSoCinapVG8MloFBGt+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195622; c=relaxed/simple;
	bh=0igFXLYu5hKG2KTGnD2aFnks2+K9FHMeFt/JFeWpnUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZBPZ664+UDsRkr9DsRQHk8APjy7ka998sF+jr5ZZJ5hj8Zr4Nc8BhZwWTNUz/6tZfPyoU3x7EgIB8HxEBQFUs6irR5gsXXCOANRrPaPl9GB4ShcXMN4bmxyZUG1GEJoehJBAMqW9LmbJGMW25ga1k7nV4S8e5t+LbBQo8gopsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a+eUVchy; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <68ecc660-1e02-4aa6-9bf1-3e56c3a23da4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764195617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9g8i2m3HErDYjYqt4Hkjbxi9Nqmf5HurBqBAwcdaCgg=;
	b=a+eUVchyxqYdPB5fn1a5mAKno7Fe1PFDLaklkXx+6IgUuL9N7YeUoQ2q4bwctTDgb4sC2Q
	plRF6ODPCElC5vThuPB8k3x+LzsyeKeKaRYuIiXft9Lkla+sDjpuMalK07JyRfyU8Mkyvy
	bDsu4clsLu5EIfYRixbFvelcRYKh0NA=
Date: Wed, 26 Nov 2025 14:20:06 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v12 2/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_array maps
To: Chris Mason <clm@meta.com>, Leon Hwang <leon.hwang@linux.dev>,
 bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jolsa@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, martin.lau@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, shuah@kernel.org, kerneljasonxing@gmail.com,
 chen.dylane@linux.dev, willemb@google.com, paul.chaignon@gmail.com,
 a.s.protopopov@gmail.com, memxor@gmail.com, yatsenko@meta.com,
 tklauser@distanz.ch, kernel-patches-bot@fb.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org
References: <20251126145039.15715-3-leon.hwang@linux.dev>
 <07707b44fc9032398db551041498d6265ccf0a0313ecd8779bd1fa82a7d96409@mail.kernel.org>
 <4d8120f7-f3b6-4654-9b14-0ee7da5f87ac@linux.dev>
 <26c4677b-aeff-4516-85f4-87b5d1a9f6ee@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <26c4677b-aeff-4516-85f4-87b5d1a9f6ee@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/26/25 7:56 AM, Chris Mason wrote:
> 
> 
> On 11/26/25 10:24 AM, Leon Hwang wrote:
>>
>>
>> On 2025/11/26 23:11, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>> index d84af3719..01a99e3a3 100644
>>>> --- a/include/linux/bpf.h
>>>> +++ b/include/linux/bpf.h
>>>
>>> [ ... ]
>>>
>>>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>>>> index 1eeb31c5b..67e9e811d 100644
>>>> --- a/kernel/bpf/arraymap.c
>>>> +++ b/kernel/bpf/arraymap.c
>>>
>>> [ ... ]
>>>
>>>> @@ -398,10 +405,11 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>>>>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
>>>>  	u32 index = *(u32 *)key;
>>>>  	void __percpu *pptr;
>>>> -	int cpu, off = 0;
>>>> +	void *ptr, *val;
>>>>  	u32 size;
>>>> +	int cpu;
>>>>
>>>> -	if (unlikely(map_flags > BPF_EXIST))
>>>> +	if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS))
>>>>  		/* unknown flags */
>>>>  		return -EINVAL;
>>>>
>>>> @@ -409,7 +417,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>>>>  		/* all elements were pre-allocated, cannot insert a new one */
>>>>  		return -E2BIG;
>>>>
>>>> -	if (unlikely(map_flags & BPF_NOEXIST))
>>>> +	if (unlikely(map_flags == BPF_NOEXIST))
>>>                               ^^
>>>
>>
>> ?
>>
>> No such change in this version.
>>
>> It seems that this change was inferred from v11 to v12 by AI itself
> 
> Thanks for flagging this, I'll try to find this section of the logs to
> see how the false positive checks failed to catch it.
> 
> -chris

AI got confused here, this was not in the diff.

But it appears it got triggered, because there are these two code
fragments nearby [1]:


	if (unlikely(map_flags & BPF_NOEXIST))
		/* all elements already exist */
		return -EEXIST;

and

	if (unlikely(map_flags == BPF_NOEXIST))
		/* all elements already exist */
		return -EEXIST;

Which is a good thing to notice even if this is intentional.

Anyone knows if it is?

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/arraymap.c#n356

> 


