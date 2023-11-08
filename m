Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E6B7E5FCF
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 22:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjKHVPc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 16:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHVPb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 16:15:31 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822192102;
        Wed,  8 Nov 2023 13:15:29 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3594149e3a1so735555ab.1;
        Wed, 08 Nov 2023 13:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699478129; x=1700082929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNB5xgB/4KCWfHCIWPGT/LuL6VAHs2IvczalgrNNVZI=;
        b=iDkvEOjT5P1p3MCN332t4zdsmsTozZi/G7NQ6TGxCNHtpCczdCj4nQPuQ7+4BF/yzZ
         IDGpShe27AEpCfZoaAEkmMqnWZ7MLkNRMXy/EAUUVUB5F3oF8ZUWT/b8rr8ST76Kr3Hu
         2+QbBdsp3eulhNqa8ImcOb+87GnkGaBj8byD93t20ysMEC3sslX7B2DeTBQ8qN91K9Zm
         eJaDlcx1StsARklsFqCRDVEC7CeJi6kouK0A98OVKmXQYOiGY0mX8nCyERsb0OA55fZ6
         nSWcQ/VNxVh2EKdBGEd08RRxM+k2N6yjK7fM5PQtluvZAl77i0GWHnvOp1H/1Q82djdV
         UEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699478129; x=1700082929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNB5xgB/4KCWfHCIWPGT/LuL6VAHs2IvczalgrNNVZI=;
        b=Na29tbbtqO7LkWuz7A7AZ0L0ZxBXyF8x0K2pKgM3WW89uVb0TxQTAVbohfll7mvHxa
         /TNoYXJ/AWF3fC5aDriXlVq86OIdBayV/i83gRjpJCbXzt3eLsjrNH8183e6qWIkWG1q
         p862n7XuL41LMz8WTbj+is9grygTp10Sn0XB0I4uThy7+ZWbZDeoe0b/3e8EEhUdmGPS
         qg+HmK17S1iKlV2clgNrTP8oyNGCCMdEtd+0tS3FxGoXcpzVvI9qAL75Je+ulc1QOpP4
         7wh0If6+/U0QMmNDpnBD2/9dIkUf+i21NrapphmRAfZdxHVDeZa7dtk3FkUI5z16CcwQ
         7LRQ==
X-Gm-Message-State: AOJu0YzUGfvYewu3y3WwU7J4bNNne47P85MYb53RNWSIP6inocVSBWqI
        5mnxTxz/PpB5rRLlAenxUsj9nGaFwATE2lVp3x8=
X-Google-Smtp-Source: AGHT+IHe/1lyuB2mxHD2Axz/XufuKF2H5f0zlaOMzfp6dlNa22DkngFGfB5vfPFkwUkqgFrltkCFDbnnmgolFmmYxjo=
X-Received: by 2002:a05:6e02:12e6:b0:359:50c2:62b6 with SMTP id
 l6-20020a056e0212e600b0035950c262b6mr3329153iln.12.1699478128763; Wed, 08 Nov
 2023 13:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20231106183159.3562879-1-nphamcs@gmail.com> <CAF8kJuMsXUm9=kiL8qPNVfYPzfyq-JWYSH3KraZadjF+myW-2A@mail.gmail.com>
In-Reply-To: <CAF8kJuMsXUm9=kiL8qPNVfYPzfyq-JWYSH3KraZadjF+myW-2A@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 8 Nov 2023 13:15:17 -0800
Message-ID: <CAKEwX=MNKY0UHbxi6Zfwf0KkepYavFaZo8F6LGe5GyyE3U35Jg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] workload-specific and memory pressure-driven zswap writeback
To:     Chris Li <chrisl@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, mhocko@kernel.org,
        roman.gushchin@linux.dev, Shakeel Butt <shakeelb@google.com>,
        muchun.song@linux.dev, linux-mm <linux-mm@kvack.org>,
        kernel-team@meta.com, LKML <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 8, 2023 at 11:46=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Nhat,
>
> Sorry for being late to the party. I want to take a look at your patches =
series.
> However I wasn't able to "git am" your patches series cleanly on current
> mm-stable, mm-unstable or linux tip.
>
> $ git am patches/v5_20231106_nphamcs_workload_specific_and_memory_pressur=
e_driven_zswap_writeback.mbx
> Applying: list_lru: allows explicit memcg and NUMA node selection
> Applying: memcontrol: allows mem_cgroup_iter() to check for onlineness
> Applying: zswap: make shrinking memcg-aware (fix)
> error: patch failed: mm/zswap.c:174
> error: mm/zswap.c: patch does not apply
> Patch failed at 0003 zswap: make shrinking memcg-aware (fix)

Ah that was meant to be a fixlet - so that on top of the original
"zswap: make shrinking memcg-aware" patch. The intention was
to eventually squash it...

But this is getting a bit annoyingly confusing, I admit. I just rebased to
mm-unstable + squashed it all again, then sent one single replacement
patch:

[PATCH v5 3/6 REPLACE] zswap: make shrinking memcg-aware

