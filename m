Return-Path: <linux-kselftest+bounces-16461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B367F961827
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 21:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716FB28533B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B3D154439;
	Tue, 27 Aug 2024 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MR/MWblx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883939473
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788070; cv=none; b=GmPh5LD39XM+Bksb33rsJ68MaddanlT8XWpJY+IIRWRoGyu+qiTinCC2XXJBGvyVs07TlVg856neeOgV9K8B1u5ApNd1p40k+zA69LdctNfRQHrJlT6OJqIEXhDw7AFCzpSvlbf4cFb0M2S54sOL9Lt069HVIjizLaPy9axgtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788070; c=relaxed/simple;
	bh=KU2RAF+UU2qQ8GsKx9fwdr4q6/Ovt8ahXCh+tywSENI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPP/ltTNf7ASLW59yoX8gkbg/z/XhkuiQ4Os176h0k7yNsqWz+Za41/IuNsQeYNSo5KRNna4RxOfSYtUyOjHP5cBoS4GK7VbMsiDocakmTW3Dy6I11P5OjMk7+hNOKzqS7jzmbXLifJFyY63EFh2R0JyshqsBzw/QBQE8y6ssIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MR/MWblx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724788069; x=1756324069;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KU2RAF+UU2qQ8GsKx9fwdr4q6/Ovt8ahXCh+tywSENI=;
  b=MR/MWblxcVm+Wz7P00aGjzNUcI69hzB0WjFiHHNCEvAwnkmRmoOWGJaN
   +5RH0//d9DAynxyWZB9nzeELnIT8BvjaxwLCgaybxET2YMen7TjpS2Lsy
   pVLaX/s4T8RvlN6it0gI7gzNbrz/35opJfW9yiq8K1funZujeJldw7ZIq
   8EQgVR5IxPTG0WSjrpJM8xeoPNJs8DZZ6f7VoQgReghIGiWwoKtDb7gVZ
   NX4qe/b3AEpwp3hDpG/4QIwXE4zPa0uy7wOjjDByqpbRo4ToERaZYouwR
   mk3UgwbCwNo1kD7oDqjxNFd1r5pb/1+YBWfEK9bIzoZUU7Q6y80P+e8DM
   g==;
X-CSE-ConnectionGUID: FvAz3JO7QXORVE/k4W/9Lw==
X-CSE-MsgGUID: lHWJVYkST6CR/X2hz0zsKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23251905"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="23251905"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 12:47:47 -0700
X-CSE-ConnectionGUID: fPOmDvEYSB2as2arcJG/Xw==
X-CSE-MsgGUID: e8HPmM3OSqivHsyb+V2Z5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="67837452"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa005.jf.intel.com with ESMTP; 27 Aug 2024 12:47:45 -0700
Received: from [10.246.1.253] (mwajdecz-MOBL.ger.corp.intel.com [10.246.1.253])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0BDF52FC70;
	Tue, 27 Aug 2024 20:47:43 +0100 (IST)
Message-ID: <fe0b8cd7-583c-4a2d-a61d-18484c3197bf@intel.com>
Date: Tue, 27 Aug 2024 21:47:43 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] kunit: Add macro to conditionally expose
 expressions to tests
To: Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 David Gow <davidgow@google.com>, Lucas De Marchi <lucas.demarchi@intel.com>
References: <20240826222015.1484-1-michal.wajdeczko@intel.com>
 <20240826222015.1484-4-michal.wajdeczko@intel.com>
 <CA+GJov4dfR=Cv7uRhPqw3P3XP==rntYWzgCKJ_7O4AcfwD--qw@mail.gmail.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <CA+GJov4dfR=Cv7uRhPqw3P3XP==rntYWzgCKJ_7O4AcfwD--qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27.08.2024 21:04, Rae Moar wrote:
> On Mon, Aug 26, 2024 at 3:20 PM Michal Wajdeczko
> <michal.wajdeczko@intel.com> wrote:
>>
>> The ONLY_IF_KUNIT macro will add expression statement only if the
>> CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
>> it will evaluate always to 0.
>>
>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> 
> Hello!
> 
> Thanks for the second version of this patch series!
> 
> I definitely could see this new macro as being useful but I currently
> don't see an example of its use in the rest of the patch series. How
> do you see this macro as being used or do you have a current use case
> for this macro?

in Xe driver we have this macro defined as XE_TEST_ONLY [1]

[1] https://elixir.bootlin.com/linux/v6.11-rc5/A/ident/XE_TEST_ONLY

> 
> I would be fine adding this macro without being used as long as
> examples on how and why to use it are clearly documented.

sure, I'll try to add some usage in the example patch 5/6

> 
> Thanks!
> -Rae
> 
>> ---
>> Cc: Rae Moar <rmoar@google.com>
>> Cc: David Gow <davidgow@google.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> ---
>>  include/kunit/visibility.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
>> index 1c23773f826c..69c71eacf368 100644
>> --- a/include/kunit/visibility.h
>> +++ b/include/kunit/visibility.h
>> @@ -18,6 +18,13 @@
>>       * @body: identifiers to be introduced conditionally
>>       */
>>      #define DECLARE_IF_KUNIT(body...)  body
>> +    /**
>> +     * ONLY_IF_KUNIT - A macro that adds expression statement only if
>> +     * CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
>> +     * it will evaluate always to 0.
>> +     * @expr: expression to be introduced conditionally
>> +     */
>> +    #define ONLY_IF_KUNIT(expr...)     expr
>>      /**
>>       * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if
>>       * CONFIG_KUNIT is not enabled. Otherwise if CONFIG_KUNIT is enabled
>> @@ -34,6 +41,7 @@
>>             EXPORTED_FOR_KUNIT_TESTING)
>>  #else
>>      #define DECLARE_IF_KUNIT(body...)
>> +    #define ONLY_IF_KUNIT(expr...) 0
>>      #define VISIBLE_IF_KUNIT static
>>      #define EXPORT_SYMBOL_IF_KUNIT(symbol)
>>  #endif
>> --
>> 2.43.0
>>

