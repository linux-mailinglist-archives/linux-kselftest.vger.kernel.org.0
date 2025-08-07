Return-Path: <linux-kselftest+bounces-38444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B885B1D443
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 10:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC084189F114
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F075E24E4B4;
	Thu,  7 Aug 2025 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TU5nEZ8P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420E1B7F4
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754555267; cv=none; b=edVAw5uXxldVCC9/Og6bO0Ih0/GTv+SjKCifFYoQx0PBdVCgjH5ClUJfjNJgDRz2kiCOHyEDY3M10j0KXi1GJsQ/ObxM4VP5RoPo0fimVzqwr9t2sSbn8aauVazbvNr9kRSR/UbL4uBp6sXv1w0tsN0x8k3HzMjXgqYOHQTLsrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754555267; c=relaxed/simple;
	bh=wQefuaorp9x2+iC+U7LVaZGnAnYxvKAf6jocxcyUsKQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YHdPLFKvigq7GWSydFn7yCxCAeY4M1BrZp4tf+6jOD6QVGaTcTJyTSUNYjHLfeClA5dIdr0w1VWPqSK1Ck8LPY4wAOSEGUsV0hqytSKN+XMAXgUMo0GH8f5RZiDjgSOTtXL9eBKmFhJlw+ujmJ4zE1W3eKdz0eOznuROAb6f+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TU5nEZ8P; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23fd91f2f8bso5272065ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 01:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754555265; x=1755160065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vtZ6qEjcenL9MHWaCdG5/xReaOz82Rc4Yl0gbz6jebg=;
        b=TU5nEZ8PiQgnNvG8h+T4sR/pESNfrsHoWOzCVnjHs7eX59QkruvYjwjdCeAzn2vtYz
         /Sz1M2U0yAlw9QQ4/yxznSh8zbFd8rAQq4vWCS9HJ7MNdKeRBWugSlljQf78PKAv8wi1
         TIFFdESbWJv9wjoMKuHizSH+slxmBexY9muu2BHmC3d8aWKnddIYBqcgZyvHrvPzjVqQ
         Pi/DcekwRsyLxWePkek6+vBESm2xPHXOzPSu7W8f6ksuSleAGm+Hmv/f/JYMZruXeSm6
         jXL9NdHUsX8eFe6v+jX1n54bbPSLhypfbJWrnrRmplaOO2N+MJQbH90FPvtvfeZRGJGB
         E6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754555265; x=1755160065;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtZ6qEjcenL9MHWaCdG5/xReaOz82Rc4Yl0gbz6jebg=;
        b=jUCgSOCDZXebi6BLLFwawSkwPYxCje5hFn0rJn+my/uDZmJWj65zImRxzcBmnj2Kr6
         oAqtnfLdKqHyU4Qp7dMCUr5D9b8PrSMN553OSxnzkXAhhkUBz8+H/JcKEG6ADtbVACNr
         0CX5T4xfS+jStiX/JCut8mkJYx2zSU6JRT4gQg6k1B9aEvqfS3RqYUZ6lseKy8J1zRY3
         2rTWhLG6atepQP1qJ61833d/rdV81+omjqE+e6pV5dsDZDttO0lY2/gqkj7F34DkFe48
         i5Fiom4NTzICHb6QqQxYw5Len2MvpbjK5IGrI1RvIk1WeXkdUQ5DH+aMXdW+GI3gRjMD
         LK6w==
X-Forwarded-Encrypted: i=1; AJvYcCUtE0ejlkUqW4LuTOIYK9ktrXZTc0g1jAPVaF08ZquEtdzO/RfcxaID2Im9MP9N6yfm/ic8lvH02lIlitTuIdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwetCEZEC2gPAkC19POdFkh+AMFWhIXPtMPuv/n6SfuNaWZhm78
	6mzOQhBVzsPvu2WppKTXbxwXuNrelXcbNVSfCQ0L5CNAg9KSfUSuTyDXgxeiABIQ0tKftIpBwGe
	m3gGh9VfwvPoO3Tr5R3yNXg8mcBQrr7UN5xZ6xLIPPg==
X-Gm-Gg: ASbGncs5nYn5/wepnl2BW3uUQga3bdEu3hzMVgZD/b2ItpyXj5JkNLKP3yYrvR3v8jx
	3bB2uyX8CWj/+3/ZYXY0iSFz1Suh/j/ndqs3dcGwzyWWjrL8XC6d9XbFQDQgK0hJ/+HUaaZ/IYH
	kEud0haumkydiZ+q5xGOSkmFBkPVpsRKyMN1sTqI7eyy+UO25oKRzbRdk7DRItT2ZTssy6pLMeD
	3GxNWamyrRTWOv2sXUgcpG3WCvaZrU2SmVocfAt
