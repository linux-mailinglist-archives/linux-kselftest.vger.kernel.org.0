Return-Path: <linux-kselftest+bounces-49184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9318D378D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 18:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6257C3026B13
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 17:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE22C33CE80;
	Fri, 16 Jan 2026 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="d5Z0XwF9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838A233B95A;
	Fri, 16 Jan 2026 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583976; cv=none; b=CtqoY9dBT3ztUw8oxVV21VyQkIZ5ni1DcHitIxi5Jik9TmKIwqHaJh0r6xgNOxGr+3SVwF+WT7pjAtohZIVTD4PACdJ/grjAlz590yeNx6xURvORuMbXWb53sAaG+lL9JSLQ0W4GJLmue+5H0IKv4uhJwwpcnCKrINggd09amyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583976; c=relaxed/simple;
	bh=XpDpPoWzbNPEaCNFY4nueroDruTKYy0mxr6Vpho7Iao=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UP4FtrhFX1Li1kf2KFV8o5mW60+l9OQEW8g8KCUc7JNWcH/iaettOp8FOlFYQ7LNZNzYncn1XowsOrRw8DtIk+zzx4GoAyNcVF+D9dTRNEJ6KDGYNaRC8IL8s9UPX/W1/WCmEkjuej14TM+dvvgAuP9Hv5afHcy3PUiKVt71vuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=d5Z0XwF9; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=5Pr7/xueEK3tP328BBekBdOt85PazUkdjcprj8yio4c=; t=1768583974;
	x=1769188774; b=d5Z0XwF9l50Wsb+vDOJzeHiC18+eZi8JMAGT7dn+PC5YWcOlmffECKFKy30sJ
	piZN87ieKoGg/6SbTXpw95oHf6ieZ6FydHNNOR/qqC93fZTIkcYc0gMlj2tKlrrwtZu6v7FrzSbvO
	Es2pqzNGI7XdLeqn2Qn/k7Gq7RaqlNpOVufmlAG2esxosqeWlnZZZToqbW74803+RorqoPfnSKK3O
	XyuAV6lvNpC1gHRMB6OYIzL7iLdbDMrxFLFWO/xhZrxuaIPmzplkVCWwVq6E1quPTFxAFDKrzCT2P
	rJUe4+BNlijKtiZcc96Hqigv9mk04ItCMAIN7w4kpdOTjr7JlA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vgnTw-00000003d7y-3Mck; Fri, 16 Jan 2026 18:19:32 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vgnTw-00000000j8J-26SM; Fri, 16 Jan 2026 18:19:32 +0100
Message-ID: <ab9a570f5c3098237a82f6e0dca61d284eb2d072.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/3] sparc: Add architecture support for clone3
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>, davem@davemloft.net, 
	andreas@gaisler.com, brauner@kernel.org, shuah@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, arnd@arndb.de, geert@linux-m68k.org, 
	schuster.simon@siemens-energy.com
Date: Fri, 16 Jan 2026 18:19:31 +0100
In-Reply-To: <20260116153051.21678-3-ludwig.rydberg@gaisler.com>
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
	 <20260116153051.21678-3-ludwig.rydberg@gaisler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ludwig,

