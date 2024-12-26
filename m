Return-Path: <linux-kselftest+bounces-23750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E04D9FCA6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 11:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43E718822EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 10:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B41CDA19;
	Thu, 26 Dec 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="E5TQUxOu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vK1923fP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1E77F10;
	Thu, 26 Dec 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735210724; cv=none; b=tnbnpB8WIHXP9Ig9Kwt91w/XPMwa+QmY9RQ9inMFC6w2XU2xCfhzY6uVnqVaWat0au6muxNuWBtupZyLp8wU5sNmGetgAYbDQf6PZCJEKMIzNhf6GpmgDSsBWanRL/sGcj6W4A0bhagLwbOzAp7MS6w/nZ1W3SoSuR69g3dmhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735210724; c=relaxed/simple;
	bh=ciS+LYD8ohtCDVNlqQkfWQe684aofMrVEecy0Md57jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P//0obVKqQAmd8EZerbwUMJbYTsFFzxNBjmHBWui8LdlZyMIARof5zsgAJW949lVlofxgv4/p1vEr4WA03HZyMk1/9MVxPBbEN8i66X39SGChPhhhbCRgTcpdZieJg7+09qAqzATBrAI5soRtmVFWh3JG8lWETceEl5m2bo/ZOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=E5TQUxOu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vK1923fP; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 6AD9E2002CD;
	Thu, 26 Dec 2024 05:58:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 26 Dec 2024 05:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1735210721; x=1735217921; bh=T2trfevT8p
	1FBQocDd7hyc8JcbXfbl6wsDPSsuq2Kj0=; b=E5TQUxOuaZ4PW12qCy2k4t6zse
	gMs37gbvmAadsZbe0oAFsshSGacPqBGyj36uz8bFgGDAU3H6rBdmeh02jvSwL3Rq
	DYmiergAsOO1qOUsatG08dqK3Vsno2GquzkVgtIBEsawaHH4G+5PUN1oI7zfC/8/
	wbg3IaLRM9fXIKeUf5LDY/zuxSx/kF4mvpC7h8sPPdAhIPEMXdP6zN0IMrLBPkTk
	CctpF7nirW2/mCHdwrjKH8dPrhx4oeRfjuMdZaPDPuAMRYU37CokyJCup3Jd3ae2
	B2BKWGS7k06sZoM2dt+v4yBqjucM+BCRZidZ6emowDGADipHYPLwrmPqaVvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735210721; x=
	1735217921; bh=T2trfevT8p1FBQocDd7hyc8JcbXfbl6wsDPSsuq2Kj0=; b=v
	K1923fPglNU0/JlJTFbB+mhxSwWssLvUef21FSOrgVD2+fywBcAUCXnSwMzSJ4aN
	wtsUuDg/bxN0q4BrPWTdUukSDE2dnLRQ86BxM2k0DBvrQhjVnxhQ37AjcMXx3X0w
	9q0DdYLtA38+A3kFW7vz+L0Y7uBZzcbbg184n329ANABus/aCr4/MOltl4a23prY
	Z3Sx0jMuDcYuFaMxAPPPkSHtlAwcLhr5MTBSWSpxbCRGbNfgVf/om/NPfmNz9w3F
	dbY8X/CQT6JLaQVzkh96HNs9eDnL/w7Xaa3Pg8PuSK2EpTvyV4HlEiR1VzCEDHK8
	VlLUn52BCXFjbXNNYeLiA==
X-ME-Sender: <xms:4DZtZ6G9SgRc5g1ln_oqPV9hqgVpSn0caBy8c9ZXn4pK4iz3KhCj_g>
    <xme:4DZtZ7V_k7BGxPO256OsNw5xlXe7cpRqmcDWecalqb11DOAEdFVNJhUpmqU2dM8MF
    Vq4uEZBNGXYWKrzKtc>
X-ME-Received: <xmr:4DZtZ0JWxlscMxU5MHVLfqtkESvaPb737saU_Tf9L_zidBZcPANt818QY2n5wEF8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeevvghlvghsthgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuh
    hsrdhnrghmvgeqnecuggftrfgrthhtvghrnhepfefhfeefteekgedvfeehhfefvedutedt
    fefhkeeileehgefgveffvdffudehhfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgdp
    nhgspghrtghpthhtohepvdehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeholh
    gvghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhies
    shhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtoh
    hmpdhrtghpthhtohepvggsihgvuggvrhhmseigmhhishhsihhonhdrtghomhdprhgtphht
    thhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvggu
    uhdprhgtphhtthhopegrlhgvgiesghhhihhtihdrfhhrpdhrtghpthhtoheplhguvhessh
    htrhgrtggvrdhioh
