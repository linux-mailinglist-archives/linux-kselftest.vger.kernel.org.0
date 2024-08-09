Return-Path: <linux-kselftest+bounces-15079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169D594D401
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 17:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AEF1C20C54
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 15:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65401198A06;
	Fri,  9 Aug 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OwKyqDC8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F152168B8;
	Fri,  9 Aug 2024 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723218823; cv=none; b=Vg1yNsEYZ+Wih90PruXvQ2eu57RXT8awX4PQ9B6X+MnJIuTBkW6DGH22rKA3Jr3Kp7gG0+ru4k8JVleeYsqD2sjQX7uZJ00NyeqjC4WOi5iomPlgOAeejIKcp6twZ3VYqH0jAAmv2+8q4kcYMWKkq5Icm7qAXlA2bzt1Z/oGGm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723218823; c=relaxed/simple;
	bh=P6cS1YkhJ0u2ZgDB+sTJKdZitAKqXDejZ1hjDidMg2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqYsCxmWfzdvKjw1HjEr/epyqY+buMC+p6HLt10WXiHBeORr37II34rdH6/TqKDr9B1eJYBaPdJbV9/5NM6fMwD9bIIsayTLURapvtiZvW+Mx3OdkhZuAuKMu27eBhaDi1lsupcfo5adRCDcCgf7nDO5iceqc4au3IOgJqhB4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OwKyqDC8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723218822; x=1754754822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P6cS1YkhJ0u2ZgDB+sTJKdZitAKqXDejZ1hjDidMg2o=;
  b=OwKyqDC8KSt/vrTTGW0ck9Jg07kWpBp30IHvaUGHcv0frQdae0dOWHqy
   uSLsQc+viLkfw2YVi46+Lnw+dBfLiRFAU5cdTLkpB+kG//SQPW/6g3G4P
   gShR3Cn+R2259LPzUEf8Qidtoh0+wc+MkVhlIBQEA2pbU5zW8/5H31JEX
   FcUuhhlog6zcZZxnKYym9YAqVnNyECSo/zgishlb4uSidQa8IMmbxowtS
   6ujsAQyiTPrb6yoBfP7QsqH2jqNyF0fMg7/zBQPBr+im+6Bg8GfKWL4ma
   O3mY8UZp5fm8PXcvfoQ1W6MNXSdZpWJrrNRz+QWRy15ZkbO7RfIXg6Tv0
   Q==;
X-CSE-ConnectionGUID: 1oXVM3f6T0aK8hXVYyNXCg==
X-CSE-MsgGUID: bFCznxoIS0e6cnaeIaIGfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21557251"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21557251"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:53:41 -0700
X-CSE-ConnectionGUID: 89AvCJGWRveMYUwnYpgHlQ==
X-CSE-MsgGUID: ZLRaqbLYTtGS83rI88Q0RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="88241156"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 09 Aug 2024 08:53:38 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scRvq-0008Sy-2l;
	Fri, 09 Aug 2024 15:53:34 +0000
Date: Fri, 9 Aug 2024 23:52:44 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
	kevin.tian@intel.com
Cc: oe-kbuild-all@lists.linux.dev, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iommufd/selftest: Add coverage for reserved IOVAs
Message-ID: <202408092301.M51NPXgL-lkp@intel.com>
References: <544ab894a301c83eb9f9d7a6326f4cb87f517019.1722644866.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544ab894a301c83eb9f9d7a6326f4cb87f517019.1722644866.git.nicolinc@nvidia.com>

Hi Nicolin,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes linus/master v6.11-rc2 next-20240809]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommufd-Reorder-include-files/20240803-210818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/544ab894a301c83eb9f9d7a6326f4cb87f517019.1722644866.git.nicolinc%40nvidia.com
patch subject: [PATCH v2 3/3] iommufd/selftest: Add coverage for reserved IOVAs
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20240809/202408092301.M51NPXgL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240809/202408092301.M51NPXgL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408092301.M51NPXgL-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb_debug.o
>> ERROR: modpost: "iommu_dma_prepare_msi" [drivers/iommu/iommufd/iommufd.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

