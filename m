Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FF0D08B7
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 09:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfJIHqt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 03:46:49 -0400
Received: from foss.arm.com ([217.140.110.172]:55080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbfJIHqs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 03:46:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3383A1000;
        Wed,  9 Oct 2019 00:46:48 -0700 (PDT)
Received: from [10.37.8.60] (unknown [10.37.8.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ADE03F68E;
        Wed,  9 Oct 2019 00:46:47 -0700 (PDT)
Subject: Re: [PATCH v7 02/11] kselftest: arm64:
 mangle_pstate_invalid_compat_toggle and common utils
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
References: <20191007182954.25730-1-cristian.marussi@arm.com>
 <20191007182954.25730-3-cristian.marussi@arm.com>
 <20191008180119.GZ27757@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <51cb947d-c477-f378-8457-34b7e807d6cc@arm.com>
Date:   Wed, 9 Oct 2019 08:47:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008180119.GZ27757@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/8/19 7:01 PM, Dave Martin wrote:
> On Mon, Oct 07, 2019 at 07:29:45pm +0100, Cristian Marussi wrote:
>> Add some arm64/signal specific boilerplate and utility code to help
>> further testcases' development.
>>
>> Introduce also one simple testcase mangle_pstate_invalid_compat_toggle
>> and some related helpers: it is a simple mangle testcase which messes
>> with the ucontext_t from within the signal handler, trying to toggle
>> PSTATE state bits to switch the system between 32bit/64bit execution
>> state. Expects SIGSEGV on test PASS.
>>
>> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>> v6 --> v7
>> - removed ambiguos fprintf in test_init
>> - fixed spacing
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
> 
> [...]
> 
>> +/* Local Helpers */
>> +#define ID_AA64MMFR1_EL1_PAN_SUPPORTED(val) \
>> +	(!!((val) & (0xfUL << ID_AA64MMFR1_PAN_SHIFT)))
>> +#define ID_AA64MMFR2_EL1_UAO_SUPPORTED(val) \
>> +	(!!((val) & (0xfUL << ID_AA64MMFR2_UAO_SHIFT)))
>> +
>> +#define SSBS_SYSREG		S3_3_C4_C2_6	/* EL0 supported */
> 
> Does anything in the series still use SSBS_SYSREG?
> 
> If not, please drop it.  No need to remove my Reviewed-by just for thato
> change.
> 

Ok I'll remove all the SSBS refs, even related to capabilities check at
test init.

Cristian
> [...]
> 
> Cheers
> ---Dave
> 
