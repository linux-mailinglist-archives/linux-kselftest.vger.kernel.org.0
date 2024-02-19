Return-Path: <linux-kselftest+bounces-4921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4889D859C49
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 07:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5751C20ED8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 06:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD00D20300;
	Mon, 19 Feb 2024 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwY5fBqv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BCC1D68F;
	Mon, 19 Feb 2024 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324615; cv=none; b=qyg1aNz8WJ/2z8ZVp3ZzNKM1wF19OU180Rm9t5WO0GakFYfcSiz1Cy9m7dyhAB5iEvagT0i1okxjsiQCPfjfAVWftxoJ40zSh2Z+gGU03h0bFWIUhN5rLi6ec/goDxpe/97RoGWcdl2TGgUqX/Zc2tXcQzEMGOido+PGfaRik0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324615; c=relaxed/simple;
	bh=1L2K/uGMpFSQGmPXioQnU1SxKm7k5LRxtDAMQaVSQ4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAgQ57kIbpY1HwSkxA49Ou9d2jfKrhL+ej9NYe7qoWSl9NY4TyyVyn3iZctGxRctlUfCbqpyZuotuo2HfpFJlKE+DzJ3ugxJp8VH0MisgohiBB1JbRmS1iXbhBIwFJvOkugI9Y5an3MsRKmR8smirDOWsKu/jxeOoYeiPzvw/bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwY5fBqv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708324614; x=1739860614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1L2K/uGMpFSQGmPXioQnU1SxKm7k5LRxtDAMQaVSQ4Q=;
  b=iwY5fBqvXRHLNjbMrBxSvsKI2edoPkeypXijA6qK82zlyUaTGWVO80xi
   6q5DOrfxrVQHPW+hS9PcyqJbMf1nUDs5S7WHI7bLG7fZC+sbF1AXPKzlw
   gRjkI7fB32cxazNvqHdjJxYDhVW5j3DJoY+w+6XfcWHFBRwFNUocISdAg
   n2caNbOEaOjrS4CauoV2PGACEG2PcBzQfSCTRJ2YPJjyeyp5vEk8RkeNl
   udyRCfIJC/Wm5VQjsuoCuxcb8SXMgz0WZBIFpNKeV4qqIZaVcAMF7EEWJ
   Z6Vg+6HZCjVXLsRHlWq+/ZAPl1gcDyPzgKNvORcRzGWBDF2M5nNbviiJ7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2516604"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2516604"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 22:36:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9011470"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 18 Feb 2024 22:36:46 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbxGR-0003aC-36;
	Mon, 19 Feb 2024 06:36:42 +0000
Date: Mon, 19 Feb 2024 14:35:16 +0800
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
Subject: Re: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
Message-ID: <202402191417.XULH88Ct-lkp@intel.com>
References: <20240215-lp-selftests-fixes-v1-1-89f4a6f5cddc@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-lp-selftests-fixes-v1-1-89f4a6f5cddc@suse.com>

Hi Marcos,

kernel test robot noticed the following build errors:

[auto build test ERROR on 345e8abe4c355bc24bab3f4a5634122e55be8665]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/selftests-lib-mk-Do-not-process-TEST_GEN_MODS_DIR/20240216-021601
base:   345e8abe4c355bc24bab3f4a5634122e55be8665
patch link:    https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-1-89f4a6f5cddc%40suse.com
patch subject: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191417.XULH88Ct-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402191417.XULH88Ct-lkp@intel.com/

All errors (new ones prefixed by >>):

>> make[3]: *** /lib/modules/5.9.0-2-amd64/build: No such file or directory.  Stop.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

