Return-Path: <linux-kselftest+bounces-45070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF7FC3EC68
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 08:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A6A3AE5EB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 07:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6463B30C36D;
	Fri,  7 Nov 2025 07:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKCTsZ/4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDE119D07E;
	Fri,  7 Nov 2025 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501200; cv=none; b=Gawr03swWQ1WNDGhXyDyygNSiu3iamWMsOwlfRkzFYtGoM8EbeVMVu/+Ao5LWpxsLd7NrXGtgn2zDlbCivxjJYSm3ga0C41rUAR+VEKqId9eH2G2JEUDWkRj9bu2XIszJb6NGrtmjlOB7bjdepL2Q7O8beqxfXcxB/fn2HNF0Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501200; c=relaxed/simple;
	bh=rlFu4NnKhWDiOltMj3WmHjKk2Ajfi86cpMomLpc6bKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhCT1ZBWsKZv2XeWAKXvpK8B+hUbl5tZ9T5j1stnrYNRSEueRpTcQHQ+X4pvLXNT8tw0ZGQkV4/lykGJUkheeJdT1NwINHe3LrG/JVV4DMPo06WuZ//FZ/lUWlcp/lVv5D+QTBTovPEbyRxceczgr2Us52IYSEoqa90wKEIy2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKCTsZ/4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762501198; x=1794037198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rlFu4NnKhWDiOltMj3WmHjKk2Ajfi86cpMomLpc6bKs=;
  b=BKCTsZ/4n74gh9ceEbEWP3BOkiG5pIkHwJQTpWzdu9NUkzSYte8yc1ox
   AFlW/ieYmXA2mrwQ7wzdS85wTJFT8ZWJjc1xRxsbekmlUA7DcpAQO965N
   9VapszJ664Iokg/h1aqgStqivvhcyiwErlr/W1/DI+HEWxRhofB4UIvY4
   +Vtm4itf0aT6ZXdKCmh4jX6LsRnU++B5oRS6fnIx0mRUixfzbUP5rftjX
   lkWuyFl/t55jR1ulDxykiiOQ5qXQiKOhCcctisTqqiSSLLh89Yu6M2jTR
   Caw7dxv4MXYvWegGzBi8HxKbdAQKM+SOQ2uQhULW5OLfaPazWIiITFzO6
   Q==;
X-CSE-ConnectionGUID: VozvQO7GQlGd1ztZzSS74Q==
X-CSE-MsgGUID: LknZCmoyTe2gsj5CxTdl1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="63660018"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="63660018"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 23:39:57 -0800
X-CSE-ConnectionGUID: +0ucQ30lRcOw0tdX7J+Pew==
X-CSE-MsgGUID: 7Q7bjwH1TD6MzSF2xpzWww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="192070285"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 06 Nov 2025 23:39:53 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHH4Y-000UqK-24;
	Fri, 07 Nov 2025 07:39:50 +0000
Date: Fri, 7 Nov 2025 15:39:05 +0800
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
Subject: Re: [PATCH v6 1/2] platform/chrome: Protect cros_ec_device lifecycle
 with revocable
Message-ID: <202511071536.lzOOC7SE-lkp@intel.com>
References: <20251106152602.11814-2-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106152602.11814-2-tzungbi@kernel.org>

Hi Tzung-Bi,

kernel test robot noticed the following build errors:

[auto build test ERROR on chrome-platform/for-next]
[also build test ERROR on chrome-platform/for-firmware-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.18-rc4 next-20251107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tzung-Bi-Shih/platform-chrome-Protect-cros_ec_device-lifecycle-with-revocable/20251106-233349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
patch link:    https://lore.kernel.org/r/20251106152602.11814-2-tzungbi%40kernel.org
patch subject: [PATCH v6 1/2] platform/chrome: Protect cros_ec_device lifecycle with revocable
config: arc-randconfig-r072-20251107 (https://download.01.org/0day-ci/archive/20251107/202511071536.lzOOC7SE-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251107/202511071536.lzOOC7SE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511071536.lzOOC7SE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from gpio-cros-ec.c:18:
>> include/linux/platform_data/cros_ec_proto.h:15:10: fatal error: linux/revocable.h: No such file or directory
      15 | #include <linux/revocable.h>
         |          ^~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +15 include/linux/platform_data/cros_ec_proto.h

    10	
    11	#include <linux/device.h>
    12	#include <linux/lockdep_types.h>
    13	#include <linux/mutex.h>
    14	#include <linux/notifier.h>
  > 15	#include <linux/revocable.h>
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

