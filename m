Return-Path: <linux-kselftest+bounces-12530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFB39140D2
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 05:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403551F22FC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 03:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7635F525E;
	Mon, 24 Jun 2024 03:25:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1DDE567;
	Mon, 24 Jun 2024 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719199524; cv=none; b=nLoez9kfJW6iaO/L2AKlyPqotm/5q5ISdUlaawlnFz0bd6cnLAUaAoJv6xEAe7vf/Wr/PO2NyRsxwZ7do+qZhkyCroHUJlQ+tT/iWjQRNzmyZN9rwuyzJ1HjqlTKDQkmTWSV8mZg5zZgd4CbSV/1VAe4QZjO7cy26Ij0ZlVE/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719199524; c=relaxed/simple;
	bh=jb3bS6DrnYOQLupVBlBLo902qLSL4pSPAqbpX27JI30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6rhLpbfZJCfBSgQ9spcuo01zwKTZgN7mlpxgnOhv9CsMuvG/7K/ZkzhYuT7qYwIlNyflxtjjAVHNErAaX9BIS+hOUuJ8lbHquu0vBmHh3KYXiz9eVeAASYrlVRgn1aTMMVWsFfqe/HjyWVmQ5MIL1XrZsDqYTi81hewq+nU7dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.12.218] (unknown [180.110.114.157])
	by APP-05 (Coremail) with SMTP id zQCowACnr+f65nhmYYxzEg--.23125S2;
	Mon, 24 Jun 2024 11:24:43 +0800 (CST)
Message-ID: <8ee88532-0aad-4e57-8a91-e5d12cf86335@iscas.ac.cn>
Date: Mon, 24 Jun 2024 11:24:42 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] riscv: selftests: Add a ptrace test to check a0
 of restarted syscall
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, oleg@redhat.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, andy.chiu@sifive.com,
 shuah@kernel.org
References: <cover.1718693532.git.zhouquan@iscas.ac.cn>
 <b5fbdd3417e925dbe5db4716e51ce49d21d27f2f.1718693532.git.zhouquan@iscas.ac.cn>
 <ZnOaBeNnNpvrE5ss@ghost> <909f2c3d-9992-4515-996b-35a17725701b@iscas.ac.cn>
 <ZnXgfQ/19eCRT33y@ghost>
Content-Language: en-US
From: Quan Zhou <zhouquan@iscas.ac.cn>
In-Reply-To: <ZnXgfQ/19eCRT33y@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnr+f65nhmYYxzEg--.23125S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr13Xw4kCr1rKryUWF1rJFb_yoW3uw18pF
	W8CFnrKF4kJF47tw4Iqr4avF1Fyw45Ary7G340gw1rAr4vyry3tr4Iqa4UJrsxA392gayI
	vFWFv3y3C398ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JV
	WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU23C7UUUUU
X-CM-SenderInfo: 52kr31xxdqqxpvfd2hldfou0/1tbiBgwSBmZ42OQu+QAAsr

