Return-Path: <linux-kselftest+bounces-3295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4BF835D08
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 09:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F631C23B1E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2581B3984F;
	Mon, 22 Jan 2024 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HeHbWEzb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602FD37143;
	Mon, 22 Jan 2024 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913207; cv=none; b=EylsWLHr5rimf/2xvbPdl0/4NG/2my0W/dLnXQsGU2mlDCvfwhCZFwhu1KbrlpL+GoEQYAInQuBWSjsmyHpqzTR25Dujx7b0d0QO9REi34IRzEe31T+zoXZftj0iATydQ5pfnQL6gFafdEznDFQ9X92DDuQ3wVictR1s1ZbrXig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913207; c=relaxed/simple;
	bh=BfEXGsOXX4GChLHbaYjozjYrk5u5mZPB4gS0W8ChVUU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CnLtE1pFxzqc6CCzEU4lqsStsJgYmVdMkFZmz/t+fvb4Xf9+1yQr1v2lZP4YGan0S3hp2lKh+I/Zx6i+9CsPf5vce/nmYt4brGVRrx4vZsZyiKAj7QFz7oCgUz4EHI9sE8jTU9PLG0hwGnIqpHZOWvMdeN/FRuOi8jwZhTNyLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HeHbWEzb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705913198;
	bh=BfEXGsOXX4GChLHbaYjozjYrk5u5mZPB4gS0W8ChVUU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HeHbWEzbiuiEtykd/PFD1bdJGpruJxNO64WFI1aVW/Iqnc6KVSLD35/NcZASVjsD1
	 7W+QNpvNAAIi9X7oc2P3LKFtoTNBgDU7T13iwYlFbvOhtBbrQWffUobk4X+LSewzpT
	 MuIKSAvwSz6bDWtXmriUkr0mI5jzAxbDjAxCTVJp59AVCBWO6eBlC3RKSqwwLAX5zJ
	 drp3cLtNBDsGS1Dg0qHVERohB7tzjobkIIpZJcWCOGHL5JRAJoD8kSo8MEYHuj6Mxu
	 QwZFA9ADDgJ7zZ68yV9OA9bpXfJD6/vtFdkxK7pO0nSDqCivDlhgY6feC/ucJ3Qqee
	 dq0balxQAtmag==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7F5883781FD3;
	Mon, 22 Jan 2024 08:46:36 +0000 (UTC)
Message-ID: <e3b2c142-aaae-481d-8206-5e8f374fd37e@collabora.com>
Date: Mon, 22 Jan 2024 13:46:49 +0500
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
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: add missing tests
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20240116090641.3411660-1-usama.anjum@collabora.com>
 <ffdba8c4-f1a2-4141-a3d4-0c85dfea6fef@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ffdba8c4-f1a2-4141-a3d4-0c85dfea6fef@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 9:09 PM, Ryan Roberts wrote:
> Hi Muhammad,
> 
> Afraid this patch is causing a regression on our CI system when it turned up in
> linux-next today. Additionally, 2 of thetests you have added are failing because
> the scripts are not exported correctly...
Andrew has dropped this patch for now.

> 
> On 16/01/2024 09:06, Muhammad Usama Anjum wrote:
>> Add missing tests to run_vmtests.sh. The mm kselftests are run through
>> run_vmtests.sh. If a test isn't present in this script, it'll not run
>> with run_tests or `make -C tools/testing/selftests/mm run_tests`.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  tools/testing/selftests/mm/run_vmtests.sh | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
>> index 246d53a5d7f2..a5e6ba8d3579 100755
>> --- a/tools/testing/selftests/mm/run_vmtests.sh
>> +++ b/tools/testing/selftests/mm/run_vmtests.sh
>> @@ -248,6 +248,9 @@ CATEGORY="hugetlb" run_test ./map_hugetlb
>>  CATEGORY="hugetlb" run_test ./hugepage-mremap
>>  CATEGORY="hugetlb" run_test ./hugepage-vmemmap
>>  CATEGORY="hugetlb" run_test ./hugetlb-madvise
>> +CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh
>> +CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh
> 
> These 2 tests are failing because the test scripts are not exported. You will
> need to add them to the TEST_FILES variable in the Makefile.
This must be done. I'll investigate even after adding them if these scripts
are robust enough to pass.

> 
>> +CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
> 
> The addition of this test causes 2 later tests to fail with ENOMEM. I suspect
> its a side-effect of marking the hugetlbs as hwpoisoned? (just a guess based on
> the test name!). Once a page is marked poisoned, is there a way to un-poison it?
> If not, I suspect that's why it wasn't part of the standard test script in the
> first place.
hugetlb-read-hwpoison failed as probably the fix in the kernel for the test
hasn't been merged in the kernel. The other tests (uffd-stress) aren't
failing on my end and on CI [1][2]

[1] https://lava.collabora.dev/scheduler/job/12577207#L3677
[2] https://lava.collabora.dev/scheduler/job/12577229#L4027

Maybe its configurations issue which is exposed now. Not sure. Maybe
hugetlb-read-hwpoison is changing some configuration and not restoring it.
Maybe your system has less number of hugetlb pages.

> 
> These are the tests that start failing:
> 
> # # ------------------------------------
> # # running ./uffd-stress hugetlb 128 32
> # # ------------------------------------
> # # nr_pages: 64, nr_pages_per_cpu: 8
> # # ERROR: context init failed (errno=12, @uffd-stress.c:254)
> # # [FAIL]
> # not ok 18 uffd-stress hugetlb 128 32 # exit=1
> # # --------------------------------------------
> # # running ./uffd-stress hugetlb-private 128 32
> # # --------------------------------------------
> # # nr_pages: 64, nr_pages_per_cpu: 8
> # # bounces: 31, mode: rnd racing ver poll, ERROR: UFFDIO_COPY error: -12ERROR:
> UFFDIO_COPY error: -12 (errno=12, @uffd-common.c:614)
> # #  (errno=12, @uffd-common.c:614)
> # # [FAIL]
> 
> Quickest way to repo is:
> 
> $ sudo ./run_vmtests.sh -t "userfaultfd hugetlb"
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

