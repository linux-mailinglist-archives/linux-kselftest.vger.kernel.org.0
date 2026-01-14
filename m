Return-Path: <linux-kselftest+bounces-48964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BACED20DE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 19:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59A33301CE86
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 18:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6543396E1;
	Wed, 14 Jan 2026 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kUJ/7MOi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9698337BB2;
	Wed, 14 Jan 2026 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416283; cv=none; b=DMEUjUZ7EZe0kI0fGnmvZH2F3HADaIxNH70EEPZtli8z7Xx4VT0qjc6Gc7jilPBqxCLAvHsuaDz2/RmxicYr7W+L9mQKjmS9NnenytE2Z8FQG+yCEX/3f14Y7IcI1ZwMJnPkZo78D26JWpn0DV+/WR3P3swqc6Ikv55WPpDsXfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416283; c=relaxed/simple;
	bh=ClypWUCcmZdhOgMSv7cAqWse/cL4IEXeAo2k6l1M1+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ue6MRNxzQWJ+Li1VJ/TWAt/6ugRGtNU12iqLJWjEofWSCj+T9pgducSO9/3OH79LDRSjSlFC6nSDx7Uaf8Qx9NT8Fh7yEGBP2LsNmG67KMDSqAKOpDGYhVqKm8qA1bhdOL7MWiqoNQYXMSBLFbf3ym9nMgf66bLplJC8xPjjh/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kUJ/7MOi; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b20c1231-c8ef-4d66-97a9-120f2d77738e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768416274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MuE08WjOKJJ911Tg0cdT6a/SadtO731OH3L0J+ZIjA=;
	b=kUJ/7MOi8ckRi8Q39kTf4knDQP3iSskFER8XOHkyRahsTZBtPaUNxXeVH5AhGvIOosaAMT
	Enux6nAn6cKwi/tOtLvyrjXE7ic1DwO0GWTZLzGCfTTuDLMxEjoowT+HcuCe2lRpoMN1nr
	vbGEKevRA0L3w6gzt7TvHzlFuodDrr4=
Date: Wed, 14 Jan 2026 10:44:27 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/5] bpf: lru: Tidy hash handling in LRU code
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
 <20260107151456.72539-2-leon.hwang@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260107151456.72539-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/7/26 7:14 AM, Leon Hwang wrote:
> The hash field is not used by the LRU list itself.
> 
> Setting hash while manipulating the LRU list also obscures the intent
> of the code and makes it harder to follow.
> 
> Tidy this up by moving the hash assignment to prealloc_lru_pop(),
> where the element is prepared for insertion into the hash table.
> 
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>   kernel/bpf/bpf_lru_list.c | 24 +++++++++---------------
>   kernel/bpf/bpf_lru_list.h |  5 ++---
>   kernel/bpf/hashtab.c      |  5 ++---
>   3 files changed, 13 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
> index e7a2fc60523f..f4e183a9c28f 100644
> --- a/kernel/bpf/bpf_lru_list.c
> +++ b/kernel/bpf/bpf_lru_list.c
> @@ -344,10 +344,8 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
>   static void __local_list_add_pending(struct bpf_lru *lru,
>   				     struct bpf_lru_locallist *loc_l,
>   				     int cpu,
> -				     struct bpf_lru_node *node,
> -				     u32 hash)
> +				     struct bpf_lru_node *node)
>   {
> -	*(u32 *)((void *)node + lru->hash_offset) = hash;
>   	node->cpu = cpu;
>   	node->type = BPF_LRU_LOCAL_LIST_T_PENDING;
>   	bpf_lru_node_clear_ref(node);
> @@ -393,8 +391,7 @@ __local_list_pop_pending(struct bpf_lru *lru, struct bpf_lru_locallist *loc_l)
>   	return NULL;
>   }
>   
> -static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
> -						    u32 hash)
> +static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru)
>   {
>   	struct list_head *free_list;
>   	struct bpf_lru_node *node = NULL;
> @@ -415,7 +412,6 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
>   
>   	if (!list_empty(free_list)) {
>   		node = list_first_entry(free_list, struct bpf_lru_node, list);
> -		*(u32 *)((void *)node + lru->hash_offset) = hash;
>   		bpf_lru_node_clear_ref(node);
>   		__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_INACTIVE);

init the hash value later (after releasing l->lock) is not correct. The 
node is in the inactive list. The inactive list is one of the rotate and 
_evict_ candidates, meaning tgt_l->hash will be used in 
htab_lru_map_delete_node(). In practice, it does not matter if 
htab_lru_map_delete_node() cannot find the node in an incorrect bucket. 
However, it still should not use an uninitialized value to begin with.

> index 441ff5bc54ac..c2d12db9036a 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -296,12 +296,13 @@ static void htab_free_elems(struct bpf_htab *htab)
>   static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
>   					  u32 hash)
>   {
> -	struct bpf_lru_node *node = bpf_lru_pop_free(&htab->lru, hash);
> +	struct bpf_lru_node *node = bpf_lru_pop_free(&htab->lru);
>   	struct htab_elem *l;
>   
>   	if (node) {
>   		bpf_map_inc_elem_count(&htab->map);
>   		l = container_of(node, struct htab_elem, lru_node);
> +		l->hash = hash;
>   		memcpy(l->key, key, htab->map.key_size);
>   		return l;
>   	}