On 2024/6/22 04:20, Charlie Jenkins wrote:
> On Fri, Jun 21, 2024 at 02:29:07PM +0800, Quan Zhou wrote:
>>
>>
>> On 2024/6/20 10:55, Charlie Jenkins wrote:
>>> On Wed, Jun 19, 2024 at 10:01:47AM +0800, zhouquan@iscas.ac.cn wrote:
>>>> From: Quan Zhou <zhouquan@iscas.ac.cn>
>>>>
>>>> This test creates two processes: a tracer and a tracee. The tracer actively
>>>> sends a SIGUSR1 signal in user mode to interrupt the read syscall being
>>>> executed by the tracee. We will reset a0/orig_a0 and then observe the value
>>>> of a0 held by the restarted read syscall.
>>>
>>> I don't quite follow what the goal of this test is. With orig_a0 being
>>> added to the previous patch for ptrace, a more constrained test could
>>> ensure that this value is respected.
>>>
>>
>> Sry, I may not have described the patch clearly enough. This patch provides
>> a channel for modifying a0 in user-space ptrace via orig_a0. Here, I will
>> try to outline the whole situation:
>>
>> 1、When the tracer calls ptrace to modify regs->a0, can the tracee's a0 be
>> correctly modified?
>>
>> Through testing, if the user only modifies regs->a0, it doesn't work. Why?
>>
>> The execution flow of the tracee in the test program is as follows.Prior to
>> this explanation:
>>
>> - PTRACE_SYSCALL can make the tracee block before and after executing
>>    a syscall.
>> - The tracer sends SIGUSR1 to interrupt read, and the kernel will
>>    restart it.
>> - Please note the point marked with (*), which I believe is the cause
>>    of the issue.
>>
>> user     kernel
>>      |
>>      |
>>      |
>>       read
>>          | +-> regs->orig_a0 = regs->a0; //(*1)
>>          |                                       <=tracer:PTRACE_SYSCALL
>>          | +-> syscall_enter_from_user_mode
>>                +-> ptrace_report_syscall_entry
>>                    +-> ptrace_stop
>>          | //stopped
>>          |                                       <= tracer:SIGUSR1
>>          |
>>          | //resume                              <= tracer:PTRACE_SYSCALL
>>          | syscall_handler...
>>          |
>>          | +-> syscall_exit_to_user_mode
>>                +-> syscall_exit_to_user_mode_prepare
>>                    +-> ptrace_report_syscall_exit
>>                        +-> ptrace_stop
>>      | //stopped
>>      |
>>      | /* Change a0/orig_a0 here and observe the restarted syscall */
>>      | regs->{a0/orig_a0} = fd_zero; //(*2)
>>      | ptrace(PTRACE_SETREGSET, ...);
>>          |                                      <= tracer:PTRACE_SYSCALL
>>          | //restarting..., skip SIGUSR1
>>          |
>>          | +-> exit_to_user_mode_loop
>>                +-> arch_do_signal_or_restart
>>                    +-> /* Settings for syscall restart */
>>                        regs->a0 = regs->orig_a0; //(*3)
>>      | //stopped
>>      | //and block before the syscall again, get current regs->a0
>>      | *result = regs->a0;
>>      |
>>      | /* Now, Check regs->a0 of restarted syscall */
>>      | EXPECT_NE(0x5, result); //for PTRACE_SETREGSSET a0, failed
>>      | EXPECT_EQ(0x5, result); //for PTRACE_SETREGSSET orig_a0, succeed
>>
>> If I'm wrong, please let me know. 🙂
>>
>> 2、Actually, I discovered the issue while using the execve function.
>> When I tried to modify the first parameter of execve in the tracer,
>> I found it didn't work.
>>
>> As for why not use execve for testing, there are two reasons:
>>
>> 1) The root cause of this issue is that when a syscall is interrupted
>> and then resumed, it restarts with orig_a0 instead of a0, so modifying
>> a0 doesn't work. I want to focus the test on the "restarted syscall".
>>
>> 2) Compared to the current test scenario, execve is terminated by ptrace
>> earlier, so I chose a later point. In fact, setting regs->a0 in the path
>> between (*1) and (*3) is ineffective because it will eventually be
>> overwritten by orig_a0, correct?
> 
> Thank you for the thorough explanation! I feel like a test case like the
> following achieves the same goal but without needing the pipes and the
> file. What do you think?
> 
>>From 5f13cdf8f7312b2b3cc98fbfbb3c95fcef62c0f0 Mon Sep 17 00:00:00 2001
> From: Charlie Jenkins <charlie@rivosinc.com>
> Date: Fri, 21 Jun 2024 12:58:29 -0700
> Subject: [PATCH] riscv: selftests: Add a ptrace test to check a0 of restarted
>   syscall
> 
> Add a riscv selftest that checks that a0 of syscalls are able to be
> replaced. When entering a syscall, a0 contains the first argument to the
> syscall and upon exiting, a0 contains the return value. To replace the
> a0 argument instead of the a0 return value with ptrace after halting the
> program with PTRACE_SYSCALL, orig_a0 must be used. This test checks that
> orig_a0 allows a syscall argument to be modified, and that changing a0
> does not change the syscall argument.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>   .../riscv/abi/ptrace_restart_syscall.c        | 123 ++++++++++++++++++
>   1 file changed, 123 insertions(+)
>   create mode 100644 tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c
> 
> diff --git a/tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c b/tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c
> new file mode 100644
> index 000000000000..e74ae02c6850
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <sys/ptrace.h>
> +#include <sys/stat.h>
> +#include <sys/user.h>
> +#include <sys/wait.h>
> +#include <sys/uio.h>
> +#include <linux/elf.h>
> +#include <linux/unistd.h>
> +#include <asm/ptrace.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +#define DEFAULT_A0		0x6
> +
> +#define ORIG_A0_AFTER_MODIFIED  0x5
> +#define MODIFY_A0               0x01
> +#define MODIFY_ORIG_A0          0x02
> +
> +#define perr_and_exit(fmt, ...) do {			\
> +	char buf[256];					\
> +	snprintf(buf, sizeof(buf), "%s:%d: " fmt ": %m\n",	\
> +			__func__, __LINE__, ##__VA_ARGS__);	\
> +	perror(buf);						\
> +	exit(-1);						\
> +} while (0)
> +
> +static inline void resume_and_wait_tracee(pid_t pid, int flag)
> +{
> +	int status;
> +
> +	if (ptrace(flag, pid, 0, 0))
> +		perr_and_exit("failed to resume the tracee %d\n", pid);
> +
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> +}
> +
> +static void ptrace_restart_syscall(int opt, int *result)
> +{
> +	int status;
> +	pid_t pid;
> +
> +	struct user_regs_struct regs;
> +	struct iovec iov = {
> +		.iov_base = &regs,
> +		.iov_len = sizeof(regs),
> +	};
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		/* Mark oneself being traced */
> +		long val = ptrace(PTRACE_TRACEME, 0, 0, 0);
> +		if (val)
> +			perr_and_exit("failed to request for tracer to trace me: %ld\n", val);
> +
> +		kill(getpid(), SIGSTOP);
> +
> +		/* Perform exit syscall that will be intercepted */
> +		exit(DEFAULT_A0);
> +	} else if (pid < 0) {
> +		exit(1);
> +	}
> +
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> +
> +	/* Stop at the entry point of the restarted syscall */
> +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> +
> +	/* Now, check regs.a0 of the restarted syscall */
> +	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
> +		perr_and_exit("failed to get tracee registers\n");
> +
> +	/* Modify a0/orig_a0 for the restarted syscall */
> +	switch (opt) {
> +	case MODIFY_A0:
> +		regs.a0 = ORIG_A0_AFTER_MODIFIED;
> +		break;
> +	case MODIFY_ORIG_A0:
> +		regs.orig_a0 = ORIG_A0_AFTER_MODIFIED;
> +		break;
> +	}
> +
> +	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
> +		perr_and_exit("failed to set tracee registers\n");
> +
> +	/* Resume the tracee */
> +	ptrace(PTRACE_CONT, pid, 0, 0);
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee\n");
> +
> +	*result = WEXITSTATUS(status);
> +}
> +
> +TEST(ptrace_modify_a0)
> +{
> +	int result;
> +
> +	ptrace_restart_syscall(MODIFY_A0, &result);
> +
> +	/* The tracer's modification of a0 cannot affect the restarted tracee */
> +	EXPECT_EQ(DEFAULT_A0, result);
> +}
> +
> +TEST(ptrace_modify_orig_a0)
> +{
> +	int result;
> +
> +	ptrace_restart_syscall(MODIFY_ORIG_A0, &result);
> +
> +	/* The tracer must modify orig_a0 to actually change the tracee's a0 */
> +	EXPECT_EQ(ORIG_A0_AFTER_MODIFIED, result);
> +}
> +
> +TEST_HARNESS_MAIN

Great, this test can reflect issues more concisely compared to the 
previous one. I will update it in the next PATCH.

Thanks a lot!


