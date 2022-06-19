Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478C3550BE1
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Jun 2022 17:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiFSPlK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Jun 2022 11:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFSPlJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Jun 2022 11:41:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8916E646B;
        Sun, 19 Jun 2022 08:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655653268; x=1687189268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OagA+1S5NVI9Ja8/jPij45wYg6CoVWVppDPjbSk9qus=;
  b=GBdhA2L2koc966Q9SEy4yKmkSYNCIr1hGPCR6W0VHyvPNkAlZPBF9K1t
   uStDiBrckkWx7cUxsMRkzmZEqZKtU6EnDdC+OEfgLM8CrTAwb502AaNxs
   K2hD0IvXIJDeD+ymq5xckT5LlJPsQmyFgeIVSfTYgVdkclSzdifP/U/HY
   2RKYz2JoqXGNRbZUKlZ3fQ1KC16+nUBSPWwmUny1t4c4pIz2nmJiyW+jV
   fF7Xvv716JZCXKvsoCNcCVOwA4s/+6KVPMAwATU9jJmBtV3YIbkj92WUV
   NwpR5FJ3v4O/q1R+Hl0h+f7jFDbaOgqa3LNYUX1PqLBgSPA3Or6igAfkp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278512916"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278512916"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 08:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642751666"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jun 2022 08:41:02 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2x2r-000RKV-SK;
        Sun, 19 Jun 2022 15:41:01 +0000
Date:   Sun, 19 Jun 2022 23:40:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com
Cc:     kbuild-all@lists.01.org,
        =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] drm: selftest: convert drm_framebuffer selftest to
 KUnit
Message-ID: <202206192329.jxlyMOhN-lkp@intel.com>
References: <20220615135824.15522-9-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615135824.15522-9-maira.canal@usp.br>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi "Maíra,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on linus/master v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-ra-Canal/drm-selftest-Convert-to-KUnit/20220615-220404
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220619/202206192329.jxlyMOhN-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5109526a34e7196931f36b5537031eaa601de997
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ma-ra-Canal/drm-selftest-Convert-to-KUnit/20220615-220404
        git checkout 5109526a34e7196931f36b5537031eaa601de997
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in drivers/gpu/drm/tests/test-drm_plane_helper.o
ERROR: modpost: missing MODULE_LICENSE() in drivers/gpu/drm/tests/test-drm_dp_mst_helper.o
ERROR: modpost: "drm_dp_encode_sideband_req" [drivers/gpu/drm/tests/test-drm_dp_mst_helper.ko] undefined!
ERROR: modpost: "drm_dp_decode_sideband_req" [drivers/gpu/drm/tests/test-drm_dp_mst_helper.ko] undefined!
ERROR: modpost: "drm_dp_dump_sideband_msg_req_body" [drivers/gpu/drm/tests/test-drm_dp_mst_helper.ko] undefined!
>> ERROR: modpost: "drm_internal_framebuffer_create" [drivers/gpu/drm/tests/test-drm_framebuffer.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
