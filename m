Return-Path: <linux-kselftest+bounces-2957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2741782D376
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 04:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4EDB20CAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 03:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DEB187F;
	Mon, 15 Jan 2024 03:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMSAOjlS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E90186A;
	Mon, 15 Jan 2024 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705290461; x=1736826461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cpCFBsSH/4SlXTqGSHw0GnglPpDmXBuS/gJX+HbsERc=;
  b=DMSAOjlSb0sI+XfQbFXvPU/HrLAXXadm2Cqc8+ajdhe+y8UYLQ/rShcS
   oiOjy3poAkkkwd91rDwu0Yu9//TJ6fUGWj1k2wRj74GOjW1LZgb38sR7j
   iVm48M04iGO35A/LIUXggMGET3ImZ1ra/KSCA5cRG93IVykzPsG2Idnz+
   MlWiWSk5o99+S9cP5OhMCqRW2qQGvczAknM+Tfw1dKfG3Gtvq4FnwR13R
   UqPkqaARrveXh4Zb7RIERUGXSslwnzi2OYkJfvoilz34mwVfK8/DOlS5o
   DFWPa0ilcm42F0bX47F1kb/bwMLim8AiMyDyNqVvG1CXURe00WMBBG//s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6284464"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="6284464"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 19:47:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="776608748"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="776608748"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Jan 2024 19:47:36 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPDwZ-000C5o-0T;
	Mon, 15 Jan 2024 03:47:26 +0000
Date: Mon, 15 Jan 2024 11:46:04 +0800
From: kernel test robot <lkp@intel.com>
To: Hu Yadi <hu.yadi@h3c.com>, jmorris@namei.org, serge@hallyn.com,
	shuah@kernel.org, mathieu.desnoyers@efficios.com, mic@digikod.net
Cc: oe-kbuild-all@lists.linux.dev, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, 514118380@qq.com,
	"Hu.Yadi" <hu.yadi@h3c.com>
Subject: Re: [PATCH v3] selftests/landlock:Fix two build issues
Message-ID: <202401151147.T1s11iHJ-lkp@intel.com>
References: <20240112071245.669-1-hu.yadi@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112071245.669-1-hu.yadi@h3c.com>

Hi Hu,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hu-Yadi/selftests-landlock-Fix-two-build-issues/20240112-151805
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20240112071245.669-1-hu.yadi%40h3c.com
patch subject: [PATCH v3] selftests/landlock:Fix two build issues
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240115/202401151147.T1s11iHJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401151147.T1s11iHJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net_test.c:25:14: error: static declaration of 'gettid' follows non-static declaration
      25 | static pid_t gettid(void)
         |              ^~~~~~
   In file included from /usr/include/unistd.h:1218,
                    from /usr/include/x86_64-linux-gnu/bits/sigstksz.h:24,
                    from /usr/include/signal.h:328,
                    from /usr/include/x86_64-linux-gnu/sys/wait.h:36,
                    from common.h:16,
                    from net_test.c:22:
   /usr/include/x86_64-linux-gnu/bits/unistd_ext.h:34:16: note: previous declaration of 'gettid' with type '__pid_t(void)' {aka 'int(void)'}
      34 | extern __pid_t gettid (void) __THROW;
         |                ^~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

