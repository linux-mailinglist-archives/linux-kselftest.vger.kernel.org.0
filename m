Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833716CF57A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 23:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjC2VoS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 17:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjC2VoR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 17:44:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8FE40DC;
        Wed, 29 Mar 2023 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680126256; x=1711662256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1887wZTzP8ET7u0wKkq/ED3uz/APO7su2aHaXdEaid8=;
  b=DajTOv6q9OpTgXAcESYLiURixsZAeufSG0LMBUJKvMrGX72FZvzxWV70
   ZD7pCwNERZ6HiCZknaTftaH99p6WW20xH1WjavpKLTeRmLMmLBjxOfT0+
   NNnQBWgUwulZbeNbwyGY24zI6EunkPYFZyhclj87HYDisjoNZ/tcdJ8xs
   /NP3V+U86nq4nce6ui6kvZroHPeHzEDRikaqpodQVKNSxThM6eDrPhHP6
   TM/ig6qKOqjnVlE+/urvyJsulVVXHLIWhqxHFXCyXNdZEPNwOeIlN1dLl
   YOy4noKgcrT9YsBAWPmzfS8qOBdM6xyUaZchCW61XYgys1LctiF9p+d7D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="427280363"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="427280363"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 14:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="828046918"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="828046918"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2023 14:44:14 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phdaX-000JzN-2k;
        Wed, 29 Mar 2023 21:44:13 +0000
Date:   Thu, 30 Mar 2023 05:43:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxime Ripard <maxime@cerno.tech>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH 1/2] drivers: base: Add basic devm tests for root devices
Message-ID: <202303300531.8jq5jsDC-lkp@intel.com>
References: <20230329-kunit-devm-inconsistencies-test-v1-1-c33127048375@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v1-1-c33127048375@cerno.tech>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maxime,

I love your patch! Perhaps something to improve:

[auto build test WARNING on a6faf7ea9fcb7267d06116d4188947f26e00e57e]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Ripard/drivers-base-Add-basic-devm-tests-for-root-devices/20230330-034149
base:   a6faf7ea9fcb7267d06116d4188947f26e00e57e
patch link:    https://lore.kernel.org/r/20230329-kunit-devm-inconsistencies-test-v1-1-c33127048375%40cerno.tech
patch subject: [PATCH 1/2] drivers: base: Add basic devm tests for root devices
config: arc-randconfig-r043-20230329 (https://download.01.org/0day-ci/archive/20230330/202303300531.8jq5jsDC-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a6c0627f4059cf0565eec2bb99fc7453e20b5c51
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Maxime-Ripard/drivers-base-Add-basic-devm-tests-for-root-devices/20230330-034149
        git checkout a6c0627f4059cf0565eec2bb99fc7453e20b5c51
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303300531.8jq5jsDC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/test/.kunitconfig: warning: ignored by one of the .gitignore files
   drivers/clk/.kunitconfig: warning: ignored by one of the .gitignore files
   drivers/gpu/drm/tests/.kunitconfig: warning: ignored by one of the .gitignore files
   drivers/gpu/drm/vc4/tests/.kunitconfig: warning: ignored by one of the .gitignore files
   drivers/hid/.kunitconfig: warning: ignored by one of the .gitignore files
   fs/ext4/.kunitconfig: warning: ignored by one of the .gitignore files
   fs/fat/.kunitconfig: warning: ignored by one of the .gitignore files
   kernel/kcsan/.kunitconfig: warning: ignored by one of the .gitignore files
   lib/kunit/.kunitconfig: warning: ignored by one of the .gitignore files
   mm/kfence/.kunitconfig: warning: ignored by one of the .gitignore files
   net/sunrpc/.kunitconfig: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/config: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/settings: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
