Return-Path: <linux-kselftest+bounces-46310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C965BC7C8DC
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 07:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3880A35BF8A
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 06:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F912F1FD1;
	Sat, 22 Nov 2025 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7V1JzSA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D441F91F6;
	Sat, 22 Nov 2025 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763794243; cv=none; b=DkHJ9neG3wOHvMPJHDTqEADkVdNVT5C7Bg52eWIa2OOl6574scTym+qX6xByG/o0EZif0IYSE5CFQC3nw/Z2+mMLDkU/2Go0flj/4QD73k2zFKHHW4AB8ZLJCGMDt4gDyMA9AlhzYXVrTRsjDUetpdCORddq/efQTQLtfsmAFy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763794243; c=relaxed/simple;
	bh=asyyhh74Yw5hvmAlX0pS/rD9jAOJr79T6FGqphnsugA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTqdp5jUeebAEjtkOnmNO9ZU7RCOnqKGDyHkoGPiZMBqxgJP+HcOc8jmoBn5UB1sNhlJDw7PmSV2apVUC1rwDhmKu/n8EnjWJEMoemcAjXBiiqimD5g+Orwn1oP+yIjm1CRVhoUV3i8BrIRfmQnoyC4wv9fpRyYIkH2YYvidazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7V1JzSA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763794241; x=1795330241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=asyyhh74Yw5hvmAlX0pS/rD9jAOJr79T6FGqphnsugA=;
  b=V7V1JzSA08+0Q6FzsrrSoA2sgBF0ELDidPY2rt2GraUrwHLTxkzTvUef
   aK8KCgXAA1XVt4el6cKg4/nxprEtDDdArZG1ZBq59GufW4defdcBLEDF+
   Rb+6Qat+2o0dXRf4RlI5AeYAOe5NI7Vx8YRHZXedBlmdPTSEqfiFkSzsw
   wbI8CI7uSNpa5+XDWWnF859P3uRfoXF/mJLD5uU6dDH8d1gAwsTWZLZeK
   FpHWfhvWli++jXvMMLPZ2mRmW0Jk185p37xIvoPEXtZTvdInDaXC8sS8t
   V6gD8euqG3jQ2w6n4LO8t7EncYeoiIfo8DMY9nQtzo6l+dZqTvDZXciqE
   A==;
X-CSE-ConnectionGUID: sQgNw5OfRHmebZVwKfsoxg==
X-CSE-MsgGUID: PDvZdKC1QhyFmMwx0HGTUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65912610"
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; 
   d="scan'208";a="65912610"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 22:50:40 -0800
X-CSE-ConnectionGUID: udtJYmBdQPqEnBwt6kad3A==
X-CSE-MsgGUID: ae9v6NQKTR+J/lR4/7q6ng==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Nov 2025 22:50:37 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMhS6-0007EN-1T;
	Sat, 22 Nov 2025 06:50:34 +0000
Date: Sat, 22 Nov 2025 14:49:53 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Ryan Houdek <Sonicadvance1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	kernel-dev@igalia.com,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v6 6/9] futex: Wire up get_robust_list2 syscall
Message-ID: <202511221454.rsysOoSt-lkp@intel.com>
References: <20251122-tonyk-robust_futex-v6-6-05fea005a0fd@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251122-tonyk-robust_futex-v6-6-05fea005a0fd@igalia.com>

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c42ba5a87bdccbca11403b7ca8bad1a57b833732]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/futex-Use-explicit-sizes-for-compat_robust_list-structs/20251122-135406
base:   c42ba5a87bdccbca11403b7ca8bad1a57b833732
patch link:    https://lore.kernel.org/r/20251122-tonyk-robust_futex-v6-6-05fea005a0fd%40igalia.com
patch subject: [PATCH v6 6/9] futex: Wire up get_robust_list2 syscall
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20251122/202511221454.rsysOoSt-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511221454.rsysOoSt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511221454.rsysOoSt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> <stdin>:1627:2: warning: #warning syscall get_robust_list2 not implemented [-Wcpp]
--
>> <stdin>:1627:2: warning: #warning syscall get_robust_list2 not implemented [-Wcpp]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

