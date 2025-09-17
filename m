Return-Path: <linux-kselftest+bounces-41671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23B6B7DA1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375761C04007
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8562E611B;
	Wed, 17 Sep 2025 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lvRnFj3K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C20F2BEFEE
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107170; cv=none; b=gyELUjaHO72lT0fBmWZhJAoaKYNXcUZhvH6029OSgBqYjpgWd7iZVGsjgzTbS/irDnGh4ElfWE8lpe/lc0g0ByTjNuOacHHfON38JAVTlCoJFZ4cFaWZ4U0DZUrSEAKCW8Zu/ptjx52mfXl86VwXnmmj+T2i+0drJOuXPsP+PCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107170; c=relaxed/simple;
	bh=8FUotb9Lid3Lmal2qWsTDiT/27OCnrqeixu8Tv+59WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwjIS1Yjq1x2ta7okbKBlL/wZsSAC444hyQt6hRaykIreD7hojq6fj8757uR8PoPKWLalMkrtDS19Gbfxc0irR1l9k7gA9pZhRSxthvTz7aMW459bhERhl/AfZCFoIN1f8qwCv48bIttA7gr2uiBqREZI5gY3hSwCjKd7dk+cWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lvRnFj3K; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1e75f092-b3ac-48d9-a304-c980e1d61472@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758107154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TuuVoVWXNYbl+ds4b8F2xNM0nTUIAdxFSHG+zKy+0Ho=;
	b=lvRnFj3KdzdsDt8rnP8I8JemxUlfemkDZK1FMj4IeOLHK++G2cTWs6v75mkO745sIBJf6g
	diqCfbSHzhn9dc/JmzXuR5/6qcNySJy+behVS5O9VkOh150PtAMA/kfzNDSpYRHqY+P0d9
	JsKzG0wdMdDmkN5Hxfa/vhBZ6p8QcPs=
Date: Wed, 17 Sep 2025 19:05:47 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND 1/1] selftests/mm: skip soft-dirty tests when
 CONFIG_MEM_SOFT_DIRTY is disabled
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: shuah@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com
References: <20250917055913.49759-1-lance.yang@linux.dev>
 <353bf8f0-d9ad-4800-80d7-4177ae64eb95@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <353bf8f0-d9ad-4800-80d7-4177ae64eb95@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/17 18:51, David Hildenbrand wrote:
> On 17.09.25 07:59, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> The madv_populate and soft-dirty kselftests currently fail on systems 
>> where
>> CONFIG_MEM_SOFT_DIRTY is disabled.
>>
>> Introduce a new helper softdirty_is_supported() into vm_util.c/h to 
>> ensure
>> tests are properly skipped when the feature is not enabled.
> 
> I'll note that tools/testing/selftests/mm/config contains
> 
>      CONFIG_MEM_SOFT_DIRTY=y
> 
> But yes, the current arm64 handling is nasty, because some other archs 
> (e.g., riscv) also don't support it yet.

Yep.

> 
> LGTM, some nits below:

Thanks for taking time to review!

