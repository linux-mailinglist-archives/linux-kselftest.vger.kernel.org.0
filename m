Return-Path: <linux-kselftest+bounces-1154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA40980597B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1302A1C2112D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F0963DED;
	Tue,  5 Dec 2023 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Scb8CJZR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6CDBA;
	Tue,  5 Dec 2023 08:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701792354; x=1733328354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o9heeCnQAsdaiKjUskI2g/hhm4Nd3ui2lad9PWcZgjQ=;
  b=Scb8CJZRtKeYBx9gKlD+T87KjctZnjavrcP/GEJTBheo0MKdQtDB9vED
   VcY3DkJRiLY11Gi37j76SFwgY3j0jAeELP+fiYDMBw0izt9xHUe6CTBF2
   7CUt1zFTXcu1vOopxyBONKbTqMQx2nTdxL072dp1+otoWrv/8caev/Dja
   4285TtNZl2+xsqT10TUpJzJZVP/V182rrwdRpHkkk5rXE8XmVzCe9JHHk
   YDuiJ+0raim638rGnhN4B9PYNroSBvzAay3PMxB6mjILKSvoPGn1gvOXw
   PEA92+MO24/hwEsqT2bZM2NNGtsgbhsTMgLuIMIYAx0UnvnRMMPoBWQKI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="425071433"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="425071433"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:05:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="720754059"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="720754059"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Dec 2023 08:05:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAXvb-0009Io-1x;
	Tue, 05 Dec 2023 16:05:43 +0000
Date: Wed, 6 Dec 2023 00:05:04 +0800
From: kernel test robot <lkp@intel.com>
To: davidgow@google.com, Rae Moar <rmoar@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-sound@vger.kernel.org, David Gow <davidgow@google.com>
Subject: Re: [PATCH 1/4] kunit: Add APIs for managing devices
Message-ID: <202312052341.fEujgbbC-lkp@intel.com>
References: <20231205-kunit_bus-v1-1-635036d3bc13@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205-kunit_bus-v1-1-635036d3bc13@google.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on c8613be119892ccceffbc550b9b9d7d68b995c9e]

url:    https://github.com/intel-lab-lkp/linux/commits/davidgow-google-com/kunit-Add-APIs-for-managing-devices/20231205-153349
base:   c8613be119892ccceffbc550b9b9d7d68b995c9e
patch link:    https://lore.kernel.org/r/20231205-kunit_bus-v1-1-635036d3bc13%40google.com
patch subject: [PATCH 1/4] kunit: Add APIs for managing devices
config: x86_64-buildonly-randconfig-001-20231205 (https://download.01.org/0day-ci/archive/20231205/202312052341.fEujgbbC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312052341.fEujgbbC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312052341.fEujgbbC-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: lib/kunit/device.o: in function `kunit_bus_init':
>> device.c:(.text+0x40): multiple definition of `init_module'; lib/kunit/test.o:test.c:(.init.text+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

