Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3495F4EB018
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbiC2PWI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 11:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238430AbiC2PWI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 11:22:08 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41A61B0857
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 08:20:24 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j2so32201622ybu.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mqf77QeoL5E8gq/UNbdnceI0Lqcn9TnB8ZcBKbA//HY=;
        b=gzfose0LqAREB7zRFZHRdNffeFoQlP8t4o4t8O+im03BrN8m99rmINX5UePPZJdCiI
         kMOYFj16jCWs/XA5tlLbXYovRDJrZL9S7pOUws5JSPWv8SKhcmpPp4D5pWhNr2yv6WhG
         i4wjTXUsf6VAWxZq1VSq/jOT916GRkv75TyZnUse/j8N5PiuCT5rYpMNAcMhwBqRXe4J
         g80Uro+2EmhRXPMTFTjqXHDqWu7nAO/cXZtoMEpng1yojJhZYGaXK2aRPQZM1IGb77s2
         nvhUYbJtyb2I4zLJ4zBYT9Iqi+OoxlzngK05QW4gWIzWFlF1oL+aDuizguL3sy3as+DR
         nrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mqf77QeoL5E8gq/UNbdnceI0Lqcn9TnB8ZcBKbA//HY=;
        b=F8fiVUMlEN6KVVKJdo3kNB8iEqhNhGqybkgpZaVQ+slIrllCqyO7CQUSNFjCJko1P3
         KyLT6pBrQ0HICnWjC7MTAqGFYmOfFx4sAulv5nvZkB5Z0X+9o1aWl31/nPREBuXIcY/U
         MzD4H7lJUdCZVSxaApwEodUsHsc7jlmVEPVy3RHG2zFOQkjKXZWcyOPP1z7DHpLpGXM1
         P29OQEDwDHzbZtZH19nLidDtGPBsAlvWFBobmOIyebPbzeJ0dhqs3H5JSqE8cSeAf1G3
         EeyMf28Xwm6zH4LEnh5Nq4yT1MZusVuyhMX0/R+78Ct8cljBGbQENqD404BD8g8KdqIF
         bTug==
X-Gm-Message-State: AOAM530IswEl0qHmKu0DP8nXE5S1YJ1odevB0ZGhv1e27GhzCrQbfTxV
        R3o0Bc4dfgx0kGv1DvxtPrz6sNYmMtl5JGB4+oXfmi0zj1URBgZj
X-Google-Smtp-Source: ABdhPJwTGzMwHTVoUHzH/SEOKRVgEO0IwzEv+Q8tSvRoNS9k6jrg6Gq+mgZ9LssHpyLF5AKwYur63FvMHokmW40AQPM=
X-Received: by 2002:a25:9909:0:b0:624:57e:d919 with SMTP id
 z9-20020a259909000000b00624057ed919mr29166744ybn.494.1648567223068; Tue, 29
 Mar 2022 08:20:23 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Mar 2022 20:50:12 +0530
Message-ID: <CA+G9fYsd+zXJqsxuYkWLQo0aYwmqLVA_YeBu+sr546bGA+1Nfg@mail.gmail.com>
Subject: WARNING: at arch/x86/kvm/../../../virt/kvm/kvm_main.c:3156 mark_page_dirty_in_slot
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While running kselftest kvm test cases on x86_64 devices the following
kernel warning was reported.

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 1930a6e739c4b4a654a69164dbe39e554d228915
  git_describe: v5.17-12882-g1930a6e739c4
  kernel_version: 5.17.0
  kernel-config: https://builds.tuxbuild.com/272RGo17Agp9s62duqGs3mP2d0S/config


