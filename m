Return-Path: <linux-kselftest+bounces-13441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF7B92CBD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 09:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC411F23727
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 07:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB3D8288F;
	Wed, 10 Jul 2024 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slyHklQc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49BE77109;
	Wed, 10 Jul 2024 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595931; cv=none; b=nkvQp5KFYQ3EzQLAwYIdpeuVzKhmegYm2chhJywzDShWfJ46yoRhFEg1tmtedzo+wJZ4WsbwXCU1ZqU2NtajjlCGHJIyM4XVdsJxHDsN26HQfTxS0QBRlxJzjEbXvDGVABZOeu8wvxjj3ro48mak54+dkzZTiQ9DaINV7T7rZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595931; c=relaxed/simple;
	bh=rqmifjrlxx3s7RcDnkE3IqBzuxCRT6+ff8aBkU6UQOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LteZzpcD5GTSgIk/Bbnp/Cq1190P3Np4ZH3RDbbR9jboUgGBaZmJTT3gmE8ySIlTq/hv/6WUaz8YffW6bCgflKUGyzlPh2OlkbmwyUlBaQFk2c6ypc0AVbghlxIwZ7MQ2VPCO5aacrtSSpefrI2b00YffZUQUUvZVh2pTE7sMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slyHklQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A071C32781;
	Wed, 10 Jul 2024 07:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720595930;
	bh=rqmifjrlxx3s7RcDnkE3IqBzuxCRT6+ff8aBkU6UQOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=slyHklQc95X/EDQbl1cTV1CxnT6/yvB1welQymjILaAWt4sb2cBJwNlE/rp7OqQcI
	 ZpkXVxCsZrJo3MOdN8NM+GoZ5Q4vrrfOYWVeFRw/qBHwuVNofb9IDXSBPJ4cwZr2el
	 ZXq367YJPNI0WN1Izf3KdaWm8o1w3VTz+jfw2ndJY7DEIyL8wa+mJw5AnUxhXdMzv1
	 mNAgxDWZ/n/9kU8JeHyqlqU4euDuFcwhYjbSLk/M+ygVJ9Kb9xgY1/ZQjS7IG58cdW
	 J+GlHi+1EMGuqNsPVkSfqalt35X4XuBgk/R1D2XFwiXSFlZIybgMzaCr6Qu8WhGPAQ
	 gqs2hVkB23EOQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Manu Bretelle <chantra@meta.com>, Daniel Borkmann
 <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>, Alexei Starovoitov
 <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Florent
 Revest <revest@google.com>
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
In-Reply-To: <SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com>
References: <20240705145009.32340-1-puranjay@kernel.org>
 <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org>
 <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
 <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net>
 <mb61ped836gn7.fsf@kernel.org>
 <d36b0c2e-fdf2-d3b0-46a8-7936e0eda5a8@iogearbox.net>
 <CACYkzJ5E+3xYkNsH7JoVkjabzSwnZZCzzTz5B50qDB7bLYkmMA@mail.gmail.com>
 <890d23f2-636e-12d1-31cc-eb6469f2a9ac@iogearbox.net>
 <SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com>
Date: Wed, 10 Jul 2024 07:18:23 +0000
Message-ID: <mb61p34ohsojk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


[SNIP]

