Return-Path: <linux-kselftest+bounces-41981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B56B8B3E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 22:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAD517E339
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 20:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CF22C178E;
	Fri, 19 Sep 2025 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEw63Uh+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6142765ED;
	Fri, 19 Sep 2025 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758315093; cv=none; b=VnY15FKO7aF3FerslSsPsdxeC5V9YqBlVSctnQVcfdjERMnMzl2AF6o6RNalXSMfSv17WethkVEjrFPcdrUUWd6vyE/1Ev7KQ+e5EPM83gpYuRP1tG32S0rws3EYxZVvO34W6IjmSIOoylhzz0xwoTbg9jdOCpD+JoV/zeX9Vws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758315093; c=relaxed/simple;
	bh=WT/AtW2xlYNnS+78n8UELvwDofVsJ6EkkO2i5EOJ8R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5zkSSxjMUcRnu3CDgAFuWTZ7lkQoI5QscEHpgPm1wwAmS9sEvpEB7o4f9+c+Z3Jl6dKZi4LyWUJFEXX7gM3nZMRvcXZHAvVQu59aT02Y0fC95eSD/797tvyMfu25A7Wf/itF1odwGA0zq6wcansIyBUpuMtBV+B7thyZ0ESEn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEw63Uh+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758315090; x=1789851090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WT/AtW2xlYNnS+78n8UELvwDofVsJ6EkkO2i5EOJ8R8=;
  b=AEw63Uh+gdvP8TBnHl1KmtGek+0aYVhxjw+pxhqAY03igZaKu0VQdI08
   ZZzvzxWyfQb9H3ewefaKarkH0YmUB1jjrqQLjd3hDJGsnGkPQifphP+M/
   N2vJunhgNfOs78LId1GkRhx4qWmm8PuMa/yiOcl+t+82gvMa0WMpUsR6/
   3RmZMvqiXJ7rCdCnFQ8C//Mg7ijtbiNyoXtjnR5iekDikPL+8xtndMxqZ
   ZosUeaNTO+cH1Y9ZJY8ojAaM0j4sHbVLeYihGvcvapYYtEdaqQP70rZFa
   eRyEu4Dz1y5HvjWdIsFjQytvW/8mjubBGqkI9RYRgYgho2ehwFo66s6GK
   g==;
X-CSE-ConnectionGUID: EpoJiZEDQxyLoxLtcTxrfw==
X-CSE-MsgGUID: 9Nmgt+lgRQ2z8qBwhqGBqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64469596"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64469596"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 13:51:29 -0700
X-CSE-ConnectionGUID: XwD47sDGR+igIFw7EOnX+A==
X-CSE-MsgGUID: mlNyeTdkTUyEuCqKl1bt8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="175847193"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 19 Sep 2025 13:51:27 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzi4i-0004nP-3C;
	Fri, 19 Sep 2025 20:51:24 +0000
Date: Sat, 20 Sep 2025 04:50:26 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 11/11] um: switch ptrace FP register access to nolibc
Message-ID: <202509200433.l6pWDPhh-lkp@intel.com>
References: <20250919153420.727385-12-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919153420.727385-12-benjamin@sipsolutions.net>

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on uml/next]
[also build test ERROR on uml/fixes shuah-kselftest/next shuah-kselftest/fixes linus/master v6.17-rc6 next-20250919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Berg/tools-compiler-h-fix-__used-definition/20250919-233959
base:   https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux next
patch link:    https://lore.kernel.org/r/20250919153420.727385-12-benjamin%40sipsolutions.net
patch subject: [PATCH v2 11/11] um: switch ptrace FP register access to nolibc
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20250920/202509200433.l6pWDPhh-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7c861bcedf61607b6c087380ac711eb7ff918ca6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509200433.l6pWDPhh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509200433.l6pWDPhh-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> arch/x86/um/os-Linux/registers.c:11:10: fatal error: 'sys/user.h' file not found
      11 | #include <sys/user.h>
         |          ^~~~~~~~~~~~
   1 error generated.
--
>> clang: warning: no such include directory: './arch/um/include/shared' [-Wmissing-include-dirs]


vim +11 arch/x86/um/os-Linux/registers.c

14c8a77e1bbd69 arch/um/os-Linux/sys-i386/registers.c Jeff Dike          2008-06-12 @11  #include <sys/user.h>
38b64aed786d59 arch/x86/um/os-Linux/registers.c      Richard Weinberger 2011-08-18  12  #endif
37185b33240870 arch/x86/um/os-Linux/registers.c      Al Viro            2012-10-08  13  #include <longjmp.h>
37185b33240870 arch/x86/um/os-Linux/registers.c      Al Viro            2012-10-08  14  #include <sysdep/ptrace_user.h>
a78ff1112263fd arch/x86/um/os-Linux/registers.c      Eli Cooper         2016-03-20  15  #include <sys/uio.h>
a78ff1112263fd arch/x86/um/os-Linux/registers.c      Eli Cooper         2016-03-20  16  #include <asm/sigcontext.h>
a78ff1112263fd arch/x86/um/os-Linux/registers.c      Eli Cooper         2016-03-20  17  #include <linux/elf.h>
dbba7f704aa0c3 arch/x86/um/os-Linux/registers.c      Al Viro            2021-09-20  18  #include <registers.h>
3f17fed2149192 arch/x86/um/os-Linux/registers.c      Benjamin Berg      2024-10-23  19  #include <sys/mman.h>
^1da177e4c3f41 arch/um/os-Linux/sys-i386/registers.c Linus Torvalds     2005-04-16  20  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

