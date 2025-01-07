Return-Path: <linux-kselftest+bounces-23995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F056A0432E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7CB162F62
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3881F193F;
	Tue,  7 Jan 2025 14:51:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8176F1F1921
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Jan 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261476; cv=none; b=UnHtC/dnYy/fnT0BNSgZggx8GF/07e2yGbwwKQ7Y77ZzTpVyMv/XSgdpR+R76qcd8DLQJxEWqKqOyVl9jAq3CIEkiNfZCt/elVd2OqRLPPc/N0NwYt5qwawgSYSGja4suMtY/D39l2JXU6eapvTOWZoIkBYzT5f1z8p61WibJgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261476; c=relaxed/simple;
	bh=byXyATrqjPzgx9TTQVHMwtyBhbWZCr2EzAWbCY27NZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqLy8tgTAfy68ZH3xd6TU12TLbzuhaL1Fb4Otha00Ch6DK1qs7rEJjL7LqhEV5nIoB5iMXWsYDhj7/ARMcFqwrDSG6P0xFixS7HqK+/lN2JTLUhzjzTGjS46eNlFDU2zNezufaLQEGtUauCd/wn0Duz1DbPo7SSv2Cfuzv/mmag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 313821424;
	Tue,  7 Jan 2025 06:51:41 -0800 (PST)
Received: from [10.1.31.134] (XHFQ2J9959.cambridge.arm.com [10.1.31.134])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 964FD3F673;
	Tue,  7 Jan 2025 06:51:10 -0800 (PST)
Message-ID: <dd630868-0d51-41a2-8c19-e93657dcb4ed@arm.com>
Date: Tue, 7 Jan 2025 14:51:07 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/mm: static process_madvise() wrapper for
 guard-pages
Content-Language: en-GB
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20250107142937.1870478-1-ryan.roberts@arm.com>
 <fcb6cf10-7789-4eee-bba1-55a2c131d935@lucifer.local>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <fcb6cf10-7789-4eee-bba1-55a2c131d935@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/01/2025 14:48, Lorenzo Stoakes wrote:
> On Tue, Jan 07, 2025 at 02:29:35PM +0000, Ryan Roberts wrote:
>> The recently introduced guard-pages mm selftest uses the
>> process_madvise() syscall, a wrapper for which was added to glibc v2.36.
>> For those of us stuck with older distributions this causes a compile
>> error when compiling the mm selftests. For example Ubuntu 22.04 uses
>> glibc 2.35, which does not have the wrapper.
> 
> Ah oops! I didn't check glibc and had erroneously assumed this would be
> trivially available, but perhaps using a rolling release distro has warped
> my perceptions on this rather...
> 
> At any rate you're entire correct, this is very much needed, cheers!
> 
>>
>> To workaround the issue, let's introduce our own static
>> process_madvise() wrapper that uses glibc's syscall() helper.
>>
>> While we are at it, add the guard-page test suite to run_vmtests.sh so
>> that it can be automatically run by CI systems.
> 
> Oops part 2... I was sure I had added it there... thanks!
> 
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

No worries, thanks for the quick review!

> 
>> ---
>>
>> Applies on top of mm-unstable (f349e79bfbf3)
>>
>> Thanks,
>> Ryan
>>
>>  tools/testing/selftests/mm/guard-pages.c  | 10 ++++++++--
>>  tools/testing/selftests/mm/run_vmtests.sh |  5 +++++
>>  2 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
>> index d8f8dee9ebbd..ece37212a8a2 100644
>> --- a/tools/testing/selftests/mm/guard-pages.c
>> +++ b/tools/testing/selftests/mm/guard-pages.c
>> @@ -55,6 +55,12 @@ static int pidfd_open(pid_t pid, unsigned int flags)
>>  	return syscall(SYS_pidfd_open, pid, flags);
>>  }
>>
>> +static ssize_t sys_process_madvise(int pidfd, const struct iovec *iovec,
>> +				   size_t n, int advice, unsigned int flags)
>> +{
>> +	return syscall(__NR_process_madvise, pidfd, iovec, n, advice, flags);
>> +}
>> +
>>  /*
>>   * Enable our signal catcher and try to read/write the specified buffer. The
>>   * return value indicates whether the read/write succeeds without a fatal
>> @@ -419,7 +425,7 @@ TEST_F(guard_pages, process_madvise)
>>  	ASSERT_EQ(munmap(&ptr_region[99 * page_size], page_size), 0);
>>
>>  	/* Now guard in one step. */
>> -	count = process_madvise(pidfd, vec, 6, MADV_GUARD_INSTALL, 0);
>> +	count = sys_process_madvise(pidfd, vec, 6, MADV_GUARD_INSTALL, 0);
>>
>>  	/* OK we don't have permission to do this, skip. */
>>  	if (count == -1 && errno == EPERM)
>> @@ -440,7 +446,7 @@ TEST_F(guard_pages, process_madvise)
>>  	ASSERT_FALSE(try_read_write_buf(&ptr3[19 * page_size]));
>>
>>  	/* Now do the same with unguard... */
>> -	count = process_madvise(pidfd, vec, 6, MADV_GUARD_REMOVE, 0);
>> +	count = sys_process_madvise(pidfd, vec, 6, MADV_GUARD_REMOVE, 0);
>>
>>  	/* ...and everything should now succeed. */
>>
>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
>> index 2fc290d9430c..00c3f07ea100 100755
>> --- a/tools/testing/selftests/mm/run_vmtests.sh
>> +++ b/tools/testing/selftests/mm/run_vmtests.sh
>> @@ -45,6 +45,8 @@ separated by spaces:
>>  	vmalloc smoke tests
>>  - hmm
>>  	hmm smoke tests
>> +- madv_guard
>> +	test madvise(2) MADV_GUARD_INSTALL and MADV_GUARD_REMOVE options
>>  - madv_populate
>>  	test memadvise(2) MADV_POPULATE_{READ,WRITE} options
>>  - memfd_secret
>> @@ -375,6 +377,9 @@ CATEGORY="mremap" run_test ./mremap_dontunmap
>>
>>  CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
>>
>> +# MADV_GUARD_INSTALL and MADV_GUARD_REMOVE tests
>> +CATEGORY="madv_guard" run_test ./guard-pages
>> +
>>  # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
>>  CATEGORY="madv_populate" run_test ./madv_populate
>>
>> --
>> 2.43.0
>>


