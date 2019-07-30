Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0243C7A974
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2019 15:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfG3NYJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jul 2019 09:24:09 -0400
Received: from foss.arm.com ([217.140.110.172]:60878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfG3NYJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jul 2019 09:24:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 811B828;
        Tue, 30 Jul 2019 06:24:07 -0700 (PDT)
Received: from [10.37.12.80] (unknown [10.37.12.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E97B3F694;
        Tue, 30 Jul 2019 06:24:05 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
To:     Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <cover.1563904656.git.andreyknvl@google.com>
 <20190725135044.24381-1-vincenzo.frascino@arm.com>
 <20190725135044.24381-2-vincenzo.frascino@arm.com>
 <52fa2cfc-f7a6-af6f-0dc2-f9ea0e41ac3c@arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <c45df19e-8f48-7f4e-3eae-ada54cb6f707@arm.com>
Date:   Tue, 30 Jul 2019 14:25:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <52fa2cfc-f7a6-af6f-0dc2-f9ea0e41ac3c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kevin,

On 7/30/19 11:32 AM, Kevin Brodsky wrote:
> Some more comments. Mostly minor wording issues, except the prctl() exclusion at
> the end.
> 
> On 25/07/2019 14:50, Vincenzo Frascino wrote:
>> On arm64 the TCR_EL1.TBI0 bit has been always enabled hence
>> the userspace (EL0) is allowed to set a non-zero value in the
>> top byte but the resulting pointers are not allowed at the
>> user-kernel syscall ABI boundary.
>>
>> With the relaxed ABI proposed through this document, it is now possible
>> to pass tagged pointers to the syscalls, when these pointers are in
>> memory ranges obtained by an anonymous (MAP_ANONYMOUS) mmap().
>>
>> This change in the ABI requires a mechanism to requires the userspace
>> to opt-in to such an option.
>>
>> Specify and document the way in which sysctl and prctl() can be used
>> in combination to allow the userspace to opt-in this feature.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> CC: Andrey Konovalov <andreyknvl@google.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
>> ---
>>   Documentation/arm64/tagged-address-abi.rst | 148 +++++++++++++++++++++
>>   1 file changed, 148 insertions(+)
>>   create mode 100644 Documentation/arm64/tagged-address-abi.rst
>>
>> diff --git a/Documentation/arm64/tagged-address-abi.rst
>> b/Documentation/arm64/tagged-address-abi.rst
>> new file mode 100644
>> index 000000000000..a8ecb991de82
>> --- /dev/null
>> +++ b/Documentation/arm64/tagged-address-abi.rst
>> @@ -0,0 +1,148 @@
>> +========================
>> +ARM64 TAGGED ADDRESS ABI
>> +========================
>> +
>> +Author: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> +
>> +Date: 25 July 2019
>> +
>> +This document describes the usage and semantics of the Tagged Address
>> +ABI on arm64.
>> +
>> +1. Introduction
>> +---------------
>> +
>> +On arm64 the TCR_EL1.TBI0 bit has always been enabled on the kernel, hence
>> +the userspace (EL0) is entitled to perform a user memory access through a
>> +64-bit pointer with a non-zero top byte but the resulting pointers are not
>> +allowed at the user-kernel syscall ABI boundary.
>> +
>> +This document describes a relaxation of the ABI that makes it possible to
>> +to pass tagged pointers to the syscalls, when these pointers are in memory
> 
> One too many "to" (at the end the previous line).
> 

Yep will fix in v7.

>> +ranges obtained as described in section 2.
>> +
>> +Since it is not desirable to relax the ABI to allow tagged user addresses
>> +into the kernel indiscriminately, arm64 provides a new sysctl interface
>> +(/proc/sys/abi/tagged_addr) that is used to prevent the applications from
>> +enabling the relaxed ABI and a new prctl() interface that can be used to
>> +enable or disable the relaxed ABI.
>> +A detailed description of the newly introduced mechanisms will be provided
>> +in section 2.
>> +
>> +2. ARM64 Tagged Address ABI
>> +---------------------------
>> +
>> +From the kernel syscall interface perspective, we define, for the purposes
>> +of this document, a "valid tagged pointer" as a pointer that either has a
>> +zero value set in the top byte or has a non-zero value, is in memory ranges
>> +privately owned by a userspace process and is obtained in one of the
>> +following ways:
>> +- mmap() done by the process itself, where either:
>> +
>> +  - flags have **MAP_PRIVATE** and **MAP_ANONYMOUS**
>> +  - flags have **MAP_PRIVATE** and the file descriptor refers to a regular
>> +    file or **/dev/zero**
>> +
>> +- brk() system call done by the process itself (i.e. the heap area between
>> +  the initial location of the program break at process creation and its
>> +  current location).
>> +- any memory mapped by the kernel in the process's address space during
>> +  creation and with the same restrictions as for mmap() (e.g. data, bss,
>> +  stack).
>> +
>> +The ARM64 Tagged Address ABI is an opt-in feature, and an application can
>> +control it using the following:
>> +
>> +- **/proc/sys/abi/tagged_addr**: a new sysctl interface that can be used to
>> +  prevent the applications from enabling the access to the relaxed ABI.
>> +  The sysctl supports the following configuration options:
>> +
>> +  - **0**: Disable the access to the ARM64 Tagged Address ABI for all
>> +    the applications.
>> +  - **1** (Default): Enable the access to the ARM64 Tagged Address ABI for
>> +    all the applications.
>> +
>> +   If the access to the ARM64 Tagged Address ABI is disabled at a certain
>> +   point in time, all the applications that were using tagging before this
>> +   event occurs, will continue to use tagging.
> 
> "tagging" may be misinterpreted here. I would be more explicit by saying that
> the tagged address ABI remains enabled in processes that opted in before the
> access got disabled.
> 

Assuming that ARM64 Tagged Address ABI gives access to "tagging" and since it is
what this document is talking about, I do not see how it can be misinterpreted ;)

>> +- **prctl()s**:
>> +
>> +  - **PR_SET_TAGGED_ADDR_CTRL**: Invoked by a process, can be used to enable or
>> +    disable its access to the ARM64 Tagged Address ABI.
> 
> I still find the wording confusing, because "access to the ABI" is not used
> consistently. The "tagged_addr" sysctl enables *access to the ABI*, that's fine.
> However, PR_SET_TAGGED_ADDR_CTRL enables *the ABI itself* (which is only
> possible if access to the ABI is enabled).
> 

As it stands, it enables or disables the ABI itself when used with
PR_TAGGED_ADDR_ENABLE, or can enable other things in future. IMHO the only thing
that these features have in common is the access to the ABI which is granted by
this prctl().

>> +
>> +    The (unsigned int) arg2 argument is a bit mask describing the control mode
>> +    used:
>> +
>> +    - **PR_TAGGED_ADDR_ENABLE**: Enable ARM64 Tagged Address ABI.
>> +
>> +    The prctl(PR_SET_TAGGED_ADDR_CTRL, ...) will return -EINVAL if the ARM64
>> +    Tagged Address ABI is not available.
> 
> For clarity, it would be good to mention that one possible reason for the ABI
> not to be available is tagged_addr == 0.
> 

The logical implication is already quite clear tagged_addr == 0 (Disabled) =>
Tagged Address ABI not available => return -EINVAL. I do not see the need to
repeat the concept twice.

>> +
>> +    The arguments arg3, arg4, and arg5 are ignored.
>> +  - **PR_GET_TAGGED_ADDR_CTRL**: can be used to check the status of the Tagged
>> +    Address ABI.
>> +
>> +    The arguments arg2, arg3, arg4, and arg5 are ignored.
>> +
>> +The ABI properties set by the mechanisms described above are inherited by
>> threads
>> +of the same application and fork()'ed children but cleared by execve().
>> +
>> +When a process has successfully opted into the new ABI by invoking
>> +PR_SET_TAGGED_ADDR_CTRL prctl(), this guarantees the following behaviours:
>> +
>> + - Every currently available syscall, except the cases mentioned in section
>> 3, can
>> +   accept any valid tagged pointer. The same rule is applicable to any syscall
>> +   introduced in the future.
> 
> I thought Catalin wanted to drop this guarantee?
> 

The guarantee is changed and explicitly includes the syscalls that can be added
in the future. IMHO since we are defining an ABI, we cannot leave that topic in
an uncharted territory, we need to address it.

>> + - If a non valid tagged pointer is passed to a syscall then the behaviour
>> +   is undefined.
>> + - Every valid tagged pointer is expected to work as an untagged one.
>> + - The kernel preserves any valid tagged pointer and returns it to the
>> +   userspace unchanged (i.e. on syscall return) in all the cases except the
>> +   ones documented in the "Preserving tags" section of tagged-pointers.txt.
>> +
>> +A definition of the meaning of tagged pointers on arm64 can be found in:
>> +Documentation/arm64/tagged-pointers.txt.
>> +
>> +3. ARM64 Tagged Address ABI Exceptions
>> +--------------------------------------
>> +
>> +The behaviours described in section 2, with particular reference to the
>> +acceptance by the syscalls of any valid tagged pointer are not applicable
>> +to the following cases:
>> +
>> + - mmap() addr parameter.
>> + - mremap() new_address parameter.
>> + - prctl(PR_SET_MM, PR_SET_MM_MAP, ...) struct prctl_mm_map fields.
>> + - prctl(PR_SET_MM, PR_SET_MM_MAP_SIZE, ...) struct prctl_mm_map fields.
> 
> All the PR_SET_MM options that specify pointers (PR_SET_MM_START_CODE,
> PR_SET_MM_END_CODE, ...) should be excluded as well. AFAICT (but don't take my
> word for it), that's all of them except PR_SET_MM_EXE_FILE. Conversely,
> PR_SET_MM_MAP_SIZE should not be excluded (it does not pass a prctl_mm_map
> struct, and the pointer to unsigned int can be tagged).
> 

Agreed, I clearly misread the prctl() man page here. Fill fix in v7.
PR_SET_MM_MAP_SIZE _returns_  struct prctl_mm_map, does not take it as a parameter.

Vincenzo

> Kevin
> 
>> +
>> +Any attempt to use non-zero tagged pointers will lead to undefined behaviour.
>> +
>> +4. Example of correct usage
>> +---------------------------
>> +.. code-block:: c
>> +
>> +   void main(void)
>> +   {
>> +           static int tbi_enabled = 0;
>> +           unsigned long tag = 0;
>> +
>> +           char *ptr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
>> +                            MAP_ANONYMOUS, -1, 0);
>> +
>> +           if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE,
>> +                     0, 0, 0) == 0)
>> +                   tbi_enabled = 1;
>> +
>> +           if (ptr == (void *)-1) /* MAP_FAILED */
>> +                   return -1;
>> +
>> +           if (tbi_enabled)
>> +                   tag = rand() & 0xff;
>> +
>> +           ptr = (char *)((unsigned long)ptr | (tag << TAG_SHIFT));
>> +
>> +           *ptr = 'a';
>> +
>> +           ...
>> +   }
>> +
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Regards,
Vincenzo
