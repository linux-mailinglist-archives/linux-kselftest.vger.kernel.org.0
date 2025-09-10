Return-Path: <linux-kselftest+bounces-41118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8F6B514CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 13:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FB016F81E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 11:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4C231984C;
	Wed, 10 Sep 2025 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuPgdsxv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6CF314A99;
	Wed, 10 Sep 2025 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502371; cv=none; b=XpuG2rzyeuOocBRHZJChI50jB2NSkclHJZf5sS2LA1kZz/vUc6FR3QLBBMjEvJkzjRgL6caAJ6HpCQjqncW14DvBLUJSBeLsdlBVfeFgeNYvHSbpZmT1p6oIanqYM5KLprSLOqcMf39MFoa3RFvCJW5i619+ggN5TM6PgNQvg8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502371; c=relaxed/simple;
	bh=Fxptr2qexEblRNttIxD7S3z3TKAgwwVEg+pPWRBq01A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaUpxOO1YWB+X6sVnCCmpjqdFxN39+ZC0X/S74JyM3mRtu9O0JjpH5G+Xa7daEr90NqBiSusuE5zr52pVeInDn4cQqpXXeE/ifknT7b3UEXCM8ingZuoDdBPwQ98x9/9bCyybF56Uiz4ryuDKpY2+fkYIS5V6stLHJ4ZhdF4uVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuPgdsxv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757502370; x=1789038370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fxptr2qexEblRNttIxD7S3z3TKAgwwVEg+pPWRBq01A=;
  b=HuPgdsxvwYVeRgWXgVU15jWE+Y1bLzxxBERawXZvk9rt1bDrTQEBhCcp
   GYEb0uP1yM8L9vU1kP45jjkdzZ0UVjEcY5frmJK0gIBfuVIDl2CWwqG35
   G49KCQj2Fi94klootOgG7OVzbx82latk4xc2EH9dmWZHx4WFxOU2OKNMJ
   ZiZxhUZsQCYdy4SOrdGZeLn65H1mqfrsfWr+PJWPqJgdoTy66T1b8qHvv
   eJ/hqRXCsZaA64qtpmzbVHwGoGO1LRGAuzllpOj7Qb64f4ayYF23RUEuC
   wdpOnnVyHkOmhMg7I7YlJUiLMGYSmeJ5eDfInxdBWu7BGyPsyNG7/6jXg
   Q==;
X-CSE-ConnectionGUID: AjP1+qe+TMG9mwqh3VnR7Q==
X-CSE-MsgGUID: eMl+r7fmTpWTkxTiJlzwew==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="63437200"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="63437200"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 04:06:09 -0700
X-CSE-ConnectionGUID: xUB8gn45TLq9bHG9qWK/Dw==
X-CSE-MsgGUID: S7dTMi/zQGS8UXVg1xZs/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="173276811"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Sep 2025 04:06:06 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwIeJ-0005rT-21;
	Wed, 10 Sep 2025 11:06:03 +0000
Date: Wed, 10 Sep 2025 19:05:22 +0800
From: kernel test robot <lkp@intel.com>
To: Andre Carvalho <asantostc@gmail.com>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Andre Carvalho <asantostc@gmail.com>
Subject: Re: [PATCH net-next 4/5] netconsole: resume previously deactivated
 target
Message-ID: <202509101818.wKicbxgJ-lkp@intel.com>
References: <20250909-netcons-retrigger-v1-4-3aea904926cf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-netcons-retrigger-v1-4-3aea904926cf@gmail.com>

Hi Andre,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3b4296f5893d3a4e19edfc3800cb79381095e55f]

url:    https://github.com/intel-lab-lkp/linux/commits/Andre-Carvalho/netconsole-add-target_state-enum/20250910-051601
base:   3b4296f5893d3a4e19edfc3800cb79381095e55f
patch link:    https://lore.kernel.org/r/20250909-netcons-retrigger-v1-4-3aea904926cf%40gmail.com
patch subject: [PATCH net-next 4/5] netconsole: resume previously deactivated target
config: i386-randconfig-014-20250910 (https://download.01.org/0day-ci/archive/20250910/202509101818.wKicbxgJ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250910/202509101818.wKicbxgJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509101818.wKicbxgJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/netconsole.c:177 struct member 'resume_wq' not described in 'netconsole_target'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

