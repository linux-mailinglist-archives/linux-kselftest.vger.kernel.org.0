Return-Path: <linux-kselftest+bounces-48974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F04D210FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 20:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FADD3018F4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C158349B11;
	Wed, 14 Jan 2026 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXQShQ7K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCBE33B6D4;
	Wed, 14 Jan 2026 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768419626; cv=none; b=mpuWa9Xp/rw534q+HBMjSdCdc7h9qu4gpb9L21t/f76y6ydxbA6qAVGzov97hy6M9B4mvpmW0jMjtcfFPR/fmqPdob5nZXQTa51lDcyTuh5EKQ4gbJHXMQ5SQewzRs99FoUBYD5NXfhOG5qyLg6jSl8syadp6WdBrxV3Sc9RjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768419626; c=relaxed/simple;
	bh=yxJ1yuBoC2AtK5ufCDSR1KJOWKcLvyq8eTR2PZlXqSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCgS/pG2+X7fot6h00pmJxzKqyuTKzm+UGiIt/olBoGHb82xGLumsm/7dLUMfGSje0AU/p4S5Gmy8j4qDOlDFBSGKIs0r6mUDFnzdGVNnN92Er3NWz73o0Zq3H5RQXjANNPaeIf7Yv2n4/+k9lwpI3YyyrMFiqkENDekcFFpJpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXQShQ7K; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768419625; x=1799955625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yxJ1yuBoC2AtK5ufCDSR1KJOWKcLvyq8eTR2PZlXqSc=;
  b=OXQShQ7K4IaLFLXO/vKjEMpWA5XVe8iS3NsF9NKRwQwLX+MhpR25otqg
   VhKrAKaO7ubdtV7JknOAcijHwp26K7aDFi0H4+lyKnf4ojcmAD0o+ec5d
   37EHI5uMItCUk5Xltgo27kFtiLKui93aPUB8PAonS11qid62Fon/qgYEK
   yf8vtBCLuK8l3aTRG7/eNKkpELd99iOXpB9x4DVSRvtquZl7BMvrrDZYb
   QLxFX0fcj7q6jgV08cGyc+lle1TXvXzW+3ytyLyu811Bz7rV48R336tcH
   F0EHsniNXicYN2qVoO+y0iB8OZ5bys9PzLkZaPVQALtwqSC57N1vx1ExB
   A==;
X-CSE-ConnectionGUID: PKg0x9qrQeKFni4DGdY8OA==
X-CSE-MsgGUID: L/i+AOK4QE+TA+1VvAruZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69812173"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69812173"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 11:40:24 -0800
X-CSE-ConnectionGUID: 0gNFD7mhTwmJDzX5k4RTRg==
X-CSE-MsgGUID: ep3If0rfTJGULNiOAdv5xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="204550709"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Jan 2026 11:40:17 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vg6j0-00000000GvQ-23re;
	Wed, 14 Jan 2026 19:40:14 +0000
Date: Thu, 15 Jan 2026 03:39:53 +0800
From: kernel test robot <lkp@intel.com>
To: adubey@linux.ibm.com, bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, hbathini@linux.ibm.com,
	sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
	eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, christophe.leroy@csgroup.eu, naveen@kernel.org,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	memxor@gmail.com, iii@linux.ibm.com, shuah@kernel.org,
	Abhishek Dubey <adubey@linux.ibm.com>
