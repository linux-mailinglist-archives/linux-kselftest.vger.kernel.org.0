Return-Path: <linux-kselftest+bounces-47089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9502CA5EB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 03:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E9A83032E04
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 02:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CB225DB0D;
	Fri,  5 Dec 2025 02:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NqexNUvC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D399423EAA4;
	Fri,  5 Dec 2025 02:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764902461; cv=none; b=m1xOnOVPNJj3uovyfRsHQvZ4voMRNhO7yJLzln797klk8qkydfDOfvmKpFDMqPGQLlR0l84tB8EJloQriHBCq91+MNSbCHl+HfVW1zhvizvAiJaZFBz2NbxTOUxPsmrxStRLccpntpdCkNSlgB3kfXmMiiage43mMwA7YGs3EF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764902461; c=relaxed/simple;
	bh=YWPgp6ETHw0rQCvXyVjOuRlG44uPU13fK/UDjtrYeoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LK1M1QeheOuehinnWHXZerrnP4xXgE+IXnnDAfrRpnxBwtBgvigqaZYKOD0EJwPNuTyWTH/BFN2fAyvbdj+GhB3FahCqJQM+J061BjDYpHTigCarYoa6wasReU3DWrqhDSBBJD5V8GRKCzX7liXNmIpUb0zG+0aIY6+gawXGogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NqexNUvC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764902460; x=1796438460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YWPgp6ETHw0rQCvXyVjOuRlG44uPU13fK/UDjtrYeoA=;
  b=NqexNUvCln6nDFVXaRLP9dr5mCusGVhqCYQVMRXqvwvJsIh7wCFItpMy
   iLuq56ZpbY6prQiYOBj4s1jLZ+rSnL1XCrGEPnX37YTXZ31d0zYDuq4kM
   T11+lLd/PtJvnQ3AhgyzFF2dhqo8ShNOyO6VSp/97DZt3F+V+bvxnn5UR
   o5Fv5Ur1+XsaRLI/+fYaCPY2e1Ue26/HXMNKEfNQa6mwdaQbHDuzZlsdS
   aSVyW9OyS+tNbT5KMeJPNRYVNwPV88Bngemhj7HC1Yf0U9RDmAbwIA7nM
   fnpNOQGapR+5BDNDfB6v2Rx4I8eXcWizeyBGMyJLRggDwIPihkjkkcA18
   w==;
X-CSE-ConnectionGUID: elDl9+7nQRyUOOp+tuqz4w==
X-CSE-MsgGUID: MuKat/w7QgC2cx4O8hfuog==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="66657797"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="66657797"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 18:40:59 -0800
X-CSE-ConnectionGUID: xyVrV1D0SiCC7UIVyZgz1w==
X-CSE-MsgGUID: tBlcxB12S5qF4sHuSv34lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="199590264"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 18:40:52 -0800
Date: Fri, 5 Dec 2025 10:40:49 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v8 13/15] iommu/amd: Use the generic iommu page table
Message-ID: <aTJGMaqwQK0ASj0G@ly-workstation>
References: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <13-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>

Hi Alejandro Jimenez,

Greetings!

I used Syzkaller and found that there is WARNING in iommufd_fops_release in linux-next next-20251203.

After bisection and the first bad commit is:
"
789a5913b29c iommu/amd: Use the generic iommu page table
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/251204_120805_iommufd_fops_release
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/251204_120805_iommufd_fops_release/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/251204_120805_iommufd_fops_release/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/251204_120805_iommufd_fops_release/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/251204_120805_iommufd_fops_release/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/251204_120805_iommufd_fops_release/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/251204_120805_iommufd_fops_release/bzImage_b2c27842ba853508b0da00187a7508eb3a96c8f7
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/251204_120805_iommufd_fops_release/b2c27842ba853508b0da00187a7508eb3a96c8f7_dmesg.log

