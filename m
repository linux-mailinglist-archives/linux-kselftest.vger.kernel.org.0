Return-Path: <linux-kselftest+bounces-8896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480528B2D72
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 01:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797011C20E2E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 23:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8A915624D;
	Thu, 25 Apr 2024 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFM7H5Op"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE353152526;
	Thu, 25 Apr 2024 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714086627; cv=none; b=rwiZ3W5L9LsKWf77d9eosxinfvNUFQrVouRNY4sjDd/uhCpNV3RwS4WYzCvv68Y9Ctp0KrmPOTWIkL6m2/xLHTgAtmlJFHNuGAxnKsjL884RxPNmb6R0xnAlXIyUjUIJJp4houe1+wIkX2QKIT70JtrzShrv1JAxRQYtRV85+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714086627; c=relaxed/simple;
	bh=iOUr7793PuOMIMhHvUa9WY+EkIduESRkPhsD/HavPVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DR88Q83YoqWcsjcr+iiQDVmW9ZmHJNg5YmiChWNE3LLrSzqXYSYnjJcwRl8SpMoBTeU3vz9BeDbAiCmUyYKfLVJPQPQwGNY6fJk6vqSu1o7Yxs1x6GRGevOthD3QfCD6etkgPlpQuiUgTeGwyb7GWGgBNLsva33LRjRQZtQzrA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFM7H5Op; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714086626; x=1745622626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iOUr7793PuOMIMhHvUa9WY+EkIduESRkPhsD/HavPVg=;
  b=mFM7H5Oprzpc1/xVxEogSgm7M98JyXl1xEj3cQ3MYPODsrkBavXf7gEV
   PPr+fL7JB3Nmo3sbmQmlj4sQbSIWKVjFCgp8tPtRhVK8SYj8Hp8cj8+kd
   E6Hn13trdRIieMDvEu3WoIF6hDGK9/NDY2pdwqyT7DNVzC48FJsACDjVd
   EFwtLY3EyAGJkucWhb2amnG6iDmzp/LWT8QhjGqsfa+rGH2nosAxt4WSR
   eLfjc09y361jB88u6IHA722KNUmpERc1JahFkG0dlJBjPpyloJQN8qIFA
   4/JhqXTzcuq3xzoshdxlfVRm5x7wK+8PBSLXJk94+v8dLBFCxGmoPRgcp
   Q==;
X-CSE-ConnectionGUID: ZfJWbl6NRf6AVbR9dBFn+A==
X-CSE-MsgGUID: o+hdQhT7R1mzgCpdquyJug==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="13598255"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="13598255"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 16:10:25 -0700
X-CSE-ConnectionGUID: yZy6SwXrSaqLR46B6z51Dg==
X-CSE-MsgGUID: tbxTMqn5TnCuB9K5YcnC7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25247701"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 25 Apr 2024 16:10:20 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s08EM-000304-1t;
	Thu, 25 Apr 2024 23:10:18 +0000
Date: Fri, 26 Apr 2024 07:09:46 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH 2/3] bpf: do not walk twice the hash map on free
Message-ID: <202404260653.ULrCGrp2-lkp@intel.com>
References: <20240425-bpf-next-v1-2-1d8330e6c643@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425-bpf-next-v1-2-1d8330e6c643@kernel.org>

Hi Benjamin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 52578f7f53ff8fe3a8f6f3bc8b5956615c07a16e]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Tissoires/bpf-do-not-walk-twice-the-map-on-free/20240425-220322
base:   52578f7f53ff8fe3a8f6f3bc8b5956615c07a16e
patch link:    https://lore.kernel.org/r/20240425-bpf-next-v1-2-1d8330e6c643%40kernel.org
patch subject: [PATCH 2/3] bpf: do not walk twice the hash map on free
config: arc-randconfig-002-20240426 (https://download.01.org/0day-ci/archive/20240426/202404260653.ULrCGrp2-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240426/202404260653.ULrCGrp2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404260653.ULrCGrp2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/hashtab.c:243:13: warning: 'htab_free_prealloced_wq' defined but not used [-Wunused-function]
     243 | static void htab_free_prealloced_wq(struct bpf_htab *htab)
         |             ^~~~~~~~~~~~~~~~~~~~~~~


vim +/htab_free_prealloced_wq +243 kernel/bpf/hashtab.c

68134668c17f31 Alexei Starovoitov 2021-07-14  242  
246331e3f1eac9 Benjamin Tissoires 2024-04-20 @243  static void htab_free_prealloced_wq(struct bpf_htab *htab)
246331e3f1eac9 Benjamin Tissoires 2024-04-20  244  {
246331e3f1eac9 Benjamin Tissoires 2024-04-20  245  	u32 num_entries = htab->map.max_entries;
246331e3f1eac9 Benjamin Tissoires 2024-04-20  246  	int i;
246331e3f1eac9 Benjamin Tissoires 2024-04-20  247  
246331e3f1eac9 Benjamin Tissoires 2024-04-20  248  	if (!btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
246331e3f1eac9 Benjamin Tissoires 2024-04-20  249  		return;
246331e3f1eac9 Benjamin Tissoires 2024-04-20  250  	if (htab_has_extra_elems(htab))
246331e3f1eac9 Benjamin Tissoires 2024-04-20  251  		num_entries += num_possible_cpus();
246331e3f1eac9 Benjamin Tissoires 2024-04-20  252  
246331e3f1eac9 Benjamin Tissoires 2024-04-20  253  	for (i = 0; i < num_entries; i++) {
246331e3f1eac9 Benjamin Tissoires 2024-04-20  254  		struct htab_elem *elem;
246331e3f1eac9 Benjamin Tissoires 2024-04-20  255  
246331e3f1eac9 Benjamin Tissoires 2024-04-20  256  		elem = get_htab_elem(htab, i);
246331e3f1eac9 Benjamin Tissoires 2024-04-20  257  		bpf_obj_free_workqueue(htab->map.record,
246331e3f1eac9 Benjamin Tissoires 2024-04-20  258  				       elem->key + round_up(htab->map.key_size, 8));
246331e3f1eac9 Benjamin Tissoires 2024-04-20  259  		cond_resched();
246331e3f1eac9 Benjamin Tissoires 2024-04-20  260  	}
246331e3f1eac9 Benjamin Tissoires 2024-04-20  261  }
246331e3f1eac9 Benjamin Tissoires 2024-04-20  262  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

