Return-Path: <linux-kselftest+bounces-45068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289B5C3EB4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 08:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6463D3AF906
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 07:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7793081CD;
	Fri,  7 Nov 2025 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="As1N7s9I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A4306D26;
	Fri,  7 Nov 2025 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762499331; cv=none; b=u0AGIeTpbvBY4s1vRjSVcxlNrjonJKjv2xwJVKflHU4cmSqloZfsKE1iRXu02G+YZpfjylJQekJUTImBQytW7AMm7UOkgSEGoNWmJn7JLsc4zbxytVT8KWRk52RNJ2+aZyHxYmjefeuaqHqEH+GEozs1vn7JFXcqpFA/B63PD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762499331; c=relaxed/simple;
	bh=6pC1aVA3xA1nxoweNiGPgc8b4jvGQAisOMaVoBdaHcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcCyjsz/OAFO6fUZSAu6VLKVbuF4UV+VRTaXRkDTzixxRdpufdyoleTb9GGx+p57zQIhYGntPTIJ1+jC5A7eXS+X7+3TB8ITClv1MWj+8YqXKVWWD9miT8AIHbKZZxDEAvChhJzSDNmaaruOb0+H0EjObjyFKthcH4eRm0cBMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=As1N7s9I; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762499330; x=1794035330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6pC1aVA3xA1nxoweNiGPgc8b4jvGQAisOMaVoBdaHcI=;
  b=As1N7s9IGvhDPAKnFO7winxqvf2Sl3/7b7SXGBQx1V9L747d5S1eqUYj
   qbGHxw0JxoO52V05b6z/aVjafImaHFqmRyJFz5eItP2FLIpbFd3ODSrDx
   lJn5Gqch92Vi+NheQWJ5hkI/FJPoeYjQaXM9mZjgtMuUDpeUjvVin1F5E
   4DulgX+m6QNBoiiZDRNgLrAH8lnVh/Ajj20036HeoPeuLOh+IPTki6GCQ
   AvAkdl0V3/aN0dmoJE1qz42cxkRS4JTDvhA7rsp4cOpBPjgLOC2ywcbl8
   v0OtjlKrio6vWUyomtsCM4jcoaCN8El1XBXgZ4xF3inXueRfye/ZDYkU2
   Q==;
X-CSE-ConnectionGUID: BnJMRUkYRzqCNETaks+83Q==
X-CSE-MsgGUID: idqFcyylSUiy/17KuGGduw==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="90117792"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="90117792"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 23:08:49 -0800
X-CSE-ConnectionGUID: VBfncNcWSPuus2De3BboJw==
X-CSE-MsgGUID: xwDWvYGISIeyoSEGOD0mCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="187810922"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 06 Nov 2025 23:08:44 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHGaQ-000UpE-2R;
	Fri, 07 Nov 2025 07:08:42 +0000
Date: Fri, 7 Nov 2025 15:07:52 +0800
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
Subject: Re: [PATCH v6 1/2] platform/chrome: Protect cros_ec_device lifecycle
 with revocable
Message-ID: <202511071425.qwhK2D9r-lkp@intel.com>
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
config: hexagon-randconfig-002-20251107 (https://download.01.org/0day-ci/archive/20251107/202511071425.qwhK2D9r-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d2625a438020ad35330cda29c3def102c1687b1b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251107/202511071425.qwhK2D9r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511071425.qwhK2D9r-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/i2c/busses/i2c-cros-ec-tunnel.c:10:
>> include/linux/platform_data/cros_ec_proto.h:15:10: fatal error: 'linux/revocable.h' file not found
      15 | #include <linux/revocable.h>
         |          ^~~~~~~~~~~~~~~~~~~
   1 error generated.


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

