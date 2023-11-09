Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB17E6AE8
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 14:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjKINEk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 08:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKINEj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 08:04:39 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139DD2D7B
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 05:04:37 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7b6cd2afaf2so386110241.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Nov 2023 05:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699535076; x=1700139876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rJHV5wjvEmu0+H0pswwKbUsYcGzXtjcRUmurBVcTMsY=;
        b=OCN1jmCBXsiBSD+mwIzfmHx5YKhJ66D9CNptirK9Mcc9yOFraci2K5ZY5A4eZm+4Oa
         CdINqhxA9XFRmiD/scENxGkc1pjhx2ZoFiSCJPP6697Rrhl9Xm1K+do+qVR9K+uPdBZG
         ZCyAMLjFX5ucuWvH1nivqWmz/kZCwLVTkbwk7FF5sjDbMFFPL+bbnxBcRbDKiAu6WQ83
         NyIw6UEJWxmg+JKyYGQxXwwmWw8sAJkKApFG8HuT78d8k8cAFSSIR/LI7tKCJ37NCRY+
         UJ1Bpks+mp1pCaWi9PseRcd6KO08IYr3zLYSQvSzTDI+ibyRjwOVBeJ2qlJNCBzWfPYV
         CQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699535076; x=1700139876;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJHV5wjvEmu0+H0pswwKbUsYcGzXtjcRUmurBVcTMsY=;
        b=D9gAK64QbQbTgioXEQgYn1FZQgqsf1Bx7Yq+g/CEYlBp1AnGvFD0n7WBHmnQYYEeXn
         ghSArLEPc1fU/NZ2YjiU+eGQo/HMTgkvyl5uY7f0Hd+sY/NKYAcl4AeLIVzZO4KYEGq6
         3SEg5EiF622QMckhxHxJ4cFKciiYEBGaMtPEoYqDpTG/XPKLw/Z91tfJiyNNQa6vbgFT
         NrpfntwAJJH6kd46x5tC3327yKjdjmPTLxLOTuTXolWU3rs6dkdedDc89D/Lz7ky3FqW
         Arps+07FxlGNgN9aGbDTmJsYyKFx0K83MoXjgiwmuvTO5zjiVy0OpyeVozqTVwSU3yS1
         Ev5w==
X-Gm-Message-State: AOJu0YycgXTbaT1axLFhA7VqU3tOc21Q8dGG4YNxglK65sxpbod/4Pmv
        E+2+S4pd192sYNUrvX1oTwCoTt22/TrnIeg9z72ycw==
X-Google-Smtp-Source: AGHT+IG9nwtGQRIOzqK10AkgRk7c+flhGsr/w/ZJgOnvHz+uB1IeZ5JtclgUH4I84oq/WNIfY/7UjG0NLcht5wwj2yQ=
X-Received: by 2002:a1f:6e4e:0:b0:49d:fab:fa37 with SMTP id
 j75-20020a1f6e4e000000b0049d0fabfa37mr1381042vkc.4.1699535076016; Thu, 09 Nov
 2023 05:04:36 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 9 Nov 2023 18:34:24 +0530
Message-ID: <CA+G9fYue-dV7t-NrOhWwGshvyboXjb2B6HpCDVDe3bgG7fbnsg@mail.gmail.com>
Subject: selftests: memfd: run_fuse_test.sh - fuse_evict_inode -
 fs/fuse/inode.c:162 - panic
To:     linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, regressions@lists.linux.dev
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following kernel panic noticed while running selftests: memfd: run_fuse_test.sh
on arm64 Juno-r2 and x86 devices running Linux next-20231109.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

