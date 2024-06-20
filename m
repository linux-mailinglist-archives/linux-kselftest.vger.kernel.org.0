Return-Path: <linux-kselftest+bounces-12301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8A090FDA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 09:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716551C2425C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 07:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C8B446A5;
	Thu, 20 Jun 2024 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4WEh8y3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3A344366;
	Thu, 20 Jun 2024 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868388; cv=none; b=dJizKYpOh1Id2L8UnDoIUzVGsqoQ+Z6VV3Q/MeznR2l/ladE328UYrzenZrpTs/Erxtx9OD/oLMZXGaK3Ol6fWNXJMm0l4r5yB14X7FeUIaWaeYCfcXdUHdTWRnAJVd7oHFnr/3nFHBOx3HKZW0jLl+fcLXWQrObFLvCsL5fEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868388; c=relaxed/simple;
	bh=8/A1Y3E8GY6PIn4gC4KVtV56SOoGUo+DimAJe67mlxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KWbhPBaBkR516KozoQDPZtUwbL5Rje4rz3pFVza96WZaVBvz7ALrkNWMx4h/hf5nenJHdcfi40K1hSjQQjxVIfa2d9EX0wPnAoqN4GaB86XtJlF171M3utPNgBG+APZLNkYeUy5G43nzECczdufXrITdikEzT4+fv3r9eno/82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4WEh8y3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718868386; x=1750404386;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8/A1Y3E8GY6PIn4gC4KVtV56SOoGUo+DimAJe67mlxs=;
  b=f4WEh8y3OH5a5TqoWO2cwdSnnB5MpBS67l4pOnJ9kkmYg6+zirar1F7r
   9s55rEwuOKmrT+PqSmd4TFYjA67gWRz3Ne24S2N5tkyOzr9NFEuVRM+wF
   vFSHj0eQmjnz7bTkuUFCCF1BdbU4XBTofbkX+QA7bjOcWT6Iat471yYEC
   H+Ec4cjC+npXPGChkr5gPMUggs/gai+54/LtHtf+fodht/FthxNeAWnMC
   dve5LDCTkD0/Vf8KDE99jlVidgTYl2Pg1KDgGwxfN2m9eNcH9PxEXpiQ8
   4F4gm3vr3E4wV25d0HH+GyPyUnHx3EQSsWBs53isC+tG3n6TcJM1T5bP1
   A==;
X-CSE-ConnectionGUID: 4jqDzsG7TbyEgfmXdyykLw==
X-CSE-MsgGUID: /Pn9maYATyq3mofXgm5bwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15966942"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15966942"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 00:26:24 -0700
X-CSE-ConnectionGUID: YPSl5iKzSRa7ktrwYfds6Q==
X-CSE-MsgGUID: MuPmNWmlS8mScjrAeRBEkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="73344286"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 00:26:21 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>,  akpm@linux-foundation.org,
  shuah@kernel.org,  linux-mm@kvack.org,  ryan.roberts@arm.com,
  chrisl@kernel.org,  hughd@google.com,  kaleshsingh@google.com,
  kasong@tencent.com,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
In-Reply-To: <3e185f8d-da63-4a61-9cd1-9804bd972515@redhat.com> (David
	Hildenbrand's message of "Thu, 20 Jun 2024 09:20:43 +0200")
References: <20240620002648.75204-1-21cnbao@gmail.com>
	<87zfrg2xce.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<3e185f8d-da63-4a61-9cd1-9804bd972515@redhat.com>
Date: Thu, 20 Jun 2024 15:24:30 +0800
Message-ID: <87cyoc2i1d.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 20.06.24 03:53, Huang, Ying wrote:
>> Barry Song <21cnbao@gmail.com> writes:
>> 
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> Both Ryan and Chris have been utilizing the small test program to aid
>>> in debugging and identifying issues with swap entry allocation. While
>>> a real or intricate workload might be more suitable for assessing the
>>> correctness and effectiveness of the swap allocation policy, a small
>>> test program presents a simpler means of understanding the problem and
>>> initially verifying the improvements being made.
>>>
>>> Let's endeavor to integrate it into the self-test suite. Although it
>>> presently only accommodates 64KB and 4KB, I'm optimistic that we can
>>> expand its capabilities to support multiple sizes and simulate more
>>> complex systems in the future as required.
>> IIUC, this is a performance test program instead of functionality
>> test
>> program.  Does it match the purpose of the kernel selftest?
>
> We do have the similar tests at least for ksm (ksm_tests.c) and
> probably others:
>
> $ git grep -l clock_gettime
> ksm_tests.c
> migration.c
> mremap_test.c
> transhuge-stress.c
>
>
> I recall that gup_test.c also measures performance things.

Good to know that!  Thanks for your information!

--
Best Regards,
Huang, Ying

