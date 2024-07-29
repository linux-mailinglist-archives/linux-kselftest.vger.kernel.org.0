Return-Path: <linux-kselftest+bounces-14353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA34F93EF39
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB711F221F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 07:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B9A12EBC7;
	Mon, 29 Jul 2024 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dcp82qsb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B43112D1FD;
	Mon, 29 Jul 2024 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239871; cv=none; b=MU7PK7l+aNSNXdadp1Ka9/CIpOBnmeOyaj1NfEFWPD13TPrdxhezaEcTDsNvenJ/53MgteiBjA8VKc+8vR/zyo+BGZlcac4SvclQUk+0+y3NA+aS5RLYala4ffQnMt5HZ1r8tyi8tv6Z9Zw5DnhbYrADKcLi7L0k/vaw0j3z3Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239871; c=relaxed/simple;
	bh=rd+cf3hmcj9TDEtVadV6eKgFpK0vDNsBJh4Z4k7rdh0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g6cYRpcSAfWlgh1819uUI9cgsLzRRpZk1IVPcK0C7hcYuEXckcFGDuyG9q2acwBDB56WGQ3N/T72SddGbkeg8+GU63XwKTExMK29zaS9M9F/MiffKgfmawHujCP/n6lNuMmQbyM4FxP6zEmQ7+PVahmHRdDKUivZv0B/jnDmWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dcp82qsb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722239866;
	bh=rd+cf3hmcj9TDEtVadV6eKgFpK0vDNsBJh4Z4k7rdh0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=dcp82qsbtUdoel9myWwIZmA4YlNAQ8IqXAN/8ivZ+6rV1NlSCXwV9DlYPtdKytVFn
	 ye9RlkW+hJNVBesetntCcS3htgACxDefzTkhC49osRxrsAODa7KT7azf97xFdpSizN
	 x66RmoNHTc1i7koziYyed5AdaQRLVkfUXudXQM3ORpfXDgbaQjcXsKGzHnaXKF0OoI
	 gXA2j971Ga5m/nc46iJoJ0ZDGaHzquQxTsneuQfWpbdv8i09pA5RyHqT9s9JRxNFc+
	 qY4YyOAYiuu1h6TiqUpDvOGN2mwKGFECOgr0TFhbX1zh5CvXbfJnDpAg7EeXXSjEy8
	 M8MYXPoFxYPyA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 46D7837809CE;
	Mon, 29 Jul 2024 07:57:44 +0000 (UTC)
Message-ID: <ba6cac02-615b-4db3-a591-fb1cb4e52823@collabora.com>
Date: Mon, 29 Jul 2024 12:57:41 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com
Subject: Re: [PATCH 2/3] bitmap: Rename module
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kees@kernel.org,
 David Gow <davidgow@google.com>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <20240726110658.2281070-3-usama.anjum@collabora.com>
 <f5aeeea3-1b6f-4ace-b346-b6650d6937a4@nvidia.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <f5aeeea3-1b6f-4ace-b346-b6650d6937a4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/26/24 11:45 PM, John Hubbard wrote:
> On 7/26/24 4:06 AM, Muhammad Usama Anjum wrote:
>> Rename module to bitmap_kunit and rename the configuration option
>> compliant with kunit framework.
>>
>> Cc: kees@kernel.org
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   MAINTAINERS                           |  2 +-
>>   lib/Kconfig.debug                     | 15 ++++++++-------
>>   lib/Makefile                          |  2 +-
>>   lib/{test_bitmap.c => bitmap_kunit.c} |  0
>>   4 files changed, 10 insertions(+), 9 deletions(-)
>>   rename lib/{test_bitmap.c => bitmap_kunit.c} (100%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 12b870712da4a..289b727344d64 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3814,13 +3814,13 @@ F:    include/linux/find.h
>>   F:    include/linux/nodemask.h
>>   F:    include/linux/nodemask_types.h
>>   F:    include/vdso/bits.h
>> +F:    lib/bitmap_kunit.c
>>   F:    lib/bitmap-str.c
>>   F:    lib/bitmap.c
>>   F:    lib/cpumask.c
>>   F:    lib/cpumask_kunit.c
>>   F:    lib/find_bit.c
>>   F:    lib/find_bit_benchmark.c
>> -F:    lib/test_bitmap.c
> 
> This changes the situation from "works for Linus' tab completion
> case", to "causes a tab completion problem"! :)
> 
> I think a tests/ subdir is how we eventually decided to do this [1],
> right?
Yes, Thank you for mentioning it. I'd missed the naming scheme. I'll fix it.

> 
> So:
> 
>     lib/tests/bitmap_kunit.c
> 
> 
> [1] https://lore.kernel.org/20240724201354.make.730-kees@kernel.org
> 
> thanks,

-- 
BR,
Muhammad Usama Anjum

