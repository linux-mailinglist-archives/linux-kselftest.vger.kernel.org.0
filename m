Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F607D5C69
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 22:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbjJXUdH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 16:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjJXUdG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 16:33:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A344FE8;
        Tue, 24 Oct 2023 13:33:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cacde97002so29295885ad.2;
        Tue, 24 Oct 2023 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698179584; x=1698784384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cxd8yIiWNp4SN7aWyP2DJ3W2qpks9IKgGTIB0vbrgeM=;
        b=QSmwtJ/TnaWCy2x/1vrRGRv3cNL6OfMROTM3LJE5UppBSDaXynWgxPV4XOLgZYhHhS
         4mzUYsQvehxlRBiLhapb6/qfOWo/fDCt7xW3cfIgpmZqGVN4jZcrAYYDVCkmtc6/0cVF
         oI5kF8zh1D/YpOyt8hPmGKHvCuWNp911E27z8oDb8ghLq8IHNvgO62nNquSY79IYcucn
         TlzusmvAoPkA8LNAopK/KrdhZ/XzwVF9fd7ydcjonBLfnstG737nq4azxLCf1By2HLnC
         Ey74SkjM2C/mgfpM43Lu3WcFu5JOX2/AemC2NfEheILg6EJEaIY4oGrnqgxstPy1UpmW
         7XlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698179584; x=1698784384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cxd8yIiWNp4SN7aWyP2DJ3W2qpks9IKgGTIB0vbrgeM=;
        b=BN1vWc8xlnNjwXQzmbQyVmKR6y5fG8PjFQ1/TrdmFmXq2vCGedND/oCaMFBRRwMjKJ
         OtHOnXi+GJTX4AHMHY71jFZrkBbR0i+J26UiwCu9ygWtCDZmQRnHOTAF8Ue7TklyeEAS
         Iu4uO2FotGrL9u+FJXC/TCN9AE0YiT6rDBvPCBzOe6vi/eFAGDKR8Sv7fpMqfW9fbHQb
         nlgZTPfQW8sHek/5np7y5S1B4h1DiSsqvvPHibHbj3G9/B9v1j0ShjQCFq27vKWMaBt+
         9GicMjqi/K2BohtXTgqeRg9r9Dz0RU4+QjTDiWUXsLEV34Dd0ZCxohM7cN04CMwVoDjM
         Jhgg==
X-Gm-Message-State: AOJu0YyZdkfzfcKMxNHNph7DSyeFs5SnYnV2t4LBLoSfg4jFF2UxwCbt
        ZJRTAoAq0cfqCmxHBTTyB9M=
X-Google-Smtp-Source: AGHT+IEztSTrjikFmnkLIpiilubvgm2U1b8XxGpaC5cbdcAdlNaHKoR1ds3ApUoqcuA1b/ZOqMDgaQ==
X-Received: by 2002:a17:902:e3c1:b0:1ca:2c3b:7747 with SMTP id r1-20020a170902e3c100b001ca2c3b7747mr9349501ple.20.1698179583985;
        Tue, 24 Oct 2023 13:33:03 -0700 (PDT)
Received: from localhost (fwdproxy-prn-004.fbsv.net. [2a03:2880:ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090332d100b001c32fd9e412sm7776395plr.58.2023.10.24.13.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 13:33:03 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: [PATCH v4 0/5] workload-specific and memory pressure-driven zswap writeback
Date:   Tue, 24 Oct 2023 13:32:57 -0700
Message-Id: <20231024203302.1920362-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changelog:
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

Nhat Pham (2):
  list_lru: allows explicit memcg and NUMA node selection
  zswap: shrinks zswap pool based on memory pressure

 Documentation/admin-guide/mm/zswap.rst      |   7 +
 drivers/android/binder_alloc.c              |   5 +-
 fs/dcache.c                                 |   8 +-
 fs/gfs2/quota.c                             |   6 +-
 fs/inode.c                                  |   4 +-
 fs/nfs/nfs42xattr.c                         |   8 +-
 fs/nfsd/filecache.c                         |   4 +-
 fs/xfs/xfs_buf.c                            |   6 +-
 fs/xfs/xfs_dquot.c                          |   2 +-
 fs/xfs/xfs_qm.c                             |   2 +-
 include/linux/list_lru.h                    |  46 ++-
 include/linux/memcontrol.h                  |   5 +
 include/linux/mmzone.h                      |   2 +
 include/linux/vm_event_item.h               |   1 +
 include/linux/zswap.h                       |  25 +-
 mm/list_lru.c                               |  48 ++-
 mm/memcontrol.c                             |   1 +
 mm/mmzone.c                                 |   1 +
 mm/swap.h                                   |   3 +-
 mm/swap_state.c                             |  25 +-
 mm/vmstat.c                                 |   1 +
 mm/workingset.c                             |   4 +-
 mm/zswap.c                                  | 365 ++++++++++++++++----
 tools/testing/selftests/cgroup/test_zswap.c |  74 ++--
 24 files changed, 526 insertions(+), 127 deletions(-)

-- 
2.34.1
