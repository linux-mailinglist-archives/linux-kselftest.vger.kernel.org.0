Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B0347CDD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 09:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbhLVIEk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 03:04:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:21394 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233159AbhLVIEk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 03:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640160280; x=1671696280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y7scDPULWRfWlt9xoVIYTtc4qPgqKGuK4ikeOefHq/Y=;
  b=FSVuIPCwT6K1paPafzqskJnj6nhoERaz0JtHRIdk21bkkl+70YR6EmlW
   5rLTklZQAgLqAjCmanGiE8K+C1oWSJzrwszZIh9yXzTWtTOEG+MAvNeFB
   Fmsq6WQotsZoruvZ2qpMbofHiVGWylgtR7RGmwlcCHTfnGoomeAFqp6KK
   y+BC893zbA54ZUjNAQIfOnRWl3u7HNFRS2PUkhxNETpVw4nugoL9jctXj
   pwvAx1Vm4f7zo1nf1pGU6xvBNbLkb+h9kLhytlkEFk48xLh6IRCmMKLEP
   Hx2QTf+0nYSFWvtgaZ2rXyG6UV6MnEh4r8Zst5yzgye7LRGzUbcjefedK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="227866505"
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="227866505"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 00:04:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="484679791"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga002.jf.intel.com with ESMTP; 22 Dec 2021 00:04:36 -0800
Date:   Wed, 22 Dec 2021 16:05:35 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Heng Su <heng.su@intel.com>,
        Hansen Dave <dave.hansen@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v6 2/2] selftests/x86: add xsave test related to
 process switching
Message-ID: <YcLcT2tOqZS0gGbg@xpf.sh.intel.com>
References: <cover.1640052713.git.pengfei.xu@intel.com>
 <153cbbb0279d99d454b06393c19e541fba44d4cd.1640052713.git.pengfei.xu@intel.com>
 <302d8316-20f4-a18d-ca04-d797b7d8be88@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <302d8316-20f4-a18d-ca04-d797b7d8be88@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 2021-12-21 at 11:05:03 -0700, Shuah Khan wrote:
> On 12/20/21 8:22 PM, Pengfei Xu wrote:
> > It will change FPU, SSE(XMM), AVX2(YMM), AVX512, PKRU xstates before process
> > switching test to ensure that these xstates have been tested.
> > In order to ensure that the content of xstates is not affected across process
> > switching, this case tests that:
> > 1. The xstates content of the child process should be the same as that of the
> >     parent process.
> > 2. The xstates content of the process should be the same across process
> >     switching.
> > 
> > Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> > ---
> >   tools/testing/selftests/x86/Makefile          |   3 +-
> >   tools/testing/selftests/x86/xsave_fork_test.c | 117 ++++++++++++++++++
> >   2 files changed, 119 insertions(+), 1 deletion(-)
> >   create mode 100644 tools/testing/selftests/x86/xsave_fork_test.c
> > 
> > diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> > index a9e452b65ba2..049f8ffb2742 100644
> > --- a/tools/testing/selftests/x86/Makefile
> > +++ b/tools/testing/selftests/x86/Makefile
> > @@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
> >   			test_FCMOV test_FCOMI test_FISTTP \
> >   			vdso_restorer
> >   TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
> > -			corrupt_xstate_header amx xsave_signal_handle
> > +			corrupt_xstate_header amx xsave_signal_handle xsave_fork_test
> >   # Some selftests require 32bit support enabled also on 64bit systems
> >   TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
> > @@ -106,3 +106,4 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
> >   $(OUTPUT)/check_initial_reg_state_32: CFLAGS += -Wl,-ereal_start -static
> >   $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
> >   $(OUTPUT)/xsave_signal_handle_64: CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku
> > +$(OUTPUT)/xsave_fork_test_64: CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku
> > diff --git a/tools/testing/selftests/x86/xsave_fork_test.c b/tools/testing/selftests/x86/xsave_fork_test.c
> > new file mode 100644
> > index 000000000000..507334e25eba
> > --- /dev/null
> > +++ b/tools/testing/selftests/x86/xsave_fork_test.c
> > @@ -0,0 +1,117 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * It's used for XSAVE test with process switching.
> 
> Add text from your change log here - more details on what this test
> for will be helpful.
> 
  Thanks very much for suggestion, I will add detailed description from
  change log in comments.

