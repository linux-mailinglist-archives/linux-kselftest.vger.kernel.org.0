Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CBB7AF6C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 01:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjIZXmk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 19:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjIZXki (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 19:40:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D76E18578
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 15:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695768823; x=1727304823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5VP33ZENS7KttVEYiLWj5dLs3mzRBPjPSPkup9tRjus=;
  b=AuSa+hC44R1izExkaWPkaFQkNzJfWmpYEOhtb9PWqnSJydljmidAp0NF
   gfhckzsaqxHj90d9HMGfvL9Ap+6VrTA0PrJbiPmLVpnFZdySbSmxGrZFv
   RRhXp9dOJ5nGOWKQVW0qRea6fbekeJ/pnMVV/ceabOBI/xrHYA1BPjf4/
   dag4IXTLKIGacIV+XzJwMonvXVkzLOyHu9901ST+Jve0FHsiYh4IVmDcB
   Ss+NoG6jlYqE7ay0+VWhYt1ZbSXUVuQpAow5QvbPeSNAkfg1yBQBwvTcm
   N9TKhA9TyBPsX7EJENU/Nz27ya8ABxZTPGUUN1093NkFLemSVgOYq70Cy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="380538850"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="380538850"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 14:15:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="1079860933"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="1079860933"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2023 14:15:34 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlFP2-0003N1-0r;
        Tue, 26 Sep 2023 21:15:32 +0000
Date:   Wed, 27 Sep 2023 05:14:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jinjie Ruan <ruanjinjie@huawei.com>, brendan.higgins@linux.dev,
        davidgow@google.com, skhan@linuxfoundation.org,
        dlatypov@google.com, rmoar@google.com,
        janusz.krzysztofik@linux.intel.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        ruanjinjie@huawei.com
Subject: Re: [PATCH v3 4/4] kunit: test: Fix the possible memory leak in
 executor_test
Message-ID: <202309270433.wGmFRGjd-lkp@intel.com>
References: <20230922071020.2554677-5-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922071020.2554677-5-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jinjie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc3 next-20230926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinjie-Ruan/kunit-Fix-missed-memory-release-in-kunit_free_suite_set/20230922-151243
base:   linus/master
patch link:    https://lore.kernel.org/r/20230922071020.2554677-5-ruanjinjie%40huawei.com
patch subject: [PATCH v3 4/4] kunit: test: Fix the possible memory leak in executor_test
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20230927/202309270433.wGmFRGjd-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230927/202309270433.wGmFRGjd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309270433.wGmFRGjd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from lib/kunit/executor.c:353:
>> lib/kunit/executor_test.c:278:4: warning: cast from 'void (*)(struct kunit_suite_set *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
     278 |                         (kunit_action_t *)free_suite_set,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +278 lib/kunit/executor_test.c

   264	
   265	/* Use the resource API to register a call to free_suite_set.
   266	 * Since we never actually use the resource, it's safe to use on const data.
   267	 */
   268	static void free_suite_set_at_end(struct kunit *test, const void *to_free)
   269	{
   270		if (!((struct kunit_suite_set *)to_free)->start)
   271			return;
   272	
   273		struct kunit_suite_set *free = kzalloc(sizeof(struct kunit_suite_set),
   274						       GFP_KERNEL);
   275		*free = *(struct kunit_suite_set *)to_free;
   276	
   277		kunit_add_action(test,
 > 278				(kunit_action_t *)free_suite_set,
   279				(void *)free);
   280	}
   281	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
