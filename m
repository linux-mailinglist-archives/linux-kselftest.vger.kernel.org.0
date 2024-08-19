Return-Path: <linux-kselftest+bounces-15640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429CE956AF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 14:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E371C21B97
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 12:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1716A920;
	Mon, 19 Aug 2024 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmLP1ALG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933B116A399
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070886; cv=none; b=TZlTl/GndG8PdfxbuA1ELQMH7xv0MVbueHoaq7K/Gk8u/wv7hlHO28OV5DYJacZ3vNNTjLMMdDn1Wp9JeXntFdgIW98CbahTJ5WFQ8+8GBDmH4kKmkO3w8rRTmYItWMethixkihDtcbsSBH1mG4VDdfeAQXjBtTdiL2RDGZJUAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070886; c=relaxed/simple;
	bh=FSBw0nDKyr+17jrVXlyQDZ8KK0OJv6v6h9/4uJd+mVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3aR6OLFN4D2QA2aR8IuA9l7tGF/Vd5G30SobgZJBoLG8FYyBoeQDB4SYdVSCgC+x4zs4bGAye5GMrqpd0PtTF8rdd8zTh+1lrLHcfAguW8mFggBLbo8WhatTbfFmNn+g36LxrY9hUQLxjnV8nypw5aiM+0xkQPw28CzcdptdgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmLP1ALG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724070884; x=1755606884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FSBw0nDKyr+17jrVXlyQDZ8KK0OJv6v6h9/4uJd+mVU=;
  b=kmLP1ALGi4mYOOWeBMz7UuFBZw6+JCJOV78b2Oc4r9jeHEe19mm0OBQT
   ABPYIU/Hv+WxfORd4ALSwCabXPxcqvkP+71zHxSVYL8+HSrbyALbwt6O2
   87r0izmR4XusPciH/qsP7j1q/bhgzZSCsn9w64l5IoTzmLNqOT6FmO7cn
   Q22FLBp7dx4Tsu62TL5QpeCf400U8KxKWdLs/iD16p4hOZ38Pm62a7fTQ
   SnzD/27RLS0a4PJy8bJx7gBh1VuzvoropjMGfiTiWT3x9VHIqeYTee3Oj
   Me8O7Tw6WcfVq8N2lKX339urGq3XAVjNGZRKaFu/87prfi+n6Ltywd4/w
   w==;
X-CSE-ConnectionGUID: vyX7zSrQS+q9hDFZnPDvDg==
X-CSE-MsgGUID: NiYS+RZvQ8iF5FApWqOxRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22450380"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22450380"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 05:34:44 -0700
X-CSE-ConnectionGUID: YPc5YmGOQL6kDegrSbl12w==
X-CSE-MsgGUID: UBRSh1UqR3m8Zu51AEFIRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="65314237"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 19 Aug 2024 05:34:42 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sg1ap-0008yk-15;
	Mon, 19 Aug 2024 12:34:39 +0000
Date: Mon, 19 Aug 2024 20:33:54 +0800
From: kernel test robot <lkp@intel.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc: oe-kbuild-all@lists.linux.dev,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] lib/math: Add int_pow test suite
Message-ID: <202408191958.Xq9SR93K-lkp@intel.com>
References: <20240819014115.221135-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819014115.221135-1-luis.hernandez093@gmail.com>

Hi Luis,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.11-rc4]
[also build test WARNING on linus/master next-20240819]
[cannot apply to akpm-mm/mm-nonmm-unstable]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luis-Felipe-Hernandez/lib-math-Add-int_pow-test-suite/20240819-094252
base:   v6.11-rc4
patch link:    https://lore.kernel.org/r/20240819014115.221135-1-luis.hernandez093%40gmail.com
patch subject: [PATCH v2] lib/math: Add int_pow test suite
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240819/202408191958.Xq9SR93K-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240819/202408191958.Xq9SR93K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408191958.Xq9SR93K-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/math/tests/int_pow_kunit.c:22:18: warning: integer constant is so large that it is unsigned
      22 |         { 2, 63, 9223372036854775808, "Large result"},
         |                  ^~~~~~~~~~~~~~~~~~~


vim +22 lib/math/tests/int_pow_kunit.c

    12	
    13	static const struct test_case_params params[] = {
    14		{ 64, 0, 1, "Power of zero" },
    15		{ 64, 1, 64, "Power of one"},
    16		{ 0, 5, 0, "Base zero" },
    17		{ 1, 64, 1, "Base one" },
    18		{ 2, 2, 4, "Two squared"},
    19		{ 2, 3, 8, "Two cubed"},
    20		{ 5, 5, 3125, "Five raised to the fith power" },
    21		{ U64_MAX, 1, U64_MAX, "Max base" },
  > 22		{ 2, 63, 9223372036854775808, "Large result"},
    23	};
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

