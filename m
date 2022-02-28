Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AB74C6366
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Feb 2022 07:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiB1G4u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Feb 2022 01:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiB1G4t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Feb 2022 01:56:49 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C5D53E1A;
        Sun, 27 Feb 2022 22:56:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 0AD721F4382C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646031370;
        bh=rE18sn0vl3KdSuH6my5m3OeJ1UdSDBnjTNzG6MNt/KA=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=av2etI9C64z7kH8oby+4RXIFve1/MfABYDgxG9Bg82wMbpSVpSvfJXxLXEW68XAVp
         QFtfBoYsKRuvuEJAUq3k0UdAE+vIW2PiRAO/LGfWf7R2mc8wx8kDlR8/UHqq2pEVhB
         fstuG9miep2o8vXjMeVsfwzjERibRm/VyezHWNKR3/oVbIFICJpL1Xny+s6daJrn0c
         higv1t4Uiw5GFewtpN6DLULRmsKGeJhWeWvk6u3BKDA8+1xo5eStu10fc63XgQcs3h
         kq3a8hie9mmyByxpC+8fi2vCCCVl+fxzYLVrkimrAa6RZ9QpWQqWVqX/gT72T+5p98
         OnXzlJf2t+3yw==
Message-ID: <52f17759-c7b9-c13b-2c58-f9f2656d26f6@collabora.com>
Date:   Mon, 28 Feb 2022 11:55:58 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        kernelci@groups.io, Will Deacon <will@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V3] selftests: vm: Add test for Soft-Dirty PTE bit
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
References: <20220224212335.3045905-1-usama.anjum@collabora.com>
 <edf398a7-b1a1-c7c9-5128-f37cfc3a5c95@linuxfoundation.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <edf398a7-b1a1-c7c9-5128-f37cfc3a5c95@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Andrew had already accepted the patch. I'll send an iteration.

On 2/26/22 5:35 AM, Shuah Khan wrote:
>> +#define PAGEMAP_PATH        "/proc/self/pagemap"
> 
> Why is this names PATH - it is the file name right?
I'll update the names of the macros.

>> +
>> +int clear_refs;
>> +int pagemap;
>> +
> 
> Get rid of these globals and pass these in - please find name
> that clearly indicates them as fds
> 
I'll update their names to indicate fds. This is a standalone test
application. Shouldn't the usage of global variables be fine?

>> +static int check_page(char *start, int page_num, int clear)
>> +{
>> +    unsigned long pfn = (unsigned long)start / pagesize;
>> +    uint64_t entry;
>> +    int ret;
>> +
>> +    ret = pread(pagemap, &entry, sizeof(entry), (pfn + page_num) *
>> sizeof(entry));
>> +    if (ret != sizeof(entry))
>> +        ksft_exit_fail_msg("reading pagemap failed\n");
>> +    if (clear)
>> +        clear_all_refs();
>> +
>> +    return ((entry >> 55) & 1);
> 
> Add a define for 55 insead of hardcoding with a meaningful name
> that describes what this value is.
> 
Sure.

>> +}
>> +
>> +static void test_simple(void)
>> +{
>> +    int i;
>> +    char *map;
>> +
>> +    map = aligned_alloc(pagesize, mmap_size);
>> +    if (!map)
>> +        ksft_exit_fail_msg("mmap failed\n");
>> +
>> +    clear_all_refs();
> 
> If clear_all_refs() fails and exits, when does map get freed?
I'll fix this.

>> +/*
>> + * read_pmd_pagesize(), check_for_pattern() and check_huge() adapted
>> + * from 'tools/testing/selftest/vm/split_huge_page_test.c'
> 
> Don't use the full path here - just use the file name
I'll update the comment.

>> +
>> +int main(int argc, char **argv)
>> +{
>> +    ksft_print_header();
>> +    ksft_set_plan(5);
>> +
>> +    pagemap = open(PAGEMAP_PATH, O_RDONLY);
>> +    if (pagemap < 0)
>> +        ksft_exit_fail_msg("Failed to open %s\n", PAGEMAP_PATH);
> 
> Can non-root user open this file? If not, when non-root user fails to
> open, it is a skip not fail
Yes, non-root user can open this file. I'll check the usage of skip
macros as well.

>> +    test_simple();
>> +    test_vma_reuse();
>> +    test_hugepage();
> 
> What happens when these tests fail?
They are independent. Each of them marks the test pass or fail on its
own. If one of them fails, others will keep on executing next.

>> +
>> +    return ksft_exit_pass();
>> +}
>>
> 
> Where do CLEAR_REFS_PATH etc. get closed. Please take a look
> at the error paths carefully. I would like to see the output for
> this test. Please include it in the change log.
I'll update and include the output as well.

> thanks,
> -- Shuah
