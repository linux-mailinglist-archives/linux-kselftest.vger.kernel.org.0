Return-Path: <linux-kselftest+bounces-49226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E3BD38D0A
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 08:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CB653001FF4
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 07:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626C8333426;
	Sat, 17 Jan 2026 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="LcM1zvev"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B48233291D;
	Sat, 17 Jan 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768633234; cv=none; b=ZLDY8DxCQ1PkeuBEnCZerYHHDtMVZ4CPGl+SpkM/QKO44Uinldwx3F0WsMse6ogfNXt5u0/MIQBKLpvNiQ6iCKXN1KZ4cgmhytvf/MnCbnZwIYemsun/lT8Cc9gIAGQE0gaagQlJ7YNlcMP8T3KL4VvM2LesThX1IRp1z6plXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768633234; c=relaxed/simple;
	bh=6oZWTH6FXYUZhw/96I15wxE7nxmPx2Wvxmm5b6xNEKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dQWQGIOWZbevXjNQ5Ipumw5mnNZpVO7nLg4lnqkneI9rSIHfFFR9XI1UGdvcXoqEdjWD6Qp10PFbG0AgPgTHclpyfjaKXZfriWjEzRL5UJnTSqCdvxaMxIMtGaB8nMeqtN2fzjFyZiddixZCIuyAtOG87+tKEfPzuDobibfTA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=LcM1zvev; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=yehRw8lcTvhej5GMnL8ek59c5hqmcx2TNM+CJsOMDz8=; t=1768633220;
	x=1769238020; b=LcM1zvev3BlonUlBXmY+SY3dgCABfZiMmvKpsZV2gdehfwEVuDho5e4+xdzFN
	rHtb6xjinPB+tU4LD/4YtDdEGKv3FQ+XdMoSnkEnmOLvYaLctf1Xm1tgDMYsAyyEOIDL3X3xEDDIG
	9TIgBDTUvsreNRrK2E+wA67mDvMUPxnfY/4pJM0iPcY6rdCgjbUs7uaHVzJ/NdgCyRv28IrZrbvfc
	4bhIOZjoukZc9QpIIT2XLibS787C722aYXx6FBQbTBHSDAxSuxp58dIhzy8TR13YfuVgrhbrxUNbS
	UJ3gMOCG8ZDWqgvikT67bWbGEzvIacowDD7khrkn7NlkLxM9vg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vh0IC-00000002A1N-2fXs; Sat, 17 Jan 2026 08:00:16 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vh0IC-000000022Fs-1bbz; Sat, 17 Jan 2026 08:00:16 +0100
Message-ID: <6529fbe6e6af7b87fdc92912b0b6a8878796bb6e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/3] sparc: Synchronize user stack on fork and clone
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>, davem@davemloft.net, 
	andreas@gaisler.com, brauner@kernel.org, shuah@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, arnd@arndb.de, geert@linux-m68k.org, 
	schuster.simon@siemens-energy.com, kernel@mkarcher.dialup.fu-berlin.de
Date: Sat, 17 Jan 2026 08:00:15 +0100
In-Reply-To: <e4eb5ddf57ef5f3a01ee76fe397c5f714a9d7626.camel@physik.fu-berlin.de>
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
		 <20260116153051.21678-2-ludwig.rydberg@gaisler.com>
	 <e4eb5ddf57ef5f3a01ee76fe397c5f714a9d7626.camel@physik.fu-berlin.de>
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

Hi,

