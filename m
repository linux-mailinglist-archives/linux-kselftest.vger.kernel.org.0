Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E304057FE3C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jul 2022 13:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiGYLU1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jul 2022 07:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbiGYLU0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jul 2022 07:20:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D48317AAA;
        Mon, 25 Jul 2022 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658748024; x=1690284024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RuTOhHe/Z85XuEOFDkWIJLJ9pTTo7hHky8fWNmi6cLg=;
  b=ADsEC+8zMFNW7TNS9MmzGWKUBVLeRpbXZB324hu2sDpfzD06HQ+1Egf3
   E4v4za7yIXMvWuQdJxmUF/n+zYuKfgE+HngSYktEFeVFSwsCYpk990q2Y
   6orSK+k53nsrWTk0SnAnETtlBw2gUTTk6sfjC1kLiKF6sNaTKtxr+qLFW
   /ei2LE8J7Y4vyFihMgVAOaT0j8CmoyBvMv3OyMp8v3/XxfR0fFXlKLFA4
   7nYVsE4SdJTYyU6v+78wacf30AR5350YnzNlFBXNrSkCWUmBjsH89oKG7
   E+tOU2sSaeodXVwrK7B8osL/vVEgLnJOpG1SalEF+mmpxlVhWSO/aWPwj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="351669323"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="351669323"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 04:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="689025180"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jul 2022 04:20:21 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFw8K-00052K-1s;
        Mon, 25 Jul 2022 11:20:20 +0000
Date:   Mon, 25 Jul 2022 19:19:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sadiya Kazi <sadiyakazi@google.com>, brendanhiggins@google.com,
        davidgow@google.com, skhan@linuxfoundation.org, corbet@lwn.net,
        mairacanal@riseup.net
Cc:     kbuild-all@lists.01.org, Sadiya Kazi <sadiyakazi@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: kunit: Add CLI args for kunit_tool
Message-ID: <202207251914.OgQ6lGdw-lkp@intel.com>
References: <20220724184758.1723925-1-sadiyakazi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724184758.1723925-1-sadiyakazi@google.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sadiya,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on linus/master v5.19-rc8 next-20220722]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sadiya-Kazi/Documentation-kunit-Add-CLI-args-for-kunit_tool/20220725-025055
base:   git://git.lwn.net/linux.git docs-next
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/dev-tools/kunit/run_wrapper.rst:262: WARNING: Unexpected indentation.

vim +262 Documentation/dev-tools/kunit/run_wrapper.rst

   226	
   227	- ``--help``: Lists all available options. To list common options,
   228	  place ``--help`` before the command. To list options specific to that
   229	  command, place ``--help`` after the command.
   230	
   231	  .. note:: Different commands (``config``, ``build``, ``run``, etc)
   232	            have different supported options.
   233	- ``--build_dir``: Specifies kunit_tool build directory. It includes
   234	  the ``.kunitconfig``, ``.config`` files and compiled kernel.
   235	
   236	- ``--make_options``: Specifies additional options to pass to make, when
   237	  compiling a kernel (using ``build`` or ``run`` commands). For example:
   238	  to enable compiler warnings, we can pass ``--make_options W=1``.
   239	
   240	- ``--alltests``: Builds a UML kernel with all config options enabled
   241	  using ``make allyesconfig``. This allows us to run as many tests as
   242	  possible.
   243	
   244	  .. note:: It is slow and prone to breakage as new options are
   245	            added or modified. Instead, enable all tests
   246	            which have satisfied dependencies by adding
   247	            ``CONFIG_KUNIT_ALL_TESTS=y`` to your ``.kunitconfig``.
   248	
   249	- ``--kunitconfig``: Specifies the path or the directory of the ``.kunitconfig``
   250	  file. For example:
   251	
   252	  - ``lib/kunit/.kunitconfig`` can be the path of the file.
   253	
   254	  - ``lib/kunit`` can be the directory in which the file is located.
   255	
   256	  This file is used to build and run with a predefined set of tests
   257	  and their dependencies. For example, to run tests for a given subsystem.
   258	
   259	- ``--kconfig_add``: Specifies additional configuration options to be
   260	  appended to the ``.kunitconfig`` file. For example:
   261	  .. code-block::
 > 262		./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
   263	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
