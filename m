Return-Path: <linux-kselftest+bounces-30168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92967A7CCD5
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Apr 2025 07:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EACE3B42CF
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Apr 2025 05:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2331D14D2A0;
	Sun,  6 Apr 2025 05:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3xz6tdg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED2914A82;
	Sun,  6 Apr 2025 05:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743916184; cv=none; b=PegYMD3Hvw5YyeP+ELlvIWYeCOZeqllAkiXWhksE7mlhRusA3XebSVi401fSj7Qpfl5XPpVl22ousNAJZjj7iGfwkiJ9e8+kq7xAIfyRD04dtMFr/gB03CTfGmustsCLAp6gKw045WvbKVRbZdERhwK8w8aStD8DDMj5BA8u/YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743916184; c=relaxed/simple;
	bh=2Vv16BmJQGGt1ruqb/MSgE5G4w4jvnFeftNhxmRK96Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8WrHohwSrVM+sJKYAztF/8tfyLXcZPIijNuYPmMFICuZ/T3ZbasaOxFaCXpzrUK8kc3aj2/Bp0HGzL68h6gNBT6Kifdg923xsEMkgtsgEgyvFXUmhbAlMkcON0fBblCxgSbMpIYvWotmJsWZAahqCSf0IWMHUs5Vv2BFJPdqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3xz6tdg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743916182; x=1775452182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Vv16BmJQGGt1ruqb/MSgE5G4w4jvnFeftNhxmRK96Q=;
  b=N3xz6tdgDYyZjg8+6OHAxIbGh+a5pEfwi+leZFRYrl2gwD18LxCvv+iE
   aI8wC27VtTqNMtZgrjbZkSS0mr8cC/M2wYNttd3QR1W1TgaucjrJADBSt
   jHxeOhRYN6TGpVkP1O/xUq0/iJCE4/+IqE5uMPgCwd8+DvpHj4sCqDeKi
   06Dd9M1AN2f2D9fAvyz4+uXwAGQ+varb0UDeJXfyzFGcc25K+csoJCjKD
   JhCPrbpSNADdIEjDhxGjA0hQjWy4BKG7CuxCgXnaeBtU2dha7KGS1CZNo
   6Hx/Vhs8NRMLtfUDWFMU/NZzaE5VIwRKl6FLS83khG6KstfXr9XRVpBNd
   Q==;
X-CSE-ConnectionGUID: 0C93XjmsQq2xv24+xl7wtw==
X-CSE-MsgGUID: CyRoFPaERWagfF2d6RPlEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11395"; a="32920992"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="32920992"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2025 22:09:38 -0700
X-CSE-ConnectionGUID: 9Z3oBZg/R0ipWzs40aYBCA==
X-CSE-MsgGUID: BNJayHtETV6W0UmceMgCLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="128141955"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Apr 2025 22:09:35 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1IGC-0002Rz-22;
	Sun, 06 Apr 2025 05:09:32 +0000
Date: Sun, 6 Apr 2025 13:08:57 +0800
From: kernel test robot <lkp@intel.com>
To: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
Message-ID: <202504061254.DqfqHfM7-lkp@intel.com>
References: <20250406024010.1177927-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406024010.1177927-2-longman@redhat.com>

Hi Waiman,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-cgroup/for-next]
[also build test ERROR on akpm-mm/mm-everything linus/master v6.14 next-20250404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/mm-vmscan-Skip-memcg-with-usage-in-shrink_node_memcgs/20250406-104208
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20250406024010.1177927-2-longman%40redhat.com
patch subject: [PATCH v3 1/2] mm/vmscan: Skip memcg with !usage in shrink_node_memcgs()
config: arm-randconfig-001-20250406 (https://download.01.org/0day-ci/archive/20250406/202504061254.DqfqHfM7-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 92c93f5286b9ff33f27ff694d2dc33da1c07afdd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250406/202504061254.DqfqHfM7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504061254.DqfqHfM7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/vmscan.c:5929:32: error: incomplete definition of type 'struct mem_cgroup'
    5929 |                 if (!page_counter_read(&memcg->memory))
         |                                         ~~~~~^
   include/linux/mm_types.h:33:8: note: forward declaration of 'struct mem_cgroup'
      33 | struct mem_cgroup;
         |        ^
   1 error generated.


vim +5929 mm/vmscan.c

  5890	
  5891	static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
  5892	{
  5893		struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
  5894		struct mem_cgroup_reclaim_cookie reclaim = {
  5895			.pgdat = pgdat,
  5896		};
  5897		struct mem_cgroup_reclaim_cookie *partial = &reclaim;
  5898		struct mem_cgroup *memcg;
  5899	
  5900		/*
  5901		 * In most cases, direct reclaimers can do partial walks
  5902		 * through the cgroup tree, using an iterator state that
  5903		 * persists across invocations. This strikes a balance between
  5904		 * fairness and allocation latency.
  5905		 *
  5906		 * For kswapd, reliable forward progress is more important
  5907		 * than a quick return to idle. Always do full walks.
  5908		 */
  5909		if (current_is_kswapd() || sc->memcg_full_walk)
  5910			partial = NULL;
  5911	
  5912		memcg = mem_cgroup_iter(target_memcg, NULL, partial);
  5913		do {
  5914			struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
  5915			unsigned long reclaimed;
  5916			unsigned long scanned;
  5917	
  5918			/*
  5919			 * This loop can become CPU-bound when target memcgs
  5920			 * aren't eligible for reclaim - either because they
  5921			 * don't have any reclaimable pages, or because their
  5922			 * memory is explicitly protected. Avoid soft lockups.
  5923			 */
  5924			cond_resched();
  5925	
  5926			mem_cgroup_calculate_protection(target_memcg, memcg);
  5927	
  5928			/* Skip memcg with no usage */
> 5929			if (!page_counter_read(&memcg->memory))
  5930				continue;
  5931	
  5932			if (mem_cgroup_below_min(target_memcg, memcg)) {
  5933				/*
  5934				 * Hard protection.
  5935				 * If there is no reclaimable memory, OOM.
  5936				 */
  5937				continue;
  5938			} else if (mem_cgroup_below_low(target_memcg, memcg)) {
  5939				/*
  5940				 * Soft protection.
  5941				 * Respect the protection only as long as
  5942				 * there is an unprotected supply
  5943				 * of reclaimable memory from other cgroups.
  5944				 */
  5945				if (!sc->memcg_low_reclaim) {
  5946					sc->memcg_low_skipped = 1;
  5947					continue;
  5948				}
  5949				memcg_memory_event(memcg, MEMCG_LOW);
  5950			}
  5951	
  5952			reclaimed = sc->nr_reclaimed;
  5953			scanned = sc->nr_scanned;
  5954	
  5955			shrink_lruvec(lruvec, sc);
  5956	
  5957			shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
  5958				    sc->priority);
  5959	
  5960			/* Record the group's reclaim efficiency */
  5961			if (!sc->proactive)
  5962				vmpressure(sc->gfp_mask, memcg, false,
  5963					   sc->nr_scanned - scanned,
  5964					   sc->nr_reclaimed - reclaimed);
  5965	
  5966			/* If partial walks are allowed, bail once goal is reached */
  5967			if (partial && sc->nr_reclaimed >= sc->nr_to_reclaim) {
  5968				mem_cgroup_iter_break(target_memcg, memcg);
  5969				break;
  5970			}
  5971		} while ((memcg = mem_cgroup_iter(target_memcg, memcg, partial)));
  5972	}
  5973	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

