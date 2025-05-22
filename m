Return-Path: <linux-kselftest+bounces-33506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6886CAC0AB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 13:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0963D4E1673
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 11:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B6A28A1CC;
	Thu, 22 May 2025 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AmdGBUZ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A24A2B9A9;
	Thu, 22 May 2025 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747914047; cv=none; b=pG/6A0KJGk3Jw1neDS2fsPGhTjHE4g1CMd/Ksnc+QvFa8AAM1E1jMVa8M36WSRalYvoGCA3WODYfrJz7Z6qZIi/qn3xScoPEzWWIzQlpFze+iVaT9lHFH7Ko4U4ws+tvvQReAe53YcUPeBseTHCu3yDWIf4Ofz0AnJegdYKVFx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747914047; c=relaxed/simple;
	bh=e+vjqzSiyrLvqGxozyE2cidSZJ3fe1rnznsk3/YQKMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdPhfxZpk/g0i1TeA0cWpvs9Z1tajCYJXGShowdRf0V1+k6xWSZOut+hV2ppdb+giNKibPfaAswqQHAHlhK07AcXt2NAG0hpgB2geSs3W1GjXKnWs5cUWz/ChNiFhwe6U4IRAjEhxjmT1/y4eOlm26ET4bJ2ekBQ+Q2r0lNTBo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AmdGBUZ6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747914044; x=1779450044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=e+vjqzSiyrLvqGxozyE2cidSZJ3fe1rnznsk3/YQKMo=;
  b=AmdGBUZ6NGFZK9t8hpLsHttCGaEbT3fD7zY44OqQEZcU5HiTzmnTTyku
   3FfZ/csyDO7Ni67Rv7U0WHXrOuwWQ4bwgkyt+YQsouJh5SQuC4pV4vDMN
   CKuQi02WJ1j/xI46m5eXVtq7/QVwRsluX+EyiNNeVAisxH6xuPRM2Uh/R
   Hlwfeg3ltLrVxXoHkN/Z3bS15ED1cTRmFoUnfITXUbqcXp97j16Kv4ZxX
   BUUgymwztGe/N/T/jRQ0e/ORapD3wZtoMNT9JiNcq5cHhbvzMySCZRu+T
   UMZvcbg/qdM0ivvHbZkc8eefwDXUrwNBGMFmZ00If8u6WoMGMlK6st1T4
   g==;
X-CSE-ConnectionGUID: 2cqHG/tBQ7atRRqMYrRqOw==
X-CSE-MsgGUID: 7Xr/tVgBRdyJ/95K4IK7XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49642216"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="49642216"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 04:40:43 -0700
X-CSE-ConnectionGUID: Nroz4pm3RAmVvUYPYBSdMw==
X-CSE-MsgGUID: oLrZUywOTCSzMVKdQjKoyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="140432837"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 22 May 2025 04:40:39 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uI4Ht-000PHs-0Q;
	Thu, 22 May 2025 11:40:37 +0000
Date: Thu, 22 May 2025 19:39:54 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v4 4/7] futex: Create set_robust_list2
Message-ID: <202505221953.JKgFsA3U-lkp@intel.com>
References: <20250520-tonyk-robust_futex-v4-4-1123093e59de@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250520-tonyk-robust_futex-v4-4-1123093e59de@igalia.com>

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3ee84e3dd88e39b55b534e17a7b9a181f1d46809]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/selftests-futex-Add-ASSERT_-macros/20250521-045231
base:   3ee84e3dd88e39b55b534e17a7b9a181f1d46809
patch link:    https://lore.kernel.org/r/20250520-tonyk-robust_futex-v4-4-1123093e59de%40igalia.com
patch subject: [PATCH v4 4/7] futex: Create set_robust_list2
config: arm-randconfig-r122-20250522 (https://download.01.org/0day-ci/archive/20250522/202505221953.JKgFsA3U-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce: (https://download.01.org/0day-ci/archive/20250522/202505221953.JKgFsA3U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505221953.JKgFsA3U-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/futex/core.c:581:38: sparse: sparse: cast removes address space '__user' of expression
   kernel/futex/core.c:581:51: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] [usertype] __user *naddr @@     got void * @@
   kernel/futex/core.c:581:51: sparse:     expected unsigned int [noderef] [usertype] __user *naddr
   kernel/futex/core.c:581:51: sparse:     got void *
   kernel/futex/core.c:597:38: sparse: sparse: cast removes address space '__user' of expression
   kernel/futex/core.c:597:51: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] [usertype] __user *naddr @@     got void * @@
   kernel/futex/core.c:597:51: sparse:     expected unsigned int [noderef] [usertype] __user *naddr
   kernel/futex/core.c:597:51: sparse:     got void *
   kernel/futex/core.c:1268:59: sparse: sparse: cast removes address space '__user' of expression
