Return-Path: <linux-kselftest+bounces-26116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1991CA2D948
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 23:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACFC3A6BC5
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 22:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3576D1F2BA9;
	Sat,  8 Feb 2025 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTwWt4TE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA221F2B89;
	Sat,  8 Feb 2025 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739053817; cv=none; b=W/QxVT0bnccx8AnbFOucsEkRIS6D11OUo3c0U3QGww2PflQ/QT5Z1I8U13qEkxlB+DSYWLcUFyKhnxc1XmfLEgolnFPFgCJ2D0j+hMPCxzEruXDEI4eFjbM56PwX9dw6HoSH7RnOGU32M73dKiDQwOspRFMusTt4KPQu/aMD2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739053817; c=relaxed/simple;
	bh=QUj11CsSy8WVXJW4TTp1f2R/odv4DJQy02Qwct09Bxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCnXBNJyaZUMIczApdzH9KccwGJWUz9uAO0NSElWkWOPBhc20mMW1wAnxr2zqXpY432OQRw+nqxp9kFvdNOGBJWn/i+evaMpHsxWW+CM1P0pW5AeyyAsKDwveFZyAoSa6yZa+rDLZJe5zZE00Hx9LrbkVoQ8IvKGzBtXUaJbw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTwWt4TE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739053815; x=1770589815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QUj11CsSy8WVXJW4TTp1f2R/odv4DJQy02Qwct09Bxg=;
  b=bTwWt4TEfcEJz14lV5ltCgZlJYwTXIMgV8K1jYlMzqkwktyPBOxXBu3K
   wS/93YFR0GJHxNu6m7dCRQFEnZ2d2uZcmSp3IGsdjKbUirchbJqLJdb7c
   Vkt/aEmOLph4MxnudaWWwHsxfQx/CCodYe3Jb89+YbJsg/WyX1QdRuXmJ
   8YaWt/1mBuUOWoKYR1zaCPk6BULsJgrGbQt+SW/DGfZniYmOpf8YBQIxE
   zTgnzPgT8EVfwQvnapMgRrQnwSqR/+uZxBCjAlBjJCbnbhOKs/hC/Dstq
   bOpUAIXVS7OuKnp0+F2mFVBBbpTsh9Sih5omoZMICa9L7AWKKfTiWNMnH
   A==;
X-CSE-ConnectionGUID: wj/JbaOpR8mn92BkKValLw==
X-CSE-MsgGUID: idnFzOj6TrGvgsLsjs23wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="57204048"
X-IronPort-AV: E=Sophos;i="6.13,271,1732608000"; 
   d="scan'208";a="57204048"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 14:30:14 -0800
X-CSE-ConnectionGUID: nv0rcM/hQ7iMDYu8+mLPZg==
X-CSE-MsgGUID: neJqry3XT9WkTA0bI4fY0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,271,1732608000"; 
   d="scan'208";a="111790884"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 08 Feb 2025 14:30:12 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgtKz-0010iJ-0T;
	Sat, 08 Feb 2025 22:30:09 +0000
Date: Sun, 9 Feb 2025 06:29:45 +0800
From: kernel test robot <lkp@intel.com>
To: Tamir Duberstein <tamird@gmail.com>, David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH v2 2/2] lib/prime_numbers: convert self-test to KUnit
Message-ID: <202502090614.UJPLikn4-lkp@intel.com>
References: <20250208-prime_numbers-kunit-convert-v2-2-863119447e04@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208-prime_numbers-kunit-convert-v2-2-863119447e04@gmail.com>

Hi Tamir,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2014c95afecee3e76ca4a56956a936e23283f05b]

