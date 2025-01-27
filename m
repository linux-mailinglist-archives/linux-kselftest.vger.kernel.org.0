Return-Path: <linux-kselftest+bounces-25227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DC1A1D5E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 13:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F9E7A1F69
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 12:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1718D1FF1B6;
	Mon, 27 Jan 2025 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHfGpRTF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F41FECC7;
	Mon, 27 Jan 2025 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737980886; cv=none; b=R8ZAxb/1NvVvMxG0FOH06MTaj0zbTGprVKYHdoP9M6sKtkH2S8XdmteJrHHuZrKAFFg9CLZbD+aoeVka+iEt1oaeDnuSzuybynqaTp7smot3BeF/a32s0nG0Ai/Wq40jCoxwirUlZWYFek/OexDhfDxHATIbKQbLjwRPBDCpaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737980886; c=relaxed/simple;
	bh=bg9amlmFdK/h2r1MnHxwVsOFVnMATC4b5ax0Y6Sl1Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf/HRJRm/mM52raHLzup54D4FHJhaul+w1wq1+aW/Z0QbusufkjgyF6BlRgYPT6aSwhL2HXAaqoaK4EHBuXsBjQcatlP3BTmR18zmX1mgg9lQbHdPBA4OhnDvZY1zfe8N4adD8Kvc2TX1ewjYESD+4W3UwTXFR5dPO2vEME+Tj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHfGpRTF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737980884; x=1769516884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bg9amlmFdK/h2r1MnHxwVsOFVnMATC4b5ax0Y6Sl1Us=;
  b=JHfGpRTFmfxy9nepMa2pNhD5whreQbRfxuaz5D+qkyQh+id2fQUkqJl7
   2kjhzJokl/Fey4cMeUIWVvcJZel3EKRb6GSX3RwQwdygqLH3p6L9QtOOE
   N15hN6bYhnARrJM0H1IepEmZtMFkfEZIq5Oy7o2JOLKjJse0JOYy2o7Il
   yCLoXGDXnxABnD6Bj8TSixWajJUfH15KzFz/SlKY965EPtYbwo0eSmCgY
   3V7JY8ioMct6IB6ZI3tWr6SUBr6zLlUwFc5y8vo9vfVZNfnmaimQsKJJ2
   lD1Y+EJi5VPKAD4SFgKdoG8qMfSCHhLe/iUWgp1c4m+0y88T9IunbDbfG
   g==;
X-CSE-ConnectionGUID: xIQnwC+ORZu97nYLkMzWeA==
X-CSE-MsgGUID: tcqpbMvCRSy9Ut1ujYsrqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="49032860"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="49032860"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 04:28:03 -0800
X-CSE-ConnectionGUID: /nXOYI4iSHqijSeaDJ5RCQ==
X-CSE-MsgGUID: k6fZ0skxT2KoCiodPqeCXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="108218730"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 27 Jan 2025 04:27:58 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tcODc-000gkp-0T;
	Mon, 27 Jan 2025 12:27:56 +0000
Date: Mon, 27 Jan 2025 20:27:43 +0800
From: kernel test robot <lkp@intel.com>
To: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Levi Zim <rsworktech@outlook.com>
Subject: Re: [PATCH bpf-next v2 2/7] bpf: Implement
 bpf_probe_read_user_dynptr helper
Message-ID: <202501272059.wikSvChi-lkp@intel.com>
References: <20250125-bpf_dynptr_probe-v2-2-c42c87f97afe@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250125-bpf_dynptr_probe-v2-2-c42c87f97afe@outlook.com>

Hi Levi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d0d106a2bd21499901299160744e5fe9f4c83ddb]

url:    https://github.com/intel-lab-lkp/linux/commits/Levi-Zim-via-B4-Relay/bpf-Implement-bpf_probe_read_kernel_dynptr-helper/20250125-163114
base:   d0d106a2bd21499901299160744e5fe9f4c83ddb
patch link:    https://lore.kernel.org/r/20250125-bpf_dynptr_probe-v2-2-c42c87f97afe%40outlook.com
patch subject: [PATCH bpf-next v2 2/7] bpf: Implement bpf_probe_read_user_dynptr helper
config: x86_64-randconfig-122-20250127 (https://download.01.org/0day-ci/archive/20250127/202501272059.wikSvChi-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250127/202501272059.wikSvChi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501272059.wikSvChi-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/bpf_trace.c:899:41: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[addressable] [assigned] [usertype] sival_ptr @@     got void * @@
   kernel/trace/bpf_trace.c:899:41: sparse:     expected void [noderef] __user *[addressable] [assigned] [usertype] sival_ptr
   kernel/trace/bpf_trace.c:899:41: sparse:     got void *
>> kernel/trace/bpf_trace.c:235:39: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void const [noderef] __user *unsafe_ptr @@     got void *unsafe_ptr @@
   kernel/trace/bpf_trace.c:235:39: sparse:     expected void const [noderef] __user *unsafe_ptr
   kernel/trace/bpf_trace.c:235:39: sparse:     got void *unsafe_ptr
   kernel/trace/bpf_trace.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   kernel/trace/bpf_trace.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:880:25: sparse: sparse: context imbalance in 'uprobe_prog_run' - unexpected unlock

vim +235 kernel/trace/bpf_trace.c

   228	
   229	BPF_CALL_5(bpf_probe_read_user_dynptr, const struct bpf_dynptr_kern *, dst,
   230		u32, offset, u32, size, void *, unsafe_ptr, u64, flags)
   231	{
   232		int ret = bpf_probe_read_check_dynptr(dst, offset, size, flags);
   233	
   234		return ret ?: bpf_probe_read_user_common(dst->data + dst->offset + offset,
 > 235					size, unsafe_ptr);
   236	}
   237	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

