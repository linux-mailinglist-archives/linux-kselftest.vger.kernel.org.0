Return-Path: <linux-kselftest+bounces-1228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5788065FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 05:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC21B2815BD
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 04:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D577DF52;
	Wed,  6 Dec 2023 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkPQUDAe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6C01BC;
	Tue,  5 Dec 2023 20:10:55 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d0a5422c80so26314535ad.3;
        Tue, 05 Dec 2023 20:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701835854; x=1702440654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ObrC2jCtLGDAckpSfZVTn0tEKMdAtJUEwxrQR45+A9Q=;
        b=TkPQUDAeccGi9r1+dWcxLq006rWGC5WUjJzykXi4lF4awcoJEA/GgXV0tMUfrCHkER
         gmhvqPI3H5wKvAxM3h4H2XN2ApuBFTHaqASXseK5AKODJcFl/RV7j8iAYbW2G8E9I22h
         43rbT7KhdURgS6CZzoV1I1whnPZLpD5ZCL8JDgaDmoYgaUjaEkhGahuT3vOjTXHuhMCW
         4ngZDGZkCdGU9iwZLjHbuLR/uewVy0HNcAvUWuJWU/dGWJSU57sCTFpJ0nuHdPVt08Ro
         EsjAxnrJEjvHcR6HGEGmlFrCWHEK4pMMayEsRH1M8KiA5rMkMfHm/V5Iky8xKTel9Ur2
         LOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701835854; x=1702440654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObrC2jCtLGDAckpSfZVTn0tEKMdAtJUEwxrQR45+A9Q=;
        b=i3kNEM88JmLz/Icn/f/cZ7Yp8Nj+ZJOhNF/DsFLLCYl1sJLzNmWZcH/qEphXfG2WHB
         PlgB0OlMW2XgNjCePn8JaabBVltYMZVYm3GO2zmClhHNR6lBsyknJEc/9mIpbOzV3HJp
         VlX5eJnYyIxOqvWE1+ze9MIpfEggS8DsJsiWPG9v2XQqgwEim0Zuo4FW3c8lRCZgLRyt
         V4+AoOIvSpV8rXbcNyyKhDnu+vWelDKinq5PWMPzGSvBwr8OgPZBbgV/vc+FAsrpa90L
         PnQ2RJ8PvBUdfe2ocOLKC/hJKWlwrVkbUbSxXhLpaRtM4PCQFMaY4QETjv371Segj8l4
         5HMQ==
X-Gm-Message-State: AOJu0YxPWakMPxT7bLrMEb4HfBTHTZcOyckzCt8WQdfMGM7sVmiWSq8s
	6PY8yp5GJ42pwfL2DWBr504=
X-Google-Smtp-Source: AGHT+IEaAOoQGFwwH/kU2fUu/2MKaKhp7MePbfzzvQOCn6yYbZlMCkGzBFnYk7XBORY7u8QTpJQ4RA==
X-Received: by 2002:a17:902:f7d4:b0:1d0:737d:2ae5 with SMTP id h20-20020a170902f7d400b001d0737d2ae5mr292078plw.87.1701835854495;
        Tue, 05 Dec 2023 20:10:54 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ij20-20020a170902ab5400b001cfbd3f38dcsm9625744plb.225.2023.12.05.20.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 20:10:53 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 8E9E81123835B; Wed,  6 Dec 2023 11:10:50 +0700 (WIB)
Date: Wed, 6 Dec 2023 11:10:50 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, cerasuolodomenico@gmail.com, yosryahmed@google.com,
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v8 0/6] workload-specific and memory pressure-driven
 zswap writeback
Message-ID: <ZW_0SqJ5xDc3lTsR@archie.me>
References: <20231130194023.4102148-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cYRqWT32c2qY1zcr"
Content-Disposition: inline
In-Reply-To: <20231130194023.4102148-1-nphamcs@gmail.com>


--cYRqWT32c2qY1zcr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 11:40:17AM -0800, Nhat Pham wrote:
> Changelog:
> v8:
>    * Fixed a couple of build errors in the case of !CONFIG_MEMCG
>    * Simplified the online memcg selection scheme for the zswap global
>      limit reclaim (suggested by Michal Hocko and Johannes Weiner)
>      (patch 2 and patch 3)
>    * Added a new kconfig to allows users to enable zswap shrinker by
>      default. (suggested by Johannes Weiner) (patch 6)
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
>   memcontrol: implement mem_cgroup_tryget_online()
>   zswap: shrinks zswap pool based on memory pressure
>=20
>  Documentation/admin-guide/mm/zswap.rst      |  10 +
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
>  include/linux/memcontrol.h                  |  15 +
>  include/linux/mmzone.h                      |   2 +
>  include/linux/vm_event_item.h               |   1 +
>  include/linux/zswap.h                       |  27 +-
>  mm/Kconfig                                  |  14 +
>  mm/list_lru.c                               |  48 ++-
>  mm/memcontrol.c                             |   3 +
>  mm/mmzone.c                                 |   1 +
>  mm/swap.h                                   |   3 +-
>  mm/swap_state.c                             |  26 +-
>  mm/vmstat.c                                 |   1 +
>  mm/workingset.c                             |   4 +-
>  mm/zswap.c                                  | 456 +++++++++++++++++---
>  tools/testing/selftests/cgroup/test_zswap.c |  74 ++--
>  25 files changed, 661 insertions(+), 125 deletions(-)
>=20

Carrying from v7,

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--cYRqWT32c2qY1zcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZW/0RQAKCRD2uYlJVVFO
o65MAP9/pT5frcsZd0LxwPcoVNeeGc0pNzxVGOZLmtka3xNlbgD3VXD447mxf7HC
r0BOQRED5Yu59sVopP7c3ZGK4tuzBA==
=huGs
-----END PGP SIGNATURE-----

--cYRqWT32c2qY1zcr--

