Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AB27E4957
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 20:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjKGTlO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 14:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjKGTlN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 14:41:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FFC10C1;
        Tue,  7 Nov 2023 11:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699386071; x=1730922071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=04PYEU/8AXnKyx06s6nH7m2enfZ7kWNT0WtNcne+y9s=;
  b=jM9aEm2VbBKayg7SLN/vZCWTTnC2zrP8/yAtRfE+ByrGTrxNwHjqr0pL
   /cyzDaDOyLBO4ImBFxoEIW6L0IAsbU2dp1fZVjuzezMVpxmjjInEXD6d+
   oA1BOGbSiwkW7YHL7x7AgyidxWL9dOyHV3szWxScY638XJlHHjUz1kGxS
   zBNH+txnZhnqS3OzPng+s3cI8kcdqq62vnuy/4D/ZxtqMGa3CCaX0wKIo
   uUu7jmfW4GkEcLfzJTgpflCv/D5n7AAD1jASrpKVuJ7xeJksjQqE8Q4u6
   2hqX0ZY67Cp6rCTTHWu9FZNHqTUCYVxvBikKqJ1ur115gPvWE2wd0Q45T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="456087212"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="456087212"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 11:41:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="766407926"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="766407926"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2023 11:41:06 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0Rwe-0007MK-18;
        Tue, 07 Nov 2023 19:41:04 +0000
Date:   Wed, 8 Nov 2023 03:34:50 +0800
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
Message-ID: <202311080319.fCEp5dTC-lkp@intel.com>
References: <20231105184010.49194-1-sergio.collado@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105184010.49194-1-sergio.collado@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sergio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6 next-20231107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sergio-Gonz-lez-Collado/Kunit-to-check-the-longest-symbol-length/20231106-024653
base:   linus/master
patch link:    https://lore.kernel.org/r/20231105184010.49194-1-sergio.collado%40gmail.com
patch subject: [PATCH] Kunit to check the longest symbol length
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231108/202311080319.fCEp5dTC-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231108/202311080319.fCEp5dTC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311080319.fCEp5dTC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/longest_symbol_kunit.c:16:18: warning: no previous prototype for 'snnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7n' [-Wmissing-prototypes]
      16 | #define DI(name) s##name##name
         |                  ^
   lib/longest_symbol_kunit.c:17:19: note: in expansion of macro 'DI'
      17 | #define DDI(name) DI(n##name##name)
         |                   ^~
   lib/longest_symbol_kunit.c:18:20: note: in expansion of macro 'DDI'
      18 | #define DDDI(name) DDI(n##name##name)
         |                    ^~~
   lib/longest_symbol_kunit.c:19:21: note: in expansion of macro 'DDDI'
      19 | #define DDDDI(name) DDDI(n##name##name)
         |                     ^~~~
   lib/longest_symbol_kunit.c:20:22: note: in expansion of macro 'DDDDI'
      20 | #define DDDDDI(name) DDDDI(n##name##name)
         |                      ^~~~~
   lib/longest_symbol_kunit.c:25:27: note: in expansion of macro 'DDDDDI'
      25 | #define LONGEST_SYM_NAME  DDDDDI(g1h2i3j4k5l6m7n)
         |                           ^~~~~~
   lib/longest_symbol_kunit.c:33:14: note: in expansion of macro 'LONGEST_SYM_NAME'
      33 | noinline int LONGEST_SYM_NAME(void)
         |              ^~~~~~~~~~~~~~~~
   In file included from <command-line>:
   lib/longest_symbol_kunit.c:16:18: warning: no previous prototype for 'snnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7ne' [-Wmissing-prototypes]
      16 | #define DI(name) s##name##name
         |                  ^
   include/linux/compiler_types.h:83:23: note: in definition of macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   lib/longest_symbol_kunit.c:22:21: note: in expansion of macro '__PASTE'
      22 | #define PLUS1(name) __PASTE(name, e)
         |                     ^~~~~~~
   lib/longest_symbol_kunit.c:28:32: note: in expansion of macro 'PLUS1'
      28 | #define LONGEST_SYM_NAME_PLUS1 PLUS1(LONGEST_SYM_NAME)
         |                                ^~~~~
   lib/longest_symbol_kunit.c:17:19: note: in expansion of macro 'DI'
      17 | #define DDI(name) DI(n##name##name)
         |                   ^~
   lib/longest_symbol_kunit.c:18:20: note: in expansion of macro 'DDI'
      18 | #define DDDI(name) DDI(n##name##name)
         |                    ^~~
   lib/longest_symbol_kunit.c:19:21: note: in expansion of macro 'DDDI'
      19 | #define DDDDI(name) DDDI(n##name##name)
         |                     ^~~~
   lib/longest_symbol_kunit.c:20:22: note: in expansion of macro 'DDDDI'
      20 | #define DDDDDI(name) DDDDI(n##name##name)
         |                      ^~~~~
   lib/longest_symbol_kunit.c:25:27: note: in expansion of macro 'DDDDDI'
      25 | #define LONGEST_SYM_NAME  DDDDDI(g1h2i3j4k5l6m7n)
         |                           ^~~~~~
   lib/longest_symbol_kunit.c:28:38: note: in expansion of macro 'LONGEST_SYM_NAME'
      28 | #define LONGEST_SYM_NAME_PLUS1 PLUS1(LONGEST_SYM_NAME)
         |                                      ^~~~~~~~~~~~~~~~
   lib/longest_symbol_kunit.c:38:14: note: in expansion of macro 'LONGEST_SYM_NAME_PLUS1'
      38 | noinline int LONGEST_SYM_NAME_PLUS1(void)
         |              ^~~~~~~~~~~~~~~~~~~~~~


vim +/snnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7n +16 lib/longest_symbol_kunit.c

    15	
  > 16	#define DI(name) s##name##name
    17	#define DDI(name) DI(n##name##name)
    18	#define DDDI(name) DDI(n##name##name)
    19	#define DDDDI(name) DDDI(n##name##name)
    20	#define DDDDDI(name) DDDDI(n##name##name)
    21	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
