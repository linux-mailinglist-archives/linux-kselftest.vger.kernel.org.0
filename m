Return-Path: <linux-kselftest+bounces-20188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75709A4B02
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 04:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FA41C20C59
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 02:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30261CCB27;
	Sat, 19 Oct 2024 02:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oe/7in0O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E261CC88D;
	Sat, 19 Oct 2024 02:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729306286; cv=none; b=Ws+3o5xb7sZXwMzDynDihx1B9Uj819pG6M/mGhUTa2KLd7h8avD7VrJdmeuUoPbduHUlIua9lsAt5e4opyR15fkK4CIkiuLRYia3vpWsE54ML2etExwJsmKis1VpLCc2JWYFMHtjz/HRAsS7JW2506ACTGi0zOF7bkdhB1BmELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729306286; c=relaxed/simple;
	bh=0zSB8vXur4XDPcBJSsROa06yuMfwtiCjG5gslnBgxMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFKy2A9WBzVosxOGzIRiWgbmlkuw+YGJMT/9g4zhXq1AbYyhqZCbxG2m0+X3YTx60GfrSWttY2J9sqxzrDrzr1BTXXe0dBSQrV4iKAjlMzBEizr5yzOt4h6U9H0k9vaqRHc5ZzQEnOB/IMGhz7wfOgmGcsN+mMk94EB9GqQdhRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oe/7in0O; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729306285; x=1760842285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0zSB8vXur4XDPcBJSsROa06yuMfwtiCjG5gslnBgxMY=;
  b=Oe/7in0OGFmFNmj2EcSX8IbaqaPPCuB+eIAeZG3MPpWMylsgAehJCCvh
   f54ETQmLRF1GnSUCHpwvXN7lkLcYjO83WLxSQIfEMZD3puyYMWDvDVwVI
   uAWRFTJ3ve26Qx2XWOJZ7nsBarQ3BR/b3ViisPEBnjOOzffK67KzWZxhj
   RZA664rRAbqRoFlg908GkbwUVxPBsN+JR3gRI7p4BpfOZPCL9UkPBCD/X
   kPTghHYZCzghZm+HZ1cuAYhe8gSmSQ4WntEyr92jsKOPy1m3s+R7uwUKv
   wlafYHXdU/e6sMGJ7C5UACmBLpSDVwBKEWAaqxu1i5ZtJICHewe7azYMW
   g==;
X-CSE-ConnectionGUID: djFH5ADgTu6ZC4iN+kb6kA==
X-CSE-MsgGUID: 83UHn8ZxQuSActXgoF5kIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29011052"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29011052"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 19:51:24 -0700
X-CSE-ConnectionGUID: qAwpvV+cSraBHH8n9v98Wg==
X-CSE-MsgGUID: OY1W/BkoTriJ4nD1ZP6RKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="83604768"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Oct 2024 19:51:18 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1zYi-000Ocb-2R;
	Sat, 19 Oct 2024 02:51:16 +0000
Date: Sat, 19 Oct 2024 10:51:05 +0800
From: kernel test robot <lkp@intel.com>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>, davem@davemloft.net,
	Liam.Howlett@oracle.com
Cc: oe-kbuild-all@lists.linux.dev, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, jiri@resnulli.us,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	akpm@linux-foundation.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, anjali.k.kulkarni@oracle.com,
	peili.io@oracle.com
Subject: Re: [PATCH net-next v5 2/3] connector/cn_proc: Kunit tests for
 threads hash table
Message-ID: <202410191051.p3iFT9om-lkp@intel.com>
References: <20241017181436.2047508-3-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017181436.2047508-3-anjali.k.kulkarni@oracle.com>

Hi Anjali,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Anjali-Kulkarni/connector-cn_proc-Add-hash-table-for-threads/20241018-021755
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241017181436.2047508-3-anjali.k.kulkarni%40oracle.com
patch subject: [PATCH net-next v5 2/3] connector/cn_proc: Kunit tests for threads hash table
config: x86_64-randconfig-104-20241019 (https://download.01.org/0day-ci/archive/20241019/202410191051.p3iFT9om-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241019/202410191051.p3iFT9om-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410191051.p3iFT9om-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in mm/kasan/kasan_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/slub_kunit.o
>> ERROR: modpost: "cn_del_get_exval" [lib/cn_hash_test.ko] undefined!
>> ERROR: modpost: "cn_table_empty" [lib/cn_hash_test.ko] undefined!
>> ERROR: modpost: "cn_display_hlist" [lib/cn_hash_test.ko] undefined!
>> ERROR: modpost: "cn_add_elem" [lib/cn_hash_test.ko] undefined!
>> ERROR: modpost: "cn_get_exval" [lib/cn_hash_test.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

