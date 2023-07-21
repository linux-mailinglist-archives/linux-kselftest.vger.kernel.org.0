Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02EC75BD4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 06:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjGUEcG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 00:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGUEcF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 00:32:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B770C268E;
        Thu, 20 Jul 2023 21:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689913923; x=1721449923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6GVU4NtSBfHGIA+db9VVes1wkK8Q3Ya1oLA7sHzSrXM=;
  b=F5pji8Vu6vJcyPzDR/Fed80so5doKRh0OoKwDyJDzYgNitbprKUN91Fm
   h3SXNCGLSOa3CJPuYdeEPpRPkin/40Y6Z898ON3Qp4b96od+JXHAuO0ii
   XsP0woe6BBoED+2WoGpG6/hC8XSKUalRcN/hyHe6UrOOD4+XPOgYUzEcB
   DU5ji/wrf1TyFQgJibbLD9NH5QtzAzhVZXn+QPuTfvg3Va/wPV0Tw1oy6
   ZqeRa/0mFFKoDhfnL/ZuT2EviAjnchQ0h+S+y4pOB4WlxjdvTzIZi3yG5
   LHBgPr5Awi6PRIXLOcvHhwN4pTgtShfx+A4nx5/ZP5cOWBIe6laiTjQSX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370533071"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="370533071"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 21:32:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="674910112"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="674910112"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 20 Jul 2023 21:31:59 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMho1-0006sZ-2n;
        Fri, 21 Jul 2023 04:31:55 +0000
Date:   Fri, 21 Jul 2023 12:31:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rae Moar <rmoar@google.com>, shuah@kernel.org, davidgow@google.com,
        dlatypov@google.com, brendan.higgins@linux.dev
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v1 2/9] kunit: Add speed attribute
Message-ID: <202307211202.hZ3gtW5S-lkp@intel.com>
References: <20230719222338.259684-3-rmoar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719222338.259684-3-rmoar@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Rae,

kernel test robot noticed the following build errors:

[auto build test ERROR on 64bd4641310c41a1ecf07c13c67bc0ed61045dfd]

url:    https://github.com/intel-lab-lkp/linux/commits/Rae-Moar/kunit-Add-test-attributes-API-structure/20230720-062623
base:   64bd4641310c41a1ecf07c13c67bc0ed61045dfd
patch link:    https://lore.kernel.org/r/20230719222338.259684-3-rmoar%40google.com
patch subject: [PATCH v1 2/9] kunit: Add speed attribute
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230721/202307211202.hZ3gtW5S-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307211202.hZ3gtW5S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307211202.hZ3gtW5S-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/kunit/attributes.c:89:47: error: initializer element is not a compile-time constant
   static struct kunit_attr kunit_attr_list[] = {speed_attr};
                                                 ^~~~~~~~~~
   1 error generated.


vim +89 lib/kunit/attributes.c

    88	
  > 89	static struct kunit_attr kunit_attr_list[] = {speed_attr};
    90	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
