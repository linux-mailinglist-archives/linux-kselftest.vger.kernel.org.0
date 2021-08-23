Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2A33F4371
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Aug 2021 04:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhHWCkx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Aug 2021 22:40:53 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52362 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229958AbhHWCkx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Aug 2021 22:40:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Ul81QuM_1629686409;
Received: from 30.21.164.129(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ul81QuM_1629686409)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 Aug 2021 10:40:10 +0800
Subject: Re: [PATCH] selftests: openat2: Fix testing failure for O_LARGEFILE
 flag
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1627475340-128057-1-git-send-email-baolin.wang@linux.alibaba.com>
 <01184d9e-477d-cbe4-c936-62b92e915911@linux.alibaba.com>
Message-ID: <9411d418-567b-78f0-0e4d-30f08371c55a@linux.alibaba.com>
Date:   Mon, 23 Aug 2021 10:40:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <01184d9e-477d-cbe4-c936-62b92e915911@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 2021/7/28 20:32, Baolin Wang wrote:
> Hi,
> 
>> When running the openat2 test suite on ARM64 platform, we got below 
>> failure,
>> since the definition of the O_LARGEFILE is different on ARM64. So we can
>> set the correct O_LARGEFILE definition on ARM64 to fix this issue.
> 
> Sorry, I forgot to copy the failure log:
> 
> # openat2 unexpectedly returned # 
> 3['/lkp/benchmarks/kernel_selftests/tools/testing/selftests/openat2'] 
> with 208000 (!= 208000)
> not ok 102 openat2 with incompatible flags (O_PATH | O_LARGEFILE) fails 
> with -22 (Invalid argument)
> 
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Could you apply this patch if no objection from your side? Thanks.

>> ---
>>   tools/testing/selftests/openat2/openat2_test.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/testing/selftests/openat2/openat2_test.c 
>> b/tools/testing/selftests/openat2/openat2_test.c
>> index d7ec1e7..1bddbe9 100644
>> --- a/tools/testing/selftests/openat2/openat2_test.c
>> +++ b/tools/testing/selftests/openat2/openat2_test.c
>> @@ -22,7 +22,11 @@
>>    * XXX: This is wrong on {mips, parisc, powerpc, sparc}.
>>    */
>>   #undef    O_LARGEFILE
>> +#ifdef __aarch64__
>> +#define    O_LARGEFILE 0x20000
>> +#else
>>   #define    O_LARGEFILE 0x8000
>> +#endif
>>   struct open_how_ext {
>>       struct open_how inner;
>>
