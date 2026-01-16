Return-Path: <linux-kselftest+bounces-49176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E46D337D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 17:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6683C30704C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016E9341063;
	Fri, 16 Jan 2026 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="VpNNNLE6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51C4340DB1;
	Fri, 16 Jan 2026 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768580819; cv=none; b=hQjiTlgQZeLytaErtxZD2Otx2hpwU2G+hzO7ifnqntdsWwoNqQNb+Nd/QdmX99F3uVqiNmQCrmvrDGG4v7m9zO2hnhKKtYvExPJXZ2kBMxEo3jgp/PJ2MFihwp1XrGFd08L+IkxUcSHkPEhlgkzW0YkC2fudaQxpcHRC+It5Vvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768580819; c=relaxed/simple;
	bh=KHAb/sp4ooI/6E3KhxCD0CSVBx7RAYaOdbarZf3Mn0Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gJVQM7tF9pZDH+AoBfUhzGd/jiob6ID41AUK3QODD8rQTuiKduTwtmEfKWZoYqDdB63qGCYzbWN3V3yXS5Clg/K2cSIR557UYzWtY3uggJDycMTMmDt2XjHvxH0iAUnSF654DZqDM7hP+JkXp7xTlIz6hqxfp5PCAHEm39aRIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=VpNNNLE6; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=3tIaHT+c2BRHxWw1W0L9MXwMu4we8XlylZLzvqYxjR0=; t=1768580817;
	x=1769185617; b=VpNNNLE6glOe01LX/WWqECln8JJzf2h9ohl+P8Lx3qVI3NTmt5MRpn7W8PVU+
	iKJU6Lr6CGbS2H12QQAP8JMj8wthqkzYCUwuZ34xYsayQM6KmFBGs3YRDJRfqZVzc+pav0jHt2bNC
	mReVsuJWJF66ONKU7ElJGh92eDsaOh4cY0/o2k6hg6RxHKhoAuoGzCZcPSLpvYZwjuTmVyETWxmVZ
	ySg3v9Yah/vxi3nrcWlkPWFd6+Rt+vQ1OiNqd36uchkaa2hPpbD4lCcMJhOsWeEx3RUyYk7nHPijD
	of4+c84VDMEAZg7QI/d1cDFd+OBqI8m1/tAunHrpvkgeUvVmNg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vgmf0-00000003Ktg-0dYm; Fri, 16 Jan 2026 17:26:54 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vgmez-00000000dSt-3qgE; Fri, 16 Jan 2026 17:26:54 +0100
Message-ID: <a96388fa07a97b2a27f4d3ac43f7019584ad4a15.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/3] sparc: Add architecture support for clone3
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>, davem@davemloft.net, 
	andreas@gaisler.com, brauner@kernel.org, shuah@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, arnd@arndb.de, geert@linux-m68k.org, 
	schuster.simon@siemens-energy.com
Date: Fri, 16 Jan 2026 17:26:53 +0100
In-Reply-To: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
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
> This series adds support for the clone3 system call to the SPARC{32|64}
> architectures and also adds a related patch for clone/fork/vfork that fix=
 an
> issue previously reported[1] that could result in -EFAULT for no good rea=
son.
> Without this patch, the clone3 system call would need the same mitigation=
 as
