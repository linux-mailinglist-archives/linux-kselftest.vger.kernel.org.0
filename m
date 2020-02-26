Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10941706EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2020 19:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBZSDC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Feb 2020 13:03:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33632 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgBZSDB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Feb 2020 13:03:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so118522lji.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2020 10:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWXKGdBdSX89CKR49e5HffMWoYSUP5rUcqDtF+HPtwU=;
        b=ACh0SRAboVy9RI/D8WrK7VHkxi4+ta5eLMnNWoJU0tAoPcYq0HEVIC0YNpBboxDBBp
         DpR1O8hBxPP0kZqekZjQfwjMvKF0/rceGQYMiduSe9uU33KJEqOl0XfIVgVG4Uue1oAb
         eVgTwOVA6OYfqaxp2t5hYREjGDebc8qEbVXx/3Hr//pVlBp/Kz4ugcx8oJqathS4eVa8
         nCNSrWLI4SKd3GV6hrw4LMIlcvCRvHjCoMFbd3fVu9zbVD8WR4i0fl4hgcTYWSXHG65x
         P3s905idwsUc6DxrPHyDsUTFz2KjVkN9fJkwK1xGlaa0vicxuiGumwphYAMOTQyK8FGa
         e38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWXKGdBdSX89CKR49e5HffMWoYSUP5rUcqDtF+HPtwU=;
        b=BhuqSlQJElb7Ywr2rhjEmBt3/jMCfKU+3q183IHYRi/eT1b3UfZXR+3fy0GnJGOu2b
         tJwulMQL82gTJudZFPn6XI4CArPNvOKelkGYQwQGiZXgPiEh/XM/q9ZifjZyRpj1vD/f
         JiI+EZc/vDiL1SJIwhJUFxcbKe0x0sBQcearrOMVMf6ImLAJ1wDM6k4yINesF7KvGgQU
         EBxJhsBG9o5eqNCow81/n/glcd2FQ3Eu6suJxOJaK6/DSTNjmvCq5ocLzGMQ5W86By8j
         6VAUT8zoJrgOjkRd7kpErG2gpwhVfFD7j7MrRxK80/3E1SIZfjQGacku4EWiexp1sI/I
         0Oqw==
X-Gm-Message-State: ANhLgQ3UWkC1mhtGg+EPhkdzPJLuFZ+2gMZRMab8uSo1qlDZsW0tk7zK
        gpGw6/BfFQn9C8LcBDsVNO8vPjOBf9BZOktyOv8aEg==
X-Google-Smtp-Source: ADFU+vuwE3qhVRbQZtrSftxYOVH0ZnrrfJe221jM9W/BJxb8Y8TG/bQuSlMQjAc3UvmpphwH1ksiK5jB59fzcMH5MEw=
X-Received: by 2002:a05:651c:414:: with SMTP id 20mr83919lja.165.1582740178341;
 Wed, 26 Feb 2020 10:02:58 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYu3682XJ2Kw2ZvQdUT80epKc9DWWXgDT1-D_65ajSXNTw@mail.gmail.com>
 <fcb799d4-f316-60d6-9fd0-0bc1c174e63c@arm.com> <202002251131.3216B3B50C@keescook>
 <b485a8a9-5312-ca77-d091-3dbfac33ec5b@arm.com>
In-Reply-To: <b485a8a9-5312-ca77-d091-3dbfac33ec5b@arm.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 26 Feb 2020 23:32:46 +0530
Message-ID: <CA+G9fYuQJjf3v53HNj4TOAL2NcgDCYCrsUkfL6h93ntXO3WWwg@mail.gmail.com>
Subject: Re: selftests: Linux Kernel Dump Test Module output
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>, ankita@in.ibm.com,
        Will Deacon <will@kernel.org>, ardb@kernel.org,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 26 Feb 2020 at 17:23, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> Hi Kees
