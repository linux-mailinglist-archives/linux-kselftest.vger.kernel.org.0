Return-Path: <linux-kselftest+bounces-3933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7C28457D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 13:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F101EB2B41D
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4DA15F311;
	Thu,  1 Feb 2024 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YBchkCDA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D904D779F0;
	Thu,  1 Feb 2024 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790380; cv=none; b=l0G8yWSqMYmxYAtP/ijVWu47y6cfudRKWfql3jJRRD1/yBUgqMMMOZrQyvJxF/SQLKvcG2D5urfu31qR3pW9ROU8UZz8d2+x49PIEqrVex4LsAh/fUBJfGQX7LW5gjLDU7U5Q8/8JKdCY1UkQ0qXjMbdozNWV9VYedKu5IlRtlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790380; c=relaxed/simple;
	bh=xg5m8felV7XMNg/ecDkG5YxQXJFG4fqtcpiToAp0aE4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f72vUHO00Z9kfS3e3t/dtedosDRbPBdgCjTWvDJg+N2/6CoDEg3wHqcdbwZxujs2R1Jw4CFplA9Y6nmreiYcHMZ792ZdFafRMKkPjA0Gw/u+XHz6zaTktroyhf/xG8+mZAVg7XHITR/WUqAiJK4lSd5vLBf/p/NpHey8juCNIyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YBchkCDA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706790376;
	bh=xg5m8felV7XMNg/ecDkG5YxQXJFG4fqtcpiToAp0aE4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YBchkCDA2ADPFyOfIaAPy6VfbCxUA4woSvmMFqErTo/eGM/o30X1zghyQjFY0MyhC
	 +N/s5HqRyxsxFa9WaUiFkMM0Cpq+4q/cJ42osL+jI3wYtAbDqZP3O4f8iaETpuvJcF
	 7FgHlcoLM9zjnDrHj9HvP5WGkstsqsaRiTSCltqLKdMNuKXcfFseCdNd4w++c+YoHD
	 cKPj6DLJSkAajiW7Q91EGgq5GX2xNLgjTkQvn46sdcYgHnk6MbSX9RV/Wq9tyczwK8
	 o++yH6dXavwI/AGaM+llvlTbNveYyvTaCdvZIHaXY51EfrF3Scr1vzj0mJ55RSbUzz
	 iiEPRBWeMU0jw==
Received: from [100.66.47.90] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 159F5378047F;
	Thu,  1 Feb 2024 12:26:13 +0000 (UTC)
Message-ID: <cbf00ee3-bb41-47b3-af03-8f26e313d0d5@collabora.com>
Date: Thu, 1 Feb 2024 17:26:29 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] selftests/mm: run_vmtests.sh: add missing tests
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20240125154608.720072-1-usama.anjum@collabora.com>
 <20240125154608.720072-6-usama.anjum@collabora.com>
 <ab7523db-f032-4f99-8090-785f126a3ae2@arm.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ab7523db-f032-4f99-8090-785f126a3ae2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/24 5:11 PM, Ryan Roberts wrote:
> On 25/01/2024 15:46, Muhammad Usama Anjum wrote:
>> Add missing tests to run_vmtests.sh. The mm kselftests are run through
>> run_vmtests.sh. If a test isn't present in this script, it'll not run
>> with run_tests or `make -C tools/testing/selftests/mm run_tests`.
>>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Copy the original scripts and their dependence script to install directory as well
>>
>> Changes since v2:
>> - Add a comment
>> - Move tests down in the file
>> - Add "-d" option which poisons the pages and aren't being useable after
>>   the test
>> ---
>>  tools/testing/selftests/mm/Makefile       | 5 +++++
>>  tools/testing/selftests/mm/run_vmtests.sh | 8 ++++++++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
>> index 2453add65d12f..f3aec7be80730 100644
>> --- a/tools/testing/selftests/mm/Makefile
>> +++ b/tools/testing/selftests/mm/Makefile
>> @@ -114,6 +114,11 @@ TEST_PROGS := run_vmtests.sh
>>  TEST_FILES := test_vmalloc.sh
>>  TEST_FILES += test_hmm.sh
>>  TEST_FILES += va_high_addr_switch.sh
>> +TEST_FILES += charge_reserved_hugetlb.sh
>> +TEST_FILES += hugetlb_reparenting_test.sh
>> +
>> +# required by charge_reserved_hugetlb.sh
>> +TEST_FILES += write_hugetlb_memory.sh
>>  
>>  include ../lib.mk
>>  
>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
>> index e373d592dbf5c..a0f37e4438937 100755
>> --- a/tools/testing/selftests/mm/run_vmtests.sh
>> +++ b/tools/testing/selftests/mm/run_vmtests.sh
>> @@ -19,6 +19,7 @@ usage: ${BASH_SOURCE[0]:-$0} [ options ]
>>    -t: specify specific categories to tests to run
>>    -h: display this message
>>    -n: disable TAP output
>> +  -d: run destructive tests
> 
> You probably want to clarify the behaviour for -a (all). I guess providing -a
> should NOT run destructive tests unless -d is also explicitly provided.
> 
>>  
>>  The default behavior is to run required tests only.  If -a is specified,
>>  will run all tests.
>> @@ -79,6 +80,7 @@ EOF
>>  }
>>  
>>  RUN_ALL=false
>> +RUN_DESTRUCTIVE_TEST=false
> 
> Either call this RUN_DESTRUCTIVE (my preference) or at least make it plural
> (RUN_DESTRUCTIVE_TESTS).
> 
>>  TAP_PREFIX="# "
>>  
>>  while getopts "aht:n" OPT; do
>> @@ -87,6 +89,7 @@ while getopts "aht:n" OPT; do
>>  		"h") usage ;;
>>  		"t") VM_SELFTEST_ITEMS=${OPTARG} ;;
>>  		"n") TAP_PREFIX= ;;
>> +		"a") RUN_DESTRUCTIVE_TEST=true ;;
> 
> The help you added says the option is -d, but this is looking for -a, and
> conflicting with the existing -a=all option.
Sorry, that's a typo. I'll resolve your above comments with fix patch as well.

> 
>>  	esac
>>  done
>>  shift $((OPTIND -1))
>> @@ -304,6 +307,11 @@ CATEGORY="process_mrelease" run_test ./mrelease_test
>>  CATEGORY="mremap" run_test ./mremap_test
>>  
>>  CATEGORY="hugetlb" run_test ./thuge-gen
>> +CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh -cgroup-v2
>> +CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh -cgroup-v2
>> +if $RUN_DESTRUCTIVE_TEST; then
>> +CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
>> +fi
>>  
>>  if [ $VADDR64 -ne 0 ]; then
>>  
> 
> 

-- 
BR,
Muhammad Usama Anjum

