Return-Path: <linux-kselftest+bounces-30166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC148A7CCBA
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Apr 2025 06:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4008188FB24
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Apr 2025 04:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463031B4251;
	Sun,  6 Apr 2025 04:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2ygRcaX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B078818C01D;
	Sun,  6 Apr 2025 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743913659; cv=none; b=oDmJYgcxwyU6DPngKsMO0FvNknOBh8aXtu9quelT1VAWXHllcnXhcRhf8U+OQLKN79FK1hprYJmQkzis3k/9RnHEQZMS8qKE3IMcR0Igj9eug9BJ8KcnGNkjp3fZ/xTtZWTA9ch7cYZ9qaKH6jvpnfrXDMaEwGa3wOXmJoS1OsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743913659; c=relaxed/simple;
	bh=O7btUqfuVN1YAH6kub7YKm5WCHvlzLjyS/fJH/XHq3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtNIeGXMZwm4PC15/TRu/wRRkeVOLbQ80NwCR7Xo5bqu9P6Wj7twGi0O6ukeKUDlZmEebhLW8WuGyzKnjokJsQ0nnSFGw8iCXkWKM71lLf7/ahyFMojSv61F5Do9Uh2vUttQ6+nvrD4fZ2j2B8B7JKmp5kxoHNDtXsHqD7u4gb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2ygRcaX; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743913656; x=1775449656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O7btUqfuVN1YAH6kub7YKm5WCHvlzLjyS/fJH/XHq3g=;
  b=V2ygRcaX9duJ96iOWr6bbaOPVnJDAbomg9sTx1HM3H/KXxTwgnePzDuq
   0qlTqo4SlAfxQTtzVvvZ0XJ+SoJCZ+ZlRRNx/Y0y4w9Wxu983Fv9+nkQr
   wSLJNqpjo1oZGuFPdsYdTus4ahibB5tP7M8waqpU3Tf/aYv0odm1VpvP7
   zDiUI2/POg1Fefi8uq65OYc/w8Z5mRXp8gZG94LchJdsDzOKdIStSvNmn
   y3aF4SdcKTWBAadEnrH7Pm7PrbPGq+8CDKK4Pi1hOrZDLMeuvOVkOYTJD
   sZnLCNY+pE9aPOzMu9PLBk3hoeiK7/tdtlvRnOVjFtKMLbAEB13OctR5c
   A==;
X-CSE-ConnectionGUID: cr4CTfudQuaPAUlnsRVjLQ==
X-CSE-MsgGUID: OrSakB0XRhmo7sb133eYqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11395"; a="45451990"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="45451990"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2025 21:27:35 -0700
X-CSE-ConnectionGUID: 5gbXp1nST4GLoL1QIFuW8Q==
X-CSE-MsgGUID: l4qFjh0ZR4OocMypNpzb2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="127956790"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Apr 2025 21:27:31 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1HbV-0002RD-1V;
	Sun, 06 Apr 2025 04:27:29 +0000
Date: Sun, 6 Apr 2025 12:27:28 +0800
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
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
Message-ID: <202504061257.GMkEJUOs-lkp@intel.com>
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
config: arc-randconfig-002-20250406 (https://download.01.org/0day-ci/archive/20250406/202504061257.GMkEJUOs-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250406/202504061257.GMkEJUOs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504061257.GMkEJUOs-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/vmscan.c: In function 'shrink_node_memcgs':
>> mm/vmscan.c:5929:46: error: invalid use of undefined type 'struct mem_cgroup'
    5929 |                 if (!page_counter_read(&memcg->memory))
         |                                              ^~


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