>> kernel/futex/core.c:1268:59: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected unsigned int [noderef] [usertype] __user *head @@     got unsigned int [usertype] * @@
   kernel/futex/core.c:1268:59: sparse:     expected unsigned int [noderef] [usertype] __user *head
   kernel/futex/core.c:1268:59: sparse:     got unsigned int [usertype] *
   kernel/futex/core.c:978:9: sparse: sparse: context imbalance in 'futex_q_lockptr_lock' - wrong count at exit

vim +1268 kernel/futex/core.c

04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1247  
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1248  /*
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1249   * Walk curr->robust_list (very carefully, it's a userspace list!)
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1250   * and mark any locks found there dead, and notify any waiters.
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1251   *
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1252   * We silently return on any sign of list-walking problem.
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1253   */
1c5e99b662506e kernel/futex/core.c André Almeida 2025-05-20  1254  static void exit_robust_list32(struct task_struct *curr,
1c5e99b662506e kernel/futex/core.c André Almeida 2025-05-20  1255  			       struct robust_list_head32 __user *head)
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1256  {
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1257  	struct robust_list __user *entry, *next_entry, *pending;
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1258  	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
3f649ab728cda8 kernel/futex.c      Kees Cook     2020-06-03  1259  	unsigned int next_pi;
b9412773325c3a kernel/futex/core.c André Almeida 2025-05-20  1260  	u32 uentry, next_uentry, upending;
b9412773325c3a kernel/futex/core.c André Almeida 2025-05-20  1261  	s32 futex_offset;
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1262  	int rc;
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1263  
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1264  	/*
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1265  	 * Fetch the list head (which was registered earlier, via
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1266  	 * sys_set_robust_list()):
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1267  	 */
b9412773325c3a kernel/futex/core.c André Almeida 2025-05-20 @1268  	if (fetch_robust_entry32((u32 *)&uentry, &entry, (u32 *)&head->list.next, &pi))
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1269  		return;
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1270  	/*
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1271  	 * Fetch the relative futex offset:
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1272  	 */
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1273  	if (get_user(futex_offset, &head->futex_offset))
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1274  		return;
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1275  	/*
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1276  	 * Fetch any possibly pending lock-add first, and handle it
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1277  	 * if it exists:
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1278  	 */
b9412773325c3a kernel/futex/core.c André Almeida 2025-05-20  1279  	if (fetch_robust_entry32(&upending, &pending,
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1280  			       &head->list_op_pending, &pip))
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1281  		return;
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1282  
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1283  	next_entry = NULL;	/* avoid warning with gcc */
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1284  	while (entry != (struct robust_list __user *) &head->list) {
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1285  		/*
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1286  		 * Fetch the next entry in the list before calling
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1287  		 * handle_futex_death:
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1288  		 */
b9412773325c3a kernel/futex/core.c André Almeida 2025-05-20  1289  		rc = fetch_robust_entry32(&next_uentry, &next_entry,
b9412773325c3a kernel/futex/core.c André Almeida 2025-05-20  1290  			(u32 __user *)&entry->next, &next_pi);
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1291  		/*
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1292  		 * A pending lock might already be on the list, so
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1293  		 * dont process it twice:
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1294  		 */
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1295  		if (entry != pending) {
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1296  			void __user *uaddr = futex_uaddr(entry, futex_offset);
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1297  
ca16d5bee59807 kernel/futex.c      Yang Tao      2019-11-06  1298  			if (handle_futex_death(uaddr, curr, pi,
ca16d5bee59807 kernel/futex.c      Yang Tao      2019-11-06  1299  					       HANDLE_DEATH_LIST))
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1300  				return;
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1301  		}
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1302  		if (rc)
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1303  			return;
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1304  		uentry = next_uentry;
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1305  		entry = next_entry;
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1306  		pi = next_pi;
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1307  		/*
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1308  		 * Avoid excessively long or circular lists:
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1309  		 */
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1310  		if (!--limit)
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1311  			break;
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1312  
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1313  		cond_resched();
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1314  	}
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1315  	if (pending) {
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1316  		void __user *uaddr = futex_uaddr(pending, futex_offset);
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1317  
ca16d5bee59807 kernel/futex.c      Yang Tao      2019-11-06  1318  		handle_futex_death(uaddr, curr, pip, HANDLE_DEATH_PENDING);
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1319  	}
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1320  }
04e7712f446058 kernel/futex.c      Arnd Bergmann 2018-04-17  1321  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

