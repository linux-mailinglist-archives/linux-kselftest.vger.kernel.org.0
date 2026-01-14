Return-Path: <linux-kselftest+bounces-48973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A36D210F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 20:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D56D3300FFAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 19:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5324B32B9A7;
	Wed, 14 Jan 2026 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O5yGqqTO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871DA2FBDF0
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768419572; cv=none; b=cL2dPQzRXGr85PFNusnT2rcy5qqpYc1RjJ7d0k/YjCCMz4Valc/VX81DKFHheTH5VN9e48mWZqqGxC5mXclJr/tKfInEBL+G2E7/xzV2JADjL46qvA9+WH9H/Lqv0omD3k3TtyDd9Vx1dRQ2lCjjcGAYdNGRUZjHt+QSMZQeosw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768419572; c=relaxed/simple;
	bh=VbJ/vebxdGjcq2EQJHGVZ67VHx9LpWRMPkqJ2jfWMVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvMokHdnD/iHtpAbgpe3cnVqC7bRImWkZM2crHymHiG0GgoAMepqingmkc+6bMgdA2CXd7rSP38D5xaFcx3uqiL9Kme1eW3ODoYssvwKpFHRPDQ90sXWt61gfSBZGzszHWRQgfg2QuX/ep04OlYF1WZMqo9Zz9CPrjKciCD4P4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O5yGqqTO; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e21c8a3d-f970-48f5-a18a-a85ee19d5bfb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768419557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qey3rjw38MpjAOKHrhYfvaMHCa3tBaP9p4wzTydW8XY=;
	b=O5yGqqTOj7nUIFfhwf3VHTTW07IpJRa96QsB4ok6g/2qfqK1MdGcTfL2zal48pApOMe82Q
	ijMAu+ITmU1rcc6oH7GnpaUzr+M5X5rXP0xvvKvRui1cP2EM+dEQ4rr4Rkk0Cd/7gtIBXh
	RAp6mx7a1x1SHrJif3VdAxcQAYM8+1E=
Date: Wed, 14 Jan 2026 11:39:07 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/5] bpf: lru: Fix unintended eviction when
 updating lru hash maps
To: Leon Hwang <leon.hwang@linux.dev>
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260107151456.72539-5-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/7/26 7:14 AM, Leon Hwang wrote:
> When updating an existing element in lru_[percpu_,]hash maps, the current
> implementation always calls prealloc_lru_pop() to get a new node before
> checking if the key already exists. If the map is full, this triggers
> LRU eviction and removes an existing element, even though the update
> operation only needs to modify the value of an existing key in-place.
> 
> This is problematic because:
> 1. Users may unexpectedly lose entries when doing simple value updates
> 2. The eviction overhead is unnecessary for existing key updates

This is not the common LRU map use case. The bpf prog usually does a 
lookup first, finds the entry, and then directly updates the value 
in-place in the bpf prog itself. If the lookup fails, it will insert a 
_new_ element.

When the map is full, eviction should actually be triggered regardless. 
For an LRU map that is too small to fit the working set, it is asking 
for trouble.

 From the syscall update, if the use case is always updating an existing 
element, the regular hashmap should be used instead.

> Fix this by first checking if the key exists before allocating a new
> node. If the key is found, update the value using the extra lru node
> without triggering any eviction.

This will instead add overhead for the common use case described above. 
The patch is mostly for getting a selftest case to work in a small LRU 
map. I don't think it is worth the added complexity either.

Patch 2 and 3 look ok, but they also only make marginal improvements on 
the existing code.

pw-bot: cr

> +static int htab_lru_map_update_elem_in_place(struct bpf_htab *htab, void *key, void *value,
> +					     u64 map_flags, struct bucket *b,
> +					     struct hlist_nulls_head *head, u32 hash,
> +					     bool percpu, bool onallcpus)
> +{
> +	struct htab_elem *l_new, *l_old, *l_free;
> +	struct bpf_map *map = &htab->map;
> +	u32 key_size = map->key_size;
> +	struct bpf_lru_node *node;
> +	unsigned long flags;
> +	void *l_val;
> +	int ret;
> +
> +	node = bpf_lru_pop_extra(&htab->lru);
> +	if (!node)
> +		return -ENOENT;
> +
> +	l_new = container_of(node, struct htab_elem, lru_node);
> +	l_new->hash = hash;
> +	memcpy(l_new->key, key, key_size);
> +	if (!percpu) {
> +		l_val = htab_elem_value(l_new, key_size);
> +		copy_map_value(map, l_val, value);
> +		bpf_obj_free_fields(map->record, l_val);
> +	}
> +
> +	ret = htab_lock_bucket(b, &flags);
> +	if (ret)
> +		goto err_lock_bucket;
> +
> +	l_old = lookup_elem_raw(head, hash, key, key_size);
> +
> +	ret = check_flags(htab, l_old, map_flags);
> +	if (ret)
> +		goto err;
> +
> +	if (l_old) {
> +		bpf_lru_node_set_ref(&l_new->lru_node);
> +		if (percpu) {
> +			/* per-cpu hash map can update value in-place.
> +			 * Keep the same logic in __htab_lru_percpu_map_update_elem().
> +			 */
> +			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
> +					value, onallcpus, map_flags);
> +			l_free = l_new;
> +		} else {
> +			hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> +			hlist_nulls_del_rcu(&l_old->hash_node);
> +			l_free = l_old;
> +		}
> +	} else {
> +		ret = -ENOENT;
> +	}
> +
> +err:
> +	htab_unlock_bucket(b, flags);
> +
> +err_lock_bucket:
> +	if (ret) {
> +		bpf_lru_push_free(&htab->lru, node);
> +	} else {
> +		if (l_old && !percpu)
> +			bpf_obj_free_fields(map->record, htab_elem_value(l_old, key_size));

Does htab_lru_map_update_elem() have an existing bug that is missing the 
bpf_obj_free_fields() on l_old?

> +		bpf_lru_push_free(&htab->lru, &l_free->lru_node);
> +	}
> +
> +	return ret;
> +}
> +
>   static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
>   				     u64 map_flags)
>   {
> @@ -1215,6 +1286,11 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
>   	b = __select_bucket(htab, hash);
>   	head = &b->head;
>   
> +	ret = htab_lru_map_update_elem_in_place(htab, key, value, map_flags, b, head, hash, false,
> +						false);
> +	if (!ret)
> +		return 0;
> +
>   	/* For LRU, we need to alloc before taking bucket's
>   	 * spinlock because getting free nodes from LRU may need
>   	 * to remove older elements from htab and this removal
> @@ -1354,6 +1430,11 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>   	b = __select_bucket(htab, hash);
>   	head = &b->head;
>   
> +	ret = htab_lru_map_update_elem_in_place(htab, key, value, map_flags, b, head, hash, true,
> +						onallcpus);
> +	if (!ret)
> +		return 0;
> +
>   	/* For LRU, we need to alloc before taking bucket's
>   	 * spinlock because LRU's elem alloc may need
>   	 * to remove older elem from htab and this removal


