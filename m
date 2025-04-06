Return-Path: <linux-kselftest+bounces-30169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7013FA7CDC1
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Apr 2025 13:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F5D16C165
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Apr 2025 11:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37262201116;
	Sun,  6 Apr 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CvU4EqZO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F75E20125B;
	Sun,  6 Apr 2025 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743940670; cv=none; b=jdvcsno46/Fb4lbmbX6tjhTBmGwP+g40gefhjpCR5tZOhukG9AR0gkjZJdikh2c1RWV/doQ1gHnUFSDBbHsmhgv1p+m8p6sY3E+qGjhWgRh9z/rw5LrUq5V1/xy30Xzkayi5zb/j3Io+tq+KnUOC+NCuXJyQdRAqNX9UWw1Gfws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743940670; c=relaxed/simple;
	bh=1qiIa1unk46NH8WusRPlYYJAwpi0rLRqMqi2/0K5qQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbIAxeoig5WMFgsCwSlGJe8NRdyZ6g5zeCUIxbueCCEC9fksjby/PZ4EyV6B5Kbiiz1wfPzrkdrabpZy7gvOw3jZz6S1CibyjQnb43l8I9RGmlSrQtvLeH8gIdxB2Q3YKjzy+ZA5JHY3oW/wGRIMvikJOdE2xLlj1Xw0euEKxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CvU4EqZO; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743940656; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qqH4N2+CHgOqU/M5fIoD1f1hycV5QL3eTccuZsOVm14=;
	b=CvU4EqZOm2Xzl6z3KyI/ngPYwUG0M6Hr0Pw3DfmJ3TCZIAecijcrAfjuRtAsCQmrj/BJrJ7E/CPc3+1p50NfaWl3gFUasK5bq/o7Q/dRKLVlrvxtryf2mou/XI+oBC0oiaHgC89FhsUXkrl0ZpKAwoPE3jYjEfNAYZ3pOljIY7U=
