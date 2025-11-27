Return-Path: <linux-kselftest+bounces-46657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 292F6C8F223
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 16:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D3B3B6541
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 15:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5571B33468E;
	Thu, 27 Nov 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMIkdj54"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B557333456;
	Thu, 27 Nov 2025 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255664; cv=none; b=XEMZ2NysUCdLDBLEJ0XpNGz661pjD01QEt0xOAALqGA186WAaivwoq0Hz/ZoY+3yacc553Deti55rTwVQdx6QLYJT30y/7AGoE7p0XJxaOxc34vfLbfhBprQwxtl4KDM/HrgpCcY8Kmb7aHYyMRIOeGafquVFSPB/MuXNgpODBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255664; c=relaxed/simple;
	bh=UeR2BgcHfyY8nNyZQwhClJSqKeDIuwmepY4yPjZ0Vcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ9i3GBCPDNVPYtvM148X8fmDkkJTsiM+91htSRgMs8CXFmIkIlaX6gP5av4c6FDj6g/CAZeoFTaG7pF/L+njZXKz9nQrYknaxCTHCC8c5qo9Qgpg7FddGQ6uh6n1tErGzyjlOFrP/mR0owiaN8bfgpXX3t3jdekT/6croqo2WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMIkdj54; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764255662; x=1795791662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UeR2BgcHfyY8nNyZQwhClJSqKeDIuwmepY4yPjZ0Vcg=;
  b=UMIkdj54tAbmOJ3ocouNc3A0QqoF8O9cuI9Xxr6KoJQ+M6CYg7J0M/+h
   R6EdwpVTNwVdPbMeq7+smxxPGjqAXEI2YfFD6tliiFzGMwV3V2mm73QmK
   7AmQR0UDlmsE1DffCOdflbPBUQEWoAiuN9inYZSlaOI8lryljrTlzlrCw
   0522n8es4igpeAbvb18ALASzRLpRE01P0c0INbI5r151qpuSInOEubM3/
   WsE88GLolOyEYK0eT3QTjPItt8QELX7US6k+SVJPmqBDue66KZxH5OhCu
   b73MfhXOq3MNzmbHFfPFNvyVsbaoyyKI/bIC0fDw2xmVSYChRiLqum6qW
   A==;
X-CSE-ConnectionGUID: UqLmUKRlT7SSjOpn5UDHxQ==
X-CSE-MsgGUID: 0lqC07vqSMCH77WO9tt+Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="83697031"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="83697031"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 07:01:01 -0800
X-CSE-ConnectionGUID: U0SK0fYHSaGH15RRdzsLpQ==
X-CSE-MsgGUID: lhj7LxZ9T2iFjd7w05O2Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="198358532"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 27 Nov 2025 07:00:59 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOdUO-0000000052H-2rLt;
	Thu, 27 Nov 2025 15:00:56 +0000
Date: Thu, 27 Nov 2025 23:00:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>,
	rostedt@goodmis.org, mhiramat@kernel.org, corbet@lwn.net,
	shuah@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: Re: [PATCH v4 2/3] tracing/fprobe: Support comma-separated symbols
 and :entry/:exit
Message-ID: <202511272241.s6tUpIgv-lkp@intel.com>
References: <20251126184110.72241-3-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126184110.72241-3-seokwoo.chung130@gmail.com>

