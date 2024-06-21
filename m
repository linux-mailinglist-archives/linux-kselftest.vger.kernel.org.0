Return-Path: <linux-kselftest+bounces-12392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F07B9118C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 04:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDFC61F2363C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 02:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44898839F4;
	Fri, 21 Jun 2024 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpFzaOJb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494D84D37;
	Fri, 21 Jun 2024 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937338; cv=none; b=ANetWwDXuelLJf84Lh/8OgF3eb2HkePv6SIIH5DMAv7Ulccf9fPL9p9Myg0UeCeK3EK3YYmPGZwxNU8e6BLXnHjx7zc0zshk956CJ5JG2BXlvlZnhQjfYa0MKjDPTBrsB43f3AeYRArwzwjDNTlGOmoDt8wNma7YWBDwJyyXUWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937338; c=relaxed/simple;
	bh=cFrj54EHqVH+PxtlDbxJQZRdDgSVfzfm3iOshhgQvNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sfMo2HTZlQTgTFkB/JdLLfT2ppmvKKIgNNtLMwcr1YB1BWG6hkNfwRFGtFeZEjQU/nf3/ex34nR0aH9jL2IkM4BbG+L8FM884p+66wqdm4hmPB51NjztE9YNSKDv1FQMHWw2WovhUsnNW+V1JiDArpuLKPdWqS3Lb6eFN4tUHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpFzaOJb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718937336; x=1750473336;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=cFrj54EHqVH+PxtlDbxJQZRdDgSVfzfm3iOshhgQvNI=;
  b=gpFzaOJbGIkOmnfrV+dui7cluRQbgaXzavfbrRtP0Zlj4w8GRda2baUf
   z9Oe3uWs4+SEGmyrSr1raNba8/23lfORdATjLnLY/nuaDhh0Tm/1vGAFH
   5RcpCgnBWmMh4nXyeB8664ZoONPpDS488QULuBZ+dmrBmYWmpkIyOks15
   cMiELZg8WXLMaINExDNMCjTpXFLXlPyqImR8KkiAIsVdduo0AW8VoZRx4
   QQO/bnl1UJHvMNqqw8oJS8U/MLCClxM4QO8rZdYXySNUlWMyq7UOTTx++
   DusxcS5nw3/xYju+8NJYMeyo5dO6EUnJBqC1G0u7wLGgZ+XV76SocStrt
   w==;
X-CSE-ConnectionGUID: q53tSpfXShy3s1rUYBQODA==
X-CSE-MsgGUID: 0KO75eV/SSqUi7XsWQ3PtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="16098512"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="16098512"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 19:35:36 -0700
X-CSE-ConnectionGUID: JQ6mUdRcRLC0P+eh/BlGEA==
X-CSE-MsgGUID: 4Dt0LsHsSR28BkTekb6V7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="42526110"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 19:35:32 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Barry Song <21cnbao@gmail.com>,
  akpm@linux-foundation.org,  shuah@kernel.org,  linux-mm@kvack.org,
  chrisl@kernel.org,  hughd@google.com,  kaleshsingh@google.com,
  kasong@tencent.com,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  Barry Song <v-songbaohua@oppo.com>,
 Philip Li <philip.li@intel.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
In-Reply-To: <d0b20f47-384d-49f1-8449-0da6da11089c@redhat.com> (David
	Hildenbrand's message of "Thu, 20 Jun 2024 13:34:02 +0200")
References: <20240620002648.75204-1-21cnbao@gmail.com>
	<f3c18806-34ac-41d3-8c79-d7dd6504547e@arm.com>
	<d0b20f47-384d-49f1-8449-0da6da11089c@redhat.com>
Date: Fri, 21 Jun 2024 10:33:41 +0800
Message-ID: <87sex710u2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 20.06.24 11:04, Ryan Roberts wrote:
>> On 20/06/2024 01:26, Barry Song wrote:
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
>> I'll try to summarize the thread with Huang Ying by suggesting this
>> test program
>> is "neccessary but not sufficient" to exhaustively test the mTHP swap-out path.
>> I've certainly found it useful and think it would be a valuable addition to the
>> tree.
>> That said, I'm not convinced it is a selftest; IMO a selftest should
>> provide a
>> clear pass/fail result against some criteria and must be able to be run
>> automatically by (e.g.) a CI system.
>
> Likely we should then consider moving other such performance-related
> thingies out of the selftests?

I think that it's good to distinguish between functionality and
performance tests.  For example, 0-day test system will use virtual
machines to do some functionality tests to improve efficiency.  But it's
not good to run performance tests in such kind of virtual machines.

--
Best Regards,
Huang, Ying

