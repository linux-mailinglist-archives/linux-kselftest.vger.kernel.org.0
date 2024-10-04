Return-Path: <linux-kselftest+bounces-19057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E741990F34
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 21:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0C21F25DC2
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 19:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6911E5727;
	Fri,  4 Oct 2024 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVCrPpZ5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5751E5726;
	Fri,  4 Oct 2024 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067240; cv=none; b=Zr1dISHFs27vzeIcXsJGBoLzxXC/QcXbJbQ650OwhyRcJqhiQbExkfvN2ZkwcQmpHejtzMCf5cSu7tPHFnQykgebhLjJaWuHDzUk18jBr+bb5R79zNSd722ksLOt+2INPs/0UrB5RcrZbNI8Ytktc6tWSeZrYAEZgsQBuKkP4AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067240; c=relaxed/simple;
	bh=rCgZOpHDQFFi3/FMJI74LvTPZIfZw8kodL5qilZLE1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb6ezZ/yAyiPMY3jJ2bXW0NxogwK2KG2tsSPVySBLrhAzhVHYzKDs/QGxYfJXcBZGqta3gYUz+r2/G6lT7DUw6MTAcp74wz1iNHbdNDmjpvlXYqSxvUWgFS1vah19p9YdHRp83g0Crt7skC5OX4Y6iqEo4IzUA/1Fm3TRPfM0ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVCrPpZ5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728067239; x=1759603239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rCgZOpHDQFFi3/FMJI74LvTPZIfZw8kodL5qilZLE1g=;
  b=kVCrPpZ577mYR00LEnQ3vpMVhIfKjaecNzLAPsizcg2yZ+yfhPauQV75
   HvkmM0lufPSKwZ1iBvxnDNbQhOyMqrKiecVAPXRkA+zyV7hobDaiDqgTB
   IhxgF/9jHH2CegNrPCBsFeOrFre7S2/6MWZTKqDFT/8VkSRfQBjz+ydx2
   o4CIasvCVRNTPTaTZp/vQRy3QPCwknWAPvMQoLSWyXUNRyUrcHKW0sSKa
   A0gSDePufE0ya6U34230vBwmkeJORMXrFBv1Xa7YzWbLf5yGa3MnczCVV
   OXa+IVnXBnNrvew5EIxsF9H6a5Jzuhh32wl/jEnKCTPN9SORn+mWD+MAW
   A==;
X-CSE-ConnectionGUID: gyt+iew3TLyW2FQY+ypX4g==
X-CSE-MsgGUID: CFi/0kbJTzeoFytiOex/pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27184400"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="27184400"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 11:40:38 -0700
X-CSE-ConnectionGUID: SA1PQIikQQGTHsIKJbMGbw==
X-CSE-MsgGUID: sS6mPp/xQA6gJBI0Dl4vqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="105637362"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 04 Oct 2024 11:40:35 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swnE8-000254-1T;
	Fri, 04 Oct 2024 18:40:32 +0000
Date: Sat, 5 Oct 2024 02:40:21 +0800
From: kernel test robot <lkp@intel.com>
To: Vinicius Peixoto <vpeixoto@lkcamp.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	Vinicius Peixoto <vpeixoto@lkcamp.dev>,
	Enzo Bertoloti <ebertoloti@lkcamp.dev>,
	Fabricio Gasperin <fgasperin@lkcamp.dev>,
	David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v2] lib/crc16_kunit.c: add KUnit tests for crc16
Message-ID: <202410050215.eU9509xy-lkp@intel.com>
References: <20241003-crc16-kunit-v2-1-5fe74b113e1e@lkcamp.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003-crc16-kunit-v2-1-5fe74b113e1e@lkcamp.dev>

Hi Vinicius,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9852d85ec9d492ebef56dc5f229416c925758edc]

url:    https://github.com/intel-lab-lkp/linux/commits/Vinicius-Peixoto/lib-crc16_kunit-c-add-KUnit-tests-for-crc16/20241004-050248
base:   9852d85ec9d492ebef56dc5f229416c925758edc
patch link:    https://lore.kernel.org/r/20241003-crc16-kunit-v2-1-5fe74b113e1e%40lkcamp.dev
patch subject: [PATCH v2] lib/crc16_kunit.c: add KUnit tests for crc16
config: parisc-randconfig-r071-20241005 (https://download.01.org/0day-ci/archive/20241005/202410050215.eU9509xy-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410050215.eU9509xy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410050215.eU9509xy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/crc16_kunit.c:29: warning: Excess struct member 'crc16' description in 'crc16_test'
   lib/crc16_kunit.c:96: warning: Function parameter or struct member 'test' not described in 'crc16_test_empty'
   lib/crc16_kunit.c:111: warning: Function parameter or struct member 'test' not described in 'crc16_test_correctness'
   lib/crc16_kunit.c:132: warning: Function parameter or struct member 'test' not described in 'crc16_test_combine'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +29 lib/crc16_kunit.c

    17	
    18	/**
    19	 * struct crc16_test - CRC16 test data
    20	 * @crc: initial input value to CRC16
    21	 * @start: Start index within the data buffer
    22	 * @length: Length of the data
    23	 * @crc16: Expected CRC16 value for the test
    24	 */
    25	static struct crc16_test {
    26		u16 crc;
    27		u16 start;
    28		u16 length;
  > 29	} tests[CRC16_KUNIT_TEST_SIZE];
    30	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