On Sat, 2026-01-17 at 07:57 +0100, John Paul Adrian Glaubitz wrote:
> Hi Ludwig,
>=20
> On Fri, 2026-01-16 at 16:30 +0100, Ludwig Rydberg wrote:
> > From: Andreas Larsson <andreas@gaisler.com>
> >=20
> > Flush all uncommitted user windows before calling the generic syscall
> > handlers for clone, fork, and vfork.
> >=20
> > Prior to entering the arch common handlers sparc_{clone|fork|vfork}, th=
e
> > arch-specific syscall wrappers for these syscalls will attempt to flush
> > all windows (including user windows).
> >=20
> > In the window overflow trap handlers on both SPARC{32|64},
> > if the window can't be stored (i.e due to MMU related faults) the routi=
ne
> > backups the user window and increments a thread counter (wsaved).
> >=20
> > By adding a synchronization point after the flush attempt, when fault
> > handling is enabled, any uncommitted user windows will be flushed.
> >=20
> > Link: https://sourceware.org/bugzilla/show_bug.cgi?id=3D31394
> > Closes: https://lore.kernel.org/sparclinux/fe5cc47167430007560501aabb28=
ba154985b661.camel@physik.fu-berlin.de/
> > Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> > Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
> > ---
> >  arch/sparc/kernel/process.c | 38 +++++++++++++++++++++++--------------
> >  1 file changed, 24 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
> > index 0442ab00518d..7d69877511fa 100644
> > --- a/arch/sparc/kernel/process.c
> > +++ b/arch/sparc/kernel/process.c
> > @@ -17,14 +17,18 @@
> > =20
> >  asmlinkage long sparc_fork(struct pt_regs *regs)
> >  {
> > -	unsigned long orig_i1 =3D regs->u_regs[UREG_I1];
> > +	unsigned long orig_i1;
> >  	long ret;
> >  	struct kernel_clone_args args =3D {
> >  		.exit_signal	=3D SIGCHLD,
> > -		/* Reuse the parent's stack for the child. */
> > -		.stack		=3D regs->u_regs[UREG_FP],
> >  	};
> > =20
> > +	synchronize_user_stack();
> > +
> > +	orig_i1 =3D regs->u_regs[UREG_I1];
> > +	/* Reuse the parent's stack for the child. */
> > +	args.stack =3D regs->u_regs[UREG_FP];
> > +
> >  	ret =3D kernel_clone(&args);
> > =20
> >  	/* If we get an error and potentially restart the system
> > @@ -40,16 +44,19 @@ asmlinkage long sparc_fork(struct pt_regs *regs)
> > =20
> >  asmlinkage long sparc_vfork(struct pt_regs *regs)
> >  {
> > -	unsigned long orig_i1 =3D regs->u_regs[UREG_I1];
> > +	unsigned long orig_i1;
> >  	long ret;
> > -
> >  	struct kernel_clone_args args =3D {
> >  		.flags		=3D CLONE_VFORK | CLONE_VM,
> >  		.exit_signal	=3D SIGCHLD,
> > -		/* Reuse the parent's stack for the child. */
> > -		.stack		=3D regs->u_regs[UREG_FP],
> >  	};
> > =20
> > +	synchronize_user_stack();
> > +
> > +	orig_i1 =3D regs->u_regs[UREG_I1];
> > +	/* Reuse the parent's stack for the child. */
> > +	args.stack =3D regs->u_regs[UREG_FP];
> > +
> >  	ret =3D kernel_clone(&args);
> > =20
> >  	/* If we get an error and potentially restart the system
> > @@ -65,15 +72,18 @@ asmlinkage long sparc_vfork(struct pt_regs *regs)
> > =20
> >  asmlinkage long sparc_clone(struct pt_regs *regs)
> >  {
> > -	unsigned long orig_i1 =3D regs->u_regs[UREG_I1];
> > -	unsigned int flags =3D lower_32_bits(regs->u_regs[UREG_I0]);
> > +	unsigned long orig_i1;
> > +	unsigned int flags;
> >  	long ret;
> > +	struct kernel_clone_args args =3D {0};
> > =20
> > -	struct kernel_clone_args args =3D {
> > -		.flags		=3D (flags & ~CSIGNAL),
> > -		.exit_signal	=3D (flags & CSIGNAL),
> > -		.tls		=3D regs->u_regs[UREG_I3],
> > -	};
> > +	synchronize_user_stack();
> > +
> > +	orig_i1 =3D regs->u_regs[UREG_I1];
> > +	flags =3D lower_32_bits(regs->u_regs[UREG_I0]);
> > +	args.flags		=3D (flags & ~CSIGNAL);
> > +	args.exit_signal	=3D (flags & CSIGNAL);
> > +	args.tls		=3D regs->u_regs[UREG_I3];
> > =20
> >  #ifdef CONFIG_COMPAT
> >  	if (test_thread_flag(TIF_32BIT)) {
>=20
> I have tested the patch with the following test program written by Michae=
l Karcher
> on a Sun Netra 240 running kernel version 6.19-rc5 by applying the patch =
on top:
>=20
> glaubitz@raverin:~$ cat attack_on_the_clone.c
> // SPARC64 clone problem demonstration
> //
> // the sparc64 Linux kernel fails to execute clone if %sp points into unc=
ommitted memory (e.g. due to lazy
> // stack committing). This program uses a variable length array on the st=
ack to position the stack pointer when
> // invoking the library function clone just at a page boundary. The libra=
ry function clone allocates a stack frame
> // that is completely in uncommitted memory before entering the kernel ca=
ll clone.
>=20
> // to probe for the correct size of the VLA, a test function is called fi=
rst. This function records the %fp value it
> // receives (which will be the %fp value in the library function clone, t=
oo, if the VLA size is equal)
>=20
> // (c) Michael Karcher (kernel@mkarcher.dialup.fu-berlin.de) , 2024, GPLv=
2 or later
>=20
> #define _GNU_SOURCE
>=20
> #include <sys/mman.h>
> #include <sys/wait.h>
> #include <sched.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <stdint.h>
>=20
> #define SPARC64_STACK_BIAS 0x7FF
>=20
> typedef int fn_t(void*);
> typedef pid_t clone_t(fn_t* entry, void* stack, int flags, void* arg, ...=
);
>=20
>=20
> // very simple function invoked using clone
> int nop(void* bar)
> {
>         return 0;
> }
>=20
>=20
> // clone substitute that records %fp
> uint64_t call_clone_sp;
>=20
> pid_t dummy_clone(fn_t* entry, void* stack, int flags, void* arg, ...)
> {
>         register uint64_t frameptr asm("fp");
>         call_clone_sp =3D frameptr + SPARC64_STACK_BIAS;  // sp in call_c=
lone is fp in dummy_clone / clone
>         return -1;
> }
>=20
>=20
> // function to invoke clone with (im)properly aligned stack
> void* child_stack;
>=20
> int call_clone(int waste_qwords, clone_t* clonefn)
> {
>         void* volatile waste[waste_qwords+2];  // volatile to not optimiz=
e the array away
>         waste[waste_qwords+1] =3D NULL;
>=20
>         pid_t child_pid =3D clonefn(nop,
>                        child_stack,
>                        CLONE_VM | SIGCHLD,
>                        0);
>         if (child_pid > 0)
>         {
>                 pid_t waitresult =3D waitpid(child_pid, NULL, 0);
>                 // before fork-bombing anything if this doesn't go to pla=
n, exit
>                 if (waitresult !=3D child_pid) abort();
>                 return 0;
>         }
>         else
>         {
>                 return -1;
>         }
> }
>=20
> int main(void)
> {
>         int wasteamount;
>         child_stack =3D mmap(NULL, 16384, PROT_READ | PROT_WRITE, MAP_ANO=
N | MAP_PRIVATE, -1, 0);
>         call_clone(0, dummy_clone);
>         printf("effective FP in clone() with waste 0 =3D %llx\n", call_cl=
one_sp);
>         wasteamount =3D 1024 + (call_clone_sp & 0xFFF) / 8;
>         printf("this is %d 64-bit words above the page boundary at least =
8K away\n", wasteamount);
>         child_stack =3D (void*)((char*)child_stack + 16000);
>         clone(NULL, NULL, 0, 0); // fails, but resolves "clone"
>         // failes for wasteamount-22 to wasteamount+22 (only even values =
tested)
>         if (call_clone(wasteamount, clone) < 0)
>         {
>                 perror("clone");
>         }
>         else
>         {
>                 puts("Congratulations, clone succeeded\n");
>         }
> }
>=20
> glaubitz@raverin:~$ gcc -o attack_on_the_clone attack_on_the_clone.c
> glaubitz@raverin:~$
>=20
> Without the patch:
>=20
> glaubitz@raverin:~$ uname -a
> Linux raverin 6.19.0-rc5 #19 Sat Jan 17 06:32:58 UTC 2026 sparc64 GNU/Lin=
ux
> glaubitz@raverin:~$ ./attack_on_the_clone=20
> effective FP in clone() with waste 0 =3D 7feffe60de0
> this is 1468 64-bit words above the page boundary at least 8K away
> clone: Bad address
> glaubitz@raverin:~$
>=20
> With the patch:
>=20
> glaubitz@raverin:~$ uname -a
> Linux raverin 6.19.0-rc5+ #20 Sat Jan 17 06:40:52 UTC 2026 sparc64 GNU/Li=
nux
> glaubitz@raverin:~$ ./attack_on_the_clone=20
> effective FP in clone() with waste 0 =3D 7fefffaede0
> this is 1468 64-bit words above the page boundary at least 8K away
> Congratulations, clone succeeded
>=20
> glaubitz@raverin:~$
>=20
> I can therefore confirm that this patch fixes the bug.
>=20
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Forgot to mention: I reverted the workaround in glibc [1] for testing.

Adrian

> [1] https://sourceware.org/git/gitweb.cgi?p=3Dglibc.git;h=3D234458024300f=
0b4b430785999f33eddf059af6a

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

