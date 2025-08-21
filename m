Return-Path: <linux-kselftest+bounces-39454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6080B2EE10
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 08:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F797BACCA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC08261B82;
	Thu, 21 Aug 2025 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qJYDM3g5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BA625BEFD;
	Thu, 21 Aug 2025 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757170; cv=none; b=gIShlpi33KNxACgjfV+1YjcRUWj5T7w12J9jHhVRsq4zN2MCs7OOjmusDGfPLn3OyoGxO2LolES1uWsqLCQAnb/JHnYY0a+40STSHhxiDC0uea9q7HN2WhPKK5gpv0dXR2s3ksUCj/Bnk+rq6iEjAnC2Yb7R5isIwdBmdfOEo/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757170; c=relaxed/simple;
	bh=I4zrmHfo3KUrLNPHF7/jdsoSqAbmt4bHTj4T59OIe/w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fPQPFIvj/HIgyecgQe79w9OdB6jIA3oDXKolkEpyGSZ4AjG+mfZETLNi0HOS52FMBLl01DgFM1z+QdSr4bJwdVrW69+xJ2evEQ6i+v6tVwA/mhQVJN4AV5Ilc4cYynBXcbXBE77RgKNASi6xDsxk4l6zb3ClupkT2FEs6a8TcWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qJYDM3g5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755757166;
	bh=I4zrmHfo3KUrLNPHF7/jdsoSqAbmt4bHTj4T59OIe/w=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qJYDM3g5NXoL0QCYPIMItwhZAY7s/w47WqfLvieaC0s4EC2hPZ+XScMGvi1G6NxWM
	 FYEDZeHOND36YeFiwA08wY/hu3sM6Zgpau/MZloXBUJAKXmJCNsgX9/CAgjiu9cn2q
	 Z7aN1qLnPUFlGy3CMcCZaoIslFGSiLmrwRXyqxK+RFUdcs6CkOKY4C50XGlqbbn8CC
	 nG8K9/SakCWfA3yyKOcw9CoAAR6HHfO9giUxaXK+uK+qgHezpIO6LfsyMR7/1E9I0C
	 9zoSuhJnacA1Idu3dDuyeSxJ03mlbh7AijE75W3/Ik9J+zXsSuKLjYhMz5oVjqpR6B
	 64EbxkdmLlX9Q==
Received: from [192.168.100.175] (unknown [103.151.43.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 845C617E0071;
	Thu, 21 Aug 2025 08:19:21 +0200 (CEST)
Message-ID: <46dce2ac-adb5-4a6b-8847-fe214c1599a7@collabora.com>
Date: Thu, 21 Aug 2025 11:19:20 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, kernel@collabora.com
Subject: Re: [PATCH v2 1/8] selftests/mm: Add -Wunreachable-code and fix
 warnings
To: Kevin Brodsky <kevin.brodsky@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Leon Romanovsky <leon@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, Shuah Khan <shuah@kernel.org>
References: <20250731160132.1795351-1-usama.anjum@collabora.com>
 <20250731160132.1795351-2-usama.anjum@collabora.com>
 <c09a2a13-8571-44e5-b780-c704598df764@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <c09a2a13-8571-44e5-b780-c704598df764@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 1:10 PM, Kevin Brodsky wrote:
> On 31/07/2025 18:01, Muhammad Usama Anjum wrote:
>> [...]
>>
>> diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
>> index b5e076a564c95..302fef54049c8 100644
>> --- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
>> +++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
>> @@ -41,7 +41,7 @@ static siginfo_t siginfo = {0};
>>   * syscall will attempt to access the PLT in order to call a library function
>>   * which is protected by MPK 0 which we don't have access to.
>>   */
>> -static inline __always_inline
>> +static __always_inline
> 
> Thanks for this, I had this fix locally but never got to post it!
> 
>>  long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
>>  {
>>  	unsigned long ret;
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>> index 05de1fc0005b7..a85b2e393e4e8 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -296,10 +296,8 @@ void split_file_backed_thp(int order)
>>  		ksft_exit_fail_msg("Unable to create a tmpfs for testing\n");
>>  
>>  	status = snprintf(testfile, INPUT_MAX, "%s/thp_file", tmpfs_loc);
>> -	if (status >= INPUT_MAX) {
>> +	if (status >= INPUT_MAX)
>>  		ksft_exit_fail_msg("Fail to create file-backed THP split testing file\n");
>> -		goto cleanup;
> 
> At that point the mount() call has succeeded so I think we do want to
> keep the goto and just print the error message instead of calling
> replace ksft_exit_fail_msg().
The cleanup tag does cleanup and then calls ksft_exit_fail_msg() without printing the
actual reason of failure. So current flow seems good where information about the error
is being printed.

> 
> - Kevin
> 
>> -	}
>>  
>>  	fd = open(testfile, O_CREAT|O_RDWR, 0664);
>>  	if (fd == -1) {


-- 
---
Thanks,
Usama