On Fri, 2026-01-16 at 16:30 +0100, Ludwig Rydberg wrote:
> Add support for the clone3 system call to the SPARC architectures.
>=20
> The implementation follows the pattern of the original clone syscall.
> However, instead of explicitly calling kernel_clone, the clone3
> handler calls the generic sys_clone3 handler in kernel/fork.
> In case no stack is provided, the parents stack is reused.
>=20
> The return call conventions for clone on SPARC are kept for clone3:
>   Parent -->  %o0 =3D=3D child's  pid, %o1 =3D=3D 0
>   Child  -->  %o0 =3D=3D parent's pid, %o1 =3D=3D 1
>=20
> Closes: https://github.com/sparclinux/issues/issues/10
> Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
> ---
>  arch/sparc/include/asm/syscalls.h      |  1 +
>  arch/sparc/include/asm/unistd.h        |  2 --
>  arch/sparc/kernel/entry.S              | 15 +++++++++++++++
>  arch/sparc/kernel/kernel.h             |  1 +
>  arch/sparc/kernel/process.c            | 25 +++++++++++++++++++++++++
>  arch/sparc/kernel/process_32.c         |  2 +-
>  arch/sparc/kernel/process_64.c         |  2 +-
>  arch/sparc/kernel/syscalls.S           |  6 ++++++
>  arch/sparc/kernel/syscalls/syscall.tbl |  2 +-
>  9 files changed, 51 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/sparc/include/asm/syscalls.h b/arch/sparc/include/asm/s=
yscalls.h
> index 35575fbfb9dc..282e62b66518 100644
> --- a/arch/sparc/include/asm/syscalls.h
> +++ b/arch/sparc/include/asm/syscalls.h
> @@ -7,5 +7,6 @@ struct pt_regs;
>  asmlinkage long sparc_fork(struct pt_regs *regs);
>  asmlinkage long sparc_vfork(struct pt_regs *regs);
>  asmlinkage long sparc_clone(struct pt_regs *regs);
> +asmlinkage long sparc_clone3(struct pt_regs *regs);
> =20
>  #endif /* _SPARC64_SYSCALLS_H */
> diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/uni=
std.h
> index 3380411a4537..d6bc76706a7a 100644
> --- a/arch/sparc/include/asm/unistd.h
> +++ b/arch/sparc/include/asm/unistd.h
> @@ -49,8 +49,6 @@
>  #define __ARCH_WANT_COMPAT_STAT
>  #endif
> =20
> -#define __ARCH_BROKEN_SYS_CLONE3
> -
>  #ifdef __32bit_syscall_numbers__
>  /* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
>   * it never had the plain ones and there is no value to adding those
> diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
> index a3fdee4cd6fa..ea51ef52c952 100644
> --- a/arch/sparc/kernel/entry.S
> +++ b/arch/sparc/kernel/entry.S
> @@ -907,6 +907,21 @@ flush_patch_four:
>  	jmpl	%l1 + %lo(sparc_vfork), %g0
>  	 add	%sp, STACKFRAME_SZ, %o0
> =20
> +	.globl	__sys_clone3, flush_patch_five
> +__sys_clone3:
> +	mov	%o7, %l5
> +flush_patch_five:
> +	FLUSH_ALL_KERNEL_WINDOWS;
> +	ld	[%curptr + TI_TASK], %o4
> +	rd	%psr, %g4
> +	WRITE_PAUSE
> +	rd	%wim, %g5
> +	WRITE_PAUSE
> +	std	%g4, [%o4 + AOFF_task_thread + AOFF_thread_fork_kpsr]
> +	add	%sp, STACKFRAME_SZ, %o0
> +	call	sparc_clone3
> +	 mov	%l5, %o7
> +
>          .align  4
>  linux_sparc_ni_syscall:
>  	sethi   %hi(sys_ni_syscall), %l7
> diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
> index 8328a3b78a44..4ee85051521a 100644
> --- a/arch/sparc/kernel/kernel.h
> +++ b/arch/sparc/kernel/kernel.h
> @@ -18,6 +18,7 @@ extern int ncpus_probed;
>  asmlinkage long sparc_clone(struct pt_regs *regs);
>  asmlinkage long sparc_fork(struct pt_regs *regs);
>  asmlinkage long sparc_vfork(struct pt_regs *regs);
> +asmlinkage long sparc_clone3(struct pt_regs *regs);
> =20
>  #ifdef CONFIG_SPARC64
>  /* setup_64.c */
> diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
> index 7d69877511fa..b8e23295db69 100644
> --- a/arch/sparc/kernel/process.c
> +++ b/arch/sparc/kernel/process.c
> @@ -12,6 +12,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/signal.h>
> +#include <linux/syscalls.h>
> =20
>  #include "kernel.h"
> =20
> @@ -118,3 +119,27 @@ asmlinkage long sparc_clone(struct pt_regs *regs)
> =20
>  	return ret;
>  }
> +
> +asmlinkage long sparc_clone3(struct pt_regs *regs)
> +{
> +	unsigned long sz;
> +	long ret;
> +	struct clone_args __user *cl_args;
> +
> +	synchronize_user_stack();
> +
> +	cl_args =3D (struct clone_args __user *)regs->u_regs[UREG_I0];
> +	sz =3D regs->u_regs[UREG_I1];
> +
> +	ret =3D sys_clone3(cl_args, sz);
> +
> +	/* If we get an error and potentially restart the system
> +	 * call, we're screwed because copy_thread() clobbered
> +	 * the parent's %o1.  So detect that case and restore it
> +	 * here.
> +	 */
> +	if ((unsigned long)ret >=3D -ERESTART_RESTARTBLOCK)
> +		regs->u_regs[UREG_I1] =3D sz;
> +
> +	return ret;
> +}
> diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_3=
2.c
> index 5a28c0e91bf1..216c07971c81 100644
> --- a/arch/sparc/kernel/process_32.c
> +++ b/arch/sparc/kernel/process_32.c
> @@ -261,11 +261,11 @@ extern void ret_from_kernel_thread(void);
>  int copy_thread(struct task_struct *p, const struct kernel_clone_args *a=
rgs)
>  {
>  	u64 clone_flags =3D args->flags;
> -	unsigned long sp =3D args->stack;
>  	unsigned long tls =3D args->tls;
>  	struct thread_info *ti =3D task_thread_info(p);
>  	struct pt_regs *childregs, *regs =3D current_pt_regs();
>  	char *new_stack;
> +	unsigned long sp =3D args->stack ? args->stack : regs->u_regs[UREG_FP];
> =20
>  #ifndef CONFIG_SMP
>  	if(last_task_used_math =3D=3D current) {
> diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_6=
4.c
> index 25781923788a..885d617ba29d 100644
> --- a/arch/sparc/kernel/process_64.c
> +++ b/arch/sparc/kernel/process_64.c
> @@ -568,13 +568,13 @@ void fault_in_user_windows(struct pt_regs *regs)
>  int copy_thread(struct task_struct *p, const struct kernel_clone_args *a=
rgs)
>  {
>  	u64 clone_flags =3D args->flags;
> -	unsigned long sp =3D args->stack;
>  	unsigned long tls =3D args->tls;
>  	struct thread_info *t =3D task_thread_info(p);
>  	struct pt_regs *regs =3D current_pt_regs();
>  	struct sparc_stackf *parent_sf;
>  	unsigned long child_stack_sz;
>  	char *child_trap_frame;
> +	unsigned long sp =3D args->stack ? args->stack : regs->u_regs[UREG_FP];
> =20
>  	/* Calculate offset to stack_frame & pt_regs */
>  	child_stack_sz =3D (STACKFRAME_SZ + TRACEREG_SZ);
> diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
> index 0e8ab0602c36..c8d374a37f98 100644
> --- a/arch/sparc/kernel/syscalls.S
> +++ b/arch/sparc/kernel/syscalls.S
> @@ -103,6 +103,12 @@ sys_clone:
>  	ba,pt	%xcc, sparc_clone
>  	 add	%sp, PTREGS_OFF, %o0
> =20
> +	.align	32
> +__sys_clone3:
> +	flushw
> +	ba,pt	%xcc, sparc_clone3
> +	 add	%sp, PTREGS_OFF, %o0
> +
>  	.globl	ret_from_fork
>  ret_from_fork:
>  	/* Clear current_thread_info()->new_child. */
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/s=
yscalls/syscall.tbl
> index 39aa26b6a50b..c0307bb09892 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -480,7 +480,7 @@
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
>  434	common	pidfd_open			sys_pidfd_open
> -# 435 reserved for clone3
> +435	common	clone3				__sys_clone3
>  436	common	close_range			sys_close_range
>  437	common	openat2			sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd

Applied on top of 6.19-rc5, tested on a Sun Netra 240 (UltraSPARC IIIi).

Running the kernel selftest for clone3 works fine:

root@raverin:/usr/src/linux/tools/testing/selftests/clone3# uname -a
Linux raverin 6.19.0-rc5+ #18 Fri Jan 16 16:02:10 UTC 2026 sparc64 GNU/Linu=
x
root@raverin:/usr/src/linux/tools/testing/selftests/clone3# make
  CC       clone3
  CC       clone3_clear_sighand
  CC       clone3_set_tid
  CC       clone3_cap_checkpoint_restore
root@raverin:/usr/src/linux/tools/testing/selftests/clone3# ./clone3
TAP version 13
1..19
# clone3() syscall supported
# Running test 'simple clone3()'
# [1385] Trying clone3() with flags 0 (size 0)
# I am the parent (1385). My child's pid is 1386
# I am the child, my PID is 1386
# [1385] clone3() with flags says: 0 expected 0
ok 1 simple clone3()
# Running test 'clone3() in a new PID_NS'
# [1385] Trying clone3() with flags 0x20000000 (size 0)
# I am the child, my PID is 1
# I am the parent (1385). My child's pid is 1387
# [1385] clone3() with flags says: 0 expected 0
ok 2 clone3() in a new PID_NS
# Running test 'CLONE_ARGS_SIZE_VER0'
# [1385] Trying clone3() with flags 0 (size 64)
# I am the parent (1385). My child's pid is 1388
# I am the child, my PID is 1388
# [1385] clone3() with flags says: 0 expected 0
ok 3 CLONE_ARGS_SIZE_VER0
# Running test 'CLONE_ARGS_SIZE_VER0 - 8'
# [1385] Trying clone3() with flags 0 (size 56)
# Invalid argument - Failed to create new process
# [1385] clone3() with flags says: -22 expected -22
ok 4 CLONE_ARGS_SIZE_VER0 - 8
# Running test 'sizeof(struct clone_args) + 8'
# [1385] Trying clone3() with flags 0 (size 96)
# I am the parent (1385). My child's pid is 1389
# I am the child, my PID is 1389
# [1385] clone3() with flags says: 0 expected 0
ok 5 sizeof(struct clone_args) + 8
# Running test 'exit_signal with highest 32 bits non-zero'
# [1385] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [1385] clone3() with flags says: -22 expected -22
ok 6 exit_signal with highest 32 bits non-zero
# Running test 'negative 32-bit exit_signal'
# [1385] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [1385] clone3() with flags says: -22 expected -22
ok 7 negative 32-bit exit_signal
# Running test 'exit_signal not fitting into CSIGNAL mask'
# [1385] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [1385] clone3() with flags says: -22 expected -22
ok 8 exit_signal not fitting into CSIGNAL mask
# Running test 'NSIG < exit_signal < CSIG'
# [1385] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [1385] clone3() with flags says: -22 expected -22
ok 9 NSIG < exit_signal < CSIG
# Running test 'Arguments sizeof(struct clone_args) + 8'
# [1385] Trying clone3() with flags 0 (size 96)
# I am the parent (1385). My child's pid is 1390
# I am the child, my PID is 1390
# [1385] clone3() with flags says: 0 expected 0
ok 10 Arguments sizeof(struct clone_args) + 8
# Running test 'Arguments sizeof(struct clone_args) + 16'
# [1385] Trying clone3() with flags 0 (size 104)
# Argument list too long - Failed to create new process
# [1385] clone3() with flags says: -7 expected -7
ok 11 Arguments sizeof(struct clone_args) + 16
# Running test 'Arguments sizeof(struct clone_arg) * 2'
# [1385] Trying clone3() with flags 0 (size 104)
# Argument list too long - Failed to create new process
# [1385] clone3() with flags says: -7 expected -7
ok 12 Arguments sizeof(struct clone_arg) * 2
# Running test 'Arguments > page size'
# [1385] Trying clone3() with flags 0 (size 8200)
# Argument list too long - Failed to create new process
# [1385] clone3() with flags says: -7 expected -7
ok 13 Arguments > page size
# Running test 'CLONE_ARGS_SIZE_VER0 in a new PID NS'
# [1385] Trying clone3() with flags 0x20000000 (size 64)
# I am the parent (1385). My child's pid is 1391
# I am the child, my PID is 1
# [1385] clone3() with flags says: 0 expected 0
ok 14 CLONE_ARGS_SIZE_VER0 in a new PID NS
# Running test 'CLONE_ARGS_SIZE_VER0 - 8 in a new PID NS'
# [1385] Trying clone3() with flags 0x20000000 (size 56)
# Invalid argument - Failed to create new process
# [1385] clone3() with flags says: -22 expected -22
ok 15 CLONE_ARGS_SIZE_VER0 - 8 in a new PID NS
# Running test 'sizeof(struct clone_args) + 8 in a new PID NS'
# [1385] Trying clone3() with flags 0x20000000 (size 96)
# I am the parent (1385). My child's pid is 1392
# I am the child, my PID is 1
# [1385] clone3() with flags says: 0 expected 0
ok 16 sizeof(struct clone_args) + 8 in a new PID NS
# Running test 'Arguments > page size in a new PID NS'
# [1385] Trying clone3() with flags 0x20000000 (size 8200)
# Argument list too long - Failed to create new process
# [1385] clone3() with flags says: -7 expected -7
ok 17 Arguments > page size in a new PID NS
# Time namespaces are not supported
ok 18 # SKIP New time NS
# Running test 'exit signal (SIGCHLD) in flags'
# [1385] Trying clone3() with flags 0x14 (size 0)
# Invalid argument - Failed to create new process
# [1385] clone3() with flags says: -22 expected -22
ok 19 exit signal (SIGCHLD) in flags
# 1 skipped test(s) detected. Consider enabling relevant config options to =
improve coverage.
# Totals: pass:18 fail:0 xfail:0 xpass:0 skip:1 error:0
root@raverin:/usr/src/linux/tools/testing/selftests/clone3#

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

