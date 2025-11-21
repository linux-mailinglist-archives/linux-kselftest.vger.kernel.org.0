Return-Path: <linux-kselftest+bounces-46289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83915C7BC30
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 22:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5D374E041D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 21:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A9C2F069E;
	Fri, 21 Nov 2025 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N66wTsH4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589126ED55;
	Fri, 21 Nov 2025 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763760891; cv=none; b=uSNGqRcw5MSKcHp4yL6TdkfVWW2VW2MFN2zsxDthVN7YvHScM/u6myZ43kVX99XbY5srs94DPB21tDR+ersVhJGVfXP9krTM8MHoTo8gfXTPlE1/YC5c6BZS4WQ7uslWeV1uJLCKCTMKPbdqwDmaAGYJ8tYF19Ams50ELA9d8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763760891; c=relaxed/simple;
	bh=0Czov/vSnhpAiV6QxdjRhlrpGNFHHnSruDyXbNge7Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZEi1l+GiiSFaaLNQMnVN6B56WuD0OrmZxNQbcEW6ZborrTQTPP4MA+tX3Tpv21BZOw2LXUfWmsIKHuYaudsfd4OyyBTk/MnOW5I3uk+iOML0C2TqLoYHC993S9Gzv46CYf6QVCSfBQcjIeAOOQM5FWv47IvIZxu2Ka5MZyrwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N66wTsH4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763760890; x=1795296890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Czov/vSnhpAiV6QxdjRhlrpGNFHHnSruDyXbNge7Zk=;
  b=N66wTsH47MYQcfq+438OlnumTpmJDZc+bpqU/0i9ry0vjbepMy+2ejcL
   5XhouXPSt8PgoZAn9GLOvRAtDGPZ4c8FuTgwUki1V1d+ElrSzEctWp+T6
   pOo8e1N8sOd0kTXvFdUY7Wv4rQ1ymzAL7tFoPymRleZOl53vKPop8qvP7
   H2vA8J0MhoXFEnciRMyYuW1kVaQlPZHDq+RlJFAnpDUHEGdEhblUghS3g
   1itge39AcAKvdycEQ6bP65fx4lPGM3CkuPpap2CCfGXeCj1Z+BMq940Ie
   QsJtztzGUdEl3/1MKSfVJTTjQFTL6VUPe8FqEin0ZoyRBRs/YhQV4KKrL
   g==;
X-CSE-ConnectionGUID: T9RDbhbCT3OWf0CCcAyACQ==
X-CSE-MsgGUID: zYem0iVWQCarPNB7e3nYvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65745494"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="65745494"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 13:34:48 -0800
X-CSE-ConnectionGUID: o8GEBnQYTy+S0wSkrKwIUA==
X-CSE-MsgGUID: y0CCEHJzQ+qAuFX6PPHeeg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Nov 2025 13:34:45 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMYmB-0006tz-0J;
	Fri, 21 Nov 2025 21:34:43 +0000
Date: Sat, 22 Nov 2025 05:34:01 +0800
From: kernel test robot <lkp@intel.com>
To: griffoul@gmail.com, kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, seanjc@google.com, pbonzini@redhat.com,
	vkuznets@redhat.com, shuah@kernel.org, dwmw@amazon.co.uk,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fred Griffoul <fgriffo@amazon.co.uk>
Subject: Re: [PATCH v2 08/10] KVM: x86: Add nested context management
Message-ID: <202511220448.n0QXrANz-lkp@intel.com>
References: <20251118171113.363528-9-griffoul@gmail.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118171113.363528-9-griffoul@gmail.org>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvm/queue]
[also build test WARNING on kvm/next mst-vhost/linux-next linus/master v6.18-rc6 next-20251121]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/griffoul-gmail-com/KVM-nVMX-Implement-cache-for-L1-MSR-bitmap/20251119-012332
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20251118171113.363528-9-griffoul%40gmail.org
patch subject: [PATCH v2 08/10] KVM: x86: Add nested context management
config: i386-randconfig-062-20251121 (https://download.01.org/0day-ci/archive/20251122/202511220448.n0QXrANz-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511220448.n0QXrANz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511220448.n0QXrANz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kvm/nested.c:133:24: sparse: sparse: Using plain integer as NULL pointer

vim +133 arch/x86/kvm/nested.c

   122	
   123	struct kvm_nested_context *kvm_nested_context_load(struct kvm_vcpu *vcpu,
   124							   gpa_t gpa)
   125	{
   126		struct kvm_nested_context_table *table;
   127		struct kvm_nested_context *ctx, *new_ctx = NULL;
   128		struct kvm *vm = vcpu->kvm;
   129		bool reset = false;
   130	
   131		table = vcpu->kvm->arch.nested_context_table;
   132		if (WARN_ON_ONCE(!table))
 > 133			return false;
   134	retry:
   135		spin_lock(&table->lock);
   136		ctx = kvm_nested_context_find(table, vcpu, gpa);
   137		if (!ctx) {
   138			/* At capacity? Recycle the LRU context */
   139			if (table->count >= kvm_nested_context_max(vcpu->kvm)) {
   140				ctx = kvm_nested_context_recycle(table);
   141				if (unlikely(!ctx))
   142					goto finish;
   143	
   144				kvm_nested_context_insert(table, ctx, gpa);
   145				++vm->stat.nested_context_recycle;
   146				reset = true;
   147	
   148			} else if (new_ctx) {
   149				++table->count;
   150				ctx = new_ctx;
   151				kvm_nested_context_insert(table, ctx, gpa);
   152				new_ctx = NULL;
   153	
   154			} else {
   155				/* Allocate a new context without holding the lock */
   156				spin_unlock(&table->lock);
   157				new_ctx = kvm_x86_ops.nested_ops->alloc_context(vcpu);
   158				if (unlikely(!new_ctx))
   159					return NULL;
   160	
   161				goto retry;
   162			}
   163		} else
   164			++vm->stat.nested_context_reuse;
   165	
   166		ctx->vcpu = vcpu;
   167	finish:
   168		spin_unlock(&table->lock);
   169	
   170		if (new_ctx)
   171			kvm_x86_ops.nested_ops->free_context(new_ctx);
   172	
   173		if (reset)
   174			kvm_x86_ops.nested_ops->reset_context(ctx);
   175	
   176		return ctx;
   177	}
   178	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

