Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E0E77C0B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 21:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjHNTXI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 15:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjHNTXF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 15:23:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DFBE5F;
        Mon, 14 Aug 2023 12:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692040977; x=1723576977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KpwpOIRxehht6Q5HjcHL8pin7vF2ossXjqiaYikcuUY=;
  b=eVPLTOM52FfAHT06+CFDTduwwXemVkk8SMODSMKdPMwNmRmN92VQM1ll
   nbfWukm8WrXS5hLIW43QLi4E+q5Xr53159W0iQ1/nj9FLKkn2L/onHw3B
   ySThpdZOnMHDm65jVWh7QFpmzFQesm+pcU2xUoK310duBNoa5+/UxAsCv
   cGOfmBvbSxNSwdyedzqmHpWw/2zAwh81NoOQ/V3hDdVCvBA1eop1tpdqJ
   UW+gpl66V7HTeBXtOPBYzkWZ8PSpfjDta/f2TW9NusXhXIgqlaZke1R9v
   wbrx+LEIixGACOqVTl6Wf7tkseX+Fube8cnb0S04+54TzsXsijVnzNOJd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="438453784"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="438453784"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 12:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="980106219"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="980106219"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 14 Aug 2023 12:22:52 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVd9Q-0000Mx-0L;
        Mon, 14 Aug 2023 19:22:52 +0000
Date:   Tue, 15 Aug 2023 03:22:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH v4 07/10] kunit: string-stream: Decouple string_stream
 from kunit
Message-ID: <202308150347.LvFXkSdz-lkp@intel.com>
References: <20230814132309.32641-8-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814132309.32641-8-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Richard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/kunit]
[also build test WARNING on shuah-kselftest/kunit-fixes linus/master v6.5-rc6 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Fitzgerald/kunit-string-stream-Improve-testing-of-string_stream/20230814-212947
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit
patch link:    https://lore.kernel.org/r/20230814132309.32641-8-rf%40opensource.cirrus.com
patch subject: [PATCH v4 07/10] kunit: string-stream: Decouple string_stream from kunit
config: hexagon-randconfig-r014-20230815 (https://download.01.org/0day-ci/archive/20230815/202308150347.LvFXkSdz-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308150347.LvFXkSdz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308150347.LvFXkSdz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/kunit/string-stream.c:199:38: warning: cast from 'void (*)(struct string_stream *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
     199 |         if (kunit_add_action_or_reset(test, (kunit_action_t *)raw_free_string_stream, stream) != 0)
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                                               ^~~~
   include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
>> lib/kunit/string-stream.c:199:38: warning: cast from 'void (*)(struct string_stream *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
     199 |         if (kunit_add_action_or_reset(test, (kunit_action_t *)raw_free_string_stream, stream) != 0)
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                                               ^~~~
   include/linux/compiler.h:57:61: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
>> lib/kunit/string-stream.c:199:38: warning: cast from 'void (*)(struct string_stream *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
     199 |         if (kunit_add_action_or_reset(test, (kunit_action_t *)raw_free_string_stream, stream) != 0)
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                                               ^~~~
   include/linux/compiler.h:57:86: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                                      ^~~~
   include/linux/compiler.h:68:3: note: expanded from macro '__trace_if_value'
      68 |         (cond) ?                                        \
         |          ^~~~
   lib/kunit/string-stream.c:210:29: warning: cast from 'void (*)(struct string_stream *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
     210 |         kunit_release_action(test, (kunit_action_t *)raw_free_string_stream, (void *)stream);
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   4 warnings generated.


vim +199 lib/kunit/string-stream.c

   188	
   189	struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
   190	{
   191		struct string_stream *stream;
   192	
   193		stream = raw_alloc_string_stream(gfp);
   194		if (IS_ERR(stream))
   195			return stream;
   196	
   197		stream->test = test;
   198	
 > 199		if (kunit_add_action_or_reset(test, (kunit_action_t *)raw_free_string_stream, stream) != 0)
   200			return ERR_PTR(-ENOMEM);
   201	
   202		return stream;
   203	}
   204	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
