Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C626DDFBD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 17:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjDKPa3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 11:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjDKPaW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 11:30:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5DF19F
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681227018; x=1712763018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iCU05kOa0hP4lNhLGaO67JgMKC63jRez+AStJP4kUsQ=;
  b=LZdn6aS/lQTGIcf3GGfJOR9qlcEzP3F72BrQu/0YujfpGQPOGM2Gaqxo
   UPUHb45wtRTmHuHXOECRCZ2ZL8zM7TTrZDNPbl6BxfLWs+WX/0RAaBduL
   CnOQnBMmmdo4bha/oryVRXt5rsJFZdtKwA3oFeNztPqeOzgsFIqhtmOYb
   EW7tsXMEc0psv+1YOW2Me7kh92EmcdulbU7h9/N7XU/wZ6161zY2l+on3
   SLWWo+xlct2w7EfTOkIeKr3xQJxXr4I/iW2LMxgUUvnAz0qTa6ETW1VvE
   0wojPnpict2tFnQNWeippJgo0bfd/f6cCkvqL4ibmgIZJi8n+PNuGBHtQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="408788676"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="408788676"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 08:29:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="799959667"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="799959667"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Apr 2023 08:29:15 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmFvm-000WRN-2q;
        Tue, 11 Apr 2023 15:29:14 +0000
Date:   Tue, 11 Apr 2023 23:28:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     benjamin@sipsolutions.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Johannes Berg <johannes@sipsolutions.net>,
        Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 2/3] kunit: add ability to register a simple cleanup
 function
Message-ID: <202304112307.LAyTVYon-lkp@intel.com>
References: <20230329172311.71861-2-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329172311.71861-2-benjamin@sipsolutions.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.3-rc6 next-20230411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/benjamin-sipsolutions-net/kunit-add-ability-to-register-a-simple-cleanup-function/20230330-012515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20230329172311.71861-2-benjamin%40sipsolutions.net
patch subject: [PATCH 2/3] kunit: add ability to register a simple cleanup function
config: arc-randconfig-m031-20230410 (https://download.01.org/0day-ci/archive/20230411/202304112307.LAyTVYon-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304112307.LAyTVYon-lkp@intel.com/

New smatch warnings:
lib/kunit/test.c:750 kunit_add_cleanup() error: potential null dereference 'res'.  (kzalloc returns null)
lib/kunit/test.c:750 kunit_add_cleanup() error: we previously assumed 'res' could be null (see line 745)

Old smatch warnings:
lib/kunit/test.c:293 kunit_abort() warn: ignoring unreachable code.

vim +/res +750 lib/kunit/test.c

   735	
   736	void kunit_add_cleanup(struct kunit *test, kunit_cleanup_t cleanup_func,
   737			       const void *data, gfp_t internal_gfp)
   738	{
   739		struct kunit_auto_cleanup *res;
   740	
   741		KUNIT_ASSERT_NOT_NULL_MSG(test, cleanup_func,
   742					  "Cleanup function must not be NULL");
   743	
   744		res = kzalloc(sizeof(*res), internal_gfp);
 > 745		if (!res) {
   746			cleanup_func(data);
   747			KUNIT_ASSERT_FAILURE(test, "Could not allocate resource for cleanup");
   748		}
   749	
 > 750		res->cleanup_func = cleanup_func;
   751		res->resource.should_kfree = true;
   752	
   753		/* Cannot fail as init is NULL */
   754		__kunit_add_resource(test, NULL, kunit_auto_cleanup_free,
   755				     &res->resource, (void *)data);
   756	}
   757	EXPORT_SYMBOL_GPL(kunit_add_cleanup);
   758	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
