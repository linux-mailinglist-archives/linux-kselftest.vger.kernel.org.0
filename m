Return-Path: <linux-kselftest+bounces-6231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2AA878A25
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 22:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9071C20FA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 21:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BE056B95;
	Mon, 11 Mar 2024 21:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZQ+07ad"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4F256B79;
	Mon, 11 Mar 2024 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193030; cv=none; b=bitSJvH7UpvXi4NrMfJivuCK8idJjUvSWdlUVkllUl2Z/hkq+UmGapBlt9XTrZ+sMeMagpLUqB6klhI48UygvBHf5OhXbFtHW4jFsAnqUgmv+i0soLS6u0A6XTQ0Ff21EqP5kh16gL7NdN6jNZfIHAad76QimkMXzhq6PVttS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193030; c=relaxed/simple;
	bh=7/t73ebbv8sRVNFVm6dXGVP8Cy5gtlrNTZRWv0cey24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku2XWjmqNMsWnfn0x9cOo1su+onrGaTSdFuFzB3yMK99vPz32K54hyqEKba6e3ynQojyp8NVZaW4UJuYNPnYBHotQn+mIGfWst8yQqOKm/d6pQyL5RNiwY1lp8wSVSOrv9Ww9xtNHvelMgS0CLDeg6afPgS93cjCeXIPG7OsQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZQ+07ad; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710193028; x=1741729028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7/t73ebbv8sRVNFVm6dXGVP8Cy5gtlrNTZRWv0cey24=;
  b=RZQ+07adTOQ/ErMs+wf882j5eW36hS/hrPXuldSfcMthmOPahDVjJ61Q
   A7fcDotHLdC7pGAVOFXw4AdvQMg1QB6BdsRZLI2EU/2KUVIsMU1YCIT0T
   pRY3z1r8J92zPxPqtWMBiUeC+n2t3pd5wWnOE/WEfE3i/1hVdNBiYR4Gf
   PyOpJ2snrRYjMGJffMzI0PVnUpBYpbqkGPKuzCqGA0q8qfqvS8BGvpYOb
   tvpf8fpZ44M+DQANbfmmy9L9PP8oFx06sw6vWjN72YgeqmiuxNZhSYvF8
   Jd/89R65rmS4SMcvIboIwmW1gAkvoB7bsi4lkFskwlXxuHkGsnpij5mEK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="8641371"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="8641371"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 14:37:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11375550"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 11 Mar 2024 14:37:01 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjnKM-0009Tt-0U;
	Mon, 11 Mar 2024 21:36:58 +0000
Date: Tue, 12 Mar 2024 05:36:48 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <dongmenglong.8@bytedance.com>, andrii@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, davem@davemloft.net, dsahern@kernel.org,
	dave.hansen@linux.intel.com, x86@kernel.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, quentin@isovalent.com,
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 6/9] bpf: tracing: add multi-link support
Message-ID: <202403120515.LMAOyTdG-lkp@intel.com>
References: <20240311093526.1010158-7-dongmenglong.8@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311093526.1010158-7-dongmenglong.8@bytedance.com>

Hi Menglong,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/bpf-tracing-add-support-to-record-and-check-the-accessed-args/20240311-173954
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240311093526.1010158-7-dongmenglong.8%40bytedance.com
patch subject: [PATCH bpf-next v2 6/9] bpf: tracing: add multi-link support
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240312/202403120515.LMAOyTdG-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240312/202403120515.LMAOyTdG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403120515.LMAOyTdG-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function 'bpf_tracing_multi_link_release':
>> kernel/bpf/syscall.c:3538:9: error: implicit declaration of function 'bpf_trampoline_multi_unlink_prog'; did you mean 'bpf_trampoline_unlink_prog'? [-Werror=implicit-function-declaration]
    3538 |         bpf_trampoline_multi_unlink_prog(&multi_link->link);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         bpf_trampoline_unlink_prog
   kernel/bpf/syscall.c: In function 'bpf_tracing_prog_attach_multi':
>> kernel/bpf/syscall.c:3815:15: error: implicit declaration of function 'bpf_trampoline_multi_link_prog'; did you mean 'bpf_trampoline_unlink_prog'? [-Werror=implicit-function-declaration]
    3815 |         err = bpf_trampoline_multi_link_prog(&link->link);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               bpf_trampoline_unlink_prog
   cc1: some warnings being treated as errors


vim +3538 kernel/bpf/syscall.c

  3532	
  3533	static void bpf_tracing_multi_link_release(struct bpf_link *link)
  3534	{
  3535		struct bpf_tracing_multi_link *multi_link =
  3536			container_of(link, struct bpf_tracing_multi_link, link.link);
  3537	
> 3538		bpf_trampoline_multi_unlink_prog(&multi_link->link);
  3539		__bpf_tracing_multi_link_release(multi_link);
  3540	}
  3541	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

