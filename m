Return-Path: <linux-kselftest+bounces-22463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B645B9D657A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 22:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40337161604
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 21:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4B918A95F;
	Fri, 22 Nov 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cs79Hq9H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDFF189909;
	Fri, 22 Nov 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732312531; cv=none; b=Kr8TBfkqNdPv2IZYD9dspgNsG1qxcIjoCdG8FGLOQu84EAD/NieWf7hgzuspFtSRsuktx2GfSDHdatgI6GzLUdie/5IgWxERRU4QvPvU572I9a0eVwVjSQr4WBVjKNVzJBKQNtqgnozK0cSKPQ+QJ+skNlMpxHZivJ47LhihBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732312531; c=relaxed/simple;
	bh=zMvZOh4mv+a4NTtfO7dqFehA1bW86WK/ItpOwTN62Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cct7wzVqkX9RmWpo8JmLN0MBWz/znHKbad19oIG7SXm4Bv89Q1qrfhsep8nRDjMa9BmgQGlftmrUb3onP2f7tdtNzsLXmYbXI2RjcdcFIN0DKXZXda/CjKScAJr/Kuy5zaYNMtdsbC/UytjVTC88IJkocgSU8ceOZbbezrXuyFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cs79Hq9H; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732312530; x=1763848530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zMvZOh4mv+a4NTtfO7dqFehA1bW86WK/ItpOwTN62Q8=;
  b=cs79Hq9HxnWktC6EPr6EN9j49SyjGX4Oo910KfL6lTkX6ncJuN2M+dSW
   7YmLQNTHo3hxWrJKT3ElWU1b0Yrk6bJeKuYAgUXYktgbEFyQfRxlUzgde
   8EXVv+bZ+A29NdP+1yRif5NCpAIvHFDD0oK1qBfUi3WIZVsANGBaBPQKd
   OoeICPnb4I3lowM7pPrgELL81qAbTeDtLwA98xiCMEVllTtNLcM4Im07b
   TUqnlEo6zaZYe3uvQU+lVsHxqe74V+jjd3z0GN3FgGT+y2X6J9+ywG7oc
   vzmxiZAmqIIkwD7XV2R02RDFJrdjQbUwsH4M8baK8ZRSJnpUtFvR14/Eu
   g==;
X-CSE-ConnectionGUID: 96M3E1fxTje+NAbwdej0GA==
X-CSE-MsgGUID: RQEzcmGcT2O8LQyTo2zB2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="36144819"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="36144819"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:55:29 -0800
X-CSE-ConnectionGUID: ld2UHzmMQtq5CpVHeOKkKA==
X-CSE-MsgGUID: JObgL+cKSQKI/zYkB0c+gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95627190"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 Nov 2024 13:55:24 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEbcX-0004Ep-0f;
	Fri, 22 Nov 2024 21:55:21 +0000
Date: Sat, 23 Nov 2024 05:54:44 +0800
From: kernel test robot <lkp@intel.com>
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Thomas =?unknown-8bit?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	Alice Ryhl <aliceryhl@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jens Axboe <axboe@kernel.dk>, Mark Rutland <mark.rutland@arm.com>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH printk v1] printk: ringbuffer: Add KUnit test
Message-ID: <202411230506.L5KQdiGm-lkp@intel.com>
References: <20241121145034.123367-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121145034.123367-1-john.ogness@linutronix.de>

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on rust/rust-next]
[also build test ERROR on linus/master v6.12 next-20241122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ogness/printk-ringbuffer-Add-KUnit-test/20241121-225731
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/20241121145034.123367-1-john.ogness%40linutronix.de
patch subject: [PATCH printk v1] printk: ringbuffer: Add KUnit test
config: i386-randconfig-141-20241122 (https://download.01.org/0day-ci/archive/20241123/202411230506.L5KQdiGm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241123/202411230506.L5KQdiGm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411230506.L5KQdiGm-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivdi3" [kernel/printk/printk_ringbuffer_test.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

