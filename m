Return-Path: <linux-kselftest+bounces-4191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BB584B535
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 13:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1D02853E1
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 12:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F985132499;
	Tue,  6 Feb 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCYP2Vl7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F094C13247A;
	Tue,  6 Feb 2024 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221889; cv=none; b=Px4minYNcYYEgbKnyggmq3ESYOAR8kPhzK8RjPuHgLKh2Lw5+dPVmZMQRWYZbo/5i1d64mE/bZeJbd93O66cxh++b7OLD6x1CQ6cUdt79DV4yrOlfH1hoZOySAQmkAFP3eW9sZ6mRvmlRI9b9HSUoT7lHyX6q3xL2xmnVKkznfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221889; c=relaxed/simple;
	bh=wDwTJtO2MjLG9wSqd9e1qztpn3YoCZw6Bxof7Rpx1Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRbjVBpZIXLSjhsTArYx0zdWDNdW+UqIe2y9KlWXIiKpKm+khCgOdlSeWbix7LkXuaNAKM841Hy1trpxQR5Jal6GuLE1ddcuPpj1pQfWli1J2FRC/1xm0zT4xcTM5UDWlK/cmreM88cXJVFpff6GeN5terRNaJig3r6smohykUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCYP2Vl7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707221888; x=1738757888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wDwTJtO2MjLG9wSqd9e1qztpn3YoCZw6Bxof7Rpx1Sw=;
  b=TCYP2Vl7vb/gXODzcmmupzIj4ulD6XLFRGKqkBupMRoFkzeu+zloBnnk
   jsD7A85FGgdfXj8tVAfTP2vJ7w8rNjg5FxEdOeL5ymfq+eGeIGBHxitbE
   HsF9kS61k+mPjiS92oKxK+gyDw3QXah/XHI2ch6EEQL+JbaSXt1BshkN6
   PP+PfkE5QRBf5OlNJMJa57J+YxxfYfA6zHEN4TEuQG0zVdaqX+DHTgLev
   /5+DX6VUZN88V1dOg6Nmw6tNjR6VBE+Ijr6rkS8wvuP5wN8fbbXlw41ri
   tdIstEOo7Ag6JAstnusqf/yL+SmrCAKfNS0vxDtR1w3MUMdy5DmaC/eSw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="23207474"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="23207474"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:18:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="933443893"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="933443893"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 Feb 2024 04:18:03 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXKOm-0001MW-2e;
	Tue, 06 Feb 2024 12:18:00 +0000
Date: Tue, 6 Feb 2024 20:17:41 +0800
From: kernel test robot <lkp@intel.com>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>, keescook@chromium.org,
	tony.luck@intel.com, gpiccoli@igalia.com, shuah@kernel.org,
	corbet@lwn.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	xlpang@linux.alibaba.com, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>,
	Xingrui Yi <yixingrui@linux.alibaba.com>
Subject: Re: [PATCH 1/3] pstore: add multi-backend support
Message-ID: <202402062036.5FPFKsGI-lkp@intel.com>
References: <20240205122852.7069-2-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240205122852.7069-2-xiangzao@linux.alibaba.com>

Hi Yuanhe,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on kees/for-next/kspp shuah-kselftest/next shuah-kselftest/fixes linus/master v6.8-rc3 next-20240206]
[cannot apply to aegl/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuanhe-Shu/pstore-add-multi-backend-support/20240205-203438
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
patch link:    https://lore.kernel.org/r/20240205122852.7069-2-xiangzao%40linux.alibaba.com
patch subject: [PATCH 1/3] pstore: add multi-backend support
config: i386-buildonly-randconfig-004-20240206 (https://download.01.org/0day-ci/archive/20240206/202402062036.5FPFKsGI-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240206/202402062036.5FPFKsGI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402062036.5FPFKsGI-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/pstore/ftrace.c:30:19: warning: declaration of 'struct ftrace_info' will not be visible outside of this function [-Wvisibility]
      30 |                                        struct ftrace_info *psinfo)
         |                                               ^
>> fs/pstore/ftrace.c:39:10: error: incompatible pointer types initializing 'struct pstore_info *' with an expression of type 'struct ftrace_info *' [-Werror,-Wincompatible-pointer-types]
      39 |                 .psi = psinfo,
         |                        ^~~~~~
>> fs/pstore/ftrace.c:55:8: error: incomplete definition of type 'struct ftrace_info'
      55 |         psinfo->write(&record);
         |         ~~~~~~^
   fs/pstore/ftrace.c:30:19: note: forward declaration of 'struct ftrace_info'
      30 |                                        struct ftrace_info *psinfo)
         |                                               ^