Subject: Re: [PATCH v2 3/6] powerpc64/bpf: Tailcall handling with trampolines
Message-ID: <202601150350.ZftaCBVV-lkp@intel.com>
References: <20260114114450.30405-4-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114114450.30405-4-adubey@linux.ibm.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes linus/master v6.19-rc5 next-20260114]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/adubey-linux-ibm-com/powerpc64-bpf-Move-tail_call_cnt-to-bottom-of-stack-frame/20260114-195044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20260114114450.30405-4-adubey%40linux.ibm.com
patch subject: [PATCH v2 3/6] powerpc64/bpf: Tailcall handling with trampolines
config: powerpc-randconfig-002-20260114 (https://download.01.org/0day-ci/archive/20260115/202601150350.ZftaCBVV-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260115/202601150350.ZftaCBVV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601150350.ZftaCBVV-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/net/bpf_jit_comp.c: In function 'bpf_trampoline_setup_tail_call_info':
>> arch/powerpc/net/bpf_jit_comp.c:644:43: error: 'BPF_PPC_TAILCALL' undeclared (first use in this function); did you mean 'BPF_TAIL_CALL'?
     644 |                 int tailcallinfo_offset = BPF_PPC_TAILCALL;
         |                                           ^~~~~~~~~~~~~~~~
         |                                           BPF_TAIL_CALL
   arch/powerpc/net/bpf_jit_comp.c:644:43: note: each undeclared identifier is reported only once for each function it appears in
   arch/powerpc/net/bpf_jit_comp.c: In function '__arch_prepare_bpf_trampoline':
   arch/powerpc/net/bpf_jit_comp.c:850:41: error: 'BPF_PPC_TAILCALL' undeclared (first use in this function); did you mean 'BPF_TAIL_CALL'?
     850 |                 bpf_frame_size += SZL + BPF_PPC_TAILCALL;
         |                                         ^~~~~~~~~~~~~~~~
         |                                         BPF_TAIL_CALL


vim +644 arch/powerpc/net/bpf_jit_comp.c

   625	
   626	/*
   627	 * Refer the label 'Generated stack layout' in this file for actual stack
   628	 * layout during trampoline invocation.
   629	 *
   630	 * Refer __arch_prepare_bpf_trampoline() for stack component details.
   631	 *
   632	 * The tailcall count/reference is present in caller's stack frame. Its required
   633	 * to copy the content of tail_call_info before calling the actual function
   634	 * to which the trampoline is attached.
   635	 *
   636	 */
   637	
   638	static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_context *ctx,
   639						       int func_frame_offset,
   640						       int bpf_dummy_frame_size, int r4_off)
   641	{
   642		if (IS_ENABLED(CONFIG_PPC64)) {
   643			/* See bpf_jit_stack_tailcallinfo_offset() */
 > 644			int tailcallinfo_offset = BPF_PPC_TAILCALL;
   645			/*
   646			 * func_frame_offset =                                   ...(1)
   647			 *     bpf_dummy_frame_size + trampoline_frame_size
   648			 */
   649			EMIT(PPC_RAW_LD(_R4, _R1, func_frame_offset));
   650			EMIT(PPC_RAW_LD(_R3, _R4, -tailcallinfo_offset));
   651	
   652			/*
   653			 * Setting the tail_call_info in trampoline's frame
   654			 * depending on if previous frame had value or reference.
   655			 */
   656			EMIT(PPC_RAW_CMPLWI(_R3, MAX_TAIL_CALL_CNT));
   657			PPC_COND_BRANCH(COND_GT, CTX_NIA(ctx) + 8);
   658			EMIT(PPC_RAW_ADDI(_R3, _R4, bpf_jit_stack_tailcallinfo_offset(ctx)));
   659			/*
   660			 * From ...(1) above:
   661			 * trampoline_frame_bottom =                            ...(2)
   662			 *     func_frame_offset - bpf_dummy_frame_size
   663			 *
   664			 * Using ...(2) derived above:
   665			 *  trampoline_tail_call_info_offset =                  ...(3)
   666			 *      trampoline_frame_bottom - tailcallinfo_offset
   667			 *
   668			 * From ...(3):
   669			 * Use trampoline_tail_call_info_offset to write reference of main's
   670			 * tail_call_info in trampoline frame.
   671			 */
   672			EMIT(PPC_RAW_STL(_R3, _R1, (func_frame_offset - bpf_dummy_frame_size)
   673						- tailcallinfo_offset));
   674	
   675		} else {
   676			/* See bpf_jit_stack_offsetof() and BPF_PPC_TC */
   677			EMIT(PPC_RAW_LL(_R4, _R1, r4_off));
   678		}
   679	}
   680	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

