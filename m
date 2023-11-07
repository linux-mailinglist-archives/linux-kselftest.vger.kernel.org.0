Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8F7E3239
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 01:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjKGAbT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 19:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjKGAbS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 19:31:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8E11BC;
        Mon,  6 Nov 2023 16:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699317075; x=1730853075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xrYiHM38iLQfDGM/2a1djaILuHvKZlmSend6LuJdjRk=;
  b=Ei5GJVF2ifIgfr7Mo+9yidTkCfFZTsf+ETtVyC1oZQWn3ZFWQCDopPjm
   gL4hqNbkSqGZ2358gqlkdB3vUuBM//+llWnEDeGM9rJoYeffnDFwyan7J
   GrAAn31gB/GWY+BC7N0ODc7Vssot//xN1bOxkwZ/e4sCnITChKGIIH2qw
   Kr8K/WRql9VjS0Nkt0LJZm5LmRYrM08+QuGan9KaJEWVaKq5qIW5dlfVG
   Y69B0uz/nC9w91C6srj59cCnaqduyOl7L7GeWGAyGmxYuj3W0KuVQShO3
   0lhYptBXHhV8FIzLEckwFhoctGLVxl0bazGYi2gwPzHAs4rmiO5ZpYUcT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="389204528"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="389204528"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 16:31:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="766122984"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="766122984"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 Nov 2023 16:31:11 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r09zp-0006qY-2J;
        Tue, 07 Nov 2023 00:31:09 +0000
Date:   Tue, 7 Nov 2023 08:30:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado 
        <sergio.collado@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     oe-kbuild-all@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] Kunit to check the longest symbol length
Message-ID: <202311070705.7aFWz7q4-lkp@intel.com>
References: <20231105184010.49194-1-sergio.collado@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105184010.49194-1-sergio.collado@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sergio,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6 next-20231106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sergio-Gonz-lez-Collado/Kunit-to-check-the-longest-symbol-length/20231106-024653
base:   linus/master
patch link:    https://lore.kernel.org/r/20231105184010.49194-1-sergio.collado%40gmail.com
patch subject: [PATCH] Kunit to check the longest symbol length
config: i386-randconfig-014-20231106 (https://download.01.org/0day-ci/archive/20231107/202311070705.7aFWz7q4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311070705.7aFWz7q4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311070705.7aFWz7q4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/tools/insn_decoder_test: error: malformed line 1810458:
   7nnnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
