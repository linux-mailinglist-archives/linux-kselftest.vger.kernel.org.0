Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DEF5AC21A
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Sep 2022 04:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIDC1d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Sep 2022 22:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiIDC1b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Sep 2022 22:27:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77334D832;
        Sat,  3 Sep 2022 19:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662258449; x=1693794449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MyDqAfyIavNoNgOVlV0h/HS947J7lgVxbR90s5sms48=;
  b=HIHIPICQz9hbnA2jwgSGzPjBWPVqd1BClRhOFNrRvYkYQR1I/Dn8OTId
   vCa0ClszOtBllaJkOcSHAeRNHol0meyrpWYI9YJyZyq5VkA2cZTnzN8rv
   0Ia81qBWpO3nPC2OH9JoZL3cdHM6VQMaeRR5hS92cvJG2vBk5k+fvFuwM
   hQrCFve+hqSz7ApJrKH5T+L9G3GvahRZ4jhOGWJs2BzHU7jRbksAPAKp+
   cKhqYLV+42UXmt7/j3JYZUmz8K2L3cknJsbI9LPtQjBK58GzyKEa6+O7l
   ROE83qMJr/zv0NKGE7fees6stx80OabzpFQhg5vAV5G61tqaIdkCFoTja
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="276600690"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="276600690"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="646516742"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 03 Sep 2022 19:27:24 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUfM3-0002S0-24;
        Sun, 04 Sep 2022 02:27:23 +0000
