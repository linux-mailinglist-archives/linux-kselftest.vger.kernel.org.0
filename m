Return-Path: <linux-kselftest+bounces-45020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2A1C3CC51
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 18:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF6A15000AB
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4D334D917;
	Thu,  6 Nov 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FK++MOsw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDDF3491C4;
	Thu,  6 Nov 2025 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449137; cv=none; b=gOi59zEELMWTYk0Utnby/3WqXoO3yhIbqY3w4ZTX+mIMILLBrwPOtOai4GFM/xDY318ALZVvAgRJpzq9ZafYJVyOKFNtnvEr6H4b35Qp/mL9359mJDiwf4qmchwga/5EY+6SKboZkuoRzX/P2QuK2byDJpnBShxqZSoYbeClF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449137; c=relaxed/simple;
	bh=4qrkGpsp3n4OXdocdoXmdZtejgU0nYsAv6I2+O0Xyo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiR7MQ0+u/1kkpA8udJbgxhoafc50LQnlOSRGcc6cmNNGJRWe6cXzcsIKs7lOXc2uVuScRkUOeuqaz/1MXWyzp1Qh7tRi9KODSm8RsUIyp3h0zoeUMMzrAqZiWHKLzA4zVKtQuRVt83rdKI6XI66XqYGR29GMHCPwsCDkBgCY5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FK++MOsw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762449136; x=1793985136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4qrkGpsp3n4OXdocdoXmdZtejgU0nYsAv6I2+O0Xyo4=;
  b=FK++MOsw52bjxwPj7gW6J7VFv19aEdkG9DrZjhAj85tfQBcBIAyzsvmW
   HoilC+/uX02owaJ4/E4nCgcUru3msbHWszQL1c3/QUlN5GZJ1kevuPMcC
   Yq507RYkq0wtT6IcJD0yJlE0Fgt0yn20uLvDybv6TPto117wWc4EqJcAv
   LhAwg2ZGsx5UUlTcLruaZN3nxOQyZQIHO4Df9wJIIel9ZnYkgySXQYhht
   AMcbBwLw91znGZ7MuBJw1yDEesyeAuVy7qXonpeMcpYREMoNA329qsDNz
   5Wl83+5+v0m3Nj1XfiVYGlMfcoR+Hq5OmYKjmIlTNcZLWvFczDg5YWFGo
   g==;
X-CSE-ConnectionGUID: VC/0Z9YdSauFPWX8fjLo0A==
X-CSE-MsgGUID: 8qerrIyGRxy9Z6BnFYTtmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="82223046"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="82223046"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 09:12:15 -0800
X-CSE-ConnectionGUID: GIvfeu/KRVybxpUq8O1Gaw==
X-CSE-MsgGUID: WXLYJNS0RSGygrxvMDGi/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187651813"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 06 Nov 2025 09:12:10 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vH3Wq-000UCK-23;
	Thu, 06 Nov 2025 17:12:08 +0000
Date: Fri, 7 Nov 2025 01:11:12 +0800
From: kernel test robot <lkp@intel.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <202511070033.7X18bWdJ-lkp@intel.com>
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
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20251107/202511070033.7X18bWdJ-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251107/202511070033.7X18bWdJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511070033.7X18bWdJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/fs_revocable.c:9:
>> include/linux/fs_revocable.h:10:10: fatal error: linux/revocable.h: No such file or directory
      10 | #include <linux/revocable.h>
         |          ^~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +10 include/linux/fs_revocable.h

     8	
     9	#include <linux/fs.h>
  > 10	#include <linux/revocable.h>
    11	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