X-Google-Smtp-Source: AGHT+IG090lvuakWHoCesKEHG/8FV69SOxDuNH9rLcZUnqgjT9x3D1J+oMPFACpctkhGwiVLlbZqH5w8lUruqCh92Y0=
X-Received: by 2002:a17:903:3bce:b0:242:8a7:6a6c with SMTP id
 d9443c01a7336-2429f32c024mr91984475ad.17.1754555265025; Thu, 07 Aug 2025
 01:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 7 Aug 2025 13:57:34 +0530
X-Gm-Features: Ac12FXzlLNIJAbNMG5_Ik7bZZCMv8iz6h3sAFL5MIIrcVzRLBwRvVd6YtBeMaBs
Message-ID: <CA+G9fYtktEOzRWohqWpsGegS2PAcYh7qrzAr=jWCxfUMEvVKfQ@mail.gmail.com>
Subject: next-20250805: ampere: WARNING: kernel/cgroup/cpuset.c:1352 at remote_partition_disable
To: Cgroups <cgroups@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, kamalesh.babulal@oracle.com
Content-Type: text/plain; charset="UTF-8"

Regressions noticed intermittently on AmpereOne while running selftest
cgroup testing
with Linux next-20250805 and earlier seen on next-20250722 tag also.

Regression Analysis:
- New regression? Yes
- Reproducibility? Intermittent

First seen on the next-20250722 and after next-20250805.

Test regression: next-20250805 ampere WARNING kernel cgroup cpuset.c
at remote_partition_disable

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log
selftests: cgroup: test_cpuset_prs.sh
Running state tRunning state transition test ...
ransition test ...
Running test 0 ...
Running test 1 ...
Running test 2 ...
Running test 3 ...
Running test 4 ...
Running test 5 ...
Running test 6 ...
Running test 7 ...
Running test 8 ...
Running test 9 ...
Running test 10 ...
Running test 11 ...
Running test 12 ...
Running test 13 ...
Running test 14 ...
Running test 15 ...
Running test 16 ...
Running test 17 ...
Running test 18 ...
Running test 19 ...
[  137.504549] psci: CPU2 killed (polled 0 ms)
[  137.747094] Detected PIPT I-cache on CPU2
[  137.747214] GICv3: CPU2: found redistributor 3500 region 0:0x0000400201cc0000
[  137.747312] CPU2: Booted secondary processor 0x0000003500 [0xc00fac40]

<>