Date:   Sun, 4 Sep 2022 10:26:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v12 09/10] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <202209041056.v0eBaBjb-lkp@intel.com>
References: <20220901205745.323326-10-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901205745.323326-10-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Waiman,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.0-rc3 next-20220901]
[cannot apply to tj-cgroup/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/cgroup-cpuset-cpu-partition-code-fixes-enhancements/20220902-050019
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 42e66b1cc3a070671001f8a1e933a80818a192bf
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/dce03e1a3eb6fce8d7c849c8daeff91ec9a47fc8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Waiman-Long/cgroup-cpuset-cpu-partition-code-fixes-enhancements/20220902-050019
        git checkout dce03e1a3eb6fce8d7c849c8daeff91ec9a47fc8
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/cgroup-v2.rst:2191: WARNING: Malformed table.

vim +2191 Documentation/admin-guide/cgroup-v2.rst

  2091	
  2092	  cpuset.cpus
  2093		A read-write multiple values file which exists on non-root
  2094		cpuset-enabled cgroups.
  2095	
  2096		It lists the requested CPUs to be used by tasks within this
  2097		cgroup.  The actual list of CPUs to be granted, however, is
  2098		subjected to constraints imposed by its parent and can differ
  2099		from the requested CPUs.
  2100	
  2101		The CPU numbers are comma-separated numbers or ranges.
  2102		For example::
  2103	
  2104		  # cat cpuset.cpus
  2105		  0-4,6,8-10
  2106	
  2107		An empty value indicates that the cgroup is using the same
  2108		setting as the nearest cgroup ancestor with a non-empty
  2109		"cpuset.cpus" or all the available CPUs if none is found.
  2110	
  2111		The value of "cpuset.cpus" stays constant until the next update
  2112		and won't be affected by any CPU hotplug events.
  2113	
  2114	  cpuset.cpus.effective
  2115		A read-only multiple values file which exists on all
  2116		cpuset-enabled cgroups.
  2117	
  2118		It lists the onlined CPUs that are actually granted to this
  2119		cgroup by its parent.  These CPUs are allowed to be used by
  2120		tasks within the current cgroup.
  2121	
  2122		If "cpuset.cpus" is empty, the "cpuset.cpus.effective" file shows
  2123		all the CPUs from the parent cgroup that can be available to
  2124		be used by this cgroup.  Otherwise, it should be a subset of
  2125		"cpuset.cpus" unless none of the CPUs listed in "cpuset.cpus"
  2126		can be granted.  In this case, it will be treated just like an
  2127		empty "cpuset.cpus".
  2128	
  2129		Its value will be affected by CPU hotplug events.
  2130	
  2131	  cpuset.mems
  2132		A read-write multiple values file which exists on non-root
  2133		cpuset-enabled cgroups.
  2134	
  2135		It lists the requested memory nodes to be used by tasks within
  2136		this cgroup.  The actual list of memory nodes granted, however,
  2137		is subjected to constraints imposed by its parent and can differ
  2138		from the requested memory nodes.
  2139	
  2140		The memory node numbers are comma-separated numbers or ranges.
  2141		For example::
  2142	
  2143		  # cat cpuset.mems
  2144		  0-1,3
  2145	
  2146		An empty value indicates that the cgroup is using the same
  2147		setting as the nearest cgroup ancestor with a non-empty
  2148		"cpuset.mems" or all the available memory nodes if none
  2149		is found.
  2150	
  2151		The value of "cpuset.mems" stays constant until the next update
  2152		and won't be affected by any memory nodes hotplug events.
  2153	
  2154		Setting a non-empty value to "cpuset.mems" causes memory of
  2155		tasks within the cgroup to be migrated to the designated nodes if
  2156		they are currently using memory outside of the designated nodes.
  2157	
  2158		There is a cost for this memory migration.  The migration
  2159		may not be complete and some memory pages may be left behind.
  2160		So it is recommended that "cpuset.mems" should be set properly
  2161		before spawning new tasks into the cpuset.  Even if there is
  2162		a need to change "cpuset.mems" with active tasks, it shouldn't
  2163		be done frequently.
  2164	
  2165	  cpuset.mems.effective
  2166		A read-only multiple values file which exists on all
  2167		cpuset-enabled cgroups.
  2168	
  2169		It lists the onlined memory nodes that are actually granted to
  2170		this cgroup by its parent. These memory nodes are allowed to
  2171		be used by tasks within the current cgroup.
  2172	
  2173		If "cpuset.mems" is empty, it shows all the memory nodes from the
  2174		parent cgroup that will be available to be used by this cgroup.
  2175		Otherwise, it should be a subset of "cpuset.mems" unless none of
  2176		the memory nodes listed in "cpuset.mems" can be granted.  In this
  2177		case, it will be treated just like an empty "cpuset.mems".
  2178	
  2179		Its value will be affected by memory nodes hotplug events.
  2180	
  2181	  cpuset.cpus.partition
  2182		A read-write single value file which exists on non-root
  2183		cpuset-enabled cgroups.  This flag is owned by the parent cgroup
  2184		and is not delegatable.
  2185	
  2186		It accepts only the following input values when written to.
  2187	
  2188		  ========	================================
  2189		  "member"	Non-root member of a partition
  2190		  "root"	Partition root
> 2191		  "isolated"	Partition root without load balancing
  2192		  ========	================================
  2193	
  2194		The root cgroup is always a partition root and its state
  2195		cannot be changed.  All other non-root cgroups start out as
  2196		"member".
  2197	
  2198		When set to "root", the current cgroup is the root of a new
  2199		partition or scheduling domain that comprises itself and all
  2200		its descendants except those that are separate partition roots
  2201		themselves and their descendants.
  2202	
  2203		When set to "isolated", the CPUs in that partition root will
  2204		be in an isolated state without any load balancing from the
  2205		scheduler.  Tasks placed in such a partition with multiple
  2206		CPUs should be carefully distributed and bound to each of the
  2207		individual CPUs for optimal performance.
  2208	
  2209		The value shown in "cpuset.cpus.effective" of a partition root
  2210		is the CPUs that the partition root can dedicate to a potential
  2211		new child partition root. The new child subtracts available
  2212		CPUs from its parent "cpuset.cpus.effective".
  2213	
  2214		A partition root ("root" or "isolated") can be in one of the
  2215		two possible states - valid or invalid.  An invalid partition
  2216		root is in a degraded state where some state information may
  2217		be retained, but behaves more like a "member".
  2218	
  2219		All possible state transitions among "member", "root" and
  2220		"isolated" are allowed.
  2221	
  2222		On read, the "cpuset.cpus.partition" file can show the following
  2223		values.
  2224	
  2225		  ======================	==============================
  2226		  "member"			Non-root member of a partition
  2227		  "root"			Partition root
  2228		  "isolated"			Partition root without load balancing
  2229		  "root invalid (<reason>)"	Invalid partition root
  2230		  "isolated invalid (<reason>)"	Invalid isolated partition root
  2231		  ======================	==============================
  2232	
  2233		In the case of an invalid partition root, a descriptive string on
  2234		why the partition is invalid is included within parentheses.
  2235	
  2236		For a partition root to become valid, the following conditions
  2237		must be met.
  2238	
  2239		1) The "cpuset.cpus" is exclusive with its siblings , i.e. they
  2240		   are not shared by any of its siblings (exclusivity rule).
  2241		2) The parent cgroup is a valid partition root.
  2242		3) The "cpuset.cpus" is not empty and must contain at least
  2243		   one of the CPUs from parent's "cpuset.cpus", i.e. they overlap.
  2244		4) The "cpuset.cpus.effective" cannot be empty unless there is
  2245		   no task associated with this partition.
  2246	
  2247		External events like hotplug or changes to "cpuset.cpus" can
  2248		cause a valid partition root to become invalid and vice versa.
  2249		Note that a task cannot be moved to a cgroup with empty
  2250		"cpuset.cpus.effective".
  2251	
  2252		For a valid partition root with the sibling cpu exclusivity
  2253		rule enabled, changes made to "cpuset.cpus" that violate the
  2254		exclusivity rule will invalidate the partition as well as its
  2255		sibiling partitions with conflicting cpuset.cpus values. So
  2256		care must be taking in changing "cpuset.cpus".
  2257	
  2258		A valid non-root parent partition may distribute out all its CPUs
  2259		to its child partitions when there is no task associated with it.
  2260	
  2261		Care must be taken to change a valid partition root to
  2262		"member" as all its child partitions, if present, will become
  2263		invalid causing disruption to tasks running in those child
  2264		partitions. These inactivated partitions could be recovered if
  2265		their parent is switched back to a partition root with a proper
  2266		set of "cpuset.cpus".
  2267	
  2268		Poll and inotify events are triggered whenever the state of
  2269		"cpuset.cpus.partition" changes.  That includes changes caused
  2270		by write to "cpuset.cpus.partition", cpu hotplug or other
  2271		changes that modify the validity status of the partition.
  2272		This will allow user space agents to monitor unexpected changes
  2273		to "cpuset.cpus.partition" without the need to do continuous
  2274		polling.
  2275	
  2276	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
