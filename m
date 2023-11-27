Return-Path: <linux-kselftest+bounces-677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413197FAE91
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 00:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB08281732
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 23:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CCD49F75;
	Mon, 27 Nov 2023 23:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MENJJqiM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91337187;
	Mon, 27 Nov 2023 15:46:01 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfbda041f3so18615905ad.2;
        Mon, 27 Nov 2023 15:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701128761; x=1701733561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0naXIH0JGObfzirOc6Nz1+BDeP5C+xEUqfta7BLJ2ro=;
        b=MENJJqiM4GCznY2jincowkWiC2ussM3wPWwLZHmgqj6RKY0Xu4RkztypVtHY5YpBMP
         TBMhngz42ASS5EbG2CAyVpRGfZcUwmPWl8CNiUdracrdc/gnFj4EuIKrtv+dQ3UO80Jt
         ximg+5cf8BHlQe2Rjd7HlRhcoXlAvJL/L0Z32T8OxEgDoIvmuaYvOlUqVxnk79ScG149
         +DkepOOCDBQhGC48azx9B1zJdVnSurIzxxF4Xgt9tWezMmNezp428RI9e1HzepzOXfco
         VtiDUOVstxYLY1/nCGyxd8IA+s0uOp85ga0c0cQJm6n2Sya5mkTI9jn8Y3b8UrE4qMvi
         C9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701128761; x=1701733561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0naXIH0JGObfzirOc6Nz1+BDeP5C+xEUqfta7BLJ2ro=;
        b=q5XiS7XTAUG9BYpKBCsxTk34rQ0qNCY988kn7YhseALRu/G9Sr/sx4Q/EOmPD63wJA
         pdzqrpM33G2FpLby3YE9BbLq99Q6AxwdHxiDPU9H8K4jyq7cMC3NoRsVPJ6swIcgc/OR
         yCbTysqMVSDyo+uF4P11yZVaMfu8lv6eAhgffJKndNGPjgH9/4TNYoncp9OFcX1CU1yk
         fSEA7tnz/9vYd18EhPJ87U7wpSi2CmVgSoEUPZIFA9UQ1g8wgZ+upKlFoSMXwph+koN0
         mBMIjP8HC0mUBGiQrnAqdP5YqyYkBzz4Ddz3uXIKDvn6teBXTIka3Sy9uCTaiKjNqLwm
         Zn4w==
X-Gm-Message-State: AOJu0Ywn0YxyvVmXZ8P8Kt5neUEpe4HKg/ihktgVinQ465zrWmBWvdoy
	4vWZdi1/vWCt6GbE4Txz0bY=
X-Google-Smtp-Source: AGHT+IG4eMKvbXes5v/gD3pRMvH+WaXrJYYV2FbfNJ0lvXkjI+dG00dYmERvEMll3xJo4Y61Ab/OvA==
X-Received: by 2002:a17:902:a707:b0:1cf:f1a0:c600 with SMTP id w7-20020a170902a70700b001cff1a0c600mr1039143plq.33.1701128760949;
        Mon, 27 Nov 2023 15:46:00 -0800 (PST)
