Return-Path: <linux-kselftest+bounces-2414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317F881D292
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Dec 2023 06:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639B41C22A0B
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Dec 2023 05:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396554C6C;
	Sat, 23 Dec 2023 05:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ie+2b/gp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26064A15;
	Sat, 23 Dec 2023 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703310772; x=1734846772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mR6DxwvAt72xJ96TjpuhNN30KdwobyHTaKeVNeYuZAQ=;
  b=Ie+2b/gpXrUKMr3CYLr9hteMtjyzKL1U0je0yDU+E0JJrc4ASRHJ7UEr
   1i7J4AqwErVe/WMFkdhwDzlzwvR1GL+XXDjKZDFYrJJLEe4hbZowpUF5N
   WmuqR2DkaFEgv/yRZc/IM1JzZNEdkFyBDuvUNF5DxCglK6kGTNsjrnBSc
   ms+QmbliwlxQERt0IiwpCtAHP8cFE+JkyGgyAUwT4GSLYbUcoWCSlmgN8
   vjd/2r5vd6YFGgdjGQYV6TXPkBsSnR7aV/NsdySVENPEPQhQU4FzaPpVy
   bUmxLIWddp5Z5bu79LYqsMunfqfeX4L+5GfwHUgPC6k8y6SijYhX0/8Lr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="9676430"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="9676430"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 21:52:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="780802163"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="780802163"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 22 Dec 2023 21:52:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGuwC-000ALd-20;
	Sat, 23 Dec 2023 05:52:43 +0000
Date: Sat, 23 Dec 2023 13:52:35 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next 3/3] selftests/net: fix GRO coalesce test and
 add ext
Message-ID: <202312231344.sWSs5PIk-lkp@intel.com>
References: <641157c0-f224-4910-874d-7906a48d914b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <641157c0-f224-4910-874d-7906a48d914b@gmail.com>

Hi Richard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Gobert/net-gso-add-HBH-extension-header-offload-support/20231222-172059
base:   net-next/main
patch link:    https://lore.kernel.org/r/641157c0-f224-4910-874d-7906a48d914b%40gmail.com
patch subject: [PATCH net-next 3/3] selftests/net: fix GRO coalesce test and add ext
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312231344.sWSs5PIk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312231344.sWSs5PIk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   gro.c: In function 'add_ipv6_exthdr':
>> gro.c:600:13: warning: variable 'opt_len' set but not used [-Wunused-but-set-variable]
     600 |         int opt_len;
         |             ^~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

