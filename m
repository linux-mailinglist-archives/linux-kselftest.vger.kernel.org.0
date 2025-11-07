Return-Path: <linux-kselftest+bounces-45054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8647CC3E61F
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 04:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36F954EBA91
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 03:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754602FB0BE;
	Fri,  7 Nov 2025 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2pH2a3F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E2227599;
	Fri,  7 Nov 2025 03:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486814; cv=none; b=DSReF6DxcNkljyzHaMXkIlQj+fnP5HPaTzB1LjPCtytLYYim1pqEBnZDMPxPZA9V2Fny+tmjbR4PMv+BrQdibn5oS0ueZUHQ5iqeGEyLxTCSVwFiOvav6hLwXpW7rOJun89+TEsukUj/D/roEdq+HNuyQU1mVHX2vpAPcVIcpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486814; c=relaxed/simple;
	bh=5mryAzNSONsN2Qp9qiKezJx2wYrwlgHNENlTmAdtyPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ux/vJlcfIKaNiQRjfan4ljIESUqDO6aZoQcE0NGnVFvK4RwWXBT5ASRSC+1fw/VOtPwX+A7DB0nLsK2mpE+JrwvfGGPe164JP2bKzREzW0WpR7lkfr9xRUK68CHOpaU5i+xoLMY57bLur83vvtcODEAhh+6eVRwZ+dVw/GH1q4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2pH2a3F; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762486813; x=1794022813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5mryAzNSONsN2Qp9qiKezJx2wYrwlgHNENlTmAdtyPY=;
  b=X2pH2a3FMjlmvD6xQ6KRjnhT1knlJs/joneAIsTumJfoLPxlm2gQnaGF
   JdWwy1xKG+Zf68fhqB0gQQBqCo88bnI+MZx33gLrw0+uILeGo/t7HOCL5
   7okG/9FubtjP+koHck9eRz5HUdDpjb4G/LOswvluKdt7TU2wmPrEZm1Lo
   0MlbJbOkvvZGn8zXuHh0evESvt3EqvB1L0FwFzo1ZOXTwKSof9bzHd4Xo
   xwpx8XDMNlo5/Vw3nf1stjUujNk0D805RoAMrVEEI9UfAd8ihnYREvg+E
   KmKURht66QlJ2skIJtY1ymvQ6RqUVRFVVsu5Q1vJ2jfHGt3jeRTb8WCsH
   Q==;
X-CSE-ConnectionGUID: c+jDB8vxQaqUnl6U4mNhzA==
X-CSE-MsgGUID: J9vCuTEVRWuTKs94fDPOFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64519232"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="64519232"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 19:40:12 -0800
X-CSE-ConnectionGUID: z63NhgyxQsu6z3LlMrKALg==
X-CSE-MsgGUID: q8H5WDsQSfm+YNa+YbFMUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="225185237"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 06 Nov 2025 19:40:08 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHDKX-000UfY-2q;
	Fri, 07 Nov 2025 03:40:05 +0000
Date: Fri, 7 Nov 2025 11:39:10 +0800
From: kernel test robot <lkp@intel.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org, tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v6 1/3] revocable: Add fops replacement
Message-ID: <202511070909.JnNsfyvx-lkp@intel.com>
References: <20251106152712.11850-2-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106152712.11850-2-tzungbi@kernel.org>

Hi Tzung-Bi,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on v6.18-rc4 next-20251106]
[cannot apply to char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus chrome-platform/for-next chrome-platform/for-firmware-next linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tzung-Bi-Shih/revocable-Add-fops-replacement/20251106-233108
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20251106152712.11850-2-tzungbi%40kernel.org
patch subject: [PATCH v6 1/3] revocable: Add fops replacement
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20251107/202511070909.JnNsfyvx-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251107/202511070909.JnNsfyvx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511070909.JnNsfyvx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/fs_revocable.c:9:
>> include/linux/fs_revocable.h:10:10: fatal error: 'linux/revocable.h' file not found
      10 | #include <linux/revocable.h>
         |          ^~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +10 include/linux/fs_revocable.h

     8	
     9	#include <linux/fs.h>
  > 10	#include <linux/revocable.h>
    11	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

