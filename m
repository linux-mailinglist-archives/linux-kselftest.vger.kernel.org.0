Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA866F4CD4
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 May 2023 00:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEBWPr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 18:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBWPq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 18:15:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BD31BDF;
        Tue,  2 May 2023 15:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683065745; x=1714601745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0I5ig81uZ02aMnVMkminXlKbbHCg627kqdairoEgsuE=;
  b=jKWFKLIY3FXQLG7vyYXCFxZ8Jj7bIezT9iZUXPx39aNqlZJatEdpBLDI
   GuB9/ZAgHqXoy+fYhX6a6IbDdTHgaLoNL68BbWc0rrpBh+3e7X/aCmV06
   z+hGiDxohihLAc+qZRg3bPZOr9HpZ9Vn6shh/TYg2Vr+V5wQ3YKMpfRVx
   zyYFDvP034ATW6Igvc10rk2BH5e1mReaINNL+ZoDj1pCBstGeZEyFZWWT
   FW5Ci4OfJq0YKw7/fFgInZqqWtlAyWuxchUXKvCTupQ/ZWJregMklC3pb
   r8eQE1j/GN4RNyZ2pn3SPu6sxsDJjjb81pJn3Pn2c3sRFQ6kf0c7TexQX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="351496616"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="351496616"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 15:15:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="870717195"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="870717195"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 May 2023 15:15:41 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ptyHc-0001JS-0Y;
        Tue, 02 May 2023 22:15:40 +0000
Date:   Wed, 3 May 2023 06:15:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ajay Kaher <akaher@vmware.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, shuah@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH v2 4/9] eventfs: adding eventfs file, directory remove
 function
Message-ID: <202305030611.Kas747Ev-lkp@intel.com>
References: <1683026600-13485-5-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683026600-13485-5-git-send-email-akaher@vmware.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ajay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes linus/master rostedt-trace/for-next v6.3 next-20230428]
[cannot apply to rostedt-trace/for-next-urgent]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ajay-Kaher/eventfs-introducing-struct-tracefs_inode/20230502-192949
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/1683026600-13485-5-git-send-email-akaher%40vmware.com
patch subject: [PATCH v2 4/9] eventfs: adding eventfs file, directory remove function
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20230503/202305030611.Kas747Ev-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/9a36b39da0c3fbfe15a3c3a0ed71b52013bac292
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ajay-Kaher/eventfs-introducing-struct-tracefs_inode/20230502-192949
        git checkout 9a36b39da0c3fbfe15a3c3a0ed71b52013bac292
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash fs/tracefs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305030611.Kas747Ev-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/tracefs/event_inode.c:379:6: sparse: sparse: symbol 'eventfs_remove_rec' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
