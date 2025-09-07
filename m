Return-Path: <linux-kselftest+bounces-40906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A167B47937
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 08:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DADEF7A8F41
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 06:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75341CAA7D;
	Sun,  7 Sep 2025 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYLFDhV7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A592125B2;
	Sun,  7 Sep 2025 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757225787; cv=none; b=hcfdTawF6wXXn9RbhPO9hGljIOunEAhRGT+7+zwSyJFfpTFh3WIlZpFluG5fPt3/0bbqwE67MDdIvpdjFOERvjc+TvZbI8OA4Xn80sZdPFUM7l5bPnVdWV/8Lr5yJYEJNxOGeebxXnP5zMpnfV6hKsMhOdhNClpYhL8uIfEH3+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757225787; c=relaxed/simple;
	bh=lGPCrWhKZU8OPA9OuXU2JI0gKkzLniADujgwev5bEBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipjtKq9KpUTfVph1atkejtHpFtt7jpPrvqFKqsJDd19fcE66cbKbvfgS2lr1rUQ6sWT6wJ5BnEuAz5EBrpZsJtkEtowB+d64WXURDP1Iiyoqq5bOQ1HIoSab/K9+q2DbfoAFtU3S15poR/uh+/QQ0IJaK1RE8Z6baOnuCl0Lico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYLFDhV7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757225786; x=1788761786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lGPCrWhKZU8OPA9OuXU2JI0gKkzLniADujgwev5bEBs=;
  b=fYLFDhV7+DRQZVbDaBWJ8tuvbhYqGq1BvTBL3MkIEaEF38My33wpQjj8
   KIByNw69GbnKji0fxHp6MwbC+sUOxmkpTwOJCETjq9nMgZIK/DDOVguT7
   zNOIj29KCFtusGe2OQ0UTu85TrpNyTzLzgArW7oG4kOhNxx5qAqGlRQow
   XxoTxQB9Ul5sqLN/SDye9gSLUj58qDeEN68aMG8LB3GVkHhEi6wRfEY8b
   6DMjSPOR7xWFbWjAo/8rAQrmXORVa+wgLSiwaLXQisjvhRYRzlHV6BCzy
   HQh3LrSf7PVgcDE69UiK2tB9IDxaeWUVK/VaY0fy7qGomw6fhF7jxZsX2
   Q==;
X-CSE-ConnectionGUID: iIW0/YTQT9a3zayI9fYRvA==
X-CSE-MsgGUID: UKbqowbsRUyLEPj2vOFqWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="59589025"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="59589025"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 23:16:25 -0700
X-CSE-ConnectionGUID: kSDflqCBRdqAKSF1mZGNPA==
X-CSE-MsgGUID: yFvq59kSSbS1gBdR2InZLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="177706786"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 06 Sep 2025 23:16:20 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv8hG-00024F-0K;
	Sun, 07 Sep 2025 06:16:18 +0000
Date: Sun, 7 Sep 2025 14:15:33 +0800
From: kernel test robot <lkp@intel.com>
To: Lin Yikai <yikai.lin@vivo.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Song Liu <song@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, zhaofuyu@vivo.com
Subject: Re: [PATCH v2 bpf-next 1/2] cpuidle: Implement BPF extensible
 cpuidle governor class
Message-ID: <202509071459.Gkqhd7YV-lkp@intel.com>
References: <20250901135609.76590-2-yikai.lin@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901135609.76590-2-yikai.lin@vivo.com>

Hi Lin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Lin-Yikai/cpuidle-Implement-BPF-extensible-cpuidle-governor-class/20250901-220011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250901135609.76590-2-yikai.lin%40vivo.com
patch subject: [PATCH v2 bpf-next 1/2] cpuidle: Implement BPF extensible cpuidle governor class
config: arm-randconfig-r131-20250907 (https://download.01.org/0day-ci/archive/20250907/202509071459.Gkqhd7YV-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250907/202509071459.Gkqhd7YV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509071459.Gkqhd7YV-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/cpuidle/governors/ext.c:141:1: sparse: sparse: symbol 'ops_enabled_key' was not declared. Should it be static?

vim +/ops_enabled_key +141 drivers/cpuidle/governors/ext.c

   139	
   140	static DEFINE_MUTEX(ops_mutex);
 > 141	DEFINE_STATIC_KEY_FALSE(ops_enabled_key);
   142	static atomic_t ops_enable_state_var = ATOMIC_INIT(OPS_DISABLED);
   143	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