X-ME-Proxy: <xmx:4DZtZ0FyrUowwEYpVLcU7J41PuVE_xqEik9j-OjuF2Tcp9Ub2F8rCA>
    <xmx:4DZtZwXQr441wA-D8c9KwtfljjvADYyHSzI3iVG2SrR1KRXLY8WHIw>
    <xmx:4DZtZ3OsQlGYEbyJgqIvC6JmBERzGZ1hGrhxpRitaJwxgtlSF58rwA>
    <xmx:4DZtZ31Q9KYbL8fdX7f-DnwtSW80hWiEuwJFY8RWGh1KwlxCYsqO9w>
    <xmx:4TZtZ2E8fCRAGN6YbwKZ5jk_jh0lyUUq2OT_BIf5mfLYkfUapIsoAdvG>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 05:58:32 -0500 (EST)
Message-ID: <76e57304-3a03-462e-bb82-61d0a0385dda@coelacanthus.name>
Date: Thu, 26 Dec 2024 18:58:29 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] riscv: selftests: Add a ptrace test to verify
 syscall parameter modification
Content-Language: en-GB-large
To: Oleg Nesterov <oleg@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>,
 Andrea Bolognani <abologna@redhat.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ron Economos <re@w6rz.net>, Charlie Jenkins <charlie@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Quan Zhou <zhouquan@iscas.ac.cn>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Guo Ren <guoren@kernel.org>, Yao Zi <ziyao@disroot.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
References: <20241226-riscv-new-regset-v3-0-f5b96465826b@coelacanthus.name>
 <20241226-riscv-new-regset-v3-2-f5b96465826b@coelacanthus.name>
