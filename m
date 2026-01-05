Return-Path: <linux-kselftest+bounces-48215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37548CF4B7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 17:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 200B1306396B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 16:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4E83090DE;
	Mon,  5 Jan 2026 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="POH40quX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A924F3081B0
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629817; cv=none; b=M2QoHt/Od412iqqOaMvk2+brnZUOI6bH90xO5uniuNEWal8nE/3LHZ1cDAlvT9LQ0PYDNp2hT5E0z5LI16dAzGB6p4ni/4TLOWmRzewSifq7sVVymt4c+tWON5cge7fjXi/U33vgx2RGasdmutJG/48Pp4Jn9aYJYk4wU71eVVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629817; c=relaxed/simple;
	bh=QM677CdcLD/2C2xfXAS6KdzQY874lurB7DGZ1pruR4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMd5eEj1BzgIMhaZn1I8vsFj6A7yy+/aTCa+pVzLEPvv/taJCvA9sU6Tmi19kSQMD8KVPqAxn78gnVOHOh1xPiqh1NAMm+ALE+eMdy1gZhm/O1SmRG/4tkUrIrWvpNDdqmRzv0W05ebgC3asRgSulSN4LwHwLo++J8QhhhkxHok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=POH40quX; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f67e288a-7c66-4e7c-8335-2d4f6376e8cb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767629813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrCBqhouGDytr5/3Tjq5tmXlRlJWGO6VtMrLwtGjDiA=;
	b=POH40quXjY5q6YrKoNJ1nxWMct46llSezncXmIFBcc16za/u8mCqoNnZ9apft2pvPtprjP
	jU4sdH5HtCL+vpbmlyK6M3mBQ8HGUPMMnEE0hgWQk7P3GKfRPwEknncaidCx/e+vFOycZi
	4AHNqPwDNOUPNMm/rrnCVHS0rOHDzxs=
Date: Tue, 6 Jan 2026 00:16:43 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/5] bpf: lru: Fix unintended eviction when
 updating lru hash maps
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 skb99@linux.ibm.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260105151813.6968-5-leon.hwang@linux.dev>
 <b9810ef33fea33c42cae606c6e3673147668f16b9e88303d47ceeeeea200712e@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <b9810ef33fea33c42cae606c6e3673147668f16b9e88303d47ceeeeea200712e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/5 23:43, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index d029690246f8..8665eb6b8a7d 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
> 
> [ ... ]
> 
>> +static int htab_lru_map_update_elem_in_place(struct bpf_htab *htab, void *key, void *value,
>> +					     u64 map_flags, struct bucket *b,
>> +					     struct hlist_nulls_head *head, u32 hash,
>> +					     bool percpu, bool onallcpus)
>> +{
>> +	struct htab_elem *l_new, *l_old, *l_free;
>> +	struct bpf_map *map = &htab->map;
>> +	u32 key_size = map->key_size;
>> +	struct bpf_lru_node *node;
>> +	unsigned long flags;
>> +	void *l_val;
>> +	int ret;
>> +
>> +	node = bpf_lru_pop_extra(&htab->lru);
>> +	if (!node)
>> +		return -ENOENT;
>> +
>> +	l_new = container_of(node, struct htab_elem, lru_node);
>> +	l_new->hash = hash;
>> +	memcpy(l_new->key, key, key_size);
>> +	if (!percpu) {
>> +		l_val = htab_elem_value(l_new, map->key_size);
>> +		copy_map_value(map, l_val, value);
>> +		bpf_obj_free_fields(map->record, l_val);
>> +	}
> 
> Should bpf_obj_free_fields() be called here on l_new? The value was just
> copied into l_new and l_new will be inserted into the hash table when
> l_old is found. Calling bpf_obj_free_fields() on l_new's value frees the
> special fields (kptr, bpf_list_head, etc.) that were just copied, then
> l_new is inserted with freed fields. This appears to be a use-after-free
> for maps with special fields.
> 
> Looking at htab_lru_map_update_elem(), the pattern is to copy the value
> and NOT call bpf_obj_free_fields() on the new element. The fields are
> only freed when an element is removed from the hash table.
> 

You're wrong here, that the copied value must be cleaned by
bpf_obj_free_fields().

>> +
>> +	ret = htab_lock_bucket(b, &flags);
>> +	if (ret)
>> +		goto err_lock_bucket;
>> +
>> +	l_old = lookup_elem_raw(head, hash, key, key_size);
>> +
>> +	ret = check_flags(htab, l_old, map_flags);
>> +	if (ret)
>> +		goto err;
>> +
>> +	if (l_old) {
>> +		bpf_lru_node_set_ref(&l_new->lru_node);
>> +		if (percpu) {
>> +			/* per-cpu hash map can update value in-place.
>> +			 * Keep the same logic in __htab_lru_percpu_map_update_elem().
>> +			 */
>> +			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
>> +					value, onallcpus);
>> +			l_free = l_new;
>> +		} else {
>> +			hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>> +			hlist_nulls_del_rcu(&l_old->hash_node);
>> +			l_free = l_old;
>> +		}
>> +	} else {
>> +		ret = -ENOENT;
>> +	}
>> +
>> +err:
>> +	htab_unlock_bucket(b, flags);
>> +
>> +err_lock_bucket:
>> +	bpf_lru_push_free(&htab->lru, ret ? node : &l_free->lru_node);
>                                               ^^^^^^^^^^^^^^^^^^
> 
> When ret == 0 and !percpu, l_free points to l_old which is being removed
> from the hash table. The code calls bpf_lru_push_free() directly instead
> of htab_lru_push_free(). Looking at htab_lru_push_free():
> 
>     static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
>     {
>         check_and_free_fields(htab, elem);
>         bpf_map_dec_elem_count(&htab->map);
>         bpf_lru_push_free(&htab->lru, &elem->lru_node);
>     }
> 
> It calls check_and_free_fields() to free special fields in the element
> before pushing to the free list. The code here bypasses that, which would
> leak special fields (kptr, etc.) in l_old when it has them.
> 
> Should this use htab_lru_push_free() instead of bpf_lru_push_free() for
> the non-error path where l_old is being freed?
> 

You're right here, that I did not free the special fields of l_old. But
htab_lru_push_free() shouldn't be used here for the non-error path,
because bpf_map_dec_elem_count() was not required here.

I'll fix it in the next revision.

Thanks,
Leon

>> +
>> +	return ret;
>> +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20720201621


