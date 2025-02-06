Return-Path: <linux-kselftest+bounces-25888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83609A2A108
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 07:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE65188633E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 06:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4F722489A;
	Thu,  6 Feb 2025 06:40:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F92144A8;
	Thu,  6 Feb 2025 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824006; cv=none; b=ghgHh8I0O99bXXPpISgAdgzmoMVpphkneOUIgxyeXRdXHnAnAchml2g3iW/Z5Y2ljjkv90MvZzGSVmmwS7BrT6curNEGPXNgzeRkQ62FWtwNYWgeviN+3b0TC/X69b+MaDDbkL1kfjdaE1rJlW9VKQLFWPo8G4Qyf8H2v6DPnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824006; c=relaxed/simple;
	bh=7xpXBJ9Lct3Eb6YdnfEBSq/oPX/CLPtDoIf+rWTizSs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QiqDaKQ8vBxSAChvgM6K2Xshoq6OvVuBBX/N41/YsoMmDavTqc4GCPzybP8TAg4yaoJ+oJ575bAxr2ITqrQ0nBwdK1fORutE8xTT88iypwK1U15zzFE/jhbCm6oN4CCmqOwkgJlg6YWmxERxQldGlxGTilABDwfSpQ98tlFarhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YpSBd5jZyz4f3jQv;
	Thu,  6 Feb 2025 14:39:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E46B51A148C;
	Thu,  6 Feb 2025 14:39:58 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgB32Fw4WaRnSh82DA--.50974S2;
	Thu, 06 Feb 2025 14:39:56 +0800 (CST)
Subject: Re: [PATCH bpf] bpf: skip non existing key in
 generic_map_lookup_batch
To: Yan Zhai <yan@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Brian Vazquez <brianvv@google.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com
References: <Z6OYbS4WqQnmzi2z@debian.debian>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <5f6610a1-3cd0-764e-0f49-91af1004ea50@huaweicloud.com>
Date: Thu, 6 Feb 2025 14:39:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z6OYbS4WqQnmzi2z@debian.debian>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgB32Fw4WaRnSh82DA--.50974S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4xAFy7Kr15tw43tr1DKFg_yoWfZF1kpF
	WrCFnrGr4kWrW8t3y2ya47XFWv9r18Kw1jyas5J3s0krn7Wr17Cr10ka9rtry3uF1kZr1a
	va12qryrXayYyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07jIksgUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/6/2025 12:57 AM, Yan Zhai wrote:
> The generic_map_lookup_batch currently returns EINTR if it fails with
> ENOENT and retries several times on bpf_map_copy_value. The next batch
> would start from the same location, presuming it's a transient issue.
> This is incorrect if a map can actually have "holes", i.e.
> "get_next_key" can return a key that does not point to a valid value. At
> least the array of maps type may contain such holes legitly. Right now
> these holes show up, generic batch lookup cannot proceed any more. It
> will always fail with EINTR errors.
>
> Rather, do not retry in generic_map_lookup_batch. If it finds a non
> existing element, skip to the next key.
>
> Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")
> Closes: https://lore.kernel.org/bpf/Z6JXtA1M5jAZx8xD@debian.debian/
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  kernel/bpf/syscall.c                          | 16 ++----
>  .../bpf/map_tests/map_in_map_batch_ops.c      | 54 ++++++++++++++-----
>  2 files changed, 45 insertions(+), 25 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c420edbfb7c8..5691fc0d370d 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1979,7 +1979,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
>  	void __user *values = u64_to_user_ptr(attr->batch.values);
>  	void __user *keys = u64_to_user_ptr(attr->batch.keys);
>  	void *buf, *buf_prevkey, *prev_key, *key, *value;
> -	int err, retry = MAP_LOOKUP_RETRIES;
> +	int err;
>  	u32 value_size, cp, max_count;
>  
>  	if (attr->batch.elem_flags & ~BPF_F_LOCK)
> @@ -2026,14 +2026,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
>  		err = bpf_map_copy_value(map, key, value,
>  					 attr->batch.elem_flags);
>  
> -		if (err == -ENOENT) {
> -			if (retry) {
> -				retry--;
> -				continue;
> -			}
> -			err = -EINTR;
> -			break;
> -		}
> +		if (err == -ENOENT)
> +			goto next_key;
>  
>  		if (err)
>  			goto free_buf;
> @@ -2048,12 +2042,12 @@ int generic_map_lookup_batch(struct bpf_map *map,
>  			goto free_buf;
>  		}
>  
> +		cp++;
> +next_key:
>  		if (!prev_key)
>  			prev_key = buf_prevkey;
>  
>  		swap(prev_key, key);
> -		retry = MAP_LOOKUP_RETRIES;
> -		cp++;
>  		cond_resched();
>  	}
>  

