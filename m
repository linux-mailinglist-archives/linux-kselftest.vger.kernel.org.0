Return-Path: <linux-kselftest+bounces-1243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124168068CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426721C210F4
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA451802B;
	Wed,  6 Dec 2023 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RG98rkGr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815BD449C
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 23:40:04 -0800 (PST)
Message-ID: <b0a56660-d269-4e54-b61e-2eac04aea24e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701848401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RLCMnEAC+ePOjl2iVkovuvFmYeessjol1ApV8elEB4s=;
	b=RG98rkGrRdXvyciaZ5Vv4XrC4+GqT/ddWAQICli27JzPU9LMEXfZFkUAgoEK//VkaI+h19
	GZn4NaITvK2c54PN6bezeIKgOAgmf/biY2yk6ADJTOuYVlzGrMPIqN4Zg4UsI9ILfhyI9n
	IA4qpS/O//SJ9q8mslbyGK7UUEaO0SU=
Date: Wed, 6 Dec 2023 15:39:54 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 6/6] zswap: shrinks zswap pool based on memory pressure
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, cerasuolodomenico@gmail.com, sjenning@redhat.com,
 ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeelb@google.com, muchun.song@linux.dev,
 chrisl@kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
References: <20231130194023.4102148-1-nphamcs@gmail.com>
 <20231130194023.4102148-7-nphamcs@gmail.com>
 <ed2792de-24cc-4037-9ee1-966cc07df57a@linux.dev>
 <CAJD7tkbiWqXs1PEZjMHO0gj5uSaaB-KNUNCiUz25MuPvzeb=wg@mail.gmail.com>
 <e55f5841-9b6e-47a1-9f68-3907ab0190e0@linux.dev>
 <CAJD7tkYkgRxDgZzCs2su7e4ocr5=zz2fjjr81+t35d_sp0E0gQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAJD7tkYkgRxDgZzCs2su7e4ocr5=zz2fjjr81+t35d_sp0E0gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2023/12/6 15:36, Yosry Ahmed wrote:
> On Tue, Dec 5, 2023 at 10:43 PM Chengming Zhou <chengming.zhou@linux.dev> wrote:
>>
>> On 2023/12/6 13:59, Yosry Ahmed wrote:
>>> [..]
>>>>> @@ -526,6 +582,102 @@ static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
>>>>>       return entry;
>>>>>  }
>>>>>
>>>>> +/*********************************
>>>>> +* shrinker functions
>>>>> +**********************************/
>>>>> +static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
>>>>> +                                    spinlock_t *lock, void *arg);
>>>>> +
>>>>> +static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
>>>>> +             struct shrink_control *sc)
>>>>> +{
>>>>> +     struct lruvec *lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
>>>>> +     unsigned long shrink_ret, nr_protected, lru_size;
>>>>> +     struct zswap_pool *pool = shrinker->private_data;
>>>>> +     bool encountered_page_in_swapcache = false;
>>>>> +
>>>>> +     nr_protected =
>>>>> +             atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
>>>>> +     lru_size = list_lru_shrink_count(&pool->list_lru, sc);
>>>>> +
>>>>> +     /*
>>>>> +      * Abort if the shrinker is disabled or if we are shrinking into the
>>>>> +      * protected region.
>>>>> +      *
>>>>> +      * This short-circuiting is necessary because if we have too many multiple
>>>>> +      * concurrent reclaimers getting the freeable zswap object counts at the
>>>>> +      * same time (before any of them made reasonable progress), the total
>>>>> +      * number of reclaimed objects might be more than the number of unprotected
>>>>> +      * objects (i.e the reclaimers will reclaim into the protected area of the
>>>>> +      * zswap LRU).
>>>>> +      */
>>>>> +     if (!zswap_shrinker_enabled || nr_protected >= lru_size - sc->nr_to_scan) {
>>>>> +             sc->nr_scanned = 0;
>>>>> +             return SHRINK_STOP;
>>>>> +     }
>>>>> +
>>>>> +     shrink_ret = list_lru_shrink_walk(&pool->list_lru, sc, &shrink_memcg_cb,
>>>>> +             &encountered_page_in_swapcache);
>>>>> +
>>>>> +     if (encountered_page_in_swapcache)
>>>>> +             return SHRINK_STOP;
>>>>> +
>>>>> +     return shrink_ret ? shrink_ret : SHRINK_STOP;
>>>>> +}
>>>>> +
>>>>> +static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
>>>>> +             struct shrink_control *sc)
>>>>> +{
>>>>> +     struct zswap_pool *pool = shrinker->private_data;
>>>>> +     struct mem_cgroup *memcg = sc->memcg;
>>>>> +     struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
>>>>> +     unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
>>>>> +
>>>>> +#ifdef CONFIG_MEMCG_KMEM
>>>>> +     cgroup_rstat_flush(memcg->css.cgroup);
>>>>> +     nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
>>>>> +     nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
>>>>> +#else
>>>>> +     /* use pool stats instead of memcg stats */
>>>>> +     nr_backing = get_zswap_pool_size(pool) >> PAGE_SHIFT;
>>>>> +     nr_stored = atomic_read(&pool->nr_stored);
>>>>> +#endif
>>>>> +
>>>>> +     if (!zswap_shrinker_enabled || !nr_stored)
>>>> When I tested with this series, with !zswap_shrinker_enabled in the default case,
>>>> I found the performance is much worse than that without this patch.
>>>>
>>>> Testcase: memory.max=2G, zswap enabled, kernel build -j32 in a tmpfs directory.
>>>>
>>>> The reason seems the above cgroup_rstat_flush(), caused much rstat lock contention
>>>> to the zswap_store() path. And if I put the "zswap_shrinker_enabled" check above
>>>> the cgroup_rstat_flush(), the performance become much better.
>>>>
>>>> Maybe we can put the "zswap_shrinker_enabled" check above cgroup_rstat_flush()?
>>>
>>> Yes, we should do nothing if !zswap_shrinker_enabled. We should also
>>> use mem_cgroup_flush_stats() here like other places unless accuracy is
>>> crucial, which I doubt given that reclaim uses
>>> mem_cgroup_flush_stats().
>>>
>>
>> Yes. After changing to use mem_cgroup_flush_stats() here, the performance
>> become much better.
>>
>>> mem_cgroup_flush_stats() has some thresholding to make sure we don't
>>> do flushes unnecessarily, and I have a pending series in mm-unstable
>>> that makes that thresholding per-memcg. Keep in mind that adding a
>>> call to mem_cgroup_flush_stats() will cause a conflict in mm-unstable,
>>
>> My test branch is linux-next 20231205, and it's all good after changing
>> to use mem_cgroup_flush_stats(memcg).
> 
> Thanks for reporting back. We should still move the
> zswap_shrinker_enabled check ahead, no need to even call
> mem_cgroup_flush_stats() if we will do nothing anyway.
> 

Yes, agree!


