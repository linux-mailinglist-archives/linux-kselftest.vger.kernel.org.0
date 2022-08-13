Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921D5591C62
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Aug 2022 21:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiHMTGe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 Aug 2022 15:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiHMTGd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 Aug 2022 15:06:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E805192BA;
        Sat, 13 Aug 2022 12:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660417592; x=1691953592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7YDN0J/Reetlqh2ldMy+An+DYONB13clcRB49v+Hnrw=;
  b=Q3ViMBUd2DFwtdeEZ0nSvRWkkpN1y5n5fz9jadQ742xpBpGPrDyNndN8
   4OdKDJEZudq32Fw7jKx1ZriUh2N6f4ihHyjOsN4KezqQMUAil/aP4mNmb
   mjEAZkdmRE8Rva5q+Hf2OmqTjvp9E2cwF9Eelom6jVNIDvWcTwjbpk/9M
   FHjMkyF4rPT2hBbgqiu6J+28oJeLROd3BU4HjtMKROf1O1G2lIyRkTKeV
   LvFlA4pRyYEQUMvD+3q6FnaEWfMLo/xTlCeER4PwMQSvhm4iUYxeQUVNh
   LjFXBqaEFB8dKeM+gwKaP2ISowD6vCir1hH1eYUSbW98+QlwtHZ6DQ6tk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="291770758"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="291770758"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 12:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="606243381"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2022 12:06:28 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMwSp-000214-2T;
        Sat, 13 Aug 2022 19:06:27 +0000
Date:   Sun, 14 Aug 2022 03:06:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     jeffxu@google.com, skhan@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH v2 5/5] sysctl: add support for mfd_noexec
Message-ID: <202208140205.5zR1h5VB-lkp@intel.com>
References: <20220805222126.142525-6-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805222126.142525-6-jeffxu@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 9e2f40233670c70c25e0681cb66d50d1e2742829]

url:    https://github.com/intel-lab-lkp/linux/commits/jeffxu-google-com/mm-memfd-MFD_NOEXEC-for-memfd_create/20220806-062430
base:   9e2f40233670c70c25e0681cb66d50d1e2742829
config: openrisc-randconfig-r004-20220805 (https://download.01.org/0day-ci/archive/20220814/202208140205.5zR1h5VB-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e71897c778df5381c6d1ca858ae096a557a08a2a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review jeffxu-google-com/mm-memfd-MFD_NOEXEC-for-memfd_create/20220806-062430
        git checkout e71897c778df5381c6d1ca858ae096a557a08a2a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> or1k-linux-ld: kernel/sysctl.o:(.data+0x440): undefined reference to `sysctl_mfd_noexec_scope'
>> or1k-linux-ld: kernel/sysctl.o:(.data+0x450): undefined reference to `mfd_noexec_dointvec_minmax'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