> > + */
> > +
> > +#define _GNU_SOURCE
> > +
> > +#include <stdio.h>
> > +#include <stdint.h>
> > +#include <string.h>
> > +#include <sys/wait.h>
> > +#include <unistd.h>
> > +#include <sched.h>
> > +#include <sys/syscall.h>
> > +
> > +#include "xsave_common.h"
> > +
> > +void *aligned_alloc(size_t alignment, size_t size);
> > +static unsigned char *xsave_buf0, *xsave_buf1, *xsave_buf2;
> > +static int xsave_size;
> > +
> > +void prepare_environment(void)
> > +{
> > +	xsave_size = get_xsave_size();
> > +	printf("XSAVE_TEST_MASK:0x%x, xsave size:0x%x\n",
> > +		XSAVE_TEST_MASK, xsave_size);
> > +	check_cpu_capability();
> > +
> > +	/* SDM XSAVE: misalignment to a 64-byte boundary will result in #GP */
> > +	xsave_buf0 = aligned_alloc(64, xsave_size);
> > +	if (!xsave_buf0)
> > +		execution_failed("aligned_alloc xsave_buf0 failed\n");
> > +	xsave_buf1 = aligned_alloc(64, xsave_size);
> > +	if (!xsave_buf1)
> > +		execution_failed("aligned_alloc xsave_buf1 failed\n");
> > +	xsave_buf2 = aligned_alloc(64, xsave_size);
> > +	if (!xsave_buf2)
> > +		execution_failed("aligned_alloc xsave_buf2 failed\n");
> > +}
> > +
> > +/* Use fork to create pid and trigger process switch test */
> > +int test_xsave_fork(void)
> > +{
> > +	pid_t child, grandchild;
> > +	int status, result[2];
> > +	const char *test_xsave_child = "Child xstate was same as parent";
> > +	const char *test_process_switch = "Xstate after the process switch didn't change";
> > +	uint32_t ui32_change = 0xffff0000;
> > +
> > +	populate_xstate_regs();
> > +	xsave(xsave_buf0, XSAVE_TEST_MASK);
> > +	child = syscall(SYS_fork);
> > +	if (child < 0)
> > +		execution_failed("fork failed\n");
> 
> Please use strerr() instead so we know why fork() failed?
> Same comment on all other error messages. Use strerror() so
> we know why syscalls failed.
> 
> So this would be the change you would make to execution_failed()
> and pass in the strerror()
> 
> 
  Thanks very much for suggestion!
  Yes, I should add  errno, strerror(errno) into failed reason.
  I will add it like as follows:
"
int execution_failed(char *reason, ...)
{
	printf("FAIL:errno=%d, %s, %s", errno, strerror(errno), reason);
	err_num++;

	return 1;
}
"

> > +	if (child == 0) {
> > +		xsave(xsave_buf1, XSAVE_TEST_MASK);
> > +		result[0] = compare_xsave_buf(xsave_buf0, xsave_buf1, xsave_size,
> > +			test_xsave_child, NO_CHANGE);
> > +
> > +		/*
> > +		 * If above case is failed and prints some failed reason, in
> 
> NIT: "If the above case fails, print reason for failure
  Thanks, I will fix it as suggestion.

> > +		 * order to avoid libc printf change and clean up some xstates,
> > +		 * populate xstates again for next test
> 
> This is not very clear. Is this for avoiding cleanup? What are "some xstates"?
> 
  Yes, it's not very clear, if printf could not use sse(added -mno-sse),
  printf will clean xmm registers by "vzeroupper(clean YMM,ZMM, XMM is included
  in YMM)" in function
  __strlen_avx2:
"
...
   0x00007ffff7f1a810 <+272>:   f3 0f bc c0     tzcnt  %eax,%eax
   0x00007ffff7f1a814 <+276>:   48 01 f8        add    %rdi,%rax
   0x00007ffff7f1a817 <+279>:   48 29 d0        sub    %rdx,%rax
=> 0x00007ffff7f1a81a <+282>:   c5 f8 77        vzeroupper
"

  I will improve it as follow if there is no comments:
"
If the above case fails, print reason for failure, and then xstate like xmm,
ymm would be cleared by vzeroupper in printf(-mnosse), so populate xstates for
next test case, otherwise, xmm and ymm xstate is all 0, there is no guarantee
that xmm, ymm will be restored as expected.
"

> > +		 */
> > +		populate_xstate_regs();
> > +		xsave(xsave_buf1, XSAVE_TEST_MASK);
> > +
> > +		/* fork grandchild will trigger process switching in child */
> > +		grandchild = syscall(SYS_fork);
> > +		if (grandchild == 0) {
> > +			printf("Grandchild pid:%d change it's own xstates\n", getpid());
> > +			change_xstate(ui32_change);
> > +			return 0;
> > +		}
> > +		if (grandchild) {
> > +			if (waitpid(grandchild, &status, 0) != grandchild || !WIFEXITED(status))
> > +				printf("[FAIL]:Grandchild exit with error, status:0x%x\n",
> > +					status);
> > +		}
> > +		/* After switch back to child process and check xstate */
> > +		xsave(xsave_buf2, XSAVE_TEST_MASK);
> > +		result[1] = compare_xsave_buf(xsave_buf1, xsave_buf2, xsave_size,
> > +			test_process_switch, NO_CHANGE);
> > +		printf("Child pid:%d check xstate after swtich back\n",
> > +			getpid());
> > +
> > +		check_result(result[0], test_xsave_child);
> > +		check_result(result[1], test_process_switch);
> > +		printf("Xstate in process switch test pass[%d/%d], err_num:%d\n",
> > +			pass_num, case_num, err_num);
> > +
> > +		return 0;
> > +	}
> > +
> > +	if (child) {
> > +		if (waitpid(child, &status, 0) != child || !WIFEXITED(status))
> > +			printf("[FAIL]:Child exit with error, status:0x%x\n",
> > +				status);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int main(void)
> > +{
> > +	cpu_set_t set;
> > +
> > +	case_num = 2;
> > +	CPU_ZERO(&set);
> > +	CPU_SET(0, &set);
> > +	sched_setaffinity(getpid(), sizeof(set), &set);
> > +
> > +	prepare_environment();
> > +	test_xsave_fork();
> > +
> > +	return 0;
> > +}
> > 
> 
> thanks,
> -- Shuah
