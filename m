Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC951C5AA4
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 May 2020 17:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgEEPKG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 May 2020 11:10:06 -0400
Received: from foss.arm.com ([217.140.110.172]:42940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729349AbgEEPKG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 May 2020 11:10:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E3BA1FB;
        Tue,  5 May 2020 08:10:03 -0700 (PDT)
Received: from [10.37.8.251] (unknown [10.37.8.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38A083F68F;
        Tue,  5 May 2020 08:10:02 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] kselftest: Extend vDSO tests
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
References: <20200429112834.24908-1-vincenzo.frascino@arm.com>
 <CAK8P3a3u05wF1DT3Wnvmapc0jixu+gp_YG=KTEN9-n4JedJ9BA@mail.gmail.com>
 <b9b313b5-697e-b92e-1aca-7ad07a640a03@arm.com>
 <CAK8P3a0hUG3-21=HCrxxjQSxFJsDBu704NQCiOW6jNpZV5Ns8w@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <e59bd06b-188c-c3c4-859e-3ced3ea0bb69@arm.com>
Date:   Tue, 5 May 2020 16:11:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0hUG3-21=HCrxxjQSxFJsDBu704NQCiOW6jNpZV5Ns8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Arnd,

On 5/5/20 4:07 PM, Arnd Bergmann wrote:
> On Tue, May 5, 2020 at 5:03 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>> On 5/5/20 3:50 PM, Arnd Bergmann wrote:
>>> On Wed, Apr 29, 2020 at 1:34 PM Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
>>>
>>> Not sure if you are aware of the recent bug report about clock_gettime64()
>>> returning invalid times on some arm32 kernels:
>>> https://github.com/raspberrypi/linux/issues/3579
>>>
>>
>> No, I was not aware of the problem. There has been no mention on the arm list
>> (unless I missed it). I can try to have a look at it as soon as I get some time.
> 
> Right, it was on only on the musl list, and I had pinged you on IRC, but you
> must have been offline.
> 

Sorry about that, I did not get your message :( The only thing I can think it is
that if it was last to last week, I was on holiday... Anyway thanks for pointing
this out.

>>> Regardless of when that gets fixed or by whom, I wonder if kselftest should
>>> also check for consistency, i.e. call both the vdso and the syscall version of
>>> clock_gettime() and clock_gettime64() and check that the results are always
>>> in sequence.
>>>
>>
>> The test #4 partially does that: it calls syscall-vdso-syscall and verifies that
>> the sequencing is correct. I reused the x86 code for that. I could extend it to
>> clock_gettime64() and make sure it builds on all the platforms.
> 
> Sounds good to me.
> 
>        Arnd
> 

-- 
Regards,
Vincenzo
