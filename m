Return-Path: <linux-kselftest+bounces-16462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6430F961840
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 21:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5644B22BB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A3A1D2F55;
	Tue, 27 Aug 2024 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGUUAqF9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C5146A63
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788600; cv=none; b=jiOIBzkCRcVyeUr50rXzn6Vwafe4PHewgxkpQuSBJ6+o/dAM9/z60rAVnHFE8nRS9GwhYzG/mARs8UijsvdN+fzCzdQuRny8f8m2NHundNlzKakGYbfFGwVb7kM95fkkfEHREU4ZFNnKjar9GyO1goY3b7lXCfsGkaxLTCPx9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788600; c=relaxed/simple;
	bh=aQe8aKZO8sLRY6PlbDGG3wSgNPvbqpm6xG0LmAAPRRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvDZqLkTxDZ9nCUIDYoxh9B6o2yxAtkldS4SiaTP0ob1nR3kKFANH/egWIl6VQKb5JaIwALx4ekTCZsZIYJE7XPDGzg/I98tU0iSBaFTVSkA4fS+XpVt33e4PpqKfj+tF8arJHlv5RT60TyR47LKSgxIPm1oopsVBi6w79LpvHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGUUAqF9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724788599; x=1756324599;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aQe8aKZO8sLRY6PlbDGG3wSgNPvbqpm6xG0LmAAPRRM=;
  b=GGUUAqF9nxc8CukWXDNNHBYeU8jVygq6tqDe+tTmpENiKOt333TF4kWy
   jiVGC5qw8mip9u1RERKgeNDG1ppSq3Yx1JU22WqQtU67c29DRqo8rYJrX
   6mxNzvNcTtoy3G6NuFzVVOf2UU4wHNMVPfEpux0E6rdITz8Ip6DbjKeO9
   /Shvb/0wPmdirKo4kpNG/RFqtwulwSVx6dr/iKtJiFRjPyQ8/vhLfw33x
   CBm8Axv8H9p4LR+xZt+CwDXyIo7sKJQhRRvLjUKOUFDpm+LhIYT00vGV0
   MDofQuKd8KiUMgpbwZEeK2mFMdz/F3Q//C5c6t0b+CkSnj14wzD04arRQ
   g==;
X-CSE-ConnectionGUID: rl6N0dTbT9C4SeMhRXkWSQ==
X-CSE-MsgGUID: lfe8ELQMSYqhE0oTcBPLgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23470776"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="23470776"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 12:56:38 -0700
X-CSE-ConnectionGUID: r9f3mMoERGKMilzgUbbJiQ==
X-CSE-MsgGUID: LzI+9Vw8S/O2ImN0clfRAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="86176645"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 27 Aug 2024 12:56:36 -0700
Received: from [10.246.1.253] (mwajdecz-MOBL.ger.corp.intel.com [10.246.1.253])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 432542FC70;
	Tue, 27 Aug 2024 20:56:35 +0100 (IST)
Message-ID: <51352c1e-1a33-4381-9345-4324845ef5e0@intel.com>
Date: Tue, 27 Aug 2024 21:56:34 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] kunit: Add macro to conditionally expose
 declarations to tests
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>
References: <20240826222015.1484-1-michal.wajdeczko@intel.com>
 <20240826222015.1484-3-michal.wajdeczko@intel.com>
 <unqbtufg2lgqdwaazti2jb6f7wkaggcc6kmcpkwxv2ylt4mgnl@bov4zj3uj66w>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <unqbtufg2lgqdwaazti2jb6f7wkaggcc6kmcpkwxv2ylt4mgnl@bov4zj3uj66w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27.08.2024 15:45, Lucas De Marchi wrote:
> On Tue, Aug 27, 2024 at 12:20:11AM GMT, Michal Wajdeczko wrote:
>> The DECLARE_IF_KUNIT macro will introduces identifiers only if
>> CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
>> no identifiers from the param list will be defined.
>>
>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>> Reviewed-by: Rae Moar <rmoar@google.com>
>> Reviewed-by: David Gow <davidgow@google.com>
>> ---
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> up to kunit maintainers, but it doesn't seem the word "DECLARE" is
> entirely correct. What it's doing is expanding arg, and it doesn't
> matter if it's an expression, definition, declaration.

hmm, while this is true for statement & declarations (as both have
similar notation) but not sure about the expression (that's why we have
patch 3)

> 
> Looking at patch 3, I think it would be more obvious to the caller if we
> have:
> 
> IF_KUNIT_ELSE_EMPTY()
> IF_KUNIT_ELSE_ZERO()

existing macros in this file are named as xxx_IF_KUNIT so maybe we
should try to follow that pattern...

so maybe (like BUILD_BUG_ON_ZERO)

	ONLY_IF_KUNIT(body...)
	ONLY_IF_KUNIT_ZERO(expr...)

> 
>> ---
>> include/kunit/visibility.h | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>>
>> diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
>> index 0dfe35feeec6..1c23773f826c 100644
>> --- a/include/kunit/visibility.h
>> +++ b/include/kunit/visibility.h
>> @@ -11,6 +11,13 @@
>> #define _KUNIT_VISIBILITY_H
>>
>> #if IS_ENABLED(CONFIG_KUNIT)
>> +    /**
>> +     * DECLARE_IF_KUNIT - A macro that introduces identifiers only if
>> +     * CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
>> +     * no identifiers will be defined.
>> +     * @body: identifiers to be introduced conditionally
> 
> missing an example here with fields inside a struct

would this work?

Example:

	struct example {
		int foo;
		/* private: test only */
		DECLARE_IF_KUNIT(int bar);
	};

> 
> Lucas De Marchi
> 
>> +     */
>> +    #define DECLARE_IF_KUNIT(body...)    body
>>     /**
>>      * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if
>>      * CONFIG_KUNIT is not enabled. Otherwise if CONFIG_KUNIT is enabled
>> @@ -26,6 +33,7 @@
>>     #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
>>         EXPORTED_FOR_KUNIT_TESTING)
>> #else
>> +    #define DECLARE_IF_KUNIT(body...)
>>     #define VISIBLE_IF_KUNIT static
>>     #define EXPORT_SYMBOL_IF_KUNIT(symbol)
>> #endif
>> -- 
>> 2.43.0
>>

