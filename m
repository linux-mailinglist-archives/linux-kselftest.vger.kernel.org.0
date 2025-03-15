Return-Path: <linux-kselftest+bounces-29119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02795A627F5
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 08:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C7E16CB51
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 07:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351851DF98F;
	Sat, 15 Mar 2025 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBwhn4uB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F6B1DE2DB;
	Sat, 15 Mar 2025 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742023053; cv=none; b=IdAJVFDoMTonoVPs9Fof1ZeGgL1aI+Dw+N2pg6Vfmm1EvKjX37fo2n9qRMOHoZBpcnALPcQsRdpHXQgwMSdx7AM29lLrpefhCtUZWc0jEIatgGO2QBgjwFTiewAgv9jMcI7opOfF8UDrKo01M7iecv/iOJitM/rZXNo+yLGGhDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742023053; c=relaxed/simple;
	bh=D6dyM5fcK5sfnzdnunmUBGtPiFQ2gHj2jDLotPVsetI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1UJ9fDU4xwAgAyekV136GylZF7MHOxKo8iUZ7ntOeZMBQSx5y2ZwW3N5ekz0rCHkyrjUJy4McgAD6CdipcF5X0dGahx5DMIpZeOpzGxwP/8+SaU3E3IZMzvcprkkdCZsKbNEMN3vKSoNoDvZItfPSlrWbX/h6YkQeCOYGtBq/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBwhn4uB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742023051; x=1773559051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D6dyM5fcK5sfnzdnunmUBGtPiFQ2gHj2jDLotPVsetI=;
  b=PBwhn4uBbLumsUFXXThK5dL5rz2PTmMmNzHUY0FIDNwL/yF9GSh1iooc
   ZkOL/KqBoMA1yHhuUaJKy1MDg7R/ynEl4XXmpCho3IX2mTAgznebzN3Ez
   tH5ilKB9FSvVn8NzyNeVWQEEcWN3QlJ/gVKpqgapAWJXR5CPmpdXgc37I
   BJAj9uU/atupGJ/uF0qVWkLIcjojL+1DDBsoVcsBnP1HJUboiJS5ZXV4c
   s8kSj6WYuRZudNHJ1gxAwwu0fRJXwVlxjPPtHe+0nqDRYE9i9g/5nHthQ
   Dsc/AAjJ2bzrIKah7AyC4oecF6lmz3NGDFyldJmSx+qGwcbDvmkWN8Tw1
   Q==;
X-CSE-ConnectionGUID: 1qdPOMgASdy5BJ1+6Nx6Rw==
X-CSE-MsgGUID: yAeKQXamRv+Ui08CRRk03Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="42427589"
X-IronPort-AV: E=Sophos;i="6.14,249,1736841600"; 
   d="scan'208";a="42427589"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 00:17:31 -0700
X-CSE-ConnectionGUID: mbIXekZnRfqWbHnE0G4Uaw==
X-CSE-MsgGUID: FtpkTt5YQleFCTfAFY66RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,249,1736841600"; 
   d="scan'208";a="125685350"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 15 Mar 2025 00:17:22 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttLln-000B7l-1S;
	Sat, 15 Mar 2025 07:17:19 +0000
Date: Sat, 15 Mar 2025 15:16:20 +0800
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
	Bjorn Helgaas <helgaas@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v3 6/6] rust: use strict provenance APIs
Message-ID: <202503151519.6bGsjUd3-lkp@intel.com>
References: <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com>

Hi Tamir,

kernel test robot noticed the following build errors:

[auto build test ERROR on a1eb95d6b5f4cf5cc7b081e85e374d1dd98a213b]