Let's move the new thread for further discussion.

>We are probably not on the same page. Let me clarify:

>By "retry logic" I mean this code snippet:
>               if (err == -ENOENT) {
>                       if (retry) {
>                               retry--;
>                               continue;
>                       }
>                       err = -EINTR;
>                       break;
>               }


Yes, the retry logic doesn't change the previous key. Thanks for the
clarifying.
> And by "skipping to the next key", it's simply
>
>   if (err == -ENOENT)
>        goto next_key;
>
> Note the "next_key" label was not in the current codebase. It is only
> in my posted patch. I don't think this would break lpm_trie unless I
> missed something.

I was trying to say that the proposed patch may break the lookup_batch
operation for lpm_trie, and let me explain step by step:

For LPM trie map:
(1) ->map_get_next_key(map, prev_key, key) returns a valid key

(2) bpf_map_copy_value() return -ENOMENT
It means the key must be deleted concurrently.

(3) goto next_key
It swaps the prev_key and key

(4) ->map_get_next_key(map, prev_key, key) again
prev_key points to a non-existing key, for LPM trie it will treat just
like prev_key=NULL case, the returned key will be duplicated.


> diff --git a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
> index 66191ae9863c..b38be71f06be 100644

It is better to split the update of map_tests into a separated patch and
it will be more friendly for stable backport.
> --- a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
> +++ b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
> @@ -120,11 +120,12 @@ static void validate_fetch_results(int outer_map_fd,
>  
>  static void fetch_and_validate(int outer_map_fd,
>  			       struct bpf_map_batch_opts *opts,
> -			       __u32 batch_size, bool delete_entries)
> +			       __u32 batch_size, bool delete_entries,
> +			       bool has_holes)
>  {
> +	int err, max_entries = OUTER_MAP_ENTRIES - !!has_holes;
>  	__u32 *fetched_keys, *fetched_values, total_fetched = 0;
>  	__u32 batch_key = 0, fetch_count, step_size;
> -	int err, max_entries = OUTER_MAP_ENTRIES;
>  	__u32 value_size = sizeof(__u32);
>  
>  	/* Total entries needs to be fetched */
> @@ -135,9 +136,9 @@ static void fetch_and_validate(int outer_map_fd,
>  	      "error=%s\n", strerror(errno));
>  
>  	for (step_size = batch_size;
> -	     step_size <= max_entries;
> +	     step_size < max_entries + batch_size; /* allow read partial */
>  	     step_size += batch_size) {
> -		fetch_count = step_size;
> +		fetch_count = batch_size;

The change "fetch_count = batch_size" may fail the lookup batch
operation of hash table, because the element in one bucket may be
greater than batch_size and it will return -ENOSPC constantly. And it
seems the original implementation of fetch_and_validate() is buggy,
because for hash map, the returned fetched_count may be less than the
passed count when there are too many elements in the same bucket. I
don't know the reason why the bug doesn't show up.
>  		err = delete_entries
>  		      ? bpf_map_lookup_and_delete_batch(outer_map_fd,
>  				      total_fetched ? &batch_key : NULL,
> @@ -184,18 +185,19 @@ static void fetch_and_validate(int outer_map_fd,
>  }
>  
>  static void _map_in_map_batch_ops(enum bpf_map_type outer_map_type,
> -				  enum bpf_map_type inner_map_type)
> +				  enum bpf_map_type inner_map_type,
> +				  bool has_holes)
>  {
> +	__u32 max_entries = OUTER_MAP_ENTRIES - !!has_holes;
>  	__u32 *outer_map_keys, *inner_map_fds;
> -	__u32 max_entries = OUTER_MAP_ENTRIES;
>  	LIBBPF_OPTS(bpf_map_batch_opts, opts);
>  	__u32 value_size = sizeof(__u32);
>  	int batch_size[2] = {5, 10};
>  	__u32 map_index, op_index;
>  	int outer_map_fd, ret;
>  
> -	outer_map_keys = calloc(max_entries, value_size);
> -	inner_map_fds = calloc(max_entries, value_size);
> +	outer_map_keys = calloc(OUTER_MAP_ENTRIES, value_size);
> +	inner_map_fds = calloc(OUTER_MAP_ENTRIES, value_size);
>  	CHECK((!outer_map_keys || !inner_map_fds),
>  	      "Memory allocation failed for outer_map_keys or inner_map_fds",
>  	      "error=%s\n", strerror(errno));
> @@ -209,6 +211,24 @@ static void _map_in_map_batch_ops(enum bpf_map_type outer_map_type,
>  			((outer_map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
>  			 ? 9 : 1000) - map_index;
>  
> +	/* This condition is only meaningful for array of maps.
> +	 *
> +	 * max_entries == OUTER_MAP_ENTRIES - 1 if it is true. Say
> +	 * max_entries is short for n, then outer_map_keys looks like:
> +	 *
> +	 *   [n, n-1, ... 2, 1]
> +	 *
> +	 * We change it to
> +	 *
> +	 *   [n, n-1, ... 2, 0]
> +	 *
> +	 * So it will leave key 1 as a hole. It will serve to test the
> +	 * correctness when batch on an array: a "non-exist" key might be
> +	 * actually allocated and returned from key iteration.
> +	 */
> +	if (has_holes)
> +		outer_map_keys[max_entries - 1]--;
> +
>  	/* batch operation - map_update */
>  	ret = bpf_map_update_batch(outer_map_fd, outer_map_keys,
>  				   inner_map_fds, &max_entries, &opts);
> @@ -219,12 +239,14 @@ static void _map_in_map_batch_ops(enum bpf_map_type outer_map_type,
>  	/* batch operation - map_lookup */
>  	for (op_index = 0; op_index < 2; ++op_index)
>  		fetch_and_validate(outer_map_fd, &opts,
> -				   batch_size[op_index], false);
> +				   batch_size[op_index], false,
> +				   has_holes);
>  
>  	/* batch operation - map_lookup_delete */
>  	if (outer_map_type == BPF_MAP_TYPE_HASH_OF_MAPS)
>  		fetch_and_validate(outer_map_fd, &opts,
> -				   max_entries, true /*delete*/);
> +				   max_entries, true /*delete*/,
> +				   has_holes);
>  
>  	/* close all map fds */
>  	for (map_index = 0; map_index < max_entries; map_index++)

OUTER_MAP_ENTRIES instead of max_entries ?
> @@ -237,16 +259,20 @@ static void _map_in_map_batch_ops(enum bpf_map_type outer_map_type,
>  
>  void test_map_in_map_batch_ops_array(void)
>  {
> -	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_ARRAY);
> +	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_ARRAY, false);
>  	printf("%s:PASS with inner ARRAY map\n", __func__);
> -	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_HASH);
> +	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_HASH, false);
>  	printf("%s:PASS with inner HASH map\n", __func__);
> +	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_ARRAY, true);
> +	printf("%s:PASS with inner ARRAY map with holes\n", __func__);
> +	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_HASH, true);
> +	printf("%s:PASS with inner HASH map with holes\n", __func__);
>  }
>  
>  void test_map_in_map_batch_ops_hash(void)
>  {
> -	_map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_ARRAY);
> +	_map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_ARRAY, false);
>  	printf("%s:PASS with inner ARRAY map\n", __func__);
> -	_map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_HASH);
> +	_map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_HASH, false);
>  	printf("%s:PASS with inner HASH map\n", __func__);
>  }


