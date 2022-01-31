Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680B84A45C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jan 2022 12:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbiAaLqs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 06:46:48 -0500
Received: from foss.arm.com ([217.140.110.172]:49286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379162AbiAaLnw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 06:43:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E1A1D6E;
        Mon, 31 Jan 2022 03:43:50 -0800 (PST)
Received: from [10.57.38.116] (unknown [10.57.38.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B88983F774;
        Mon, 31 Jan 2022 03:43:48 -0800 (PST)
Subject: Re: [PATCH v3] kselftest: Fix vdso_test_abi return status
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220128130701.17511-1-vincenzo.frascino@arm.com>
 <20220128144451.GC5776@e120937-lin>
 <82d59ef7-39a1-c1f7-2746-f4fc19593add@linuxfoundation.org>
 <25eb270c-fa11-f2bc-0686-b5a8c55cd0a7@linuxfoundation.org>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <f1bbd32d-470c-d5ea-f324-85189e00f5e6@arm.com>
Date:   Mon, 31 Jan 2022 11:44:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <25eb270c-fa11-f2bc-0686-b5a8c55cd0a7@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 1/28/22 5:41 PM, Shuah Khan wrote:
> On 1/28/22 10:35 AM, Shuah Khan wrote:
>> On 1/28/22 7:44 AM, Cristian Marussi wrote:
>>> On Fri, Jan 28, 2022 at 01:07:01PM +0000, Vincenzo Frascino wrote:
>>>> vdso_test_abi contains a batch of tests that verify the validity of the
>>>> vDSO ABI.
>>>>
>>>> When a vDSO symbol is not found the relevant test is skipped reporting
>>>> KSFT_SKIP. All the tests return values are then added in a single
>>>> variable which is checked to verify failures. This approach can have
>>>> side effects which result in reporting the wrong kselftest exit status.
>>>>
>>>> Fix vdso_test_abi verifying the return code of each test separately.
>>>>
>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>> Cc: Andy Lutomirski <luto@kernel.org>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Reported-by: Cristian Marussi <cristian.marussi@arm.com>
>>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>>> ---
>>>
>>> Hi,
>>>
>>> LGTM.
>>>
>>> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
>>>
>>> Thanks,
>>> Cristian
>>
>> Thank you both. Will queue this up for 5.17 rc3.
>>
> 
> Vincenzo,
> 
> A couple of checkpatch warns. Please fix them and send me v4.
> 

It should be sorted now, I just posted v4. Please let me know if anything else
is required from my side.

Thanks!

--->8---

$ scripts/checkpatch.pl v4-0001-kselftest-Fix-vdso_test_abi-return-status.patch
total: 0 errors, 0 warnings, 252 lines checked


> thanks,
> -- Shuah

-- 
Regards,
Vincenzo
