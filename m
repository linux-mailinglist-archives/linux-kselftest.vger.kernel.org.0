Return-Path: <linux-kselftest+bounces-40365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C19AB3CEDE
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 20:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76837C2EEB
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 18:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4110F2DA77E;
	Sat, 30 Aug 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f53jyCKF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E4A1DE8AE;
	Sat, 30 Aug 2025 18:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756580212; cv=none; b=URIux13wUu31qGS+QhWn5etNsKSDMA6lJMwI5qsvz5POqSKUJXah4eGimTfyndvBznOBwnOjDNfjedFF4BluoDIwZS6lTY6no38RkelTVyzGIwpPVt2Jq4ELQxW0gJ6m4TtR4EdjG8Y0zDjOyX2mLoMji5Pp/BR3g5MlZyZpViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756580212; c=relaxed/simple;
	bh=CHk+rQK0/3ksJzsZOpQ42U/wXkW4aw9gkgjYX9WCQho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS90c9Yt+AnYm2F04r2yNCLKB3lJmOWWjwhGMRMYRlU+Bh1XSEN2aGmInxSsV1uDotylLljsTeLsHxyyVOHyGwYyfxgQAbx75GMox28xI6sYg7VHMbVqqVzb4/qnFa/C4OY2RZwzrEbc8YFYwfaNXPRxNFP6G/x29gujak/b8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f53jyCKF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756580210; x=1788116210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CHk+rQK0/3ksJzsZOpQ42U/wXkW4aw9gkgjYX9WCQho=;
  b=f53jyCKFO62H2PMLhYpWk2V5e6ww4+4+++V3xNQxh85drX98E+hBQTpp
   QxSDOfZLnhpN9FB/a3vWio6B/ipatQFh43o9E/Riqc0sB/hrWqLpOFzpt
   4Mx40aWxbgwRCWiz7ZEA85f9l7KQwj1Du7/bg2i3tlqdG2BfTajqSnXdf
   2eisrX5FfSOAV619ivMAdLQhqqWO3/WRtn1sYmusRCOlLzDBLc1jIQ/YK
   FZsInpWohtWjTjmOv3wJtz9gukm/lpPxQiG7TrbCmSCYOY2lybKyIivLJ
   n3o/NcIVaVIRL+CSkM8dpJjqTEPzasl0fcMHvJe4ntgJ8goZJW7asIvEN
   w==;
X-CSE-ConnectionGUID: Wi6ssj3aQzeJtZx3UMdDeg==
X-CSE-MsgGUID: lgTAt+VqSFy/LwA7T0/RUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="69429693"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="69429693"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 11:56:49 -0700
X-CSE-ConnectionGUID: z+e/25oPTQu1aEMUlCgAbQ==
X-CSE-MsgGUID: QzZnou2VQca1TIsOl3rKfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="175909235"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 30 Aug 2025 11:56:46 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usQkm-000VdH-1C;
	Sat, 30 Aug 2025 18:56:44 +0000
Date: Sun, 31 Aug 2025 02:56:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"michael.day@amd.com" <michael.day@amd.com>,
	"david@redhat.com" <david@redhat.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"Roy, Patrick" <roypat@amazon.co.uk>,
	"Thomson, Jack" <jackabt@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>,
	"Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Subject: Re: [PATCH v4 1/2] KVM: guest_memfd: add generic population via write
Message-ID: <202508310252.E5uFh1hx-lkp@intel.com>
References: <20250828153049.3922-2-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828153049.3922-2-kalyazin@amazon.com>

Hi Nikita,

kernel test robot noticed the following build errors:

[auto build test ERROR on a6ad54137af92535cfe32e19e5f3bc1bb7dbd383]

url:    https://github.com/intel-lab-lkp/linux/commits/Kalyazin-Nikita/KVM-guest_memfd-add-generic-population-via-write/20250828-233437
base:   a6ad54137af92535cfe32e19e5f3bc1bb7dbd383
patch link:    https://lore.kernel.org/r/20250828153049.3922-2-kalyazin%40amazon.com
patch subject: [PATCH v4 1/2] KVM: guest_memfd: add generic population via write
config: x86_64-randconfig-001-20250830 (https://download.01.org/0day-ci/archive/20250831/202508310252.E5uFh1hx-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250831/202508310252.E5uFh1hx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508310252.E5uFh1hx-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "filemap_remove_folio" [arch/x86/kvm/kvm.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

