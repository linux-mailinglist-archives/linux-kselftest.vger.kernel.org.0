Return-Path: <linux-kselftest+bounces-20719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C13349B1361
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602D62838B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6799E20D50A;
	Fri, 25 Oct 2024 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghqLW+EV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638621FCC66
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 23:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729899762; cv=none; b=jnsH7radV9jBBu1J3YA79WiTEo0J25RbVMz1AQyPxrmGQKSNYLQEWRbziSEEFWnlPlHHXHyJPsU1P+ytXAFwVzHRfNMyJVzaQyG7Z7lJVaKGs7JFH4NJyU+DdBkzRkVI2PSAwAnAj7tzOpRm0EPr8J1V02u7pvVye00PID7qjds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729899762; c=relaxed/simple;
	bh=9AUHJ52vhcnHhpIsDcydmIMZD0WvaKeVjZTBF2tdN1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jo2A9mISBBCm3LgkL8DHG1MxKALjqQeyDxG72uXy0bExc0DmbfjvRQL/wI1RJHPujw7n0jw8MJ7QAjwbjeIsocLtRthmkb79gdJfHVtB++6hNjUloAv5a2h06UeHOA8JG7FixpUPrek6NCr75zb1Cpls9nmglfJrWl9Ly1PqaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghqLW+EV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729899761; x=1761435761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9AUHJ52vhcnHhpIsDcydmIMZD0WvaKeVjZTBF2tdN1w=;
  b=ghqLW+EVezZ1eHfk+z7fnD7z5IaI9LmUDQr/oxnKMyQzMbf7qB9PqErj
   fKC9oQq3L7eI+4NP5WwT5Fd3kWLpDbhAP95qz1lRSKhLxaMx5rRxBtWgy
   0oqqGSBxJKfb9aNWmYx6l3X+8fn0HSxQX7vvxYAFBAfuAPwtcSn5b0fyr
   Ks09bsP4WGjVJWUNqAKjMNn7dda5iEihSkbRlwkBS06ywvCEQ2bNkmTvv
   2b/wC/65j7+Z3oU74kBsId5S1nVoseD3eu4oGAJLnVog+ta8kimBXCvZF
   Elim5Crt56L3BY1FuCgIqvmpkYi5GFFvzYhkstlu35yb0MoRq7ZxbbyXK
   A==;
X-CSE-ConnectionGUID: j4GaCjW5Qae+yhCLFRDCwQ==
X-CSE-MsgGUID: LjxqEa50ShanH7tV5iDWdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40199497"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40199497"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 16:42:40 -0700
X-CSE-ConnectionGUID: +TbfiPdVR+uv+a8H55sVeg==
X-CSE-MsgGUID: GjZIWSRLSlOzrUCDDGJ/xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="80992565"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 25 Oct 2024 16:42:38 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4Tww-000Z2j-2p;
	Fri, 25 Oct 2024 23:42:34 +0000
Date: Sat, 26 Oct 2024 07:41:51 +0800
From: kernel test robot <lkp@intel.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	brendan.higgins@linux.dev, davidgow@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org, ricardo@marliere.net,
	linux-kernel-mentees@lists.linuxfoundation.org,
	andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v2] lib/math: Add int_sqrt test suite
Message-ID: <202410260709.2XVfASBv-lkp@intel.com>
References: <20241024195511.72674-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024195511.72674-1-luis.hernandez093@gmail.com>

Hi Luis,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.12-rc4]
[also build test ERROR on linus/master]
[cannot apply to akpm-mm/mm-nonmm-unstable next-20241025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luis-Felipe-Hernandez/lib-math-Add-int_sqrt-test-suite/20241025-035643
base:   v6.12-rc4
patch link:    https://lore.kernel.org/r/20241024195511.72674-1-luis.hernandez093%40gmail.com
patch subject: [PATCH v2] lib/math: Add int_sqrt test suite
config: i386-buildonly-randconfig-001-20241026 (https://download.01.org/0day-ci/archive/20241026/202410260709.2XVfASBv-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410260709.2XVfASBv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410260709.2XVfASBv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/math/tests/int_sqrt_kunit.c:7:10: fatal error: 'limits.h' file not found
       7 | #include <limits.h>
         |          ^~~~~~~~~~
   1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +7 lib/math/tests/int_sqrt_kunit.c

     2	
     3	#include <kunit/test.h>
     4	#include <linux/math.h>
     5	#include <linux/module.h>
     6	#include <linux/string.h>
   > 7	#include <limits.h>
     8	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

