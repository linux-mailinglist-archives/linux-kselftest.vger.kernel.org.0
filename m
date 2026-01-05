Return-Path: <linux-kselftest+bounces-48214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2736CF48AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 16:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29E3A31317BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1448B3093BC;
	Mon,  5 Jan 2026 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np88r4ts"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC91C3019D8;
	Mon,  5 Jan 2026 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627792; cv=none; b=Hwzojdw2U7bwZL0xly5K9JqEjp9MOIJGKvkdakd0II5LAPUY44IXzF6aulXgReLLYti+JFN83JaJ4eRlGbUppb9rfOG+3bvKw4MFJheY1pXpjvsJ2u+Ts8NSfhAEinXvywpuSySZSsWSkRgSSE3fCJ5x1P9FLwwD3tN4mJ9EdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627792; c=relaxed/simple;
	bh=/JKo3a+bEEV8RMt7G4yFVltWy0vo1NbwemAW3LYU+Dc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UO2+xBeqI9r9Oh75XXvl8uEdwrcKUttGFEqap/id1f7evSYNxY8hIFhwFxBl+fblOoX2afxIPegF/OrVQKZkqsfmStAeJvCaaPHl74MZZPxupJ2eMvqi+gdrnylO4a1aXWRsk5u6si8jlhabFFZu+cp37pLCCbScTQ/EodpMhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np88r4ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F85C116D0;
	Mon,  5 Jan 2026 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767627791;
	bh=/JKo3a+bEEV8RMt7G4yFVltWy0vo1NbwemAW3LYU+Dc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=np88r4ts1nNRST4Jmu8WK/TlLk7RnTyxGnMDu2wQxVXj7EXN00M92llO7tClnXJ4P
	 iozZ9gqjnEZZu8AQAaoZ1FHADsPEjhLV78GhA+IizN9EN4MWrOYUGJGTVUKDIzYEb1
	 Q05Mu3r4h1iJQ/QgzsObTAL0Y+P01q+GOEEroV7BIpC4Fmk+06hmGbobnyp0HToz6t
	 i20rzGy7N/Wctc9NhMuSuLZ/Ec6pUvfYnUiyE64Ix4RNj4RIBP01l2au9cdTYEA0X6
	 fY7JtJsEQ0IhgQSyBDmZsFk2IThzXLWAHAs9AN7EdD/DirFjgjq7jPZy505xNbenQp
	 nVZxkfSlfgjsQ==
Content-Type: multipart/mixed; boundary="===============0955332525649677193=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b9810ef33fea33c42cae606c6e3673147668f16b9e88303d47ceeeeea200712e@mail.kernel.org>
In-Reply-To: <20260105151813.6968-5-leon.hwang@linux.dev>
References: <20260105151813.6968-5-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v2 4/5] bpf: lru: Fix unintended eviction when updating lru hash maps
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,skb99@linux.ibm.com,davem@davemloft.net,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  5 Jan 2026 15:43:10 +0000 (UTC)

--===============0955332525649677193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d029690246f8..8665eb6b8a7d 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

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
> +		l_val = htab_elem_value(l_new, map->key_size);
> +		copy_map_value(map, l_val, value);
> +		bpf_obj_free_fields(map->record, l_val);
> +	}

Should bpf_obj_free_fields() be called here on l_new? The value was just
copied into l_new and l_new will be inserted into the hash table when
l_old is found. Calling bpf_obj_free_fields() on l_new's value frees the
special fields (kptr, bpf_list_head, etc.) that were just copied, then
l_new is inserted with freed fields. This appears to be a use-after-free
for maps with special fields.

Looking at htab_lru_map_update_elem(), the pattern is to copy the value
and NOT call bpf_obj_free_fields() on the new element. The fields are
only freed when an element is removed from the hash table.

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
> +					value, onallcpus);
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
> +	bpf_lru_push_free(&htab->lru, ret ? node : &l_free->lru_node);
                                              ^^^^^^^^^^^^^^^^^^

When ret == 0 and !percpu, l_free points to l_old which is being removed
from the hash table. The code calls bpf_lru_push_free() directly instead
of htab_lru_push_free(). Looking at htab_lru_push_free():

    static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
    {
        check_and_free_fields(htab, elem);
        bpf_map_dec_elem_count(&htab->map);
        bpf_lru_push_free(&htab->lru, &elem->lru_node);
    }

It calls check_and_free_fields() to free special fields in the element
before pushing to the free list. The code here bypasses that, which would
leak special fields (kptr, etc.) in l_old when it has them.

Should this use htab_lru_push_free() instead of bpf_lru_push_free() for
the non-error path where l_old is being freed?

> +
> +	return ret;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20720201621

--===============0955332525649677193==--

