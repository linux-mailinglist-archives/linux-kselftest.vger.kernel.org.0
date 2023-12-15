Return-Path: <linux-kselftest+bounces-2026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960EC814928
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C897F1C203DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778942D7B7;
	Fri, 15 Dec 2023 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uDr6Wazg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102562C688;
	Fri, 15 Dec 2023 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702646799;
	bh=WMPnWsUlFFgO2rziKdOQefwB/ccC+zfLPtfvmvBwKqY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=uDr6WazgLau8fLePhmRCMl5xT4wm8MODt32jt91i1Pk5o2yrRk2Tcy7Cl+QQfBNXz
	 uDt5UVsvgQ3txgNqRNXmARNokg5lIJpn0KXyWYKptMjFzHgSV+JmhsnFvCCnEyeWfK
	 xMxX1FFQvI2vcINV69z5KoK5mO/8Y3skD62UY1TZrkhdEaeMsvJ+yli7IBg1+Ii6HU
	 ce92YICdeOLZvBnbfmIaLOf6uF5mx9fc4EMTYJ0XS8a9GduCNwt14glp1xEKve9HUM
	 utb7HLqBnT/HF4yqZyNrQJRVq7sEjVWQsCIXdUiUdOQZVOSB2NqTDubWMGkpYLKtnO
	 +VE6OvLK8gp7A==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A80CA3781FB2;
	Fri, 15 Dec 2023 13:26:34 +0000 (UTC)
Message-ID: <71a3274c-a51a-4660-a7cf-679e779af6ad@collabora.com>
Date: Fri, 15 Dec 2023 18:26:30 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 kernel@collabora.com, "kernelci.org bot" <bot@kernelci.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: secretmem: Floor the memory size to the
 multiple of page_size
To: Mike Rapoport <rppt@kernel.org>
References: <20231214101931.1155586-1-usama.anjum@collabora.com>
 <20231215105933.GO636165@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231215105933.GO636165@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/23 3:59 PM, Mike Rapoport wrote:
> On Thu, Dec 14, 2023 at 03:19:30PM +0500, Muhammad Usama Anjum wrote:
>> The "locked-in-memory size" limit per process can be non-multiple of
>> page_size. The mmap() fails if we try to allocate locked-in-memory
>> with same size as the allowed limit if it isn't multiple of the
>> page_size because mmap() rounds off the memory size to be allocated
>> to next multiple of page_size.
>>
>> Fix this by flooring the length to be allocated with mmap() to the
>> previous multiple of the page_size.
>>
>> Fixes: 76fe17ef588a ("secretmem: test: add basic selftest for memfd_secret(2)")
>> Reported-by: "kernelci.org bot" <bot@kernelci.org>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  tools/testing/selftests/mm/memfd_secret.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
>> index 957b9e18c729..9b298f6a04b3 100644
>> --- a/tools/testing/selftests/mm/memfd_secret.c
>> +++ b/tools/testing/selftests/mm/memfd_secret.c
>> @@ -62,6 +62,9 @@ static void test_mlock_limit(int fd)
>>  	char *mem;
>>  
>>  	len = mlock_limit_cur;
>> +	if (len % page_size != 0)
>> +		len = (len/page_size) * page_size;
>> +
> 
> With mlock limit smaller than a page we get zero length here and mmap will
> fail with -EINVAL because of it.
This test has a initialization step in prepare() where it increases the
limit to at least a page if it is less than a page. Hence we'll never get
len = 0 here.

> In this case I think we can just skip the first mmap and only check that
> mmaping more than mlock limit fails.
> 
>>  	mem = mmap(NULL, len, prot, mode, fd, 0);
>>  	if (mem == MAP_FAILED) {
>>  		fail("unable to mmap secret memory\n");
>> -- 
>> 2.42.0
>>
> 

-- 
BR,
Muhammad Usama Anjum