From: Celeste Liu <uwu@coelacanthus.name>
In-Reply-To: <20241226-riscv-new-regset-v3-2-f5b96465826b@coelacanthus.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2024-12-26 18:45, Celeste Liu wrote:
> This test checks that orig_a0 allows a syscall argument to be modified,
> and that changing a0 does not change the syscall argument.
> 
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Co-developed-by: Charlie Jenkins <charlie@rivosinc.com>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> ---
>  tools/testing/selftests/riscv/abi/.gitignore |   1 +
>  tools/testing/selftests/riscv/abi/Makefile   |   5 +-
>  tools/testing/selftests/riscv/abi/ptrace.c   | 151 +++++++++++++++++++++++++++
>  3 files changed, 156 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/riscv/abi/.gitignore b/tools/testing/selftests/riscv/abi/.gitignore
> index b38358f91c4d2240ae64892871d9ca98bda1ae58..378c605919a3b3d58eec2701eb7af430cfe315d6 100644
> --- a/tools/testing/selftests/riscv/abi/.gitignore
> +++ b/tools/testing/selftests/riscv/abi/.gitignore
> @@ -1 +1,2 @@
>  pointer_masking
> +ptrace
> diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
> index ed82ff9c664e7eb3f760cbab81fb957ff72579c5..3f74d059dfdcbce4d45d8ff618781ccea1419061 100644
> --- a/tools/testing/selftests/riscv/abi/Makefile
> +++ b/tools/testing/selftests/riscv/abi/Makefile
> @@ -2,9 +2,12 @@
>  
>  CFLAGS += -I$(top_srcdir)/tools/include
>  
> -TEST_GEN_PROGS := pointer_masking
> +TEST_GEN_PROGS := pointer_masking ptrace
>  
>  include ../../lib.mk
>  
>  $(OUTPUT)/pointer_masking: pointer_masking.c
>  	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> +
> +$(OUTPUT)/ptrace: ptrace.c
> +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/abi/ptrace.c b/tools/testing/selftests/riscv/abi/ptrace.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..c89343cb4abc7da57f83879ecce619f503c438bb
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/abi/ptrace.c
> @@ -0,0 +1,151 @@
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
> +#include <linux/ptrace.h>
> +#include <asm/ptrace.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +#define ORIG_A0_MODIFY      0x01
> +#define A0_MODIFY           0x02
> +#define A0_OLD              0x03
> +#define A0_NEW              0x04
> +
> +struct a0_regs {
> +	__s64 orig_a0;
> +	__u64 a0;
> +};
> +
> +#define perr_and_exit(fmt, ...)						\
> +	({								\
> +		char buf[256];						\
> +		snprintf(buf, sizeof(buf), "%s:%d:" fmt ": %m\n",	\
> +			__func__, __LINE__, ##__VA_ARGS__);		\
> +		ksft_exit_fail_perror(buf);				\
> +	})
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
> +static void ptrace_test(int opt, struct a0_regs *result)
> +{
> +	int status;
> +	pid_t pid;
> +	struct user_regs_struct regs;
> +	struct iovec iov = {
> +		.iov_base = &regs,
> +		.iov_len = sizeof(regs),
> +	};
> +
> +	unsigned long orig_a0;
> +	struct iovec a0_iov = {
> +		.iov_base = &orig_a0,
> +		.iov_len = sizeof(orig_a0),
> +	};
> +	struct ptrace_syscall_info syscall_info_entry, syscall_info_exit;
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		/* Mark oneself being traced */
> +		long val = ptrace(PTRACE_TRACEME, 0, 0, 0);
> +
> +		if (val)
> +			perr_and_exit("failed to request for tracer to trace me: %ld\n", val);
> +
> +		kill(getpid(), SIGSTOP);
> +
> +		/* Perform exit syscall that will be intercepted */
> +		exit(A0_OLD);
> +	}
> +
> +	if (pid < 0)
> +		ksft_exit_fail_perror("failed to fork");
> +
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> +
> +	/* Stop at the entry point of the syscall */
> +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> +
> +	/* Check tracee regs before the syscall */
> +	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
> +		perr_and_exit("failed to get tracee registers\n");
> +	if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> +		perr_and_exit("failed to get tracee registers\n");
> +	if (orig_a0 != A0_OLD)
> +		perr_and_exit("unexpected orig_a0: 0x%lx\n", orig_a0);
> +
> +	/* Modify a0/orig_a0 for the syscall */
> +	switch (opt) {
> +	case A0_MODIFY:
> +		regs.a0 = A0_NEW;
> +		break;
> +	case ORIG_A0_MODIFY:
> +		orig_a0 = A0_NEW;
> +		break;
> +	}
> +
> +	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &a0_iov))
> +		perr_and_exit("failed to set tracee registers\n");

v4 has been sent because I found a uncommited fix for this...

> +	if (ptrace(PTRACE_SETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> +		perr_and_exit("failed to set tracee registers\n");
> +
> +	if (ptrace(PTRACE_GET_SYSCALL_INFO, pid, PTRACE_SYSCALL_INFO_ENTRY, &syscall_info_entry))
> +		perr_and_exit("failed to get syscall info of entry\n");
> +	result->orig_a0 = syscall_info_entry->entry.args[0];
> +	if (ptrace(PTRACE_GET_SYSCALL_INFO, pid, PTRACE_SYSCALL_INFO_EXIT, &syscall_info_exit))
> +		perr_and_exit("failed to get syscall info of exit\n");
> +	result->a0 = syscall_info_exit->exit.rval;
> +
> +	/* Resume the tracee */
> +	ptrace(PTRACE_CONT, pid, 0, 0);
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee\n");
> +
> +}
> +
> +TEST(ptrace_modify_a0)
> +{
> +	struct a0_regs result;
> +
> +	ptrace_test(A0_MODIFY, &result);
> +
> +	/* The modification of a0 cannot affect the first argument of the syscall */
> +	EXPECT_EQ(A0_OLD, result.orig_a0);
> +	EXPECT_EQ(A0_NEW, result.a0);
> +}
> +
> +TEST(ptrace_modify_orig_a0)
> +{
> +	struct a0_regs result;
> +
> +	ptrace_test(ORIG_A0_MODIFY, &result);
> +
> +	/* Only modify orig_a0 to change the first argument of the syscall */
> +	EXPECT_EQ(A0_NEW, result.orig_a0);
> +	/* a0 will keep default value, orig_a0 or -ENOSYS, depends on internal. */
> +	EXPECT_NE(A0_NEW, result.a0);
> +}
> +
> +TEST_HARNESS_MAIN
> 


