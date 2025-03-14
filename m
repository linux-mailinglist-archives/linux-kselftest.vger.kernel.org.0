Return-Path: <linux-kselftest+bounces-28995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCD0A6097A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 08:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C6117EC94
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 07:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B5119004B;
	Fri, 14 Mar 2025 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/6ooFJU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D17218D634;
	Fri, 14 Mar 2025 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936261; cv=none; b=QfNQ2UNtK8ey7gFuW7PyC9Z3IrKPA9SPiRNFCnIuQwyXCcmeR3Qmlk2JFgtlT6IgJwSEcb7jYvRnCHyXnmR+tva49+sM4WmEtAo+gObi9zEI5pikZOyLZRXYZlrlkv/n9p8i11+8j/eXj9zceRRmqSo4GCsaL7rSGSvkvC7Q7aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936261; c=relaxed/simple;
	bh=IKdBA13JupXjDh3Rlpq56k/VtfWKKPwKkrryIgel3M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFlPVTtRYFPEe5tcvEZ7SBXB+ikdcxztXgFFnaVOjGk7ETiKZsjOOr+dWfZBnuEI0SzB/9CMbbNLW9KYWeBpqAMYyxNWJN4Xeihr7LJ8MGiyKGmrpsrQ1wsrTsIWym99k0XEXUt1rSK2uqNVOt6r1xqmKZYOPyLCC/TMCI30eYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/6ooFJU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741936259; x=1773472259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IKdBA13JupXjDh3Rlpq56k/VtfWKKPwKkrryIgel3M0=;
  b=S/6ooFJUq3S8esuLPHi2a3NmhCBHmguXa1GNRAHBQvLoBXg+m363u1a6
   tcYNcKQTI50iSypl7lPrFVcqZBLPNQetic6279QN3gISqu++MO2JccqH5
   JIlUoRw3MfaO5R4CCdrcVZvA13ImfjlMXyrdMSc5J93WPNiYCocP9wyFq
   4F9DS0oSBDqo8oYWtOw0+KWi7DDaeKuXDSFRHaujjjb2/My/Bsjp04Tw3
   cJs9wlj6udVeoBxmmTetXQao3opnrQDSsuyJVbPwe4Z9hrTTwEptYybBw
   ACBGgp2gj4tYINcwsyQU69hllaTABL/ksQiaqOvjyuAK39A1triA81LGi
   w==;
X-CSE-ConnectionGUID: IuwbHh/HRwGw0KhvTcFYWg==
X-CSE-MsgGUID: BREprz79SIe8h6RyMRcOhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60477872"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="60477872"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 00:10:58 -0700
X-CSE-ConnectionGUID: eUsGcmroQlSQOhljXpJKeA==
X-CSE-MsgGUID: FcXeWHeuQRmvAF80w9bpgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121390713"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 14 Mar 2025 00:10:52 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tszBy-000ABs-0z;
	Fri, 14 Mar 2025 07:10:50 +0000
Date: Fri, 14 Mar 2025 15:10:26 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Hickey <contact@antoniohickey.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Antonio Hickey <contact@antoniohickey.com>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: replace `addr_of[_mut]!` with `&raw [mut]`
Message-ID: <202503141434.n6oUhRIM-lkp@intel.com>
References: <010001958dfec447-37d6d276-32f8-4b4e-b7bd-6d7ce2570ee2-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001958dfec447-37d6d276-32f8-4b4e-b7bd-6d7ce2570ee2-000000@email.amazonses.com>

Hi Antonio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rust/rust-next]
[also build test WARNING on driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.14-rc6 next-20250313]
[cannot apply to shuah-kselftest/kunit shuah-kselftest/kunit-fixes pci/next pci/for-linus rust/rust-block-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antonio-Hickey/rust-clippy-disable-addr_of-and-addr_of_mut-macros/20250313-133646
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/010001958dfec447-37d6d276-32f8-4b4e-b7bd-6d7ce2570ee2-000000%40email.amazonses.com
patch subject: [PATCH 3/3] rust: replace `addr_of[_mut]!` with `&raw [mut]`
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250314/202503141434.n6oUhRIM-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250314/202503141434.n6oUhRIM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503141434.n6oUhRIM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: consider removing unnecessary double parentheses
   --> rust/kernel/faux.rs:48:41
   |
   48 |         unsafe { device::Device::as_ref((&raw mut (*self.as_raw()).dev)) }
   |                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#double_parens
   = note: `-W clippy::double-parens` implied by `-W clippy::all`
   = help: to override `-W clippy::all` add `#[allow(clippy::double_parens)]`
--
>> warning: unnecessary parentheses around function argument
   --> rust/kernel/faux.rs:48:41
   |
   48 |         unsafe { device::Device::as_ref((&raw mut (*self.as_raw()).dev)) }
   |                                         ^                             ^
   |
   = note: `#[warn(unused_parens)]` on by default
   help: remove these parentheses
   |
   48 -         unsafe { device::Device::as_ref((&raw mut (*self.as_raw()).dev)) }
   48 +         unsafe { device::Device::as_ref(&raw mut (*self.as_raw()).dev) }
   |
--
>> warning: immediately dereferencing a reference
   --> rust/kernel/task.rs:260:28
   |
   260 |         let ptr = unsafe { *(&raw const (*self.as_ptr()).group_leader) };
   |                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: try: `(*self.as_ptr()).group_leader`
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#deref_addrof
   = note: `-W clippy::deref-addrof` implied by `-W clippy::all`
   = help: to override `-W clippy::all` add `#[allow(clippy::deref_addrof)]`
--
>> warning: immediately dereferencing a reference
   --> rust/kernel/task.rs:272:18
   |
   272 |         unsafe { *(&raw const (*self.as_ptr()).pid) }
   |                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: try: `(*self.as_ptr()).pid`
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#deref_addrof

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

