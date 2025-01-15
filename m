Return-Path: <linux-kselftest+bounces-24559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C844AA11E54
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 10:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA157A4298
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 09:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A30724818C;
	Wed, 15 Jan 2025 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="mVoJWykJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wixxW+Kn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C971FC7C8;
	Wed, 15 Jan 2025 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934134; cv=none; b=at1jZA9rOAWQUFqBaIcGRBSUkfHDhAgxfMiURvFse259RagDrUE1dTEa4s9cs+xlPdI47Kfe2Rb/wbvDV0wMHvjQCBPx9WoSRv+FPILEkTU4FGzNzwXJrVE1ESqvf0aUezX1WRzsQGoVKKm9Q3OG76KoPYwc/k5fWU20ULx3oDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934134; c=relaxed/simple;
	bh=jM9uAjCE9ZCH+BeFfF6HIVe3V2LTHVHuU46DqkTLWGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTM6D1lWkXAXF8/S8A8AdSsVlzmdMlOCsgX74X/DuQDlPJ+ykOJaFruyKnF8Q7vOdpPVvaZSmeHTuBcy7YEY3zlCfPEqTba19NqjaXj1oBMD7nTSd8L88E712CGzytphDG2M0XHRSEi0rgdm1sDPuMBH/mhKQoPmTw1zjjCn48M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=mVoJWykJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wixxW+Kn; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 825E2200C73;
	Wed, 15 Jan 2025 04:42:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 15 Jan 2025 04:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736934130; x=1736941330; bh=YiRbxGu1UH
	Jm8IpldfHhFbmYMUtUE+hZXcRxL0CMUCE=; b=mVoJWykJvVwY6ulcWer5cqbm6L
	NPulbUzcxq9J2RsLAKsDDOH3VOrTe66WWakovWl2mRB/SHAz+3PtMktDWlEPc/K6
	olTFyquzCnOYQf9EczbOebtLbJnamLoTSMaq7r5ZUb6kZwAN4G3N1J0nstL6qaFg
	9Ve0sKcKQ6O02oM/ZcAwdWFX7XSiwYyCa9g5qUPNGskDWhHTM7HJUijAutWrOkWq
	wFT4EZqblW/vmNoUoCWUCpoABBHXDEZDSh6B/DzgFy/+SJc6z/KV70zfR35uv41V
	bDit6x+aztrGI1FfI/sZbg2/4M9EEnu6IKKyiy8jwuGLuMTmYQQ+fHEXFW9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736934130; x=
	1736941330; bh=YiRbxGu1UHJm8IpldfHhFbmYMUtUE+hZXcRxL0CMUCE=; b=w
	ixxW+KnBVgzt8CodHWBgfKkkhveQB6iY0HmhzagaNBiXTpdlx7fGDdX1bbiEQIS8
	mkhQyp07u3etVV2xjiGTgev36m9XkoDCVkbcLFEUMGlPkhAo19pbyP5kXJ79KVbD
	VyD86rAIaLtVcaM0ohkK9R0oEJPtokKlPXngSaJurnOwH9EGaweOAU40AJIdhYFE
	UgMQ8BHdv+4NSeOh2IVhMU0PDi7axAHksZZcpavH11vaZg0Y/BwGq9OV2cXcOPmO
	R6EMMO32QrLOzXa7zHvx/3guvi6kGz2roYY/7NpFFlTFFOsSo5vFTQeb7L6m/Iln
	K9RY2ybOkiQtMF4Wq3Wvg==
X-ME-Sender: <xms:8IKHZw3n0DQKJyrGBRP69GOzteyZXDTDHTXWeo3cHBJABuWGhMFV3A>
    <xme:8IKHZ7EqerpFoP0tVT_CzNuPOxRaX1mkdQobV0zKGO-3OgKaTy8AhyxA5yi9QutlA
    KIt_tYvleAPkEjjbt0>
X-ME-Received: <xmr:8IKHZ46L6_iwZO5yBEmYwau2LN0ntsvQPWmuXX311UopsAdMM2YjurIpipDQywXP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehkedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeevvghlvghsthgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuh
    hsrdhnrghmvgeqnecuggftrfgrthhtvghrnhepfefhfeefteekgedvfeehhfefvedutedt
    fefhkeeileehgefgveffvdffudehhfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgdp
    nhgspghrtghpthhtohepvdehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrjh
    honhgvshesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtohepohhlvghgsehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfih
    hvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgt
    phhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghpthhtohepkh
    gvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtg
    hpthhtoheprghlvgigsehghhhithhirdhfrh
