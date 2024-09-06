Return-Path: <linux-kselftest+bounces-17423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078AA96FC97
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 22:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316231C221A6
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 20:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA5C1D54FE;
	Fri,  6 Sep 2024 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FiSGtLwH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234B1D54EE
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654065; cv=none; b=GBkM774+bUYykrSjXWEZ8xNj++HMLHrj+A6BYV3M1Y8pJajFnMtVdH0Gn5vwCosI2u6RAIkw5YEYAO9FamKfmw+EXgo2aEzSO9hdJMVcY2uji5EnONVRoKXza5I/3vUlXK4iuj0Fz/7/5DZohqBam3M3i9BHDVjNOv7nm+q7eSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654065; c=relaxed/simple;
	bh=rkcJ4yYWL1RB4xZm1DyitL9XX6jvdjCva7vANo1rBV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THeb0zmYCssVJTEf/hl+OfxILdUXpapOZZ1XeBzOnwSk71BKqVDJFLW+GZacB7g3YOKfHwFsCswppFpyiVQ3TEYi85BsfONZH0olS/xJnl3dnmMAR/k+Y1ncSbGQqwztLawEKJqhp3dwusKQDApmPsojgyNjFHGdL+CLJi7sDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FiSGtLwH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725654062; x=1757190062;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rkcJ4yYWL1RB4xZm1DyitL9XX6jvdjCva7vANo1rBV8=;
  b=FiSGtLwHbt/nMKhFvsPPjyTm5TNtSmqHPRxrJT0M6JysHDy0lATk5QTr
   sAwZxh8LGdAOKC7keJ6UceXDTz5Sn3FonAbl1oGdXibnkJtKn77JcwRoW
   Lo46y4DimbFdAWG1gf4nCnlWkCI3X1hPyWe898GTY6+A3L8hld3q7lQUR
   XKV8qS8Gq0XIEGjDbmmjZNJFJ3kTVWg7tGCfNee/REMua0hY8bryRT1Qc
   gcaUk2ekUpeXNEwML8AOq/ODHHjFv7bKhbOL69+p2jB5yrxp7IS4lVmGu
   aj4Nd1SnGUzWTuf8ahfxliShcSZdZPQEf28c9rATN7MsBPSjSv0wzC+6U
   Q==;
X-CSE-ConnectionGUID: cZzME1UDThqPvh1xXE4Ukg==
X-CSE-MsgGUID: SEqRmeYhSIK/QbyDtBkFlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="41936009"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="41936009"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 13:21:01 -0700
X-CSE-ConnectionGUID: rblzNJqLRzGPHxi4Ixs4qg==
X-CSE-MsgGUID: bv/n5GrgSue1TV+7bZiMAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="66798130"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 06 Sep 2024 13:20:59 -0700
Received: from [10.246.19.248] (mwajdecz-MOBL.ger.corp.intel.com [10.246.19.248])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1C94B2FC61;
	Fri,  6 Sep 2024 21:20:58 +0100 (IST)
Message-ID: <a01fbbcb-abe8-4629-b3b8-19c264166b49@intel.com>
Date: Fri, 6 Sep 2024 22:20:57 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: Fix kernel-doc for EXPORT_SYMBOL_IF_KUNIT
To: Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 David Gow <davidgow@google.com>
References: <20240829183150.1616-1-michal.wajdeczko@intel.com>
 <CA+GJov5POvegznZutxHZuoUhxeHyseECHm4GW5NMR5vqZGWk4g@mail.gmail.com>
 <63952c61-d00b-421a-be9d-e7b940325f38@intel.com>
 <CA+GJov4ZR6Cfms-j8v3xVSj10L1_4JptQfYt6tqZGi1s=0cyBQ@mail.gmail.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <CA+GJov4ZR6Cfms-j8v3xVSj10L1_4JptQfYt6tqZGi1s=0cyBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rae,

On 06.09.2024 21:57, Rae Moar wrote:
> On Thu, Aug 29, 2024 at 4:28 PM Michal Wajdeczko
> <michal.wajdeczko@intel.com> wrote:
>>
>>
>>
>> On 29.08.2024 20:58, Rae Moar wrote:
>>> On Thu, Aug 29, 2024 at 11:32 AM Michal Wajdeczko
>>> <michal.wajdeczko@intel.com> wrote:
>>>>
>>>> While kunit/visibility.h is today not included in any generated
>>>> kernel documentation, also likely due to the fact that none of the
>>>> existing comments are correctly recognized as kernel-doc, but once
>>>> we decide to add this header and fix the tool, there will be:
>>>>
>>>> ../include/kunit/visibility.h:61: warning: Function parameter or
>>>> struct member 'symbol' not described in 'EXPORT_SYMBOL_IF_KUNIT'
>>>>
>>>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>>>
>>> Hello!
>>>
>>> This looks good to me. Thanks for adding this. We will need to do a
>>> patch on making this recognized as a kernel-doc at some point.
>>
>> here it goes [1]
>>
>> [1]
>> https://lore.kernel.org/linux-doc/20240829202529.1660-1-michal.wajdeczko@intel.com/
> 
> Hi Michal!
> 
> Thanks for your fast response to this! It looks like this patch
> changes the kernel-doc specification, 

I'm not sure it changes anything as in the spec there is just:

"The opening comment mark ``/**`` is used for kernel-doc comments."

without any mention that it has to be at the start of the line.

In fact above patch was able to detect (too) many mistakes in existing
comments that were either incomplete or false kernel-doc, but once we
fixed those, there is high chance patch will be accepted.

Michal

> which is a very worthwhile
> conversation, but in this instance I intended to change the code
> comments in visibility.h to match the current kernel-doc
> specification. I am also happy to make those edits in a future patch.
> 
> Thanks!
> -Rae
> 
>>
>>>
>>> Reviewed-by: Rae Moar <rmoar@google.com>
>>>
>>> Thanks!
>>> -Rae
>>>
>>>> ---
>>>> Cc: Rae Moar <rmoar@google.com>
>>>> Cc: David Gow <davidgow@google.com>
>>>> ---
>>>>  include/kunit/visibility.h | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
>>>> index 0dfe35feeec6..efff77b58dd6 100644
>>>> --- a/include/kunit/visibility.h
>>>> +++ b/include/kunit/visibility.h
>>>> @@ -22,6 +22,7 @@
>>>>       * EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is
>>>>       * enabled. Must use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING)
>>>>       * in test file in order to use symbols.
>>>> +     * @symbol: the symbol identifier to export
>>>>       */
>>>>      #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
>>>>             EXPORTED_FOR_KUNIT_TESTING)
>>>> --
>>>> 2.43.0
>>>>
>>>> --
>>>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>>>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>>>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20240829183150.1616-1-michal.wajdeczko%40intel.com.

