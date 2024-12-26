Return-Path: <linux-kselftest+bounces-23751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 222929FCA70
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 12:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 306BE7A1465
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 11:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF4A1BC9FE;
	Thu, 26 Dec 2024 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="osJQTCRB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b1+5zgYw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A39714D708;
	Thu, 26 Dec 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735211101; cv=none; b=f0xkl2YkTuRGEyGEj30Tdo/lgzmfzQe6b9izHBY1VFSMipHlqik4hqZTo63egEuVmCV30s+iATJmSY+iBUbWMq8o3C9k9geTnK4Fvz972mQVv/qhOGD+tnuQ3HfqknTBBrGZOuSCIpD3e4qgIg7pF/S4Ft0TmkwW1jbOOu3kwRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735211101; c=relaxed/simple;
	bh=IQCK+MYHcLU/beGqxyJx3BZxy515asaS8PLgnTvs8qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHODjMEneN4dQN06xdiMIyZhpdCTz0pyiY+xhv4QAUlnZTBcMAc/x9mfYNDWqDXJnfyxh8vo/LWkCRFjvcDhWYs5vUgl6mlkuBSv4zNAnC8OrSUqYsqOa5GXQ6Ihga6ctWbdVA8OsxmU/DSPy4ufQUfJesG1+8/1WpoXKOZeDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=osJQTCRB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b1+5zgYw; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 705222002C3;
	Thu, 26 Dec 2024 06:04:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 26 Dec 2024 06:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1735211098; x=1735218298; bh=PZ1yD1zFxi
	j2IMu4FxJMiGtPa+gds2YF5EDXDrbqMws=; b=osJQTCRBMvc3BenT7MsTtuGwzd
	mdlomsiYxZU1dqBKICcLhVjFTjwVkVWpFUyeSJBr62k+6dLJqMjPeTv1IaQf11hZ
	zb5Niaq6SfqD50qmjItKyZ53A30vR/gU7BAuQPPjyL6o6bSRHUNU818nhFBlxCh9
	lEnlektWTwnmCk7RKuLXak5vLClgcAfhKDHc1wHBD6pp+/zwi6zFGCAjzEJUgAye
	rVnEj+RUcvv4jH4KXymUWyavVMh11fB6N7J0XnVB1zOvprPRFpH9i7BzXUt8wJyO
	zmC2OLSdGldxIKLmLDL6V9u4cLpjDoX1TUuo7Yd2PW5HlWHl1A2Ad4hx7F4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735211098; x=
	1735218298; bh=PZ1yD1zFxij2IMu4FxJMiGtPa+gds2YF5EDXDrbqMws=; b=b
	1+5zgYwThmA5dkNo4UfeRI7VkKuyZMcwX02fcdem1krLniH3RzsNGnolqq7fIS86
	shU7bz1Fg2O700dDErGvgMnRYTfoynqtyx+Jh6VbqAWZ6VDLekXVPz2VN58Jumpm
	+nj2+JGeKHqIh/6g9EenFGeM/bbFNpZBs2DLHAQR21B1f3g+shp8L8ttdj84fTeD
	Rail5B9CsAJsMxVFDG1SXI7L/16vTYEk4T3HECqJYStY9dTI44/+vLIxSq5i/zl6
	Sl8zq8qEtF5tfQ83h6i9M7TKqBeQeH2b/yMdIrTrMF7rTC9GLSy5QsJCZw/GI1nG
	Y69ncP1+6BEvb3Vin2QYw==
X-ME-Sender: <xms:WThtZyJHmWg4OAXcCc13PRPBD0vv1qcU_r5D55kIhC4Fi0VKPCz3zA>
    <xme:WThtZ6LxeZYq7rV0LZTtl27RCj8wgBcr-DAJdDI04AVcR3T64s-kDaKPHrwVrGod_
    bGkAFytBPiMVOh31l8>
