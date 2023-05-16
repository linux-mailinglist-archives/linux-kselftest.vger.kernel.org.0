Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9832704552
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 May 2023 08:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjEPG25 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 02:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjEPG2z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 02:28:55 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA64A198D
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 23:28:52 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-44f985f250aso4683039e0c.3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 23:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684218531; x=1686810531;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AgsSOatvvgnVAbY3fKEOd/H8oYsa3jb8AEbLxPV5lY0=;
        b=eVoARu4468ITDHSNCRhZjPF7lkSK2YCIGRrh1q69aAufHbdXcutRIAG8Ta9yGXgMpG
         aF9jDwGDV50Xm0JmAvPrp6rlti94eYb+EqcxUbR8MDH1CUYsKtHylzXxDawJ5L83d+9r
         rzYcUV06wE0aC87B7hxxsF1qmTc4MftMBej5L6bLIZEB3MuhcdECnS4pvtalgTiPfjco
         YdEqJWMqJyM2oiFCtLQrOSSgw0dg0+EHJxQStYp1g+3oEEeEB2UrUBuxEnT50cIS4ldd
         CjB070YtvdHl6NF0eYA4c3KmfPBQhjSADCNQWLYumodFPfxmohLQ7RsRjgNsPRhsgCGm
         TUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218531; x=1686810531;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgsSOatvvgnVAbY3fKEOd/H8oYsa3jb8AEbLxPV5lY0=;
        b=UCtmD7rAjkF3aQDi0OaecmMaIG6m14XkKQtwrKfdRKkkvccahLNE+PQ+ONDEJDMbOl
         Y63XyoxmqyINoy4Z9KRWuIgvQEbBCA6xcLs0Kek8qx2Y+FFO5WnoOqb0+jruj31ecq7w
         OXNBzCykKgWF+OTuan7zZJY6tJKb90bftFHr4PJ4+1ON8GO7yV0PAyzmYkcxmPbduFNZ
         eq2Vpho3CkKcKt4A4jwonO73KjNWtpzG+MOrW4Ghi6vqXkkef48hOHQ2svqNadJaWiBm
         L0tKEudY+gCyu4PXBqVF30guGoHSqR3ux8Xro9weWXflViX5eUeseBo2kNPke/ItWFpV
         7Yjw==
X-Gm-Message-State: AC+VfDyKsgx8xkQoS0ta597Ir2lQAF9cl2slG/9qgqYLVoxugu07mor+
        mTsT2iL3zgS7Z7CfotSZrZw9q54NCw1Snp1ftSXp5vQwE9mKonOfgaVc2A==
X-Google-Smtp-Source: ACHHUZ7K88QWLW8FEDkPIsmlIrOleGCLDIgIB6J3mSc1D7Xs4dcjZNsV/EW+ls74lUPjZYX7u55XIblREzw3y/i/1hQ=
X-Received: by 2002:a1f:4c87:0:b0:451:c0f9:f02a with SMTP id
 z129-20020a1f4c87000000b00451c0f9f02amr11362211vka.3.1684218531248; Mon, 15
 May 2023 23:28:51 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 16 May 2023 11:58:40 +0530
Message-ID: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
Subject: arm64: fp-stress: BUG: KFENCE: memory corruption in fpsimd_release_task
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following kernel BUG noticed while running selftests arm64 fp-stress
running stable rc kernel versions 6.1.29-rc1 and 6.3.3-rc1.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

# selftests: arm64: fp-stress
# TAP version 13
# 1..80
# # 8 CPUs, 3 SVE VLs, 3 SME VLs, SME2 absent
# # Will run for 10s
...

