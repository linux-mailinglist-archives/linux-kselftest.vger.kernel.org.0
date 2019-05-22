Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E65F26079
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2019 11:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfEVJ2U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 May 2019 05:28:20 -0400
Received: from foss.arm.com ([217.140.101.70]:45786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbfEVJ2U (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 May 2019 05:28:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC67E341;
        Wed, 22 May 2019 02:28:19 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BCE93F575;
        Wed, 22 May 2019 02:28:18 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] kselftest: Extend vDSO selftest to clock_getres
To:     shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>
References: <20190416161434.32691-1-vincenzo.frascino@arm.com>
 <20190416161434.32691-6-vincenzo.frascino@arm.com>
 <f07e07b0-4e53-96c8-ebe2-a0f5528fa329@arm.com>
 <252b011e-974a-2f3b-2cc3-0892d1c4a3c0@kernel.org>
 <759f59b2-2cb3-130b-fb30-89e3fb92af33@kernel.org>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <33d0f306-cc39-306b-3349-21fe69ec07d0@arm.com>
Date:   Wed, 22 May 2019 10:28:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <759f59b2-2cb3-130b-fb30-89e3fb92af33@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 21/05/2019 18:33, shuah wrote:
> On 5/21/19 10:24 AM, shuah wrote:
>> On 5/21/19 10:11 AM, Vincenzo Frascino wrote:
>>> Hi Shuah,
>>>
>>> I did not see this patch in 5.2-rc1 and I was wondering if there is 
>>> anything I
>>> can do to help with upstraming it.
>>>
>>
>> Thanks for the ping.
>>
>> Sorry about this. I saw that this part of a series and thought it
>> depends on other patches and should go through another tree.
>>
>> Totally missed that Will suggested that I take it though selftests.
>>
>> My bad. I will get this in - I hope there are no dependencies with other
>> trees.
>>
>> thanks,
>> -- Shuah
>>
>>
> 
> Can you take a look at the macro in this patch. It has checkpatch
> warn:
> 
> WARNING: Macros with flow control statements should be avoided
> 
> 

Ok, I will fix this in v3.

> thanks,
> -- Shuah
> 

-- 
Regards,
Vincenzo