X-ME-Proxy: <xmx:8IKHZ51rd6uijQn6Q9471j0S-XUW60UiRxY-_ZB4SEw-1zysuUZTDA>
    <xmx:8IKHZzGkh-MMxYYiUZKWyVzOheeN6jAw6Ru4vkH0pcKu3O-mkI5e_g>
    <xmx:8IKHZy-LVxpExg-Ya_P0DJd7h0hu8EFT1Sim3MQr1FGsIh8Y5fSL9g>
    <xmx:8IKHZ4kORGLEQ3ErQ_H0kENQjQkLgqg4HITLYkSVRjQC9jKk1TJsyA>
    <xmx:8oKHZ82LT6TKD1T6jJSjvJQOY7vJNz1mRZrP0KBLpK6Ev0BT_W4410Cv>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 04:42:00 -0500 (EST)
Message-ID: <17dfb122-4ae3-477f-93a8-1748b819c59c@coelacanthus.name>
Date: Wed, 15 Jan 2025 17:41:57 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] riscv: selftests: Add a ptrace test to verify a0
 and orig_a0 access
Content-Language: en-GB-large
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>,
 Andrea Bolognani <abologna@redhat.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ron Economos <re@w6rz.net>, Charlie Jenkins <charlie@rivosinc.com>,
 Quan Zhou <zhouquan@iscas.ac.cn>, Felix Yan <felixonmars@archlinux.org>,
 Ruizhe Pan <c141028@gmail.com>, Guo Ren <guoren@kernel.org>,
 Yao Zi <ziyao@disroot.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
References: <20250115-riscv-new-regset-v5-0-d0e6ec031a23@coelacanthus.name>
 <20250115-riscv-new-regset-v5-2-d0e6ec031a23@coelacanthus.name>
 <20250115-28c95808502d43f84b3fe0a6@orel>
