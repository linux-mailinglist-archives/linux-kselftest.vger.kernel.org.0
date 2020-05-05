Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287371C5A63
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 May 2020 17:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgEEPDL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 May 2020 11:03:11 -0400
Received: from foss.arm.com ([217.140.110.172]:42624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbgEEPDK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 May 2020 11:03:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC3901FB;
        Tue,  5 May 2020 08:03:09 -0700 (PDT)
Received: from [10.37.8.251] (unknown [10.37.8.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C824E3F68F;
        Tue,  5 May 2020 08:03:08 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] kselftest: Extend vDSO tests
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
References: <20200429112834.24908-1-vincenzo.frascino@arm.com>
 <CAK8P3a3u05wF1DT3Wnvmapc0jixu+gp_YG=KTEN9-n4JedJ9BA@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b9b313b5-697e-b92e-1aca-7ad07a640a03@arm.com>
Date:   Tue, 5 May 2020 16:04:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3u05wF1DT3Wnvmapc0jixu+gp_YG=KTEN9-n4JedJ9BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Arnd,

On 5/5/20 3:50 PM, Arnd Bergmann wrote:
> On Wed, Apr 29, 2020 at 1:34 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> This series extends the kselftests for the vDSO library making sure: that
>> they compile correctly on non x86 platforms, that they can be cross
>> compiled and introducing new tests that verify the correctness of the
>> library.
>>
>> The so extended vDSO kselftests have been verified on all the platforms
>> supported by the unified vDSO library [1].
>>
>> The only new patch that this series introduces is the first one, patch 2 and
>> patch 3 have already been reviewed in past as part of other series [2] [3].
>>
>> [1] https://lore.kernel.org/lkml/20190621095252.32307-1-vincenzo.frascino@arm.com
>> [2] https://lore.kernel.org/lkml/20190621095252.32307-26-vincenzo.frascino@arm.com
>> [3] https://lore.kernel.org/lkml/20190523112116.19233-4-vincenzo.frascino@arm.com
> 
> Hi Vincenzo,
> 
> Not sure if you are aware of the recent bug report about clock_gettime64()
> returning invalid times on some arm32 kernels:
> https://github.com/raspberrypi/linux/issues/3579
> 

No, I was not aware of the problem. There has been no mention on the arm list
(unless I missed it). I can try to have a look at it as soon as I get some time.

> Regardless of when that gets fixed or by whom, I wonder if kselftest should
> also check for consistency, i.e. call both the vdso and the syscall version of
> clock_gettime() and clock_gettime64() and check that the results are always
> in sequence.
> 

The test #4 partially does that: it calls syscall-vdso-syscall and verifies that
the sequencing is correct. I reused the x86 code for that. I could extend it to
clock_gettime64() and make sure it builds on all the platforms.

>       Arnd
> 

-- 
Regards,
Vincenzo
