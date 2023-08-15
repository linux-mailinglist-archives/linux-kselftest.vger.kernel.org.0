Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B7877C867
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 09:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbjHOHRA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 03:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjHOHQe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 03:16:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A3510F2;
        Tue, 15 Aug 2023 00:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692083793; x=1723619793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mqpW8dLHNLWmnXIgpv0wcWy9H6kceWlZT7a9uKG7nyY=;
  b=lcEv4XmEQVU00HHSAbjqZZ1S0ay+Ids2wMrSHl+CWhRR2yv7VfwDNp+S
   XU5xg4KhthIb2lDEK1Oa+36XCQWwFQADFnplD7vxt4zHZG2so02h0iOui
   QOMFnOohvEW+syWWR5CMqaPcb5ecLC1+FSBGirND9wsCQF80AZJiW+zMG
   58a/YcZwCGvuXkAykBsdKzmCeSCpQgypk5uKNa/1eLqgedQaW5Iimtg6v
   vnOeEH9ZM5egc7ir9NzJNCLJdoaEeFXpwtqXMDhjwsi+wSPMSnsWq2reo
   jhAGVPxfEBJu7aS97QEA3BPoYwRfGRZila3mhbzEcFTVt3HTIzBpq7h8u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="369692381"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="369692381"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 00:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="733750361"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="733750361"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2023 00:16:30 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVoI1-0000l1-1L;
        Tue, 15 Aug 2023 07:16:29 +0000
Date:   Tue, 15 Aug 2023 15:16:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH v4 01/10] kunit: string-stream: Improve testing of
 string_stream
Message-ID: <202308151555.o0Ok5tyv-lkp@intel.com>
References: <20230814132309.32641-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814132309.32641-2-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
patch link:    https://lore.kernel.org/r/20230814132309.32641-2-rf%40opensource.cirrus.com
patch subject: [PATCH v4 01/10] kunit: string-stream: Improve testing of string_stream
config: arc-randconfig-r073-20230815 (https://download.01.org/0day-ci/archive/20230815/202308151555.o0Ok5tyv-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308151555.o0Ok5tyv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308151555.o0Ok5tyv-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/kunit/string-stream-test.c:25:9: sparse: sparse: incorrect type in initializer (different base types) @@     expected long long left_value @@     got restricted gfp_t const __left @@
   lib/kunit/string-stream-test.c:25:9: sparse:     expected long long left_value
   lib/kunit/string-stream-test.c:25:9: sparse:     got restricted gfp_t const __left
>> lib/kunit/string-stream-test.c:25:9: sparse: sparse: incorrect type in initializer (different base types) @@     expected long long right_value @@     got restricted gfp_t const __right @@
   lib/kunit/string-stream-test.c:25:9: sparse:     expected long long right_value
   lib/kunit/string-stream-test.c:25:9: sparse:     got restricted gfp_t const __right

vim +25 lib/kunit/string-stream-test.c

    13	
    14	/* string_stream object is initialized correctly. */
    15	static void string_stream_init_test(struct kunit *test)
    16	{
    17		struct string_stream *stream;
    18	
    19		stream = alloc_string_stream(test, GFP_KERNEL);
    20		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
    21	
    22		KUNIT_EXPECT_EQ(test, stream->length, 0);
    23		KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
    24		KUNIT_EXPECT_PTR_EQ(test, stream->test, test);
  > 25		KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
    26	
    27		KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
    28	}
    29	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
