Return-Path: <linux-kselftest+bounces-897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E167FFB87
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 20:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CFA281951
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 19:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB91052F86;
	Thu, 30 Nov 2023 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdEX7CGx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9412310C2;
	Thu, 30 Nov 2023 11:40:24 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cbc8199a2aso1344588b3a.1;
        Thu, 30 Nov 2023 11:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701373224; x=1701978024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+x/LKk3FvB937MhuGOYKQ0IyJa8w9wJ6MIupisyP6ic=;
        b=fdEX7CGxk8YfyCpaTW62ot1p4dxtElp/J0yIsxi8w33EzmxUrgJ8Nj4RNJBpgjGOde
         /abS5d/k9l+KLa7z2Cv6UfyK3OBadUVfqMRDn1p3+bmtrB0QZfyxyeMfYcpKNtmwO7VT
         mkmO7dQNskF/iyJ+9fpCJwW9NWDP2YfWWKidDKBGHJhkNAfX+EddeLTklAOs98nitQbq
         62JFEPvuSBlD2Dk0Su55ZsgrcLfnPW8VRMCyvNJuuJUPdppd/tH4Ae8wJpXnWYjH9Vyw
         wigPFru1UnDFvygG1AwnrBhevUhboR9D1QFeoV90zvKoTm+ujU37YnRj4VGGy1ARysv2
         CWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373224; x=1701978024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+x/LKk3FvB937MhuGOYKQ0IyJa8w9wJ6MIupisyP6ic=;
        b=gI4pp+vUtYfsywE/CFQdF/5bnciwtxeRQ8jLW31gD2cADmsx7dyis2Li5Auzcg8RHe
         ciKycFMAlcgDpV+6gFQa7kgbT1khx/C1yqsZdwQOAoM3sBDxCxR1o8EQS+aPOcJO/mg+
         LzxXLg2WIF13yN9GeAct6MScnG6nUP74sWmNxg68Lt3EYBjgVCBZ/KllsHBArNs86p3f
         48huZNqPiuAYf97Fqj2zEnPQviM+prFmHuJ5/zMWkW/o7B8nlP3Nicl3cxMGAWhn+Nwj
         hFeLZsXwC2q7rkDOzzj5zgk6znGX5cqKCjx4EHI2YZjUhqy8DELHP9zoHJ4kZeAyizFW
         /+/A==
X-Gm-Message-State: AOJu0YwVUWMY3ZV57mxeYrLA8Fs3o4vUDay4Sfi9htl5BLaFWoDMtxJr
	S66GAO01dU4L4BgZx1S7KT4=
X-Google-Smtp-Source: AGHT+IEmdSdnMH+kII1N7XUeBVLX4vq3m9jYQohZEcsNhiLq8IQwMxJyAHsNE5doFtymTJtoJnEBZg==
X-Received: by 2002:a05:6a00:2e19:b0:6cb:a431:2d75 with SMTP id fc25-20020a056a002e1900b006cba4312d75mr27388691pfb.7.1701373223877;
        Thu, 30 Nov 2023 11:40:23 -0800 (PST)
Received: from localhost (fwdproxy-prn-002.fbsv.net. [2a03:2880:ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id n5-20020a056a000d4500b006c341cf08f9sm1641980pfv.140.2023.11.30.11.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:40:23 -0800 (PST)
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
Subject: [PATCH v8 0/6] workload-specific and memory pressure-driven zswap writeback
Date: Thu, 30 Nov 2023 11:40:17 -0800
Message-Id: <20231130194023.4102148-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v8:
   * Fixed a couple of build errors in the case of !CONFIG_MEMCG
   * Simplified the online memcg selection scheme for the zswap global
     limit reclaim (suggested by Michal Hocko and Johannes Weiner)
     (patch 2 and patch 3)
   * Added a new kconfig to allows users to enable zswap shrinker by
     default. (suggested by Johannes Weiner) (patch 6)
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
  memcontrol: implement mem_cgroup_tryget_online()
  zswap: shrinks zswap pool based on memory pressure

 Documentation/admin-guide/mm/zswap.rst      |  10 +
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
 include/linux/memcontrol.h                  |  15 +
 include/linux/mmzone.h                      |   2 +
 include/linux/vm_event_item.h               |   1 +
 include/linux/zswap.h                       |  27 +-
 mm/Kconfig                                  |  14 +
 mm/list_lru.c                               |  48 ++-
 mm/memcontrol.c                             |   3 +
 mm/mmzone.c                                 |   1 +
 mm/swap.h                                   |   3 +-
 mm/swap_state.c                             |  26 +-
 mm/vmstat.c                                 |   1 +
 mm/workingset.c                             |   4 +-
 mm/zswap.c                                  | 456 +++++++++++++++++---
 tools/testing/selftests/cgroup/test_zswap.c |  74 ++--
 25 files changed, 661 insertions(+), 125 deletions(-)


base-commit: 5cdba94229e58a39ca389ad99763af29e6b0c5a5
-- 
2.34.1

