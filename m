Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982564DB738
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 18:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbiCPRhj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 13:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239152AbiCPRhi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 13:37:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B00B674C1;
        Wed, 16 Mar 2022 10:36:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 6F9591F430DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647452182;
        bh=CcIxudwQJMgXuoIKm9oLlx5LdLPJZ9BlYBuhMcMRnmI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=IiPUZ/OADUJlHDKAwqADefd9ggOCIa5NXfKPYcqxdq3Yct/2qNnmWRZVMH7luFZqn
         eDH5p2h4TqROCiRChNrgvdohvrtM8zi28Ey5fRWLI31Xuno4xG7PjzMhlhY+lwzb2+
         1CSF1x4PjOzYtdRngZazwoqOJElurTS2yXIUQB0qvU/lEqG9aOFWjewZ1TQHRkuASS
         k+/31ZXA/T3/a6/UO+fJjk2vbdg3TEpkU6hbdAdURZH7J8uEDcMVJ65lEDT2XALCJd
         1zjhYbO1TDQ24HqSfc67QKoMRtMKk2PxB7T6YL1vMVw1zVgI6AgS7R8ZRmk/7cBh0s
         layUMKAVVehpQ==
Message-ID: <468db472-3298-0f3d-e000-29aed1abcd91@collabora.com>
Date:   Wed, 16 Mar 2022 22:36:14 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Cc:     usama.anjum@collabora.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V4 2/2] selftests: vm: Add test for Soft-Dirty PTE bit
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
References: <20220315085014.1047291-1-usama.anjum@collabora.com>
 <20220315085014.1047291-2-usama.anjum@collabora.com>
 <871qz3ndji.fsf@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <871qz3ndji.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/16/22 1:53 AM, Gabriel Krisman Bertazi wrote:
> Muhammad Usama Anjum <usama.anjum@collabora.com> writes:
> 
>> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Hi Usama,
> 
> Please, cc me on the whole thread.  I didn't get the patch 1/2 or the
> cover letter.
> 

Sorry, I'll correct it.

>> This introduces three tests:
>> 1) Sanity check soft dirty basic semantics: allocate area, clean, dirty,
>> check if the SD bit is flipped.
>> 2) Check VMA reuse: validate the VM_SOFTDIRTY usage
>> 3) Check soft-dirty on huge pages
>>
>> This was motivated by Will Deacon's fix commit 912efa17e512 ("mm: proc:
>> Invalidate TLB after clearing soft-dirty page state"). I was tracking the
>> same issue that he fixed, and this test would have caught it.
>>
>> CC: Will Deacon <will@kernel.org>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> V3 of this patch is in Andrew's tree. Please drop that.
> 
> v3 is still in linux-next and this note is quite hidden in the middle of
> the commit message.

I've tried to put this message at the top of the changelog. I can add
"Note" in the start of it. What can be some other way to highlight this
kind of important message?

>>
>> Changes in V4:
>> Cosmetic changes
>> Removed global variables
>> Replaced ksft_print_msg with ksft_exit_fail_msg to exit the program at
>> once
>> Some other minor changes
>> Correct the authorship of the patch
>>
>> Tests of soft dirty bit in this patch and in madv_populate.c are
>> non-overlapping. madv_populate.c has only one soft-dirty bit test in the
>> context of different advise (MADV_POPULATE_READ and
>> MADV_POPULATE_WRITE). This new test adds more tests.
>>
>> Tab width of 8 has been used to align the macros. This alignment may look
>> odd in shell or email. But it looks alright in editors.
> 
> I'm curious if you tested reverting 912efa17e512. Did the new versions
> of this patch still catch the original issue?

Yeah, it did after I reverted the patch and fixed build errors because
of some function's signature change and one test failed and hence issue
is caught:

TAP version 13
1..5
# dirty bit was 0, but should be 1 (i=1)
not ok 1 Test test_simple
ok 2 Test test_vma_reuse reused memory location
ok 3 Test test_vma_reuse dirty bit of previous page
ok 4 # SKIP Test test_hugepage huge page allocation
ok 5 # SKIP Test test_hugepage huge page dirty bit
# Totals: pass:2 fail:1 xfail:0 xpass:0 skip:2 error:0


>> Test output:
>> TAP version 13
>> 1..5
>> ok 1 Test test_simple
>> ok 2 Test test_vma_reuse reused memory location
>> ok 3 Test test_vma_reuse dirty bit of previous page
>> ok 4 Test test_hugepage huge page allocation
>> ok 5 Test test_hugepage huge page dirty bit
>>  # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
>>
>> Or
>>
>> TAP version 13
>> 1..5
>> ok 1 Test test_simple
>> ok 2 Test test_vma_reuse reused memory location
>> ok 3 Test test_vma_reuse dirty bit of previous page
>> ok 4 # SKIP Test test_hugepage huge page allocation
>> ok 5 # SKIP Test test_hugepage huge page dirty bit
>>  # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:2 error:0
[..]
>> +
>> +#define PAGEMAP			"/proc/self/pagemap"
>> +#define CLEAR_REFS		"/proc/self/clear_refs"
>> +#define MAX_LINE_LENGTH		512
> 
> MAX_LINE_LENGTH is no longer used after check_for_pattern was dropped.
> 
> Can't the previous defines and file handling functions also go the
> vm_util.h?
> 

I don't want to make changes in other two tests. I just want to move
some functions which we need for this test into vm_util.h while keeping
changes less.

>> +#define TEST_ITERATIONS		10000
>> +
>> +static void test_simple(int pagemap_fd, int pagesize)
>> +{
>> +	int i;
>> +	char *map;
>> +
>> +	map = aligned_alloc(pagesize, pagesize);
>> +	if (!map)
>> +		ksft_exit_fail_msg("mmap failed\n");
>> +
>> +	clear_softdirty();
>> +
>> +	for (i = 0 ; i < TEST_ITERATIONS; i++) {
>> +		if (pagemap_is_softdirty(pagemap_fd, map) == 1) {
>> +			ksft_print_msg("dirty bit was 1, but should be 0 (i=%d)\n", i);
>> +			break;
>> +		}
>> +
>> +		clear_softdirty();
>> +		map[0]++;
> 
> 
> This will overflow several times during TEST_ITERATIONS.  While it is
> not broken, since we care about causing the page fault, it is not
> obvious.  Can you add a comment or do something like this instead?
> 
>   map[0] = !map[0];

Yeah, it is less obvious. I'll add a comment

-- 
Muhammad Usama Anjum
