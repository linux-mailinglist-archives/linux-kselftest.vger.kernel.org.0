Return-Path: <linux-kselftest+bounces-46527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250B0C8AF2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83343A52D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AD83321A4;
	Wed, 26 Nov 2025 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o6EBdzbB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA4030BBAB
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174282; cv=none; b=ZvRZRa61PpWMnlME2EaufYe48D4+o2c+L7BfAO1rh8v31ojFEFgb8Y8PwjV0J7KghunY9X05PRa9KPbKuMdbD0s//6f3C9gGzp0lA31H4q2zYXnQfwOX19xtIs53OSoLKr9QAa31sPak8Qx9npkr9FFYqug+rFEu8eGq7AXBWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174282; c=relaxed/simple;
	bh=jVuT3OlGm7eNi3eYEGZFHHFSDumDXBBchOQE3Jg8Y/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPqi69OOdWSeEbTS6GVaRjYjl1q6HT0DStgclHRQhb13dBzFW6VeiZf93ZDBGHbimRcpLOiQb9JhG+VxlaBn9NVmt0gsWk2dzS6azpzO2I/3clTPgqkNBSDgoJNpLxXqHHh4cvFVCV6Eb3Ge7lSdXUP0sYdN/ACsBz4/BdYFxhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o6EBdzbB; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <13a871d1-5bd8-44a1-8737-eb26342d30b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764174268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ekRT332AhugTObU/O7d0SgsnySfkt/B3bfRW4qi1c38=;
	b=o6EBdzbBfRSNbqrzyNQy0/jwq3rhnUJY9BWQHLJn0k5zdTTvjgAf2+V1BfVRd9qHfpD1eu
	HUOSsk4Vk3QsZwRXXY7iimxiFnLtr5jxD6NVJCQMPtUO1qh42ZZMvELk9N7h889j5R0uCu
	YenxpVKMF7xP80JV942cal4X7de7Jk0=
Date: Thu, 27 Nov 2025 00:24:10 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v12 3/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
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
References: <20251126145039.15715-4-leon.hwang@linux.dev>
 <f33b87ffc7d3884dab5f73d90ba3f29afd4ee5975be512532702228363cde72e@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <f33b87ffc7d3884dab5f73d90ba3f29afd4ee5975be512532702228363cde72e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/26 23:11, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 01a99e3a3..f79d2ae27 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index c8a9b27f8..441ff5bc5 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
> 
> [ ... ]
> 
>> @@ -1249,6 +1258,15 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
>>  	return ret;
>>  }
>>
>> +static int htab_map_check_update_flags(bool onallcpus, u64 map_flags)
>> +{
>> +	if (unlikely(!onallcpus && map_flags > BPF_EXIST))
>> +		return -EINVAL;
>> +	if (unlikely(onallcpus && ((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS)))
>> +		return -EINVAL;
>> +	return 0;
>> +}
>> +
> 
> Can htab_map_check_update_flags() correctly validate the new flags?
> 
> When onallcpus=false (the common case for normal map_update_elem
> operations via htab_percpu_map_update_elem()->
> htab_map_update_elem_in_place()), the check at the first if statement
> compares the full 64-bit map_flags value against BPF_EXIST (2).
> 
> When BPF_F_CPU (8) is set, or when the CPU number is embedded in the
> upper 32 bits (e.g., 0x0000000100000008 for CPU 1), map_flags will be
> greater than BPF_EXIST, causing this function to return -EINVAL.
> 
> This appears inconsistent with the equivalent check in
> bpf_percpu_array_update() (commit 51f40f83b), which uses:
> 
>   if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS))
> 
> The percpu_array check casts to u32 to examine only the lower 32 bits,
> allowing the CPU number in the upper 32 bits. The hash table check for
> onallcpus=false doesn't perform this cast, so it will reject valid flag
> combinations that include BPF_F_CPU.
> 
> Would this prevent the BPF_F_CPU functionality from working for normal
> percpu_hash update operations?
> 

For UAPI percpu_hash updates, this is fine because onallcpus is always true.

For BPF program–initiated percpu_hash updates, the behavior also remains
unchanged since onallcpus is false, and the 'map_flags > BPF_EXIST'
check behaves exactly as it did before.

Thanks,
Leon

>> @@ -1262,9 +1280,9 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
>>  	u32 key_size, hash;
>>  	int ret;
>>
>> -	if (unlikely(map_flags > BPF_EXIST))
>> -		/* unknown flags */
>> -		return -EINVAL;
>> +	ret = htab_map_check_update_flags(onallcpus, map_flags);
>> +	if (unlikely(ret))
>> +		return ret;
>>
>>  	WARN_ON_ONCE(!bpf_rcu_lock_held());
>>
> 
> [ ... ]
> 
>> @@ -1324,9 +1342,9 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>>  	u32 key_size, hash;
>>  	int ret;
>>
>> -	if (unlikely(map_flags > BPF_EXIST))
>> -		/* unknown flags */
>> -		return -EINVAL;
>> +	ret = htab_map_check_update_flags(onallcpus, map_flags);
>> +	if (unlikely(ret))
>> +		return ret;
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19708012130


