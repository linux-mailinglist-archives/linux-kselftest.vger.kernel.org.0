Return-Path: <linux-kselftest+bounces-13742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 025E69319CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 19:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8FD283106
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8514D599;
	Mon, 15 Jul 2024 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RF7ieBKb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794A022318
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Jul 2024 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721065766; cv=none; b=Vkq9Jpo05auWULMjOCmCuW/8TVSwz5epfBH7OJCyA+nhGas4jcE3w0jKRLKfdpP2V/TcIAK3s/QGfZ8xzVtA0Rl+dHwJCUCfyWZ2xJ0KfUFO/2XjFef+hg/ZINXuO1tPkPfRTl5hglSCmh2NvRRDeDQMHasnrDdH0CldeojTA4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721065766; c=relaxed/simple;
	bh=IF2yrLjoxT0h6e+1eVvUPCO0jY/8dmFWBEa0TyqEXhg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KK0moBgDVExXOFroXTzdaLTKKUa5zaHyrwnnBElWyQwOd2CASixeuI0wWIKeg51hDOjcw5QWcU7qfn+jlhOeyp+nIbCaBwRvNzy6b0dLO5J98earlNpcm3RdvUc3ao7aGwWzLhDZlhA6OUHuPf+mFr7dFgz+ZC/+nUcTPF0Nbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RF7ieBKb; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4f30331218eso2407718e0c.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jul 2024 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721065763; x=1721670563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2TCN+mtAfqSFvf2FCnrFAIjr/fY03vnJ5dZhsJkvwYQ=;
        b=RF7ieBKbq4dY75FdnVNl9QxdIF8f8yOWP4ioox+XUbyuF3xOT2y3HcIm0nASV3zTfB
         kMYPvghZwV0UN8KAvL3oCctVuKH7j7SXrALn2/9KdUgyDBcZHPO0S2rGft5GUbfDN7AA
         pth3PGA3Kr6lY3L4Bmtx9mCXuUrUn1fUFGohGrjtQrnJ3XLQNoHYWMEhZ9OsOIarNNHW
         y7zCXfk02auh20ZpMlW8W2++DpCF+Uairz/ZVPBmMyc/EwXf3hWQuQMBO5RbPFZc39GV
         XLLwJIZeaT7VZjXLWQItlL5TTq+OYGuWWPFA92M9SgiIyBtyHvaN5wKsVlVGIqz9xA+7
         iyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721065763; x=1721670563;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TCN+mtAfqSFvf2FCnrFAIjr/fY03vnJ5dZhsJkvwYQ=;
        b=qKZSx05mn2HVWmfQxkUaT1jkjcUXVz1WRfD1jwvSZTwim2mITsScQhZWH7m9hOobT6
         htn4ieKCldIMJaZbLMrQ5Spj4TmjyRG9+ucyiU9EbET0Ad+YsS5Jor/fLDICgLAYRlVX
         5Z2sxafKMAfEYYsUswl9O7gqc4I/G6bh+Y8M6gr3KULWKgv3RxOzOvHrhOXwYsIR3x3D
         Lqm2gMiD0zl8wAtGQWvssFdmw6zfI/754rQ1GBaQKIl4z8odugceYknNf2zIWRgZ+xUC
         qZSbCwboHmV2xB6EF9wNYC9YGXRwJxqkkHGGk245PQwex0RLT72vq8F5Ahu08AtCjG4H
         M8qA==
X-Forwarded-Encrypted: i=1; AJvYcCUF5iYdZiXgPh/I4gnS25ps5chetFODm+vQ23dZQdSBo9bwlYdVwUY83RZ2vQAXAB/GGz8NGtrYrnWDSFb34p0jqrS2Y1jYIc2JyTKUSTYi
X-Gm-Message-State: AOJu0Yxi5lmaAvlOyl/soVWxyUTEmJtFHya88zxW8OAgvE31/vpE+vj2
	IjGVsG71FwLLKpD9Zt1QW/ZPVMKRQtDyG2KYWYtZOpG2NaLLsKE/yn4oyVUIid6p9YcLrX1kNvB
	Rz8PFrCu2/DyOqcGNkk8o27VNdEph1ZVdMfSZEA==
X-Google-Smtp-Source: AGHT+IHmQdZH1T6f8//lyjnZOeWGMzQnj/b4V5M1kqpMLo1UsssriZE2N9YRNkxSh8XT0qhPeiQCYIl7EHJDHzWBFbU=
X-Received: by 2002:a05:6122:1796:b0:4b9:e8bd:3b2 with SMTP id
 71dfb90a1353d-4f4cd294049mr977929e0c.2.1721065763380; Mon, 15 Jul 2024
 10:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 15 Jul 2024 23:19:11 +0530
Message-ID: <CA+G9fYtg6tjSpVSN+OJRrSFhKcH5NkXVH7ccZMkXDpKjV5TYmA@mail.gmail.com>
Subject: next-20240715: WARNING: at kernel/cpu.c:527 lockdep_assert_cpus_held
 (kernel/cpu.c:527 (discriminator 7) kernel/cpu.c:516 (discriminator 7))
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, Tejun Heo <tj@kernel.org>, 
	void@manifault.com, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following kernel warnings are noticed on today's Linux next-20240715 tag
on the arm64 Raspberry Pi 4 Model B and x86_64 devices while booting.

