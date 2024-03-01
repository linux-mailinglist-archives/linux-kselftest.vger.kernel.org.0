Return-Path: <linux-kselftest+bounces-5701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E4C86DD62
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 09:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FC71C21083
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 08:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18CD69DE0;
	Fri,  1 Mar 2024 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YzxCElIs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1269DF5;
	Fri,  1 Mar 2024 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282771; cv=none; b=FK5KzAhDnAZesF7jsuAowGOzxGCl+r3qQe1gdKhXXrdcuFnnKPylg9AuATZ/jZnjgUeR67F8UpCvYWim5dnmD81kg/E2/gAcJ0HZqOupOz79qCTEKc+VRKjXL93XAP0MVb4ANZe12Ctj9OV8ULBbVWBMZG8W6CSpoxKEgMP444U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282771; c=relaxed/simple;
	bh=BRXrHEtLvQZI7rp6SYuCJF7yKl0sL9pVD0qKQUEpvTA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SyRwv1IT+mHt8VLnOVXrdeFXQqvJqqifzVkTkeuPMEpmmHP4nZt6BLsEa3YlbEP0HQiZPTAjR3FWU0z7V0b6Ivitz3D7AUVZKlxAyz6dvBXyFcE7DYp+elsfOo+lV47w/kRSuBiCACWrhylx0JiBAOSrh61VgdU/+kuy232Qoww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YzxCElIs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709282768;
	bh=BRXrHEtLvQZI7rp6SYuCJF7yKl0sL9pVD0qKQUEpvTA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YzxCElIsnoyaoJY/2i2N8GjZ4OnfID1ioAg671+mX3LMJOQWfUk+abfo45Pgy3SG4
	 X4vgI/QoXDlR7PKAnx16LnUWzo8zqmnX7z2o/U/PdeROUUXyZ95mLPgaR1XE/B6B4+
	 SsAsMJ+uK6u7AMKhRu48joIP3X2SwRYsl0OVaPyiV+2TsJBMqNjlWs1ybsu755yy4M
	 4h1KlL2gKzIL4pT1EFvMSFs0jt7ozoeKjg6UlV5XQKOZHSfoWA/bKL8EJ24eHHAdlh
	 84gVDRSdK+JYLN5HrJ7hYf33aASKK2skzoKFn3Z/CIxKA/Wp+IzVqOT03r6hVf2TUo
	 6VUwaRe7vAGWg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DD38237814A4;
	Fri,  1 Mar 2024 08:46:05 +0000 (UTC)
Message-ID: <03c942f0-3a6f-46d1-9ce5-d9f7a40ce4e8@collabora.com>
Date: Fri, 1 Mar 2024 13:46:32 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests/dmabuf-heap: conform test to TAP format
 output
Content-Language: en-US
To: "T.J. Mercier" <tjmercier@google.com>
References: <20240227121920.1905095-1-usama.anjum@collabora.com>
 <CABdmKX3_+G20TB5HJLLLMQQ1-i9g=RV1QU_A00Knd08pyiJWgw@mail.gmail.com>
 <a90a91bd-6182-412f-bfd9-fa3e3f9cc93e@collabora.com>
 <CABdmKX0d_Q2ishxS_bS7siEOmwDOobnTOyXK-QbdKsn_0Jv1VQ@mail.gmail.com>
 <202d7b66-edc4-4416-a32f-4d702742f44b@collabora.com>
 <CABdmKX1jruzSn0E883xfo_pYOimpTTC2HHw=3JG6NYHAhXZrsw@mail.gmail.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABdmKX1jruzSn0E883xfo_pYOimpTTC2HHw=3JG6NYHAhXZrsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/29/24 10:36 PM, T.J. Mercier wrote:
> On Thu, Feb 29, 2024 at 1:14 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> On 2/28/24 11:47 PM, T.J. Mercier wrote:
>>> On Wed, Feb 28, 2024 at 3:46 AM Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>>
>>>> On 2/27/24 10:18 PM, T.J. Mercier wrote:
>>>>> On Tue, Feb 27, 2024 at 4:21 AM Muhammad Usama Anjum
>>>>> <usama.anjum@collabora.com> wrote:
> ..
>>>>>> -static int test_alloc_zeroed(char *heap_name, size_t size)
>>>>>> +static void test_alloc_zeroed(char *heap_name, size_t size)
>>>>>>  {
>>>>>>         int heap_fd = -1, dmabuf_fd[32];
>>>>>>         int i, j, ret;
>>>>>>         void *p = NULL;
>>>>>>         char *c;
>>>>>>
>>>>>> -       printf("  Testing alloced %ldk buffers are zeroed:  ", size / 1024);
>>>>>> +       ksft_print_msg("Testing alloced %ldk buffers are zeroed:\n", size / 1024);
>>>>>>         heap_fd = dmabuf_heap_open(heap_name);
>>>>>> -       if (heap_fd < 0)
>>>>>> -               return -1;
>>>>>>
>>>>>>         /* Allocate and fill a bunch of buffers */
>>>>>>         for (i = 0; i < 32; i++) {
>>>>>>                 ret = dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]);
>>>>>> -               if (ret < 0) {
>>>>>> -                       printf("FAIL (Allocation (%i) failed)\n", i);
>>>>>> -                       goto out;
>>>>>> -               }
>>>>>> +               if (ret)
>>>>>> +                       ksft_exit_fail_msg("FAIL (Allocation (%i) failed)\n", i);
>>>>>> +
>>>>>>                 /* mmap and fill with simple pattern */
>>>>>>                 p = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, dmabuf_fd[i], 0);
>>>>>> -               if (p == MAP_FAILED) {
>>>>>> -                       printf("FAIL (mmap() failed!)\n");
>>>>>> -                       ret = -1;
>>>>>> -                       goto out;
>>>>>> -               }
>>>>>> +               if (p == MAP_FAILED)
>>>>>> +                       ksft_exit_fail_msg("FAIL (mmap() failed!)\n");
>>>>>
>>>>> So based on the previous ksft_exit_fail_msg calls I thought your
>>>>> intention was to exit the program and never run subsequent tests when
>>>>> errors occurred. That's what led to my initial comment about switching
>>>>> to ksft_exit_fail_msg from ksft_print_msg here, and I expected to see
>>>>> only ksft_exit_fail_msg for error cases afterwards. But you're still
>>>>> mixing ksft_exit_fail_msg and (ksft_print_msg +
>>>>> ksft_test_result{_pass,_fail,_skip}) so we've got a mix of behaviors
>>>>> where some errors lead to complete program exits and different errors
>>>>> lead to skipped/failed tests followed by further progress.
>>>>>
>>>>> It seems most useful and predictable to me to have all tests run even
>>>>> after encountering an error for a single test, which we don't get when
>>>>> ksft_exit_fail_msg is called from the individual tests. I was fine
>>>>> with switching all error handling to ksft_exit_fail_msg to eliminate
>>>>> cleanup code and reduce maintenance, but I think we should be
>>>>> consistent with the behavior for dealing with errors which this
>>>>> doesn't currently have. So let's either always call ksft_exit_fail_msg
>>>>> for errors, or never call it (my preference).
>>>> The following rules are being used:
>>>> - If a fetal error occurs where initial conditions to perform a test aren't
>>>> fulfilled, we exit the entire test by ksft_exit_fail_msg().
>>>
>>> But this doesn't exit just the test, it exits the entire program.
>>>
>>>> - If some test fails after fulfilling of initial conditions,
>>>> ksft_print_msg() + ksft_test_result{_pass,_fail} are used to avoid putting
>>>> multiple ksft_test_result_fail() and later ksft_test_result_pass.
>>>>
>>>> ksft_exit_fail_msg() like behaviour was being followed before this patch.
>>>> On non-zero return value, all of following test weren't being run.
>>>> ksft_exit_fail_msg() cannot be used on every failure as it wouldn't run
>>>> following test cases.
>>>
>>> Yeah this is what I'm saying. I'd prefer to always run remaining test
>>> cases for the current heap, and all test cases for subsequent heaps
>>> following an error so you can see all the passes/fails at once. (like
>>> continue in the while loop in main instead of break w/the current
>>> implementation) ksft_exit_fail_msg ends the whole program and that's
>>> what was happening before, but that means the number of test results
>>> that gets reported is inconsistent (unless everything always passes
>>> for all heaps). Failures from one heap mask passes/fails in failures
>>> from other heaps, and that's inconvenient for CI which expects to see
>>> the same set of reported test results across runs, but will have
>>> nothing to report for tests skipped due to premature program exit from
>>> ksft_exit_fail_msg that could have been a single test failure. Like
>>> you mentioned this would be a behavior change, but IDK if it's worth
>>> the churn to exactly duplicate the existing behavior and then go back
>>> to retouch many of the same spots in a later patch to get (what I
>>> consider) better behavior from the program.
>>>
>>> The docs mention about calling ksft_exit_* only once after all tests
>>> are finished:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/kselftest.h?h=v6.8-rc6#n29
>>>
>>> But actual usage seems to be split between ksft_exit_fail_msg for all
>>> the things (e.g. fchmodat2_test.c), and ksft_exit_skip/fail for
>>> prerequisites + ksft_test_result_skip/pass/fail for individual tests
>>> followed by ksft_exit_fail_msg once at the end (e.g.
>>> ksm_functional_tests.c).
>>>
>>> So what you have is fine based on the fact that nobody has fixed it
>>> yet, but I think we could do better for not a lot of work here.
>> I'll send a v3 by fixing only the other thing you caught.
> 
> Ok, but this is all that's needed:
> 
> @@ -152,8 +152,10 @@ static void test_alloc_and_import(char *heap_name)
> 
>         ksft_print_msg("Testing allocation and importing:\n");
>         ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> -       if (ret)
> -               ksft_exit_fail_msg("FAIL (Allocation Failed!)\n");
> +       if (ret) {
> +               ksft_test_result_fail("FAIL (Allocation Failed!)\n");
> +               return;
> +       }
> 
>         /* mmap and write a simple pattern */
>         p = mmap(NULL,
> @@ -162,8 +164,10 @@ static void test_alloc_and_import(char *heap_name)
>                  MAP_SHARED,
>                  dmabuf_fd,
>                  0);
> -       if (p == MAP_FAILED)
> -               ksft_exit_fail_msg("FAIL (mmap() failed)\n");
> +       if (p == MAP_FAILED) {
> +               ksft_test_result_fail("FAIL (mmap() failed)\n");
> +               return;
> +       }
> 
>         dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
>         memset(p, 1, ONE_MEG / 2);
> @@ -217,13 +221,17 @@ static void test_alloc_zeroed(char *heap_name,
> size_t size)
>         /* Allocate and fill a bunch of buffers */
>         for (i = 0; i < 32; i++) {
>                 ret = dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]);
> -               if (ret)
> -                       ksft_exit_fail_msg("FAIL (Allocation (%i)
> failed)\n", i);
> +               if (ret) {
> +                       ksft_test_result_fail("FAIL (Allocation (%i)
> failed)\n", i);
> +                       return;
> +               }
> 
>                 /* mmap and fill with simple pattern */
>                 p = mmap(NULL, size, PROT_READ | PROT_WRITE,
> MAP_SHARED, dmabuf_fd[i], 0);
> -               if (p == MAP_FAILED)
> -                       ksft_exit_fail_msg("FAIL (mmap() failed!)\n");
> +               if (p == MAP_FAILED) {
> +                       ksft_test_result_fail("FAIL (mmap() failed!)\n");
> +                       return;
> +               }
> 
>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
>                 memset(p, 0xff, size);
> @@ -238,13 +246,17 @@ static void test_alloc_zeroed(char *heap_name,
> size_t size)
>         /* Allocate and validate all buffers are zeroed */
>         for (i = 0; i < 32; i++) {
>                 ret = dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]);
> -               if (ret < 0)
> -                       ksft_exit_fail_msg("FAIL (Allocation (%i)
> failed)\n", i);
> +               if (ret < 0) {
> +                       ksft_test_result_fail("FAIL (Allocation (%i)
> failed)\n", i);
> +                       return;
> +               }
> 
>                 /* mmap and validate everything is zero */
>                 p = mmap(NULL, size, PROT_READ | PROT_WRITE,
> MAP_SHARED, dmabuf_fd[i], 0);
> -               if (p == MAP_FAILED)
> -                       ksft_exit_fail_msg("FAIL (mmap() failed!)\n");
> +               if (p == MAP_FAILED) {
> +                       ksft_test_result_fail("FAIL (mmap() failed!)\n");
> +                       return;
> +               }
> 
> Otherwise, on a Pixel 6 I get just:
> 
> TAP version 13
> 1..176
> # Testing heap: aaudio_capture_heap
> # =======================================
> # Testing allocation and importing:
> Bail out! FAIL (Allocation Failed!)
> # Planned tests != run tests (176 != 0)
> # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> and none of the other 15 heaps are ever tested.
> 
I'll send the updated patch.

-- 
BR,
Muhammad Usama Anjum

