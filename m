Return-Path: <linux-kselftest+bounces-40779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE8EB43ADA
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 13:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADAD16FFBE
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92BE2FCC01;
	Thu,  4 Sep 2025 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCdtUYs5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F61E7C08;
	Thu,  4 Sep 2025 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987001; cv=none; b=ACm4+ye74dYdbBNegL5cBsezCgi/4zE3NIx09oi5cSowypQ2eXlFYNn6JYbSARi/irLAw/lGManEM+fsEK0wiPlSojRHxlc/H5d2su6+Qb2UyvGr4PYevwEEB9tMAUee4Q1c2jc4KvdPTxQs/bvAhkLU0IzMNJZcy9Kmv329ap0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987001; c=relaxed/simple;
	bh=w3sdhJKD22zCigLruzAyu/UYQLy1/QH44k6QEPcMNjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQYmXw9w0pLLcqJZu0GYEZ3y5ZEndVToYCk7FTpY1nkmJ4tZI2rGjeE/fXuQscrjUpKdxtCr0dtRssHQdfis9v899rndHNHFmsqXpujOUHCQPGRmosuU7NCtE1EKIZ7TNzJqsy/wX2l6bzMQbP7+Um5n+3xYDV0nA45LJIOugJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCdtUYs5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756987001; x=1788523001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w3sdhJKD22zCigLruzAyu/UYQLy1/QH44k6QEPcMNjs=;
  b=KCdtUYs53E0wPpW7dkina9E7D2Bf0xI8uET6vwHLsI6LSbAQxtyrbj8O
   fdTrctfudaUiIfY896rMns41J+nOGhAHkqcLAd5lhTvCeMRRYf6oZFb0z
   sTcOXm8AZqYZNTNlNwg42JiqE6W23JPjWbErMdOOCir6bfGoAPdE7l4FR
   nZb12nqConSvpCJLnI1aWgRrdTuXhfFZdhFcURKEwWkaqZgeWVWatjISC
   lxSnMEVFxBBidVD37PKad1uyllrPEWX6WonovxZQ6/HOrkCE7gy9M28U/
   TBBCaZ5FRn3LrhaB95a998NvCrqQ1e2FW+EtcNmxxwjYdq4F/1Bkhw6E5
   A==;
X-CSE-ConnectionGUID: ZMKoBeqhRtKHdj2n6nKw0g==
X-CSE-MsgGUID: /eptbQypRci5X5/KTxh23w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81911421"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81911421"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 04:56:40 -0700
X-CSE-ConnectionGUID: Oiiq1wuWS9q6tqe4SLAX7g==
X-CSE-MsgGUID: JREOD9RtQQmHv0fxQ2OtPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="171984324"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 04 Sep 2025 04:56:36 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uu8Z5-0005CZ-0x;
	Thu, 04 Sep 2025 11:55:56 +0000
Date: Thu, 4 Sep 2025 19:53:23 +0800
From: kernel test robot <lkp@intel.com>
To: Tom Hromatka <tom.hromatka@oracle.com>, kees@kernel.org,
	luto@amacapital.net, wad@chromium.org, sargun@sargun.me,
	corbet@lwn.net, shuah@kernel.org, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add SECCOMP_CLONE_FILTER operation
Message-ID: <202509041931.XtQcy27H-lkp@intel.com>
References: <20250903203805.1335307-1-tom.hromatka@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903203805.1335307-1-tom.hromatka@oracle.com>

Hi Tom,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/seccomp]
[also build test WARNING on linus/master v6.17-rc4 next-20250904]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tom-Hromatka/seccomp-Add-SECCOMP_CLONE_FILTER-operation/20250904-043943
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/seccomp
patch link:    https://lore.kernel.org/r/20250903203805.1335307-1-tom.hromatka%40oracle.com
patch subject: [PATCH] seccomp: Add SECCOMP_CLONE_FILTER operation
config: x86_64-randconfig-074-20250904 (https://download.01.org/0day-ci/archive/20250904/202509041931.XtQcy27H-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250904/202509041931.XtQcy27H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509041931.XtQcy27H-lkp@intel.com/

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   samples/seccomp/clone-filter.c: In function 'main':
>> samples/seccomp/clone-filter.c:142:9: warning: 'ret' may be used uninitialized [-Wmaybe-uninitialized]
     142 |         exit(ret);
         |         ^~~~~~~~~
   samples/seccomp/clone-filter.c:113:13: note: 'ret' was declared here
     113 |         int ret, status;
         |             ^~~


vim +/ret +142 samples/seccomp/clone-filter.c

   109	
   110	int main(void)
   111	{
   112		pid_t ref_pid = -1, child_pid = -1;
   113		int ret, status;
   114	
   115		ref_pid = fork();
   116		if (ref_pid < 0)
   117			exit(errno);
   118		else if (ref_pid == 0)
   119			do_ref_filter();
   120	
   121		child_pid = fork();
   122		if (child_pid < 0)
   123			goto out;
   124		else if (child_pid == 0)
   125			do_child_process(ref_pid);
   126	
   127		waitpid(child_pid, &status, 0);
   128		if (WEXITSTATUS(status) != 0) {
   129			perror("child process failed");
   130			ret = WEXITSTATUS(status);
   131			goto out;
   132		}
   133	
   134		ret = 0;
   135	
   136	out:
   137		if (ref_pid != -1)
   138			kill(ref_pid, SIGKILL);
   139		if (child_pid != -1)
   140			kill(child_pid, SIGKILL);
   141	
 > 142		exit(ret);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