Let me know if this still fails to apply. If not, I'll send the whole thing
again as v6! My sincerest apologies for the troubles and confusion :(


>
> What is the base of your patches? A git hash or a branch I can pull
> from would be
> nice.
>
> Thanks
>
> Chris
>
> On Mon, Nov 6, 2023 at 10:32=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > Changelog:
> > v5:
> >    * Replace reference getting with an rcu_read_lock() section for
> >      zswap lru modifications (suggested by Yosry)
> >    * Add a new prep patch that allows mem_cgroup_iter() to return
> >      online cgroup.
> >    * Add a callback that updates pool->next_shrink when the cgroup is
> >      offlined (suggested by Yosry Ahmed, Johannes Weiner)
> > v4:
> >    * Rename list_lru_add to list_lru_add_obj and __list_lru_add to
> >      list_lru_add (patch 1) (suggested by Johannes Weiner and
> >          Yosry Ahmed)
> >    * Some cleanups on the memcg aware LRU patch (patch 2)
> >      (suggested by Yosry Ahmed)
> >    * Use event interface for the new per-cgroup writeback counters.
> >      (patch 3) (suggested by Yosry Ahmed)
> >    * Abstract zswap's lruvec states and handling into
> >      zswap_lruvec_state (patch 5) (suggested by Yosry Ahmed)
> > v3:
> >    * Add a patch to export per-cgroup zswap writeback counters
> >    * Add a patch to update zswap's kselftest
> >    * Separate the new list_lru functions into its own prep patch
> >    * Do not start from the top of the hierarchy when encounter a memcg
> >      that is not online for the global limit zswap writeback (patch 2)
> >      (suggested by Yosry Ahmed)
> >    * Do not remove the swap entry from list_lru in
> >      __read_swapcache_async() (patch 2) (suggested by Yosry Ahmed)
> >    * Removed a redundant zswap pool getting (patch 2)
> >      (reported by Ryan Roberts)
> >    * Use atomic for the nr_zswap_protected (instead of lruvec's lock)
> >      (patch 5) (suggested by Yosry Ahmed)
> >    * Remove the per-cgroup zswap shrinker knob (patch 5)
> >      (suggested by Yosry Ahmed)
> > v2:
> >    * Fix loongarch compiler errors
> >    * Use pool stats instead of memcg stats when !CONFIG_MEMCG_KEM
> >
> > There are currently several issues with zswap writeback:
> >
> > 1. There is only a single global LRU for zswap, making it impossible to
> >    perform worload-specific shrinking - an memcg under memory pressure
> >    cannot determine which pages in the pool it owns, and often ends up
> >    writing pages from other memcgs. This issue has been previously
> >    observed in practice and mitigated by simply disabling
> >    memcg-initiated shrinking:
> >
> >    https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.c=
om/T/#u
> >
> >    But this solution leaves a lot to be desired, as we still do not
> >    have an avenue for an memcg to free up its own memory locked up in
> >    the zswap pool.
> >
> > 2. We only shrink the zswap pool when the user-defined limit is hit.
> >    This means that if we set the limit too high, cold data that are
> >    unlikely to be used again will reside in the pool, wasting precious
> >    memory. It is hard to predict how much zswap space will be needed
> >    ahead of time, as this depends on the workload (specifically, on
> >    factors such as memory access patterns and compressibility of the
> >    memory pages).
> >
> > This patch series solves these issues by separating the global zswap
> > LRU into per-memcg and per-NUMA LRUs, and performs workload-specific
> > (i.e memcg- and NUMA-aware) zswap writeback under memory pressure. The
> > new shrinker does not have any parameter that must be tuned by the
> > user, and can be opted in or out on a per-memcg basis.
> >
> > As a proof of concept, we ran the following synthetic benchmark:
> > build the linux kernel in a memory-limited cgroup, and allocate some
> > cold data in tmpfs to see if the shrinker could write them out and
> > improved the overall performance. Depending on the amount of cold data
> > generated, we observe from 14% to 35% reduction in kernel CPU time used
> > in the kernel builds.
> >
> > Domenico Cerasuolo (3):
> >   zswap: make shrinking memcg-aware
> >   mm: memcg: add per-memcg zswap writeback stat
> >   selftests: cgroup: update per-memcg zswap writeback selftest
> >
> > Nhat Pham (3):
> >   list_lru: allows explicit memcg and NUMA node selection
> >   memcontrol: allows mem_cgroup_iter() to check for onlineness
> >   zswap: shrinks zswap pool based on memory pressure
> >
> >  Documentation/admin-guide/mm/zswap.rst      |   7 +
> >  drivers/android/binder_alloc.c              |   5 +-
> >  fs/dcache.c                                 |   8 +-
> >  fs/gfs2/quota.c                             |   6 +-
> >  fs/inode.c                                  |   4 +-
> >  fs/nfs/nfs42xattr.c                         |   8 +-
> >  fs/nfsd/filecache.c                         |   4 +-
> >  fs/xfs/xfs_buf.c                            |   6 +-
> >  fs/xfs/xfs_dquot.c                          |   2 +-
> >  fs/xfs/xfs_qm.c                             |   2 +-
> >  include/linux/list_lru.h                    |  46 ++-
> >  include/linux/memcontrol.h                  |   9 +-
> >  include/linux/mmzone.h                      |   2 +
> >  include/linux/vm_event_item.h               |   1 +
> >  include/linux/zswap.h                       |  27 +-
> >  mm/list_lru.c                               |  48 ++-
> >  mm/memcontrol.c                             |  20 +-
> >  mm/mmzone.c                                 |   1 +
> >  mm/shrinker.c                               |   4 +-
> >  mm/swap.h                                   |   3 +-
> >  mm/swap_state.c                             |  26 +-
> >  mm/vmscan.c                                 |  26 +-
> >  mm/vmstat.c                                 |   1 +
> >  mm/workingset.c                             |   4 +-
> >  mm/zswap.c                                  | 430 +++++++++++++++++---
> >  tools/testing/selftests/cgroup/test_zswap.c |  74 ++--
> >  26 files changed, 625 insertions(+), 149 deletions(-)
> >
> > --
> > 2.34.1
> >
