Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714B547C5AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 19:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbhLUSFF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 13:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbhLUSFE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 13:05:04 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B528CC06173F
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 10:05:04 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id k21so18808957ioh.4
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 10:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2KBUDdoRqlu/SZ5CeTfBXhMozIYnYHZYo4dC8l6msck=;
        b=H2g7WDpsJDPm+DpELquDvVCm8MtFH9QEtGg2H6S2lTituJcZvARPS2IbaS9n+fKSGB
         UXTOhFOg+HgZzn9EpXywm16u4tvaI9cqRIuPTQCWTrCMQebGLoxkS1vikpKhEP4fX6Le
         bmiap7Sge2P691gD25AE1PLNRfiMMdAJMUvwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2KBUDdoRqlu/SZ5CeTfBXhMozIYnYHZYo4dC8l6msck=;
        b=ZT+8X95LYCDd8EQCr1qOrv18zZwtiayanSZWlDmV3Xsb88Y5GF3Nm4H/ysPguHPkjH
         b+4mEdB4/VQVZM39cGLVAT5nbfzVgDez/4Ma0YmkQ/A7MI3k9RsRul3PSU7PnhHWieOA
         BhmsQ8+au5bY1LG7yGBekI/SGu0tgZ1iTnqtnFRKdeYY25PNpcJFPsUXp3bJEInPgtLR
         JgfjcqgK7VDXJ03y7KEA7EmensSWncdhRjT6JG+siiD/QBSy+42ifixYcxgRrBLncFzk
         Z+vNbg53PzUotSM+TWjxB62UkzZxUUCqSFjcek05Noc7Obh7aaYGUN+MeHljcZaNBgK0
         2CrA==
X-Gm-Message-State: AOAM5329BURAlUtTxjSBaM/VlyUvVv5WrRP0P5HjPgkENmLlBmpuXyIc
        QirK2GO5f1HlVi7qzMtwtffiEw==
X-Google-Smtp-Source: ABdhPJxDxgaIHaPk7eoRUKMTGlgNHAWouZT0xScus+U4LOLGngCKhdGYDYBzOwtCYXwoP5eOBOTkfA==
X-Received: by 2002:a05:6638:24c6:: with SMTP id y6mr2608375jat.98.1640109904044;
        Tue, 21 Dec 2021 10:05:04 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q8sm12867059iow.47.2021.12.21.10.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:05:03 -0800 (PST)
Subject: Re: [RFC PATCH v6 2/2] selftests/x86: add xsave test related to
 process switching
To:     Pengfei Xu <pengfei.xu@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Heng Su <heng.su@intel.com>, Hansen Dave <dave.hansen@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1640052713.git.pengfei.xu@intel.com>
 <153cbbb0279d99d454b06393c19e541fba44d4cd.1640052713.git.pengfei.xu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <302d8316-20f4-a18d-ca04-d797b7d8be88@linuxfoundation.org>
Date:   Tue, 21 Dec 2021 11:05:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <153cbbb0279d99d454b06393c19e541fba44d4cd.1640052713.git.pengfei.xu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/20/21 8:22 PM, Pengfei Xu wrote:
> It will change FPU, SSE(XMM), AVX2(YMM), AVX512, PKRU xstates before process
> switching test to ensure that these xstates have been tested.
> In order to ensure that the content of xstates is not affected across process
> switching, this case tests that:
> 1. The xstates content of the child process should be the same as that of the
>     parent process.
> 2. The xstates content of the process should be the same across process
>     switching.
> 
> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>   tools/testing/selftests/x86/Makefile          |   3 +-
>   tools/testing/selftests/x86/xsave_fork_test.c | 117 ++++++++++++++++++
>   2 files changed, 119 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/x86/xsave_fork_test.c
> 
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index a9e452b65ba2..049f8ffb2742 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
>   			test_FCMOV test_FCOMI test_FISTTP \
>   			vdso_restorer
>   TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
> -			corrupt_xstate_header amx xsave_signal_handle
> +			corrupt_xstate_header amx xsave_signal_handle xsave_fork_test
>   # Some selftests require 32bit support enabled also on 64bit systems
>   TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
>   
> @@ -106,3 +106,4 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
>   $(OUTPUT)/check_initial_reg_state_32: CFLAGS += -Wl,-ereal_start -static
>   $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
>   $(OUTPUT)/xsave_signal_handle_64: CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku
> +$(OUTPUT)/xsave_fork_test_64: CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku
> diff --git a/tools/testing/selftests/x86/xsave_fork_test.c b/tools/testing/selftests/x86/xsave_fork_test.c
> new file mode 100644
> index 000000000000..507334e25eba
> --- /dev/null
> +++ b/tools/testing/selftests/x86/xsave_fork_test.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * It's used for XSAVE test with process switching.