> introduced in glibc[2] for the clone system call.
>=20
> About "sparc: Synchronize user stack on fork and clone"
> ---------------------------------------------------------
>=20
> The clone3 implementation is developed on top of a fix for an issue repor=
ted
> by Adrian Glaubitz[1], where a clone call could return -EFAULT. This prob=
lem
> has since been mitigated in glibc[2] by synchronizing the user stack befo=
re
> calling clone.
>=20
> The root cause analysis of the kernel side when running the program in [1=
]
> shows that the window spill handler routine on both SPARC{32|64} is unabl=
e to
> flush a user window to the stack (due to MMU related faults) when flushin=
g all
> windows before handling the syscall. This then results in a -EFAULT when
> copy_thread() fails to clone the uncommited stackframe of the parent.
>=20
> For SPARC32:
> Prior to calling the syscall wrappers for clone/fork/vork all windows are
> flushed by a macro (FLUSH_ALL_KERNEL_WINDOWS).
> In the window spill trap handler, MMU fault-handling is temporarily
> disabled while storing the window. If the window can't be stored
> (which normally would have triggered a fault trap) the routine
> backups the user window and increments a thread counter (wsaved).
>=20
> For SPARC64:
> Prior to calling the syscall wrappers for clone/fork/vork all windows are
> flushed by issuing the flushw instruction.
> In the window spill trap handler, if an exception triggers, then the user
> window is added to the thread's user window buffer (in kernel memory) and
> a thread counter (wsaved) counter is incremented.
>=20
> Both SPARC{32|64}:
> Eventually copy_thread will be called, which then will fail to clone the =
parent
> stackframe to the child as the user window has not been flushed to the st=
ack.
>=20
> Fixed by adding a call to synchronize_user_stack() prior to calling
> kernel_clone(). The patch has been tested both with and without the mitig=
ation
> in glibc by running the program mentioned in [1].
>=20
> SPARC32:
> - Tested in QEMU emulating sun4m using Buildroot 2025.02
>   (qemu_sparc_ss10_defconfig).
> - Tested on LEON using a GR-CPCI-GR740 development board from
>   Frontgrade Gaisler.
>=20
> SPARC64:
> - Tested in QEMU emulating sun4u using Buildroot 2025.02
>   (qemu_sparc64_sun4u_defconfig).
>=20
> About the clone3 implementation:
> --------------------------------
>=20
> The implementation in the architectural port follows the same pattern as =
for the
> original clone syscall. But instead of explicitly calling kernel_clone (a=
s in
> sparc_clone) the clone3 handler calls the generic sys_clone3 handler
> (in kernel/fork). To get this to work without a user provided stack,
> the copy_thread functions had to be updated to handle cl_args.stack =3D=
=3D NULL.
> In this case the stack of the parent is re-used.
>=20
> When applying the patch series on top of v6.19-rc1 the relevant clone3 te=
sts of
> kselftest pass:
>=20
> # /usr/lib/kselftests/run_kselftest.sh -c clone3 -s
> kselftest: Running tests in clone3
> TAP version 13
> 1..4
> # selftests: clone3: clone3
> ok 1 selftests: clone3: clone3
> # selftests: clone3: clone3_clear_sighand
> ok 2 selftests: clone3: clone3_clear_sighand
> # selftests: clone3: clone3_set_tid
> ok 3 selftests: clone3: clone3_set_tid
> # selftests: clone3: clone3_cap_checkpoint_restore
> ok 4 selftests: clone3: clone3_cap_checkpoint_restore
>=20
> Note that the clone3_cap_checkpoint test failed in the same way as mentio=
ned in
> [3] (due to incompatibility with the libcap version on my system).
> When applying the patch from [4] or by downgrading libcap to 2.59 the tes=
t pass.
>=20
> SPARC32:
> - Tested in QEMU emulating sun4m using Buildroot 2025.02
>   (qemu_sparc_ss10_defconfig).
> - Tested on LEON using a GR-CPCI-GR740 development board from
>   Frontgrade Gaisler.
>=20
> SPARC64:
> - Tested in QEMU emulating sun4u using Buildroot 2025.02
>   (qemu_sparc64_sun4u_defconfig).
> - Tested on UltraSparc T4
>=20
> [1]: https://lore.kernel.org/sparclinux/3ae4130c-c5aa-428e-b819-44cf2daf2=
af1@mkarcher.dialup.fu-berlin.de/
> [2]: https://sourceware.org/bugzilla/show_bug.cgi?id=3D31394
> [3]: https://lore.kernel.org/all/20250901-nios2-implement-clone3-v2-0-53f=
cf5577d57@siemens-energy.com/
> [4]: https://lore.kernel.org/all/20241105062948.1037011-1-zhouyuhang1010@=
163.com/
>=20
> Andreas Larsson (1):
>   sparc: Synchronize user stack on fork and clone
>=20
> Ludwig Rydberg (2):
>   sparc: Add architecture support for clone3
>   selftests/clone3: Add sys_clone3 wrapper for SPARC
>=20
>  arch/sparc/include/asm/syscalls.h             |  1 +
>  arch/sparc/include/asm/unistd.h               |  2 -
>  arch/sparc/kernel/entry.S                     | 15 ++++
>  arch/sparc/kernel/kernel.h                    |  1 +
>  arch/sparc/kernel/process.c                   | 63 ++++++++++++----
>  arch/sparc/kernel/process_32.c                |  2 +-
>  arch/sparc/kernel/process_64.c                |  2 +-
>  arch/sparc/kernel/syscalls.S                  |  6 ++
>  arch/sparc/kernel/syscalls/syscall.tbl        |  2 +-
>  .../selftests/clone3/clone3_selftests.h       | 75 +++++++++++++++++++
>  10 files changed, 150 insertions(+), 19 deletions(-)

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

