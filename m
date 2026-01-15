Return-Path: <linux-kselftest+bounces-48990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E3AD224B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 04:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56C473015E07
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 03:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866FE288C30;
	Thu, 15 Jan 2026 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rWWj7X3Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F2727FD43
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 03:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768447561; cv=none; b=dRuTTMKO1gWNzqQWN2fXkHH5+hE7rIWieg4DezDHR+eLEIzHaNm0dauVkEbYSWwIhI3BTf9P1QoSRRwMKV1KB/QIlHe9Udy3FEaGFgMFRpkbaWWIUzVTmRUccNB6KouWG8jlPL9ogDbYNdWHqC68AARJZMKkIni7BKj/Y5SL54Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768447561; c=relaxed/simple;
	bh=QkPXqnV3ZRfhtGfh1Vcau6M2ZsYkINU+HKPnyvuY0iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wsq6x7yjzkZoZB4cvUnH/Oak9zH4gV5OMaKn+UWF/ucMh2eTrtR7Yg1HZ2mO4I+8mUhPqiU0xRu/GZYx5O6yiZauJWGD4v2u8pGCgWS5B/9r0cFAYYt/orQemMzb9JOtwIRsw82R93B9LH0XxC75IDI28riB4w0x1SS4idZ5DMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rWWj7X3Z; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3d4287e5-0564-4933-83ee-c2dcbfe993f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768447557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwdtCxk+bhle2ZNHlx3yJsg+WAw9Zp1L7FaYnQsiDdw=;
	b=rWWj7X3Z2fEw+8PidI1ci6WixFd5ud03Mwh/YDwBd5ZkwOSyXuvYFcwQXTjjOGzMzNnWR3
	pgwu+gNmbAEs7GKgMkE0vcY+ReR0X611mnt5pNo3q9BhyX/NRsAWnmu1/JjXVMR8zi3igH
	W5z8PYpkszoIK9EgQbdjNUcxwzeZBDE=
Date: Thu, 15 Jan 2026 11:25:46 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/5] bpf: lru: Fix unintended eviction when
 updating lru hash maps
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Saket Kumar Bhaskar <skb99@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 bpf@vger.kernel.org
References: <20260107151456.72539-1-leon.hwang@linux.dev>
 <20260107151456.72539-5-leon.hwang@linux.dev>
 <e21c8a3d-f970-48f5-a18a-a85ee19d5bfb@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <e21c8a3d-f970-48f5-a18a-a85ee19d5bfb@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 15/1/26 03:39, Martin KaFai Lau wrote:
> 
> 
> On 1/7/26 7:14 AM, Leon Hwang wrote:
>> When updating an existing element in lru_[percpu_,]hash maps, the current
>> implementation always calls prealloc_lru_pop() to get a new node before
>> checking if the key already exists. If the map is full, this triggers
>> LRU eviction and removes an existing element, even though the update
>> operation only needs to modify the value of an existing key in-place.
>>
>> This is problematic because:
>> 1. Users may unexpectedly lose entries when doing simple value updates
>> 2. The eviction overhead is unnecessary for existing key updates
> 
> This is not the common LRU map use case. The bpf prog usually does a
> lookup first, finds the entry, and then directly updates the value in-
> place in the bpf prog itself. If the lookup fails, it will insert a
> _new_ element.
> 
> When the map is full, eviction should actually be triggered regardless.
> For an LRU map that is too small to fit the working set, it is asking
> for trouble.
> 
> From the syscall update, if the use case is always updating an existing
> element, the regular hashmap should be used instead.
> 

Thanks for the explanation.

While the common use case is indeed to update values in place after a
lookup, small-capacity LRU maps are not forbidden today, so the
unexpected eviction behavior can still be observed in practice.

I have been asked about data loss with a 110-entry LRU map before, and
in that case my recommendation was also to use a regular hash map instead.

>> Fix this by first checking if the key exists before allocating a new
>> node. If the key is found, update the value using the extra lru node
>> without triggering any eviction.
> 
> This will instead add overhead for the common use case described above.
> The patch is mostly for getting a selftest case to work in a small LRU
> map. I don't think it is worth the added complexity either.
> 

Given this, instead of pursuing this change, I will update the selftests
in 'tools/testing/selftests/bpf/prog_tests/percpu_alloc.c' to make them
more robust and avoid CI failures.

> Patch 2 and 3 look ok, but they also only make marginal improvements on
> the existing code.
> 
> pw-bot: cr
> 
>> +static int htab_lru_map_update_elem_in_place(struct bpf_htab *htab,
>> void *key, void *value,
>> +                         u64 map_flags, struct bucket *b,
>> +                         struct hlist_nulls_head *head, u32 hash,
>> +                         bool percpu, bool onallcpus)
>> +{

[...]

>> +err:
>> +    htab_unlock_bucket(b, flags);
>> +
>> +err_lock_bucket:
>> +    if (ret) {
>> +        bpf_lru_push_free(&htab->lru, node);
>> +    } else {
>> +        if (l_old && !percpu)
>> +            bpf_obj_free_fields(map->record, htab_elem_value(l_old,
>> key_size));
> 
> Does htab_lru_map_update_elem() have an existing bug that is missing the
> bpf_obj_free_fields() on l_old?
> 

No.

htab_lru_push_free() would free the special fields.

Thanks,
Leon

[...]


