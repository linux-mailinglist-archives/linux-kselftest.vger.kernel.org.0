Return-Path: <linux-kselftest+bounces-49372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D72FD3AC61
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 15:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2C81308808E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A40238A703;
	Mon, 19 Jan 2026 14:26:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798AD38A288;
	Mon, 19 Jan 2026 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832798; cv=none; b=X3B01musOUwyQSIt6S3VaFfmGTJF7gwcd9yGu/vPTL1pP3I87PWya0FrmMpk/GS5kr9OUJr2Sglo1PitCMHCSFE8BdASR6Qzb2/oWREzBk6iCnP1IdbvZoLF3fhO9qQxE6PU31ANPSrdnONNdytpazYbhi4zlrftQpfqF5/VnS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832798; c=relaxed/simple;
	bh=OltS73BK9qPHA6+f0G0GmOvpS3/x3+idBDJRBE6H10U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvl5mg9QyVeRgJAzTEekoheD7LD9b9rJO77v/hQP9MpPg4AUfpdRCwSLzQh8XN66uwuSS5HyJAtu9wyZfAlpJaawGWCoLVKb7iMZ4fO4iQM/H95ei93loivs1oEw5AQ9jdaWDrEUArHalOkcQSlrR+52XC00vXDQnxBtGd6K1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55E6D497;
	Mon, 19 Jan 2026 06:26:29 -0800 (PST)
Received: from [10.57.93.204] (unknown [10.57.93.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E548A3F632;
	Mon, 19 Jan 2026 06:26:33 -0800 (PST)
Message-ID: <46e50e9d-0e4a-4f81-8b43-61b897ad9c34@arm.com>
Date: Mon, 19 Jan 2026 14:26:32 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] selftests/mm: report SKIP in pfnmap if a check
 fails
Content-Language: en-GB
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20260107164842.3289559-1-kevin.brodsky@arm.com>
 <20260107164842.3289559-9-kevin.brodsky@arm.com>
 <09c214df-c3aa-48e4-9587-c54c667c6ce9@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <09c214df-c3aa-48e4-9587-c54c667c6ce9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/01/2026 11:16, David Hildenbrand (Red Hat) wrote:
> On 1/7/26 17:48, Kevin Brodsky wrote:
>> pfnmap currently checks the target file in FIXTURE_SETUP(pfnmap),
>> meaning once for every test, and skips the test if any check fails.
>>
>> The target file is the same for every test so this is a little
>> overkill. More importantly, this approach means that the whole suite
>> will report PASS even if all the tests are skipped because kernel
>> configuration (e.g. CONFIG_STRICT_DEVMEM=y) prevented /dev/mem from
>> being mapped, for instance.
>>
>> Let's ensure that KSFT_SKIP is returned as exit code if any check
>> fails by performing the checks in pfnmap_init(), run once. That
>> function also takes care of finding the offset of the pages to be
>> mapped and saves it in a global. The file is still mapped/unmapped
>> for every test, as some of them modify the mapping.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>   tools/testing/selftests/mm/pfnmap.c | 81 ++++++++++++++++++++---------
>>   1 file changed, 55 insertions(+), 26 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/
>> pfnmap.c
>> index 35b0e3ed54cd..e41d5464130b 100644
>> --- a/tools/testing/selftests/mm/pfnmap.c
>> +++ b/tools/testing/selftests/mm/pfnmap.c
>> @@ -25,8 +25,11 @@
>>   #include "kselftest_harness.h"
>>   #include "vm_util.h"
>>   +#define DEV_MEM_NPAGES    2
>> +
>>   static sigjmp_buf sigjmp_buf_env;
>>   static char *file = "/dev/mem";
>> +static off_t file_offset;
>>     static void signal_handler(int sig)
>>   {
>> @@ -88,7 +91,7 @@ static int find_ram_target(off_t *offset,
>>               break;
>>             /* We need two pages. */
>> -        if (end > start + 2 * pagesize) {
>> +        if (end > start + DEV_MEM_NPAGES * pagesize) {
>>               fclose(file);
>>               *offset = start;
>>               return 0;
>> @@ -97,9 +100,49 @@ static int find_ram_target(off_t *offset,
>>       return -ENOENT;
>>   }
>>   +static void pfnmap_init(void)
>> +{
>> +    size_t pagesize = getpagesize();
>> +    size_t size = DEV_MEM_NPAGES * pagesize;
>> +    int fd;
>> +    void *addr;
>> +
>> +    if (strncmp(file, "/dev/mem", strlen("/dev/mem")) == 0) {
>> +        int err = find_ram_target(&file_offset, pagesize);
>> +
>> +        if (err)
>> +            ksft_exit_skip("Cannot find ram target in '/proc/iomem': %s\n",
>> +                       strerror(-err));
>> +    } else {
>> +        file_offset = 0;
>> +    }
>> +
>> +    /*
>> +     * Make sure we can open and map the file, and perform some basic
>> +     * checks; skip the whole suite if anything goes wrong.
>> +     * A fresh mapping is then created for every test case by
>> +     * FIXTURE_SETUP(pfnmap).
>> +     */
>> +    fd = open(file, O_RDONLY);
>> +    if (fd < 0)
>> +        ksft_exit_skip("Cannot open '%s': %s\n", file, strerror(errno));
>> +
>> +    addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, file_offset);
>> +    if (addr == MAP_FAILED)
>> +        ksft_exit_skip("Cannot mmap '%s': %s\n", file, strerror(errno));
>> +
>> +    if (!check_vmflag_pfnmap(addr))
>> +        ksft_exit_skip("Invalid file: '%s'. Not pfnmap'ed\n", file);
>> +
>> +    if (test_read_access(addr, size))
>> +        ksft_exit_skip("Cannot read-access mmap'ed '%s'\n", file);
>> +
>> +    munmap(addr, size);
> 
> Why not keep the fd open then and supply that to all tests without the need for
> them to open/close?
> 
> Then, also the file cannot change etc.

I had a private conversation with Kevin about this before he posted; my very
minor, theorectical concern about that was that it's possible to pass in a
custom file to be pfnmapped and I wondered if such a file could map a device
region that has read side effects? In that case I think you'd want to open it
fresh for each test to ensure consistent starting state?

But if you think that concern is unfounded, certainly just opening it once and
reusing will simplify.

Thanks,
Ryan