"
[   26.277988] ------------[ cut here ]------------
[   26.278641] WARNING: drivers/iommu/iommufd/main.c:369 at iommufd_fops_release+0x385/0x430, CPU#1: repro/724
[   26.280106] Modules linked in:
[   26.280581] CPU: 1 UID: 0 PID: 724 Comm: repro Not tainted 6.18.0-next-20251203-b2c27842ba85 #1 PREEMPT(volun
[   26.281901] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.q4
[   26.283453] RIP: 0010:iommufd_fops_release+0x385/0x430
[   26.284150] Code: 8b 45 d0 65 48 2b 05 82 16 78 05 75 7b 48 81 c4 88 00 00 00 31 c0 5b 41 5c 41 5d 41 5e 41 5e
[   26.286461] RSP: 0018:ffff8880202efba8 EFLAGS: 00010293
[   26.287290] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83be6832
[   26.288207] RDX: ffff888019104b00 RSI: ffffffff83be69a5 RDI: 0000000000000005
[   26.289136] RBP: ffff8880202efc58 R08: 0000000000000001 R09: 0000000000000001
[   26.290045] R10: 0000000000000000 R11: ffff888019105998 R12: 0000000000000000
[   26.291071] R13: ffff888022d49008 R14: ffff8880202efbf0 R15: 0000000000000000
[   26.292002] FS:  0000000000000000(0000) GS:ffff8880e31c0000(0000) knlGS:0000000000000000
[   26.293036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.293787] CR2: 00007fa6ab957000 CR3: 00000000138bb001 CR4: 0000000000770ef0
[   26.294815] PKRU: 55555554
[   26.295192] Call Trace:
[   26.295539]  <TASK>
[   26.295843]  ? locks_remove_file+0x3b4/0x5d0
[   26.296451]  ? __pfx_iommufd_fops_release+0x10/0x10
[   26.297104]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
[   26.297841]  ? evm_file_release+0x140/0x220
[   26.298439]  ? __pfx_iommufd_fops_release+0x10/0x10
[   26.299193]  __fput+0x41f/0xb70
[   26.299670]  ____fput+0x22/0x30
[   26.300113]  task_work_run+0x19e/0x2b0
[   26.300644]  ? __pfx_task_work_run+0x10/0x10
[   26.301229]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   26.301938]  ? switch_task_namespaces+0xdd/0x130
[   26.302579]  do_exit+0x8a3/0x28a0
[   26.303205]  ? do_group_exit+0x1d8/0x2c0
[   26.303745]  ? __pfx_do_exit+0x10/0x10
[   26.304256]  ? __this_cpu_preempt_check+0x21/0x30
[   26.304915]  ? _raw_spin_unlock_irq+0x2c/0x60
[   26.305515]  ? lockdep_hardirqs_on+0x85/0x110
[   26.306099]  ? _raw_spin_unlock_irq+0x2c/0x60
[   26.306796]  ? trace_hardirqs_on+0x26/0x130
[   26.307388]  do_group_exit+0xe4/0x2c0
[   26.307892]  __x64_sys_exit_group+0x4d/0x60
[   26.308460]  x64_sys_call+0x21a2/0x21b0
[   26.308993]  do_syscall_64+0x6d/0x1180
[   26.309509]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   26.310174] RIP: 0033:0x7fa6ab718a4d
[   26.310680] Code: Unable to access opcode bytes at 0x7fa6ab718a23.
[   26.311595] RSP: 002b:00007ffdeee343f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   26.312569] RAX: ffffffffffffffda RBX: 00007fa6ab7f69e0 RCX: 00007fa6ab718a4d
[   26.313498] RDX: 00000000000000e7 RSI: ffffffffffffff80 RDI: 0000000000000000
[   26.314442] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000020
[   26.315466] R10: 00007ffdeee342a0 R11: 0000000000000246 R12: 00007fa6ab7f69e0
[   26.316385] R13: 00007fa6ab7fbf00 R14: 0000000000000001 R15: 00007fa6ab7fbee8
[   26.317323]  </TASK>
[   26.317642] irq event stamp: 2083
[   26.318092] hardirqs last  enabled at (2091): [<ffffffff81666d75>] __up_console_sem+0x95/0xb0
[   26.319467] hardirqs last disabled at (2214): [<ffffffff81666d5a>] __up_console_sem+0x7a/0xb0
[   26.320566] softirqs last  enabled at (2212): [<ffffffff8148a2fe>] __irq_exit_rcu+0x10e/0x170
[   26.321679] softirqs last disabled at (2099): [<ffffffff8148a2fe>] __irq_exit_rcu+0x10e/0x170
[   26.322880] ---[ end trace 0000000000000000 ]---
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 


