Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CCB275DE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Sep 2020 18:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIWQvp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Sep 2020 12:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgIWQvp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Sep 2020 12:51:45 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E266C0613CE
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Sep 2020 09:51:45 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id e2so387037vsr.7
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Sep 2020 09:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qnH/IpGBOgvAVXQTuDw2bqYhHdHC09C72JJjikHyR2o=;
        b=L7XB9rQlCac4xFnNlxadc3BUSRbCpKTKYIA1+PQeRbnrGy3BRD73gzz5g7rM0aJJU8
         JRYqRmMZrCaxw5z1rxbyMtXOWn+LCRPrRT/TqVNAZl6QsUIQ1IF7N9OtU1JgdXV7EEMG
         tNCSeGCMjUH0rrYyXZ38yPLhkUVJtf4bt6uqIMR54p9eb7Dk8sMPYytHFlrvRHw6+t3p
         K9jgpS4Smqcq9KkQokl7k5xl9ZS//MzfSVpkpyjdDayc3dAS2s8H/QSNhhEITMPNSe09
         yvwrwYUmUf98IwLNzwHD/9tLN/pTMfEdrN4AAyMc6nwSSSUoEHlx/xRkhN56a1ChAe84
         IZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qnH/IpGBOgvAVXQTuDw2bqYhHdHC09C72JJjikHyR2o=;
        b=EtT3oyh+zW59sjF2Rg7wcSKawOuR3ar1Xa3+Kk/xbfugqY8r6byvAIz7oqyYozj5Th
         zMomKziYVyXgMb4s3eU2Bn722Bwn7oBA6XhykOiXiXizDg+lX+CzWJ9ZKAtlZuX6Q8Eq
         VkuWGqKhmC5Mvc4kIBR2Iq/Xq11flJ9pkog2MQNx4lQte5sWe4cBTZd9t6TBOsbGdK8i
         g+KtCp/If7QUQiTtKWgx4pHviZTKCupIkaEcsO/clzrC6g0UFXA8MRH+dlrsX6oGuk87
         /FU97KkRKJqpTj2O7TJRZyrFleNe59T7NqOzA46fZvhEKVgHRdsewywNCDnNUc9rez7K
         gWuw==
X-Gm-Message-State: AOAM531Gwu73VbsADSxs7a0LmsVFeT1Z3A3w4DL/B3/uFLFuh71Vr2U3
        iEpUtJTeo0wQP78iI/HqKhu7s9vcuOzHhS/TUsJ0UA==
X-Google-Smtp-Source: ABdhPJzJFKBMH3sLAH452/VAa92lJmJo///tI6mJFnGfzrVnGsARg9aE7e7YhV58UMfbqYkxcF8lyweNpTesuOuMo3c=
X-Received: by 2002:a05:6102:2085:: with SMTP id h5mr954881vsr.26.1600879904000;
 Wed, 23 Sep 2020 09:51:44 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 23 Sep 2020 22:21:32 +0530
Message-ID: <CA+G9fYsT+MREZ=yPb3t=Rh+MCxz6q7p_tSJ_oeh92Sd3ro+PRw@mail.gmail.com>
Subject: BUG: kernel NULL pointer dereference, address: trace_event_raw_event_sched_switch
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While running kselftest ftracetest on i386 the kernel crash reported
on linux next tag
5.9.0-rc5-next-20200921.
Good news is that this crash is not seen on today's linux next tag 20200923.

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git describe: next-20200921
  make_kernelversion: 5.9.0-rc5
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/864/config

Reproduce steps:
          - cd /opt/kselftests/default-in-kernel/ftrace
          - ./ftracetest

