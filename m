Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48048793C64
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 14:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbjIFMMz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 08:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbjIFMMy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 08:12:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A17E71;
        Wed,  6 Sep 2023 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694002368; x=1725538368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IX8tqAU4qqO4xD68t3JJmbkfL8h79O8BisSE4UjrixU=;
  b=JzwTu5jodsE1ARpc0Ff0D+XJ+W2av1zvk6PIkdrq6AghZTPlWjqRnf0F
   ndgjiuefGR4AsccBGPaklesK/tioIqXgZrFNHOBbyMkJgglfzKyPvgSTQ
   lpTL/Rhjq9k9fMEK/FBVwEhh0cH4m1HUfCzdHtZBhZAJn3eZN7zQblH9k
   jE7Q8SgNPhl+gtLl57irBRWB4hwQEkvurpMcEA1YX8lo/Y0vVJTuBPcny
   26y0TIB47ZaXYCyz0jNhSvDW/NgRB4SGlDwuRuvkDxS/fjLF04q7DuRO4
   jsS9lACZhWverDpc6htDeYe8muNaSkEx5JFNEUIHAabUKDwnhUb0pbj+2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="357362012"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="357362012"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 05:12:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="806982511"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="806982511"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2023 05:12:03 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdrO4-0000Bh-2d;
        Wed, 06 Sep 2023 12:12:00 +0000
