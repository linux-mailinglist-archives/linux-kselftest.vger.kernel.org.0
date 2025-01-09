Return-Path: <linux-kselftest+bounces-24157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65482A07F43
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAAA9188CE9C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8989119CC20;
	Thu,  9 Jan 2025 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="cjlAjR8f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33961991D2;
	Thu,  9 Jan 2025 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444936; cv=pass; b=cPDiEykqId+zjVyQZoGvVF511eoSrodAMx4r4O7QMFyBZt0ij/t8MBe5bap8cSqhowZxuHHov8+STaK+iPixTczPMyfPD+2didw/AAZA1FqGEjzDahwktISjNelbPCkiFlNyDgsfsGojvM1hL66ISs6QnJkqmv9vBxBX3BJ6XMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444936; c=relaxed/simple;
	bh=07gucdF8Io33jsVWumFe7f+kaPmFBST//hAjgo2Va70=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TmAiWlfLTMvnyg+PbKs+UKzCBngR9P4dgE4sXb5ri9cy+lrHYfwuqoKMV2zjToGrpWoKOHT8yw6dTmDGSkvrwgMch14wCJ6kzHTZTS4e6y9N6QEvc9DChv2ZbuUs0fUXv0JkloEA8PJ/pHb4/0ETDVM+bVeRz8g9sbKlM4cIqBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=cjlAjR8f; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444916; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P0pxul2Nk8AjHyXJTKzJ9pxTFYhdycvBx244/JO0nBB+Gil3OnyEfRZtW8HQrWLtvAMWO29+oSFACZg/tj2NIfCmGzAVDciQ4eUbdeGq+tTGiDqJw9vWEIn9mwew2l+JM+9oAvsHu+OoZqUXD0CD6CTUrAkMCs4w1NUJD6BV5eU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444916; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7pSLBT5GTiy8l8cA8ZgCQNESRaMTsNJdWXHMYVnXF/Y=; 
	b=IW6UHXr8pNwy3n07zwj58IVPs0ydsSh+iQnbU88bnoGRyC/h+kD2nJEGREHcYYlZjuN5vwXjmRZtwQWxx46zccH6Dy28qtCIRBa65Rj5gEnPZEuwXN3muYXtydfg5Tz7kmY448RhZJFTJhhAekgnByOA7PoVZIgu48+A555qRGY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444916;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7pSLBT5GTiy8l8cA8ZgCQNESRaMTsNJdWXHMYVnXF/Y=;
	b=cjlAjR8fgoxftjFZbW4V6qC2jyJxh7dM1OMeJ9sQTSXZkB1iNwm07PoixJCSySto
	tLVSPPv1yGK6vqL2xtCcGixkcnKsf5K9tton21SKmHHk+lXGfJZu8PTdKZO3HyCpzqi
	EGnb4DwsfxfPBNPECLur2YIdYxomMDQgtA5bv+vI=
Received: by mx.zohomail.com with SMTPS id 1736444914002678.3576966097946;
	Thu, 9 Jan 2025 09:48:34 -0800 (PST)
Message-ID: <843bf743-4005-47bc-9e39-8ea49255b152@collabora.com>
Date: Thu, 9 Jan 2025 22:48:52 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel@collabora.com
Subject: Re: [PATCH 01/16] selftests/mm: remove argc and argv unused
 parameters
To: Kees Cook <kees@kernel.org>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
 <20250109173842.1142376-2-usama.anjum@collabora.com>
 <202501090941.5289E7444B@keescook>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <202501090941.5289E7444B@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 1/9/25 10:42 PM, Kees Cook wrote:
> On Thu, Jan 09, 2025 at 10:38:27PM +0500, Muhammad Usama Anjum wrote:
>> Remove the following warnings by removing unused argc and argv
>> parameters:
>> In function ‘main’:
>>   warning: unused parameter ‘argc’ [-Wunused-parameter]
>>     158 | int main(int argc, char *argv[])
>>         |          ~~~~^~~~
>>   warning: unused parameter ‘argv’ [-Wunused-parameter]
>>     158 | int main(int argc, char *argv[])
>>         |                    ~~~~~~^~~~~~
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  tools/testing/selftests/mm/compaction_test.c       | 2 +-
>>  tools/testing/selftests/mm/cow.c                   | 2 +-
>>  tools/testing/selftests/mm/droppable.c             | 2 +-
>>  tools/testing/selftests/mm/gup_longterm.c          | 2 +-
>>  tools/testing/selftests/mm/hugepage-vmemmap.c      | 2 +-
>>  tools/testing/selftests/mm/hugetlb-madvise.c       | 2 +-
>>  tools/testing/selftests/mm/hugetlb-soft-offline.c  | 2 +-
>>  tools/testing/selftests/mm/madv_populate.c         | 2 +-
>>  tools/testing/selftests/mm/map_populate.c          | 2 +-
>>  tools/testing/selftests/mm/memfd_secret.c          | 2 +-
>>  tools/testing/selftests/mm/mlock-random-test.c     | 2 +-
>>  tools/testing/selftests/mm/mlock2-tests.c          | 2 +-
>>  tools/testing/selftests/mm/on-fault-limit.c        | 2 +-
>>  tools/testing/selftests/mm/pkey_sighandler_tests.c | 2 +-
>>  tools/testing/selftests/mm/soft-dirty.c            | 2 +-
>>  tools/testing/selftests/mm/uffd-wp-mremap.c        | 2 +-
>>  tools/testing/selftests/mm/virtual_address_range.c | 2 +-
>>  17 files changed, 17 insertions(+), 17 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
>> index 2c3a0eb6b22d3..8d23b698ce9db 100644
>> --- a/tools/testing/selftests/mm/compaction_test.c
>> +++ b/tools/testing/selftests/mm/compaction_test.c
>> @@ -194,7 +194,7 @@ int set_zero_hugepages(unsigned long *initial_nr_hugepages)
>>  	return ret;
>>  }
>>  
>> -int main(int argc, char **argv)
>> +int main(void)
>>  {
>>  	struct rlimit lim;
>>  	struct map_list *list = NULL, *entry;
>> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
>> index 1238e1c5aae15..ea00c85c76caa 100644
>> --- a/tools/testing/selftests/mm/cow.c
>> +++ b/tools/testing/selftests/mm/cow.c
>> @@ -1769,7 +1769,7 @@ static int tests_per_non_anon_test_case(void)
>>  	return tests;
>>  }
>>  
>> -int main(int argc, char **argv)
>> +int main(void)
>>  {
>>  	int err;
>>  	struct thp_settings default_settings;
>> diff --git a/tools/testing/selftests/mm/droppable.c b/tools/testing/selftests/mm/droppable.c
>> index f3d9ecf96890a..90ea6377810c5 100644
>> --- a/tools/testing/selftests/mm/droppable.c
>> +++ b/tools/testing/selftests/mm/droppable.c
>> @@ -15,7 +15,7 @@
>>  
>>  #include "../kselftest.h"
>>  
>> -int main(int argc, char *argv[])
>> +int main(void)
>>  {
>>  	size_t alloc_size = 134217728;
>>  	size_t page_size = getpagesize();
>> diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
>> index 9423ad439a614..03a31dcb57577 100644
>> --- a/tools/testing/selftests/mm/gup_longterm.c
>> +++ b/tools/testing/selftests/mm/gup_longterm.c
>> @@ -444,7 +444,7 @@ static int tests_per_test_case(void)
>>  	return 3 + nr_hugetlbsizes;
>>  }
>>  
>> -int main(int argc, char **argv)
>> +int main(void)
>>  {
>>  	int i, err;
>>  
>> diff --git a/tools/testing/selftests/mm/hugepage-vmemmap.c b/tools/testing/selftests/mm/hugepage-vmemmap.c
>> index df366a4d1b92d..23e97e552057d 100644
>> --- a/tools/testing/selftests/mm/hugepage-vmemmap.c
>> +++ b/tools/testing/selftests/mm/hugepage-vmemmap.c
>> @@ -87,7 +87,7 @@ static int check_page_flags(unsigned long pfn)
>>  	return 0;
>>  }
>>  
>> -int main(int argc, char **argv)
>> +int main(void)
>>  {
>>  	void *addr;
>>  	unsigned long pfn;
>> diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
>> index e74107185324f..43f16c12c8e9a 100644
>> --- a/tools/testing/selftests/mm/hugetlb-madvise.c
>> +++ b/tools/testing/selftests/mm/hugetlb-madvise.c
>> @@ -58,7 +58,7 @@ void read_fault_pages(void *addr, unsigned long nr_pages)
>>  	}
>>  }
>>  
>> -int main(int argc, char **argv)
>> +int main(int __attribute__((unused)) argc, char **argv)
> 
> Can we add a macro in kselftest.h for "__unused" like the kernel already
> does?
It can be done. But as there kselftest patches aren't regulated as much as
other kernel patches, people may still not use this macro and use the gcc
attribute directly. Let's see what others have to say.

> Then instead of removing args, we can just mark them, like you're
> doing here.
In this case, argv is being used while argc isn't being used. I didn't
find a way to keep argv and remove argc. Hence I marked argc as unused.

For the all other case, why should we keep argv/argc and mark them unused
as well when they aren't being used?

-- 
BR,
Muhammad Usama Anjum

