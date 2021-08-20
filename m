Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E773F2B4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 13:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbhHTLft (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 07:35:49 -0400
Received: from foss.arm.com ([217.140.110.172]:59846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239870AbhHTLft (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 07:35:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 106C4101E;
        Fri, 20 Aug 2021 04:35:11 -0700 (PDT)
Received: from [10.163.68.233] (unknown [10.163.68.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E69C3F70D;
        Fri, 20 Aug 2021 04:35:08 -0700 (PDT)
Subject: Re: [PATCH] kselftest/arm64: pac: Fix skipping of tests on systems
 without PAC
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Boyan Karatotev <boyan.karatotev@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
References: <20210819165723.43903-1-broonie@kernel.org>
 <a988b3e2-5f88-fbd5-99da-2066a65a17b2@arm.com>
 <20210820105531.GP4177@sirena.org.uk>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <20d96c3e-36f8-276f-ab02-daf5bc7c976f@arm.com>
Date:   Fri, 20 Aug 2021 17:05:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210820105531.GP4177@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/20/21 4:25 PM, Mark Brown wrote:
> On Fri, Aug 20, 2021 at 12:39:39PM +0530, Amit Kachhap wrote:
>> On 8/19/21 10:27 PM, Mark Brown wrote:
> 
>>> -	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled"); \
>>> +	if (!(hwcaps & HWCAP_PACA))					\
>>> +		SKIP(return, "PAUTH not enabled"); \
>>>    } while (0)
>>>    #define ASSERT_GENERIC_PAUTH_ENABLED() \
> 
>> May be ASSERT_GENERIC_PAUTH_ENABLED can be replaced with
>> something like VERIFY_GENERIC_PAUTH_ENABLED
> 
> I thought briefly about bikeshedding the name but didn't come up with
> anything that was sufficiently better/clearer.
> 
>> or can be modified like below and instead of failing it skips with a
>> message
> 
>>    -	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled"); \
>>    +	ASSERT_NE(0, hwcaps & HWCAP_PACA) SKIP(return, "PAUTH not enabled");
> 
> That's what the patch does?

Agree, I saw few other testcases where ASSERT is used along with SKIP.
(tools/testing/selftests/core/close_range_test.c) so this way 
ASSERT_GENERIC_* macro will be clear. There will be just an extra
log like "hwcaps & HWCAP_PACA = 0" in this case.

Probably your way is consistent as other tests in arm64 also just
skips due to HWCAP mismatch.

> 
