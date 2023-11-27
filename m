Return-Path: <linux-kselftest+bounces-669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DC87FACB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 22:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037B41C20E16
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 21:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068AF46532;
	Mon, 27 Nov 2023 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RERa00m1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A252F51;
	Mon, 27 Nov 2023 21:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A920C433C7;
	Mon, 27 Nov 2023 21:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701121380;
	bh=CoO2w1Aaayjts+dtvAb8Eh6H5/dRtPDx1TPM+uYjYAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RERa00m1APTZ4nW8M04Rfr5i0iygE8BDQ0e6DmhSMgrHZ7Jw8YuA+xtP69/WxezsS
	 rJMo7RPAVGmSaP6y2uf2uCKw0+eW38cOjgSScmhCD+QpioQ4N661eUERXRrVP0Lsvr
	 wLF7BGf+jgv/d4EqPdkzSwHborOYqRliIGg2SYhE=
Date: Mon, 27 Nov 2023 13:42:59 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: hannes@cmpxchg.org, cerasuolodomenico@gmail.com, yosryahmed@google.com,
 sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
 muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
 kernel-team@meta.com, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v6 2/6] memcontrol: allows mem_cgroup_iter() to check
 for onlineness
Message-Id: <20231127134259.67b69ab47f4f88c9751e5222@linux-foundation.org>
In-Reply-To: <20231127193703.1980089-3-nphamcs@gmail.com>
References: <20231127193703.1980089-1-nphamcs@gmail.com>
	<20231127193703.1980089-3-nphamcs@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 11:36:59 -0800 Nhat Pham <nphamcs@gmail.com> wrote:

> The new zswap writeback scheme requires an online-only memcg hierarchy
> traversal. Add a new parameter to mem_cgroup_iter() to check for
> onlineness before returning.

I get a few build errors, perhaps because of patch timing issues...

mm/shrinker_debug.c: In function 'shrinker_debugfs_count_show':
mm/shrinker_debug.c:64:17: error: too few arguments to function 'mem_cgroup_iter'
   64 |         memcg = mem_cgroup_iter(NULL, NULL, NULL);
      |                 ^~~~~~~~~~~~~~~
In file included from mm/shrinker_debug.c:7:
./include/linux/memcontrol.h:833:20: note: declared here
  833 | struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
      |                    ^~~~~~~~~~~~~~~
mm/shrinker_debug.c:89:27: error: too few arguments to function 'mem_cgroup_iter'
   89 |         } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
      |                           ^~~~~~~~~~~~~~~
./include/linux/memcontrol.h:833:20: note: declared here
  833 | struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
      |                    ^~~~~~~~~~~~~~~
mm/damon/sysfs-schemes.c: In function 'damon_sysfs_memcg_path_to_id':
mm/damon/sysfs-schemes.c:1594:22: error: too few arguments to function 'mem_cgroup_iter'
 1594 |         for (memcg = mem_cgroup_iter(NULL, NULL, NULL); memcg;
      |                      ^~~~~~~~~~~~~~~
In file included from ./include/linux/damon.h:11,
                 from mm/damon/sysfs-common.h:8,
                 from mm/damon/sysfs-schemes.c:10:
./include/linux/memcontrol.h:833:20: note: declared here
  833 | struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
      |                    ^~~~~~~~~~~~~~~
mm/damon/sysfs-schemes.c:1595:33: error: too few arguments to function 'mem_cgroup_iter'
 1595 |                         memcg = mem_cgroup_iter(NULL, memcg, NULL)) {
      |                                 ^~~~~~~~~~~~~~~
./include/linux/memcontrol.h:833:20: note: declared here
  833 | struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
      |                    ^~~~~~~~~~~~~~~

> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -832,7 +832,7 @@ static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  
>  struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
>  				   struct mem_cgroup *,
> -				   struct mem_cgroup_reclaim_cookie *);
> +				   struct mem_cgroup_reclaim_cookie *, bool online);

How many callsites do we expect to utilize the new `online' argument? 
Few, I suspect.

How about we fix the above and simplify the patch by adding a new
mem_cgroup_iter_online() and make mem_cgroup_iter() a one-line wrapper
which calls that and adds the online=false argument?

I also saw this, didn't investigate.

drivers/android/binder_alloc.c: In function 'binder_update_page_range':
drivers/android/binder_alloc.c:237:34: error: too few arguments to function 'list_lru_del'
  237 |                         on_lru = list_lru_del(&binder_alloc_lru, &page->lru);