X-ME-Received: <xmr:WThtZyvGu9URJHWGrtpPxQMKZobzgdrgW52wP9H3hbCKwOApQB5Uhb2rRXZJuEXZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeevvghlvghsthgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuh
    hsrdhnrghmvgeqnecuggftrfgrthhtvghrnhepfefgvdfgteevveekheelffetkedvhfev
    vdehudeuheekvdeuvdfhieeijedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgdp
    nhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthh
    grrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopegrjhhonhgvshesvhgv
    nhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtohepohhlvghgsehrvgguhhgrthdrtg
    homhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdp
    rhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegroh
    husegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohepvggsihgvuggvrhhm
    seigmhhishhsihhonhdrtghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WThtZ3ZuhfM5GOJB0InXKoXyjWRfdsRiz2zCy-oxRMJk8KsIdDEXgg>
    <xmx:WThtZ5bQGfY_f6CdjP093L9fawiqWGi2sWXQMYs8TMi82Va-6eyEQw>
    <xmx:WThtZzAwk9l_Lcgp8QxEux4qQoJ80XZPhcz2WALwYZRcdIcxYHlA6Q>
    <xmx:WThtZ_Y11F_US0Vit8PA2tNEy8IPo0sN-cmlDG_QH-aNATusaiWyEw>
    <xmx:WjhtZ1Nue3veWGbEsMJ_pGBX6EJu9tHJLEEB94HeqDzK8iaWHFOcWhbk>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 06:04:50 -0500 (EST)
Message-ID: <75877caa-1c29-4a85-9e09-f4a37114f58d@coelacanthus.name>
Date: Thu, 26 Dec 2024 19:04:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] riscv: selftests: Add a ptrace test to verify
 syscall parameter modification
Content-Language: en-GB-large
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, Oleg Nesterov <oleg@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
 "Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>,
 Quan Zhou <zhouquan@iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241203-riscv-new-regset-v2-0-d37da8c0cba6@coelacanthus.name>
 <20241203-riscv-new-regset-v2-2-d37da8c0cba6@coelacanthus.name>
 <20241203-55c76715e16422ddaf8d7edf@orel> <Z2RlR1cP9tne8rNi@ghost>
 <50a62291-5ae1-47b0-8f64-a42271820789@coelacanthus.name>
 <Z2SR86wpB5waLtx-@ghost>
