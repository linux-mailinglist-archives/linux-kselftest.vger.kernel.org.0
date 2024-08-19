Return-Path: <linux-kselftest+bounces-15633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F42956837
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 12:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C28280E23
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 10:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6979215FD04;
	Mon, 19 Aug 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHfO9Qu3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F3015B14C
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062903; cv=none; b=pByfrP4jGAtaNat2ImjYTzfGyUMu474Gvx7LcEzFpKvTI3x6PYgNWGOlG+9fJzBK0X6a4Am7qd/iggrBZaO8ENPlU+iNSdlfqbGgGLfs012cJcsMYhebOKHolNjF2TXDAZHmC6WwEEc++mY/WVQn96+w3RcT1bXU25SZ7WRTLeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062903; c=relaxed/simple;
	bh=lMB3ZG3s5QhQax0iPZTRA/YO04UStL4JIwcWP2MwrEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQ2RZ/jFD/VIeoSOR94ly99iMIq4D9JpvzE6oBbNwYG/aDW5N3+Hr99DIuzOiTxRZefwc5kFi7zwWt7bFh9UkKM2JYHF2haHmFNrqybMBRWXBgzuwC+SS+oBW9bczCDFouDPgQ/P6+OoIc4Shy0jWIPJTduzOq+LLjyibFGphKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHfO9Qu3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724062902; x=1755598902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lMB3ZG3s5QhQax0iPZTRA/YO04UStL4JIwcWP2MwrEo=;
  b=bHfO9Qu3VcsIZk/dHClbZUPvnxB7WOK32ynpuL1pgm4WuFih0o21JRma
   0y6gf7kDUcAnLAc+3eehMSAzVQGq66x6pYI5teLhevrR8lce8ZBQ5sNfT
   UtcIV7L4yMLgYlnTFgPV2wx+C0Q3U8+hi0Mn/yRXhdJ5/WdOwugHjb40G
   7akWx3+CAx6BYBLOcti0mIGIOoqgv/b9k4M3OZdXoj0IsKTOtNmfHyzJE
   xCz4InRDV0j3nliQX/zpzc8ZDaML0ak74WaMnRwKXZcRzREG1yK3Yu3ki
   GENGI0SMM/ie85gtg6Rpslo19muABO37I5DC5OPSt34ZeG4gEPz7sjJXc
   g==;
X-CSE-ConnectionGUID: mXsEdgH0RA6s6G0Xuj2JTQ==
X-CSE-MsgGUID: Bq1+yV4rThyS0KQs48KSeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="32921443"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="32921443"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 03:21:40 -0700
X-CSE-ConnectionGUID: oYdsRvbgQo+PZKBviBso5Q==
X-CSE-MsgGUID: +laIDPhiQzGP+M4t0nmrxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="61101153"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 19 Aug 2024 03:21:37 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfzW3-0008t2-1B;
	Mon, 19 Aug 2024 10:21:35 +0000
Date: Mon, 19 Aug 2024 18:21:27 +0800
From: kernel test robot <lkp@intel.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] lib/math: Add int_pow test suite
Message-ID: <202408191754.tO9UUD0n-lkp@intel.com>
References: <20240819014115.221135-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819014115.221135-1-luis.hernandez093@gmail.com>

Hi Luis,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.11-rc4]
[also build test WARNING on linus/master next-20240819]
[cannot apply to akpm-mm/mm-nonmm-unstable]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luis-Felipe-Hernandez/lib-math-Add-int_pow-test-suite/20240819-094252
base:   v6.11-rc4
patch link:    https://lore.kernel.org/r/20240819014115.221135-1-luis.hernandez093%40gmail.com
patch subject: [PATCH v2] lib/math: Add int_pow test suite
config: i386-buildonly-randconfig-004-20240819 (https://download.01.org/0day-ci/archive/20240819/202408191754.tO9UUD0n-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240819/202408191754.tO9UUD0n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408191754.tO9UUD0n-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/math/tests/int_pow_kunit.c:22:11: warning: integer literal is too large to be represented in a signed integer type, interpreting as unsigned [-Wimplicitly-unsigned-literal]
      22 |         { 2, 63, 9223372036854775808, "Large result"},
         |                  ^
   1 warning generated.


vim +22 lib/math/tests/int_pow_kunit.c

    12	
    13	static const struct test_case_params params[] = {
    14		{ 64, 0, 1, "Power of zero" },
    15		{ 64, 1, 64, "Power of one"},
    16		{ 0, 5, 0, "Base zero" },
    17		{ 1, 64, 1, "Base one" },
    18		{ 2, 2, 4, "Two squared"},
    19		{ 2, 3, 8, "Two cubed"},
    20		{ 5, 5, 3125, "Five raised to the fith power" },
    21		{ U64_MAX, 1, U64_MAX, "Max base" },
  > 22		{ 2, 63, 9223372036854775808, "Large result"},
    23	};
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

