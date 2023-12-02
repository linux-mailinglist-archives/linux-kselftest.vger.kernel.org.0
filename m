Return-Path: <linux-kselftest+bounces-1019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E804801ABE
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 05:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87158281E0A
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 04:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CEA5688;
	Sat,  2 Dec 2023 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3gyfexm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D722D48;
	Fri,  1 Dec 2023 20:44:25 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d01c45ffebso11164545ad.1;
        Fri, 01 Dec 2023 20:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701492264; x=1702097064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkjJumzQC9OLzeUlKf2cdrps8W5WGvu5yds3ov88Mec=;
        b=E3gyfexmpid1Z4GSpO06PN8FOE2ZoHik1iF+WMU/TZDtOy6J2933XcvQVhHv86SsTv
         qxtTGC+I9tMSyeyFIU6OauXFQrzsbFhcM5AXHWy8caZj5fDPkCOslRAZ/sNXWRCB0gjR
         MRLpk3ld2O6NTW80CQDis9Cjbv+vzAJAlgMGOvMXYSc2eIMejeg1ggZjo9mTxL+OTcpm
         RtspADyevomAD4sUpqbOw0sB680OKA6hAq9uSTnBtkHUQxz7M6vkXn17kBUXFEfirkcp
         YE/F9f/qPw10R1azfGoMJw0kYVhK5QVLg3an2lBHtxEZQ+mF3sChVu/vedxxUGdcJM3B
         tKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701492264; x=1702097064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkjJumzQC9OLzeUlKf2cdrps8W5WGvu5yds3ov88Mec=;
        b=bWETZYOOpuhztpCxqntx0hEfPI2VAxyvi7tddOBRzwaDGxSDbg6p3bpXbji0CbaTW4
         bgI3dLwLNHDcSVYTwsXY+i7yDizDiDlIPbHSbXbZucKI/XvZpZc1P8rll5OIJALFtOPJ
         JJEmPMP41MPNnL09nrcQQLXHjc599XKbhpksMjKEkSaMaWBTHGlwCjvMtzyP6dOZ2d7s
         q4u8k5+sn91QKXX5OYUi9o9kLf57pwGDxG4H73QjDjip14yW0Yn4MARdMe68oEkXGBc6
         2nuKXe5lvtKOVyLSalVTmT6ioq4Qx5WRet7t+Ilpvbv2bJURSyM87WBzfhAcvqes8uNC
         gy8g==
X-Gm-Message-State: AOJu0YyXtHB5QpkeLn6Y3lUCSGJfOBCdq9vOREpaOJGBNTBCDqQOooko
	v5Hl178CB82uTNOxzyWi9dE=
X-Google-Smtp-Source: AGHT+IG+AyARMGDcYbSUtUR0Ml9fa0udGX+8XMSUKKs+Zr4+J4uBha8QS1idDiF0qZFBJrJwksUIvw==
X-Received: by 2002:a17:902:dacb:b0:1d0:68a:4a46 with SMTP id q11-20020a170902dacb00b001d0068a4a46mr798452plx.3.1701492264465;
        Fri, 01 Dec 2023 20:44:24 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p14-20020a1709028a8e00b001cf6453b237sm4173552plo.236.2023.12.01.20.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 20:44:23 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id B89B9110DB381; Sat,  2 Dec 2023 11:44:18 +0700 (WIB)
Date: Sat, 2 Dec 2023 11:44:18 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, cerasuolodomenico@gmail.com, yosryahmed@google.com,
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
	kernel-team@meta.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux CGroups <cgroups@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Selftests <linux-kselftest@vger.kernel.org>,
	shuah@kernel.org
Subject: Re: [PATCH v7 0/6] workload-specific and memory pressure-driven
 zswap writeback
Message-ID: <ZWq2IqMMJesqenGK@archie.me>
References: <20231127234600.2971029-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L3dnvOdQcggt5SPe"
Content-Disposition: inline
In-Reply-To: <20231127234600.2971029-1-nphamcs@gmail.com>


