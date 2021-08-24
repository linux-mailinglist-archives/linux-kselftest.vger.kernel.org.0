Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE613F5794
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 07:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhHXF0R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 01:26:17 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:54687 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229885AbhHXF0Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 01:26:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UlTKbvp_1629782729;
Received: from 30.21.164.109(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UlTKbvp_1629782729)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Aug 2021 13:25:29 +0800
Subject: Re: [PATCH] selftests: openat2: Fix testing failure for O_LARGEFILE
 flag
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1627475340-128057-1-git-send-email-baolin.wang@linux.alibaba.com>
 <01184d9e-477d-cbe4-c936-62b92e915911@linux.alibaba.com>
 <9411d418-567b-78f0-0e4d-30f08371c55a@linux.alibaba.com>
 <a9dc1616-61b9-c010-950c-521693c74247@linuxfoundation.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <4b7f320a-53d0-982a-b441-60e2ce86bfae@linux.alibaba.com>
Date:   Tue, 24 Aug 2021 13:26:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a9dc1616-61b9-c010-950c-521693c74247@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 2021/8/24 3:23, Shuah Khan wrote:
> Hi Baolin,
> 
> On 8/22/21 8:40 PM, Baolin Wang wrote:
>> Hi Shuah,
>>
>> On 2021/7/28 20:32, Baolin Wang wrote:
>>> Hi,
>>>
>>>> When running the openat2 test suite on ARM64 platform, we got below 
>>>> failure,
>>>> since the definition of the O_LARGEFILE is different on ARM64. So we 
>>>> can
>>>> set the correct O_LARGEFILE definition on ARM64 to fix this issue.
>>>
>>> Sorry, I forgot to copy the failure log:
>>>
> 
> Please cc everybody get_maintainers.pl suggests. You are missing
> key reviewers for this change.
> 
> Adding Christian Brauner and Aleksa Sarai to the thread.

Thanks.

> 
>>> # openat2 unexpectedly returned # 
>>> 3['/lkp/benchmarks/kernel_selftests/tools/testing/selftests/openat2'] 
>>> with 208000 (!= 208000)
> 
> Not sure I understand this. 208000 (!= 208000) look sthe same to me.

These are not the error message, just show the fd flags. The error is it 
should return -22 (-EINVAL) for this test case, but it returns 3 which 
indicates a successful openat2() calling.

>>> not ok 102 openat2 with incompatible flags (O_PATH | O_LARGEFILE) 
>>> fails with -22 (Invalid argument)
>>>
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> Could you apply this patch if no objection from your side? Thanks.
>>
> 
> Ideally this define should come from an include file.
> 
> Christian, Aleksa,
> 
> Can you review this patch and let me know if this approach looks right.
> 
>>>> ---
>>>>   tools/testing/selftests/openat2/openat2_test.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/openat2/openat2_test.c 
>>>> b/tools/testing/selftests/openat2/openat2_test.c
>>>> index d7ec1e7..1bddbe9 100644
>>>> --- a/tools/testing/selftests/openat2/openat2_test.c
>>>> +++ b/tools/testing/selftests/openat2/openat2_test.c
>>>> @@ -22,7 +22,11 @@
>>>>    * XXX: This is wrong on {mips, parisc, powerpc, sparc}.
>>>>    */
>>>>   #undef    O_LARGEFILE
>>>> +#ifdef __aarch64__
>>>> +#define    O_LARGEFILE 0x20000
>>>> +#else
>>>>   #define    O_LARGEFILE 0x8000
>>>> +#endif
>>>>   struct open_how_ext {
>>>>       struct open_how inner;
>>>>
>>
> 
> thanks,
> -- Shuah