url:    https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/lib-math-Hook-up-tests-Makefile/20250208-220040
base:   2014c95afecee3e76ca4a56956a936e23283f05b
patch link:    https://lore.kernel.org/r/20250208-prime_numbers-kunit-convert-v2-2-863119447e04%40gmail.com
patch subject: [PATCH v2 2/2] lib/prime_numbers: convert self-test to KUnit
config: i386-buildonly-randconfig-002-20250209 (https://download.01.org/0day-ci/archive/20250209/202502090614.UJPLikn4-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250209/202502090614.UJPLikn4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502090614.UJPLikn4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/math/prime_numbers.c:126:8: error: call to undeclared function 'kmalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     126 |         new = kmalloc(sizeof(*new) + bitmap_size(sz),
         |               ^
   lib/math/prime_numbers.c:126:8: note: did you mean 'mm_alloc'?
   include/linux/sched/mm.h:16:26: note: 'mm_alloc' declared here
      16 | extern struct mm_struct *mm_alloc(void);
         |                          ^
>> lib/math/prime_numbers.c:126:6: error: incompatible integer to pointer conversion assigning to 'struct primes *' from 'int' [-Wint-conversion]
     126 |         new = kmalloc(sizeof(*new) + bitmap_size(sz),
         |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     127 |                       GFP_KERNEL | __GFP_NOWARN);
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~
>> lib/math/prime_numbers.c:134:3: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     134 |                 kfree(new);
         |                 ^
   3 errors generated.


vim +/kmalloc +126 lib/math/prime_numbers.c

cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  106  
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  107  static bool expand_to_next_prime(unsigned long x)
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  108  {
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  109  	const struct primes *p;
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  110  	struct primes *new;
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  111  	unsigned long sz, y;
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  112  
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  113  	/* Betrand's Postulate (or Chebyshev's theorem) states that if n > 3,
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  114  	 * there is always at least one prime p between n and 2n - 2.
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  115  	 * Equivalently, if n > 1, then there is always at least one prime p
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  116  	 * such that n < p < 2n.
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  117  	 *
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  118  	 * http://mathworld.wolfram.com/BertrandsPostulate.html
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  119  	 * https://en.wikipedia.org/wiki/Bertrand's_postulate
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  120  	 */
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  121  	sz = 2 * x;
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  122  	if (sz < x)
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  123  		return false;
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  124  
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  125  	sz = round_up(sz, BITS_PER_LONG);
717c8ae7aae4f2 lib/prime_numbers.c Chris Wilson 2017-01-13 @126  	new = kmalloc(sizeof(*new) + bitmap_size(sz),
717c8ae7aae4f2 lib/prime_numbers.c Chris Wilson 2017-01-13  127  		      GFP_KERNEL | __GFP_NOWARN);
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  128  	if (!new)
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  129  		return false;
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  130  
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  131  	mutex_lock(&lock);
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  132  	p = rcu_dereference_protected(primes, lockdep_is_held(&lock));
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  133  	if (x < p->last) {
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22 @134  		kfree(new);
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  135  		goto unlock;
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  136  	}
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  137  
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  138  	/* Where memory permits, track the primes using the
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  139  	 * Sieve of Eratosthenes. The sieve is to remove all multiples of known
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  140  	 * primes from the set, what remains in the set is therefore prime.
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  141  	 */
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  142  	bitmap_fill(new->primes, sz);
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  143  	bitmap_copy(new->primes, p->primes, p->sz);
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  144  	for (y = 2UL; y < sz; y = find_next_bit(new->primes, sz, y + 1))
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  145  		new->last = clear_multiples(y, new->primes, p->sz, sz);
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  146  	new->sz = sz;
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  147  
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  148  	BUG_ON(new->last <= x);
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  149  
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  150  	rcu_assign_pointer(primes, new);
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  151  	if (p != &small_primes)
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  152  		kfree_rcu((struct primes *)p, rcu);
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  153  
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  154  unlock:
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  155  	mutex_unlock(&lock);
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  156  	return true;
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  157  }
cf4a7207b1cb4a lib/prime_numbers.c Chris Wilson 2016-12-22  158  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

