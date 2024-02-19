Return-Path: <linux-kselftest+bounces-4922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FA3859CB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 08:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56767B211CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 07:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956C6208C4;
	Mon, 19 Feb 2024 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrjLDMSp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A802033A;
	Mon, 19 Feb 2024 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327052; cv=none; b=ESYlMUl2IartOwmypdnqcf7TF3cXnW5Gq1lgVbag3n8CFVtAqWwsx76O5FVvp2395hlPDLTFETdp7iH4tRhwsHYlfqhYKFB/E4IeXZR1KzZgvXQPhpRC46rv+wzdRjSmeq10CLfWpSmyHPUym75t2ggzG/z1p7UI5CAl6KiJDDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327052; c=relaxed/simple;
	bh=GKXy53YYv0eSLU9kBkF29HbfUhSrEPdczZxj9bBvR7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRaPrWuT8cFy4/FHJDwh4U4vCJg0bswl+V2I24qsSpy7FjvxvmrdSBwz+y6wOLmG1Rm8zUUFT1FkRfifEmb/hZbRtgac7V049g2+Li4jHNe4RE04EeyPMMkKwVbzXPAKNH1ezKL9HwblINokGQCg7EKEqnLn0GEIP9AR/agRLFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrjLDMSp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708327051; x=1739863051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GKXy53YYv0eSLU9kBkF29HbfUhSrEPdczZxj9bBvR7s=;
  b=MrjLDMSpu1ZjnmDJJJH9noZqAVLG0RN2FBeJGGCqOHs/i/Y7JQ5dgFjc
   TKjyT7L8NLMWoAMFW/XMLrHsuJ21cIWVwW0a71TcuPN4YjYLKxAR6UX8X
   sBSC+D7NSJRMqfIcf7Ar1rkniaqaQO01EhGTiSSd2fJ7Wn9SGuv6o9qFe
   kAQbt30XpjYOtK4lRd9IRisTvB9pp83p2L6mlm1mvnX+awwGWTgWZwMBl
   Uwilt2lMhOv4j08Bh+yuAOHbQAOwQP8aHuYDA3m5TzRn0b5WO+z+rdqus
   YVS3LxahTYwPEv9tg+/k5QoDQLGCyFRr1S33BssMMrHL5FsJ42C3ybjTJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2256901"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2256901"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 23:17:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="35186430"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2024 23:17:27 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbxtt-0003ba-1C;
	Mon, 19 Feb 2024 07:17:22 +0000
Date: Mon, 19 Feb 2024 15:16:51 +0800
From: kernel test robot <lkp@intel.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 2/3] selftests: lib.mk: Simplify TEST_GEN_MODS_DIR
 handling
Message-ID: <202402191502.dALlSRz0-lkp@intel.com>
References: <20240215-lp-selftests-fixes-v1-2-89f4a6f5cddc@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-lp-selftests-fixes-v1-2-89f4a6f5cddc@suse.com>

Hi Marcos,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 345e8abe4c355bc24bab3f4a5634122e55be8665]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/selftests-lib-mk-Do-not-process-TEST_GEN_MODS_DIR/20240216-021601
base:   345e8abe4c355bc24bab3f4a5634122e55be8665
patch link:    https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-2-89f4a6f5cddc%40suse.com
patch subject: [PATCH 2/3] selftests: lib.mk: Simplify TEST_GEN_MODS_DIR handling
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191502.dALlSRz0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402191502.dALlSRz0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Makefile:11: warning: overriding recipe for target 'all'
>> ../lib.mk:62: warning: ignoring old recipe for target 'all'
   make[1]: *** [../lib.mk:62: all] Error 2
   Makefile:65: warning: overriding recipe for target 'emit_tests'
   ../lib.mk:120: warning: ignoring old recipe for target 'emit_tests'
   make[1]: *** No targets.  Stop.
   make[1]: *** No targets.  Stop.
   make[1]: *** No targets.  Stop.


vim +/all +11 Makefile

^1da177e4c3f41 Linus Torvalds 2005-04-16   7  
^1da177e4c3f41 Linus Torvalds 2005-04-16   8  # *DOCUMENTATION*
^1da177e4c3f41 Linus Torvalds 2005-04-16   9  # To see a list of typical targets execute "make help"
^1da177e4c3f41 Linus Torvalds 2005-04-16  10  # More info can be located in ./README
^1da177e4c3f41 Linus Torvalds 2005-04-16 @11  # Comments in this file are targeted only to the developer, do not
^1da177e4c3f41 Linus Torvalds 2005-04-16  12  # expect to learn how to build the kernel reading this file.
^1da177e4c3f41 Linus Torvalds 2005-04-16  13  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

