Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFCA550449
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jun 2022 13:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiFRLhf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Jun 2022 07:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiFRLhY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Jun 2022 07:37:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79F41A041;
        Sat, 18 Jun 2022 04:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655552241; x=1687088241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=trJevHg9pw/ezRiw4PuJjXBPnKq5vd9v7IT0hWBUmjs=;
  b=nTfRcL+RznaoaintCyx+/llluE1JcgqCyShELSdwnOb60MHOcYT+lV2W
   UFfiXfHgjCNTTxYtLbbq1ELMK9RCar2Lt2/5q2wc4M3CmrXsBYM67MpQY
   1wBaipWSlXYw07bhHlOb3frmRdMZeFxDf+FrpPXLGDPXfIBbQcbKOnHEp
   RljMa5zvGctTR7A11W63RRq3+M9oBVhtw640CCvYehdiBr1M26Ze6hBtN
   NKLCmgIt/yvVFjUNeUUHbwEkXRlrQXPa94wMBurzB9iSoeyHNia6q9Mu9
   VHa/lmq0CI2RBCQH4i4cdRb7U9CaxLkSMNGcjVNEiBDSCnncLJatkk06P
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262690059"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262690059"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 04:37:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="912969164"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2022 04:37:16 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2WlP-000QHv-Cp;
        Sat, 18 Jun 2022 11:37:15 +0000
Date:   Sat, 18 Jun 2022 19:36:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>
Cc:     kbuild-all@lists.01.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>,
        David Gow <davidgow@google.com>
Subject: Re: [PATCH 1/5] kunit: unify module and builtin suite definitions
Message-ID: <202206181950.qNG3jcE8-lkp@intel.com>
References: <20220618090310.1174932-2-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618090310.1174932-2-davidgow@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to mcgrof/modules-next joel-aspeed/for-next ulf-hansson-mmc-mirror/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4b35035bcf80ddb47c0112c4fbd84a63a2836a18
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220618/202206181950.qNG3jcE8-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/14ff6ae01a41e301f1409874dd5aa38f73bc96f5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653
        git checkout 14ff6ae01a41e301f1409874dd5aa38f73bc96f5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash lib/kunit/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   lib/kunit/test.c: In function 'kunit_module_init':
>> lib/kunit/test.c:618:28: error: 'struct module' has no member named 'num_kunit_suites'
     618 |         for (i = 0; i < mod->num_kunit_suites; i++)
         |                            ^~
>> lib/kunit/test.c:619:45: error: 'struct module' has no member named 'kunit_suites'
     619 |                 __kunit_test_suites_init(mod->kunit_suites[i]);
         |                                             ^~
   lib/kunit/test.c: In function 'kunit_module_exit':
   lib/kunit/test.c:626:28: error: 'struct module' has no member named 'num_kunit_suites'
     626 |         for (i = 0; i < mod->num_kunit_suites; i++)
         |                            ^~
   lib/kunit/test.c:627:45: error: 'struct module' has no member named 'kunit_suites'
     627 |                 __kunit_test_suites_exit(mod->kunit_suites[i]);
         |                                             ^~


vim +618 lib/kunit/test.c

   612	
   613	#ifdef CONFIG_MODULES
   614	static void kunit_module_init(struct module *mod)
   615	{
   616		unsigned int i;
   617	
 > 618		for (i = 0; i < mod->num_kunit_suites; i++)
 > 619			__kunit_test_suites_init(mod->kunit_suites[i]);
   620	}
   621	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
