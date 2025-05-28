Return-Path: <linux-kselftest+bounces-33944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EC5AC6D45
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 17:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2874E1BC7B6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AAD28C5C2;
	Wed, 28 May 2025 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mD9I6qF3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0BC286436;
	Wed, 28 May 2025 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447908; cv=none; b=bOUJeHb6X8PSEPAMO0ziwWfBZwvXJIfA0bupBTDP9nE48qygCEbelQ3SZqUZwfWkmxWTKK8HrMNcsK+6/xYYSRM92syCd+ZDwKa56XozuwcdD19FGHP+d68B6BIvSkmbIwDjDBOOGJUrLe118Mz6UJeVOtk23RT5+C1lVjrRVyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447908; c=relaxed/simple;
	bh=NIZUO6nfWzxOmDFR7kuS4TIBoOtvv4jh2sd4GzavqT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+uHYdfNyzZtR9pEl0o+3RxHD2x+ykFc6FQwuK0MxAHEFFTS2D/LOVD2KrLYuzDFa0GtRAl3emJQFdQCh+4/cDNnkSzk5YOCAcgOWi9hJ/A1UdpSDEpcEiYkF6YtIDJQi0ZhDTDfV9xqVaCKaejqx6v4i/rrJ5Xahj00c2cVNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mD9I6qF3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748447908; x=1779983908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NIZUO6nfWzxOmDFR7kuS4TIBoOtvv4jh2sd4GzavqT4=;
  b=mD9I6qF3nKN2HG0XnXD+sxfcnJnZkj2zevJTpFMGkU6HHoPGnotFIOjj
   ybEyWs3i34MNrLaqGreSY4G2EO45vSmfyrj/7XuBh/t2GgDaSlAL3zfl+
   feYExZ/GvPWQO/9jHeabNgldzNLaXW+meQiGchaQP27Phm3G3WKkRqU6U
   ++j5unesiiLgDNpLhzEGN83llExWKvinQ462sCh4RqUTzfqEroktNTXH+
   6mWkPFplitKdDZh1mbd3P+M10Oztpz2CprPd9SMZq7aQt5Ufuz7YmobaU
   SzpGUgttWjQRngHL7XsKF1sRgZQLIaYe9OYDwI+qe0X/Pb1+AuCbvGTyF
   A==;
X-CSE-ConnectionGUID: D/7DjDcEQNijX9zStQLZUA==
X-CSE-MsgGUID: 9wbXrTghRliEQhdjaqFTiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="67897079"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="67897079"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:58:27 -0700
X-CSE-ConnectionGUID: 8KS9rMUsR8uWNQsowgjXnQ==
X-CSE-MsgGUID: bU31e17nRDSY4Nv7jkm57w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="144248096"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 28 May 2025 08:58:22 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKJAZ-000Vou-2c;
	Wed, 28 May 2025 15:58:19 +0000
Date: Wed, 28 May 2025 23:57:43 +0800
From: kernel test robot <lkp@intel.com>
To: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH] rust: replace length checks with match
Message-ID: <202505282330.oOHtt60s-lkp@intel.com>
References: <20250527-idiomatic-match-slice-v1-1-34b0b1d1d58c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-idiomatic-match-slice-v1-1-34b0b1d1d58c@gmail.com>

Hi Tamir,

kernel test robot noticed the following build errors:

[auto build test ERROR on bfc3cd87559bc593bb32bb1482f9cae3308b6398]

url:    https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/rust-replace-length-checks-with-match/20250528-001121
base:   bfc3cd87559bc593bb32bb1482f9cae3308b6398
patch link:    https://lore.kernel.org/r/20250527-idiomatic-match-slice-v1-1-34b0b1d1d58c%40gmail.com
patch subject: [PATCH] rust: replace length checks with match
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250528/202505282330.oOHtt60s-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250528/202505282330.oOHtt60s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505282330.oOHtt60s-lkp@intel.com/

All errors (new ones prefixed by >>):

   PATH=/opt/cross/clang-18/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   INFO PATH=/opt/cross/rustc-1.78.0-bindgen-0.65.1/cargo/bin:/opt/cross/clang-18/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS= -Wno-error=return-type -Wreturn-type -funsigned-char -Wundef W=1 --keep-going LLVM=1 -j24 -C source O=/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=x86_64 SHELL=/bin/bash rustfmtcheck
   make: Entering directory '/kbuild/src/consumer'
   make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
>> Diff in scripts/rustdoc_test_gen.rs at line 90:
                "No path candidates found for `{file}`. This is likely a bug in the build system, or \
                some files went away while compiling."
            ),
   -        [valid_path] => {
   -            valid_path.to_str().unwrap()
   -        }
   +        [valid_path] => valid_path.to_str().unwrap(),
            valid_paths => {
                eprintln!("Several path candidates found:");
                for path in valid_paths {
   make[2]: *** [Makefile:1826: rustfmt] Error 123
   make[2]: Target 'rustfmtcheck' not remade because of errors.
   make[1]: Leaving directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'rustfmtcheck' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'rustfmtcheck' not remade because of errors.
   make: Leaving directory '/kbuild/src/consumer'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