> 
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   tools/testing/selftests/mm/madv_populate.c | 21 ++--------------
>>   tools/testing/selftests/mm/soft-dirty.c    |  5 +++-
>>   tools/testing/selftests/mm/vm_util.c       | 28 ++++++++++++++++++++++
>>   tools/testing/selftests/mm/vm_util.h       |  1 +
>>   4 files changed, 35 insertions(+), 20 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/ 
>> testing/selftests/mm/madv_populate.c
>> index b6fabd5c27ed..43dac7783004 100644
>> --- a/tools/testing/selftests/mm/madv_populate.c
>> +++ b/tools/testing/selftests/mm/madv_populate.c
>> @@ -264,23 +264,6 @@ static void test_softdirty(void)
>>       munmap(addr, SIZE);
>>   }
>> -static int system_has_softdirty(void)
>> -{
>> -    /*
>> -     * There is no way to check if the kernel supports soft-dirty, other
>> -     * than by writing to a page and seeing if the bit was set. But the
>> -     * tests are intended to check that the bit gets set when it 
>> should, so
>> -     * doing that check would turn a potentially legitimate fail into a
>> -     * skip. Fortunately, we know for sure that arm64 does not support
>> -     * soft-dirty. So for now, let's just use the arch as a corse guide.
>> -     */
>> -#if defined(__aarch64__)
>> -    return 0;
>> -#else
>> -    return 1;
>> -#endif
>> -}
>> -
>>   int main(int argc, char **argv)
>>   {
>>       int nr_tests = 16;
>> @@ -288,7 +271,7 @@ int main(int argc, char **argv)
>>       pagesize = getpagesize();
>> -    if (system_has_softdirty())
>> +    if (softdirty_is_supported())
>>           nr_tests += 5;
>>       ksft_print_header();
>> @@ -300,7 +283,7 @@ int main(int argc, char **argv)
>>       test_holes();
>>       test_populate_read();
>>       test_populate_write();
>> -    if (system_has_softdirty())
>> +    if (softdirty_is_supported())
>>           test_softdirty();
>>       err = ksft_get_fail_cnt();
>> diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/ 
>> selftests/mm/soft-dirty.c
>> index 8a3f2b4b2186..98e42d2ac32a 100644
>> --- a/tools/testing/selftests/mm/soft-dirty.c
>> +++ b/tools/testing/selftests/mm/soft-dirty.c
>> @@ -200,8 +200,11 @@ int main(int argc, char **argv)
>>       int pagesize;
>>       ksft_print_header();
>> -    ksft_set_plan(15);
>> +    if (!softdirty_is_supported())
>> +        ksft_exit_skip("soft-dirty is not support\n");
>> +
>> +    ksft_set_plan(15);
>>       pagemap_fd = open(PAGEMAP_FILE_PATH, O_RDONLY);
>>       if (pagemap_fd < 0)
>>           ksft_exit_fail_msg("Failed to open %s\n", PAGEMAP_FILE_PATH);
>> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/ 
>> selftests/mm/vm_util.c
>> index 56e9bd541edd..3173335df775 100644
>> --- a/tools/testing/selftests/mm/vm_util.c
>> +++ b/tools/testing/selftests/mm/vm_util.c
>> @@ -449,6 +449,34 @@ bool check_vmflag_pfnmap(void *addr)
>>       return check_vmflag(addr, "pf");
>>   }
>> +bool softdirty_is_supported(void)
> 
> I'd just call it "softdirty_supported" similar to 
> "pagemap_scan_supported()".

Got it.

> 
>> +{
>> +    char *addr;
>> +    int ret = 0;
> 
> bool supported = false;
> 
>> +    size_t pagesize;
>> +
>> +    /* We know for sure that arm64 does not support soft-dirty. */
>> +#if defined(__aarch64__)
>> +    return ret;
>> +#endif
> 
> Just drop this arm special case now.

OK

> 
>> +    pagesize = getpagesize();
> 
> const size_t pagesize = getpagesize();
> 
>> +    /*
>> +     * __mmap_complete() always sets VM_SOFTDIRTY for new VMAs, so we
>> +     * just mmap a small region and check its VmFlags in /proc/self/ 
>> smaps
>> +     * for the "sd" flag.
>> +     */
> 
> /* New mappings are expected to be marked with VM_SOFTDIRTY (sd). */

Cool. Much better!

> 
>> +    addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
>> +            MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
>> +    if (!addr)
>> +        ksft_exit_fail_msg("mmap failed\n");
>> +
>> +    if (check_vmflag(addr, "sd"))
>> +        ret = 1;
> 
> supported = true;

I'll adjust as you suggested ;)

> 
>> +
>> +    munmap(addr, pagesize);
>> +    return ret;
>> +}
>> +
> 

Cheers,
Lance