Received: from 30.246.160.68(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WVZ69Fk_1743940654 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 06 Apr 2025 19:57:35 +0800
Message-ID: <3af36c30-48e9-4182-ad09-bd28d3e4acb4@linux.alibaba.com>
Date: Sun, 6 Apr 2025 19:57:34 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/pidfd: align stack to fix SP alignment
 exception
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, baolin.wang@linux.alibaba.com,
 tianruidong@linux.alibaba.com, brauner@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250312061557.28532-1-xueshuai@linux.alibaba.com>
 <0a70f4ab-cd83-434d-8dd2-486d58e5599a@linux.alibaba.com>
 <20250404121759.GA28692@willie-the-truck>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250404121759.GA28692@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/4 20:18, Will Deacon 写道:
> On Wed, Mar 19, 2025 at 10:59:57AM +0800, Shuai Xue wrote:
>> + ARM maintainers for review.
>>
>> 在 2025/3/12 14:15, Shuai Xue 写道:
>>> The pidfd_test fails on the ARM64 platform with the following error:
>>>
>>>       Bail out! pidfd_poll check for premature notification on child thread exec test: Failed
>>>
>>> When exception-trace is enabled, the kernel logs the details:
>>>
>>>       #echo 1 > /proc/sys/debug/exception-trace
>>>       #dmesg | tail -n 20
>>>       [48628.713023] pidfd_test[1082142]: unhandled exception: SP Alignment, ESR 0x000000009a000000, SP/PC alignment exception in pidfd_test[400000+4000]
>>>       [48628.713049] CPU: 21 PID: 1082142 Comm: pidfd_test Kdump: loaded Tainted: G        W   E      6.6.71-3_rc1.al8.aarch64 #1
>>>       [48628.713051] Hardware name: AlibabaCloud AliServer-Xuanwu2.0AM-1UC1P-5B/AS1111MG1, BIOS 1.2.M1.AL.P.157.00 07/29/2023
>>>       [48628.713053] pstate: 60001800 (nZCv daif -PAN -UAO -TCO -DIT +SSBS BTYPE=-c)
>>>       [48628.713055] pc : 0000000000402100
>>>       [48628.713056] lr : 0000ffff98288f9c
>>>       [48628.713056] sp : 0000ffffde49daa8
>>>       [48628.713057] x29: 0000000000000000 x28: 0000000000000000 x27: 0000000000000000
>>>       [48628.713060] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
>>>       [48628.713062] x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000400e80
>>>       [48628.713065] x20: 0000000000000000 x19: 0000000000402650 x18: 0000000000000000
>>>       [48628.713067] x17: 00000000004200d8 x16: 0000ffff98288f40 x15: 0000ffffde49b92c
>>>       [48628.713070] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>>       [48628.713072] x11: 0000000000001011 x10: 0000000000402100 x9 : 0000000000000010
>>>       [48628.713074] x8 : 00000000000000dc x7 : 3861616239346564 x6 : 000000000000000a
>>>       [48628.713077] x5 : 0000ffffde49daa8 x4 : 000000000000000a x3 : 0000ffffde49daa8
>>>       [48628.713079] x2 : 0000ffffde49dadc x1 : 0000ffffde49daa8 x0 : 0000000000000000
>>>
>>> According to ARM ARM D1.3.10.2 SP alignment checking:
>>>
>>>> When the SP is used as the base address of a calculation, regardless of
>>>> any offset applied by the instruction, if bits [3:0] of the SP are not
>>>> 0b0000, there is a misaligned SP.
>>>
>>> To fix it, align the stack with 16 bytes.
>>>
>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>> ---
>>>    tools/testing/selftests/pidfd/pidfd_test.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
>>> index c081ae91313a..ec161a7c3ff9 100644
>>> --- a/tools/testing/selftests/pidfd/pidfd_test.c
>>> +++ b/tools/testing/selftests/pidfd/pidfd_test.c
>>> @@ -33,7 +33,7 @@ static bool have_pidfd_send_signal;
>>>    static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
>>>    {
>>>    	size_t stack_size = 1024;
>>> -	char *stack[1024] = { 0 };
>>> +	char *stack[1024] __attribute__((aligned(16))) = {0};
>>>    #ifdef __ia64__
>>>    	return __clone2(fn, stack, stack_size, flags | SIGCHLD, NULL, pidfd);
> 
> The arm64 alignment requirement is correct, but I don't really grok what
> this code is trying to do. If it's not using CLONE_VM, why bother passing
> a separate stack? If it _is_ using CLONE_VM, then surely the stack needs
> to be allocated somewhere other than the caller stack?
> 

Hi, Will,

Thank for you reply.

> https://man7.org/linux/man-pages/man2/clone3.2.html
clone3()
        The stack for the child process is specified via cl_args.stack,
        which points to the lowest byte of the stack area, and
        cl_args.stack_size, which specifies the size of the stack in
        bytes.  In the case where the CLONE_VM flag (see below) is
        specified, a stack must be explicitly allocated and specified.
        * Otherwise, these two fields can be specified as NULL and 0 *, which
        causes the child to use the same stack area as the parent (in the
        child's own virtual address space).

 From man-pages for clone3, I think you are right.
As you pointed out, without CLONE_VM, the stack can indeed be set to NULL.
However, when running the pidfd_test, issues arise:

#./pidfd_test
TAP version 13
1..8
# Parent: pid: 125004
Bail out! pidfd_poll check for premature notification on child thread exec test: pidfd_clone failed (ret -1, errno 22)
# Planned tests != run tests (8 != 0)
# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0


Upon examining the git diff:

#git diff
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 9a2d64901d59..c5991c0712c8 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -32,13 +32,10 @@ static bool have_pidfd_send_signal;

  static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
  {
-       size_t stack_size = 1024;
-       char *stack[1024] = { 0 };
-
  #ifdef __ia64__
         return __clone2(fn, stack, stack_size, flags | SIGCHLD, NULL, pidfd);
  #else
-       return clone(fn, stack + stack_size, flags | SIGCHLD, NULL, pidfd);
+       return clone(fn, NULL, flags | SIGCHLD, NULL, pidfd);
  #endif
  }


Also from man-pages of clone3, https://man7.org/linux/man-pages/man2/clone3.2.html

    The clone() wrapper function

        The stack argument specifies the location of the stack used by the
        child process.  Since the child and calling process may share
        memory, it is not possible for the child process to execute in the
        same stack as the calling process.  *The calling process must
        therefore set up memory space for the child stack and pass a
        pointer to this space to clone()*.  Stacks grow downward on all
        processors that run Linux (except the HP PA processors), so stack
        usually points to the topmost address of the memory space set up
        for the child stack.  Note that clone() does not provide a means
        whereby the caller can inform the kernel of the size of the stack
        area.

Now, I am confused about the rules :(

Upon reviewing the glibc code for handling this:
https://elixir.bootlin.com/glibc/glibc-2.41.9000/source/sysdeps/unix/sysv/linux/aarch64/clone.S#L52

It's evident that when the stack pointer is set to NULL, the aligned stack
pointer remains zero, leading __clone to perform a syscall error,
returning -EINVAL due to an invalid argument.

In summary, memory space for the child's stack must be explicitly allocated,
and a valid pointer must be passed to clone() regardless of the use of
CLONE_VM.

> Will

Thanks.
Shuai


