Return-Path: <linux-kselftest+bounces-46637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DB5C8E369
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 13:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE7BC34AF49
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6657432E6A8;
	Thu, 27 Nov 2025 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7uayMwp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FAA269CE1;
	Thu, 27 Nov 2025 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245622; cv=none; b=jFZy7y+tLIxtdqJGsmBR5MLd5g/1FvOg9IRdoZCvZwjxHNH49qAiPU6PjgWjIi06fnSGReu7XpliqGzNV5JBIDgSVO3TSWgxEQ/2SdneV0ObdgubjDYgquEIVnDUBP00GgmpAWWq6FWUgpaEvInD91AJIG1lBbd33yNdWmZ8QOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245622; c=relaxed/simple;
	bh=4wfdcjLqa32wYY20jUpXr6SpqVXYg6QlXgbmRyPKHNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slP0MDbCCJiYLU86vpm3ybID/rQodAINwtqYuNg+nznXlybr5pKlHsBZqdHbP0cDsNR/GrtLQIumbi5QcCHxwftROIS9H8WQZmKqrh4Vgbvja4OVdh5fjfna6KUloBYIbIR9k1TT6SQkOP4Y3+aboGqsm4kmyp6snTtIZrHAE64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7uayMwp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764245620; x=1795781620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4wfdcjLqa32wYY20jUpXr6SpqVXYg6QlXgbmRyPKHNs=;
  b=i7uayMwpCJe1jtD3mMvAL2yUaBFmWQoAv75X/CnhYBbZtjxiQ1wBptP9
   6M1EFxdUz5WVJo94o0WO9Mmzxtx/UumsFX8oJJ5JnPoqAotoAc0x9ea4L
   MavO/7BCuuwsgWEelasdLxEp94mOYdUXTkFMpQRYRVqW7wP9i9sYTD8sR
   6iKnQVnC8G4XmPKpq85R/3quXpsJWzpw1UMTI1XQ2d/jPDa6j9YIfb1c7
   g+VVlv3TNFE6osGmUfqbsJSzpkZjzY7HkT1zm8TVQovkymZFJBzsuPeM2
   mVWs0wOJ6UWmSrMs5kLyfuaOib+mbJC7K5ACXfVjBSNQSax8XWlKpgE0X
   w==;
X-CSE-ConnectionGUID: CXfjPvepRFa9kXILAYbc3g==
X-CSE-MsgGUID: lo7pzuZUQFW31EwlOFth0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="83684938"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="83684938"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 04:13:39 -0800
X-CSE-ConnectionGUID: +5F6CXJjSyyszMrvVcgAUg==
X-CSE-MsgGUID: LdZuhfhfQNSSajPSbYmYmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="192472033"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 27 Nov 2025 04:13:36 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOasP-000000004jp-1rzh;
	Thu, 27 Nov 2025 12:13:33 +0000
Date: Thu, 27 Nov 2025 20:12:53 +0800
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
Message-ID: <202511271925.xuaUx8bB-lkp@intel.com>
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
config: x86_64-randconfig-003-20251127 (https://download.01.org/0day-ci/archive/20251127/202511271925.xuaUx8bB-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251127/202511271925.xuaUx8bB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511271925.xuaUx8bB-lkp@intel.com/

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

334e5519c37570 Masami Hiramatsu (Google  2023-06-06  27) 
334e5519c37570 Masami Hiramatsu (Google  2023-06-06 @28) static int trace_fprobe_create(const char *raw_command);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06 @29) static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06 @30) static int trace_fprobe_release(struct dyn_event *ev);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  31) static bool trace_fprobe_is_busy(struct dyn_event *ev);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  32) static bool trace_fprobe_match(const char *system, const char *event,
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  33) 			int argc, const char **argv, struct dyn_event *ev);
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  34) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

