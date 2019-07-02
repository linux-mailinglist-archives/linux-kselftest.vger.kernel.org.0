Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3100C5D6D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2019 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfGBTZO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jul 2019 15:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGBTZO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jul 2019 15:25:14 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B96D2184B;
        Tue,  2 Jul 2019 19:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562095513;
        bh=Mbp9MNyhyqdzgfx444BJLeoELBbPVPumzkHWdXrOrks=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qe7NMukWj2CHbj62FbbmMMOvKvAjq9WLjDC0IXNKzujPedvLUz2tn4e5B0Vt5KM41
         faZIIKP7TZfIp/K1Xlcluu0rtZTeBmc7Z4ibG+7VXJPFDdjSemBMG1FaRa7N5SWTzl
         Zd7SFNXykl64AbD3EMHy5qCheymYuksA27bZ86J4=
Subject: Re: [PATCH][next] selftests/x86: fix spelling mistake "FAILT" ->
 "FAIL"
To:     Andy Lutomirski <luto@kernel.org>,
        Colin King <colin.king@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, shuah <shuah@kernel.org>
References: <20190701130431.13391-1-colin.king@canonical.com>
 <CALCETrVo0rJVxsYvo=abDfFCZHBuCiB0coSBXoDeP_emSZgESg@mail.gmail.com>
 <6e5a9bed-4f7f-4851-0421-2b440ff1f584@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <9ba791d5-0d67-9834-90e9-e1dca307d386@kernel.org>
Date:   Tue, 2 Jul 2019 13:25:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <6e5a9bed-4f7f-4851-0421-2b440ff1f584@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/2/19 8:22 AM, shuah wrote:
> On 7/1/19 11:48 AM, Andy Lutomirski wrote:
>> On Mon, Jul 1, 2019 at 6:04 AM Colin King <colin.king@canonical.com> 
>> wrote:
>>>
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> There is an spelling mistake in an a test error message. Fix it.
>>>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>   tools/testing/selftests/x86/test_vsyscall.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/x86/test_vsyscall.c 
>>> b/tools/testing/selftests/x86/test_vsyscall.c
>>> index 4602326b8f5b..a4f4d4cf22c3 100644
>>> --- a/tools/testing/selftests/x86/test_vsyscall.c
>>> +++ b/tools/testing/selftests/x86/test_vsyscall.c
>>> @@ -451,7 +451,7 @@ static int test_vsys_x(void)
>>>                  printf("[OK]\tExecuting the vsyscall page failed: 
>>> #PF(0x%lx)\n",
>>>                         segv_err);
>>>          } else {
>>> -               printf("[FAILT]\tExecution failed with the wrong 
>>> error: #PF(0x%lx)\n",
>>> +               printf("[FAIL]\tExecution failed with the wrong 
>>> error: #PF(0x%lx)\n",
>>>                         segv_err);
>>>                  return 1;
>>>          }
>>> -- 
>>> 2.20.1
>>>
>>
>> Acked-by: Andy Lutomirski <luto@kernel.org>
>>
> 
> Thanks Andy!
> 
> I will queue this up for 5.3
> 
> -- Shuah
> 

Hi Colin,

Checkpatch warning on this. Probably failed on the original patch.
Could you please fix the checkpatch warn, and send v2.

thanks,
-- Shuah
