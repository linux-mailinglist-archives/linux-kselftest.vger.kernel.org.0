Return-Path: <linux-kselftest+bounces-46523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 893DDC8AB10
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7C164E5DCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 15:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAFB33BBD5;
	Wed, 26 Nov 2025 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RaKFkPNN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BED033BBD0
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764171381; cv=none; b=QZMcx5dguq23mmvGBr4+wIHmKA3rt79SbFzt/cD8WA20pcTh7MKnNppWgwOCLxLDJXLpS3uDMsXmxGu42BiQHzAN7ckn/nHa0YTFDt87QXHg3qKB/KfImVRWn7IMDHI9SlTTkRgDDgGdDxqUd2OTebTYRx47Ln3tAhM4sfu2JWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764171381; c=relaxed/simple;
	bh=CXZcCiuzESNaeTzLwW2QktKQ3N4bxI2br7SPZ8krOK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g80CiixQvO7/BMZBJSi7QLikPs0ZoPzmgtVabM+Z15J3KcJPlQzoIk+2Gb/IEQvymcd90plI4uvQACnbq/kCaQPyGw1r8yKBUhoEf4YGv3Du0sg+ECY776tvWZkxr0GYD6sZhApKG1RhilGXsaBIb/1rRGYK4f5KZmIwxgk5XuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RaKFkPNN; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <73cda750-5979-4e4e-aa34-18e460b8b6e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764171367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYZc95UrAi4/xFTTZF1FyRXrZNMEEA99WkW75EMwNW0=;
	b=RaKFkPNN5IWJiVQWEgw55A1IJiX6kD+SDSUhb7gH+OvLWzJEDpnTE4wRNr+4k+0DWy5M77
	lo2eMiIyn3LZuKQ+dKzeWNqQpShldv9nX42DP7+c3E4O4Rq6mXEhQouHeNrpVZ7iIiwb36
	bR24vYPBsIviRrItthpWBOs3VQbqNt0=
Date: Wed, 26 Nov 2025 23:35:44 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v12 5/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_cgroup_storage maps
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
References: <20251126145039.15715-6-leon.hwang@linux.dev>
 <edd9991150f1456a7868025636825d7cf7595802e4a2fe405900c53fc1799ed8@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <edd9991150f1456a7868025636825d7cf7595802e4a2fe405900c53fc1799ed8@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/26 23:11, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>> index aedf573bd..013f4db99 100644
>> --- a/include/linux/bpf-cgroup.h
>> +++ b/include/linux/bpf-cgroup.h
> 
> [ ... ]
> 
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index f79d2ae27..9e756db5e 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
>> index 2ab4b60ff..1ccbf28b2 100644
>> --- a/kernel/bpf/local_storage.c
>> +++ b/kernel/bpf/local_storage.c
>> @@ -180,7 +180,7 @@ static long cgroup_storage_update_elem(struct bpf_map *map, void *key,
>>  }
>>
>>  int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
>> -				   void *value)
>> +				   void *value, u64 map_flags)
>>  {
>>  	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
>>  	struct bpf_cgroup_storage *storage;
>> @@ -198,11 +198,17 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
>>  	 * access 'value_size' of them, so copying rounded areas
>>  	 * will not leak any kernel data
>>  	 */
>> +	if (map_flags & BPF_F_CPU) {
>> +		cpu = map_flags >> 32;
>> +		copy_map_value(_map, value, per_cpu_ptr(storage->percpu_buf, cpu));
>> +		goto unlock;
>> +	}
> 
> Should check_and_init_map_value() be called here after copy_map_value()?
> 

It should not be called, because percpu_cgroup_storage maps do not
support any special fields.

Thanks,
Leon

> The similar implementations in bpf_percpu_array_copy() and
> bpf_percpu_hash_copy() both call check_and_init_map_value() after
> copying a single CPU's value when BPF_F_CPU is set:
> 
>   bpf_percpu_array_copy():
>     if (map_flags & BPF_F_CPU) {
>         cpu = map_flags >> 32;
>         copy_map_value(map, value, per_cpu_ptr(pptr, cpu));
>         check_and_init_map_value(map, value);
>         goto unlock;
>     }
> 
>   bpf_percpu_hash_copy():
>     if (map_flags & BPF_F_CPU) {
>         cpu = map_flags >> 32;
>         copy_map_value(map, value, per_cpu_ptr(pptr, cpu));
>         check_and_init_map_value(map, value);
>         goto out;
>     }
> 
> The check_and_init_map_value() call initializes special BTF fields
> (timers, kptrs, etc.) when copying map values to userspace. Without it,> these fields might not be properly initialized if percpu_cgroup_storage
> map values contain such fields.
> 
>>  	size = round_up(_map->value_size, 8);
>>  	for_each_possible_cpu(cpu) {
>>  		copy_map_value_long(_map, value + off, per_cpu_ptr(storage->percpu_buf, cpu));
>>  		off += size;
>>  	}
>> +unlock:
>>  	rcu_read_unlock();
>>  	return 0;
>>  }
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19708012130