crash log,
--------------
[  366.934246] BUG: kernel NULL pointer dereference, address: 00000024
[  366.940528] #PF: supervisor read access in kernel mode
[  366.945683] #PF: error_code(0x0000) - not-present page
[  366.950828] *pde = 00000000
[  366.953717] Oops: 0000 [#1] SMP
[  366.956862] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W
  5.9.0-rc5-next-20200921 #1
[  366.965639] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  366.973119] EIP: trace_event_raw_event_sched_switch+0x10/0x180
[  366.978950] Code: 08 5b 5e 5f 5d c3 8d 74 26 00 31 c0 eb e4 e8 07
42 dd 00 8d b4 26 00 00 00 00 55 89 e5 57 56 53 89 c6 89 cf 83 ec 28
8b 45 08 <8b> 5e 24 89 55 cc 89 45 d0 65 a1 14 00 00 00 89 45 f0 31 c0
f6 c7
[  366.997687] EAX: f5582480 EBX: f5582480 ECX: f5585b40 EDX: 00000000
[  367.003945] ESI: 00000000 EDI: f5585b40 EBP: f5593f20 ESP: f5593eec
[  367.010203] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210092
[  367.016978] CR0: 80050033 CR2: 00000024 CR3: 0bfbc000 CR4: 003506d0
[  367.023236] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  367.029495] DR6: fffe0ff0 DR7: 00000400
[  367.033323] Call Trace:
[  367.035771]  ? cpu_cgroup_can_attach+0x90/0x90
[  367.040215]  ? exc_general_protection+0x280/0x280
[  367.044922]  __schedule+0x4dc/0xa90
[  367.048415]  schedule_idle+0x1c/0x40
[  367.051993]  do_idle+0x185/0x2a0
[  367.055226]  cpu_startup_entry+0x25/0x30
[  367.059142]  start_secondary+0x106/0x140
[  367.063061]  startup_32_smp+0x164/0x168
[  367.066902] Modules linked in: sch_fq 8021q iptable_filter xt_mark
ip_tables cls_bpf veth algif_hash x86_pkg_temp_thermal fuse [last
unloaded: test_bpf]
[  367.080550] CR2: 0000000000000024
[  367.083871] ---[ end trace 41a54e0211ae9de1 ]---
[  367.083872] BUG: kernel NULL pointer dereference, address: 00000024
[  367.083873] #PF: supervisor read access in kernel mode
[  367.088489] EIP: trace_event_raw_event_sched_switch+0x10/0x180
[  367.094743] #PF: error_code(0x0000) - not-present page
[  367.094744] *pde = 00000000
[  367.099877] Code: 08 5b 5e 5f 5d c3 8d 74 26 00 31 c0 eb e4 e8 07
42 dd 00 8d b4 26 00 00 00 00 55 89 e5 57 56 53 89 c6 89 cf 83 ec 28
8b 45 08 <8b> 5e 24 89 55 cc 89 45 d0 65 a1 14 00 00 00 89 45 f0 31 c0
f6 c7
[  367.099878] EAX: f5582480 EBX: f5582480 ECX: f5585b40 EDX: 00000000
[  367.105709]
[  367.105710] Oops: 0000 [#2] SMP
[  367.110846] ESI: 00000000 EDI: f5585b40 EBP: f5593f20 ESP: f5593eec
[  367.110847] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210092
[  367.113725] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D W
  5.9.0-rc5-next-20200921 #1
[  367.132462] CR0: 80050033 CR2: 00000024 CR3: 0bfbc000 CR4: 003506d0
[  367.132463] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  367.138718] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  367.138720] EIP: trace_event_raw_event_sched_switch+0x10/0x180
[  367.140210] DR6: fffe0ff0 DR7: 00000400
[  367.140211] Kernel panic - not syncing: Attempted to kill the idle task!
[  367.143348] Code: 08 5b 5e 5f 5d c3 8d 74 26 00 31 c0 eb e4 e8 07
42 dd 00 8d b4 26 00 00 00 00 55 89 e5 57 56 53 89 c6 89 cf 83 ec 28
8b 45 08 <8b> 5e 24 89 55 cc 89 45 d0 65 a1 14 00 00 00 89 45 f0 31 c0
f6 c7
[  367.220218] EAX: d5ebb6c0 EBX: d5ebb6c0 ECX: cbca0700 EDX: 00000000
[  367.226476] ESI: 00000000 EDI: cbca0700 EBP: cbc8bef0 ESP: cbc8bebc
[  367.232733] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210092
[  367.239512] CR0: 80050033 CR2: 00000024 CR3: 0bfbc000 CR4: 003506d0
[  367.245767] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  367.252025] DR6: fffe0ff0 DR7: 00000400
[  367.255855] Call Trace:
[  367.258302]  ? pick_next_task_fair+0x154/0x3a0
[  367.262748]  __schedule+0x4dc/0xa90
[  367.266240]  schedule_idle+0x1c/0x40
[  367.269819]  do_idle+0x185/0x2a0
[  367.273053]  cpu_startup_entry+0x25/0x30
[  367.276978]  rest_init+0x166/0x230
[  367.280375]  arch_call_rest_init+0xd/0x19
[  367.284380]  start_kernel+0x481/0x4a0
[  367.288045]  i386_start_kernel+0x48/0x4a
[  367.291970]  startup_32_smp+0x164/0x168
[  367.295803] Modules linked in: sch_fq 8021q iptable_filter xt_mark
ip_tables cls_bpf veth algif_hash x86_pkg_temp_thermal fuse [last
unloaded: test_bpf]
[  367.309450] CR2: 0000000000000024
[  367.312762] ---[ end trace 41a54e0211ae9de2 ]---
[  367.312763] BUG: kernel NULL pointer dereference, address: 00000024
[  367.312764] #PF: supervisor read access in kernel mode
[  367.317381] EIP: trace_event_raw_event_sched_switch+0x10/0x180
[  367.323637] #PF: error_code(0x0000) - not-present page
[  367.323638] *pde = 00000000
[  367.328769] Code: 08 5b 5e 5f 5d c3 8d 74 26 00 31 c0 eb e4 e8 07
42 dd 00 8d b4 26 00 00 00 00 55 89 e5 57 56 53 89 c6 89 cf 83 ec 28
8b 45 08 <8b> 5e 24 89 55 cc 89 45 d0 65 a1 14 00 00 00 89 45 f0 31 c0
f6 c7
[  367.328770] EAX: f5582480 EBX: f5582480 ECX: f5585b40 EDX: 00000000
[  367.334600]
[  367.334601] Oops: 0000 [#3] SMP
[  367.339731] ESI: 00000000 EDI: f5585b40 EBP: f5593f20 ESP: f5593eec
[  367.339732] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210092
[  367.342611] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D W
  5.9.0-rc5-next-20200921 #1
[  367.361346] CR0: 80050033 CR2: 00000024 CR3: 0bfbc000 CR4: 003506d0
[  367.361347] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  367.367602] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  367.367604] EIP: trace_event_raw_event_sched_switch+0x10/0x180
[  367.369095] DR6: fffe0ff0 DR7: 00000400
[  367.423685] Code: 08 5b 5e 5f 5d c3 8d 74 26 00 31 c0 eb e4 e8 07
42 dd 00 8d b4 26 00 00 00 00 55 89 e5 57 56 53 89 c6 89 cf 83 ec 28
8b 45 08 <8b> 5e 24 89 55 cc 89 45 d0 65 a1 14 00 00 00 89 45 f0 31 c0
f6 c7
[  367.442431] EAX: f2dca480 EBX: f2dca480 ECX: f5584900 EDX: 00000000
[  367.448687] ESI: 00000000 EDI: f5584900 EBP: f5591f20 ESP: f5591eec
[  367.454945] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210092
[  367.461722] CR0: 80050033 CR2: 00000024 CR3: 0bfbc000 CR4: 003506d0
[  367.467980] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  367.474236] DR6: fffe0ff0 DR7: 00000400
[  367.478067] Call Trace:
[  367.480514]  ? pick_next_task_fair+0x154/0x3a0
[  367.484961]  __schedule+0x4dc/0xa90
[  367.488453]  ? inet_rtm_getroute+0x214/0x990
[  367.492724]  schedule_idle+0x1c/0x40
[  367.496302]  do_idle+0x185/0x2a0
[  367.499526]  ? inet_rtm_getroute+0x214/0x990
[  367.503792]  cpu_startup_entry+0x25/0x30
[  367.507715]  start_secondary+0x106/0x140
[  367.511633]  ? inet_rtm_getroute+0x214/0x990
[  367.515898]  startup_32_smp+0x164/0x168
[  367.519738] Modules linked in: sch_fq 8021q iptable_filter xt_mark
ip_tables cls_bpf veth algif_hash x86_pkg_temp_thermal fuse [last
unloaded: test_bpf]
[  367.533385] CR2: 0000000000000024
[  367.536698] ---[ end trace 41a54e0211ae9de3 ]---
[  367.541316] EIP: trace_event_raw_event_sched_switch+0x10/0x180
[  367.547140] Code: 08 5b 5e 5f 5d c3 8d 74 26 00 31 c0 eb e4 e8 07
42 dd 00 8d b4 26 00 00 00 00 55 89 e5 57 56 53 89 c6 89 cf 83 ec 28
8b 45 08 <8b> 5e 24 89 55 cc 89 45 d0 65 a1 14 00 00 00 89 45 f0 31 c0
f6 c7
[  367.565877] EAX: f5582480 EBX: f5582480 ECX: f5585b40 EDX: 00000000
[  367.572135] ESI: 00000000 EDI: f5585b40 EBP: f5593f20 ESP: f5593eec
[  367.578391] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210092
[  367.585170] CR0: 80050033 CR2: 00000024 CR3: 0bfbc000 CR4: 003506d0
[  367.591433] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  367.597691] DR6: fffe0ff0 DR7: 00000400
[  368.219291] Shutting down cpus with NMI
[  368.223134] Kernel Offset: disabled
[  368.226617] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task! ]---

full test log,
https://lkft.validation.linaro.org/scheduler/job/1784011
https://lkft.validation.linaro.org/scheduler/job/1776849#L9308

-- 
Linaro LKFT
https://lkft.linaro.org
