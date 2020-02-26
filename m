Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 406D016FE43
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2020 12:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgBZLxm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Feb 2020 06:53:42 -0500
Received: from foss.arm.com ([217.140.110.172]:34782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgBZLxm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Feb 2020 06:53:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2AB51FB;
        Wed, 26 Feb 2020 03:53:40 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D3473FA00;
        Wed, 26 Feb 2020 03:53:39 -0800 (PST)
Subject: Re: selftests: Linux Kernel Dump Test Module output
To:     Kees Cook <keescook@chromium.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>, ankita@in.ibm.com,
        Will Deacon <will@kernel.org>, ardb@kernel.org,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
References: <CA+G9fYu3682XJ2Kw2ZvQdUT80epKc9DWWXgDT1-D_65ajSXNTw@mail.gmail.com>
 <fcb799d4-f316-60d6-9fd0-0bc1c174e63c@arm.com>
 <202002251131.3216B3B50C@keescook>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <b485a8a9-5312-ca77-d091-3dbfac33ec5b@arm.com>
Date:   Wed, 26 Feb 2020 11:53:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <202002251131.3216B3B50C@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kees

On 25/02/2020 19:31, Kees Cook wrote:
> On Mon, Feb 17, 2020 at 03:36:59PM +0000, Cristian Marussi wrote:
>> n 17/02/2020 11:09, Naresh Kamboju wrote:
>>> The selftest lkdtm test failed on x86_64 and arm64.
>>> am I missing any pre-requisite?
>>>
>>> Boot log:
>>> [    3.297812] lkdtm: No crash points registered, enable through debugfs
>>>
>>
>> from your logs I cannot deduce anything useful, but in our CI I've got similar issues
>> since the 10/12th of Feb...
>>
>> TAP version 13
>> 1..71
>> # selftests: lkdtm: PANIC.sh
>> # Cannot find /sys/kernel/debug/provoke-crash/DIRECT (missing CONFIG_LKDTM?)
>> not ok 1 selftests: lkdtm: PANIC.sh # SKIP
>> # selftests: lkdtm: BUG.sh
>> # Cannot find /sys/kernel/debug/provoke-crash/DIRECT (missing CONFIG_LKDTM?)
>>
>> so I suppose this and a bunch of other (probably new) tests are simply
>> missing a bit of CONFIGs... (but I have still to look into this properly)
>> (not sure if this also is your case either...)
> 
> Did you solve this with loading lkdtm?
> 
> -Kees
> 

Sorry I lost track of this thread....tested now on v5.6rc3 on arm64 on a local
setup (not proper CI) with CONFIG_LKDTM=y and solves the above issue. (missing CONFIG_LKDTM?)

Looking at the general run though I have anyway a bunch of SKIP similar to Naresh

./run_kselftest.sh 2>/dev/null | grep "SKIP"
not ok 1 selftests: lkdtm: PANIC.sh # SKIP
not ok 6 selftests: lkdtm: LOOP.sh # SKIP
not ok 7 selftests: lkdtm: EXHAUST_STACK.sh # SKIP
not ok 8 selftests: lkdtm: CORRUPT_STACK.sh # SKIP
not ok 9 selftests: lkdtm: CORRUPT_STACK_STRONG.sh # SKIP
not ok 15 selftests: lkdtm: UNSET_SMEP.sh # SKIP
not ok 16 selftests: lkdtm: DOUBLE_FAULT.sh # SKIP
not ok 18 selftests: lkdtm: OVERWRITE_ALLOCATION.sh # SKIP
not ok 19 selftests: lkdtm: WRITE_AFTER_FREE.sh # SKIP
not ok 21 selftests: lkdtm: WRITE_BUDDY_AFTER_FREE.sh # SKIP
not ok 26 selftests: lkdtm: SOFTLOCKUP.sh # SKIP
not ok 27 selftests: lkdtm: HARDLOCKUP.sh # SKIP
not ok 28 selftests: lkdtm: SPINLOCKUP.sh # SKIP
not ok 29 selftests: lkdtm: HUNG_TASK.sh # SKIP
not ok 59 selftests: lkdtm: REFCOUNT_TIMING.sh # SKIP
not ok 60 selftests: lkdtm: ATOMIC_TIMING.sh # SKIP

BUT, if I look at one LKDTM test script
(lkdtm/USERCOPY_STACK_FRAME_TO.sh):

...
# If the test is commented out, report a skip
if echo "$test" | grep -q '^#' ; then
...

and in fact:

root@sqwt-ubuntu:/opt/ksft# cat lkdtm/tests.txt | grep ^#
#PANIC
#LOOP Hangs the system
#EXHAUST_STACK Corrupts memory on failure
#CORRUPT_STACK Crashes entire system on success
#CORRUPT_STACK_STRONG Crashes entire system on success
#OVERWRITE_ALLOCATION Corrupts memory on failure
#WRITE_AFTER_FREE Corrupts memory on failure
#WRITE_BUDDY_AFTER_FREE Corrupts memory on failure
#SOFTLOCKUP Hangs the system
#HARDLOCKUP Hangs the system
#SPINLOCKUP Hangs the system
#HUNG_TASK Hangs the system
#REFCOUNT_TIMING timing only
#ATOMIC_TIMING timing only

so only two of the above tests are in fact unexpectedly skipped.

not ok 15 selftests: lkdtm: UNSET_SMEP.sh # SKIP
not ok 16 selftests: lkdtm: DOUBLE_FAULT.sh # SKIP

I've not investigated further as of now.

Regards

Cristian


>>
>> Regards
>>
>> Cristian
>>
>>
>>
>>> Test output log,
>>> --------------------
>>> # selftests lkdtm PANIC.sh
>>> lkdtm: PANIC.sh_ #
>>> # Skipping PANIC crashes entire system
>>> PANIC: crashes_entire #
>>> [SKIP] 1 selftests lkdtm PANIC.sh # SKIP
>>> selftests: lkdtm_PANIC.sh [SKIP]
>>> # selftests lkdtm BUG.sh
>>> lkdtm: BUG.sh_ #
>>> # BUG missing 'kernel BUG at' [FAIL]
>>> missing: 'kernel_BUG #
>>> [FAIL] 2 selftests lkdtm BUG.sh # exit=1
>>> selftests: lkdtm_BUG.sh [FAIL]
>>> # selftests lkdtm WARNING.sh
>>> lkdtm: WARNING.sh_ #
>>> # WARNING missing 'WARNING' [FAIL]
>>> missing: 'WARNING'_[FAIL] #
>>> [FAIL] 3 selftests lkdtm WARNING.sh # exit=1
>>> selftests: lkdtm_WARNING.sh [FAIL]
>>> # selftests lkdtm WARNING_MESSAGE.sh
>>> lkdtm: WARNING_MESSAGE.sh_ #
>>> # WARNING_MESSAGE missing 'message trigger' [FAIL]
>>> missing: 'message_trigger' #
>>> [FAIL] 4 selftests lkdtm WARNING_MESSAGE.sh # exit=1
>>> selftests: lkdtm_WARNING_MESSAGE.sh [FAIL]
>>> # selftests lkdtm EXCEPTION.sh
>>> lkdtm: EXCEPTION.sh_ #
>>> # EXCEPTION missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 5 selftests lkdtm EXCEPTION.sh # exit=1
>>> selftests: lkdtm_EXCEPTION.sh [FAIL]
>>> # selftests lkdtm LOOP.sh
>>> lkdtm: LOOP.sh_ #
>>> # Skipping LOOP Hangs the system
>>> LOOP: Hangs_the #
>>> [SKIP] 6 selftests lkdtm LOOP.sh # SKIP
>>> selftests: lkdtm_LOOP.sh [SKIP]
>>> # selftests lkdtm EXHAUST_STACK.sh
>>> lkdtm: EXHAUST_STACK.sh_ #
>>> # Skipping EXHAUST_STACK Corrupts memory on failure
>>> EXHAUST_STACK: Corrupts_memory #
>>> [SKIP] 7 selftests lkdtm EXHAUST_STACK.sh # SKIP
>>> selftests: lkdtm_EXHAUST_STACK.sh [SKIP]
>>> # selftests lkdtm CORRUPT_STACK.sh
>>> lkdtm: CORRUPT_STACK.sh_ #
>>> # Skipping CORRUPT_STACK Crashes entire system on success
>>> CORRUPT_STACK: Crashes_entire #
>>> [SKIP] 8 selftests lkdtm CORRUPT_STACK.sh # SKIP
>>> selftests: lkdtm_CORRUPT_STACK.sh [SKIP]
>>> # selftests lkdtm CORRUPT_STACK_STRONG.sh
>>> lkdtm: CORRUPT_STACK_STRONG.sh_ #
>>> # Skipping CORRUPT_STACK_STRONG Crashes entire system on success
>>> CORRUPT_STACK_STRONG: Crashes_entire #
>>> [SKIP] 9 selftests lkdtm CORRUPT_STACK_STRONG.sh # SKIP
>>> selftests: lkdtm_CORRUPT_STACK_STRONG.sh [SKIP]
>>> # selftests lkdtm CORRUPT_LIST_ADD.sh
>>> lkdtm: CORRUPT_LIST_ADD.sh_ #
>>> # CORRUPT_LIST_ADD missing 'list_add corruption' [FAIL]
>>> missing: 'list_add_corruption' #
>>> [FAIL] 10 selftests lkdtm CORRUPT_LIST_ADD.sh # exit=1
>>> selftests: lkdtm_CORRUPT_LIST_ADD.sh [FAIL]
>>> # selftests lkdtm CORRUPT_LIST_DEL.sh
>>> lkdtm: CORRUPT_LIST_DEL.sh_ #
>>> # CORRUPT_LIST_DEL missing 'list_del corruption' [FAIL]
>>> missing: 'list_del_corruption' #
>>> [FAIL] 11 selftests lkdtm CORRUPT_LIST_DEL.sh # exit=1
>>> selftests: lkdtm_CORRUPT_LIST_DEL.sh [FAIL]
>>> # selftests lkdtm CORRUPT_USER_DS.sh
>>> lkdtm: CORRUPT_USER_DS.sh_ #
>>> # CORRUPT_USER_DS missing 'Invalid address limit on user-mode return' [FAIL]
>>> missing: 'Invalid_address #
>>> [FAIL] 12 selftests lkdtm CORRUPT_USER_DS.sh # exit=1
>>> selftests: lkdtm_CORRUPT_USER_DS.sh [FAIL]
>>> # selftests lkdtm STACK_GUARD_PAGE_LEADING.sh
>>> lkdtm: STACK_GUARD_PAGE_LEADING.sh_ #
>>> # STACK_GUARD_PAGE_LEADING missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 13 selftests lkdtm STACK_GUARD_PAGE_LEADING.sh # exit=1
>>> selftests: lkdtm_STACK_GUARD_PAGE_LEADING.sh [FAIL]
>>> # selftests lkdtm STACK_GUARD_PAGE_TRAILING.sh
>>> lkdtm: STACK_GUARD_PAGE_TRAILING.sh_ #
>>> # STACK_GUARD_PAGE_TRAILING missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 14 selftests lkdtm STACK_GUARD_PAGE_TRAILING.sh # exit=1
>>> selftests: lkdtm_STACK_GUARD_PAGE_TRAILING.sh [FAIL]
>>> # selftests lkdtm UNSET_SMEP.sh
>>> lkdtm: UNSET_SMEP.sh_ #
>>> # UNSET_SMEP missing 'CR4 bits went missing' [FAIL]
>>> missing: 'CR4_bits #
>>> [FAIL] 15 selftests lkdtm UNSET_SMEP.sh # exit=1
>>> selftests: lkdtm_UNSET_SMEP.sh [FAIL]
>>> # selftests lkdtm DOUBLE_FAULT.sh
>>> lkdtm: DOUBLE_FAULT.sh_ #
>>> # Skipped test 'DOUBLE_FAULT' missing in /sys/kernel/debug/provoke-crash/DIRECT!
>>> test: 'DOUBLE_FAULT'_missing #
>>> [SKIP] 16 selftests lkdtm DOUBLE_FAULT.sh # SKIP
>>> selftests: lkdtm_DOUBLE_FAULT.sh [SKIP]
>>> # selftests lkdtm UNALIGNED_LOAD_STORE_WRITE.sh
>>> lkdtm: UNALIGNED_LOAD_STORE_WRITE.sh_ #
>>> # UNALIGNED_LOAD_STORE_WRITE missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 17 selftests lkdtm UNALIGNED_LOAD_STORE_WRITE.sh # exit=1
>>> selftests: lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh [FAIL]
>>> # selftests lkdtm OVERWRITE_ALLOCATION.sh
>>> lkdtm: OVERWRITE_ALLOCATION.sh_ #
>>> # Skipping OVERWRITE_ALLOCATION Corrupts memory on failure
>>> OVERWRITE_ALLOCATION: Corrupts_memory #
>>> [SKIP] 18 selftests lkdtm OVERWRITE_ALLOCATION.sh # SKIP
>>> selftests: lkdtm_OVERWRITE_ALLOCATION.sh [SKIP]
>>> # selftests lkdtm WRITE_AFTER_FREE.sh
>>> lkdtm: WRITE_AFTER_FREE.sh_ #
>>> # Skipping WRITE_AFTER_FREE Corrupts memory on failure
>>> WRITE_AFTER_FREE: Corrupts_memory #
>>> [SKIP] 19 selftests lkdtm WRITE_AFTER_FREE.sh # SKIP
>>> selftests: lkdtm_WRITE_AFTER_FREE.sh [SKIP]
>>> # selftests lkdtm READ_AFTER_FREE.sh
>>> lkdtm: READ_AFTER_FREE.sh_ #
>>> # READ_AFTER_FREE missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 20 selftests lkdtm READ_AFTER_FREE.sh # exit=1
>>> selftests: lkdtm_READ_AFTER_FREE.sh [FAIL]
>>> # selftests lkdtm WRITE_BUDDY_AFTER_FREE.sh
>>> lkdtm: WRITE_BUDDY_AFTER_FREE.sh_ #
>>> # Skipping WRITE_BUDDY_AFTER_FREE Corrupts memory on failure
>>> WRITE_BUDDY_AFTER_FREE: Corrupts_memory #
>>> [SKIP] 21 selftests lkdtm WRITE_BUDDY_AFTER_FREE.sh # SKIP
>>> selftests: lkdtm_WRITE_BUDDY_AFTER_FREE.sh [SKIP]
>>> # selftests lkdtm READ_BUDDY_AFTER_FREE.sh
>>> lkdtm: READ_BUDDY_AFTER_FREE.sh_ #
>>> # READ_BUDDY_AFTER_FREE missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 22 selftests lkdtm READ_BUDDY_AFTER_FREE.sh # exit=1
>>> selftests: lkdtm_READ_BUDDY_AFTER_FREE.sh [FAIL]
>>> # selftests lkdtm SLAB_FREE_DOUBLE.sh
>>> lkdtm: SLAB_FREE_DOUBLE.sh_ #
>>> # SLAB_FREE_DOUBLE missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 23 selftests lkdtm SLAB_FREE_DOUBLE.sh # exit=1
>>> selftests: lkdtm_SLAB_FREE_DOUBLE.sh [FAIL]
>>> # selftests lkdtm SLAB_FREE_CROSS.sh
>>> lkdtm: SLAB_FREE_CROSS.sh_ #
>>> # SLAB_FREE_CROSS missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 24 selftests lkdtm SLAB_FREE_CROSS.sh # exit=1
>>> selftests: lkdtm_SLAB_FREE_CROSS.sh [FAIL]
>>> # selftests lkdtm SLAB_FREE_PAGE.sh
>>> lkdtm: SLAB_FREE_PAGE.sh_ #
>>> # SLAB_FREE_PAGE missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 25 selftests lkdtm SLAB_FREE_PAGE.sh # exit=1
>>> selftests: lkdtm_SLAB_FREE_PAGE.sh [FAIL]
>>> # selftests lkdtm SOFTLOCKUP.sh
>>> lkdtm: SOFTLOCKUP.sh_ #
>>> # Skipping SOFTLOCKUP Hangs the system
>>> SOFTLOCKUP: Hangs_the #
>>> [SKIP] 26 selftests lkdtm SOFTLOCKUP.sh # SKIP
>>> selftests: lkdtm_SOFTLOCKUP.sh [SKIP]
>>> # selftests lkdtm HARDLOCKUP.sh
>>> lkdtm: HARDLOCKUP.sh_ #
>>> # Skipping HARDLOCKUP Hangs the system
>>> HARDLOCKUP: Hangs_the #
>>> [SKIP] 27 selftests lkdtm HARDLOCKUP.sh # SKIP
>>> selftests: lkdtm_HARDLOCKUP.sh [SKIP]
>>> # selftests lkdtm SPINLOCKUP.sh
>>> lkdtm: SPINLOCKUP.sh_ #
>>> # Skipping SPINLOCKUP Hangs the system
>>> SPINLOCKUP: Hangs_the #
>>> [SKIP] 28 selftests lkdtm SPINLOCKUP.sh # SKIP
>>> selftests: lkdtm_SPINLOCKUP.sh [SKIP]
>>> # selftests lkdtm HUNG_TASK.sh
>>> lkdtm: HUNG_TASK.sh_ #
>>> # Skipping HUNG_TASK Hangs the system
>>> HUNG_TASK: Hangs_the #
>>> [SKIP] 29 selftests lkdtm HUNG_TASK.sh # SKIP
>>> selftests: lkdtm_HUNG_TASK.sh [SKIP]
>>> # selftests lkdtm EXEC_DATA.sh
>>> lkdtm: EXEC_DATA.sh_ #
>>> # EXEC_DATA missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 30 selftests lkdtm EXEC_DATA.sh # exit=1
>>> selftests: lkdtm_EXEC_DATA.sh [FAIL]
>>> # selftests lkdtm EXEC_STACK.sh
>>> lkdtm: EXEC_STACK.sh_ #
>>> # EXEC_STACK missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 31 selftests lkdtm EXEC_STACK.sh # exit=1
>>> selftests: lkdtm_EXEC_STACK.sh [FAIL]
>>> # selftests lkdtm EXEC_KMALLOC.sh
>>> lkdtm: EXEC_KMALLOC.sh_ #
>>> # EXEC_KMALLOC missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 32 selftests lkdtm EXEC_KMALLOC.sh # exit=1
>>> selftests: lkdtm_EXEC_KMALLOC.sh [FAIL]
>>> # selftests lkdtm EXEC_VMALLOC.sh
>>> lkdtm: EXEC_VMALLOC.sh_ #
>>> # EXEC_VMALLOC missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 33 selftests lkdtm EXEC_VMALLOC.sh # exit=1
>>> selftests: lkdtm_EXEC_VMALLOC.sh [FAIL]
>>> # selftests lkdtm EXEC_RODATA.sh
>>> lkdtm: EXEC_RODATA.sh_ #
>>> # EXEC_RODATA missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 34 selftests lkdtm EXEC_RODATA.sh # exit=1
>>> selftests: lkdtm_EXEC_RODATA.sh [FAIL]
>>> # selftests lkdtm EXEC_USERSPACE.sh
>>> lkdtm: EXEC_USERSPACE.sh_ #
>>> # EXEC_USERSPACE missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 35 selftests lkdtm EXEC_USERSPACE.sh # exit=1
>>> selftests: lkdtm_EXEC_USERSPACE.sh [FAIL]
>>> # selftests lkdtm EXEC_NULL.sh
>>> lkdtm: EXEC_NULL.sh_ #
>>> # EXEC_NULL missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 36 selftests lkdtm EXEC_NULL.sh # exit=1
>>> selftests: lkdtm_EXEC_NULL.sh [FAIL]
>>> # selftests lkdtm ACCESS_USERSPACE.sh
>>> lkdtm: ACCESS_USERSPACE.sh_ #
>>> # ACCESS_USERSPACE missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 37 selftests lkdtm ACCESS_USERSPACE.sh # exit=1
>>> selftests: lkdtm_ACCESS_USERSPACE.sh [FAIL]
>>> # selftests lkdtm ACCESS_NULL.sh
>>> lkdtm: ACCESS_NULL.sh_ #
>>> # ACCESS_NULL missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 38 selftests lkdtm ACCESS_NULL.sh # exit=1
>>> selftests: lkdtm_ACCESS_NULL.sh [FAIL]
>>> # selftests lkdtm WRITE_RO.sh
>>> lkdtm: WRITE_RO.sh_ #
>>> # WRITE_RO missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 39 selftests lkdtm WRITE_RO.sh # exit=1
>>> selftests: lkdtm_WRITE_RO.sh [FAIL]
>>> # selftests lkdtm WRITE_RO_AFTER_INIT.sh
>>> lkdtm: WRITE_RO_AFTER_INIT.sh_ #
>>> # WRITE_RO_AFTER_INIT missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 40 selftests lkdtm WRITE_RO_AFTER_INIT.sh # exit=1
>>> selftests: lkdtm_WRITE_RO_AFTER_INIT.sh [FAIL]
>>> # selftests lkdtm WRITE_KERN.sh
>>> lkdtm: WRITE_KERN.sh_ #
>>> # WRITE_KERN missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 41 selftests lkdtm WRITE_KERN.sh # exit=1
>>> selftests: lkdtm_WRITE_KERN.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_INC_OVERFLOW.sh
>>> lkdtm: REFCOUNT_INC_OVERFLOW.sh_ #
>>> # REFCOUNT_INC_OVERFLOW missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 42 selftests lkdtm REFCOUNT_INC_OVERFLOW.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_INC_OVERFLOW.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_ADD_OVERFLOW.sh
>>> lkdtm: REFCOUNT_ADD_OVERFLOW.sh_ #
>>> # REFCOUNT_ADD_OVERFLOW missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 43 selftests lkdtm REFCOUNT_ADD_OVERFLOW.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_ADD_OVERFLOW.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
>>> lkdtm: REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh_ #
>>> # REFCOUNT_INC_NOT_ZERO_OVERFLOW missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 44 selftests lkdtm REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
>>> lkdtm: REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh_ #
>>> # REFCOUNT_ADD_NOT_ZERO_OVERFLOW missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 45 selftests lkdtm REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_DEC_ZERO.sh
>>> lkdtm: REFCOUNT_DEC_ZERO.sh_ #
>>> # REFCOUNT_DEC_ZERO missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 46 selftests lkdtm REFCOUNT_DEC_ZERO.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_DEC_ZERO.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_DEC_NEGATIVE.sh
>>> lkdtm: REFCOUNT_DEC_NEGATIVE.sh_ #
>>> # REFCOUNT_DEC_NEGATIVE missing 'Negative detected saturated' [FAIL]
>>> missing: 'Negative_detected #
>>> [FAIL] 47 selftests lkdtm REFCOUNT_DEC_NEGATIVE.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_DEC_NEGATIVE.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
>>> lkdtm: REFCOUNT_DEC_AND_TEST_NEGATIVE.sh_ #
>>> # REFCOUNT_DEC_AND_TEST_NEGATIVE missing 'Negative detected saturated' [FAIL]
>>> missing: 'Negative_detected #
>>> [  360.222897] kselftest: Running tests in membarrier
>>> [FAIL] 48 selftests lkdtm REFCOUNT_DEC_AND_TEST_NEGATIVE.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
>>> lkdtm: REFCOUNT_SUB_AND_TEST_NEGATIVE.sh_ [  360.455095] kselftest:
>>> Running tests in memfd
>>> #
>>> # REFCOUNT_SUB_AND_TEST_NEGATIVE missing 'Negative detected saturated' [FAIL]
>>> missing: 'Negative_detected #
>>> [FAIL] 49 selftests lkdtm REFCOUNT_SUB_AND_TEST_NEGATIVE.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_INC_ZERO.sh
>>> lkdtm: REFCOUNT_INC_ZERO.sh_ #
>>> # REFCOUNT_INC_ZERO missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 50 selftests lkdtm REFCOUNT_INC_ZERO.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_INC_ZERO.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_ADD_ZERO.sh
>>> lkdtm: REFCOUNT_ADD_ZERO.sh_ #
>>> # REFCOUNT_ADD_ZERO missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 51 selftests lkdtm REFCOUNT_ADD_ZERO.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_ADD_ZERO.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_INC_SATURATED.sh
>>> lkdtm: REFCOUNT_INC_SATURATED.sh_ #
>>> # REFCOUNT_INC_SATURATED missing 'Saturation detected still saturated' [FAIL]
>>> missing: 'Saturation_detected #
>>> [FAIL] 52 selftests lkdtm REFCOUNT_INC_SATURATED.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_INC_SATURATED.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_DEC_SATURATED.sh
>>> lkdtm: REFCOUNT_DEC_SATURATED.sh_ #
>>> # REFCOUNT_DEC_SATURATED missing 'Saturation detected still saturated' [FAIL]
>>> missing: 'Saturation_detected #
>>> [FAIL] 53 selftests lkdtm REFCOUNT_DEC_SATURATED.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_DEC_SATURATED.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_ADD_SATURATED.sh
>>> lkdtm: REFCOUNT_ADD_SATURATED.sh_ #
>>> # REFCOUNT_ADD_SATURATED missing 'Saturation detected still saturated' [FAIL]
>>> missing: 'Saturation_detected #
>>> [FAIL] 54 selftests lkdtm REFCOUNT_ADD_SATURATED.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_ADD_SATURATED.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_INC_NOT_ZERO_SATURATED.sh
>>> lkdtm: REFCOUNT_INC_NOT_ZERO_SATURATED.sh_ #
>>> # REFCOUNT_INC_NOT_ZERO_SATURATED missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 55 selftests lkdtm REFCOUNT_INC_NOT_ZERO_SATURATED.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
>>> lkdtm: REFCOUNT_ADD_NOT_ZERO_SATURATED.sh_ #
>>> # REFCOUNT_ADD_NOT_ZERO_SATURATED missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 56 selftests lkdtm REFCOUNT_ADD_NOT_ZERO_SATURATED.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_DEC_AND_TEST_SATURATED.sh
>>> lkdtm: REFCOUNT_DEC_AND_TEST_SATURATED.sh_ #
>>> # REFCOUNT_DEC_AND_TEST_SATURATED missing 'Saturation detected still
>>> saturated' [FAIL]
>>> missing: 'Saturation_detected #
>>> [FAIL] 57 selftests lkdtm REFCOUNT_DEC_AND_TEST_SATURATED.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_SUB_AND_TEST_SATURATED.sh
>>> lkdtm: REFCOUNT_SUB_AND_TEST_SATURATED.sh_ #
>>> # REFCOUNT_SUB_AND_TEST_SATURATED missing 'Saturation detected still
>>> saturated' [FAIL]
>>> missing: 'Saturation_detected #
>>> [FAIL] 58 selftests lkdtm REFCOUNT_SUB_AND_TEST_SATURATED.sh # exit=1
>>> selftests: lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh [FAIL]
>>> # selftests lkdtm REFCOUNT_TIMING.sh
>>> lkdtm: REFCOUNT_TIMING.sh_ #
>>> # Skipping REFCOUNT_TIMING timing only
>>> REFCOUNT_TIMING: timing_only #
>>> [SKIP] 59 selftests lkdtm REFCOUNT_TIMING.sh # SKIP
>>> selftests: lkdtm_REFCOUNT_TIMING.sh [SKIP]
>>> # selftests lkdtm ATOMIC_TIMING.sh
>>> lkdtm: ATOMIC_TIMING.sh_ #
>>> # Skipping ATOMIC_TIMING timing only
>>> ATOMIC_TIMING: timing_only #
>>> [SKIP] 60 selftests lkdtm ATOMIC_TIMING.sh # SKIP
>>> selftests: lkdtm_ATOMIC_TIMING.sh [SKIP]
>>> # selftests lkdtm USERCOPY_HEAP_SIZE_TO.sh
>>> lkdtm: USERCOPY_HEAP_SIZE_TO.sh_ #
>>> # USERCOPY_HEAP_SIZE_TO missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 61 selftests lkdtm USERCOPY_HEAP_SIZE_TO.sh # exit=1
>>> selftests: lkdtm_USERCOPY_HEAP_SIZE_TO.sh [FAIL]
>>> # selftests lkdtm USERCOPY_HEAP_SIZE_FROM.sh
>>> lkdtm: USERCOPY_HEAP_SIZE_FROM.sh_ #
>>> # USERCOPY_HEAP_SIZE_FROM missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 62 selftests lkdtm USERCOPY_HEAP_SIZE_FROM.sh # exit=1
>>> selftests: lkdtm_USERCOPY_HEAP_SIZE_FROM.sh [FAIL]
>>> # selftests lkdtm USERCOPY_HEAP_WHITELIST_TO.sh
>>> lkdtm: USERCOPY_HEAP_WHITELIST_TO.sh_ #
>>> # USERCOPY_HEAP_WHITELIST_TO missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 63 selftests lkdtm USERCOPY_HEAP_WHITELIST_TO.sh # exit=1
>>> selftests: lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh [FAIL]
>>> # selftests lkdtm USERCOPY_HEAP_WHITELIST_FROM.sh
>>> lkdtm: USERCOPY_HEAP_WHITELIST_FROM.sh_ #
>>> # USERCOPY_HEAP_WHITELIST_FROM missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 64 selftests lkdtm USERCOPY_HEAP_WHITELIST_FROM.sh # exit=1
>>> selftests: lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh [FAIL]
>>> # selftests lkdtm USERCOPY_STACK_FRAME_TO.sh
>>> lkdtm: USERCOPY_STACK_FRAME_TO.sh_ #
>>> # USERCOPY_STACK_FRAME_TO missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 65 selftests lkdtm USERCOPY_STACK_FRAME_TO.sh # exit=1
>>> selftests: lkdtm_USERCOPY_STACK_FRAME_TO.sh [FAIL]
>>> # selftests lkdtm USERCOPY_STACK_FRAME_FROM.sh
>>> lkdtm: USERCOPY_STACK_FRAME_FROM.sh_ #
>>> # USERCOPY_STACK_FRAME_FROM missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 66 selftests lkdtm USERCOPY_STACK_FRAME_FROM.sh # exit=1
>>> selftests: lkdtm_USERCOPY_STACK_FRAME_FROM.sh [FAIL]
>>> # selftests lkdtm USERCOPY_STACK_BEYOND.sh
>>> lkdtm: USERCOPY_STACK_BEYOND.sh_ #
>>> # USERCOPY_STACK_BEYOND missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 67 selftests lkdtm USERCOPY_STACK_BEYOND.sh # exit=1
>>> selftests: lkdtm_USERCOPY_STACK_BEYOND.sh [FAIL]
>>> # selftests lkdtm USERCOPY_KERNEL.sh
>>> lkdtm: USERCOPY_KERNEL.sh_ #
>>> # USERCOPY_KERNEL missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 68 selftests lkdtm USERCOPY_KERNEL.sh # exit=1
>>> selftests: lkdtm_USERCOPY_KERNEL.sh [FAIL]
>>> # selftests lkdtm USERCOPY_KERNEL_DS.sh
>>> lkdtm: USERCOPY_KERNEL_DS.sh_ #
>>> # USERCOPY_KERNEL_DS missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 69 selftests lkdtm USERCOPY_KERNEL_DS.sh # exit=1
>>> selftests: lkdtm_USERCOPY_KERNEL_DS.sh [FAIL]
>>> # selftests lkdtm STACKLEAK_ERASING.sh
>>> lkdtm: STACKLEAK_ERASING.sh_ #
>>> # STACKLEAK_ERASING missing 'OK the rest of the thread stack is
>>> properly erased' [FAIL]
>>> missing: 'OK_the #
>>> [FAIL] 70 selftests lkdtm STACKLEAK_ERASING.sh # exit=1
>>> selftests: lkdtm_STACKLEAK_ERASING.sh [FAIL]
>>> # selftests lkdtm CFI_FORWARD_PROTO.sh
>>> lkdtm: CFI_FORWARD_PROTO.sh_ #
>>> # CFI_FORWARD_PROTO missing 'call trace' [FAIL]
>>> missing: 'call_trace' #
>>> [FAIL] 71 selftests lkdtm CFI_FORWARD_PROTO.sh # exit=1
>>> selftests: lkdtm_CFI_FORWARD_PROTO.sh [FAIL]
>>>
>>> ref:
>>> https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.6-rc1-19-g359c92c02bfa/testrun/1212254/log
>>> https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.5-11440-gd1ea35f4cdd4/testrun/1202720/log
>>>
>>> --
>>> Linaro LKFT
>>> https://lkft.linaro.org
>>>
>>
> 

