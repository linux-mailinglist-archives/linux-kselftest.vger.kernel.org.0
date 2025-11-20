Return-Path: <linux-kselftest+bounces-46141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79827C76633
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 22:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C46F4E0311
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 21:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193982698AF;
	Thu, 20 Nov 2025 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzX3FUQs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720A1302774;
	Thu, 20 Nov 2025 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763674588; cv=none; b=U7rgVX1RIjs+Upct/wajWOMPQxVaaiHyo3wYprbnxrfNl6SZNeKgdKf4whYRzK8+NEBiVLCAhT4n+MyzK2Ipm0gu6dTZ8G4hXtNoTlNzdA8YbUj64/I6vlv+HTVmZTzY2mOxjkt6xXpiMqUHGWZExN65VnWZFcRgY5QZ6HAwfF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763674588; c=relaxed/simple;
	bh=pZ8ivgqMDkOJbGubFInE/45I1Jd0L9jrqG0Z1uaW19Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYtL4f00lbmUvBIWB7tr8LqQP20r9lxcR0Nf0pJfqInjbtg9NuHPpRyiw3VVxunJI3E7t4ct6pN6YK8uURgeUxB2R5KZRSptQKrf5RsU5xwIGyKJ2SbwwaBLH6Oi/CCoo6bUd7AP7zISK00Wtv+2qxmhlu8ujXHZY/rQ5ceMkCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XzX3FUQs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763674586; x=1795210586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pZ8ivgqMDkOJbGubFInE/45I1Jd0L9jrqG0Z1uaW19Q=;
  b=XzX3FUQsOXxPB2h6+8fOdKugPep7oPSJmSaRpSHywjcMwtnA+GEx6iqo
   0H7LvdecW+jR9fVeB1mdpZ/lesD9alXsobYfNWsM/NDd3ucNfxqUVwIr1
   b39351TIdlxqNQYD54ufwiTuLzzzlp5ioRE67tGuBxjQcP3KqbeK+D/99
   0cyeE9++nRDkt/G1OMZcl5Q307TcOhKJPjnGj64OYA95wYWAoKIZ3FgiA
   Qxa5nAXZvluv650tqyvMsSxJESjPCbzkaMA00d34MYW1NQyi7MsJcFNtm
   kCOCfrjrsJkPGbcqL/j+nUuhPKow4Pkr08tsz0b/Uco3Zk8RxbjUSiq69
   g==;
X-CSE-ConnectionGUID: fhRI6N2/Rc6Z2QGt/QyfJA==
X-CSE-MsgGUID: EA5nORtWTaSBmz0kXvhtJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="76864709"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="76864709"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 13:36:25 -0800
X-CSE-ConnectionGUID: KqDocwj6RnWMdsLi4JMTFg==
X-CSE-MsgGUID: r/Me6OORQda8xGobvBAfeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="191591619"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Nov 2025 13:36:22 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMCKB-0004bH-2v;
	Thu, 20 Nov 2025 21:36:19 +0000
Date: Fri, 21 Nov 2025 05:35:21 +0800
From: kernel test robot <lkp@intel.com>
To: griffoul@gmail.com, kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, seanjc@google.com, pbonzini@redhat.com,
	vkuznets@redhat.com, shuah@kernel.org, dwmw@amazon.co.uk,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fred Griffoul <fgriffo@amazon.co.uk>
Subject: Re: [PATCH v2 08/10] KVM: x86: Add nested context management
Message-ID: <202511210515.8L9NBb1R-lkp@intel.com>
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
[also build test WARNING on kvm/next mst-vhost/linux-next linus/master v6.18-rc6 next-20251120]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/griffoul-gmail-com/KVM-nVMX-Implement-cache-for-L1-MSR-bitmap/20251119-012332
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20251118171113.363528-9-griffoul%40gmail.org
patch subject: [PATCH v2 08/10] KVM: x86: Add nested context management
config: i386-randconfig-141-20251120 (https://download.01.org/0day-ci/archive/20251121/202511210515.8L9NBb1R-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251121/202511210515.8L9NBb1R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511210515.8L9NBb1R-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/nested.c:133:10: warning: expression which evaluates to zero treated as a null pointer constant of type 'struct kvm_nested_context *' [-Wnon-literal-null-conversion]
     133 |                 return false;
         |                        ^~~~~
   1 warning generated.


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

