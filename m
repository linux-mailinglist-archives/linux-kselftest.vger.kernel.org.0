Return-Path: <linux-kselftest+bounces-28763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA73A5CF38
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE546189A33C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4B0263F4E;
	Tue, 11 Mar 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1vFLHq4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41540263C88;
	Tue, 11 Mar 2025 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720977; cv=none; b=ff7qcIlit3KsgxGuqFiinpu3LKWmx8dZK6GV8FYVGAQVcoq7uREgcwVFiCnJJR2PnACiZ1QR0UAdWpIEG3PyD0hNu0HYSjvTLP1Rbfx2U1B3fH9e10O85+IMK6FycsJ6XQusIoaWc1nEGZoam/RDGb+4wxxye+ZD4X9ddF/AG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720977; c=relaxed/simple;
	bh=5BQSyaBQxUFZeErA3U7SLVLmiRtJYGd9Vyqr3I7dCeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHCVk2dag3JlkbIiRuWu0OsmtL3YUji8T8JcedvY5dR3xPGCcp75L3D3vMB7pVtxr/GtxmVC1/8EKXXRXybulEnz+DuTdHndbIHiD32IUslFujaAoHtvhsJfYX8cMwRitb/0z2mtRYTHQX41BL1nPi6Me6eYR/jM9Q8qrG8TYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1vFLHq4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741720976; x=1773256976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5BQSyaBQxUFZeErA3U7SLVLmiRtJYGd9Vyqr3I7dCeE=;
  b=P1vFLHq44APE7p052VDH4TvOR3gYwmVmcM23o0rOaYG4EqF+/7wj/XHh
   NatotfSapM6rr9N4hHfYvNzI1DY1DNZfRPWHNxaGV1WL6JuGX0DWELAcG
   tgteJyczSp8gp+E/77fXNCBAriWE8hMwwxwc8W3I99uK4fbza6U1dMzqL
   F/qh4H7kO4OL6db89KnkAJmnExmN3SX41TU2hNpGvRLRcl3IFaSYE+/Ix
   1uXJTjWCTT2ZPit1QWxpLaH+MWFUvsNQgnf0dt2ejD3LTseJS2ENsAW5u
   sVB0OTBpxlvVPfqexEpJ0/W4oy7F6TBLypIGKPyjMTeNwn+y/REwf1I8w
   w==;
X-CSE-ConnectionGUID: jcbTnxD2TfGl3Xm6pRhF2g==
X-CSE-MsgGUID: Gex8OomZQAmIKWSI248Muw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="68140538"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="68140538"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 12:22:55 -0700
X-CSE-ConnectionGUID: NenFRhsnSMyQfY/xGuDGFQ==
X-CSE-MsgGUID: YFmv9pF4TY2TRKohK66sOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="120913249"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 11 Mar 2025 12:22:49 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts5Bf-0007m8-0w;
	Tue, 11 Mar 2025 19:22:47 +0000
Date: Wed, 12 Mar 2025 03:22:20 +0800
From: kernel test robot <lkp@intel.com>
To: Tamir Duberstein <tamird@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH] rust: enable `clippy::ptr_as_ptr` lint
Message-ID: <202503120332.YTCpFEvv-lkp@intel.com>
References: <20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com>

Hi Tamir,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ff64846bee0e7e3e7bc9363ebad3bab42dd27e24]

url:    https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/rust-enable-clippy-ptr_as_ptr-lint/20250308-004557
base:   ff64846bee0e7e3e7bc9363ebad3bab42dd27e24
patch link:    https://lore.kernel.org/r/20250307-ptr-as-ptr-v1-1-582d06514c98%40gmail.com
patch subject: [PATCH] rust: enable `clippy::ptr_as_ptr` lint
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250312/202503120332.YTCpFEvv-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503120332.YTCpFEvv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503120332.YTCpFEvv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: `as` casting between raw pointers without changing its mutability
   --> rust/kernel/firmware.rs:64:35
   |
   64 |         let ret = unsafe { func.0(pfw as _, name.as_char_ptr(), dev.as_raw()) };
   |                                   ^^^^^^^^ help: try `pointer::cast`, a safer alternative: `pfw.cast()`
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#ptr_as_ptr
   = note: requested on the command line with `-W clippy::ptr-as-ptr`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

