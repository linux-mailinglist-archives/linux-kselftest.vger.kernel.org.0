Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3919D5D906
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2019 02:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfGCAdN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jul 2019 20:33:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39293 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfGCAdM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jul 2019 20:33:12 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hiRTs-0003jV-5l; Tue, 02 Jul 2019 22:42:32 +0000
Subject: Re: [PATCH][next] selftests/x86: fix spelling mistake "FAILT" ->
 "FAIL"
To:     shuah <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20190701130431.13391-1-colin.king@canonical.com>
 <CALCETrVo0rJVxsYvo=abDfFCZHBuCiB0coSBXoDeP_emSZgESg@mail.gmail.com>
 <6e5a9bed-4f7f-4851-0421-2b440ff1f584@kernel.org>
 <9ba791d5-0d67-9834-90e9-e1dca307d386@kernel.org>
From:   Colin Ian King <colin.king@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0031e09b-e309-3976-09b1-dc8d10365aee@canonical.com>
Date:   Tue, 2 Jul 2019 23:42:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9ba791d5-0d67-9834-90e9-e1dca307d386@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02/07/2019 20:25, shuah wrote:
> On 7/2/19 8:22 AM, shuah wrote:
>> On 7/1/19 11:48 AM, Andy Lutomirski wrote:
>>> On Mon, Jul 1, 2019 at 6:04 AM Colin King <colin.king@canonical.com>
>>> wrote:
>>>>
>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>
>>>> There is an spelling mistake in an a test error message. Fix it.
>>>>
>>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>>> ---
>>>>   tools/testing/selftests/x86/test_vsyscall.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/x86/test_vsyscall.c
>>>> b/tools/testing/selftests/x86/test_vsyscall.c
>>>> index 4602326b8f5b..a4f4d4cf22c3 100644
>>>> --- a/tools/testing/selftests/x86/test_vsyscall.c
>>>> +++ b/tools/testing/selftests/x86/test_vsyscall.c
>>>> @@ -451,7 +451,7 @@ static int test_vsys_x(void)
>>>>                  printf("[OK]\tExecuting the vsyscall page failed:
>>>> #PF(0x%lx)\n",
>>>>                         segv_err);
>>>>          } else {
>>>> -               printf("[FAILT]\tExecution failed with the wrong
>>>> error: #PF(0x%lx)\n",
>>>> +               printf("[FAIL]\tExecution failed with the wrong
>>>> error: #PF(0x%lx)\n",
>>>>                         segv_err);
>>>>                  return 1;
>>>>          }
>>>> -- 
>>>> 2.20.1
>>>>
>>>
>>> Acked-by: Andy Lutomirski <luto@kernel.org>
>>>
>>
>> Thanks Andy!
>>
>> I will queue this up for 5.3
>>
>> -- Shuah
>>
> 
> Hi Colin,
> 
> Checkpatch warning on this. Probably failed on the original patch.
> Could you please fix the checkpatch warn, and send v2.

If I split the line, I get another checkpatch warning:

"WARNING: quoted string split across lines"

Either way checkpatch emits a warning. The convention is to not break
literal strings, and the line is only a few chars over the 80 char
boundary, so the V1 of the patch is the way it should be IMHO.

Colin


> 
> thanks,
> -- Shuah

