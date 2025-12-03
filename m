Return-Path: <linux-kselftest+bounces-46943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BAFC9F72E
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 16:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48BB7306154F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 15:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E161C328632;
	Wed,  3 Dec 2025 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fi2U1ydu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5BD328623
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764774869; cv=none; b=b8RBU7Cr2CVzfVn1JHn9Xz8Ez53+HvF+eP/ebs9RYSBpPwwno/L6XG68lOh+VVtlhIFOuauP1X+mgXJgfR0fodheptWIrvVsPNsjti1s5D8x6EbRGjaEAhjekNA5r0v0tGbX06/VlA27mrY0GmRxakqbMXaCPzRMuhpjzFvEkm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764774869; c=relaxed/simple;
	bh=8xU9bgAfQF75D6U15lEpa3GwmcZ4IzP/Zytt/4wQj3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLsAdDRCPoHo0UGEvxn7KqNSMQRGBBpbT7uw6cm2+XBPYdPN3yb9F6a8gW6G6xJpecLooQTuGDQWiRGamNd9aL7lv/W849a4dT5+prl11xpJEhc8SQBJYaGbNpzuxlpyOuO8LCrZesLteT28bF3oXEHj7zKsH411J6OeGsJc+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fi2U1ydu; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b35fe921-473e-457b-a7ad-ca84c815788c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764774855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkXnjZ0hTkjuDzpjasxp3KdLtUkvR20DGjEbN4J8Z9s=;
	b=Fi2U1yduT9vUj+HWNQhGY9ltENz6VcAwmr6ryaFcR4tpSR6sLSASTX0M47L4RWwV9LysNL
	RC4ZSTmOYZGlNgwfRA3y7oLIWRE71pG/VzemMUHoJ2dxhZkSCMvyw2xeskQYiKLOiD7WqJ
	KeyN1UQ8+k+gnbXjayqduJKC7OsA1Wc=
Date: Wed, 3 Dec 2025 23:14:05 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Avoid unintended eviction when updating
 lru_hash maps
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, houtao1@huawei.com
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Saket Kumar Bhaskar <skb99@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, LKML
 <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com
References: <20251202153032.10118-1-leon.hwang@linux.dev>
 <20251202153032.10118-2-leon.hwang@linux.dev>
 <CAADnVQKrxz6Fa-rT6466U_HjE4TDDrJ9kdU_h28=Av+L92NBgA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQKrxz6Fa-rT6466U_HjE4TDDrJ9kdU_h28=Av+L92NBgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/12/3 02:10, Alexei Starovoitov wrote:
> On Tue, Dec 2, 2025 at 7:31 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> When updating an existing element in lru_hash maps, the current
>> implementation always calls prealloc_lru_pop() to get a new node before
>> checking if the key already exists. If the map is full, this triggers
>> LRU eviction and removes an existing element, even though the update
>> operation only needs to modify the value of an existing key in-place.
>>
>> This is problematic because:
>> 1. Users may unexpectedly lose entries when doing simple value updates
>> 2. The eviction overhead is unnecessary for existing key updates
>>
>> Fix this by first checking if the key exists before allocating a new
>> node. If the key is found, update the value in-place, refresh the LRU
>> reference, and return immediately without triggering any eviction.
>>
>> Fixes: 29ba732acbee ("bpf: Add BPF_MAP_TYPE_LRU_HASH")
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  kernel/bpf/hashtab.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index c8a9b27f8663..fb624aa76573 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -1207,6 +1207,27 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
>>         b = __select_bucket(htab, hash);
>>         head = &b->head;
>>
>> +       ret = htab_lock_bucket(b, &flags);
>> +       if (ret)
>> +               goto err_lock_bucket;
>> +
>> +       l_old = lookup_elem_raw(head, hash, key, key_size);
>> +
>> +       ret = check_flags(htab, l_old, map_flags);
>> +       if (ret)
>> +               goto err;
>> +
>> +       if (l_old) {
>> +               bpf_lru_node_set_ref(&l_old->lru_node);
>> +               copy_map_value(&htab->map, htab_elem_value(l_old, map->key_size), value);
>> +               check_and_free_fields(htab, l_old);
>> +       }
> 
> We cannot do this. It breaks the atomicity of the update.
> We added htab_map_update_elem_in_place() for a very specific case.
> See
> https://lore.kernel.org/all/20250401062250.543403-1-houtao@huaweicloud.com/
> and discussion in v1,v2.
> 
> We cannot do in-place updates for other map types.
> It will break user expectations.
> 

After going through the patch set and the related discussions, I
understand the concerns around breaking update atomicity.

I'll look into alternative approaches to address this issue without
violating the expected atomic semantics.

Thanks,
Leon


