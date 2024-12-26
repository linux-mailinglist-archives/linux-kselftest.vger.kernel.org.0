Return-Path: <linux-kselftest+bounces-23752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEEE9FCB2E
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 14:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74071882EAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E91E493;
	Thu, 26 Dec 2024 13:35:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C9A1361;
	Thu, 26 Dec 2024 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735220111; cv=none; b=Jf0UiAsuadzBLBU4wjxyStZl5dol+I7IhPg28G3OjSrVw0ZYJBrlz2L2/csOXt0Q75H51CW1nqITUu2IkaEbURzNz7tc2r8WZvhuBB213uJUxgFdhNUG67kb/KuipTGSAKw7pRzxOUAOvg6d1p0zi62+ysFZkv7m/PyJcEbhUvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735220111; c=relaxed/simple;
	bh=Uo3cDZbyha4w6q4pob/vGiTmVRDWap8zMZwgB1dxQNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S02tGy3G+Qk44jUSOv0SdaaxAHm/U1Oj1yp48GlrZGYBM9htNslty4/9dUi6mR3XMAhNuKzpyRkmAhz9saqCZ8h9BpDPRg75pERHN+r9SwnufFpqWu6fP9BquWrDxbGYsdUOy+aSQF3LKZ9anRD4Aeq5cumYAsIOIqbemnD/fNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 8FAC872C8CC;
	Thu, 26 Dec 2024 16:35:00 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 489C37CCB3A; Thu, 26 Dec 2024 15:35:00 +0200 (IST)
Date: Thu, 26 Dec 2024 15:35:00 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrea Bolognani <abologna@redhat.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>, Guo Ren <guoren@kernel.org>,
	Yao Zi <ziyao@disroot.org>, Eugene Syromyatnikov <evgsyr@gmail.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v4 2/2] riscv: selftests: Add a ptrace test to verify
 syscall parameter modification
Message-ID: <20241226133459.GA30481@strace.io>
References: <20241226-riscv-new-regset-v4-0-4496a29d0436@coelacanthus.name>
 <20241226-riscv-new-regset-v4-2-4496a29d0436@coelacanthus.name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241226-riscv-new-regset-v4-2-4496a29d0436@coelacanthus.name>

On Thu, Dec 26, 2024 at 06:52:52PM +0800, Celeste Liu wrote:
> This test checks that orig_a0 allows a syscall argument to be modified,
> and that changing a0 does not change the syscall argument.
> 
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Co-developed-by: Charlie Jenkins <charlie@rivosinc.com>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
[...]
> diff --git a/tools/testing/selftests/riscv/abi/ptrace.c b/tools/testing/selftests/riscv/abi/ptrace.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..023695352215bb5de3f91c1a6f5ea3b4f9373ff9
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/abi/ptrace.c
[...]
> +	if (ptrace(PTRACE_GET_SYSCALL_INFO, pid, PTRACE_SYSCALL_INFO_ENTRY, &syscall_info_entry))
> +		perr_and_exit("failed to get syscall info of entry\n");
> +	result->orig_a0 = syscall_info_entry->entry.args[0];
> +	if (ptrace(PTRACE_GET_SYSCALL_INFO, pid, PTRACE_SYSCALL_INFO_EXIT, &syscall_info_exit))
> +		perr_and_exit("failed to get syscall info of exit\n");
> +	result->a0 = syscall_info_exit->exit.rval;

I'm sorry but this is not how PTRACE_GET_SYSCALL_INFO should be used.

PTRACE_GET_SYSCALL_INFO operation takes a pointer and a size,
and in this example instead of size you pass constants 1 and 2, which
essentially means that both syscall_info_entry->entry.args[0] and
syscall_info_exit->exit.rval are not going to be assigned
and would just contain some garbage from the stack.

Also, PTRACE_GET_SYSCALL_INFO operation returns the number of bytes
available to be written by the kernel, which is always nonzero on any
PTRACE_GET_SYSCALL_INFO-capable kernel.  In other words, this example
will always end up with perr_and_exit() call.

I wonder how this test was tested before the submission.


-- 
ldv

