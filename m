Return-Path: <linux-kselftest+bounces-17118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B508696BBB3
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 14:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A7B1C20B25
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761E91D86C6;
	Wed,  4 Sep 2024 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQu7ax2w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC21D7E5E
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Sep 2024 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451598; cv=none; b=peul4ksfpw8WhHaHUod/rJcc+La9CjRnNdK/tbCE+2adz9UvmQNyGp7tAPkDBcUBvvRX4fH3pMQRkG4IIcZf0x3kVXxv/uqUsMBOkdbPj5/EBJomHLKjb+WGNQ8SLrvM2KnCJRYn9KGeOAPxyzPiTPDG2Rm+Zndrzd4xswdEY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451598; c=relaxed/simple;
	bh=uzBIlylmDxRXgGFzT0bGOfS65mm+1zh0xnYHpNKBl1o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QrM/CFWxWhXfgXmVQTZ27541ScjzjhSsRGrDLwdAQYAD8DRIGeRLVDS2TxpCKMGeazoYO00iIr7F+SH4cUVdYqjBYBaYKh51UyxLhAEcT3iWYltxRV0KTDfCexCJTZ/oTmBM2fanHeDGz9R1FAndPijtqVf5CyqnaYUaJ7wcCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mQu7ax2w; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70f794cd0e3so2369398a34.2
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2024 05:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725451595; x=1726056395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ncjbY78o2dy+2oTujZ9Kjw0Cl9c+zoMUYTRCjzOr+9s=;
        b=mQu7ax2w5R3NYIY88MG6mhEiTX40a5X3L4BvlErPHlHokbShJXFgP0pa9g+IuNaEpt
         u9tBZFYEoKkzl2Wwwl48MptJZhFpvVP0DfFAQHsxpeCLtPXPou917wCRuNdEdEGeE82e
         NkC7cXH4v72YcapqRZz2nOvweXysVluU9DWW7GXXC8S+e6wyUnaa273pzvTYhH22SMZP
         SxHAZo34UBCf7UX6BqZ1XKNPa+keoN0WitJjjGO8S3L+gcdAQLndSWFPQFgWwiWYL4R6
         LkhCIIm+8iRKOLibrj4nC9+gz9O6rUeABSigoBkyXNiQ/b3hCpFw09UNXsnB7uAGqLqD
         R9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725451595; x=1726056395;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ncjbY78o2dy+2oTujZ9Kjw0Cl9c+zoMUYTRCjzOr+9s=;
        b=Y774nLAaEyYP4S1CL+TvxVn5c1igVQu3axeiykLKQa2Ln6aAoPxAwTqpSaq9VBVks8
         fSOrUT7tkcbbcQvYXpuwGsnbqzeuOzB9CEaSs4wFuKiETx+bmu0hgKGK4Oh94GLEE6k0
         w2zVBeqEsZ6D4yjRy+CSOUgCYACeU7w3X+oTyAexY74tYKBq1gFTgNplEkew2QKat1Ry
         HHLsFUhfUqLmdSdYdw9/03g4ZLJ3Ue5JsbEkfm64D6bssOU/GWNZ8nJjpI6YBa+6QwFd
         3cj/x77Suzl0aN8Th5RLAEiM11hjI4JLWa9hwVhsC/31QpKcDCQy4TWUZIHOmVill6yC
         9Cfg==
X-Forwarded-Encrypted: i=1; AJvYcCUS/31indum0puekhEMmVGXqUFtSQRLcXUefB5FGFHo3exoBESjc7Kmwyqi6oooEtPOmm67/jsrutfXEM87MTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywrr2UIUX9c8y8UDqCoMNxuvm3oOAUXA5IYRoi4geLcDQ8H2hI
	1D5FArMXjqrl3fBd4b1+x0yjGSXL4VxptCJv8mQ/vkq8cz0I8VbpMiZDwropsFJSo1SnDxrqMsc
	t/NfXQA7V+SWxSN2nKFuM44PwTVxKzhmbt70YWQ==
X-Google-Smtp-Source: AGHT+IFwsdX/Q/Zp6aR6mbWRW7zx6fkPuH/EEWv8mPrWmqx+SJ6CSLticxCtQao0gbQdlc/DJv5LQVWCyndHO+2CPRg=
X-Received: by 2002:a05:6808:218a:b0:3df:7527:5e8a with SMTP id
 5614622812f47-3df752760e7mr11528917b6e.25.1725451595527; Wed, 04 Sep 2024
 05:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 4 Sep 2024 17:36:24 +0530
Message-ID: <CA+G9fYv=v713xAFCKvkwr_0qyaQWkmfeDC2=bO7KKkui+p+ZeQ@mail.gmail.com>
Subject: next: rcu_preempt self-detected stall on CPU - queued_spin_lock_slowpath
To: open list <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: yangyun50@huawei.com, "Paul E. McKenney" <paulmck@kernel.org>, 
	Zhen Lei <thunder.leizhen@huawei.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following kernel rcu info generated while running the test case
selftests: memfd: run_fuse_test.sh on qemu-arm64 running Linux
next-20240902. The qemu-arm64 did not recover.

This build was created with kselftest merge configs.

Anders bisected this to,
  # first bad commit:
    [5fb9c98e9d8ddf2abc645e2dcd9eb6703f77fdab]
    fuse: add support for no forget requests

