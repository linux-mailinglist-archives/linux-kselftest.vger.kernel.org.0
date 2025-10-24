Return-Path: <linux-kselftest+bounces-44006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF896C07445
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC5E6583959
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D79627E1D7;
	Fri, 24 Oct 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9e/39w/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B651DC997;
	Fri, 24 Oct 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322671; cv=none; b=tRIihwugBAxzB4La0XuLI0CD+NKWzOetd5FZOJLtuFVd/Vr02FzQPKxexf+bN8U7M4dXrF8ENFthMrcLyauVMbrg8PbCR8/Y+16YPVOl4MX/pLugMsfcr3saIkc81BJLiRhlyfYBIsam71kAyu9ICuUEtg0ju3ujKqlawGCO1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322671; c=relaxed/simple;
	bh=wk66qIygkkbUUS4Vseh1sg6teJA5/ZT5GoMUU6R4qwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNEi7vl7pHPbato9mJlZPWzY+G6M7Ep4qT0BEamPD/cwjSrjH7zg/HDV7kHsZmZ0XNw+b3OMwoZTn5UG+OoJV1y4NNWRnBOQuD630+DopEmlmmmmxHy4j4VSxzcp1vk4OFJI0s+CI4lULWvfKYbPLQKgev9X1SywSSqv9ZBIFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9e/39w/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761322670; x=1792858670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wk66qIygkkbUUS4Vseh1sg6teJA5/ZT5GoMUU6R4qwg=;
  b=S9e/39w/1ASlPnXtSKu/WcGkTQZcG5b21wnI9KDxAr/3R2iXvU1aVd2L
   Q8t1TtWA5AV2UhRhbXIsrxBMng/Uz4R32JZ6iqoVZckv2ekH6aqDGsPpq
   /iYJpolBT7sMxTTj6Srm8CtiD0bggx81NYropnM6ZcyHDQh9hdjWwFb0B
   o6zI1Xnvo4/Kj8MOBOmQN5+r4fF8WKf7KEst3uUUysXkZuFAHfyWR284e
   N5lOfbKaDllFeoq1vbpDPrkbzRAWN9t8cxdj0U/D+OjDhb84AQ831VPU0
   viZENhOAxuSKgKpMoDC304uI/YaVN+b7hWnzU4bamqB3tTfs0BXkqwVHC
   w==;
X-CSE-ConnectionGUID: RLw1A/tISsSQHsHa9f9qSw==
X-CSE-MsgGUID: kCdlq5ZrQjGMYyg4+eAh9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63412299"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="63412299"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 09:17:47 -0700
X-CSE-ConnectionGUID: rox9pthtT9qkicVmkF+xRw==
X-CSE-MsgGUID: OqN+FRlvSO2q/H4Vl8klIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="183643221"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 24 Oct 2025 09:17:38 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCKS1-000Een-0H;
	Fri, 24 Oct 2025 16:17:01 +0000
Date: Sat, 25 Oct 2025 00:14:45 +0800
From: kernel test robot <lkp@intel.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Add kfuncs for detecting execution
 context
Message-ID: <202510242353.hCaLzqVt-lkp@intel.com>
References: <20251022113412.352307-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022113412.352307-2-jiayuan.chen@linux.dev>

Hi Jiayuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiayuan-Chen/bpf-Add-kfuncs-for-detecting-execution-context/20251022-193551
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251022113412.352307-2-jiayuan.chen%40linux.dev
patch subject: [PATCH bpf-next v1 1/2] bpf: Add kfuncs for detecting execution context
config: alpha-randconfig-r123-20251023 (https://download.01.org/0day-ci/archive/20251024/202510242353.hCaLzqVt-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251024/202510242353.hCaLzqVt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510242353.hCaLzqVt-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/bpf/helpers.c:1199:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long ( *[usertype] callback_fn )( ... ) @@     got void [noderef] __rcu * @@
   kernel/bpf/helpers.c:1199:21: sparse:     expected unsigned long long ( *[usertype] callback_fn )( ... )
   kernel/bpf/helpers.c:1199:21: sparse:     got void [noderef] __rcu *
   kernel/bpf/helpers.c:2480:18: sparse: sparse: symbol 'bpf_task_release_dtor' was not declared. Should it be static?
   kernel/bpf/helpers.c:2510:18: sparse: sparse: symbol 'bpf_cgroup_release_dtor' was not declared. Should it be static?
>> kernel/bpf/helpers.c:4260:18: sparse: sparse: symbol 'bpf_in_nmi_context' was not declared. Should it be static?
   kernel/bpf/helpers.c:2976:18: sparse: sparse: context imbalance in 'bpf_rcu_read_lock' - wrong count at exit
   kernel/bpf/helpers.c:2981:18: sparse: sparse: context imbalance in 'bpf_rcu_read_unlock' - unexpected unlock

vim +/bpf_in_nmi_context +4260 kernel/bpf/helpers.c

  4254	
  4255	/**
  4256	 * bpf_in_nmi_context - Check whether we are serving NMI
  4257	 *
  4258	 * Return: true if we are serving NMI
  4259	 */
> 4260	__bpf_kfunc bool bpf_in_nmi_context(void)
  4261	{
  4262		return in_nmi();
  4263	}
  4264	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