From: Celeste Liu <uwu@coelacanthus.name>
In-Reply-To: <20250115-28c95808502d43f84b3fe0a6@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-01-15 17:14, Andrew Jones wrote:
> On Wed, Jan 15, 2025 at 04:24:59AM +0800, Celeste Liu wrote:
>> This test checks that orig_a0 and a0 can be modified and accessed
>> independently.
>>
>> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
>> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
>> Co-developed-by: Charlie Jenkins <charlie@rivosinc.com>
>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
>> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
>> ---
>>  tools/testing/selftests/riscv/abi/.gitignore |   1 +
>>  tools/testing/selftests/riscv/abi/Makefile   |   6 +-
>>  tools/testing/selftests/riscv/abi/ptrace.c   | 201 +++++++++++++++++++++++++++
>>  3 files changed, 207 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/riscv/abi/.gitignore b/tools/testing/selftests/riscv/abi/.gitignore
>> index b38358f91c4d2240ae64892871d9ca98bda1ae58..378c605919a3b3d58eec2701eb7af430cfe315d6 100644
>> --- a/tools/testing/selftests/riscv/abi/.gitignore
>> +++ b/tools/testing/selftests/riscv/abi/.gitignore
>> @@ -1 +1,2 @@
>>  pointer_masking
>> +ptrace
>> diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
>> index ed82ff9c664e7eb3f760cbab81fb957ff72579c5..359a082c88a401883fb3776b35e4dacf69beaaaa 100644
>> --- a/tools/testing/selftests/riscv/abi/Makefile
>> +++ b/tools/testing/selftests/riscv/abi/Makefile
>> @@ -1,10 +1,14 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>>  CFLAGS += -I$(top_srcdir)/tools/include
>> +CFLAGS += $(KHDR_INCLUDES)
>>  
>> -TEST_GEN_PROGS := pointer_masking
>> +TEST_GEN_PROGS := pointer_masking ptrace
>>  
>>  include ../../lib.mk
>>  
>>  $(OUTPUT)/pointer_masking: pointer_masking.c
>>  	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
>> +
>> +$(OUTPUT)/ptrace: ptrace.c
>> +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
>> diff --git a/tools/testing/selftests/riscv/abi/ptrace.c b/tools/testing/selftests/riscv/abi/ptrace.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..f1a0458adccdd040bfaa350e2e8d98b1ef34c0ad
>> --- /dev/null
>> +++ b/tools/testing/selftests/riscv/abi/ptrace.c
>> @@ -0,0 +1,201 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include <fcntl.h>
>> +#include <signal.h>
>> +#include <errno.h>
>> +#include <sys/types.h>
>> +#include <sys/ptrace.h>
>> +#include <sys/stat.h>
>> +#include <sys/user.h>
>> +#include <sys/wait.h>
>> +#include <sys/uio.h>
>> +#include <linux/elf.h>
>> +#include <linux/unistd.h>
>> +#include <linux/ptrace.h>
>> +#include <asm/ptrace.h>
>> +
>> +#include "../../kselftest_harness.h"
>> +
>> +#ifndef sizeof_field
>> +#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
>> +#endif
>> +#ifndef offsetofend
>> +#define offsetofend(TYPE, MEMBER) \
>> +	(offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
>> +#endif
> 
> I think this is the sixth test to define these. We should copy
> include/linux/stddef.h into tools/include. We already have
> tools/include/uapi/linux/stddef.h with __struct_group and
> __DECLARE_FLEX_ARRAY, so I think it should just work.

Agreed. But it may be better to be a separate patchset
so we can change those definition in different selftests
one pass.

> 
>> +
>> +
>> +#define ORIG_A0_MODIFY      0x01
>> +#define A0_MODIFY           0x02
>> +#define A0_OLD              0xbadbeefbeeff
>> +#define A0_NEW              0xffeebfeebdab
>> +
>> +
>> +struct a0_regs {
>> +	__s64 orig_a0;
>> +	__u64 a0;
>> +};
>> +
>> +#define perr_and_exit(fmt, ...)						\
>> +	({								\
>> +		char buf[256];						\
>> +		snprintf(buf, sizeof(buf), "%s:%d:" fmt ": %m\n",	\
>> +			__func__, __LINE__, ##__VA_ARGS__);		\
>> +		ksft_exit_fail_perror(buf);				\
>> +	})
>> +
>> +static void ptrace_test(int opt, struct a0_regs result[])
>> +{
>> +	int status;
>> +	long rc;
>> +	pid_t pid;
>> +	struct user_regs_struct regs;
>> +	struct iovec iov = {
>> +		.iov_base = &regs,
>> +		.iov_len = sizeof(regs),
>> +	};
>> +
>> +	unsigned long orig_a0;
>> +	struct iovec a0_iov = {
>> +		.iov_base = &orig_a0,
>> +		.iov_len = sizeof(orig_a0),
>> +	};
>> +	struct ptrace_syscall_info syscall_info = {
>> +		.op = 0xff,
>> +	};
>> +	const unsigned int expected_sci_entry_size =
>> +		offsetofend(struct ptrace_syscall_info, entry.args);
>> +	const unsigned int expected_sci_exit_size =
>> +		offsetofend(struct ptrace_syscall_info, exit.is_error);
>> +
>> +	pid = fork();
>> +	if (pid == 0) {
>> +		/* Mark oneself being traced */
>> +		long val = ptrace(PTRACE_TRACEME, 0, 0, 0);
>> +
>> +		if (val < 0)
>> +			perr_and_exit("failed to request for tracer to trace me: %ld", val);
>> +
>> +		kill(getpid(), SIGSTOP);
>> +
>> +		/* Perform chdir syscall that will be intercepted */
>> +		syscall(__NR_chdir, A0_OLD);
>> +
>> +		exit(0);
>> +	}
>> +
>> +	if (pid < 0)
>> +		ksft_exit_fail_perror("failed to fork");
>> +
>> +	for (int i = 0; i < 3; i++) {
>> +		if (waitpid(pid, &status, 0) != pid)
>> +			perr_and_exit("failed to wait for the tracee %d", pid);
>> +		if (WIFSTOPPED(status)) {
>> +			switch (WSTOPSIG(status)) {
>> +			case SIGSTOP:
>> +				if (ptrace(PTRACE_SETOPTIONS, pid, 0, PTRACE_O_TRACESYSGOOD) < 0)
>> +					perr_and_exit("failed to set PTRACE_O_TRACESYSGOOD");
>> +				break;
>> +			case SIGTRAP|0x80:
>> +				/* Modify twice so GET_SYSCALL_INFO get modified a0 and orig_a0 */
>> +				if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
>> +					perr_and_exit("failed to get tracee registers");
>> +				if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
>> +					perr_and_exit("failed to get tracee registers");
>> +
>> +				/* Modify a0/orig_a0 for the syscall */
>> +				switch (opt) {
>> +				case A0_MODIFY:
>> +					regs.a0 = A0_NEW;
>> +					break;
>> +				case ORIG_A0_MODIFY:
>> +					orig_a0 = A0_NEW;
>> +					break;
>> +				}
>> +
>> +				if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
>> +					perr_and_exit("failed to set tracee registers");
>> +				if (ptrace(PTRACE_SETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
>> +					perr_and_exit("failed to set tracee registers");
>> +				switch (i) {
>> +				case 1:
>> +					/* Stop at the beginning of syscall */
>> +					rc = ptrace(PTRACE_GET_SYSCALL_INFO, pid,
>> +						sizeof(syscall_info), &syscall_info);
>> +					if (rc < 0)
>> +						perr_and_exit("failed to get syscall info of entry");
>> +					if (rc < expected_sci_entry_size
>> +						|| syscall_info.op != PTRACE_SYSCALL_INFO_ENTRY)
>> +						perr_and_exit("stop position of entry mismatched");
>> +					result[0].orig_a0 = syscall_info.entry.args[0];
>> +					break;
>> +
>> +				case 2:
>> +					/* Stop at the end of syscall */
>> +					rc = ptrace(PTRACE_GET_SYSCALL_INFO, pid,
>> +						sizeof(syscall_info), &syscall_info);
>> +					if (rc < 0)
>> +						perr_and_exit("failed to get syscall info of entry");
>> +					if (rc < expected_sci_exit_size
>> +						|| syscall_info.op != PTRACE_SYSCALL_INFO_EXIT)
>> +						perr_and_exit("stop position of exit mismatched");
>> +					result[0].a0 = syscall_info.exit.rval;
>> +
>> +					if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
>> +						perr_and_exit("failed to get tracee registers");
>> +					result[1].a0 = regs.a0;
>> +					if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_ORIG_A0,
>> +						   &a0_iov))
>> +						perr_and_exit("failed to get tracee registers");
>> +					result[1].orig_a0 = orig_a0;
>> +				}
>> +			}
>> +			if (ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
>> +				perr_and_exit("failed to resume tracee");
>> +		}
>> +	}
>> +
>> +	/* Resume the tracee */
>> +	ptrace(PTRACE_CONT, pid, 0, 0);
>> +	if (waitpid(pid, &status, 0) != pid)
>> +		perr_and_exit("failed to wait for the tracee");
>> +
>> +}
>> +
>> +TEST(ptrace_access_a0)
>> +{
>> +	struct a0_regs result[2];
>> +
>> +	ptrace_test(A0_MODIFY, result);
>> +
>> +	/* Verify PTRACE_SETREGSET */
>> +	/* The modification of a0 cannot affect the first argument of the syscall */
>> +	EXPECT_EQ(A0_OLD, result[0].orig_a0);
>> +	EXPECT_EQ(A0_NEW, result[0].a0);
>> +
>> +	/* Verify PTRACE_GETREGSET */
>> +	EXPECT_EQ(result[1].orig_a0, result[0].orig_a0);
>> +	EXPECT_EQ(result[1].a0, result[0].a0);
>> +}
>> +
>> +TEST(ptrace_access_orig_a0)
>> +{
>> +	struct a0_regs result[2];
>> +
>> +	ptrace_test(ORIG_A0_MODIFY, result);
>> +
>> +	/* Verify PTRACE_SETREGSET */
>> +	/* Only modify orig_a0 to change the first argument of the syscall */
>> +	EXPECT_EQ(A0_NEW, result[0].orig_a0);
>> +	/* a0 will keep default value, orig_a0 or -ENOSYS, depends on internal. */
>> +	EXPECT_NE(A0_NEW, result[0].a0);
> 
> I don't understand this test. Why don't we know what to expect? Also, the
> comment says orig_a0 is an option for the value, but then we don't expect
> it to be A0_NEW, even though we expect orig_a0 to be A0_NEW?

The purpose of the test is to ensure that the ORIG_A0_MODIFY operation
will not affect the a0 register (So it will not be our A0_NEW). But there
is a problem with the comment. It is written for some old wrong code.
I will correct the comment.

> 
>> +
>> +	/* Verify PTRACE_GETREGSET */
>> +	EXPECT_EQ(result[1].orig_a0, result[0].orig_a0);
>> +	EXPECT_EQ(result[1].a0, result[0].a0);
>> +}
>> +
>> +TEST_HARNESS_MAIN
>>
>> -- 
>> 2.48.0
>>
> 
> Other than the two comments/questions, this test looks great.
> 
> Thanks,
> drew