Crash log:
----------
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
[    0.000000] Linux version 6.11.0-rc6-next-20240902
(tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 13.3.0-5) 13.3.0, GNU
ld (GNU Binutils for Debian) 2.43) #1 SMP PREEMPT @1725295942
[    0.000000] KASLR enabled
[    0.000000] random: crng init done
[    0.000000] Machine model: linux,dummy-virt
..
# selftests: memfd: run_fuse_test.sh
<3>[  107.408167] rcu: INFO: rcu_preempt self-detected stall on CPU
<3>[  107.409195] rcu: 1-....: (5249 ticks this GP)
idle=4d34/1/0x4000000000000000 softirq=10271/10271 fqs=2623
<3>[  107.410438] rcu: (t=5250 jiffies g=20109 q=58 ncpus=2)
<4>[  107.411776] CPU: 1 UID: 0 PID: 386 Comm: fuse_mnt Not tainted
6.11.0-rc6-next-20240902 #1
<4>[  107.412663] Hardware name: linux,dummy-virt (DT)
<4>[  107.413680] pstate: 03400009 (nzcv daif +PAN -UAO +TCO +DIT
-SSBS BTYPE=--)
<4>[  107.414341] pc : queued_spin_lock_slowpath+0x5c/0x440
<4>[  107.415481] lr : _raw_spin_lock+0x74/0x90
<4>[  107.415974] sp : ffff800080993ad0
<4>[  107.419229] x29: ffff800080993ad0 x28: 0000000000000008 x27:
fff000000635b800
<4>[  107.421148] x26: 0000000000000000 x25: 0000000000000000 x24:
ffff800080993ba0
<4>[  107.422099] x23: ffffa8c953aa02c8 x22: ffffa8c953aa02a0 x21:
0000000000000000
<4>[  107.423060] x20: fff0000005088330 x19: fff0000005088330 x18:
0000000000000000
<4>[  107.424145] x17: fff057375aeca000 x16: ffffa8c9a382f930 x15:
0000000000000000
<4>[  107.425097] x14: 0000000000000000 x13: 00000000000000d0 x12:
0000000000000000
<4>[  107.425990] x11: 0000000000000000 x10: fff00000ff7fb7b0 x9 :
ffffa8c9a382f9a4
<4>[  107.426955] x8 : ffff800080993a38 x7 : 0000000000000000 x6 :
0000000000000001
<4>[  107.427836] x5 : ffffa8c9a490a000 x4 : ffffa8c9a490a5c0 x3 :
0000000000000000
<4>[  107.428777] x2 : 0000000000000002 x1 : 0000000000000000 x0 :
0000000000000001
<4>[  107.430091] Call trace:
<4>[  107.430421]  queued_spin_lock_slowpath+0x5c/0x440
<4>[  107.431226]  _raw_spin_lock+0x74/0x90
<4>[  107.431841]  fuse_iget+0x1a0/0x2b8 [fuse]
<4>[  107.433439]  fuse_fill_super_common+0x344/0x468 [fuse]
<4>[  107.434320]  fuse_fill_super+0x6c/0xc8 [fuse]
<4>[  107.435044]  get_tree_nodev+0x78/0xc8
<4>[  107.435656]  fuse_get_tree+0xc8/0x1a0 [fuse]
<4>[  107.436133]  vfs_get_tree+0x30/0x100
<4>[  107.436927]  path_mount+0x3f4/0xa70
<4>[  107.437515]  __arm64_sys_mount+0x1e0/0x2a8
<4>[  107.438148]  invoke_syscall+0x50/0x120
<4>[  107.438760]  el0_svc_common.constprop.0+0x48/0xf0
<4>[  107.439484]  do_el0_svc+0x24/0x38
<4>[  107.440251]  el0_svc+0x3c/0x108
<4>[  107.440574]  el0t_64_sync_handler+0x120/0x130
<4>[  107.440978]  el0t_64_sync+0x190/0x198
<3>[  170.451886] rcu: INFO: rcu_preempt self-detected stall on CPU
<3>[  170.452546] rcu: 1-....: (21001 ticks this GP)
idle=4d34/1/0x4000000000000000 softirq=10271/10271 fqs=10494
<3>[  170.453323] rcu: (t=21011 jiffies g=20109 q=83 ncpus=2)
<4>[  170.454283] CPU: 1 UID: 0 PID: 386 Comm: fuse_mnt Not tainted
6.11.0-rc6-next-20240902 #1
<4>[  170.454966] Hardware name: linux,dummy-virt (DT)
<4>[  170.455736] pstate: 03400009 (nzcv daif +PAN -UAO +TCO +DIT
-SSBS BTYPE=--)
<4>[  170.456697] pc : queued_spin_lock_slowpath+0x5c/0x440
<4>[  170.457179] lr : _raw_spin_lock+0x74/0x90

boot Log links,
--------
 - https://storage.tuxsuite.com/public/linaro/lkft/tests/2lWV52ERJsLvYqFnGkWoPm2Wm9O/logs.txt
 - https://storage.tuxsuite.com/public/linaro/lkft/tests/2lWV52ERJsLvYqFnGkWoPm2Wm9O/logs.html

metadata:
----
  git describe: next-20240902
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: ecc768a84f0b8e631986f9ade3118fa37852fef0
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lWV3S20oiROqoJeQxul8mzi4Lo/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lWV3S20oiROqoJeQxul8mzi4Lo/
  toolchain: gcc-13

Steps to reproduce:
---------
 - https://storage.tuxsuite.com/public/linaro/lkft/tests/2lWV52ERJsLvYqFnGkWoPm2Wm9O/
 - https://storage.tuxsuite.com/public/linaro/lkft/tests/2lWV52ERJsLvYqFnGkWoPm2Wm9O/tuxrun_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org

