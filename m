Return-Path: <linux-kselftest+bounces-16725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5709650C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 22:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C55284816
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 20:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7247C1B78F6;
	Thu, 29 Aug 2024 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdsttQAx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377F224B28
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724963325; cv=none; b=RkpVmTl0//4YP1M9vFrg1nYdYCmjdpWnpjdx1wY4jcz7t3docBVUqcwUN8be1osnu2YOJRDEWLHXL3B9oCs0tZTOAo3VmBWynhOMbhhz6OCG96ckA4oNOWOrnYwI/La1X3xeIsFjZS2jN2DJncl8wGEWcDt17Nz1C8LZRHKvW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724963325; c=relaxed/simple;
	bh=vzm4ZfOnGzGWMX5Kaw7lUaCLfiG7STX3eo7wBIP5HWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfKc5tAfIoST+iJEczl0CCbAgb/b9Wn/QtH1H/Zj7kv7aY83Ge8GRGFn+P8lKATZ1CGXqXVJsumn5QzBAteG6K1ZXc11hOplhJy/cuDLkevmPK1GWYkYg0rjwsekluSFNvdPRwJ4tSsUwcRxLiM8jgOAX84ESCnbIJKd7XJPnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdsttQAx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724963323; x=1756499323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vzm4ZfOnGzGWMX5Kaw7lUaCLfiG7STX3eo7wBIP5HWw=;
  b=CdsttQAx6iL6m2wpqmuWVT73Sg5FDgIOXzmJqhPV4yOEGWnsjOhF9P4S
   EXFHR1xxkSb3RwMXLCyoTM2qz//LC86/tqrUaEqISjZ2a6Tjmb3W9OFq8
   oZaTDJnhBFRg3dJa0DUw5d5XLrdZJWkVWcMhTDY1oQ2cbnA5x6ChB+iwC
   OfuSQiSVyOronD4xKuRDj5Pdzhfi2L874KXiOX1dAjfA9l0CceXixCCEo
   C8Fm9yXdIQZDj++BRJmdNpS2MWxhzS/Vh3p8uWX/GzaTnY95m2rv9gx3U
   UdSPLPraUGIpkQZKOK/aOJZqpCBszeci1n3O3dZgvGxxLfSqo9g8QjDRw
   Q==;
X-CSE-ConnectionGUID: pFoLqIz6S3OHvhnen7NG/w==
X-CSE-MsgGUID: gRgs/eIRQUumaBYkutSceQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23774622"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23774622"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 13:28:42 -0700
X-CSE-ConnectionGUID: Y1MpFOw1QFa1CQTk7q1Sow==
X-CSE-MsgGUID: T6RYqndBSryqyyptky0Vqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="68519244"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa005.jf.intel.com with ESMTP; 29 Aug 2024 13:28:41 -0700
Received: from [10.245.120.199] (unknown [10.245.120.199])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 026F328167;
	Thu, 29 Aug 2024 21:28:39 +0100 (IST)
Message-ID: <63952c61-d00b-421a-be9d-e7b940325f38@intel.com>
Date: Thu, 29 Aug 2024 22:28:39 +0200
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
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <CA+GJov5POvegznZutxHZuoUhxeHyseECHm4GW5NMR5vqZGWk4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 29.08.2024 20:58, Rae Moar wrote:
> On Thu, Aug 29, 2024 at 11:32 AM Michal Wajdeczko
> <michal.wajdeczko@intel.com> wrote:
>>
>> While kunit/visibility.h is today not included in any generated
>> kernel documentation, also likely due to the fact that none of the
>> existing comments are correctly recognized as kernel-doc, but once
>> we decide to add this header and fix the tool, there will be:
>>
>> ../include/kunit/visibility.h:61: warning: Function parameter or
>> struct member 'symbol' not described in 'EXPORT_SYMBOL_IF_KUNIT'
>>
>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> 
> Hello!
> 
> This looks good to me. Thanks for adding this. We will need to do a
> patch on making this recognized as a kernel-doc at some point.

here it goes [1]

[1]
https://lore.kernel.org/linux-doc/20240829202529.1660-1-michal.wajdeczko@intel.com/

> 
> Reviewed-by: Rae Moar <rmoar@google.com>
> 
> Thanks!
> -Rae
> 
>> ---
>> Cc: Rae Moar <rmoar@google.com>
>> Cc: David Gow <davidgow@google.com>
>> ---
>>  include/kunit/visibility.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
>> index 0dfe35feeec6..efff77b58dd6 100644
>> --- a/include/kunit/visibility.h
>> +++ b/include/kunit/visibility.h
>> @@ -22,6 +22,7 @@
>>       * EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is
>>       * enabled. Must use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING)
>>       * in test file in order to use symbols.
>> +     * @symbol: the symbol identifier to export
>>       */
>>      #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
>>             EXPORTED_FOR_KUNIT_TESTING)
>> --
>> 2.43.0
>>
>> --
>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20240829183150.1616-1-michal.wajdeczko%40intel.com.