From: Celeste Liu <uwu@coelacanthus.name>
In-Reply-To: <Z2SR86wpB5waLtx-@ghost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2024-12-20 05:36, Charlie Jenkins wrote:
> On Fri, Dec 20, 2024 at 05:29:45AM +0800, Celeste Liu wrote:
>>
>> On 2024-12-20 02:26, Charlie Jenkins wrote:
>>> On Tue, Dec 03, 2024 at 01:55:07PM +0100, Andrew Jones wrote:
>>>> On Tue, Dec 03, 2024 at 05:30:05PM +0800, Celeste Liu wrote:
>>>>> From: Charlie Jenkins <charlie@rivosinc.com>
>>>>>
>>>>> This test checks that orig_a0 allows a syscall argument to be modified,
>>>>> and that changing a0 does not change the syscall argument.
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
>>>>> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
>>>>> Co-developed-by: Celeste Liu <uwu@coelacanthus.name>
>>>>> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
>>>>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>>>>> ---
>>>>>  tools/testing/selftests/riscv/abi/.gitignore |   1 +
>>>>>  tools/testing/selftests/riscv/abi/Makefile   |   5 +-
>>>>>  tools/testing/selftests/riscv/abi/ptrace.c   | 134 +++++++++++++++++++++++++++
>>>>>  3 files changed, 139 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/riscv/abi/.gitignore b/tools/testing/selftests/riscv/abi/.gitignore
>>>>> index b38358f91c4d2240ae64892871d9ca98bda1ae58..378c605919a3b3d58eec2701eb7af430cfe315d6 100644
>>>>> --- a/tools/testing/selftests/riscv/abi/.gitignore
>>>>> +++ b/tools/testing/selftests/riscv/abi/.gitignore
>>>>> @@ -1 +1,2 @@
>>>>>  pointer_masking
>>>>> +ptrace
>>>>> diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
>>>>> index ed82ff9c664e7eb3f760cbab81fb957ff72579c5..3f74d059dfdcbce4d45d8ff618781ccea1419061 100644
>>>>> --- a/tools/testing/selftests/riscv/abi/Makefile
>>>>> +++ b/tools/testing/selftests/riscv/abi/Makefile
>>>>> @@ -2,9 +2,12 @@
>>>>>  
>>>>>  CFLAGS += -I$(top_srcdir)/tools/include
>>>>>  
>>>>> -TEST_GEN_PROGS := pointer_masking
>>>>> +TEST_GEN_PROGS := pointer_masking ptrace
>>>>>  
>>>>>  include ../../lib.mk
>>>>>  
>>>>>  $(OUTPUT)/pointer_masking: pointer_masking.c
>>>>>  	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
>>>>> +
>>>>> +$(OUTPUT)/ptrace: ptrace.c
>>>>> +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
>>>>> diff --git a/tools/testing/selftests/riscv/abi/ptrace.c b/tools/testing/selftests/riscv/abi/ptrace.c
>>>>> new file mode 100644
>>>>> index 0000000000000000000000000000000000000000..d192764b428d1f1c442f3957c6fedeb01a48d556
>>>>> --- /dev/null
>>>>> +++ b/tools/testing/selftests/riscv/abi/ptrace.c
>>>>> @@ -0,0 +1,134 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>> +#include <stdio.h>
>>>>> +#include <stdlib.h>
>>>>> +#include <string.h>
>>>>> +#include <unistd.h>
>>>>> +#include <fcntl.h>
>>>>> +#include <signal.h>
>>>>> +#include <errno.h>
>>>>> +#include <sys/types.h>
>>>>> +#include <sys/ptrace.h>
>>>>> +#include <sys/stat.h>
>>>>> +#include <sys/user.h>
>>>>> +#include <sys/wait.h>
>>>>> +#include <sys/uio.h>
>>>>> +#include <linux/elf.h>
>>>>> +#include <linux/unistd.h>
>>>>> +#include <asm/ptrace.h>
>>>>> +
>>>>> +#include "../../kselftest_harness.h"
>>>>> +
>>>>> +#define ORIG_A0_MODIFY      0x01
>>>>> +#define A0_MODIFY           0x02
>>>>> +#define A0_OLD              0x03
>>>>> +#define A0_NEW              0x04
>>>>
>>>> Shouldn't A0_OLD and A0_NEW set more bits, since 3 and 4 aren't very
>>>> unique (we could have those values by accident)? And should we include
>>>> setting bits over 31 for 64-bit targets?
>>>>
>>>>> +
>>>>> +#define perr_and_exit(fmt, ...)						\
>>>>> +	({								\
>>>>> +		char buf[256];						\
>>>>> +		snprintf(buf, sizeof(buf), "%s:%d:" fmt ": %m\n",	\
>>>>> +			__func__, __LINE__, ##__VA_ARGS__);		\
>>>>> +		perror(buf);						\
>>>>> +		exit(-1);						\
>>>>> +	})
>>>>
>>>> Can we use e.g. ksft_exit_fail_perror() instead? I'd prefer we try to
>>>> consolidate testing/selftests/riscv/* tests on a common format for
>>>> errors and exit codes and we're already using other kselftest stuff.
>>>>
>>>>> +
>>>>> +static inline void resume_and_wait_tracee(pid_t pid, int flag)
>>>>> +{
>>>>> +	int status;
>>>>> +
>>>>> +	if (ptrace(flag, pid, 0, 0))
>>>>> +		perr_and_exit("failed to resume the tracee %d\n", pid);
>>>>> +
>>>>> +	if (waitpid(pid, &status, 0) != pid)
>>>>> +		perr_and_exit("failed to wait for the tracee %d\n", pid);
>>>>> +}
>>>>> +
>>>>> +static void ptrace_test(int opt, int *result)
>>>>> +{
>>>>> +	int status;
>>>>> +	pid_t pid;
>>>>> +	struct user_regs_struct regs;
>>>>> +	struct iovec iov = {
>>>>> +		.iov_base = &regs,
>>>>> +		.iov_len = sizeof(regs),
>>>>> +	};
>>>>> +
>>>>> +	unsigned long orig_a0;
>>>>> +	struct iovec a0_iov = {
>>>>> +		.iov_base = &orig_a0,
>>>>> +		.iov_len = sizeof(orig_a0),
>>>>> +	};
>>>>> +
>>>>> +	pid = fork();
>>>>> +	if (pid == 0) {
>>>>> +		/* Mark oneself being traced */
>>>>> +		long val = ptrace(PTRACE_TRACEME, 0, 0, 0);
>>>>> +
>>>>> +		if (val)
>>>>> +			perr_and_exit("failed to request for tracer to trace me: %ld\n", val);
>>>>> +
>>>>> +		kill(getpid(), SIGSTOP);
>>>>> +
>>>>> +		/* Perform exit syscall that will be intercepted */
>>>>> +		exit(A0_OLD);
>>>>> +	}
>>>>> +
>>>>> +	if (pid < 0)
>>>>> +		exit(1);
>>>>
>>>> This unexpected error condition deserves a message, so I'd use
>>>> ksft_exit_fail_perror() here.
>>>>
>>>>> +
>>>>> +	if (waitpid(pid, &status, 0) != pid)
>>>>> +		perr_and_exit("failed to wait for the tracee %d\n", pid);
>>>>> +
>>>>> +	/* Stop at the entry point of the syscall */
>>>>> +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
>>>>> +
>>>>> +	/* Check tracee regs before the syscall */
>>>>> +	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
>>>>> +		perr_and_exit("failed to get tracee registers\n");
>>>>> +	if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
>>>>> +		perr_and_exit("failed to get tracee registers\n");
>>>>> +	if (orig_a0 != A0_OLD)
>>>>> +		perr_and_exit("unexpected orig_a0: 0x%lx\n", orig_a0);
>>>>> +
>>>>> +	/* Modify a0/orig_a0 for the syscall */
>>>>> +	switch (opt) {
>>>>> +	case A0_MODIFY:
>>>>> +		regs.a0 = A0_NEW;
>>>>> +		break;
>>>>> +	case ORIG_A0_MODIFY:
>>>>> +		orig_a0 = A0_NEW;
>>>>> +		break;
>>>>> +	}
>>>>> +
>>>>> +	if (ptrace(PTRACE_SETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
>>>>> +		perr_and_exit("failed to set tracee registers\n");
>>>>> +
>>>>> +	/* Resume the tracee */
>>>>> +	ptrace(PTRACE_CONT, pid, 0, 0);
>>>>> +	if (waitpid(pid, &status, 0) != pid)
>>>>> +		perr_and_exit("failed to wait for the tracee\n");
>>>>> +
>>>>> +	*result = WEXITSTATUS(status);
>>>>> +}
>>>>> +
>>>>> +TEST(ptrace_modify_a0)
>>>>> +{
>>>>> +	int result;
>>>>> +
>>>>> +	ptrace_test(A0_MODIFY, &result);
>>>>> +
>>>>> +	/* The modification of a0 cannot affect the first argument of the syscall */
>>>>> +	EXPECT_EQ(A0_OLD, result);
>>>>
>>>> What about checking that we actually set regs.a0 to A0_NEW? We'd need
>>>> A0_NEW to be more unique than 4, though.
>>>>
>>>>> +}
>>>>> +
>>>>> +TEST(ptrace_modify_orig_a0)
>>>>> +{
>>>>> +	int result;
>>>>> +
>>>>> +	ptrace_test(ORIG_A0_MODIFY, &result);
>>>>> +
>>>>> +	/* Only modify orig_a0 to change the first argument of the syscall */
>>>>
>>>> If we run ptrace_modify_a0 first then we've already set regs.a0 to A0_NEW
>>>> and can't check with this test that we don't set it to A0_NEW. We should
>>>> probably have two different test values, one for regs.a0 and one for
>>>> orig_a0 and ensure on both tests that we aren't writing both.
>>>>
>>>
>>> Celeste, do you want to fix this up or are you waiting for me to?
>>
>> Sorry for delay. I was busy with household affairs in the past few weeks.
>> v3 will be sent tomorrow or the day after tomorrow.
>>
>> I am deeply sorry for this.
> 
> No need to apologize! Just wanted to make sure you weren't expected me
> to update the test :)
> 
> - Charlie
> 
>>
>>>
>>> - Charlie
>>>
>>>>> +	EXPECT_EQ(A0_NEW, result);
>>>>> +}
>>>>> +
>>>>> +TEST_HARNESS_MAIN
>>>>>
>>>>> -- 
>>>>> 2.47.0
>>>>>
>>>>
>>>> Thanks,
>>>> drew
>>

v4 has been sent.


