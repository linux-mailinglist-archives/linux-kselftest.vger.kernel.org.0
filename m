Return-Path: <linux-kselftest+bounces-36645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CC8AFA2CF
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jul 2025 05:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312CF301632
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jul 2025 03:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8CE1547C0;
	Sun,  6 Jul 2025 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzyzjJ7J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B152E36F6;
	Sun,  6 Jul 2025 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751771169; cv=none; b=TTP75uwUgk3HusFN71FC3I+i7V3Q11bxBOPfroTeYh9rCxZY7D+jpntfZnkJN6K03GYOPCYP/b37NxCX5r5SBhNsxXCVxVDpTJ0mCUiyJCqTEPz8iF5g0eMdPpNYAQ6kcF3EsCWbTZsAZo/axwXEaiSK8v7edezIfP12AhfWGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751771169; c=relaxed/simple;
	bh=iBI/Y7Y2TK1z9mUYXrJyGM8Cqi42Qt7xaOHNi8F1ZeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0ArFPUvfVjTkdHtWZX+7bnrsSGsQw0E/Yjpt9/plcyKW/G5ip2Vw+I3F6ObdTdH/BDyhrt8OXCxCvE8+nB8kGrHih3z6jU+wYk3y/OgII8GTs65U77Ea+5glzJ7PUiUR0AfXwAdAcMc00H86+SBNRGwvVf6Yto+SJ3vtxlF1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzyzjJ7J; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751771167; x=1783307167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iBI/Y7Y2TK1z9mUYXrJyGM8Cqi42Qt7xaOHNi8F1ZeA=;
  b=UzyzjJ7JmcL0hYFqDl2pMrArFD88Z1CHl4RuAm+VylVptt+zcvvMi2p1
   noJ3Je8ZfK4NcbHjIHFzh2oEU0FFdNF4iXLu3BLMeZgP6ulCJ48ANTGls
   XW07tKZ8eDGSXUD4AvZVO7LmlkcVYM7xsJAOEYP91VYe3fcepHyB8ZN/b
   uhcP8JJM8IGp/Q/If2wb9Jg/OT6CObyPGVOQzBKjAiy3dW48tYGH1L8y/
   XOhaYEoR0HNHxorQ8daZP/0ZvAa2EjPG/cBUY5BJvkOBIWEs2+yagYf/5
   GW3HqWix/sNqAtslTRpaAUze5JmESIu3tkKLV+Mip8lQbHT1V0UkqPcGg
   g==;
X-CSE-ConnectionGUID: afgb+/gvQRKcoHFHLg2+Lg==
X-CSE-MsgGUID: pFq8ln9hTw2VWwSs/Vt/ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11485"; a="65483599"
X-IronPort-AV: E=Sophos;i="6.16,291,1744095600"; 
   d="scan'208";a="65483599"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2025 20:06:07 -0700
X-CSE-ConnectionGUID: 9RzBk+4xRzCsdIO7hkpsCA==
X-CSE-MsgGUID: hY9zMaW5SZabpDCpV+rQWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,291,1744095600"; 
   d="scan'208";a="178587492"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 05 Jul 2025 20:06:03 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uYFhY-0004qd-2e;
	Sun, 06 Jul 2025 03:06:00 +0000
Date: Sun, 6 Jul 2025 11:05:26 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH 01/15] selftests: kselftest: Create ksft_print_dbg_msg()
Message-ID: <202507061039.0ZKQCW5y-lkp@intel.com>
References: <20250704-tonyk-robust_test_cleanup-v1-1-c0ff4f24c4e1@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250704-tonyk-robust_test_cleanup-v1-1-c0ff4f24c4e1@igalia.com>

Hi André,

kernel test robot noticed the following build errors:

[auto build test ERROR on a24cc6ce1933eade12aa2b9859de0fcd2dac2c06]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/selftests-kselftest-Create-ksft_print_dbg_msg/20250704-231034
base:   a24cc6ce1933eade12aa2b9859de0fcd2dac2c06
patch link:    https://lore.kernel.org/r/20250704-tonyk-robust_test_cleanup-v1-1-c0ff4f24c4e1%40igalia.com
patch subject: [PATCH 01/15] selftests: kselftest: Create ksft_print_dbg_msg()
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250706/202507061039.0ZKQCW5y-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250706/202507061039.0ZKQCW5y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507061039.0ZKQCW5y-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from samples/vfs/test-list-all-mounts.c:11:
   In file included from samples/vfs/../../tools/testing/selftests/pidfd/pidfd.h:19:
>> samples/vfs/../../tools/testing/selftests/pidfd/../kselftest.h:107:8: error: unknown type name 'bool'
     107 | static bool ksft_debug_enabled;
         |        ^
   1 error generated.


vim +/bool +107 samples/vfs/../../tools/testing/selftests/pidfd/../kselftest.h

   104	
   105	static struct ksft_count ksft_cnt;
   106	static unsigned int ksft_plan;
 > 107	static bool ksft_debug_enabled;
   108	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

