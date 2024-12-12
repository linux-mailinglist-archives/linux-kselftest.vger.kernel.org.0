Return-Path: <linux-kselftest+bounces-23239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DA79EDEA4
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 05:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EF8282F98
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 04:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2690117C7C4;
	Thu, 12 Dec 2024 04:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdbFOPDI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682DE1632CA;
	Thu, 12 Dec 2024 04:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733979196; cv=none; b=JTc7nTDXSsQzf2wRvCcE3jVjALq8UhnbpgSAVODj4vdUgUFiEIrSEONmXuBiGw+WQK99KCi0/verNdp5oFo3xiB8TjDXigWGsJ8BGw3VjvFjcbahLY2uMm8aFVFrBYKFuktPBVA2ZVyZSeBv7agx7N/KdTOg5YEqa7liWenrgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733979196; c=relaxed/simple;
	bh=OThb/28WRH4fPmSctOntMxlFyk4uNJM60KRc4sMrzqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZojeSFJA5YF94snFbrn6QZhBVgyBNIOjqBe4yzYoQ13SNFfuq2V2MT8cOqRpfDdbG8/r4rZuZbirUMenFD5+ph+4JoitlR81BZdYr64av+8ID/9EhTeAQQsdxmNdiTxXjuMkZHrt03arCRzADvjzhiLUMCuwGpDSURcgb2r0OJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdbFOPDI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733979193; x=1765515193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OThb/28WRH4fPmSctOntMxlFyk4uNJM60KRc4sMrzqg=;
  b=VdbFOPDIG2GdRTaTHG5y5Gw1wt/IO/YYGuH7n3ER9LTYJGYpDF/5yK5r
   Wx3MHHUa5ozDzjbU8ZlL9G4VPqKdnBvNfJfNzj7ksnf0WIqqOuhn780DS
   ZrS9C8EQEoUCUlE6eqI2P4pdvb165+Aw3Uq+JgEQvwCr0vLG4ypArKZR1
   F+dqZcyyxAI91HO83ome4gkaBz48Ni2U0XTsjcK53W58FD94NmCkLnfoS
   vjYaThwXB3WrdDOYbNn2tDcnAj2KrruQ8GxfpEt+PYW2brFeeMXBmE6MM
   qo6cigjpmfTp30vcubkSO637Kh5TxogfTQUzImVTMO115p0SsV+UfzrUb
   g==;
X-CSE-ConnectionGUID: Gn3aZrxZScKO0AAlKqyAWA==
X-CSE-MsgGUID: ABC5keaDRXKSfxcsPUhN6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45765797"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45765797"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 20:53:12 -0800
X-CSE-ConnectionGUID: 61UdLCRVSFCV9GxQXcQjQQ==
X-CSE-MsgGUID: gsE7v/SySSK9YmCGTr+8Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="95947178"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 11 Dec 2024 20:53:09 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLbCD-0007Rz-2h;
	Thu, 12 Dec 2024 04:53:05 +0000
Date: Thu, 12 Dec 2024 12:52:54 +0800
From: kernel test robot <lkp@intel.com>
To: Elizabeth Figura <zfigura@codeweavers.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: Re: [PATCH v6 28/28] ntsync: No longer depend on BROKEN.
Message-ID: <202412121219.EQhUbN0S-lkp@intel.com>
References: <20241209185904.507350-29-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209185904.507350-29-zfigura@codeweavers.com>

Hi Elizabeth,

kernel test robot noticed the following build errors:

[auto build test ERROR on cdd30ebb1b9f36159d66f088b61aee264e649d7a]

url:    https://github.com/intel-lab-lkp/linux/commits/Elizabeth-Figura/ntsync-Introduce-NTSYNC_IOC_WAIT_ANY/20241210-031155
base:   cdd30ebb1b9f36159d66f088b61aee264e649d7a
patch link:    https://lore.kernel.org/r/20241209185904.507350-29-zfigura%40codeweavers.com
patch subject: [PATCH v6 28/28] ntsync: No longer depend on BROKEN.
config: i386-randconfig-002-20241212 (https://download.01.org/0day-ci/archive/20241212/202412121219.EQhUbN0S-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412121219.EQhUbN0S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412121219.EQhUbN0S-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/spinlock.h:60,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from drivers/misc/ntsync.c:11:
   In function 'check_copy_size',
       inlined from 'copy_from_user' at include/linux/uaccess.h:207:7,
       inlined from 'setup_wait' at drivers/misc/ntsync.c:903:6:
>> include/linux/thread_info.h:259:25: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
     259 |                         __bad_copy_to();
         |                         ^~~~~~~~~~~~~~~


vim +/__bad_copy_to +259 include/linux/thread_info.h

b0377fedb652808 Al Viro   2017-06-29  248  
9dd819a15162f8f Kees Cook 2019-09-25  249  static __always_inline __must_check bool
b0377fedb652808 Al Viro   2017-06-29  250  check_copy_size(const void *addr, size_t bytes, bool is_source)
b0377fedb652808 Al Viro   2017-06-29  251  {
c80d92fbb67b2c8 Kees Cook 2021-06-17  252  	int sz = __builtin_object_size(addr, 0);
b0377fedb652808 Al Viro   2017-06-29  253  	if (unlikely(sz >= 0 && sz < bytes)) {
b0377fedb652808 Al Viro   2017-06-29  254  		if (!__builtin_constant_p(bytes))
b0377fedb652808 Al Viro   2017-06-29  255  			copy_overflow(sz, bytes);
b0377fedb652808 Al Viro   2017-06-29  256  		else if (is_source)
b0377fedb652808 Al Viro   2017-06-29  257  			__bad_copy_from();
b0377fedb652808 Al Viro   2017-06-29  258  		else
b0377fedb652808 Al Viro   2017-06-29 @259  			__bad_copy_to();
b0377fedb652808 Al Viro   2017-06-29  260  		return false;
b0377fedb652808 Al Viro   2017-06-29  261  	}
6d13de1489b6bf5 Kees Cook 2019-12-04  262  	if (WARN_ON_ONCE(bytes > INT_MAX))
6d13de1489b6bf5 Kees Cook 2019-12-04  263  		return false;
b0377fedb652808 Al Viro   2017-06-29  264  	check_object_size(addr, bytes, is_source);
b0377fedb652808 Al Viro   2017-06-29  265  	return true;
b0377fedb652808 Al Viro   2017-06-29  266  }
b0377fedb652808 Al Viro   2017-06-29  267  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

