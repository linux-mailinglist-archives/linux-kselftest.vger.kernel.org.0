Return-Path: <linux-kselftest+bounces-22495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AC89D7B61
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 06:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1131C1627FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 05:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B6912EBEA;
	Mon, 25 Nov 2024 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWOa61CU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA71F376;
	Mon, 25 Nov 2024 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732514294; cv=none; b=gtcjVm8UtSEVV6C4npXe+W12OxlKjRHr+qCVUMhPu+4IwqIQ365uXK8icsf++BIlcoGRqinCxVa/lVVEmaX1U9l2o0U2do89R95dckxU/Eewfw6gSCo06jeBU4mTXzczRgo+jwMxs1sNyYZJaNULapKoIKUAUqwUD95Mkr95exQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732514294; c=relaxed/simple;
	bh=Fuk7F5EN1TIxoq7wyjhMmvw7/e0hDH5BfzC2Yk/onvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCbbW6deiNlWaK4ZKzDMFBZmxLXtzjJWwXNE8qH40kGQf0Q7fyqjQC7oaHOBhPCh4Jjxgsl5hdwjqfyKFvU/otIPqcNlqX8TTSwQ7dix08R/DEKE4As6kukYYA2F3mQD2zdMTxd3x2bdRtN9sutnMbSDBvz+RZUOAKVRfb+n/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWOa61CU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732514293; x=1764050293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fuk7F5EN1TIxoq7wyjhMmvw7/e0hDH5BfzC2Yk/onvA=;
  b=RWOa61CUxz17sCpgdEaLYSl+bZPjpEAcBY854OwOqeJ6lwd7NLQ53Dxk
   v3oo7QIl2f7M6yHIUn7oZ0t4Zgve6s0z3Jf80IzkD46X20+6l0qp7/4aw
   5rzusEIVjkz+kXR3EPDu2uhL5CF8a0pOYoRIPe43+NDBAr5oixFUeYByN
   CtIRKZ59+i60SMS05Ti8Xcil58zNDbpEF2aCfuL7ncX6bS8MOqp+TRulp
   EGTdPXXUOXRPxUrFQWvF22qV+0YyfiRqYxjdz2l3X+NzhWlECut+T2/Km
   9Whr642DlcpPgQRI+v8HRM9Wuxx9/NAQQzi5NCLoMq7cYqrf5lnGT+Bd+
   A==;
X-CSE-ConnectionGUID: 6c2PsIc5Tk6ycaVzI4QfBg==
X-CSE-MsgGUID: QpyqrbCjTse68DQJHDSnUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="32543697"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="32543697"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2024 21:58:12 -0800
X-CSE-ConnectionGUID: FdzviD5tSn6kysloyZ4QsA==
X-CSE-MsgGUID: /svRNchCSzmU+nyrbUUfJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91286439"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 24 Nov 2024 21:58:10 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFS6p-0005vx-2c;
	Mon, 25 Nov 2024 05:58:07 +0000
Date: Mon, 25 Nov 2024 13:57:12 +0800
From: kernel test robot <lkp@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, shuah@kernel.org,
	linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH for-next v3] selftests/mm: Add a few missing gitignore
 files
Message-ID: <202411251308.Vjm5MzVC-lkp@intel.com>
References: <20241122074612.1582161-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122074612.1582161-1-lizhijian@fujitsu.com>

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.12]
[cannot apply to akpm-mm/mm-everything linus/master next-20241122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Zhijian/selftests-mm-Add-a-few-missing-gitignore-files/20241125-095645
base:   v6.12
patch link:    https://lore.kernel.org/r/20241122074612.1582161-1-lizhijian%40fujitsu.com
patch subject: [PATCH for-next v3] selftests/mm: Add a few missing gitignore files
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20241125/202411251308.Vjm5MzVC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241125/202411251308.Vjm5MzVC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411251308.Vjm5MzVC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files
>> tools/testing/selftests/mm/pkey_sighandler_tests.c: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