Date:   Wed, 6 Sep 2023 20:11:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Meng Li <li.meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>
Subject: Re: [PATCH V5 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
Message-ID: <202309061958.4wimkcbo-lkp@intel.com>
References: <20230905015116.2268926-4-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905015116.2268926-4-li.meng@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Meng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.5 next-20230906]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Meng-Li/x86-Drop-CPU_SUP_INTEL-from-SCHED_MC_PRIO-for-the-expansion/20230906-003754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230905015116.2268926-4-li.meng%40amd.com
patch subject: [PATCH V5 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred core supporting.
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230906/202309061958.4wimkcbo-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230906/202309061958.4wimkcbo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309061958.4wimkcbo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/cpufreq.h:12,
                    from drivers/cpufreq/amd-pstate.c:30:
>> include/linux/device.h:198:33: warning: 'dev_attr_hw_prefcore' defined but not used [-Wunused-variable]
     198 |         struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
         |                                 ^~~~~~~~~
   drivers/cpufreq/amd-pstate.c:1131:8: note: in expansion of macro 'DEVICE_ATTR_RO'
    1131 | static DEVICE_ATTR_RO(hw_prefcore);
         |        ^~~~~~~~~~~~~~


vim +/dev_attr_hw_prefcore +198 include/linux/device.h

ca22e56debc57b4 Kay Sievers        2011-12-14  123  
ca22e56debc57b4 Kay Sievers        2011-12-14  124  ssize_t device_show_ulong(struct device *dev, struct device_attribute *attr,
ca22e56debc57b4 Kay Sievers        2011-12-14  125  			  char *buf);
ca22e56debc57b4 Kay Sievers        2011-12-14  126  ssize_t device_store_ulong(struct device *dev, struct device_attribute *attr,
ca22e56debc57b4 Kay Sievers        2011-12-14  127  			   const char *buf, size_t count);
ca22e56debc57b4 Kay Sievers        2011-12-14  128  ssize_t device_show_int(struct device *dev, struct device_attribute *attr,
ca22e56debc57b4 Kay Sievers        2011-12-14  129  			char *buf);
ca22e56debc57b4 Kay Sievers        2011-12-14  130  ssize_t device_store_int(struct device *dev, struct device_attribute *attr,
ca22e56debc57b4 Kay Sievers        2011-12-14  131  			 const char *buf, size_t count);
91872392f08486f Borislav Petkov    2012-10-09  132  ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
91872392f08486f Borislav Petkov    2012-10-09  133  			char *buf);
91872392f08486f Borislav Petkov    2012-10-09  134  ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
91872392f08486f Borislav Petkov    2012-10-09  135  			 const char *buf, size_t count);
ca22e56debc57b4 Kay Sievers        2011-12-14  136  
cd00bc2ca42705b James Seo          2023-05-08  137  /**
cd00bc2ca42705b James Seo          2023-05-08  138   * DEVICE_ATTR - Define a device attribute.
cd00bc2ca42705b James Seo          2023-05-08  139   * @_name: Attribute name.
cd00bc2ca42705b James Seo          2023-05-08  140   * @_mode: File mode.
cd00bc2ca42705b James Seo          2023-05-08  141   * @_show: Show handler. Optional, but mandatory if attribute is readable.
cd00bc2ca42705b James Seo          2023-05-08  142   * @_store: Store handler. Optional, but mandatory if attribute is writable.
cd00bc2ca42705b James Seo          2023-05-08  143   *
cd00bc2ca42705b James Seo          2023-05-08  144   * Convenience macro for defining a struct device_attribute.
cd00bc2ca42705b James Seo          2023-05-08  145   *
cd00bc2ca42705b James Seo          2023-05-08  146   * For example, ``DEVICE_ATTR(foo, 0644, foo_show, foo_store);`` expands to:
cd00bc2ca42705b James Seo          2023-05-08  147   *
cd00bc2ca42705b James Seo          2023-05-08  148   * .. code-block:: c
cd00bc2ca42705b James Seo          2023-05-08  149   *
cd00bc2ca42705b James Seo          2023-05-08  150   *	struct device_attribute dev_attr_foo = {
cd00bc2ca42705b James Seo          2023-05-08  151   *		.attr	= { .name = "foo", .mode = 0644 },
cd00bc2ca42705b James Seo          2023-05-08  152   *		.show	= foo_show,
cd00bc2ca42705b James Seo          2023-05-08  153   *		.store	= foo_store,
cd00bc2ca42705b James Seo          2023-05-08  154   *	};
cd00bc2ca42705b James Seo          2023-05-08  155   */
a7fd67062efc5b0 Kay Sievers        2005-10-01  156  #define DEVICE_ATTR(_name, _mode, _show, _store) \
a7fd67062efc5b0 Kay Sievers        2005-10-01  157  	struct device_attribute dev_attr_##_name = __ATTR(_name, _mode, _show, _store)
cd00bc2ca42705b James Seo          2023-05-08  158  
cd00bc2ca42705b James Seo          2023-05-08  159  /**
cd00bc2ca42705b James Seo          2023-05-08  160   * DEVICE_ATTR_PREALLOC - Define a preallocated device attribute.
cd00bc2ca42705b James Seo          2023-05-08  161   * @_name: Attribute name.
cd00bc2ca42705b James Seo          2023-05-08  162   * @_mode: File mode.
cd00bc2ca42705b James Seo          2023-05-08  163   * @_show: Show handler. Optional, but mandatory if attribute is readable.
cd00bc2ca42705b James Seo          2023-05-08  164   * @_store: Store handler. Optional, but mandatory if attribute is writable.
cd00bc2ca42705b James Seo          2023-05-08  165   *
cd00bc2ca42705b James Seo          2023-05-08  166   * Like DEVICE_ATTR(), but ``SYSFS_PREALLOC`` is set on @_mode.
cd00bc2ca42705b James Seo          2023-05-08  167   */
7fda9100bb8258b Christophe Leroy   2017-12-18  168  #define DEVICE_ATTR_PREALLOC(_name, _mode, _show, _store) \
7fda9100bb8258b Christophe Leroy   2017-12-18  169  	struct device_attribute dev_attr_##_name = \
7fda9100bb8258b Christophe Leroy   2017-12-18  170  		__ATTR_PREALLOC(_name, _mode, _show, _store)
cd00bc2ca42705b James Seo          2023-05-08  171  
cd00bc2ca42705b James Seo          2023-05-08  172  /**
cd00bc2ca42705b James Seo          2023-05-08  173   * DEVICE_ATTR_RW - Define a read-write device attribute.
cd00bc2ca42705b James Seo          2023-05-08  174   * @_name: Attribute name.
cd00bc2ca42705b James Seo          2023-05-08  175   *
cd00bc2ca42705b James Seo          2023-05-08  176   * Like DEVICE_ATTR(), but @_mode is 0644, @_show is <_name>_show,
cd00bc2ca42705b James Seo          2023-05-08  177   * and @_store is <_name>_store.
cd00bc2ca42705b James Seo          2023-05-08  178   */
ced321bf9151535 Greg Kroah-Hartman 2013-07-14  179  #define DEVICE_ATTR_RW(_name) \
ced321bf9151535 Greg Kroah-Hartman 2013-07-14  180  	struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
cd00bc2ca42705b James Seo          2023-05-08  181  
cd00bc2ca42705b James Seo          2023-05-08  182  /**
cd00bc2ca42705b James Seo          2023-05-08  183   * DEVICE_ATTR_ADMIN_RW - Define an admin-only read-write device attribute.
cd00bc2ca42705b James Seo          2023-05-08  184   * @_name: Attribute name.
cd00bc2ca42705b James Seo          2023-05-08  185   *
cd00bc2ca42705b James Seo          2023-05-08  186   * Like DEVICE_ATTR_RW(), but @_mode is 0600.
cd00bc2ca42705b James Seo          2023-05-08  187   */
3022c6a1b4b76c4 Dan Williams       2020-06-25  188  #define DEVICE_ATTR_ADMIN_RW(_name) \
3022c6a1b4b76c4 Dan Williams       2020-06-25  189  	struct device_attribute dev_attr_##_name = __ATTR_RW_MODE(_name, 0600)
cd00bc2ca42705b James Seo          2023-05-08  190  
cd00bc2ca42705b James Seo          2023-05-08  191  /**
cd00bc2ca42705b James Seo          2023-05-08  192   * DEVICE_ATTR_RO - Define a readable device attribute.
cd00bc2ca42705b James Seo          2023-05-08  193   * @_name: Attribute name.
cd00bc2ca42705b James Seo          2023-05-08  194   *
cd00bc2ca42705b James Seo          2023-05-08  195   * Like DEVICE_ATTR(), but @_mode is 0444 and @_show is <_name>_show.
cd00bc2ca42705b James Seo          2023-05-08  196   */
ced321bf9151535 Greg Kroah-Hartman 2013-07-14  197  #define DEVICE_ATTR_RO(_name) \
ced321bf9151535 Greg Kroah-Hartman 2013-07-14 @198  	struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
cd00bc2ca42705b James Seo          2023-05-08  199  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
