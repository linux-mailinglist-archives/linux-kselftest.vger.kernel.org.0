Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940997CD053
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 01:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjJQXV4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 19:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjJQXVz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 19:21:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF04892;
        Tue, 17 Oct 2023 16:21:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9b1e3a809so41668775ad.2;
        Tue, 17 Oct 2023 16:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697584913; x=1698189713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AsfyhFO7p0RUOzLnEBAeg12shRu5DCBIJmIbrYlrbQQ=;
        b=ns0iD/hOCcWTWTlQVQcycHbUcZ1ZD0Zc7E/uQqm9vO7D5+obLV9YL1e3z+5O4fivBr
         ZGamCI/SjnI3p1jNIjAl8wcr0g0HKHa9IMdInrIhKwHebYsDbzQ5tfU9CXLE6JTqKW6W
         piq/BFsAS81fPEl5uP29w9DhrWzxWu2+MqjAArHrccfIQxG2EUOj2zglF1rizE6epjjm
         o2cYoowY0/Yzwp+xRL4+7HM5QvDb1lWc6oKSmwuhEKYDYh84vKhlve8SE9FGBVTfgLlA
         7bYcui2qM6+/Esh74ufzBrzPjXVsKMWW+P1BITsXDkZB35QWJ1gXKCfSlC2xJo59OdgM
         3S6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697584913; x=1698189713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsfyhFO7p0RUOzLnEBAeg12shRu5DCBIJmIbrYlrbQQ=;
        b=s30EHQe2I0FXHeqUTCjhlHRnKvL9Lzzhc/F9xYcMay5g2eKec+8UgFjkS0jisvYPOR
         BXZQQqZsFJr90A2AtjOuN4Rti/GO9HIVKmBmBV0AOmNwtohl1ow+e0i0LFAUJU3Uj7kk
         spndV4uOM0PdCYgMjks+lB8J8CKVm/fnS26DmSaS18WuN0BD7HNweIGyZgMSS3L8Dg85
         ZQBe5guM7Ozsp1lehBqyObWnBcs4qStROLHod9biv845nqj8fFN7ZRWCwC43+5yvI//p
         6a1j+URdx9AoGTO4Aons06MiRsOxdZAMI4JBa3ADc2mMbCg01K4UESX+xR4mGaiT6Qmc
         LcfA==
X-Gm-Message-State: AOJu0YxmXurtUOtrBI4HlSGACj14D/imKIuTPN7b9X3153ylya1uP9F5
        bo844juf2woMBT8ngSYe2TQ=
X-Google-Smtp-Source: AGHT+IEB1bkpliZr4/0wwEWk35bjMHS8jcWP7je173r3nrnISt5OHU2yyH0fIdSym0BtiLsCs5IyAQ==
X-Received: by 2002:a17:902:e5c6:b0:1ca:8abd:6b52 with SMTP id u6-20020a170902e5c600b001ca8abd6b52mr4311445plf.69.1697584913016;
        Tue, 17 Oct 2023 16:21:53 -0700 (PDT)
Received: from localhost (fwdproxy-prn-003.fbsv.net. [2a03:2880:ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id t9-20020a1709028c8900b001b8a00d4f7asm2126736plo.9.2023.10.17.16.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 16:21:52 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH v3 0/5] workload-specific and memory pressure-driven zswap writeback
Date:   Tue, 17 Oct 2023 16:21:47 -0700
Message-Id: <20231017232152.2605440-1-nphamcs@gmail.com>
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
  mm: list_lru: allow external numa node and cgroup tracking
  zswap: shrinks zswap pool based on memory pressure

 Documentation/admin-guide/mm/zswap.rst      |   7 +
 include/linux/list_lru.h                    |  38 +++
 include/linux/memcontrol.h                  |   7 +
 include/linux/mmzone.h                      |  14 +
 mm/list_lru.c                               |  43 ++-
 mm/memcontrol.c                             |  15 +
 mm/mmzone.c                                 |   3 +
 mm/swap.h                                   |   3 +-
 mm/swap_state.c                             |  38 ++-
 mm/zswap.c                                  | 335 ++++++++++++++++----
 tools/testing/selftests/cgroup/test_zswap.c |  74 +++--
 11 files changed, 485 insertions(+), 92 deletions(-)

-- 
2.34.1