url:    https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/rust-retain-pointer-mut-ness-in-container_of/20250315-003150
base:   a1eb95d6b5f4cf5cc7b081e85e374d1dd98a213b
patch link:    https://lore.kernel.org/r/20250314-ptr-as-ptr-v3-6-e7ba61048f4a%40gmail.com
patch subject: [PATCH v3 6/6] rust: use strict provenance APIs
config: x86_64-randconfig-002-20250315 (https://download.01.org/0day-ci/archive/20250315/202503151519.6bGsjUd3-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250315/202503151519.6bGsjUd3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503151519.6bGsjUd3-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
   |                            ~~~~~~~~~~~~~~~~~~~~~ ^
   505 |                            item];
   |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
   |                            ~~~~~~~~~~~~~~~~~~~~~ ^
   512 |                            NR_VM_NUMA_EVENT_ITEMS +
   |                            ~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.
   ***
   *** Rust bindings generator 'bindgen' < 0.69.5 together with libclang >= 19.1
   *** may not work due to a bug (https://github.com/rust-lang/rust-bindgen/pull/2824),
   *** unless patched (like Debian's).
   ***   Your bindgen version:  0.65.1
   ***   Your libclang version: 19.1.7
   ***
   ***
   *** Please see Documentation/rust/quick-start.rst for details
   *** on how to set up the Rust support.
   ***
   In file included from rust/helpers/helpers.c:10:
   In file included from rust/helpers/blk.c:3:
   In file included from include/linux/blk-mq.h:5:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
   |                            ~~~~~~~~~~~~~~~~~~~~~ ^
   505 |                            item];
   |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
   |                            ~~~~~~~~~~~~~~~~~~~~~ ^
   512 |                            NR_VM_NUMA_EVENT_ITEMS +
   |                            ~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.
   clang diag: include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>> error[E0425]: cannot find function `with_exposed_provenance` in module `core::ptr`
   --> rust/kernel/lib.rs:37:20
   |
   37  |         core::ptr::with_exposed_provenance(addr)
   |                    ^^^^^^^^^^^^^^^^^^^^^^^
   |
   ::: /opt/cross/rustc-1.78.0-bindgen-0.65.1/rustup/toolchains/1.78.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/ptr/mod.rs:593:1
   |
   593 | pub const fn without_provenance<T>(addr: usize) -> *const T {
   | ----------------------------------------------------------- similarly named function `without_provenance` defined here
   |
   help: a function with a similar name exists
   |
   37  |         core::ptr::without_provenance(addr)
   |                    ~~~~~~~~~~~~~~~~~~
   help: consider importing this function through its public re-export
   |
   30  +     use crate::with_exposed_provenance;
   |
   help: if you import `with_exposed_provenance`, refer to it directly
   |
   37  -         core::ptr::with_exposed_provenance(addr)
   37  +         with_exposed_provenance(addr)
   |
--
>> error[E0425]: cannot find function `with_exposed_provenance_mut` in module `core::ptr`
   --> rust/kernel/lib.rs:42:20
   |
   42  |         core::ptr::with_exposed_provenance_mut(addr)
   |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   ::: /opt/cross/rustc-1.78.0-bindgen-0.65.1/rustup/toolchains/1.78.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/ptr/mod.rs:637:1
   |
   637 | pub const fn without_provenance_mut<T>(addr: usize) -> *mut T {
   | ------------------------------------------------------------- similarly named function `without_provenance_mut` defined here
   |
   help: a function with a similar name exists
   |
   42  |         core::ptr::without_provenance_mut(addr)
   |                    ~~~~~~~~~~~~~~~~~~~~~~
   help: consider importing this function through its public re-export
   |
   30  +     use crate::with_exposed_provenance_mut;
   |
   help: if you import `with_exposed_provenance_mut`, refer to it directly
   |
   42  -         core::ptr::with_exposed_provenance_mut(addr)
   42  +         with_exposed_provenance_mut(addr)
   |
--
>> error[E0599]: no method named `expose_provenance` found for raw pointer `*const T` in the current scope
   --> rust/kernel/lib.rs:32:14
   |
   32 |         addr.expose_provenance()
   |              ^^^^^^^^^^^^^^^^^ method not found in `*const T`
   |
   = note: try using `<*const T>::as_ref()` to get a reference to the type behind the pointer: https://doc.rust-lang.org/std/primitive.pointer.html#method.as_ref
   = note: using `<*const T>::as_ref()` on a pointer which is unaligned or points to invalid or uninitialized memory is undefined behavior

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

