Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB36C51F449
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 May 2022 08:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiEIFyL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 01:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbiEIFox (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 01:44:53 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9922F68A4
        for <linux-kselftest@vger.kernel.org>; Sun,  8 May 2022 22:41:00 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id s30so22952735ybi.8
        for <linux-kselftest@vger.kernel.org>; Sun, 08 May 2022 22:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IuWRns9pMIw65xrkUwtqZzcIMvbP9jtItO2aE2vrqao=;
        b=NyXzAoVtt5sgm+AtKlFW0eUzqe7GNpGc8ZrJqgMJ/JYp5fndo7F4SBWUkn4MIHCxOH
         3WyWAlprtrjeDXqgc/fmUhUjcMaP8/jvtl1Ewd/Z60hLyjjU+3CXeWYm91v+GfSyeMKS
         6veo2Bc+lgj6otgNwohuOoeWJqCbjxz0ongngBGJhj+3mYPuLKko8FGRwL7wvKq8CvPQ
         HCsXTgXxp65XKhvE7r6M71Y9xrTQuKYskKsV9z2F2G1olpLUCMOjrgGOidI9UB0jIgGA
         icIFcWd8iac+YMqYdKQlKaqD9z9s7Qh7v/c9L8zRFQyf/t1ffyunCsUxtXgxj30d4k8Y
         +0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IuWRns9pMIw65xrkUwtqZzcIMvbP9jtItO2aE2vrqao=;
        b=LDPXO51QQ9o427KNtdqOEJEKo3WBdK1eQM8YqkgpWwMdyncuXgj4IEfJO7zrvyixlF
         gFB27VTlW7HltQxy4/r2ttCo1S1ajqB1cWRakbT3vd5F8Xap1E0ys6jsR+oGtHvML3F7
         iTaXdNFB7cxDI5SpLo+BSDXGyWrQC5eUOjPAUkFh2HOiGyu7oAD9wW6vsWY2cGidkINJ
         P4uUiGZ8xEFyKuSUEbWdeluDH6J+WHmVHltfcJBYWqQqrLhSP78sAJ9azaU8yC3TWJS6
         wnFutcRPw5un5gUznodqttGeJUoX0T96mLhk5T2isGIpMijX1RtHJiFPkVoknUQJ9sAN
         +vpg==
X-Gm-Message-State: AOAM5337ve5dVDLtG0mmRAzt8UMqsGEznbej/U5LQihQBlRjbqh2OynK
        mjfBLMiL4SLxEmh4srXEFYBCsS6lVYMYyF3rFCrS4EM+gfcsSA==
X-Google-Smtp-Source: ABdhPJxXiV1FtvYaSxQHIhdToDEZ2/LEk/cdnCoyg2GjIeMct6kKJ4BvSWYPmU/MADQWAiQrVcHWnlsRaCi5+OpJOtU=
X-Received: by 2002:a25:c64b:0:b0:649:11d:9db1 with SMTP id
 k72-20020a25c64b000000b00649011d9db1mr11660848ybf.128.1652074843828; Sun, 08
 May 2022 22:40:43 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 9 May 2022 11:10:32 +0530
Message-ID: <CA+G9fYtHMuvr3U4YS78WKxB1SiSDQkiHFPzQLETMe_n2QYwdqg@mail.gmail.com>
Subject: [next] gpio: gpio-sim.sh: Unable to handle kernel NULL pointer
 dereference at virtual address 0000000000000008
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        brgl@bgdev.pl, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        andrei.lalaev@emlid.com, Linus Walleij <linus.walleij@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Raghuram Thammiraju <raghuram.thammiraju@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
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

Following kernel crash noticed while running kselftest gpio gpio-sim.sh on
qemu_arm64 with Linux next-20220506 kernel [1] & [2].

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

# selftests: gpio: gpio-sim.sh
# 1. chip_name and dev_name attributes
# 1.1. Chip name is communicated to user
# 1.2. chip_name returns 'none' if the chip is still pending
# 1.3. Device name is communicated to user
# 2. Creating and configuring simulated chips
# 2.1. Default number of lines is 1
# 2.2. Number of lines can be specified
# 2.3. Label can be set
# 2.4. Label can be left empty
# 2.5. Line names can be configured
# 2.6. Line config can remain unused if offset is greater than number of lines
# 2.7. Line configfs directory names are sanitized
# 2.8. Multiple chips can be created
# 2.9. Can't modify settings when chip is live
# 2.10. Can't create line items when chip is live
# 2.11. Probe errors are propagated to user-space
[  218.163457] gpio gpiochip1: (gpio-sim.0-node0): line cnt 34463 is
greater than fast path cnt 512
[  218.163739] gpiochip_find_base: cannot find free range
[  218.164216] gpiochip_add_data_with_key: GPIOs 0..34462
(gpio-sim.0-node0) failed to register, -28
[  218.164503] gpio-sim: probe of gpio-sim.0 failed with error -28
# 2.12. Cannot enable a chip without any GPIO banks
# 2.13. Duplicate chip labels are not allowed
# 2.14. Lines can be hogged
[  223.754983] gpio-2036 (?): hogged as input
[  224.231594] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000008
[  224.233378] Mem abort info:
[  224.233719]   ESR = 0x0000000096000006
[  224.234076]   EC = 0x25: DABT (current EL), IL = 32 bits
[  224.235432]   SET = 0, FnV = 0
[  224.235790]   EA = 0, S1PTW = 0
[  224.236146]   FSC = 0x06: level 2 translation fault
[  224.236592] Data abort info:
[  224.236926]   ISV = 0, ISS = 0x00000006
[  224.237300]   CM = 0, WnR = 0
[  224.237738] user pgtable: 4k pages, 48-bit VAs, pgdp=000000010ab2b000
[  224.238785] [0000000000000008] pgd=080000010b9c4003,
p4d=080000010b9c4003, pud=080000010b990003, pmd=0000000000000000
[  224.240838] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[  224.241509] Modules linked in: gpio_sim rfkill crct10dif_ce sm3_ce
sm3 sha3_ce sha512_ce sha512_arm64 fuse [last unloaded: gpio_mockup]
[  224.242848] CPU: 2 PID: 1105 Comm: gpio-mockup-cde Not tainted
5.18.0-rc5-next-20220506 #1
[  224.243548] Hardware name: linux,dummy-virt (DT)
[  224.244109] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  224.244643] pc : linereq_free+0xb0/0x120
[  224.245515] lr : linereq_create+0x548/0x640
[  224.245797] sp : ffff8000089eb870
[  224.246065] x29: ffff8000089eb870 x28: ffffd5cd009d5cd8 x27: ffff0000c32da0c0
[  224.246795] x26: ffffd5ccfeb521c8 x25: 0000000000000000 x24: ffff0000c60d1d20
[  224.247318] x23: ffff0000c60d1c00 x22: 0000000000000000 x21: 0000000000000118
[  224.247843] x20: 0000000000000001 x19: ffff0000c60d1c00 x18: 0000000000000000
[  224.248352] x17: ffffd5ccfcc2c288 x16: ffffd5ccfd019804 x15: ffffd5ccfd468a48
[  224.248875] x14: ffffd5ccfd4686c0 x13: ffffd5ccfcc11d48 x12: ffffd5ccfe224eec
[  224.249307] x11: ffffd5ccfe223b88 x10: ffffd5ccfcc2c4e8 x9 : ffffd5ccfd4688c8
[  224.249840] x8 : ffff0000c32e6108 x7 : bbbbbbbbbbbbbbbb x6 : 0000000000000001
[  224.250418] x5 : ffffd5ccff965000 x4 : ffffd5ccff9654f0 x3 : 0000000000000000
[  224.251050] x2 : ffff0000c33e5080 x1 : 0000000000000000 x0 : 0000000000000000
[  224.251741] Call trace:
[  224.251998]  linereq_free+0xb0/0x120
[  224.252315]  linereq_create+0x548/0x640
[  224.252571]  gpio_ioctl+0x88/0x754
[  224.252808]  __arm64_sys_ioctl+0xb4/0x100
[  224.253103]  invoke_syscall+0x78/0x100
[  224.253342]  el0_svc_common.constprop.0+0x104/0x124
[  224.253680]  do_el0_svc+0xb4/0xcc
[  224.253922]  el0_svc+0x68/0x160
[  224.254173]  el0t_64_sync_handler+0xbc/0x140
[  224.254504]  el0t_64_sync+0x18c/0x190
[  224.254929] Code: cb160273 8b130ef3 f9409261 b9413260 (f9400422)
[  224.255783] ---[ end trace 0000000000000000 ]---
# ./gpio-sim.sh: line 318:  1105 Segmentation fault
$BASE_DIR/gpio-mockup-cdev -s 1 /dev/`configfs_chip_name chip bank` 4
2> /dev/null