Received: from localhost (fwdproxy-prn-020.fbsv.net. [2a03:2880:ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001ca86a9caccsm8857868pld.228.2023.11.27.15.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 15:46:00 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	cerasuolodomenico@gmail.com,
	yosryahmed@google.com,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	chrisl@kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH v7 0/6] workload-specific and memory pressure-driven zswap writeback
Date: Mon, 27 Nov 2023 15:45:54 -0800
Message-Id: <20231127234600.2971029-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v7:
   * Added the mem_cgroup_iter_online() function to the API for the new
     behavior (suggested by Andrew Morton) (patch 2)
   * Fixed a missing list_lru_del -> list_lru_del_obj (patch 1)
v6:
   * Rebase on top of latest mm-unstable.
   * Fix/improve the in-code documentation of the new list_lru
     manipulation functions (patch 1)
v5:
   * Replace reference getting with an rcu_read_lock() section for
     zswap lru modifications (suggested by Yosry)
   * Add a new prep patch that allows mem_cgroup_iter() to return
     online cgroup.
   * Add a callback that updates pool->next_shrink when the cgroup is
     offlined (suggested by Yosry Ahmed, Johannes Weiner)
v4:
   * Rename list_lru_add to list_lru_add_obj and __list_lru_add to
     list_lru_add (patch 1) (suggested by Johannes Weiner and
	 Yosry Ahmed)
   * Some cleanups on the memcg aware LRU patch (patch 2)
     (suggested by Yosry Ahmed)
   * Use event interface for the new per-cgroup writeback counters.
     (patch 3) (suggested by Yosry Ahmed)
   * Abstract zswap's lruvec states and handling into 
     zswap_lruvec_state (patch 5) (suggested by Yosry Ahmed)
v3:
   * Add a patch to export per-cgroup zswap writeback counters
   * Add a patch to update zswap's kselftest
   * Separate the new list_lru functions into its own prep patch
   * Do not start from the top of the hierarchy when encounter a memcg
     that is not online for the global limit zswap writeback (patch 2)
     (suggested by Yosry Ahmed)
   * Do not remove the swap entry from list_lru in
     __read_swapcache_async() (patch 2) (suggested by Yosry Ahmed)
   * Removed a redundant zswap pool getting (patch 2)
     (reported by Ryan Roberts)
   * Use atomic for the nr_zswap_protected (instead of lruvec's lock)
     (patch 5) (suggested by Yosry Ahmed)
   * Remove the per-cgroup zswap shrinker knob (patch 5)
     (suggested by Yosry Ahmed)
v2:
   * Fix loongarch compiler errors
   * Use pool stats instead of memcg stats when !CONFIG_MEMCG_KEM

There are currently several issues with zswap writeback:

1. There is only a single global LRU for zswap, making it impossible to
   perform worload-specific shrinking - an memcg under memory pressure
   cannot determine which pages in the pool it owns, and often ends up
   writing pages from other memcgs. This issue has been previously
   observed in practice and mitigated by simply disabling
   memcg-initiated shrinking:

   https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.com/T/#u

   But this solution leaves a lot to be desired, as we still do not
   have an avenue for an memcg to free up its own memory locked up in
   the zswap pool.

2. We only shrink the zswap pool when the user-defined limit is hit.
   This means that if we set the limit too high, cold data that are
   unlikely to be used again will reside in the pool, wasting precious
   memory. It is hard to predict how much zswap space will be needed
   ahead of time, as this depends on the workload (specifically, on
   factors such as memory access patterns and compressibility of the
   memory pages).

This patch series solves these issues by separating the global zswap
LRU into per-memcg and per-NUMA LRUs, and performs workload-specific
(i.e memcg- and NUMA-aware) zswap writeback under memory pressure. The
new shrinker does not have any parameter that must be tuned by the
user, and can be opted in or out on a per-memcg basis.

As a proof of concept, we ran the following synthetic benchmark:
build the linux kernel in a memory-limited cgroup, and allocate some
cold data in tmpfs to see if the shrinker could write them out and
improved the overall performance. Depending on the amount of cold data
generated, we observe from 14% to 35% reduction in kernel CPU time used
in the kernel builds.

Domenico Cerasuolo (3):
  zswap: make shrinking memcg-aware
  mm: memcg: add per-memcg zswap writeback stat
  selftests: cgroup: update per-memcg zswap writeback selftest

Nhat Pham (3):
  list_lru: allows explicit memcg and NUMA node selection
  memcontrol: add a new function to traverse online-only memcg hierarchy
  zswap: shrinks zswap pool based on memory pressure

 Documentation/admin-guide/mm/zswap.rst      |   7 +
 drivers/android/binder_alloc.c              |   7 +-
 fs/dcache.c                                 |   8 +-
 fs/gfs2/quota.c                             |   6 +-
 fs/inode.c                                  |   4 +-
 fs/nfs/nfs42xattr.c                         |   8 +-
 fs/nfsd/filecache.c                         |   4 +-
 fs/xfs/xfs_buf.c                            |   6 +-
 fs/xfs/xfs_dquot.c                          |   2 +-
 fs/xfs/xfs_qm.c                             |   2 +-
 include/linux/list_lru.h                    |  54 ++-
 include/linux/memcontrol.h                  |  18 +
 include/linux/mmzone.h                      |   2 +
 include/linux/vm_event_item.h               |   1 +
 include/linux/zswap.h                       |  27 +-
 mm/list_lru.c                               |  48 ++-
 mm/memcontrol.c                             |  32 +-
 mm/mmzone.c                                 |   1 +
 mm/swap.h                                   |   3 +-
 mm/swap_state.c                             |  26 +-
 mm/vmstat.c                                 |   1 +
 mm/workingset.c                             |   4 +-
 mm/zswap.c                                  | 426 +++++++++++++++++---
 tools/testing/selftests/cgroup/test_zswap.c |  74 ++--
 24 files changed, 641 insertions(+), 130 deletions(-)


base-commit: 5cdba94229e58a39ca389ad99763af29e6b0c5a5
-- 
2.34.1

