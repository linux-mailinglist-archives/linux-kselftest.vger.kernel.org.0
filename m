Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D821159DC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2020 01:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgBLACa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 19:02:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:32846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbgBLACa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 19:02:30 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93D0C20724;
        Wed, 12 Feb 2020 00:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581465749;
        bh=VXj1a+npI+7ydAyG+Owt//6Nop6TGqj0xGSkiZ+iHYA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=peRaHaSjJBWu0RxNWsbg2RkLC4l6xVY/UNgyg4oYdntqHFeDLMDpCQq3ZzzKuUrOA
         zeKtNvUu0+uN19gu6qqY1w2j4lz2W0GQnIGL18vKQttilbW3vUx2lHkkkV77SlzbVT
         RktuuaFjkVVQ6c/0oY+eZo3VzmOB0u5pYTbjNi84=
Subject: Re: [PATCH v3 7/7] selftests/exec: Add READ_IMPLIES_EXEC tests
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jann Horn <jannh@google.com>,
        Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200210193049.64362-1-keescook@chromium.org>
 <20200210193049.64362-8-keescook@chromium.org>
 <4f8a5036-dc2a-90ad-5fc8-69560a5dd78e@kernel.org>
 <202002111124.0A334167@keescook>
 <c09c345a-786f-25d2-1ee5-65f9cb23db6d@kernel.org>
 <202002111549.CF18B7B3B@keescook>
From:   shuah <shuah@kernel.org>
Message-ID: <36e45314-b672-b211-72c5-eef1d48984c0@kernel.org>
Date:   Tue, 11 Feb 2020 17:02:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <202002111549.CF18B7B3B@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/11/20 4:54 PM, Kees Cook wrote:
> On Tue, Feb 11, 2020 at 02:06:53PM -0700, shuah wrote:
>> On 2/11/20 12:25 PM, Kees Cook wrote:
>>> On Tue, Feb 11, 2020 at 11:11:21AM -0700, shuah wrote:
>>>> On 2/10/20 12:30 PM, Kees Cook wrote:
>>>>> In order to check the matrix of possible states for handling
>>>>> READ_IMPLIES_EXEC across native, compat, and the state of PT_GNU_STACK,
>>>>> add tests for these execution conditions.
>>>>>
>>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>>
>>>> No issues for this to go through tip.
>>>>
>>>> A few problems to fix first. This fails to compile when 32-bit libraries
>>>> aren't installed. It should fail the 32-bit part and run other checks.
>>>
>>> Do you mean the Makefile should detect the missing compat build deps and
>>> avoid building them? Testing compat is pretty important to this test, so
>>> it seems like missing the build deps causing the build to fail is the
>>> correct action here. This is likely true for the x86/ selftests too.
>>>
>>> What would you like this to do?
>>>
>>
>> selftests/x86 does this already and runs the dependency check in
>> x86/Makefile.
>>
>>
>> check_cc.sh:# check_cc.sh - Helper to test userspace compilation support
>> Makefile:CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC)
>> trivial_32bit_program.c -m32)
>> Makefile:CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC)
>> trivial_64bit_program.c)
>> Makefile:CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC)
>> trivial_program.c -no-pie)
>>
>> Take a look and see if you can leverage this.
> 
> I did before, and it can certainly be done, but their stuff is somewhat
> specific to x86_64/ia32. I'm looking at supporting _all_ compat for any
> 64-bit architecture. I can certainly write some similar build tooling,
> but the question I have for you is one of coverage:
> 
> If a builder is 64-bit, it needs to be able to produce 32-bit compat
> binaries for testing, otherwise the test is incomplete. (i.e. the tests
> will only be able to test native behavior and not compat). This doesn't
> seem like an "XFAIL" situation to me, and it doesn't seem right to
> silently pass. It seems like the build should explicitly fail because
> the needed prerequisites are missing. Do you instead want me to just
> have it skip building the compat binaries if it can't build them?
> 

Can we do the following:


Build and run tests thatc an be built.
Skip build and warn that test coverage is incomplete for compat
with a strong recommendation on installing 32-bit libraries with
some instructions on how to if applicable.

thanks,
-- Shuah
