Return-Path: <linux-kselftest+bounces-33468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B09ABF7C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 16:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC7716389A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5232E1A2C27;
	Wed, 21 May 2025 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BF8RR/p4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A51519B8;
	Wed, 21 May 2025 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747837453; cv=none; b=QdS36Ieqzy7A7loqgGtXGOp+5/jnt48gxDcEGCjf2n/QWzS14V78uvsmaNlTHv+MEZE38vtH/VhjRdrC06wp3iHZNM0Fk++U7Na2b6l+IhtARu5cYqnnmeOvpiBBUpuZKBURySnGMd/yC7m5iSn/pcWV3Uf9mArlOWdhIN60lUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747837453; c=relaxed/simple;
	bh=eUGk6V7wI03gCVDLIG209a4YmT/Iai4T9MJ/TF9DLyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6053dr1QhvfK44cbKg24HokOH2CFXvZs2dJXiC5Py0x6WGmNuTozlDlDJDsHaTEXJzlZMXFQMoECXbh3UJkmp7rGLJe/UHWkq86szDbkp0ix6mMyH/U517skQEqn0q/K/mNjfSoqBudb0kwMjGx/JEwvuClPRZ70CMxAl6sPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BF8RR/p4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747837451; x=1779373451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eUGk6V7wI03gCVDLIG209a4YmT/Iai4T9MJ/TF9DLyk=;
  b=BF8RR/p4/lkarbPBnrX1i6C6pB9Vy82dprQHyJuzEgG5Lkv1uBN8H+XL
   eZZRKvNBa/QMyw81wAUJ+jS/7GHlkIKJtFOkTNI1pB1LyDpzcYKtDuwcV
   F2dOH3nsK36yJZI4eq43SLwuCzOhx0shx82YTT2iI7tL2M8VC+Vqayv5i
   OHeWMIpqWJe4jWDthIsHuCBN/v1NY7dOzHkdwUaUObWxKS9fY0Uff5+QY
   YwbEmat8/1am7Nvmti5wI6byubHXHTjjhD2OwKE2aNTgjq39Ht7ZLuWj2
   /N+Tzi642TByiKjXMCOeePx0G0jFKQ7wRhQj0blY7mjbr0iWk5HS+ZfDV
   A==;
X-CSE-ConnectionGUID: +z1SxEj/S9qrHE8IYAyq2A==
X-CSE-MsgGUID: HBNcczIdQmqZOtbQcUfFmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49879915"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49879915"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 07:24:11 -0700
X-CSE-ConnectionGUID: 4BUjFANHQzO7LV0bp8FiPg==
X-CSE-MsgGUID: cNeIdTQfQKiMknVr6oSrCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="171102153"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 21 May 2025 07:24:08 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHkMX-000OLs-2d;
	Wed, 21 May 2025 14:24:05 +0000
Date: Wed, 21 May 2025 22:24:04 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v4 4/7] futex: Create set_robust_list2
Message-ID: <202505212200.ditHHp5E-lkp@intel.com>
References: <20250520-tonyk-robust_futex-v4-4-1123093e59de@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250520-tonyk-robust_futex-v4-4-1123093e59de@igalia.com>

Hi André,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3ee84e3dd88e39b55b534e17a7b9a181f1d46809]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/selftests-futex-Add-ASSERT_-macros/20250521-045231
base:   3ee84e3dd88e39b55b534e17a7b9a181f1d46809
patch link:    https://lore.kernel.org/r/20250520-tonyk-robust_futex-v4-4-1123093e59de%40igalia.com
patch subject: [PATCH v4 4/7] futex: Create set_robust_list2
config: i386-buildonly-randconfig-003-20250521 (https://download.01.org/0day-ci/archive/20250521/202505212200.ditHHp5E-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250521/202505212200.ditHHp5E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505212200.ditHHp5E-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/futex.h:177:26: error: field 'list' has incomplete type
     177 |         struct list_head list;
         |                          ^~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