# # ZA-VL-32-4: PID: 1091
# # [  263.834190]
==================================================================
[  263.834270] BUG: KFENCE: memory corruption in fpsimd_release_task+0x28/0x50
[  263.834270]
ZA-V[  263.834419] Corrupted memory at 0x00000000d9c0a375 [ ! ! ! ! !
! . . . . . . . . . . ] (in kfence-#158):
L-64-[  263.834929]  fpsimd_release_task+0x28/0x50
[  263.835074]  arch_release_task_struct+0x1c/0x30
[  263.835221]  __put_task_struct+0x164/0x220
[  263.835336]  delayed_put_task_struct+0x60/0x128
4: [  263.835484]  rcu_core+0x318/0x950
[  263.835632]  rcu_core_si+0x1c/0x30
[  263.835770]  __do_softirq+0x110/0x3d8
Stre[  263.835874]  run_ksoftirqd+0x40/0xe0
[  263.835994]  smpboot_thread_fn+0x1d0/0x260
[  263.836105]  kthread+0xec/0x190
[  263.836221]  ret_from_fork+0x10/0x20
[  263.836342]
ami[  263.836393] kfence-#158: 0x00000000c8819329-0x000000009e00cc22,
size=546, cache=kmalloc-1k
[  263.836393]
[  263.836527] allocated by task 1112 on cpu 5 at 252.422888s:
[  263.836697]  do_sme_acc+0xa8/0x230
ng m[  263.836821]  el0_sme_acc+0x40/0xa0
[  263.836966]  el0t_64_sync_handler+0xa8/0xf0
[  263.837114]  el0t_64_sync+0x190/0x198
[  263.837224]
ode[  263.837275] freed by task 15 on cpu 0 at 263.833793s:
[  263.837500]  fpsimd_release_task+0x28/0x50
[  263.837629]  arch_release_task_struct+0x1c/0x30
 ve[  263.837773]  __put_task_struct+0x164/0x220
[  263.837886]  delayed_put_task_struct+0x60/0x128
[  263.838032]  rcu_core+0x318/0x950
cto[  263.838176]  rcu_core_si+0x1c/0x30
[  263.838310]  __do_softirq+0x110/0x3d8
[  263.838417]  run_ksoftirqd+0x40/0xe0
[  263.838521]  smpboot_thread_fn+0x1d0/0x260
[  263.838626]  kthread+0xec/0x190
[  263.838742]  ret_from_fork+0x10/0x20
[  263.838861]
[  263.838913] CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.3.3-rc1 #1
[  263.839037] Hardware name: FVP Base RevC (DT)
[  263.839111] ==================================================================
r length: 512 bits
# # ZA-VL-64-4: PID: 1089
# # SSVE-VL-64-4: Streaming mode Vector length: 512 bits
# # SSVE-VL-64-4: PID: 1088
# # ZA-VL-16-4: Streaming mode vector length: 128 bits
# # ZA-VL-16-4: PID: 1093
# # FPSIMD-5-0: Vector length: 128 bits
# # FPSIMD-5-0: PID: 1094
# # SVE-VL-32-5: Vector length: 256 bits
# # SVE-VL-32-5: PID: 1096
# # SSVE-VL-64-5: Streaming mode Vector length: 512 bits
# # SVE-VL-64-5: Vector length: 512 bits
# # SVE-VL-64-5: PID: 1095
# # SSVE-VL-64-5: PID: 1098
# # ZA-VL-64-5:[  263.905145]
==================================================================
[  263.905299] BUG: KFENCE: memory corruption in fpsimd_release_task+0x28/0x50
[  263.905299]
 Str[  263.905444] Corrupted memory at 0x00000000e3d2342a [ ! ! ! ! !
! . . . . . . . . . . ] (in kfence-#146):
[  263.905957]  fpsimd_release_task+0x28/0x50
eam[  263.906088]  arch_release_task_struct+0x1c/0x30
[  263.906236]  __put_task_struct+0x164/0x220
[  263.906348]  delayed_put_task_struct+0x60/0x128
[  263.906499]  rcu_core+0x318/0x950
[  263.906647]  rcu_core_si+0x1c/0x30
in[  263.906786]  __do_softirq+0x110/0x3d8
[  263.906892]  ____do_softirq+0x1c/0x30
[  263.907015]  call_on_irq_stack+0x24/0x58
g mo[  263.907139]  do_softirq_own_stack+0x28/0x40
[  263.907305]  __irq_exit_rcu+0x94/0xf8
[  263.907454]  irq_exit_rcu+0x1c/0x40
de [  263.907599]  el0_interrupt+0x58/0x160
[  263.907765]  __el0_irq_handler_common+0x18/0x28
[  263.907879]  el0t_64_irq_handler+0x10/0x20
[  263.907989]  el0t_64_irq+0x190/0x198
[  263.908098]
vect[  263.908149] kfence-#146: 0x000000005a8569e6-0x00000000c704c501,
size=546, cache=kmalloc-1k
[  263.908149]
[  263.908282] allocated by task 1102 on cpu 0 at 251.030980s:
[  263.908452]  do_sme_acc+0xa8/0x230
or l[  263.908576]  el0_sme_acc+0x40/0xa0
[  263.908725]  el0t_64_sync_handler+0xa8/0xf0
[  263.908879]  el0t_64_sync+0x190/0x198
[  263.908986]
eng[  263.909036] freed by task 1 on cpu 3 at 263.904989s:
[  263.909311]  fpsimd_release_task+0x28/0x50
[  263.909439]  arch_release_task_struct+0x1c/0x30
th:[  263.909584]  __put_task_struct+0x164/0x220
[  263.909696]  delayed_put_task_struct+0x60/0x128
[  263.909842]  rcu_core+0x318/0x950
512 [  263.909986]  rcu_core_si+0x1c/0x30
[  263.910175]  __do_softirq+0x110/0x3d8
[  263.910279]  ____do_softirq+0x1c/0x30
[  263.910399]  call_on_irq_stack+0x24/0x58
[  263.910520]  do_softirq_own_stack+0x28/0x40
[  263.910645]  __irq_exit_rcu+0x94/0xf8
bits[  263.910792]  irq_exit_rcu+0x1c/0x40
[  263.910937]  el0_interrupt+0x58/0x160
[  263.911043]  __el0_irq_handler_common+0x18/0x28
[  263.911154]  el0t_64_irq_handler+0x10/0x20

[  263.911261]  el0t_64_irq+0x190/0x198
# # [  263.911387]
[  263.911448] CPU: 3 PID: 1 Comm: systemd Tainted: G    B
 6.3.3-rc1 #1
[  263.911575] Hardware name: FVP Base RevC (DT)
[  263.911653] ==================================================================
..

# ok 80 ZA-VL-16-7
# # Totals: pass:80 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 32 selftests: arm64: fp-stress


Steps to reproduce:
============

# To install tuxrun on your system globally:
# sudo pip3 install -U tuxrun==0.42.0
#
# See https://tuxrun.org/ for complete documentation.

tuxrun   \
 --runtime podman   \
 --device fvp-aemva   \
 --boot-args rw   \
 --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2Pq5NvLiBcWRMuy6lXftDVQMvca/Image.gz
  \
 --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2Pq5NvLiBcWRMuy6lXftDVQMvca/modules.tar.xz
  \
 --rootfs https://storage.tuxboot.com/debian/bookworm/arm64/rootfs.ext4.xz   \
 --parameters SKIPFILE=skipfile-lkft.yaml   \
 --parameters KSELFTEST=https://storage.tuxsuite.com/public/linaro/lkft/builds/2Pq5NvLiBcWRMuy6lXftDVQMvca/kselftest.tar.xz
  \
 --image tuxrun:fvp   \
 --tests kselftest-arm64   \
 --timeouts boot=60 kselftest-arm64=60


Test log links:
========

 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.28-240-gb82733c0ff99/testrun/17007082/suite/log-parser-test/test/check-kernel-kfence/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.28-240-gb82733c0ff99/testrun/17007082/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.28-240-gb82733c0ff99/testrun/17007268/suite/kselftest-arm64/tests/

 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.2-247-g5a952cfef67c/testrun/17015127/suite/log-parser-test/test/check-kernel-bug/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.2-247-g5a952cfef67c/testrun/17015127/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.2-247-g5a952cfef67c/testrun/17015127/suite/kselftest-arm64/tests/

--
Linaro LKFT
https://lkft.linaro.org