>> fs/pstore/ftrace.c:71:40: error: incompatible pointer types passing 'struct pt_regs *' to parameter of type 'struct ftrace_regs *' [-Werror,-Wincompatible-pointer-types]
      71 |                         pstore_do_ftrace(ip, parent_ip, op, regs, entry->psi);
         |                                                             ^~~~
   fs/pstore/ftrace.c:29:32: note: passing argument to parameter 'fregs' here
      29 |                                        struct ftrace_regs *fregs,
         |                                                            ^
>> fs/pstore/ftrace.c:71:46: error: incompatible pointer types passing 'struct pstore_info *' to parameter of type 'struct ftrace_info *' [-Werror,-Wincompatible-pointer-types]
      71 |                         pstore_do_ftrace(ip, parent_ip, op, regs, entry->psi);
         |                                                                   ^~~~~~~~~~
   fs/pstore/ftrace.c:30:32: note: passing argument to parameter 'psinfo' here
      30 |                                        struct ftrace_info *psinfo)
         |                                                            ^
>> fs/pstore/ftrace.c:76:10: error: incompatible function pointer types initializing 'ftrace_func_t' (aka 'void (*)(unsigned long, unsigned long, struct ftrace_ops *, struct ftrace_regs *)') with an expression of type 'void (unsigned long, unsigned long, struct ftrace_ops *, struct pt_regs *)' [-Wincompatible-function-pointer-types]
      76 |         .func   = pstore_ftrace_call,
         |                   ^~~~~~~~~~~~~~~~~~
>> fs/pstore/ftrace.c:150:26: error: use of undeclared identifier 'entry'
     150 |         list_for_each_entry_rcu(entry, &psback->list_entry, list)
         |                                 ^
>> fs/pstore/ftrace.c:150:26: error: use of undeclared identifier 'entry'
>> fs/pstore/ftrace.c:150:26: error: use of undeclared identifier 'entry'
>> fs/pstore/ftrace.c:150:26: error: use of undeclared identifier 'entry'
>> fs/pstore/ftrace.c:150:26: error: use of undeclared identifier 'entry'
>> fs/pstore/ftrace.c:150:26: error: use of undeclared identifier 'entry'
>> fs/pstore/ftrace.c:150:26: error: use of undeclared identifier 'entry'
>> fs/pstore/ftrace.c:150:26: error: use of undeclared identifier 'entry'
>> fs/pstore/ftrace.c:150:26: error: use of undeclared identifier 'entry'
>> fs/pstore/ftrace.c:150:26: error: use of undeclared identifier 'entry'
>> fs/pstore/ftrace.c:150:26: error: use of undeclared identifier 'entry'
>> fs/pstore/ftrace.c:150:2: error: operand of type 'void' where arithmetic or pointer type is required
     150 |         list_for_each_entry_rcu(entry, &psback->list_entry, list)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:393:9: note: expanded from macro 'list_for_each_entry_rcu'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:307:2: note: expanded from macro 'list_entry_rcu'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:19:25: note: expanded from macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                ^~~~~
>> fs/pstore/ftrace.c:150:26: error: use of undeclared identifier 'entry'
     150 |         list_for_each_entry_rcu(entry, &psback->list_entry, list)
         |                                 ^
>> fs/pstore/ftrace.c:150:26: error: use of undeclared identifier 'entry'
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   1 warning and 20 errors generated.


vim +39 fs/pstore/ftrace.c

