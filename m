Return-Path: <linux-kselftest+bounces-395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A09C77F3B09
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 02:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729ADB2157C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 01:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EC615B1;
	Wed, 22 Nov 2023 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bo6hEHqa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED889D45;
	Tue, 21 Nov 2023 17:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700615331; x=1732151331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2+fdHO12ohmJATutgg6iYR9BqC3ibMl5puCl9Ejbv/A=;
  b=bo6hEHqaN0PpPwbSoi/V9yDaE+aXbKy3t4JjpG/mxhxFs/ACMZ8lg8Lh
   YVcFlXR2SbpLaHvPCSEsmu0WdO0K9oxgcTxtTyW1Np8aP0mxLfjhQxpti
   22jbDHjb3VknFEG1QpG21uF7rSIR6VaZZu0n4eX1wWg2wSaRdToRbMkL6
   S9LMDehBL9yaGNa8cCHCCJBXYvvh2X9PPO6d34+CP/CSE1giwl6Qtdhj0
   x6BW7dfZ72l1I3SKI49OLnxnjW/OsuiXXppqUMQ2dMQGN99Y2qIowAk3L
   DnQKmZ4wE+A/UQkls48IcoNzDxCkA45z0C1nIq7XcplVzWt5MOIl8pDH3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5154722"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="5154722"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 17:08:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="801726701"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="801726701"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Nov 2023 17:08:43 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5bjM-0008Tj-2M;
	Wed, 22 Nov 2023 01:08:40 +0000
Date: Wed, 22 Nov 2023 09:08:06 +0800
From: kernel test robot <lkp@intel.com>
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
	workflows@vger.kernel.org, Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Veronika Kabatova <vkabatov@redhat.com>,
	CKI <cki-project@redhat.com>, kernelci@lists.linux.dev,
	Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Message-ID: <202311220843.vh7WyxDF-lkp@intel.com>
References: <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>

Hi Nikolai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikolai-Kondrashov/MAINTAINERS-Introduce-V-field-for-required-tests/20231116-015419
base:   linus/master
patch link:    https://lore.kernel.org/r/20231115175146.9848-2-Nikolai.Kondrashov%40redhat.com
patch subject: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311220843.vh7WyxDF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220843.vh7WyxDF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/process/tests.rst: WARNING: document isn't included in any toctree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

