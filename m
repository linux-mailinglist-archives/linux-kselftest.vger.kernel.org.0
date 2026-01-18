Return-Path: <linux-kselftest+bounces-49249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72310D39309
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 07:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE4DF3010742
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 06:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3002248AF;
	Sun, 18 Jan 2026 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zee7kwuB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79517D6;
	Sun, 18 Jan 2026 06:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768718174; cv=none; b=T7X3NLpotNtC+8asSXHQgwBkGGlB48iXkjoGjkMrVC49tFiUhW6ygefTP33UsLeZ1k96pH2h+MCJFOu0Vxizz+eCZ2k14B1TrB8fpDEj4zRR6RJQpTLYkvHlXWiDvqpSi0xZIqmnJ1kKyt0vO/mjuLVWe+Bq19LxYXkSqS7A8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768718174; c=relaxed/simple;
	bh=aKLCKvaFUBdlP+9DOV2yYz6au92+CHN/1gNqOaUJJBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYyywrd65tJBH68DfARUUs8nfcWzRr6YCC4/Tq307RBIlULc2oE6TxDPm4XpPB5Nc1YKO1e7YJ6/Sm6y1jteFYpY5+pREA0aAx7Uxog6e9viTmrIvPDcsONXOripPzcIUAYBjYNYN3GPfmBWGfyq8aNDDnkPzhxGoO3xAsQ1pIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zee7kwuB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768718172; x=1800254172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aKLCKvaFUBdlP+9DOV2yYz6au92+CHN/1gNqOaUJJBw=;
  b=Zee7kwuBTH0z0TLAJV/NuGEofMzRh7y1wFn/F/d6SIqO/Emng9f3CDvq
   dl4yBpFrfY/b1euhMVgnvmsM0azMSB6ZUkrqq+yySndcd0TNONVLTXpKd
   kRHDciW8GQaNRznq+5IelkQp+CuTuqgjStjXsYdMG2uqoS7dSQVFZ4ZuN
   kLiQB3Qb9x3ZoBSrBN0aO0J0pFzo8q99SxdFFEUK7DvYTF+qHSchHP0xd
   +iY7+9ITzZsYQRe5vmzxMsM8z0Nk4uk0XFz+Ya4IJsgCpROEjNdrYAJMC
   +Jt4CgxBZ1uxEWy14a2Mo8xh6+K92DJtEIFaiBJSSiGw25UdrgxG/kEdy
   g==;
X-CSE-ConnectionGUID: Km32jQg8TmGIXQnmpmGnBQ==
X-CSE-MsgGUID: NNiWPGzgQwW/FF+/fpyWdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11674"; a="73821862"
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="73821862"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 22:36:12 -0800
X-CSE-ConnectionGUID: BPpWmG+ISj6n4H7uIA0V8g==
X-CSE-MsgGUID: fZ4T/Se/QxyYisLOhJurYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="236270915"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Jan 2026 22:36:08 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhMOL-00000000MjQ-42l9;
	Sun, 18 Jan 2026 06:36:05 +0000
Date: Sun, 18 Jan 2026 14:36:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>,
	rostedt@goodmis.org, mhiramat@kernel.org, corbet@lwn.net,
	shuah@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: Re: [PATCH v5 v5 2/3] tracing/fprobe: Support comma-separated
 symbols and :entry/:exit
Message-ID: <202601181443.vv7qeHyx-lkp@intel.com>
References: <20260118011815.56516-3-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118011815.56516-3-seokwoo.chung130@gmail.com>

