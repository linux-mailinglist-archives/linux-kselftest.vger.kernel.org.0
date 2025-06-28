Return-Path: <linux-kselftest+bounces-36037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5B4AEC69B
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 13:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07E617C2E4
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F112D2459E0;
	Sat, 28 Jun 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZaWk2fyB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858301C6FE1;
	Sat, 28 Jun 2025 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751108397; cv=none; b=dIrOs9ZB0hm8Gp95zujZrWiFlOzuVvFcv+MIdC1iq07QPWdvUIhsTOGAliyqH010nk0Iq/N2AFQajlqwKElsbI+BV0RRkTfmYz197IyohYn4Cw8R0BT+w8NbBbVKeqIi5NjM76qgcyi5rlYO7PKli2Rj0FV50TIaOUIbW8FPjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751108397; c=relaxed/simple;
	bh=PyS8+QY/Xp3+/7gWrQEE7t6DJx4VoFwvrUEY7A9l/GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJhVWQxXHYo99cmXF8t0M7OKgtXp0sg3kdSRXvFk5vTdLntzn3qlH/rPCwAs8OJrDol/bucY0s1xQk9+9J1pumePUtA3w/10Yi9DAPTC87GNUKhRXVGiUXeArKiS2jYddlkUuC+B6aURslj7i6sxDkwsTdE0cwHDeeCkmoOrUFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZaWk2fyB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751108395; x=1782644395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PyS8+QY/Xp3+/7gWrQEE7t6DJx4VoFwvrUEY7A9l/GI=;
  b=ZaWk2fyBkeOAE1nNiiSUVUUqSiHgTg86oK+fsRhxKnHwPDlQwASk9Rms
   JnXfTpJK6n1Oz5VD4csBoXX7crawzKlJjBedv4W4hWu5cmEtNCp2UzlTt
   BlsWNw/gXyRnAj8CtPbYE78rT0yNpKDb1c5hfRxgpvaNlqZl7e7v89Qj/
   58QvL7eg7tZ+c7Zlvw7cEdcvJ4RKn4/veBzWvbIm3aoVw+4peW4n1OD7h
   oaZNFu8xxAwSitc2ppbp7VqVwV8w1EJg9p9rN55FMpSztNeLW9YHMcnZk
   0PQ0Cna9z8B/ANIhuQ5W4Bykn4BP/AGZIsPYtfsDd7nt31ivik9zbDHzu
   A==;
X-CSE-ConnectionGUID: 43P9aotRSZCQ11IvybAtbw==
X-CSE-MsgGUID: h+ZrgN41S12QaUp5voNOQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="57084628"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="57084628"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 03:59:54 -0700
X-CSE-ConnectionGUID: Xskm3iphRuGr/JSLtxvKCg==
X-CSE-MsgGUID: FzYXCsYPR720uxl4LGMD/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="152750678"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 28 Jun 2025 03:59:50 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVTHf-000Wzi-1z;
	Sat, 28 Jun 2025 10:59:47 +0000
Date: Sat, 28 Jun 2025 18:59:11 +0800
From: kernel test robot <lkp@intel.com>
To: Tiffany Yang <ynaffit@google.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	keescook@google.com, kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 4/5] binder: Convert binder_alloc selftests to KUnit
Message-ID: <202506281837.hReNHJjO-lkp@intel.com>
References: <20250627203748.881022-5-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627203748.881022-5-ynaffit@google.com>

Hi Tiffany,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on staging/staging-next staging/staging-linus shuah-kselftest/kunit shuah-kselftest/kunit-fixes linus/master v6.16-rc3 next-20250627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tiffany-Yang/binder-Fix-selftest-page-indexing/20250628-044044
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20250627203748.881022-5-ynaffit%40google.com
patch subject: [PATCH 4/5] binder: Convert binder_alloc selftests to KUnit
config: x86_64-buildonly-randconfig-002-20250628 (https://download.01.org/0day-ci/archive/20250628/202506281837.hReNHJjO-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250628/202506281837.hReNHJjO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506281837.hReNHJjO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/android/tests/binder_alloc_kunit.c:326 function parameter 'test' not described in 'binder_alloc_exhaustive_test'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