fbccdeb8d77d68 Joel Fernandes          2016-10-20   25  
7b968e55e3984c Yuanhe Shu              2024-02-05   26  static void notrace pstore_do_ftrace(unsigned long ip,
ebacfd1ece3bfa Anton Vorontsov         2012-11-14   27  				       unsigned long parent_ip,
ebacfd1ece3bfa Anton Vorontsov         2012-11-14   28  				       struct ftrace_ops *op,
7b968e55e3984c Yuanhe Shu              2024-02-05   29  				       struct ftrace_regs *fregs,
7b968e55e3984c Yuanhe Shu              2024-02-05   30  				       struct ftrace_info *psinfo)
060287b8c467bf Anton Vorontsov         2012-07-09   31  {
6cdf941871ec9c Steven Rostedt (VMware  2020-11-05   32) 	int bit;
65f8c95e46a182 Anton Vorontsov         2012-07-17   33  	unsigned long flags;
060287b8c467bf Anton Vorontsov         2012-07-09   34  	struct pstore_ftrace_record rec = {};
b10b471145f28c Kees Cook               2017-03-05   35  	struct pstore_record record = {
b10b471145f28c Kees Cook               2017-03-05   36  		.type = PSTORE_TYPE_FTRACE,
b10b471145f28c Kees Cook               2017-03-05   37  		.buf = (char *)&rec,
b10b471145f28c Kees Cook               2017-03-05   38  		.size = sizeof(rec),
b10b471145f28c Kees Cook               2017-03-05  @39  		.psi = psinfo,
b10b471145f28c Kees Cook               2017-03-05   40  	};
060287b8c467bf Anton Vorontsov         2012-07-09   41  
060287b8c467bf Anton Vorontsov         2012-07-09   42  	if (unlikely(oops_in_progress))
060287b8c467bf Anton Vorontsov         2012-07-09   43  		return;
060287b8c467bf Anton Vorontsov         2012-07-09   44  
773c16705058e9 Steven Rostedt (VMware  2020-11-05   45) 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
6cdf941871ec9c Steven Rostedt (VMware  2020-11-05   46) 	if (bit < 0)
6cdf941871ec9c Steven Rostedt (VMware  2020-11-05   47) 		return;
6cdf941871ec9c Steven Rostedt (VMware  2020-11-05   48) 
65f8c95e46a182 Anton Vorontsov         2012-07-17   49  	local_irq_save(flags);
65f8c95e46a182 Anton Vorontsov         2012-07-17   50  
060287b8c467bf Anton Vorontsov         2012-07-09   51  	rec.ip = ip;
060287b8c467bf Anton Vorontsov         2012-07-09   52  	rec.parent_ip = parent_ip;
fbccdeb8d77d68 Joel Fernandes          2016-10-20   53  	pstore_ftrace_write_timestamp(&rec, pstore_ftrace_stamp++);
060287b8c467bf Anton Vorontsov         2012-07-09   54  	pstore_ftrace_encode_cpu(&rec, raw_smp_processor_id());
4c9ec219766a21 Kees Cook               2017-03-05  @55  	psinfo->write(&record);
65f8c95e46a182 Anton Vorontsov         2012-07-17   56  
65f8c95e46a182 Anton Vorontsov         2012-07-17   57  	local_irq_restore(flags);
6cdf941871ec9c Steven Rostedt (VMware  2020-11-05   58) 	ftrace_test_recursion_unlock(bit);
65f8c95e46a182 Anton Vorontsov         2012-07-17   59  }
65f8c95e46a182 Anton Vorontsov         2012-07-17   60  
7b968e55e3984c Yuanhe Shu              2024-02-05   61  static void notrace pstore_ftrace_call(unsigned long ip,
7b968e55e3984c Yuanhe Shu              2024-02-05   62  				       unsigned long parent_ip,
7b968e55e3984c Yuanhe Shu              2024-02-05   63  				       struct ftrace_ops *op,
7b968e55e3984c Yuanhe Shu              2024-02-05   64  				       struct pt_regs *regs)
7b968e55e3984c Yuanhe Shu              2024-02-05   65  {
7b968e55e3984c Yuanhe Shu              2024-02-05   66  	struct pstore_info_list *entry;
7b968e55e3984c Yuanhe Shu              2024-02-05   67  
7b968e55e3984c Yuanhe Shu              2024-02-05   68  	rcu_read_lock();
7b968e55e3984c Yuanhe Shu              2024-02-05   69  	list_for_each_entry_rcu(entry, &psback->list_entry, list)
7b968e55e3984c Yuanhe Shu              2024-02-05   70  		if (entry->psi->flags & PSTORE_FLAGS_FTRACE)
7b968e55e3984c Yuanhe Shu              2024-02-05  @71  			pstore_do_ftrace(ip, parent_ip, op, regs, entry->psi);
7b968e55e3984c Yuanhe Shu              2024-02-05   72  	rcu_read_unlock();
7b968e55e3984c Yuanhe Shu              2024-02-05   73  }
7b968e55e3984c Yuanhe Shu              2024-02-05   74  
65f8c95e46a182 Anton Vorontsov         2012-07-17   75  static struct ftrace_ops pstore_ftrace_ops __read_mostly = {
65f8c95e46a182 Anton Vorontsov         2012-07-17  @76  	.func	= pstore_ftrace_call,
65f8c95e46a182 Anton Vorontsov         2012-07-17   77  };
65f8c95e46a182 Anton Vorontsov         2012-07-17   78  
65f8c95e46a182 Anton Vorontsov         2012-07-17   79  static DEFINE_MUTEX(pstore_ftrace_lock);
65f8c95e46a182 Anton Vorontsov         2012-07-17   80  static bool pstore_ftrace_enabled;
65f8c95e46a182 Anton Vorontsov         2012-07-17   81  
a5d05b07961a2d Uwe Kleine-König        2021-06-10   82  static int pstore_set_ftrace_enabled(bool on)
65f8c95e46a182 Anton Vorontsov         2012-07-17   83  {
65f8c95e46a182 Anton Vorontsov         2012-07-17   84  	ssize_t ret;
65f8c95e46a182 Anton Vorontsov         2012-07-17   85  
a5d05b07961a2d Uwe Kleine-König        2021-06-10   86  	if (on == pstore_ftrace_enabled)
a5d05b07961a2d Uwe Kleine-König        2021-06-10   87  		return 0;
65f8c95e46a182 Anton Vorontsov         2012-07-17   88  
7a0032f50472c7 Joel Fernandes          2016-11-15   89  	if (on) {
7a0032f50472c7 Joel Fernandes          2016-11-15   90  		ftrace_ops_set_global_filter(&pstore_ftrace_ops);
65f8c95e46a182 Anton Vorontsov         2012-07-17   91  		ret = register_ftrace_function(&pstore_ftrace_ops);
7a0032f50472c7 Joel Fernandes          2016-11-15   92  	} else {
65f8c95e46a182 Anton Vorontsov         2012-07-17   93  		ret = unregister_ftrace_function(&pstore_ftrace_ops);
7a0032f50472c7 Joel Fernandes          2016-11-15   94  	}
7a0032f50472c7 Joel Fernandes          2016-11-15   95  
65f8c95e46a182 Anton Vorontsov         2012-07-17   96  	if (ret) {
65f8c95e46a182 Anton Vorontsov         2012-07-17   97  		pr_err("%s: unable to %sregister ftrace ops: %zd\n",
65f8c95e46a182 Anton Vorontsov         2012-07-17   98  		       __func__, on ? "" : "un", ret);
a5d05b07961a2d Uwe Kleine-König        2021-06-10   99  	} else {
a5d05b07961a2d Uwe Kleine-König        2021-06-10  100  		pstore_ftrace_enabled = on;
65f8c95e46a182 Anton Vorontsov         2012-07-17  101  	}
65f8c95e46a182 Anton Vorontsov         2012-07-17  102  
a5d05b07961a2d Uwe Kleine-König        2021-06-10  103  	return ret;
a5d05b07961a2d Uwe Kleine-König        2021-06-10  104  }
a5d05b07961a2d Uwe Kleine-König        2021-06-10  105  
a5d05b07961a2d Uwe Kleine-König        2021-06-10  106  static ssize_t pstore_ftrace_knob_write(struct file *f, const char __user *buf,
a5d05b07961a2d Uwe Kleine-König        2021-06-10  107  					size_t count, loff_t *ppos)
a5d05b07961a2d Uwe Kleine-König        2021-06-10  108  {
a5d05b07961a2d Uwe Kleine-König        2021-06-10  109  	u8 on;
a5d05b07961a2d Uwe Kleine-König        2021-06-10  110  	ssize_t ret;
a5d05b07961a2d Uwe Kleine-König        2021-06-10  111  
a5d05b07961a2d Uwe Kleine-König        2021-06-10  112  	ret = kstrtou8_from_user(buf, count, 2, &on);
a5d05b07961a2d Uwe Kleine-König        2021-06-10  113  	if (ret)
a5d05b07961a2d Uwe Kleine-König        2021-06-10  114  		return ret;
a5d05b07961a2d Uwe Kleine-König        2021-06-10  115  
a5d05b07961a2d Uwe Kleine-König        2021-06-10  116  	mutex_lock(&pstore_ftrace_lock);
a5d05b07961a2d Uwe Kleine-König        2021-06-10  117  	ret = pstore_set_ftrace_enabled(on);
65f8c95e46a182 Anton Vorontsov         2012-07-17  118  	mutex_unlock(&pstore_ftrace_lock);
65f8c95e46a182 Anton Vorontsov         2012-07-17  119  
a5d05b07961a2d Uwe Kleine-König        2021-06-10  120  	if (ret == 0)
a5d05b07961a2d Uwe Kleine-König        2021-06-10  121  		ret = count;
a5d05b07961a2d Uwe Kleine-König        2021-06-10  122  
65f8c95e46a182 Anton Vorontsov         2012-07-17  123  	return ret;
65f8c95e46a182 Anton Vorontsov         2012-07-17  124  }
65f8c95e46a182 Anton Vorontsov         2012-07-17  125  
65f8c95e46a182 Anton Vorontsov         2012-07-17  126  static ssize_t pstore_ftrace_knob_read(struct file *f, char __user *buf,
65f8c95e46a182 Anton Vorontsov         2012-07-17  127  				       size_t count, loff_t *ppos)
65f8c95e46a182 Anton Vorontsov         2012-07-17  128  {
65f8c95e46a182 Anton Vorontsov         2012-07-17  129  	char val[] = { '0' + pstore_ftrace_enabled, '\n' };
65f8c95e46a182 Anton Vorontsov         2012-07-17  130  
65f8c95e46a182 Anton Vorontsov         2012-07-17  131  	return simple_read_from_buffer(buf, count, ppos, val, sizeof(val));
65f8c95e46a182 Anton Vorontsov         2012-07-17  132  }
65f8c95e46a182 Anton Vorontsov         2012-07-17  133  
65f8c95e46a182 Anton Vorontsov         2012-07-17  134  static const struct file_operations pstore_knob_fops = {
65f8c95e46a182 Anton Vorontsov         2012-07-17  135  	.open	= simple_open,
65f8c95e46a182 Anton Vorontsov         2012-07-17  136  	.read	= pstore_ftrace_knob_read,
65f8c95e46a182 Anton Vorontsov         2012-07-17  137  	.write	= pstore_ftrace_knob_write,
65f8c95e46a182 Anton Vorontsov         2012-07-17  138  };
65f8c95e46a182 Anton Vorontsov         2012-07-17  139  
ee1d267423a1f8 Geliang Tang            2015-10-20  140  static struct dentry *pstore_ftrace_dir;
ee1d267423a1f8 Geliang Tang            2015-10-20  141  
a5d05b07961a2d Uwe Kleine-König        2021-06-10  142  static bool record_ftrace;
a5d05b07961a2d Uwe Kleine-König        2021-06-10  143  module_param(record_ftrace, bool, 0400);
a5d05b07961a2d Uwe Kleine-König        2021-06-10  144  MODULE_PARM_DESC(record_ftrace,
a5d05b07961a2d Uwe Kleine-König        2021-06-10  145  		 "enable ftrace recording immediately (default: off)");
a5d05b07961a2d Uwe Kleine-König        2021-06-10  146  
65f8c95e46a182 Anton Vorontsov         2012-07-17  147  void pstore_register_ftrace(void)
65f8c95e46a182 Anton Vorontsov         2012-07-17  148  {
7b968e55e3984c Yuanhe Shu              2024-02-05  149  	rcu_read_lock();
7b968e55e3984c Yuanhe Shu              2024-02-05 @150  	list_for_each_entry_rcu(entry, &psback->list_entry, list)
7b968e55e3984c Yuanhe Shu              2024-02-05  151  		if (entry->psi->flags & PSTORE_FLAGS_FTRACE)
7b968e55e3984c Yuanhe Shu              2024-02-05  152  			if (!entry->psi->write) {
7b968e55e3984c Yuanhe Shu              2024-02-05  153  				rcu_read_unlock();
65f8c95e46a182 Anton Vorontsov         2012-07-17  154  				return;
7b968e55e3984c Yuanhe Shu              2024-02-05  155  			}
7b968e55e3984c Yuanhe Shu              2024-02-05  156  	rcu_read_unlock();
65f8c95e46a182 Anton Vorontsov         2012-07-17  157  
ee1d267423a1f8 Geliang Tang            2015-10-20  158  	pstore_ftrace_dir = debugfs_create_dir("pstore", NULL);
65f8c95e46a182 Anton Vorontsov         2012-07-17  159  
a5d05b07961a2d Uwe Kleine-König        2021-06-10  160  	pstore_set_ftrace_enabled(record_ftrace);
a5d05b07961a2d Uwe Kleine-König        2021-06-10  161  
fa1af7583e8012 Greg Kroah-Hartman      2019-06-12  162  	debugfs_create_file("record_ftrace", 0600, pstore_ftrace_dir, NULL,
fa1af7583e8012 Greg Kroah-Hartman      2019-06-12  163  			    &pstore_knob_fops);
ee1d267423a1f8 Geliang Tang            2015-10-20  164  }
ee1d267423a1f8 Geliang Tang            2015-10-20  165  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