Broadcast message from systemd-journald@juno (Fri 2022-05-06 09:51:02 UTC):

kernel[304]: [  224.240838] Internal error: Oops: 96000006 [#1] PREEMPT SMP


Broadcast message from systemd-journald@juno (Fri 2022-05-06 09:51:02 UTC):

kernel[304]: [  224.254929] Code: cb160273 8b130ef3 f9409261 b9413260 (f9400422)

# 3. Controlling simulated chips
# 3.1. Pull can be set over sysfs
#
not ok 2 selftests: gpio: gpio-sim.sh # TIMEOUT 45 seconds

metadata:
  git_ref: master
  git_repo: ''
  git_sha: 38a288f5941ef03752887ad86f2d85442358c99a
  git_describe: next-20220506
  kernel_version: 5.18.0-rc5
  kernel-config: https://builds.tuxbuild.com/28mio5DFBEfnEtkiTLdPb9tTWVa/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/532821646
  artifact-location: https://builds.tuxbuild.com/28mio5DFBEfnEtkiTLdPb9tTWVa
  toolchain: gcc-11

Steps to reproduce:
# cd /opt/kselftests/default-in-kernel/gpio
# ./gpio-sim.sh

Full test logs.
[1] https://lkft.validation.linaro.org/scheduler/job/4994124#L1108
[2] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220506/testrun/9366936/suite/linux-log-parser/test/check-kernel-oops-4994124/log

--
Linaro LKFT
https://lkft.linaro.org
