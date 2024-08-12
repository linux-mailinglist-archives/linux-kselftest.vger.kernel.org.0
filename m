Return-Path: <linux-kselftest+bounces-15145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2103494E684
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 08:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862F4B2113C
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 06:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B8014E2C1;
	Mon, 12 Aug 2024 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAoufx4k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B827457;
	Mon, 12 Aug 2024 06:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723443851; cv=none; b=HYdGTsVNk2IIaoTaC8Cr9dkFMMsbWJbnLM/RW8jfIS1MNabWNcZekbbDVhUtU/t10CE7PVwQG1N6WRuNRAO9umPL7ES/cmU7c8la7jIXOCtqiuHczrQUekYaHCCFUxmtwkrOau7n9NO9f/zQwdaaItDF/Z7PTSU6rqjrsfVO0SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723443851; c=relaxed/simple;
	bh=wqmmRaJgN7uZL9iEMq97OQg2HcSFnevlr3fm/+ffpLI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ijUY3nJpwez7UvpTHo2qDu2+LJOQBwuYUzA4WrtH8v//DjM9UTBOG/IqzI+oa6nG2tlxkfLA5Pqe1I2EhEmDnjE/PkQniiv+CyaN0t1wbZuaevit3+3CgDrOpLkUe0qZVCa2g4Rns6oPqiQfyoWdNOMzyJftz/8xHH6NIdAwmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAoufx4k; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723443850; x=1754979850;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=wqmmRaJgN7uZL9iEMq97OQg2HcSFnevlr3fm/+ffpLI=;
  b=nAoufx4kBvmmn8+6O+T5KhhF80PIiT8xBj7WNCyOwcWZkYrVlIKcYlyo
   KKu8yhFQgtfzPeEpIpw9aFaegcY709tBNl0P+cuFGzIuTS2w6Mx63K3Xd
   SAc5uGrvJ0zQ9dFCIVk0NtAlAsYY0t5FuKy2r1jEYpVmqhryhr3pHE/+b
   JP5G0435ZfGeUXgQufmJlCEa3R30TM/OK3c6nxwP3PPY8XxkNPLf6Scbf
   RczjRz31uReTWx8VO9+grL3odyeWmpHeYTZCYwteYD37aWSRwE4KaxA46
   rOG5hvRyszGmxWRHDdpCx1l3fj3y4EfS92IXZOdqwxmzzqr2aYwqqACvP
   g==;
X-CSE-ConnectionGUID: vjgcZKtTSEi9lKrs3/2r1A==
X-CSE-MsgGUID: bSA9DpQZTc6iTE9Gn/pPRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32112798"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32112798"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 23:24:09 -0700
X-CSE-ConnectionGUID: BNI0Hy1JQv6KVSZrIsIcQw==
X-CSE-MsgGUID: zMgUwZTYTtSj65Zs3ujsTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="88994412"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 23:24:02 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dev Jain <dev.jain@arm.com>
Cc: <akpm@linux-foundation.org>,  <shuah@kernel.org>,  <david@redhat.com>,
  <willy@infradead.org>,  <ryan.roberts@arm.com>,
  <anshuman.khandual@arm.com>,  <catalin.marinas@arm.com>,
  <cl@gentwo.org>,  <vbabka@suse.cz>,  <mhocko@suse.com>,
  <apopple@nvidia.com>,  <osalvador@suse.de>,
  <baolin.wang@linux.alibaba.com>,  <dave.hansen@linux.intel.com>,
  <will@kernel.org>,  <baohua@kernel.org>,  <ioworker0@gmail.com>,
  <gshan@redhat.com>,  <mark.rutland@arm.com>,
  <kirill.shutemov@linux.intel.com>,  <hughd@google.com>,
  <aneesh.kumar@kernel.org>,  <yang@os.amperecomputing.com>,
  <peterx@redhat.com>,  <broonie@kernel.org>,
  <mgorman@techsingularity.net>,  <linux-arm-kernel@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: Retry migration earlier upon refcount mismatch
In-Reply-To: <cc1ababf-cda5-4eaf-9e67-47c26d5d70fe@arm.com> (Dev Jain's
	message of "Mon, 12 Aug 2024 11:43:43 +0530")
References: <20240809103129.365029-1-dev.jain@arm.com>
	<20240809103129.365029-2-dev.jain@arm.com>
	<87frrauwwv.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<cc1ababf-cda5-4eaf-9e67-47c26d5d70fe@arm.com>
Date: Mon, 12 Aug 2024 14:20:29 +0800
Message-ID: <877ccmuus2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dev Jain <dev.jain@arm.com> writes:

> On 8/12/24 11:04, Huang, Ying wrote:
>> Hi, Dev,
>>
>> Dev Jain <dev.jain@arm.com> writes:
>>
>>> As already being done in __migrate_folio(), wherein we backoff if the
>>> folio refcount is wrong, make this check during the unmapping phase, upon
>>> the failure of which, the original state of the PTEs will be restored and
>>> the folio lock will be dropped via migrate_folio_undo_src(), any racing
>>> thread will make progress and migration will be retried.
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>   mm/migrate.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index e7296c0fb5d5..477acf996951 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1250,6 +1250,15 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>   	}
>>>     	if (!folio_mapped(src)) {
>>> +		/*
>>> +		 * Someone may have changed the refcount and maybe sleeping
>>> +		 * on the folio lock. In case of refcount mismatch, bail out,
>>> +		 * let the system make progress and retry.
>>> +		 */
>>> +		struct address_space *mapping = folio_mapping(src);
>>> +
>>> +		if (folio_ref_count(src) != folio_expected_refs(mapping, src))
>>> +			goto out;
>>>   		__migrate_folio_record(dst, old_page_state, anon_vma);
>>>   		return MIGRATEPAGE_UNMAP;
>>>   	}
>> Do you have some test results for this?  For example, after applying the
>> patch, the migration success rate increased XX%, etc.
>
> Noting that the migration selftest is operating on a single page,
> before the patch, the test fails on shared-anon mappings on an
> average of 10 iterations of move_pages(), and after applying the
> patch it fails on average of 100 iterations, which makes sense
> because the unmapping() will get retried 3 + 7 = 10 times.

Thanks!  What is the test results for

https://lore.kernel.org/all/20240801081657.1386743-1-dev.jain@arm.com/

?

>>
>> My understanding for this issue is that the migration success rate can
>> increase if we undo all changes before retrying.  This is the current
>> behavior for sync migration, but not for async migration.  If so, we can
>> use migrate_pages_sync() for async migration too to increase success
>> rate?  Of course, we need to change the function name and comments.

--
Best Regards,
Huang, Ying