This is always reproducible: yes.

  GOOD: next-20240712
  BAD:  next-20240715

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Warning log:
----
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 6.10.0-next-20240715 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 13.2.0-12) 13.2.0, GNU ld (GNU Binutils
for Debian) 2.42) #1 SMP PREEMPT @1721032044
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: Raspberry Pi 4 Model B
...
[   33.796467] ------------[ cut here ]------------
[   33.801373] WARNING: CPU: 2 PID: 134 at kernel/cpu.c:527
lockdep_assert_cpus_held (kernel/cpu.c:527 (discriminator 7)
kernel/cpu.c:516 (discriminator 7))
[   33.801410] Modules linked in: dm_mod(+)
[   33.801428] CPU: 2 UID: 0 PID: 134 Comm: modprobe Not tainted
6.10.0-next-20240715 #1
[   33.801445] Hardware name: Raspberry Pi 4 Model B (DT)
[   33.801452] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   33.801465] pc : lockdep_assert_cpus_held (kernel/cpu.c:527
(discriminator 7) kernel/cpu.c:516 (discriminator 7))
[   33.801479] lr : lockdep_assert_cpus_held (kernel/cpu.c:527
(discriminator 1))
[   33.801491] sp : ffff800087583560
[   33.801497] x29: ffff800087583560 x28: 0000000000000000 x27: 0000000000000000
[   33.801515] x26: ffff000046714c10 x25: ffff800084edb000 x24: 0000000000000008
[   33.801532] x23: ffff800082d10740 x22: ffff800084f12128 x21: ffff8000857a9a38
[   33.801547] x20: ffff000046714c00 x19: 0000000000020002 x18: 0000000000000000
[   33.801562] x17: ffff800080205c24 x16: ffff8000802058c4 x15: ffff800080204170
[   33.801577] x14: ffff8000800152dc x13: ffff800080011550 x12: ffff800081d31448
[   33.801592] x11: 000000000000002c x10: 000000000000002c x9 : ffff800080101d4c
[   33.801608] x8 : 00000000ffffffff x7 : 00000000000b663d x6 : ffff8000857afdd0
[   33.801623] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000732be000
[   33.801638] x2 : 0000000000000000 x1 : 00000000000000c0 x0 : 0000000000000000
[   33.801652] Call trace:
[   33.801658] lockdep_assert_cpus_held (kernel/cpu.c:527
(discriminator 7) kernel/cpu.c:516 (discriminator 7))
[   33.801671] alloc_and_link_pwqs (kernel/workqueue.c:5438)
[   33.801682] alloc_workqueue (kernel/workqueue.c:5703 (discriminator 1))
[   33.801692] local_init+0x34/0xc0 dm_mod
[   33.801805] dm_init+0x54/0xf8 dm_mod
[   33.801900] do_one_initcall (init/main.c:1267)
[   33.801916] do_init_module (kernel/module/main.c:2543)
[   33.801930] load_module (kernel/module/main.c:3009)
[   33.801942] init_module_from_file (kernel/module/main.c:3177)
[   33.801955] idempotent_init_module (kernel/module/main.c:3193)
[   33.801968] __arm64_sys_finit_module (kernel/module/main.c:3214
kernel/module/main.c:3197 kernel/module/main.c:3197)
[   33.801980] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:54)
[   33.801990] el0_svc_common (include/linux/thread_info.h:127
(discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2))
[   33.801999] do_el0_svc (arch/arm64/kernel/syscall.c:152)
[   33.802008] el0_svc (arch/arm64/include/asm/irqflags.h:82
(discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
arch/arm64/kernel/entry-common.c:165 (discriminator 1)
arch/arm64/kernel/entry-common.c:178 (discriminator 1)
arch/arm64/kernel/entry-common.c:713 (discriminator 1))
[   33.802020] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:731)
[   33.802032] el0t_64_sync (arch/arm64/kernel/entry.S:598)
[   33.802042] irq event stamp: 35480
[   33.802046] hardirqs last enabled at (35479):
_raw_spin_unlock_irqrestore (arch/arm64/include/asm/irqflags.h:82
(discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
include/linux/spinlock_api_smp.h:151 (discriminator 1)
kernel/locking/spinlock.c:194 (discriminator 1))
[   33.802064] hardirqs last disabled at (35480): el1_dbg
(arch/arm64/kernel/entry-common.c:371 (discriminator 1)
arch/arm64/kernel/entry-common.c:471 (discriminator 1))
[   33.802077] softirqs last enabled at (35456): handle_softirqs
(arch/arm64/include/asm/current.h:19
arch/arm64/include/asm/preempt.h:13 kernel/softirq.c:401
kernel/softirq.c:582)
[   33.802096] softirqs last disabled at (35389): __do_softirq
(kernel/softirq.c:589)
[   33.802107] ---[ end trace 0000000000000000 ]---


metadata:
------
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 91e3b24eb7d297d9d99030800ed96944b8652eaf
  git_describe: next-20240715
  kernel_version: 6.10.0
  kernel-config:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2jH6dXP5XS72ybkPa57keKJ7q3z/config
  artifact-location:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2jH6dXP5XS72ybkPa57keKJ7q3z/
  toolchain: gcc-13
  build_name: gcc-13-lkftconfig-kselftest
  arch: arm64 and x86_64

Kernel boot log links:
-------
 [1] https://lkft.validation.linaro.org/scheduler/job/7729587#L844
 [2] https://lkft.validation.linaro.org/scheduler/job/7728947#L1742

--
Linaro LKFT
https://lkft.linaro.org

