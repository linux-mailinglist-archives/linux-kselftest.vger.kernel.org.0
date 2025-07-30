Return-Path: <linux-kselftest+bounces-38082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BB8B161CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 15:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7FB5A42FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 13:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D9F2D77E7;
	Wed, 30 Jul 2025 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SW5QWZ8n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A812063F0;
	Wed, 30 Jul 2025 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883438; cv=none; b=gmOfCeUn7iwlmVWGSOaW2xF+W1Q6kwOpRuuSPvR3azQnJ8CHJFUxiSeabKfanFoPmUvIeieV3+pLN29Cuwn5TBWDvOTgp/86rwb9vOHW4EN12PZLM/85prYHyAGeQKyHTXLdFm77EwhThMPH4YX1NNGNIxbTYccPTooU2CxRh+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883438; c=relaxed/simple;
	bh=ifIMrBtF5ufMRPUqGdpwMP/SvTYeKCCpB+qZwdbtgxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXRljrYLdY11YCAG+Ht1DgI2e2ZjOwxkzCn/jTlELJ+pLm74i4lSnJyeFI1s63Fs2/7bapsxYDPXKVS1q4oaNpCQyRvCI2DfcvF5CUQitO78Eba/kkKYWpZ1fbvy406J2a5NqNEp/VUxmZbWhbQxsJ0JCVGsEJo4Wxb1OJgwqmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SW5QWZ8n; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753883436; x=1785419436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ifIMrBtF5ufMRPUqGdpwMP/SvTYeKCCpB+qZwdbtgxQ=;
  b=SW5QWZ8nv2fBxUDbednnbWDWGVVX5MBaBHCOWosoKX1AiAhjcbgpH2ym
   dA2erRJa4wu8D/gReW7gQhlGG95BbHJiNQ/PcnCeVwJTyXYlShphSAzlj
   yZTmWq5fE5clnZm7vri8Z2Llec++xV031j2/qL7bRnJsTy59ZoftIOwH6
   l04IR5gmYVZMkB4MWRoWSkW7v1/2C6xaaUJoFglcxtORz1+8IgY+H7X/u
   Jgjs+mCchnKuIuiFq4J4uUgK0iXaQuu61eS//1kazukEU6aQhy0fj9rAw
   IJwbJvNMZs8ATlb8HBy6Qy4FVKhJ5PfnF3DpigBolFOSNFygWx8gYcQ3p
   w==;
X-CSE-ConnectionGUID: Io5HeSmWSjKbkrG0B4ykqQ==
X-CSE-MsgGUID: gNSlfHMKR9+lr9ZGdvqI7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56331423"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56331423"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 06:50:32 -0700
X-CSE-ConnectionGUID: 43tHoqJqSGyDw3huzPrupQ==
X-CSE-MsgGUID: 4qJf4K0QTxGvRBFc0JAQkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="193978560"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 30 Jul 2025 06:50:28 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uh7CL-0002nY-2G;
	Wed, 30 Jul 2025 13:50:25 +0000
Date: Wed, 30 Jul 2025 21:50:12 +0800
From: kernel test robot <lkp@intel.com>
To: Marie Zhussupova <marievic@google.com>, rmoar@google.com,
	davidgow@google.com, shuah@kernel.org, brendan.higgins@linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, elver@google.com,
	dvyukov@google.com, lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Marie Zhussupova <marievic@google.com>
Subject: Re: [PATCH 2/9] kunit: Introduce param_init/exit for parameterized
 test shared context management
Message-ID: <202507302114.xQU4zmX5-lkp@intel.com>
References: <20250729193647.3410634-3-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729193647.3410634-3-marievic@google.com>

Hi Marie,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/kunit]
[also build test ERROR on shuah-kselftest/kunit-fixes drm-xe/drm-xe-next linus/master v6.16 next-20250730]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marie-Zhussupova/kunit-Add-parent-kunit-for-parameterized-test-context/20250730-033818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit
patch link:    https://lore.kernel.org/r/20250729193647.3410634-3-marievic%40google.com
patch subject: [PATCH 2/9] kunit: Introduce param_init/exit for parameterized test shared context management
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250730/202507302114.xQU4zmX5-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250730/202507302114.xQU4zmX5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507302114.xQU4zmX5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0063]: missing fields `param_exit` and `param_init` in initializer of `kunit_case`
   --> rust/kernel/kunit.rs:200:5
   |
   200 |     kernel::bindings::kunit_case {
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `param_exit` and `param_init`
--
>> error[E0063]: missing fields `param_exit` and `param_init` in initializer of `kunit_case`
   --> rust/kernel/kunit.rs:219:5
   |
   219 |     kernel::bindings::kunit_case {
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `param_exit` and `param_init`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