Add text from your change log here - more details on what this test
for will be helpful.

> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <sched.h>
> +#include <sys/syscall.h>
> +
> +#include "xsave_common.h"
> +
> +void *aligned_alloc(size_t alignment, size_t size);
> +static unsigned char *xsave_buf0, *xsave_buf1, *xsave_buf2;
> +static int xsave_size;
> +
> +void prepare_environment(void)
> +{
> +	xsave_size = get_xsave_size();
> +	printf("XSAVE_TEST_MASK:0x%x, xsave size:0x%x\n",
> +		XSAVE_TEST_MASK, xsave_size);
> +	check_cpu_capability();
> +
> +	/* SDM XSAVE: misalignment to a 64-byte boundary will result in #GP */
> +	xsave_buf0 = aligned_alloc(64, xsave_size);
> +	if (!xsave_buf0)
> +		execution_failed("aligned_alloc xsave_buf0 failed\n");
> +	xsave_buf1 = aligned_alloc(64, xsave_size);
> +	if (!xsave_buf1)
> +		execution_failed("aligned_alloc xsave_buf1 failed\n");
> +	xsave_buf2 = aligned_alloc(64, xsave_size);
> +	if (!xsave_buf2)
> +		execution_failed("aligned_alloc xsave_buf2 failed\n");
> +}
> +
> +/* Use fork to create pid and trigger process switch test */
> +int test_xsave_fork(void)
> +{
> +	pid_t child, grandchild;
> +	int status, result[2];
> +	const char *test_xsave_child = "Child xstate was same as parent";
> +	const char *test_process_switch = "Xstate after the process switch didn't change";
> +	uint32_t ui32_change = 0xffff0000;
> +
> +	populate_xstate_regs();
> +	xsave(xsave_buf0, XSAVE_TEST_MASK);
> +	child = syscall(SYS_fork);
> +	if (child < 0)
> +		execution_failed("fork failed\n");

Please use strerr() instead so we know why fork() failed?
Same comment on all other error messages. Use strerror() so
we know why syscalls failed.

So this would be the change you would make to execution_failed()
and pass in the strerror()


> +	if (child == 0) {
> +		xsave(xsave_buf1, XSAVE_TEST_MASK);
> +		result[0] = compare_xsave_buf(xsave_buf0, xsave_buf1, xsave_size,
> +			test_xsave_child, NO_CHANGE);
> +
> +		/*
> +		 * If above case is failed and prints some failed reason, in

NIT: "If the above case fails, print reason for failure
> +		 * order to avoid libc printf change and clean up some xstates,
> +		 * populate xstates again for next test

This is not very clear. Is this for avoiding cleanup? What are "some xstates"?

> +		 */
> +		populate_xstate_regs();
> +		xsave(xsave_buf1, XSAVE_TEST_MASK);
> +
> +		/* fork grandchild will trigger process switching in child */
> +		grandchild = syscall(SYS_fork);
> +		if (grandchild == 0) {
> +			printf("Grandchild pid:%d change it's own xstates\n", getpid());
> +			change_xstate(ui32_change);
> +			return 0;
> +		}
> +		if (grandchild) {
> +			if (waitpid(grandchild, &status, 0) != grandchild || !WIFEXITED(status))
> +				printf("[FAIL]:Grandchild exit with error, status:0x%x\n",
> +					status);
> +		}
> +		/* After switch back to child process and check xstate */
> +		xsave(xsave_buf2, XSAVE_TEST_MASK);
> +		result[1] = compare_xsave_buf(xsave_buf1, xsave_buf2, xsave_size,
> +			test_process_switch, NO_CHANGE);
> +		printf("Child pid:%d check xstate after swtich back\n",
> +			getpid());
> +
> +		check_result(result[0], test_xsave_child);
> +		check_result(result[1], test_process_switch);
> +		printf("Xstate in process switch test pass[%d/%d], err_num:%d\n",
> +			pass_num, case_num, err_num);
> +
> +		return 0;
> +	}
> +
> +	if (child) {
> +		if (waitpid(child, &status, 0) != child || !WIFEXITED(status))
> +			printf("[FAIL]:Child exit with error, status:0x%x\n",
> +				status);
> +	}
> +
> +	return 0;
> +}
> +
> +int main(void)
> +{
> +	cpu_set_t set;
> +
> +	case_num = 2;
> +	CPU_ZERO(&set);
> +	CPU_SET(0, &set);
> +	sched_setaffinity(getpid(), sizeof(set), &set);
> +
> +	prepare_environment();
> +	test_xsave_fork();
> +
> +	return 0;
> +}
> 

thanks,
-- Shuah