Running test 63 ...
Running test 64 ...
Running test 66 ...
[  174.929535] psci: CPU3 killed (polled 0 ms)
[  175.263087] Detected PIPT I-cache on CPU3
[  175.263203] GICv3: CPU3: found redistributor 3501 region 0:0x0000400201d00000
[  175.263300] CPU3: Booted secondary processor 0x0000003501 [0xc00fac40]
[  175.434129] workqueue: Interrupted when creating a worker thread
"kworker/u1028:0"
** replaying previous printk message **
[  175.434129] workqueue: Interrupted when creating a worker thread
"kworker/u1028:0"
[  175.440230] ------------[ cut here ]------------
[  175.440234] WARNING: kernel/cgroup/cpuset.c:1352 at
remote_partition_disable+0x120/0x160, CPU#170: rmdir/33763
[  175.467456] Modules linked in: cdc_ether usbnet sm3_ce sha3_ce nvme
nvme_core xhci_pci_renesas arm_cspmu_module ipmi_devintf arm_spe_pmu
ipmi_msghandler arm_cmn cppc_cpufreq fuse drm backlight
[  175.484676] CPU: 170 UID: 0 PID: 33763 Comm: rmdir Not tainted
6.16.0-next-20250805 #1 PREEMPT
[  175.493365] Hardware name: Inspur NF5280R7/Mitchell MB, BIOS
04.04.00004001 2025-02-04 22:23:30 02/04/2025
[  175.503178] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
not ok 12 selftests: cgroup: test_cpuset_prs.sh TIMEOUT 45 seconds
[  175.510130] pc : remote_partition_disable
(kernel/cgroup/cpuset.c:1352 (discriminator 1)
kernel/cgroup/cpuset.c:1342 (discriminator 1)
kernel/cgroup/cpuset.c:1514 (discriminator 1))
[  175.518032] lr : remote_partition_disable
(kernel/cgroup/cpuset.c:1352 (discriminator 1)
kernel/cgroup/cpuset.c:1514 (discriminator 1))
[  175.525849] sp : ffff8000c853bb90
[  175.529585] x29: ffff8000c853bb90 x28: ffff00017badc800 x27: 0000000000000000
timeout set to 45
[  175.536713] x26: 0000000000000000 x25: ffff00014c422540 x24: ffffb1c71020b000
[  175.545489] x23: ffff000113769c00 x22: 0000000000000001 x21: ffffb1c71020b5c0
[  175.552615] x20: ffff8000c853bbd0 x19: ffff000113769a00 x18: 00000000ffffffff
selftests: cgroup: test_cpuset_v1_hp.sh
[  175.559910] x17: 31752f72656b726f x16: 776b222064616572 x15: 68742072656b726f
[  175.569900] x14: 0000000000000004 x13: ffffb1c70fb4f160 x12: 0000000000000000
cpuset v1 mount point not found!
[  175.577888] x11: 000002f6b9bf58c3 x10: 0000000000000023 x9 : ffffb1c70d6bdff8
Test SKIPPED
ok 13 selftests: cgroup: test_cpuset_v1_hp.sh #SKIP
[  175.587877] x8 : ffff8000c853bad0 x7 : 0000000000000000 x6 : 0000000000000001
[  175.597864] x5 : ffffb1c70e87a488 x4 : fffffdffc40a88e0 x3 : 000000000080007d
[  175.607849] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000fffffff4
[  175.615578] Call trace:
[  175.618013] remote_partition_disable (kernel/cgroup/cpuset.c:1352
(discriminator 1) kernel/cgroup/cpuset.c:1342 (discriminator 1)
kernel/cgroup/cpuset.c:1514 (discriminator 1)) (P)
[  175.623057] update_prstate (include/linux/spinlock.h:376
kernel/cgroup/cpuset.c:2963)
[  175.626799] cpuset_css_killed (kernel/cgroup/cpuset.c:3598)
[  175.630713] kill_css.part.0 (kernel/cgroup/cgroup.c:5968)
[  175.634464] cgroup_destroy_locked (kernel/cgroup/cgroup.c:6058
(discriminator 4))
[  175.638810] cgroup_rmdir (kernel/cgroup/cgroup.c:6102)
[  175.642376] kernfs_iop_rmdir (fs/kernfs/dir.c:1286)
[  175.646203] vfs_rmdir (fs/namei.c:4461 fs/namei.c:4438)
[  175.649515] do_rmdir (fs/namei.c:4516 (discriminator 1))
[  175.652823] __arm64_sys_unlinkat (fs/namei.c:4690 (discriminator 2)
fs/namei.c:4684 (discriminator 2) fs/namei.c:4684 (discriminator 2))
[  175.656998] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:54)
[  175.660738] el0_svc_common.constprop.0
(include/linux/thread_info.h:135 (discriminator 2)
arch/arm64/kernel/syscall.c:140 (discriminator 2))
[  175.665431] do_el0_svc (arch/arm64/kernel/syscall.c:152)
[  175.668735] el0_svc (arch/arm64/include/asm/irqflags.h:82
(discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
arch/arm64/kernel/entry-common.c:169 (discriminator 1)
arch/arm64/kernel/entry-common.c:182 (discriminator 1)
arch/arm64/kernel/entry-common.c:880 (discriminator 1))
[  175.671877] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:899)
[  175.676052] el0t_64_sync (arch/arm64/kernel/entry.S:596)
[  175.679705] ---[ end trace 0000000000000000 ]---


## Source
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: afec768a6a8fe7fb02a08ffce5f2f556f51d4b52
* Git describe: next-20250805
* Architectures: arm64
* Toolchains: gcc-13
* Kconfigs: defconfig+selftests/*/configs

## Build
* Test log 1: https://qa-reports.linaro.org/api/testruns/29220998/log_file/
* Test log 2: https://qa-reports.linaro.org/api/testruns/29395866/log_file/
* LAVA log: https://lkft-staging.validation.linaro.org/scheduler/job/187100#L6621
* Test history:
https://regressions.linaro.org/lkft/linux-next-master-ampere/next-20250805/log-parser-test/exception-warning-kernelcgroupcpuset-at-remote_partition_disable/history/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/ampere/projects/ci/tests/30rj0dIdTXUiGfYMA7suavpa77r
* Build link: https://storage.tuxsuite.com/public/ampere/ci/builds/30rj0OYSDUMeT0cyTDioTe5XVOI/
* Kernel config:
https://storage.tuxsuite.com/public/ampere/ci/builds/30rj0OYSDUMeT0cyTDioTe5XVOI/config

--
Linaro LKFT
https://lkft.linaro.org

