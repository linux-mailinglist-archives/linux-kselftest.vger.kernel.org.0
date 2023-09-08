Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9662F7990C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 22:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjIHUDB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 16:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbjIHUDA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 16:03:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F267210DF;
        Fri,  8 Sep 2023 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694203359; x=1725739359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R88nXWWc0OUb6aIDazZdF1rypv5AxHZtVExhYQzX2hM=;
  b=XG4DuEg7Rt6taSiKZKPn/NP0NwDAy7Qjgf+WM2OhKopD6y/OX/9MO+sV
   qdlZqqUKfJ9HaV2ax6IC4uJ9+2MerKQLqfkjF8+XjBxOVBrSNcaWUAzRL
   YJxlF2QyIOkuroetY8MRFCYw7KSPvl33sXZ18YRdPLftA8AMllp6keODx
   /SvPWsLyZccz0rtG8fBxClUnt/4wkgVS/RWfafaJSFHQHwUUkmzk2356a
   kvynUR0GFOTUnaCTZAHGL/+a0T7pCZsYOY3k1+dtcBUp61ZCCr1F6Bm6Q
   pN2Ukn1iZ/6pl2jOhUsCUI0X9JwgpHjA/ruqVK+0SRoJ+QlwefKurnKlL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="357200341"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="357200341"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 13:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="885782557"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="885782557"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Sep 2023 13:02:10 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qehgP-0002Yc-0X;
        Fri, 08 Sep 2023 20:02:25 +0000
Date:   Sat, 9 Sep 2023 04:02:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Clapinski <mclapinski@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Yi Liu <yi.l.liu@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Steve French <stfrench@microsoft.com>,
        Simon Ser <contact@emersion.fr>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Luca Vizzarro <Luca.Vizzarro@arm.com>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Clapinski <mclapinski@google.com>
Subject: Re: [PATCH v2 1/2] mm/memfd: add ioctl(MEMFD_CHECK_IF_ORIGINAL)
Message-ID: <202309090301.rMwXPz1I-lkp@intel.com>
References: <20230908175738.41895-2-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908175738.41895-2-mclapinski@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Michal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Clapinski/mm-memfd-add-ioctl-MEMFD_CHECK_IF_ORIGINAL/20230909-020048
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230908175738.41895-2-mclapinski%40google.com
patch subject: [PATCH v2 1/2] mm/memfd: add ioctl(MEMFD_CHECK_IF_ORIGINAL)
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20230909/202309090301.rMwXPz1I-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309090301.rMwXPz1I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309090301.rMwXPz1I-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/shmem.c:4480:13: warning: 'shmem_file_ioctl' defined but not used [-Wunused-function]
    4480 | static long shmem_file_ioctl(struct file *file, unsigned int cmd,
         |             ^~~~~~~~~~~~~~~~


vim +/shmem_file_ioctl +4480 mm/shmem.c

  4479	
> 4480	static long shmem_file_ioctl(struct file *file, unsigned int cmd,
  4481				     unsigned long arg)
  4482	{
  4483		return memfd_ioctl(file, cmd, arg);
  4484	}
  4485	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