# selftests: kvm: evmcs_test
# Running L1 which uses EVMCS to run L2
# Injecting NMI into L1 before L2 had a chance to run after restore
# Trying extra KVM_GET_NESTED_STATE/KVM_SET_NESTED_STATE cycle
ok 4 selftests: kvm: evmcs_test
# selftests: kvm: emulator_error_test
# module parameter 'allow_smaller_maxphyaddr' is not set.  Skipping test.
ok 5 selftests: kvm: emulator_error_test
# selftests: kvm: hyperv_clock
[   62.510388] ------------[ cut here ]------------
[   62.515064] WARNING: CPU: 1 PID: 915 at
arch/x86/kvm/../../../virt/kvm/kvm_main.c:3156
mark_page_dirty_in_slot+0xba/0xd0
[   62.525968] Modules linked in: x86_pkg_temp_thermal fuse
[   62.531307] CPU: 1 PID: 915 Comm: hyperv_clock Not tainted 5.17.0 #1
[   62.537691] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   62.545185] RIP: 0010:mark_page_dirty_in_slot+0xba/0xd0
[   62.550452] Code: 89 ea 09 c6 e8 57 d4 00 00 5b 41 5c 41 5d 41 5e
5d c3 48 8b 83 c0 00 00 00 49 63 d5 f0 48 0f ab 10 5b 41 5c 41 5d 41
5e 5d c3 <0f> 0b 5b 41 5c 41 5d 41 5e 5d c3 0f 1f 44 00 00 eb 80 0f 1f
40 00
[   62.569265] RSP: 0018:ffffa347c1663b50 EFLAGS: 00010246
[   62.574502] RAX: 0000000080000000 RBX: ffff8f01149ce600 RCX: 0000000000000000
[   62.581700] RDX: 0000000000000000 RSI: ffffffffa302ab31 RDI: ffffffffa302ab31
[   62.588874] RBP: ffffa347c1663b70 R08: 0000000000000000 R09: 0000000000000001
[   62.596046] R10: 0000000000000001 R11: 0000000000000000 R12: ffffa347c1665000
[   62.603213] R13: 0000000000000022 R14: 0000000000000000 R15: 0000000000000004
[   62.610389] FS:  00007fe3799c1740(0000) GS:ffff8f041fc80000(0000)
knlGS:0000000000000000
[   62.618697] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   62.624467] CR2: 0000000000000000 CR3: 000000010614e004 CR4: 00000000003726e0
[   62.631684] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   62.638833] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   62.646009] Call Trace:
[   62.648480]  <TASK>
[   62.650604]  __kvm_write_guest_page+0xc8/0x100
[   62.655112]  kvm_write_guest+0x61/0xb0
[   62.658884]  kvm_hv_invalidate_tsc_page+0xd3/0x140
[   62.663699]  ? kvm_hv_invalidate_tsc_page+0x72/0x140
[   62.668684]  kvm_arch_vm_ioctl+0x20f/0xbc0
[   62.672798]  ? __lock_acquire+0x3af/0x2450
[   62.676956]  ? __this_cpu_preempt_check+0x13/0x20
[   62.681706]  kvm_vm_ioctl+0x6f1/0xe20
[   62.685423]  ? ktime_get_coarse_real_ts64+0xc7/0xd0
[   62.690323]  ? __this_cpu_preempt_check+0x13/0x20
[   62.695048]  ? lockdep_hardirqs_on+0x7e/0x100
[   62.699423]  ? blk_log_with_error+0x3b/0x70
[   62.703644]  ? __audit_syscall_entry+0xcd/0x130
[   62.708220]  ? selinux_file_ioctl+0xa6/0x130
[   62.712542]  ? selinux_file_ioctl+0xa6/0x130
[   62.716869]  __x64_sys_ioctl+0x91/0xc0
[   62.720686]  do_syscall_64+0x5c/0x80
[   62.724305]  ? __this_cpu_preempt_check+0x13/0x20
[   62.729059]  ? lock_is_held_type+0xdd/0x130
[   62.733264]  ? do_syscall_64+0x69/0x80
[   62.737069]  ? __this_cpu_preempt_check+0x13/0x20
[   62.741791]  ? lockdep_hardirqs_on+0x7e/0x100
[   62.746219]  ? syscall_exit_to_user_mode+0x3e/0x50
[   62.751082]  ? do_syscall_64+0x69/0x80
[   62.754904]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   62.760027] RIP: 0033:0x7fe3792bf8f7
[   62.763687] Code: b3 66 90 48 8b 05 a1 35 2c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 71 35 2c 00 f7 d8 64 89
01 48
[   62.782497] RSP: 002b:00007ffe035acf38 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   62.790131] RAX: ffffffffffffffda RBX: 000000004030ae7b RCX: 00007fe3792bf8f7
[   62.797334] RDX: 00007ffe035acf70 RSI: 000000004030ae7b RDI: 0000000000000006
[   62.804539] RBP: 0000000000000007 R08: 000000000040e320 R09: 0000000000000007
[   62.811737] R10: 000000000004da6b R11: 0000000000000246 R12: 00007fe3799c7000
[   62.818914] R13: 0000000000000007 R14: 00000000000058cb R15: 00000000000e8f42
[   62.826141]  </TASK>
[   62.828378] irq event stamp: 6435
[   62.831765] hardirqs last  enabled at (6445): [<ffffffffa3272a88>]
__up_console_sem+0x58/0x60
[   62.840354] hardirqs last disabled at (6454): [<ffffffffa3272a6d>]
__up_console_sem+0x3d/0x60
[   62.848944] softirqs last  enabled at (6392): [<ffffffffa4600341>]
__do_softirq+0x341/0x4cc
[   62.857362] softirqs last disabled at (6473): [<ffffffffa31ef29f>]
irq_exit_rcu+0xdf/0x140
[   62.865700] ---[ end trace 0000000000000000 ]---
ok 6 selftests: kvm: hyperv_clock

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/4805876#L1528