Hi Seokwoo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.18-rc7 next-20251127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Seokwoo-Chung-Ryan/docs-tracing-fprobe-Document-list-filters-and-entry-exit/20251127-024245
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20251126184110.72241-3-seokwoo.chung130%40gmail.com
patch subject: [PATCH v4 2/3] tracing/fprobe: Support comma-separated symbols and :entry/:exit
config: x86_64-randconfig-003-20251127 (https://download.01.org/0day-ci/archive/20251127/202511272241.s6tUpIgv-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251127/202511272241.s6tUpIgv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511272241.s6tUpIgv-lkp@intel.com/

All warnings (new ones prefixed by >>):

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
   include/linux/compiler.h:286:52: error: initializer element is not constant
     286 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
         |                                                    ^
   include/linux/compiler.h:289:9: note: in expansion of macro '___ADDRESSABLE'
     289 |         ___ADDRESSABLE(sym, __section(".discard.addressable"))
         |         ^~~~~~~~~~~~~~
   include/linux/init.h:250:9: note: in expansion of macro '__ADDRESSABLE'
     250 |         __ADDRESSABLE(fn)
         |         ^~~~~~~~~~~~~
   include/linux/init.h:255:9: note: in expansion of macro '__define_initcall_stub'
     255 |         __define_initcall_stub(__stub, fn)                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:268:9: note: in expansion of macro '____define_initcall'
     268 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:274:9: note: in expansion of macro '__unique_initcall'
     274 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:276:35: note: in expansion of macro '___define_initcall'
     276 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:294:41: note: in expansion of macro '__define_initcall'
     294 | #define core_initcall(fn)               __define_initcall(fn, 1)
         |                                         ^~~~~~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1702:1: note: in expansion of macro 'core_initcall'
    1702 | core_initcall(init_fprobe_trace_early);
         | ^~~~~~~~~~~~~
   kernel/trace/trace_fprobe.c:1702:1: error: expected declaration or statement at end of input
   kernel/trace/trace_fprobe.c: At top level:
>> kernel/trace/trace_fprobe.c:28:12: warning: 'trace_fprobe_create' used but never defined
      28 | static int trace_fprobe_create(const char *raw_command);
         |            ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace_fprobe.c:29:12: warning: 'trace_fprobe_show' used but never defined
      29 | static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev);
         |            ^~~~~~~~~~~~~~~~~
>> kernel/trace/trace_fprobe.c:30:12: warning: 'trace_fprobe_release' used but never defined
      30 | static int trace_fprobe_release(struct dyn_event *ev);
         |            ^~~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace_fprobe.c:741:12: warning: 'fprobe_register' used but never defined
     741 | static int fprobe_register(struct trace_event_call *event,
         |            ^~~~~~~~~~~~~~~
>> kernel/trace/trace_fprobe.c:1653:12: warning: 'fprobe_register' defined but not used [-Wunused-function]
    1653 | static int fprobe_register(struct trace_event_call *event,
         |            ^~~~~~~~~~~~~~~
>> kernel/trace/trace_fprobe.c:1545:12: warning: 'trace_fprobe_show' defined but not used [-Wunused-function]
    1545 | static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
         |            ^~~~~~~~~~~~~~~~~
>> kernel/trace/trace_fprobe.c:1535:12: warning: 'trace_fprobe_release' defined but not used [-Wunused-function]
    1535 | static int trace_fprobe_release(struct dyn_event *ev)
         |            ^~~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace_fprobe.c:1530:12: warning: 'trace_fprobe_create' defined but not used [-Wunused-function]
    1530 | static int trace_fprobe_create(const char *raw_command)
         |            ^~~~~~~~~~~~~~~~~~~


vim +/trace_fprobe_create +28 kernel/trace/trace_fprobe.c

334e5519c375701 Masami Hiramatsu (Google  2023-06-06  27) 
334e5519c375701 Masami Hiramatsu (Google  2023-06-06 @28) static int trace_fprobe_create(const char *raw_command);
334e5519c375701 Masami Hiramatsu (Google  2023-06-06 @29) static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev);
334e5519c375701 Masami Hiramatsu (Google  2023-06-06 @30) static int trace_fprobe_release(struct dyn_event *ev);
334e5519c375701 Masami Hiramatsu (Google  2023-06-06  31) static bool trace_fprobe_is_busy(struct dyn_event *ev);
334e5519c375701 Masami Hiramatsu (Google  2023-06-06  32) static bool trace_fprobe_match(const char *system, const char *event,
334e5519c375701 Masami Hiramatsu (Google  2023-06-06  33) 			int argc, const char **argv, struct dyn_event *ev);
334e5519c375701 Masami Hiramatsu (Google  2023-06-06  34) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