Hi Seokwoo,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.19-rc5 next-20260116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Seokwoo-Chung-Ryan/docs-tracing-fprobe-Document-list-filters-and-entry-exit/20260118-092055
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20260118011815.56516-3-seokwoo.chung130%40gmail.com
patch subject: [PATCH v5 v5 2/3] tracing/fprobe: Support comma-separated symbols and :entry/:exit
config: x86_64-randconfig-012-20260118 (https://download.01.org/0day-ci/archive/20260118/202601181443.vv7qeHyx-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260118/202601181443.vv7qeHyx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601181443.vv7qeHyx-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace_fprobe.c: In function 'parse_fprobe_spec':
   kernel/trace/trace_fprobe.c:1282:12: error: invalid storage class for function 'trace_fprobe_create_internal'
    1282 | static int trace_fprobe_create_internal(int argc, const char *argv[],
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1513:12: error: invalid storage class for function 'trace_fprobe_create_cb'
    1513 | static int trace_fprobe_create_cb(int argc, const char *argv[])
         |            ^~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1530:12: error: invalid storage class for function 'trace_fprobe_create'
    1530 | static int trace_fprobe_create(const char *raw_command)
         |            ^~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1535:12: error: invalid storage class for function 'trace_fprobe_release'
    1535 | static int trace_fprobe_release(struct dyn_event *ev)
         |            ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1545:12: error: invalid storage class for function 'trace_fprobe_show'
    1545 | static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
         |            ^~~~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1572:12: error: invalid storage class for function 'enable_trace_fprobe'
    1572 | static int enable_trace_fprobe(struct trace_event_call *call,
         |            ^~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1608:12: error: invalid storage class for function 'disable_trace_fprobe'
    1608 | static int disable_trace_fprobe(struct trace_event_call *call,
         |            ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1653:12: error: invalid storage class for function 'fprobe_register'
    1653 | static int fprobe_register(struct trace_event_call *event,
         |            ^~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1683:19: error: invalid storage class for function 'init_fprobe_trace_early'
    1683 | static __init int init_fprobe_trace_early(void)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/fprobe.h:6,
                    from kernel/trace/trace_fprobe.c:8:
>> include/linux/compiler.h:284:51: error: initializer element is not constant
     284 |         __UNIQUE_ID(__PASTE(addressable_, sym)) = (void *)(uintptr_t)&sym;
         |                                                   ^
   include/linux/compiler.h:287:9: note: in expansion of macro '___ADDRESSABLE'
     287 |         ___ADDRESSABLE(sym, __section(".discard.addressable"))
         |         ^~~~~~~~~~~~~~
   include/linux/init.h:251:9: note: in expansion of macro '__ADDRESSABLE'
     251 |         __ADDRESSABLE(fn)
         |         ^~~~~~~~~~~~~
   include/linux/init.h:256:9: note: in expansion of macro '__define_initcall_stub'
     256 |         __define_initcall_stub(__stub, fn)                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:269:9: note: in expansion of macro '____define_initcall'
     269 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:275:9: note: in expansion of macro '__unique_initcall'
     275 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:277:35: note: in expansion of macro '___define_initcall'
     277 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:295:41: note: in expansion of macro '__define_initcall'
     295 | #define core_initcall(fn)               __define_initcall(fn, 1)
         |                                         ^~~~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1702:1: note: in expansion of macro 'core_initcall'
    1702 | core_initcall(init_fprobe_trace_early);
         | ^~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1702:1: error: expected declaration or statement at end of input
   kernel/trace/trace_fprobe.c: At top level:
   kernel/trace/trace_fprobe.c:28:12: warning: 'trace_fprobe_create' used but never defined
      28 | static int trace_fprobe_create(const char *raw_command);
         |            ^~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:29:12: warning: 'trace_fprobe_show' used but never defined
      29 | static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev);
         |            ^~~~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:30:12: warning: 'trace_fprobe_release' used but never defined
      30 | static int trace_fprobe_release(struct dyn_event *ev);
         |            ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:741:12: warning: 'fprobe_register' used but never defined
     741 | static int fprobe_register(struct trace_event_call *event,
         |            ^~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1653:12: warning: 'fprobe_register' defined but not used [-Wunused-function]
    1653 | static int fprobe_register(struct trace_event_call *event,
         |            ^~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1545:12: warning: 'trace_fprobe_show' defined but not used [-Wunused-function]
    1545 | static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
         |            ^~~~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1535:12: warning: 'trace_fprobe_release' defined but not used [-Wunused-function]
    1535 | static int trace_fprobe_release(struct dyn_event *ev)
         |            ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1530:12: warning: 'trace_fprobe_create' defined but not used [-Wunused-function]
    1530 | static int trace_fprobe_create(const char *raw_command)
         |            ^~~~~~~~~~~~~~~~~~~


vim +284 include/linux/compiler.h

0ef8047b737d74 Juergen Gross  2024-11-29  275  
7290d58095712a Ard Biesheuvel 2018-08-21  276  /*
7290d58095712a Ard Biesheuvel 2018-08-21  277   * Force the compiler to emit 'sym' as a symbol, so that we can reference
7290d58095712a Ard Biesheuvel 2018-08-21  278   * it from inline assembler. Necessary in case 'sym' could be inlined
7290d58095712a Ard Biesheuvel 2018-08-21  279   * otherwise, or eliminated entirely due to lack of references that are
7290d58095712a Ard Biesheuvel 2018-08-21  280   * visible to the compiler.
7290d58095712a Ard Biesheuvel 2018-08-21  281   */
92efda8eb15295 Sami Tolvanen  2022-09-08  282  #define ___ADDRESSABLE(sym, __attrs)						\
92efda8eb15295 Sami Tolvanen  2022-09-08  283  	static void * __used __attrs						\
9f14f1f91883aa Josh Poimboeuf 2025-09-17 @284  	__UNIQUE_ID(__PASTE(addressable_, sym)) = (void *)(uintptr_t)&sym;
0ef8047b737d74 Juergen Gross  2024-11-29  285  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

