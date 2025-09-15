Return-Path: <linux-kselftest+bounces-41474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7273B576CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 12:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52AAF44568F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 10:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8082FD7A8;
	Mon, 15 Sep 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqSLhXHh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1185D2FD1DB;
	Mon, 15 Sep 2025 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932821; cv=none; b=EYTtBDKGoRTlI6uk5fLM5LFpiGTL5spWDelBv5pSsCPxpHPcyEnfdpyrqRNUla1MQJxUaRUy/sPpg/JLgn4SbAjmKhWJZ+nf07L1nK5Gy+Z5haDSFWkwiEHesE/fOT9qS7dvasXACY6ezZeW9TlhOe4q7loYL/QV2fuBQU7K2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932821; c=relaxed/simple;
	bh=Nzk/WGSFbYXU/3XfPyxSdJhM2+qxUftU2FcBdAr8OJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxanHlWn/268rraULow/9mRx3lusG1zCde65HuVqo2N6yMqzaAY35uiAsmtoIDmEc4DEQ3+6baUzU2qP2UuO0dEWKEklACC3qTENb6ljwJt18ZaFZGrxrtg0g12L7NuFg0pu6Fa78dZSUn4p6IJZWvFRUNBtXm+0PlTs4a31T9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqSLhXHh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757932820; x=1789468820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nzk/WGSFbYXU/3XfPyxSdJhM2+qxUftU2FcBdAr8OJY=;
  b=EqSLhXHh203T1aNowmFHhwqbydsdaChHTFbAzCmDS3Sayt0lhiue/V29
   NQbnsWlAYrdGvQIaVejsV+JtyzIpUKYxGxAYyC9AsW2SwWxDWIUBolMOt
   YbOimMHYnE5+EUnkH+VhHW6Be+qB+mqDgljnySnWQYKOB2+onAqaCuIJc
   Yd3n93xGD3s/2KSykFHzQ9be2mBgrL5LXyeU9ja9D7DaY9guoCD8E+urY
   MRTmcwdMdaS7vRRYIgSmyO+eAdxtY4zCr6d9pKXtERZ/n1S1SKRzz3clm
   fuxy3S5UdIONXAgQC7hVroRMbfGpPIiMneR2EZx8SQzusri/Wb24qKzep
   Q==;
X-CSE-ConnectionGUID: J5pPtniRRQG4c8ynz07kkw==
X-CSE-MsgGUID: nesyQA5hSICjoox5aXuZBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="60051244"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="60051244"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 03:40:20 -0700
X-CSE-ConnectionGUID: 8iJJl0gJQhq5nxP18SkwKw==
X-CSE-MsgGUID: zy0r3AIKSySNYAJ2rb6mUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="173881637"
Received: from lkp-server01.sh.intel.com (HELO 5b01dd97f97c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 15 Sep 2025 03:40:17 -0700
Received: from kbuild by 5b01dd97f97c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uy6d4-00008h-1O;
	Mon, 15 Sep 2025 10:40:14 +0000
Date: Mon, 15 Sep 2025 18:40:08 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 2/9] um: use tools/include for user files
Message-ID: <202509151828.S0qPk6Du-lkp@intel.com>
References: <20250915071115.1429196-3-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915071115.1429196-3-benjamin@sipsolutions.net>

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on uml/next]
[also build test ERROR on uml/fixes linus/master v6.17-rc6 next-20250912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Berg/tools-compiler-h-fix-__used-definition/20250915-152550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux next
patch link:    https://lore.kernel.org/r/20250915071115.1429196-3-benjamin%40sipsolutions.net
patch subject: [PATCH 2/9] um: use tools/include for user files
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20250915/202509151828.S0qPk6Du-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 65ad21d730d25789454d18e811f8ff5db79cb5d4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250915/202509151828.S0qPk6Du-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509151828.S0qPk6Du-lkp@intel.com/

All errors (new ones prefixed by >>):

>> <built-in>:3:10: fatal error: 'include/generated/autoconf.h' file not found
       3 | #include "include/generated/autoconf.h"
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
   make[3]: *** [scripts/Makefile.build:182: arch/x86/um/user-offsets.s] Error 1
   make[3]: Target 'include/generated/user_constants.h' not remade because of errors.
   make[2]: *** [arch/um/Makefile:121: archprepare] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