--L3dnvOdQcggt5SPe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 03:45:54PM -0800, Nhat Pham wrote:
> Changelog:
> v7:
>    * Added the mem_cgroup_iter_online() function to the API for the new
>      behavior (suggested by Andrew Morton) (patch 2)
>    * Fixed a missing list_lru_del -> list_lru_del_obj (patch 1)
> v6:
>    * Rebase on top of latest mm-unstable.
>    * Fix/improve the in-code documentation of the new list_lru
>      manipulation functions (patch 1)
> v5:
>    * Replace reference getting with an rcu_read_lock() section for
>      zswap lru modifications (suggested by Yosry)
>    * Add a new prep patch that allows mem_cgroup_iter() to return
>      online cgroup.
>    * Add a callback that updates pool->next_shrink when the cgroup is
>      offlined (suggested by Yosry Ahmed, Johannes Weiner)
> v4:
>    * Rename list_lru_add to list_lru_add_obj and __list_lru_add to
>      list_lru_add (patch 1) (suggested by Johannes Weiner and
> 	 Yosry Ahmed)
>    * Some cleanups on the memcg aware LRU patch (patch 2)
>      (suggested by Yosry Ahmed)
>    * Use event interface for the new per-cgroup writeback counters.
>      (patch 3) (suggested by Yosry Ahmed)
>    * Abstract zswap's lruvec states and handling into=20
>      zswap_lruvec_state (patch 5) (suggested by Yosry Ahmed)
> v3:
>    * Add a patch to export per-cgroup zswap writeback counters
>    * Add a patch to update zswap's kselftest
>    * Separate the new list_lru functions into its own prep patch
>    * Do not start from the top of the hierarchy when encounter a memcg
>      that is not online for the global limit zswap writeback (patch 2)
>      (suggested by Yosry Ahmed)
>    * Do not remove the swap entry from list_lru in
>      __read_swapcache_async() (patch 2) (suggested by Yosry Ahmed)
>    * Removed a redundant zswap pool getting (patch 2)
>      (reported by Ryan Roberts)
>    * Use atomic for the nr_zswap_protected (instead of lruvec's lock)
>      (patch 5) (suggested by Yosry Ahmed)
>    * Remove the per-cgroup zswap shrinker knob (patch 5)
>      (suggested by Yosry Ahmed)
> v2:
>    * Fix loongarch compiler errors
>    * Use pool stats instead of memcg stats when !CONFIG_MEMCG_KEM
>=20
> There are currently several issues with zswap writeback:
>=20
> 1. There is only a single global LRU for zswap, making it impossible to
>    perform worload-specific shrinking - an memcg under memory pressure
>    cannot determine which pages in the pool it owns, and often ends up
>    writing pages from other memcgs. This issue has been previously
>    observed in practice and mitigated by simply disabling
>    memcg-initiated shrinking:
>=20
>    https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.com=
/T/#u
>=20
>    But this solution leaves a lot to be desired, as we still do not
>    have an avenue for an memcg to free up its own memory locked up in
>    the zswap pool.
>=20
> 2. We only shrink the zswap pool when the user-defined limit is hit.
>    This means that if we set the limit too high, cold data that are
>    unlikely to be used again will reside in the pool, wasting precious
>    memory. It is hard to predict how much zswap space will be needed
>    ahead of time, as this depends on the workload (specifically, on
>    factors such as memory access patterns and compressibility of the
>    memory pages).
>=20
> This patch series solves these issues by separating the global zswap
> LRU into per-memcg and per-NUMA LRUs, and performs workload-specific
> (i.e memcg- and NUMA-aware) zswap writeback under memory pressure. The
> new shrinker does not have any parameter that must be tuned by the
> user, and can be opted in or out on a per-memcg basis.
>=20
> As a proof of concept, we ran the following synthetic benchmark:
> build the linux kernel in a memory-limited cgroup, and allocate some
> cold data in tmpfs to see if the shrinker could write them out and
> improved the overall performance. Depending on the amount of cold data
> generated, we observe from 14% to 35% reduction in kernel CPU time used
> in the kernel builds.
>=20
> Domenico Cerasuolo (3):
>   zswap: make shrinking memcg-aware
>   mm: memcg: add per-memcg zswap writeback stat
>   selftests: cgroup: update per-memcg zswap writeback selftest
>=20
> Nhat Pham (3):
>   list_lru: allows explicit memcg and NUMA node selection
>   memcontrol: add a new function to traverse online-only memcg hierarchy
>   zswap: shrinks zswap pool based on memory pressure
>=20
>  Documentation/admin-guide/mm/zswap.rst      |   7 +
>  drivers/android/binder_alloc.c              |   7 +-
>  fs/dcache.c                                 |   8 +-
>  fs/gfs2/quota.c                             |   6 +-
>  fs/inode.c                                  |   4 +-
>  fs/nfs/nfs42xattr.c                         |   8 +-
>  fs/nfsd/filecache.c                         |   4 +-
>  fs/xfs/xfs_buf.c                            |   6 +-
>  fs/xfs/xfs_dquot.c                          |   2 +-
>  fs/xfs/xfs_qm.c                             |   2 +-
>  include/linux/list_lru.h                    |  54 ++-
>  include/linux/memcontrol.h                  |  18 +
>  include/linux/mmzone.h                      |   2 +
>  include/linux/vm_event_item.h               |   1 +
>  include/linux/zswap.h                       |  27 +-
>  mm/list_lru.c                               |  48 ++-
>  mm/memcontrol.c                             |  32 +-
>  mm/mmzone.c                                 |   1 +
>  mm/swap.h                                   |   3 +-
>  mm/swap_state.c                             |  26 +-
>  mm/vmstat.c                                 |   1 +
>  mm/workingset.c                             |   4 +-
>  mm/zswap.c                                  | 426 +++++++++++++++++---
>  tools/testing/selftests/cgroup/test_zswap.c |  74 ++--
>  24 files changed, 641 insertions(+), 130 deletions(-)
>=20
>=20
> base-commit: 5cdba94229e58a39ca389ad99763af29e6b0c5a5

No regressions when booting kernel with series applied.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--L3dnvOdQcggt5SPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWq2HwAKCRD2uYlJVVFO
o+mhAP98o1RpDS79BK+Q11P7wQTxU2MYmimbjb5iykn5K7OINwEAx7hxtVV/yTcR
X+TAaHXp3ua/dAycrhD7Qx+QUiyCRgw=
=qSwI
-----END PGP SIGNATURE-----

--L3dnvOdQcggt5SPe--