log:
---
# timeout set to 45
# selftests: memfd: run_fuse_test.sh
# opening: ./mnt/memfd
# fuse: DONE
[ 1931.860330] Unable to handle kernel paging request at virtual
address 005a5a5a5a5a5a5a
[ 1931.868645] Mem abort info:
[ 1931.871505]   ESR = 0x0000000096000021
[ 1931.875311]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1931.880805]   SET = 0, FnV = 0
[ 1931.883924]   EA = 0, S1PTW = 0
[ 1931.887563]   FSC = 0x21: alignment fault
[ 1931.891618] Data abort info:
[ 1931.894542]   ISV = 0, ISS = 0x00000021, ISS2 = 0x00000000
[ 1931.900219]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1931.905305]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1931.910692] [005a5a5a5a5a5a5a] address between user and kernel address ranges
[ 1931.918091] Internal error: Oops: 0000000096000021 [#1] PREEMPT SMP
[ 1931.924375] Modules linked in: gpio_sim onboard_usb_hub tda998x
hdlcd crct10dif_ce cec drm_dma_helper dm_mod [last unloaded:
gpio_mockup]
[ 1931.936789] CPU: 1 PID: 20739 Comm: fusermount Not tainted
6.6.0-next-20231109 #1
[ 1931.944295] Hardware name: ARM Juno development board (r2) (DT)
[ 1931.950224] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1931.957205] pc : fuse_evict_inode
(arch/arm64/include/asm/atomic_ll_sc.h:96 (discriminator 3)
arch/arm64/include/asm/atomic.h:51 (discriminator 3)
include/linux/atomic/atomic-arch-fallback.h:944 (discriminator 3)
include/linux/atomic/atomic-instrumented.h:401 (discriminator 3)
include/linux/refcount.h:272 (discriminator 3)
include/linux/refcount.h:315 (discriminator 3)
include/linux/refcount.h:333 (discriminator 3) fs/fuse/inode.c:137
(discriminator 3) fs/fuse/inode.c:166 (discriminator 3))
[ 1931.961586] lr : fuse_evict_inode (fs/fuse/inode.c:162)
[ 1931.965868] sp : ffff80008792ba90
[ 1931.969189] x29: ffff80008792ba90 x28: ffff000800b58040 x27: 0000000000000000
[ 1931.976358] x26: 0000000000000000 x25: ffff800080508f98 x24: ffff80008316a008
[ 1931.983519] x23: ffff80008316a008 x22: ffff80008424a020 x21: ffff00082a514c00
[ 1931.990679] x20: 5a5a5a5a5a5a5a5a x19: ffff000838828780 x18: 0000000000000000
[ 1931.997840] x17: ffff80008050e610 x16: ffff80008050e5bc x15: ffff80008050e3e8
[ 1932.005003] x14: ffff80008050df10 x13: ffff800080769c60 x12: ffff8000851f6388
[ 1932.012165] x11: 0000000000000645 x10: 0000000000000645 x9 : ffff800081c0e0b4
[ 1932.019332] x8 : ffff80008792b988 x7 : 0000000000000000 x6 : ffff800084a75fe8
[ 1932.026495] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008424a968
[ 1932.033659] x2 : 0000000000000002 x1 : ffff000800b58040 x0 : 0000000000000001
[ 1932.040820] Call trace:
[ 1932.043272] fuse_evict_inode
(arch/arm64/include/asm/atomic_ll_sc.h:96 (discriminator 3)
arch/arm64/include/asm/atomic.h:51 (discriminator 3)
include/linux/atomic/atomic-arch-fallback.h:944 (discriminator 3)
include/linux/atomic/atomic-instrumented.h:401 (discriminator 3)
include/linux/refcount.h:272 (discriminator 3)
include/linux/refcount.h:315 (discriminator 3)
include/linux/refcount.h:333 (discriminator 3) fs/fuse/inode.c:137
(discriminator 3) fs/fuse/inode.c:166 (discriminator 3))
[ 1932.047296] evict (fs/inode.c:669)
[ 1932.050279] iput_final (fs/inode.c:1776)
[ 1932.053694] iput.part.0 (fs/inode.c:1803)
[ 1932.057280] iput (fs/inode.c:1803)
[ 1932.060085] dentry_unlink_inode (fs/dcache.c:402)
[ 1932.064281] __dentry_kill (arch/arm64/include/asm/current.h:19
arch/arm64/include/asm/preempt.h:47 fs/dcache.c:610)
[ 1932.067956] shrink_dentry_list (include/linux/list.h:373
(discriminator 2) fs/dcache.c:1179 (discriminator 2))
[ 1932.072067] shrink_dcache_parent (fs/dcache.c:1652)
[ 1932.076433] shrink_dcache_for_umount (fs/dcache.c:1682 fs/dcache.c:1698)
[ 1932.081062] generic_shutdown_super (fs/super.c:647)
[ 1932.085518] kill_anon_super (fs/super.c:1254)
[ 1932.089277] fuse_kill_sb_anon (fs/fuse/fuse_i.h:895 fs/fuse/inode.c:1912)
[ 1932.093298] deactivate_locked_super (fs/super.c:489)
[ 1932.097753] deactivate_super (fs/super.c:522)
[ 1932.101599] cleanup_mnt (fs/namespace.c:139 fs/namespace.c:1257)
[ 1932.105097] __cleanup_mnt (fs/namespace.c:1264)
[ 1932.108680] task_work_run (kernel/task_work.c:182)
[ 1932.112266] do_notify_resume (include/linux/resume_user_mode.h:49
arch/arm64/kernel/signal.c:1305)
[ 1932.116283] el0_svc (arch/arm64/kernel/entry-common.c:137
arch/arm64/kernel/entry-common.c:144
arch/arm64/kernel/entry-common.c:679)
[ 1932.119345] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:697)
[ 1932.123710] el0t_64_sync (arch/arm64/kernel/entry.S:595)
[ 1932.127383] Code: f9026a7f 17ffffd9 52800020 f9800291 (885f7e81)
All code
========
   0: f9026a7f str xzr, [x19, #1232]
   4: 17ffffd9 b 0xffffffffffffff68
   8: 52800020 mov w0, #0x1                    // #1
   c: f9800291 prfm pstl1strm, [x20]
  10:* 885f7e81 ldxr w1, [x20] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: 885f7e81 ldxr w1, [x20]
[ 1932.133486] ---[ end trace 0000000000000000 ]---
[ 1932.138111] Kernel panic - not syncing: Oops: Fatal exception
[ 1932.143867] SMP: stopping secondary CPUs
[ 1932.148008] Kernel Offset: disabled
[ 1932.151498] CPU features: 0x1,0000020c,3c020000,0100421b
[ 1932.156820] Memory Limit: none
[ 1932.159880] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---


Links:
- https://lkft.validation.linaro.org/scheduler/job/7006578#L6164
- https://lkft.validation.linaro.org/scheduler/job/7006482#L9235

metadata:
git_ref: master
git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
git_sha: b622d91ca201bf97582e9b09ebbaab005ecee86f
git_describe: next-20231109
kernel_version: 6.6.0
kernel-config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2Xv92VPrzXNNmQil9l8bJV2RQHs/config
artifact-location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2Xv92VPrzXNNmQil9l8bJV2RQHs/
toolchain: gcc-13


--
Linaro LKFT
https://lkft.linaro.org
