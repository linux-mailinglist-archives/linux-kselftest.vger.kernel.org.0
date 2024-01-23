Return-Path: <linux-kselftest+bounces-3418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3205483919D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 15:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B9C1C20CB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EAC50A61;
	Tue, 23 Jan 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oYH9+34T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A241C5026F;
	Tue, 23 Jan 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706021102; cv=none; b=tYa5BBQ4/SFcbDSNXJYa9C/Ds1FWe0NR30Efl/zLrNCAWvQDsaV9/GawikjQ5Jyz4u66WDF5DB7od1pexgPNGFJ/6tsEkbbMSDynRKJq++XFP9t0gjHV7POm6SUm/tjyy5zuVwqit8X/ZclnTn8fQTm0BvkbGwsbVVwknTKs72w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706021102; c=relaxed/simple;
	bh=+8mWQtyFcnYGhfR0wkSQ68fK9+UKR6e+xL/523DTfrE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aU9/kxnr2+YeurUxjFusLPE02lJ9WNkE/QQVwVjiZ5py0OPVmztnX+ilUtjorDnAQh1UJEGNMxJnJp7xqUC23wN4SSLajW0RA+IP6dv1R+yX/lftCv5pifHzCkzyC85RRqYR2QLuhuOKw9g8KH4jVJ3qG3/x3Ca+/3u2evmFvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oYH9+34T; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706021099;
	bh=+8mWQtyFcnYGhfR0wkSQ68fK9+UKR6e+xL/523DTfrE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oYH9+34T274wj0pmflwVQkZtj4kzL8X0IozbxHiUB9ZxNClluGgTttaT4fIDBM3zg
	 /c1PI1tgscghRptoWKdEndPRz85x5eU6/hvZbRgXGcEzBx1qKSGoG2YiotL/+9Cgkh
	 0wJKLLagQx9oMACCrnO+GquHBAVe+sfJk8P5q3JGCeo7eGpzy2rVybdaE15QyxXOV+
	 Os1+/IMiq88hvgXLTh1OsOLQNCcWVOL7DFqRR+I2ojRiKPmVS5QRIwzRcKuHmO6dvq
	 34SAn06OsRTaNegs093K7Ji1pGJo3EF3K4EpazlyotI676TaEKiNelO8qOIS21m3Rh
	 4thZ6PDfmB0jg==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DC41437820AF;
	Tue, 23 Jan 2024 14:44:56 +0000 (UTC)
Message-ID: <4bf9bf87-0622-4824-9026-d7ab5839f433@collabora.com>
Date: Tue, 23 Jan 2024 19:45:08 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 1/2] selftests/mm: run_vmtests.sh: add missing tests
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>
References: <20240123073615.920324-1-usama.anjum@collabora.com>
 <e92f7c49-5268-421e-a017-af268c845b1b@arm.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <e92f7c49-5268-421e-a017-af268c845b1b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ryan,

Thank you so much for reviewing and getting involved.

On 1/23/24 2:33 PM, Ryan Roberts wrote:
> On 23/01/2024 07:36, Muhammad Usama Anjum wrote:
>> Add missing tests to run_vmtests.sh. The mm kselftests are run through
>> run_vmtests.sh. If a test isn't present in this script, it'll not run
>> with run_tests or `make -C tools/testing/selftests/mm run_tests`.
>>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Copy the original scripts and their dependence script to install directory as well
>> ---
>>  tools/testing/selftests/mm/Makefile       | 3 +++
>>  tools/testing/selftests/mm/run_vmtests.sh | 3 +++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
>> index 2453add65d12f..c9c8112a7262e 100644
>> --- a/tools/testing/selftests/mm/Makefile
>> +++ b/tools/testing/selftests/mm/Makefile
>> @@ -114,6 +114,9 @@ TEST_PROGS := run_vmtests.sh
>>  TEST_FILES := test_vmalloc.sh
>>  TEST_FILES += test_hmm.sh
>>  TEST_FILES += va_high_addr_switch.sh
>> +TEST_FILES += charge_reserved_hugetlb.sh
>> +TEST_FILES += write_hugetlb_memory.sh
>> +TEST_FILES += hugetlb_reparenting_test.sh
> 
> I see you are exporting 3 scripts, but only invoking 2 of them from
> run_vmtests.sh below. Is one a helper that gets called indirectly?
Yeah, write_hugetlb_memory.sh is needed by charge_reserved_hugetlb.sh. I'll
put a comment there.

> 
>>  
>>  include ../lib.mk
>>  
>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
>> index 246d53a5d7f28..12754af00b39c 100755
>> --- a/tools/testing/selftests/mm/run_vmtests.sh
>> +++ b/tools/testing/selftests/mm/run_vmtests.sh
>> @@ -248,6 +248,9 @@ CATEGORY="hugetlb" run_test ./map_hugetlb
>>  CATEGORY="hugetlb" run_test ./hugepage-mremap
>>  CATEGORY="hugetlb" run_test ./hugepage-vmemmap
>>  CATEGORY="hugetlb" run_test ./hugetlb-madvise
>> +CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh -cgroup-v2
>> +CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh -cgroup-v2
>> +CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
> 
> I'm not really a fan of adding this last test here; its destructive because it
> poisons 8 hugepages. So at a minimum, I think you need to modify the code in
> run_vmtests.sh to ensure those extra pages are allocated (there is already a
> section in the script that allocates hugepages).
> 
> However, given this test is destructive, I'd prefer that it wasn't run as part
> of the main test set. Because the first time you run it, it will presumably
> pass, but now some of the hugepages are poisoned so next time you run it, there
> won't be enough unpoisoned hugepages and a test will fail. So you have very
> confusing behaviour for a developer who might be running these tests multiple
> times per boot (e.g. me).
> 
> Perhaps we can add a -d (destructive) option to the script, and this test will
> only be run if that option is passed?
Ideally we should be able to fix these tests before enabling them and there
shouldn't be any side-effect of these. I'm struggling with the
configurations where I'm getting consistent results. Studying and analyzing
how and how many hugetlbs are being allocated/deallocated isn't straight
forward enough in these.

I'll spend more time to either put it under some flag or modify the tests
to don't entangle with each other.

> 
> Thanks,
> Ryan
> 
> 
>>  
>>  nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
>>  # For this test, we need one and just one huge page
> 
> 

-- 
BR,
Muhammad Usama Anjum

