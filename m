Return-Path: <linux-kselftest+bounces-26066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AA6A2D262
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 01:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46880188E24B
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 00:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295BF8479;
	Sat,  8 Feb 2025 00:51:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D897483;
	Sat,  8 Feb 2025 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738975918; cv=none; b=E3u773UKx19D40kQnvVo8S5nLqgCoUkquJLulXkNlD1Pwx8R8gwrPHqg9ooR0RoeAkK3BD8KHFIsM37WVw5gHRS3uxHdxxiBm74wujjvMKi6svq8vMAlXZ+O6a6u12sMmVB1uL7cZpmWZAfb+tBoV8VGl+4NC3gIfrA0BOixZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738975918; c=relaxed/simple;
	bh=KSJlU7RWSwAN128E+ekyLcOzzpRnsUlM1weHPm1sTnI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UrQt70pmTcNkAFuOQGhiR8cgicQaWRIxbKq+6XL53MA0pEAXl0p1wmhXvt6Duql2carwXroZlZqlg4XqcSKAEgyRSo0h9cS4N1RPV+qPDupgBT8QPX5yxeVAsu5WaI9pTHgc71eEjOCrInnyafCkHNIJVEwIOxMUm/rXyvh0QMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YqXN20mvZz4f3jcs;
	Sat,  8 Feb 2025 08:51:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4F3F41A0C33;
	Sat,  8 Feb 2025 08:51:51 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgCXN8KhqqZnzrKwDA--.58958S2;
	Sat, 08 Feb 2025 08:51:49 +0800 (CST)
Subject: Re: [PATCH v2 bpf 1/2] bpf: skip non exist keys in
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
References: <cover.1738905497.git.yan@cloudflare.com>
 <177c4a3417d848aa9d72158e235be7d6b6f43915.1738905497.git.yan@cloudflare.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a74970e1-9545-a975-3501-cfb17277f303@huaweicloud.com>
Date: Sat, 8 Feb 2025 08:51:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <177c4a3417d848aa9d72158e235be7d6b6f43915.1738905497.git.yan@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgCXN8KhqqZnzrKwDA--.58958S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr13Xry8ArW8ZFWDXFy7Wrg_yoWrGr4kpF
	WrGF13Jw18ur4Iqw4Fqa1kWFy8Aw48Gr15Ga95t3sYkrn3Wry2kr10gaya9rW5Cr10vw4S
	vr4jvF9Ygw12yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2/7/2025 1:45 PM, Yan Zhai wrote:
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
> existing element, skip to the next key. This simple solution comes with
> a price that transient errors may not be recovered, and the iteration
> might cycle back to the first key under parallel deletion. For example,
> Hou Tao <houtao@huaweicloud.com> pointed out a following scenario:
>
> For LPM trie map:
> (1) ->map_get_next_key(map, prev_key, key) returns a valid key
>
> (2) bpf_map_copy_value() return -ENOMENT
> It means the key must be deleted concurrently.
>
> (3) goto next_key
> It swaps the prev_key and key
>
> (4) ->map_get_next_key(map, prev_key, key) again
> prev_key points to a non-existing key, for LPM trie it will treat just
> like prev_key=NULL case, the returned key will be duplicated.
>
> With the retry logic, the iteration can continue to the key next to the
> deleted one. But if we directly skip to the next key, the iteration loop
> would restart from the first key for the lpm_trie type.
>
> However, not all races may be recovered. For example, if current key is
> deleted after instead of before bpf_map_copy_value, or if the prev_key
> also gets deleted, then the loop will still restart from the first key
> for lpm_tire anyway. For generic lookup it might be better to stay
> simple, i.e. just skip to the next key. To guarantee that the output
> keys are not duplicated, it is better to implement map type specific
> batch operations, which can properly lock the trie and synchronize with
> concurrent mutators.

Make sense.

>
> Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")
> Closes: https://lore.kernel.org/bpf/Z6JXtA1M5jAZx8xD@debian.debian/
> Signed-off-by: Yan Zhai <yan@cloudflare.com>

Acked-by: Hou Tao <houtao1@huawei.com>
> ---
> v1->v2: incorporate more useful information inside commit message.
> v1: https://lore.kernel.org/bpf/Z6OYbS4WqQnmzi2z@debian.debian/
> ---
>  kernel/bpf/syscall.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c420edbfb7c8..5d0a4db6fb85 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1979,8 +1979,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
>  	void __user *values = u64_to_user_ptr(attr->batch.values);
>  	void __user *keys = u64_to_user_ptr(attr->batch.keys);
>  	void *buf, *buf_prevkey, *prev_key, *key, *value;
> -	int err, retry = MAP_LOOKUP_RETRIES;
>  	u32 value_size, cp, max_count;
> +	int err;
>  
>  	if (attr->batch.elem_flags & ~BPF_F_LOCK)
>  		return -EINVAL;
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


