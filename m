Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 277A6D0E11
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 13:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfJILzg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 07:55:36 -0400
Received: from foss.arm.com ([217.140.110.172]:60744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfJILzg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 07:55:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B79528;
        Wed,  9 Oct 2019 04:55:35 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC4D63F703;
        Wed,  9 Oct 2019 04:55:34 -0700 (PDT)
Subject: Re: [PATCH v8 02/12] kselftest: arm64:
 mangle_pstate_invalid_compat_toggle and common utils
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
References: <20191009082611.9441-1-cristian.marussi@arm.com>
 <20191009082611.9441-3-cristian.marussi@arm.com>
 <20191009111848.GB27757@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <38e73559-ad80-d05a-32ca-ac763ee648bb@arm.com>
Date:   Wed, 9 Oct 2019 12:55:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009111848.GB27757@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 09/10/2019 12:18, Dave Martin wrote:
> On Wed, Oct 09, 2019 at 09:26:01AM +0100, Cristian Marussi wrote:
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
>> v7 --> v8
>> - removed unused SSBS_SYSREG
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
>> new file mode 100644
>> index 000000000000..e5aeae45febb
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/.gitignore
>> @@ -0,0 +1,3 @@
>> +!*.[ch]
>> +mangle_*
>> +fake_sigreturn_*
> 
> I think the !*.[ch] line needs to come last.
> 
> Re-including *.[ch] on the first line has no effect because no files
> have been excluded yet.
> 
> (This looks like it was my mistake when I originally suggested using
> wildcards here -- apologies for that!)
> 
> I'm happy for you to keey my Reviewed-by on that change.
> 

Moved to last in v9

Cristian
> [...]
> 
> Cheers
> ---Dave
> 

