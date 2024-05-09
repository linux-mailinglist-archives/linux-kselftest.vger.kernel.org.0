Return-Path: <linux-kselftest+bounces-9758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7988C0A2E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 05:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01DB1F23551
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 03:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DD3147C6B;
	Thu,  9 May 2024 03:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlAqsFFH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80057146D71;
	Thu,  9 May 2024 03:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715225641; cv=none; b=aC8IhLei3owc4IpCH1ATN2a4f93mx060gnAMo5o7vzVh92VXMgTEeG9aJSHlLGVLFnac93Kwuk77RWZAXivnviPfqvD6EfNPR9QuM3Mq91Eae+q72xIEs7ao3GetPhZKBtOCaWmKibyOqJDnmy/Cwo+m27LY1Kv626Dl7BvEh4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715225641; c=relaxed/simple;
	bh=ddq2PrSc8jg2qRz2VY92lmOAPCg7XWrl3IgtCa1cQvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCSe8+13ls3BtNao+rHJhf2idV6Vr9DvMrpdikZ0aC3Ay2MjktF3oDawH/aktURChSehQQtTj5LPljiZQeil4ApGCsMk/SOS/iP9ckq8K9bQdRrLPKqnUv2YKpCTAmJ40Tdcy/b7HNlEI6czFNFzIti5R2b142ntPdO+zIzSKBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlAqsFFH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715225639; x=1746761639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ddq2PrSc8jg2qRz2VY92lmOAPCg7XWrl3IgtCa1cQvo=;
  b=BlAqsFFHiuF5cLbRh5mTLh/5ePZ6d2pS4sXWzSN0B6mNAfCHMHPa3Fba
   JnjVX+RpgVm9W19n5436aIC6N+BvlowKwNjRNAGUnoNObDagaGc47yRTf
   0LHnJYr10CxCgEln/Z7gkCJYDHwm66KLlwCrxMXvXkdMMA3SZi+sShWfe
   oGSJg+vVfuSrm3WcV7BNd7bjsUHRbS1qrwPGDh9ZUP1tNg7Pj25heXG+K
   M4oqhEdFe53BIqFPGlUzVa06t62sJVkS/fU7Gl8OhHiOvHGV0ocG83VZ8
   PXoA7W675HYEZakw9a+dASiPWXWGjzbliavwR0McV5V4VOq+tl9rrkBma
   w==;
X-CSE-ConnectionGUID: jyCc79hNRUmAtK6nXPsQYA==
X-CSE-MsgGUID: FGrtLq85TYS+3XY8ZBG/CQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10955006"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="10955006"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 20:33:58 -0700
X-CSE-ConnectionGUID: JtLEBq92TX6Gb0LE2tdZCA==
X-CSE-MsgGUID: G/flVZurRIC846hEpl08ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="33907996"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 May 2024 20:33:55 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4uXY-0004PA-2N;
	Thu, 09 May 2024 03:33:52 +0000
Date: Thu, 9 May 2024 11:33:32 +0800
From: kernel test robot <lkp@intel.com>
To: Ivan Orlov <ivan.orlov0322@gmail.com>, brendan.higgins@linux.dev,
	davidgow@google.com, rmoar@google.com
Cc: oe-kbuild-all@lists.linux.dev, Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] kunit: Cover 'assert.c' with tests
Message-ID: <202405091128.Rh6iS2He-lkp@intel.com>
References: <20240508132557.599213-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508132557.599213-1-ivan.orlov0322@gmail.com>

Hi Ivan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/kunit]
[also build test WARNING on linus/master v6.9-rc7 next-20240508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Orlov/kunit-Cover-assert-c-with-tests/20240508-212654
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit
patch link:    https://lore.kernel.org/r/20240508132557.599213-1-ivan.orlov0322%40gmail.com
patch subject: [PATCH v2] kunit: Cover 'assert.c' with tests
config: x86_64-randconfig-121-20240509 (https://download.01.org/0day-ci/archive/20240509/202405091128.Rh6iS2He-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240509/202405091128.Rh6iS2He-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405091128.Rh6iS2He-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/kunit/assert_test.c:368:19: sparse: sparse: symbol 'assert_test_cases' was not declared. Should it be static?
>> lib/kunit/assert_test.c:383:20: sparse: sparse: symbol 'assert_test_suite' was not declared. Should it be static?

vim +/assert_test_cases +368 lib/kunit/assert_test.c

   367	
 > 368	struct kunit_case assert_test_cases[] = {
   369		KUNIT_CASE(kunit_test_is_literal),
   370		KUNIT_CASE(kunit_test_is_str_literal),
   371		KUNIT_CASE(kunit_test_assert_prologue),
   372		KUNIT_CASE(kunit_test_assert_print_msg),
   373		KUNIT_CASE(kunit_test_unary_assert_format),
   374		KUNIT_CASE(kunit_test_ptr_not_err_assert_format),
   375		KUNIT_CASE(kunit_test_binary_assert_format),
   376		KUNIT_CASE(kunit_test_binary_ptr_assert_format),
   377		KUNIT_CASE(kunit_test_binary_str_assert_format),
   378		KUNIT_CASE(kunit_test_assert_hexdump),
   379		KUNIT_CASE(kunit_test_mem_assert_format),
   380		{}
   381	};
   382	
 > 383	struct kunit_suite assert_test_suite = {
   384		.name = "kunit-assert",
   385		.test_cases = assert_test_cases,
   386	};
   387	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