>
> Hm, the latest run actually hangs in fexit_sleep (which is the test right=
 after
> fexit_bpf2bpf). So looks like this was too early. It seems some CI runs p=
ass on
> arm64 but others fail:
>
> =C2=A0=C2=A0 https://github.com/kernel-patches/bpf/actions/runs/985982685=
1/job/27224868398=C2=A0(fail)
> =C2=A0=C2=A0 https://github.com/kernel-patches/bpf/actions/runs/985983721=
3/job/27224955045=C2=A0(pass)
>
> Puranjay, do you have a chance to look into this again?
>
> Probably unrelated... but when I tried to reproduce this using qemu in fu=
ll emulation mode [0], I am getting a kernel crash for fexit_sleep, but als=
o for fexit_bpf2bpf, fentry_fexit
>
> stacktraces look like (for fentry_fexit)
>
>
> root@(none):/mnt/vmtest/selftests/bpf# ./test_progs -v -t fentry_fexit
> bpf_testmod.ko is already unloaded.
> Loading bpf_testmod.ko...
> Successfully loaded bpf_testmod.ko.
> test_fentry_fexit:PASS:fentry_skel_load 0 nsec
> test_fentry_fexit:PASS:fexit_skel_load 0 nsec
>
> test_fentry_fexit:PASS:fentry_attach 0 nsec
> test_fentry_fexit:PASS:fexit_attach 0 nsec
> Unable to handle kernel paging request at virtual address ffff0000c2a80e68
> Mem abort info:
>   ESR =3D 0x0000000096000004
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0
>   FSC =3D 0x04: level 0 translation fault
> Data abort info:
>   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
>   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> swapper pgtable: 4k pages, 52-bit VAs, pgdp=3D0000000041b4a000
> [ffff0000c2a80e68] pgd=3D1000000042f28003, p4d=3D0000000000000000
> Internal error: Oops: 0000000096000004 [#1] SMP
> Modules linked in: bpf_testmod(OE) [last unloaded: bpf_testmod(OE)]
> CPU: 0 PID: 97 Comm: test_progs Tainted: G           OE      6.10.0-rc6-g=
b0eedd920017-dirty #67
> Hardware name: linux,dummy-virt (DT)
> pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=3D--)
> pc : __bpf_tramp_enter+0x58/0x190
> lr : __bpf_tramp_enter+0xd8/0x190
> sp : ffff800084afbc10
> x29: ffff800084afbc10 x28: fff00000c28c2e80 x27: 0000000000000000
> x26: 0000000000000000 x25: 0000000000000050 x24: 0000000000000000
> x23: 000000000000000a x22: fff00000c28c2e80 x21: 0000ffffed100070
> x20: ffff800082032938 x19: ffff0000c2a80c00 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffed100070
> x14: 0000000000000000 x13: ffff800082032938 x12: 0000000000000000
> x11: 0000000000020007 x10: 0000000000000007 x9 : 00000000ffffffff
> x8 : 0000000000004008 x7 : ffff80008218fa78 x6 : 0000000000000000
> x5 : 0000000000000001 x4 : 0000000086db7919 x3 : 0000000095481a34
> x2 : 0000000000000001 x1 : fff00000c28c2e80 x0 : 0000000000000001
> Call trace:
>  __bpf_tramp_enter+0x58/0x190
>  bpf_trampoline_6442499844+0x44/0x158
>  bpf_fentry_test1+0x8/0x10
>  bpf_prog_test_run_tracing+0x190/0x328
>  __sys_bpf+0x844/0x2148
>  __arm64_sys_bpf+0x2c/0x48
>  invoke_syscall+0x4c/0x118
>  el0_svc_common.constprop.0+0x48/0xf0
>  do_el0_svc+0x24/0x38
>  el0_svc+0x4c/0x120
>  el0t_64_sync_handler+0xc0/0xc8
>  el0t_64_sync+0x190/0x198
> Code: 52800001 97f9f3df 942a3be8 35000400 (f9413660)
> ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Oops: Fatal exception
> SMP: stopping secondary CPUs
> Kernel Offset: disabled
> CPU features: 0x00,00000006,8c13bd78,576676af
> Memory Limit: none
>
> For "fexit_sleep" and "fexit_bpf2bpf" respectively:
>
>
>  $ ( cd  9859826851 && vmtest -k kbuild-output/arch/arm64/boot/Image.gz -=
r ../aarch64-rootfs -a aarch64 '/bin/mount bpffs /sys/fs/bpf -t bpf && ip l=
ink set lo up && cd /mnt/vmtest/selftests/bpf/ && ./test_progs -v -t fexit_=
sleep' )
> =3D> Image.gz
> =3D=3D=3D> Booting
> =3D=3D=3D> Setting up VM
> =3D=3D=3D> Running command
> root@(none):/# bpf_testmod: loading out-of-tree module taints kernel.
> bpf_testmod: module verification failed: signature and/or required key mi=
ssing - tainting kernel
> Unable to handle kernel paging request at virtual address ffff0000c19c2668
> Mem abort info:
>   ESR =3D 0x0000000096000004
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0
>   FSC =3D 0x04: level 0 translation fault
> Data abort info:
>   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
>   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> swapper pgtable: 4k pages, 52-bit VAs, pgdp=3D0000000041b4a000
> [ffff0000c19c2668] pgd=3D1000000042f28003, p4d=3D0000000000000000
> Internal error: Oops: 0000000096000004 [#1] SMP
> Modules linked in: bpf_testmod(OE)
> CPU: 1 PID: 91 Comm: test_progs Tainted: G           OE      6.10.0-rc6-g=
b0eedd920017-dirty #67
> Hardware name: linux,dummy-virt (DT)
> pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=3D--)
> pc : __bpf_tramp_enter+0x58/0x190
> lr : __bpf_tramp_enter+0xd8/0x190
> sp : ffff800084c4bda0
> x29: ffff800084c4bda0 x28: fff00000c274ae80 x27: 0000000000000000
> x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> x23: 0000000060001000 x22: 0000ffffa36b7a54 x21: 00000000ffffffff
> x20: ffff800082032938 x19: ffff0000c19c2400 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000000 x13: ffff800082032938 x12: 0000000000000000
> x11: 0000000000020007 x10: 0000000000000007 x9 : 00000000ffffffff
> x8 : 0000000000004008 x7 : ffff80008218fa78 x6 : 0000000000000000
> x5 : 0000000000000001 x4 : 0000000086db7919 x3 : 0000000095481a34
> x2 : 0000000000000001 x1 : fff00000c274ae80 x0 : 0000000000000001
> Call trace:
>  __bpf_tramp_enter+0x58/0x190
>  bpf_trampoline_6442487232+0x44/0x158
>  __arm64_sys_nanosleep+0x8/0xf0
>  invoke_syscall+0x4c/0x118
>  el0_svc_common.constprop.0+0x48/0xf0
>  do_el0_svc+0x24/0x38
>  el0_svc+0x4c/0x120
>  el0t_64_sync_handler+0xc0/0xc8
>  el0t_64_sync+0x190/0x198
> Code: 52800001 97f9f3df 942a3be8 35000400 (f9413660)
> ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Oops: Fatal exception
> SMP: stopping secondary CPUs
> Kernel Offset: disabled
> CPU features: 0x00,00000006,8c13bd78,576676af
> Memory Limit: none
> Failed to run command
>
> Caused by:
>     0: Failed to QGA guest-exec-status
>     1: error running guest_exec_status
>     2: Broken pipe (os error 32)
>     3: Broken pipe (os error 32)
> [11:46:14] chantra@devvm17937:scratchpad $
> [11:47:56] chantra@devvm17937:scratchpad $
> [11:47:57] chantra@devvm17937:scratchpad $ ( cd  9859826851 && vmtest -k =
kbuild-output/arch/arm64/boot/Image.gz -r ../aarch64-rootfs -a aarch64 '/bi=
n/mount bpffs /sys/fs/bpf -t bpf && ip link set lo up && cd /mnt/vmtest/sel=
ftests/bpf/ && ./test_progs -v -t fexit_bpf2bpf' )
> =3D> Image.gz
> =3D=3D=3D> Booting
> =3D=3D=3D> Setting up VM
> =3D=3D=3D> Running command
> root@(none):/# bpf_testmod: loading out-of-tree module taints kernel.
> bpf_testmod: module verification failed: signature and/or required key mi=
ssing - tainting kernel
> Unable to handle kernel paging request at virtual address ffff0000c278de68
> Mem abort info:
>   ESR =3D 0x0000000096000004
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0
>   FSC =3D 0x04: level 0 translation fault
> Data abort info:
>   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
>   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> swapper pgtable: 4k pages, 52-bit VAs, pgdp=3D0000000041b4a000
> [ffff0000c278de68] pgd=3D1000000042f28003, p4d=3D0000000000000000
> Internal error: Oops: 0000000096000004 [#1] SMP
> Modules linked in: bpf_testmod(OE)
> CPU: 1 PID: 87 Comm: test_progs Tainted: G           OE      6.10.0-rc6-g=
b0eedd920017-dirty #67
> Hardware name: linux,dummy-virt (DT)
> pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=3D--)
> pc : __bpf_tramp_enter+0x58/0x190
> lr : __bpf_tramp_enter+0xd8/0x190
> sp : ffff800084c4ba90
> x29: ffff800084c4ba90 x28: ffff800080a32d10 x27: ffff800080a32d80
> x26: ffff8000813e0ad8 x25: ffff800084c4bce4 x24: ffff800082fbd048
> x23: 0000000000000001 x22: fff00000c2732e80 x21: fff00000c18a3200
> x20: ffff800082032938 x19: ffff0000c278dc00 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaaabcc22aa0
> x14: 0000000000000000 x13: ffff800082032938 x12: 0000000000000000
> x11: 0000000000000000 x10: 000000000ac0d5af x9 : 000000000ac0d5af
> x8 : 00000000a4d7a457 x7 : ffff80008218fa78 x6 : 0000000000000000
> x5 : 0000000000000002 x4 : 0000000006fa0785 x3 : 0000000081d7cd4c
> x2 : 0000000000000202 x1 : fff00000c2732e80 x0 : 0000000000000001
> Call trace:
>  __bpf_tramp_enter+0x58/0x190
>  bpf_trampoline_34359738386+0x44/0xf8
>  bpf_prog_3b052b77318ab7c4_test_pkt_md_access+0x8/0x118
>  bpf_test_run+0x200/0x3a0
>  bpf_prog_test_run_skb+0x328/0x6d8
>  __sys_bpf+0x844/0x2148
>  __arm64_sys_bpf+0x2c/0x48
>  invoke_syscall+0x4c/0x118
>  el0_svc_common.constprop.0+0x48/0xf0
>  do_el0_svc+0x24/0x38
>  el0_svc+0x4c/0x120
>  el0t_64_sync_handler+0xc0/0xc8
>  el0t_64_sync+0x190/0x198
> Code: 52800001 97f9f3df 942a3be8 35000400 (f9413660)
> ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Oops: Fatal exception in interrupt
> SMP: stopping secondary CPUs
> Kernel Offset: disabled
> CPU features: 0x00,00000006,8c13bd78,576676af
> Memory Limit: none
> Failed to run command
>
> Caused by:
>     0: Failed to QGA guest-exec-status
>     1: error running guest_exec_status
>     2: Broken pipe (os error 32)
>     3: Broken pipe (os error 32)
>
>
> [0] https://chantra.github.io/bpfcitools/bpfci-troubleshooting.html


Thanks for sharing the logs,
I will try to reproduce this and find the root cause.

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZo41wBQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nff7AQD5NhgufVv5SrRGgblNq+3Qs4aZtV0I
FRNSA1uNza9PhAEApV3fxx7DC631inEOVo3nM2wgD3JfnrjmAlYxxkBB6A8=
=oNqc
-----END PGP SIGNATURE-----
--=-=-=--

