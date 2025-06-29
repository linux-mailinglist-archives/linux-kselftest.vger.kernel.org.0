Return-Path: <linux-kselftest+bounces-36066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C1CAECB9A
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 09:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D9616EAF0
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 07:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6471C1EFFB7;
	Sun, 29 Jun 2025 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHQ8Cg+D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865181E5018;
	Sun, 29 Jun 2025 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751183048; cv=none; b=aEQcy2oaNRJcQUS+a1mdQ4G0cqDXf1ViXEo9Bmq8J5AaOEI4GrmUDAKYChIpMwpTey1Ew8mg6FyrkcaW0R5A7HglwUYPY6+JLdQGeQddlLNpw6l+SYziB2S93uVrtUShKfWqBouOzlWtmIiIehSzuVnnfxNQGg8ahcGMoJ092uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751183048; c=relaxed/simple;
	bh=SEqy5zb+emFhpz7wJU3XLdetnXNP8qZL/erb9T+5OOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoYQqvmWquCmWSco2dTfVOOeaGaf2zIfOLrJ/C4fqnhHx+SFbHGtsbc96pwd9TjfhFnk3IzwacCRNQQgUcFM0D1nU+zGQtLkAZ/0Gpv4NT/d/6SfV/vfkSuz0OYE4bTmun7AvO6quTxiy1N9mi3m61k/AuKjNzGz2MYD14OASHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHQ8Cg+D; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751183046; x=1782719046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SEqy5zb+emFhpz7wJU3XLdetnXNP8qZL/erb9T+5OOs=;
  b=WHQ8Cg+DWH3RJ55jeMKQ8ahwfcZqZsMG9Gw8pSKZEhqYCzyt+xTYmSKv
   ee09UZf+D5g6O82Qfa5RgKh2dtnC7MNgFlL0NLsjC9EwymqlMXT1Ya8/S
   9m1d9ZNUJ/H+BcOCSXVFuOzYnPh0rfRQmsP9lDVk7bv1oNp0JE7UMvMgE
   NuzP0qz1saYVH+LlaobQ7OhpJORWOPD2xt5hO5bYhKXd7m6hJLh4CsRO6
   sW9hNWFL8XAgtfC3go6hhEC4cWJbOhs9lFs8fd5zHzeP6ImDlsP58gT+j
   NMxtSXUcbQRkQjP/btWVivCK18yefXSiTdMlqOSI65lOqgRKGER9upK77
   A==;
X-CSE-ConnectionGUID: i34v0/vARfO/lwDGhbkvnw==
X-CSE-MsgGUID: rw8DN9XrTDywFGrDgOwqag==
X-IronPort-AV: E=McAfee;i="6800,10657,11478"; a="64881137"
X-IronPort-AV: E=Sophos;i="6.16,274,1744095600"; 
   d="scan'208";a="64881137"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 00:44:05 -0700
X-CSE-ConnectionGUID: 768TlwaAQU20+qeUe/XL0Q==
X-CSE-MsgGUID: kJ0CsLdyQhaFtS8NBHabgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,274,1744095600"; 
   d="scan'208";a="152804225"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jun 2025 00:43:59 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVmhh-000XlG-0E;
	Sun, 29 Jun 2025 07:43:57 +0000
Date: Sun, 29 Jun 2025 15:43:42 +0800
From: kernel test robot <lkp@intel.com>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, airlied@gmail.com,
	simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, rafael@kernel.org, viresh.kumar@linaro.org,
	gregkh@linuxfoundation.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, davidgow@google.com,
	nm@ti.com, Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH v3 1/3] replace `#[allow(...)]` with `#[expect(...)]`
Message-ID: <202506291507.M9eg5kic-lkp@intel.com>
References: <20250628040956.2181-2-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628040956.2181-2-work@onurozkan.dev>

Hi Onur,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-next]
[also build test WARNING on driver-core/driver-core-linus rust/alloc-next shuah-kselftest/kunit shuah-kselftest/kunit-fixes rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.16-rc3]
[cannot apply to rust/rust-next driver-core/driver-core-testing rust/pin-init-next amd-pstate/linux-next amd-pstate/bleeding-edge next-20250627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Onur-zkan/replace-allow-with-expect/20250628-121734
base:   driver-core/driver-core-next
patch link:    https://lore.kernel.org/r/20250628040956.2181-2-work%40onurozkan.dev
patch subject: [PATCH v3 1/3] replace `#[allow(...)]` with `#[expect(...)]`
config: x86_64-randconfig-008-20250629 (https://download.01.org/0day-ci/archive/20250629/202506291507.M9eg5kic-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250629/202506291507.M9eg5kic-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506291507.M9eg5kic-lkp@intel.com/

All warnings (new ones prefixed by >>):

   ***
   *** Rust bindings generator 'bindgen' < 0.69.5 together with libclang >= 19.1
   *** may not work due to a bug (https://github.com/rust-lang/rust-bindgen/pull/2824),
   *** unless patched (like Debian's).
   ***   Your bindgen version:  0.65.1
   ***   Your libclang version: 20.1.7
   ***
   ***
   *** Please see Documentation/rust/quick-start.rst for details
   *** on how to set up the Rust support.
   ***
>> warning: this lint expectation is unfulfilled
   --> rust/kernel/opp.rs:603:14
   |
   603 |     #[expect(dead_code)]
   |              ^^^^^^^^^
   |
   = note: `#[warn(unfulfilled_lint_expectations)]` on by default
--
>> warning: this lint expectation is unfulfilled
   --> rust/kernel/opp.rs:605:14
   |
   605 |     #[expect(dead_code)]
   |              ^^^^^^^^^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