>
> ./run_kselftest.sh 2>/dev/null | grep "SKIP"
> not ok 1 selftests: lkdtm: PANIC.sh # SKIP
> not ok 6 selftests: lkdtm: LOOP.sh # SKIP
> not ok 7 selftests: lkdtm: EXHAUST_STACK.sh # SKIP
> not ok 8 selftests: lkdtm: CORRUPT_STACK.sh # SKIP
> not ok 9 selftests: lkdtm: CORRUPT_STACK_STRONG.sh # SKIP
> not ok 15 selftests: lkdtm: UNSET_SMEP.sh # SKIP
> not ok 16 selftests: lkdtm: DOUBLE_FAULT.sh # SKIP
> not ok 18 selftests: lkdtm: OVERWRITE_ALLOCATION.sh # SKIP
> not ok 19 selftests: lkdtm: WRITE_AFTER_FREE.sh # SKIP
> not ok 21 selftests: lkdtm: WRITE_BUDDY_AFTER_FREE.sh # SKIP
> not ok 26 selftests: lkdtm: SOFTLOCKUP.sh # SKIP
> not ok 27 selftests: lkdtm: HARDLOCKUP.sh # SKIP
> not ok 28 selftests: lkdtm: SPINLOCKUP.sh # SKIP
> not ok 29 selftests: lkdtm: HUNG_TASK.sh # SKIP
> not ok 59 selftests: lkdtm: REFCOUNT_TIMING.sh # SKIP
> not ok 60 selftests: lkdtm: ATOMIC_TIMING.sh # SKIP
>
> BUT, if I look at one LKDTM test script
> (lkdtm/USERCOPY_STACK_FRAME_TO.sh):
>
> ...
> # If the test is commented out, report a skip

Yeah i see this case at my end also.

my two cents,
I have two comments,
1) shell check

2) I see the debugfs mounted and test required details are available
in a given path.

1) Shell check show these warnings
* SHELLCHECK: [FAILED]: run.sh
* SHELLCHECK: [OUTPUT]:

 In run.sh line 26:
 test=$(basename $0 .sh)
                 ^-- SC2086: Double quote to prevent globbing and word
splitting.


 In run.sh line 28:
 line=$(egrep '^#?'"$test"'\b' tests.txt)
        ^---^ SC2196: egrep is non-standard and deprecated. Use grep -E instead.


 In run.sh line 34:
 if ! egrep -q '^'"$test"'$' "$TRIGGER" ; then
      ^---^ SC2196: egrep is non-standard and deprecated. Use grep -E instead.


 In run.sh line 81:
 if egrep -qi "$expect" "$LOG" ; then
    ^---^ SC2196: egrep is non-standard and deprecated. Use grep -E instead.


 In run.sh line 85:
  if egrep -qi XFAIL: "$LOG" ; then
            ^---^ SC2196: egrep is non-standard and deprecated. Use
grep -E instead.

Test output with set -x for debugging shell scripts.

