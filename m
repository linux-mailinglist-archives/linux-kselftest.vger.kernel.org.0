Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3BD30EA47
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 03:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhBDCh3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 21:37:29 -0500
Received: from mail.loongson.cn ([114.242.206.163]:35282 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233517AbhBDCh2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 21:37:28 -0500
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxadS2XRtg+ikDAA--.3874S3;
        Thu, 04 Feb 2021 10:36:39 +0800 (CST)
Subject: Re: [PATCH] selftests: breakpoints: Fix wrong argument of ptrace()
 when single step
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
References: <1612341547-22225-1-git-send-email-yangtiezhu@loongson.cn>
 <f91f1e69-310e-5256-de6e-9bceeaa7b205@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d560a99f-be45-c03f-e729-56ccdbc9a131@loongson.cn>
Date:   Thu, 4 Feb 2021 10:36:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <f91f1e69-310e-5256-de6e-9bceeaa7b205@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxadS2XRtg+ikDAA--.3874S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyfZF1kJr4kZFW7Zry7Jrb_yoW8KFWxpF
        WfZr1ktFs3try5K3ZrX3yqvF1fGrs7ZFWxA34rJ34avr18tws3Jw1xKF4UKFy3u395X3sY
        y3Z7GF4rua4UXrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU8mZX5UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02/04/2021 02:30 AM, Shuah Khan wrote:
> On 2/3/21 1:39 AM, Tiezhu Yang wrote:
>> According to the error message, the first argument of ptrace() should be
>> PTRACE_SINGLESTEP instead of PTRACE_CONT when ptrace single step.
>>
>> Fixes: f43365ee17f8 ("selftests: arm64: add test for 
>> unaligned/inexact watchpoint handling")
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   tools/testing/selftests/breakpoints/breakpoint_test_arm64.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git 
>> a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c 
>> b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
>> index ad41ea6..2f4d4d6 100644
>> --- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
>> +++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
>> @@ -143,7 +143,7 @@ static bool run_test(int wr_size, int wp_size, 
>> int wr, int wp)
>>       if (!set_watchpoint(pid, wp_size, wp))
>>           return false;
>>   -    if (ptrace(PTRACE_CONT, pid, NULL, NULL) < 0) {
>> +    if (ptrace(PTRACE_SINGLESTEP, pid, NULL, NULL) < 0) {
>>           ksft_print_msg(
>>               "ptrace(PTRACE_SINGLESTEP) failed: %s\n",
>>               strerror(errno));
>>
>
> Right before this it does a set_watchpoint(). PTRACE_CONT is what
> makes sense to me. Error might be the one that is incorrect here?

What do you think the following change? If it is OK, I will send v2 soon.

diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c 
b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
index ad41ea6..e704181 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
@@ -145,7 +145,7 @@ static bool run_test(int wr_size, int wp_size, int 
wr, int wp)

         if (ptrace(PTRACE_CONT, pid, NULL, NULL) < 0) {
                 ksft_print_msg(
-                       "ptrace(PTRACE_SINGLESTEP) failed: %s\n",
+                       "ptrace(PTRACE_CONT) failed: %s\n",
                         strerror(errno));
                 return false;
         }
@@ -159,7 +159,7 @@ static bool run_test(int wr_size, int wp_size, int 
wr, int wp)
         }
         alarm(0);
         if (WIFEXITED(status)) {
-               ksft_print_msg("child did not single-step\n");
+               ksft_print_msg("child exited prematurely\n");
                 return false;
         }
         if (!WIFSTOPPED(status)) {

Thanks,
Tiezhu

>
> thanks,
> -- Shuah

