Return-Path: <linux-kselftest+bounces-20053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7269A2E6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 22:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F58C1C21A94
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6641DFD9B;
	Thu, 17 Oct 2024 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQMUgsim"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854411D07B0;
	Thu, 17 Oct 2024 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196573; cv=none; b=mAw4SHo1CvOdbn/IpLOzE8kIL6+GICjrUQJYsAM47IZGuvFaP2jEQ6NnNA7nksJ/g0ljlvZIdjTEqNz8HKKdPkUM7x1xRfc7Jog68I5XCW1xzuzFeiydcTcpd4fd34QJYL0RzZm0QnyTpPEUznkrtzOLg6P75qYnkOM81WroRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196573; c=relaxed/simple;
	bh=aiLEByOVnwOznKJHOUWBXqp2FuKLx82PDD5OULTXF+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfQcKenyvdiV4yDccn40jTtg6Mi1HOqnQGegXqQDSDnjrNmCKfYaAmwWonvuEYsBd7bEzOP3d4D+DMw41cSXNYsmd1Qjs3g1tDjVQhNFWEJA/Ty/BTkS9jj6uNlU3GAzibOSlhARMZfa84greeVtvB2npKzc4a30zeGBlvMXP9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQMUgsim; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729196569; x=1760732569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aiLEByOVnwOznKJHOUWBXqp2FuKLx82PDD5OULTXF+U=;
  b=GQMUgsimNtpg5kYwy1DW7fZVhdlflETSTQDoL2KtZy5Akt0xN/L7HStG
   XWFcncj5zWyfIHANzuMiZMo64KhfU6+7uMezV9XnG/SPlCGMTG/4zALBr
   86zBeIBwkpXGXfViuqSRRf8KhaslnpbWyQERG290MKuMkkFnlh6/dyl3p
   unyhO05MRvpCTXsUQw42S55jEQp8eru/v66V+MPuYwlwKfJDN6yFFxTgS
   BH+irHJJKXSlzNcEkeLP0SyYC0JLy2aSFdVmixrKnvHdqbXQaei4g2AZZ
   94X0EojMZvYQFssUNz2sxNqVn7tlwS6M7qyIzc+TEWf0EVvbTTuduMqGr
   w==;
X-CSE-ConnectionGUID: EUnMDDm2RLOrROj+8u4tGw==
X-CSE-MsgGUID: NA65gI0CS3qxAlbv8evroA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28497493"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28497493"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 13:22:49 -0700
X-CSE-ConnectionGUID: UqZb50TSRDiZHsUrZPYrnQ==
X-CSE-MsgGUID: +kkSlPidR6SXJSmZY8eUbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="78804674"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Oct 2024 13:22:47 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1X1A-000MtK-0o;
	Thu, 17 Oct 2024 20:22:44 +0000
Date: Fri, 18 Oct 2024 04:22:17 +0800
From: kernel test robot <lkp@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 1/3] selftests: Add a few missing gitignore files
Message-ID: <202410180306.uMloezUi-lkp@intel.com>
References: <20241015010817.453539-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015010817.453539-1-lizhijian@fujitsu.com>

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes rafael-pm/linux-next rafael-pm/bleeding-edge tiwai-sound/for-next tiwai-sound/for-linus netfilter-nf/main linus/master v6.12-rc3]
[cannot apply to akpm-mm/mm-everything nf-next/master next-20241017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Zhijian/selftests-net-Fix-ns-XXXXXX-not-cleanup/20241015-091039
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20241015010817.453539-1-lizhijian%40fujitsu.com
patch subject: [PATCH 1/3] selftests: Add a few missing gitignore files
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241018/202410180306.uMloezUi-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241018/202410180306.uMloezUi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410180306.uMloezUi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files
>> tools/testing/selftests/mm/pkey_sighandler_tests.c: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