+ ls /sys/kernel/debug/provoke-crash/DIRECT
/sys/kernel/debug/provoke-crash/DIRECT
+ ls /sys/kernel/debug/provoke-crash/DIRECT
/sys/kernel/debug/provoke-crash/FS_DEVRW
/sys/kernel/debug/provoke-crash/IDE_CORE_CP
/sys/kernel/debug/provoke-crash/INT_HARDWARE_ENTRY
/sys/kernel/debug/provoke-crash/INT_HW_IRQ_EN
/sys/kernel/debug/provoke-crash/INT_TASKLET_ENTRY
/sys/kernel/debug/provoke-crash/MEM_SWAPOUT
/sys/kernel/debug/provoke-crash/SCSI_DISPATCH_CMD
/sys/kernel/debug/provoke-crash/TIMERADD
/sys/kernel/debug/provoke-crash/DIRECT
/sys/kernel/debug/provoke-crash/FS_DEVRW
/sys/kernel/debug/provoke-crash/IDE_CORE_CP
/sys/kernel/debug/provoke-crash/INT_HARDWARE_ENTRY
/sys/kernel/debug/provoke-crash/INT_HW_IRQ_EN
/sys/kernel/debug/provoke-crash/INT_TASKLET_ENTRY
/sys/kernel/debug/provoke-crash/MEM_SWAPOUT
/sys/kernel/debug/provoke-crash/SCSI_DISPATCH_CMD
/sys/kernel/debug/provoke-crash/TIMERADD
+ cat /sys/kernel/debug/provoke-crash/DIRECT
Available crash types:
PANIC
BUG
WARNING
WARNING_MESSAGE
EXCEPTION
LOOP
EXHAUST_STACK
CORRUPT_STACK
CORRUPT_STACK_STRONG
CORRUPT_LIST_ADD
CORRUPT_LIST_DEL
CORRUPT_USER_DS
STACK_GUARD_PAGE_LEADING
STACK_GUARD_PAGE_TRAILING
UNSET_SMEP
UNALIGNED_LOAD_STORE_WRITE
OVERWRITE_ALLOCATION
WRITE_AFTER_FREE
READ_AFTER_FREE
WRITE_BUDDY_AFTER_FREE
READ_BUDDY_AFTER_FREE
SLAB_FREE_DOUBLE
SLAB_FREE_CROSS
SLAB_FREE_PAGE
SOFTLOCKUP
HARDLOCKUP
SPINLOCKUP
HUNG_TASK
EXEC_DATA
EXEC_STACK
EXEC_KMALLOC
EXEC_VMALLOC
EXEC_RODATA
EXEC_USERSPACE
EXEC_NULL
ACCESS_USERSPACE
ACCESS_NULL
WRITE_RO
WRITE_RO_AFTER_INIT
WRITE_KERN
REFCOUNT_INC_OVERFLOW
REFCOUNT_ADD_OVERFLOW
REFCOUNT_INC_NOT_ZERO_OVERFLOW
REFCOUNT_ADD_NOT_ZERO_OVERFLOW
REFCOUNT_DEC_ZERO
REFCOUNT_DEC_NEGATIVE
REFCOUNT_DEC_AND_TEST_NEGATIVE
REFCOUNT_SUB_AND_TEST_NEGATIVE
REFCOUNT_INC_ZERO
REFCOUNT_ADD_ZERO
REFCOUNT_INC_SATURATED
REFCOUNT_DEC_SATURATED
REFCOUNT_ADD_SATURATED
REFCOUNT_INC_NOT_ZERO_SATURATED
REFCOUNT_ADD_NOT_ZERO_SATURATED
REFCOUNT_DEC_AND_TEST_SATURATED
REFCOUNT_SUB_AND_TEST_SATURATED
REFCOUNT_TIMING
ATOMIC_TIMING
USERCOPY_HEAP_SIZE_TO
USERCOPY_HEAP_SIZE_FROM
USERCOPY_HEAP_WHITELIST_TO
USERCOPY_HEAP_WHITELIST_FROM
USERCOPY_STACK_FRAME_TO
USERCOPY_STACK_FRAME_FROM
USERCOPY_STACK_BEYOND
USERCOPY_KERNEL
USERCOPY_KERNEL_DS
STACKLEAK_ERASING
CFI_FORWARD_PROTO
+ cd /opt/kselftests/default-in-kernel/lkdtm
+ sed -i '1i set -x' ACCESS_NULL.sh ACCESS_USERSPACE.sh
ATOMIC_TIMING.sh BUG.sh CFI_FORWARD_PROTO.sh CORRUPT_LIST_ADD.sh
CORRUPT_LIST_DEL.sh CORRUPT_STACK.sh CORRUPT_STACK_STRONG.sh
CORRUPT_USER_DS.sh DOUBLE_FAULT.sh EXCEPTION.sh EXEC_DATA.sh
EXEC_KMALLOC.sh EXEC_NULL.sh EXEC_RODATA.sh EXEC_STACK.sh
EXEC_USERSPACE.sh EXEC_VMALLOC.sh EXHAUST_STACK.sh HARDLOCKUP.sh
HUNG_TASK.sh LOOP.sh OVERWRITE_ALLOCATION.sh PANIC.sh
READ_AFTER_FREE.sh READ_BUDDY_AFTER_FREE.sh
REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
REFCOUNT_ADD_OVERFLOW.sh REFCOUNT_ADD_SATURATED.sh
REFCOUNT_ADD_ZERO.sh REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
REFCOUNT_DEC_AND_TEST_SATURATED.sh REFCOUNT_DEC_NEGATIVE.sh
REFCOUNT_DEC_SATURATED.sh REFCOUNT_DEC_ZERO.sh
REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh REFCOUNT_INC_NOT_ZERO_SATURATED.sh
REFCOUNT_INC_OVERFLOW.sh REFCOUNT_INC_SATURATED.sh
REFCOUNT_INC_ZERO.sh REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
REFCOUNT_SUB_AND_TEST_SATURATED.sh REFCOUNT_TIMING.sh
SLAB_FREE_CROSS.sh SLAB_FREE_DOUBLE.sh SLAB_FREE_PAGE.sh SOFTLOCKUP.sh
SPINLOCKUP.sh STACKLEAK_ERASING.sh STACK_GUARD_PAGE_LEADING.sh
STACK_GUARD_PAGE_TRAILING.sh UNALIGNED_LOAD_STORE_WRITE.sh
UNSET_SMEP.sh USERCOPY_HEAP_SIZE_FROM.sh USERCOPY_HEAP_SIZE_TO.sh
USERCOPY_HEAP_WHITELIST_FROM.sh USERCOPY_HEAP_WHITELIST_TO.sh
USERCOPY_KERNEL.sh USERCOPY_KERNEL_DS.sh USERCOPY_STACK_BEYOND.sh
USERCOPY_STACK_FRAME_FROM.sh USERCOPY_STACK_FRAME_TO.sh WARNING.sh
WARNING_MESSAGE.sh WRITE_AFTER_FREE.sh WRITE_BUDDY_AFTER_FREE.sh
WRITE_KERN.sh WRITE_RO.sh WRITE_RO_AFTER_INIT.sh
+ ./PANIC.sh
++ set -e
++ TRIGGER=/sys/kernel/debug/provoke-crash/DIRECT
++ KSELFTEST_SKIP_TEST=4
++ '[' '!' -r /sys/kernel/debug/provoke-crash/DIRECT ']'
+++ basename ./PANIC.sh .sh
++ test=PANIC
+++ egrep '^#?PANIC\b' tests.txt
++ line='#PANIC'
++ '[' -z '#PANIC' ']'
++ egrep -q '^PANIC$' /sys/kernel/debug/provoke-crash/DIRECT
+++ echo '#PANIC'
+++ cut '-d ' -f1
++ test='#PANIC'
++ echo '#PANIC'
++ grep -q ' '
++ expect=
++ echo '#PANIC'
++ grep -q '^#'
+++ echo '#PANIC'
+++ cut -c2-
++ test=PANIC
++ '[' -z '' ']'
++ expect='crashes entire system'
++ echo 'Skipping PANIC: crashes entire system'
Skipping PANIC: crashes entire system
++ exit 4
+ true
+ ./BUG.sh
++ set -e
++ TRIGGER=/sys/kernel/debug/provoke-crash/DIRECT
++ KSELFTEST_SKIP_TEST=4
++ '[' '!' -r /sys/kernel/debug/provoke-crash/DIRECT ']'
+++ basename ./BUG.sh .sh
++ test=BUG
+++ egrep '^#?BUG\b' tests.txt
++ line='BUG kernel BUG at'
++ '[' -z 'BUG kernel BUG at' ']'
++ egrep -q '^BUG$' /sys/kernel/debug/provoke-crash/DIRECT
+++ echo 'BUG kernel BUG at'
+++ cut '-d ' -f1
++ test=BUG
++ echo 'BUG kernel BUG at'
++ grep -q ' '
+++ echo 'BUG kernel BUG at'
+++ cut '-d ' -f2-
++ expect='kernel BUG at'
++ echo BUG
++ grep -q '^#'
++ '[' -z 'kernel BUG at' ']'
++ dmesg -c
+++ mktemp --tmpdir -t lkdtm-XXXXXX
++ LOG=/tmp/lkdtm-r5yZ7K
++ trap cleanup EXIT
++ /bin/sh -c 'cat <(echo BUG) >/sys/kernel/debug/provoke-crash/DIRECT'
++ true
++ dmesg -c
++ cat /tmp/lkdtm-r5yZ7K
++ egrep -qi 'kernel BUG at' /tmp/lkdtm-r5yZ7K
++ egrep -qi XFAIL: /tmp/lkdtm-r5yZ7K
++ echo 'BUG: missing '\''kernel BUG at'\'': [FAIL]'
BUG: missing 'kernel BUG at': [FAIL]
...

ref:
https://lkft.validation.linaro.org/scheduler/job/1251181#L1311
