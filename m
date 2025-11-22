Return-Path: <linux-kselftest+bounces-46312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3033C7C9CB
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 08:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67D64358708
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 07:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FC5286D60;
	Sat, 22 Nov 2025 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkJkqWgV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7813E26A0DB;
	Sat, 22 Nov 2025 07:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763797488; cv=none; b=WeWixM3fUZXHfvCZhF9TjvxLP2ubvRA0wV4500nlMf1fQm+nAM1e/Tm22CMNsRZFUXmDlY1H1t4/sP/oCESjecCamhAwwvrc0UsBWs6FyI6XjNqpnFF23N4dcc+T9Qrh93VqfL+blXR7jYLwIOX7JNb6SQRSV27V6fVQYs/2pbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763797488; c=relaxed/simple;
	bh=X/ohklRasv/xtI+CkJOe5aZ7VMVJETKkoe4o1TAcmEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvUZaFHTAcgU0TB3TQVLph6hmuSAtJ9+FDP7WZjDPdDlkwgMN/PqH3GDSH2eB+880ZEfskPJJzE8HkYV6kT0kaeUpkVrhJAgybmTORSuKzRMHAPcwoVgaUIbO2MgY0kcKy7DTeeBFNwey7f57Sx6DVZv1xVXuAoCIUgS5XlevWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkJkqWgV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763797487; x=1795333487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=X/ohklRasv/xtI+CkJOe5aZ7VMVJETKkoe4o1TAcmEE=;
  b=lkJkqWgV09sM3icDqQh5WG5yzDFL2Yp2cxLn4NYscWCEMtuJnUGJbQaL
   Jthe0qwH+seb21EFhL7x6DRQpTtXn1yhcTbmDNSAEc7X+UWZM+Y4bjN1h
   TuWZ2r5Wj6nutdpa8YlqI7NuChND4OW8BX/w2HurepE3b4P2ZVPabI0eT
   UJiBtRjVrHQB1RWI5QD8JjFRcKBft9iLQ6jHx9hxgvBo5CAE09witcqQ3
   Rdp6JKNjhJTOajql6nFw3DlTGNv8TKFQBKqhTWz2DIZyrGaUQQMW7Ts+L
   beWr9eEgmZ9zpRgC1O8OIVJyt/yE9lH3Yg1ER8A2Ksqw0Gc4hVH6ZJwtl
   Q==;
X-CSE-ConnectionGUID: L4O+r5NwSRWb4TOQNF3z0Q==
X-CSE-MsgGUID: PO1dg9ivTASJWCFkg4GAwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65581558"
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; 
   d="scan'208";a="65581558"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 23:44:46 -0800
X-CSE-ConnectionGUID: 9Lp6hcoIQoS/aN+gAxeuIw==
X-CSE-MsgGUID: PMY0OqCGRLqTrsWBkHisRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; 
   d="scan'208";a="192350309"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 21 Nov 2025 23:44:42 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMiIR-0007GR-2P;
	Sat, 22 Nov 2025 07:44:39 +0000
Date: Sat, 22 Nov 2025 15:44:04 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Ryan Houdek <Sonicadvance1@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org, kernel-dev@igalia.com,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v6 6/9] futex: Wire up get_robust_list2 syscall
Message-ID: <202511221522.uRpEUT5O-lkp@intel.com>
References: <20251122-tonyk-robust_futex-v6-6-05fea005a0fd@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251122-tonyk-robust_futex-v6-6-05fea005a0fd@igalia.com>

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c42ba5a87bdccbca11403b7ca8bad1a57b833732]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/futex-Use-explicit-sizes-for-compat_robust_list-structs/20251122-135406
base:   c42ba5a87bdccbca11403b7ca8bad1a57b833732
patch link:    https://lore.kernel.org/r/20251122-tonyk-robust_futex-v6-6-05fea005a0fd%40igalia.com
patch subject: [PATCH v6 6/9] futex: Wire up get_robust_list2 syscall
config: hexagon-allnoconfig (https://download.01.org/0day-ci/archive/20251122/202511221522.uRpEUT5O-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511221522.uRpEUT5O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511221522.uRpEUT5O-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> <stdin>:1627:2: warning: syscall get_robust_list2 not implemented [-W#warnings]
    1627 | #warning syscall get_robust_list2 not implemented
         |  ^
   1 warning generated.
--
>> <stdin>:1627:2: warning: syscall get_robust_list2 not implemented [-W#warnings]
    1627 | #warning syscall get_robust_list2 not implemented
         |  ^
   1 warning generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

