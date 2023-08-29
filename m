Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0D78C0E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 11:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjH2JCD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 05:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjH2JBo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 05:01:44 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F308139
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Aug 2023 02:01:41 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44ee3a547adso242625137.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Aug 2023 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693299700; x=1693904500;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n+CqqB4EY3ISGsS51lvl5duWo7g4p4NV86kSm7kFdCw=;
        b=CTQlSHoodUNoGIxrDYWdQGj8MxQrd+T9d6i7bsORQQbHmxA8AuwDYWti2UrW5koY4+
         I7F2C1OLNXGpUq47R8gm6Wm93PLr+PZ3CEvPDyFwQkP1PwBrAfi+3K0mSKYBBHf1ZTot
         86pmmbdxi5mWDFNo6rhmMu8EDWPo0KKpAN8caxuilOQq29RK9EkGIhx4mGXszgrRACOQ
         IGVmqN+qGRKOhJXK9nGCTn0JN4PzfgXsQDd9W0/ZC+9KM/s59GlzsEb4AjfnHUymBIBI
         H5aS+trRmY0seudVqvyBCRojNSjRFmKqyRhp4rb4+k+BXRazAY4pwgWY5YefKvUgYY9d
         i77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693299700; x=1693904500;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+CqqB4EY3ISGsS51lvl5duWo7g4p4NV86kSm7kFdCw=;
        b=BqB7PQzSRlb1yBEg4WglFgAdHF902CjiXI6v1K0wkWODy/6mt0IEE/YR0bf35AOGxD
         kB5UVFtcpW24TQgeyn8qQZj8DcKIepgd36czqrO2i2hwPWW/NB0K/UIgwXKzJgqd0dA4
         urmNXPYw2sNDc+MnIafYVWN6eCTLvqZxc1vyH7iB9xkfUYDmSI4V0hiDBXsCBYZUCL8I
         zSL/dh/yMV75JlGsT8XooVwRsnERSkcgbE/wJwtBYRoUve9Eb6QIhVrxcbbcSw+FJO9m
         7iiDdNpRrH7P7UlnmMtrQZdzDRkgby9GdqbOIC00sQneZn+tAVZiYhOtwMAtpDt70YJT
         W0Kg==
X-Gm-Message-State: AOJu0Yxj/7MMiWf4EjIpyPKyPqtSXtKJeDGrXHZJzbxr0FzWW416lOxQ
        Ak8jOawYD79FOr8C+iJYlbgtUNxWzEduME6cM0U5KlgmO45VmxUPJN4=
X-Google-Smtp-Source: AGHT+IEXREhN0QCHw4JhByYeog64RUzxQ1vaMpUYuUfifiJfTidhNz/iw1Ug/Bnk5aAZcTvF5yWugzL8QmphCZKjLeo=
X-Received: by 2002:a05:6102:2365:b0:44e:af33:4607 with SMTP id
 o5-20020a056102236500b0044eaf334607mr7210377vsa.2.1693299700108; Tue, 29 Aug
 2023 02:01:40 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Aug 2023 14:31:28 +0530
Message-ID: <CA+G9fYvFG4AuXiUQMFBaB8G+a2+-xxbikYkT7Rnpwj5s5KoVaQ@mail.gmail.com>
Subject: selftests: net: pmtu.sh: Unable to handle kernel paging request at
 virtual address
To:     Netdev <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The selftests: net: pmtu.sh running on Linux next got this kernel panic on
qemu-arm64.


logs:
====
[    0.000000] Linux version 6.5.0 (tuxmake@tuxmake) (Debian clang
version 18.0.0 (++20230822112105+841c4dc7e51e-1~exp1~20230822112223.851),
Debian LLD 18.0.0) #1 SMP PREEMPT @1693176139

...
# selftests: net: pmtu.sh
# TEST: ipv4: PMTU exceptions                                         [ OK ]
# TEST: ipv4: PMTU exceptions - nexthop objects                       [ OK ]
# TEST: ipv6: PMTU exceptions                                         [ OK ]
# TEST: ipv6: PMTU exceptions - nexthop objects                       [ OK ]

...

# TEST: vti4: PMTU exceptions, routed (ESP-in-UDP)                    [FAIL]
#   PMTU exception wasn't created after exceeding PMTU (IP payload length 1438)
# ./pmtu.sh: 938: kill: No such process
#
# ./pmtu.sh: 938: kill: No such process
#
<47>[  366.411270] systemd-journald[84]: Sent WATCHDOG=1 notification.
# TEST: vti4: default MTU assignment                                  [ OK ]
# TEST: vti6: default MTU assignment                                  [ OK ]
# TEST: vti4: MTU setting on link creation                            [ OK ]
# TEST: vti6: MTU setting on link creation                            [ OK ]
# TEST: vti6: MTU changes on link changes                             [ OK ]
# TEST: ipv4: cleanup of cached exceptions                            [ OK ]
# TEST: ipv4: cleanup of cached exceptions - nexthop objects          [ OK ]
# TEST: ipv6: cleanup of cached exceptions                            [ OK ]
# TEST: ipv6: cleanup of cached exceptions - nexthop objects          [ OK ]
<1>[  398.987591] Unable to handle kernel paging request at virtual
address ffff5dbb8189f000
<1>[  398.988469] Mem abort info:
<1>[  398.988712]   ESR = 0x0000000097b58004
<1>[  398.989264]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[  398.989893]   SET = 0, FnV = 0
<1>[  398.990312]   EA = 0, S1PTW = 0
<1>[  398.990768]   FSC = 0x04: level 0 translation fault
<1>[  398.992330] Data abort info:
<1>[  398.992591]   Access size = 4 byte(s)
<1>[  398.992811]   SSE = 1, SRT = 21
<1>[  398.993008]   SF = 1, AR = 0
<1>[  398.993243]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[  398.993601]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[  398.994094] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041d49000
<1>[  398.994603] [ffff5dbb8189f000] pgd=0000000000000000, p4d=0000000000000000
<0>[  398.995464] Internal error: Oops: 0000000097b58004 [#1] PREEMPT SMP
<4>[  398.996177] Modules linked in: fou6 sit fou bridge stp llc vxlan
ip6_udp_tunnel udp_tunnel act_csum libcrc32c act_pedit cls_flower
sch_prio veth vrf macvtap macvlan tap crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 fuse drm dm_mod ip_tables x_tables [last
unloaded: test_blackhole_dev]
<4>[  398.999384] CPU: 1 PID: 132 Comm: kworker/u4:3 Not tainted 6.5.0 #1
<4>[  399.000045] Hardware name: linux,dummy-virt (DT)
<4>[  399.001079] Workqueue: netns cleanup_net
<4>[  399.002441] pstate: 824000c9 (Nzcv daIF +PAN -UAO +TCO -DIT
-SSBS BTYPE=--)
<4>[  399.003881] pc : percpu_counter_add_batch+0x28/0xd0
<4>[  399.004637] lr : dst_destroy+0x44/0x1e4
<4>[  399.004904] sp : ffff80008000be70
<4>[  399.005864] x29: ffff80008000be70 x28: ffffa2457df6ea40 x27:
ffffa2457df24008
<4>[  399.006586] x26: ffffa2457dffa000 x25: 000000000000000a x24:
0000000000000002
<4>[  399.007360] x23: 0000000000000000 x22: 000000000000000a x21:
ffff0000c0e90ec0
<4>[  399.008276] x20: 0000000000000000 x19: ffff0000c4f83440 x18:
0000000000000000
<4>[  399.009327] x17: ffff5dbb8189f000 x16: ffff800080008000 x15:
0000000000000010
<4>[  399.009653] x14: 0000000000000010 x13: 0000000000000004 x12:
0000000000000701
<4>[  399.010159] x11: 0000000000000001 x10: fffffc00030c7260 x9 :
ffff5dbb8189f000
<4>[  399.010742] x8 : 0000000000000000 x7 : 7f7f7f7f7f7f7f7f x6 :
fefefefefefefeff
<4>[  399.012056] x5 : 000000000010000e x4 : fffffc00030c7260 x3 :
000000000010000e
<4>[  399.013082] x2 : 0000000000000020 x1 : ffffffffffffffff x0 :
ffff0000c4f83440
<4>[  399.014716] Call trace:
<4>[  399.015702]  percpu_counter_add_batch+0x28/0xd0
<4>[  399.016399]  dst_destroy+0x44/0x1e4
<4>[  399.016681]  dst_destroy_rcu+0x14/0x20
<4>[  399.017009]  rcu_core+0x2d0/0x5e0
<4>[  399.017311]  rcu_core_si+0x10/0x1c
<4>[  399.017609]  __do_softirq+0xd4/0x23c
<4>[  399.017991]  ____do_softirq+0x10/0x1c
<4>[  399.018320]  call_on_irq_stack+0x24/0x4c
<4>[  399.018723]  do_softirq_own_stack+0x1c/0x28
<4>[  399.022639]  __irq_exit_rcu+0x6c/0xcc
<4>[  399.023434]  irq_exit_rcu+0x10/0x1c
<4>[  399.023962]  el1_interrupt+0x8c/0xc0
<4>[  399.024810]  el1h_64_irq_handler+0x18/0x24
<4>[  399.025324]  el1h_64_irq+0x64/0x68
<4>[  399.025612]  _raw_spin_lock_bh+0x0/0x6c
<4>[  399.026102]  cleanup_net+0x280/0x45c
<4>[  399.026403]  process_one_work+0x1d4/0x310
<4>[  399.027140]  worker_thread+0x248/0x470
<4>[  399.027621]  kthread+0xfc/0x184
<4>[  399.028068]  ret_from_fork+0x10/0x20
<0>[  399.029333] Code: d50343df aa0003f3 f9401008 d53cd049 (b8a86935)
<4>[  399.030578] ---[ end trace 0000000000000000 ]---
<0>[  399.031422] Kernel panic - not syncing: Oops: Fatal exception in interrupt
<2>[  399.032320] SMP: stopping secondary CPUs
<0>[  399.033487] Kernel Offset: 0x2244fc200000 from 0xffff800080000000
<0>[  399.033819] PHYS_OFFSET: 0x40000000
<0>[  399.034096] CPU features: 0x00000000,68f167a1,ccc6773f
<0>[  399.034779] Memory Limit: none
<0>[  399.035768] ---[ end Kernel panic - not syncing: Oops: Fatal
exception in interrupt ]---

Links:
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.5/testrun/19373075/suite/log-parser-test/test/check-kernel-oops/log
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.5/testrun/19373075/suite/log-parser-test/tests/
 -   https://storage.tuxsuite.com/public/linaro/lkft/builds/2UaRggcJ0lNsDMIbbFaiyz3Qwsi/

Steps to reproduce:
===================
#
# To install tuxrun to your home directory at ~/.local/bin:
# pip3 install -U --user tuxrun==0.48.0
#
# Or install a deb/rpm depending on the running distribution
# See https://tuxmake.org/install-deb/ or
# https://tuxmake.org/install-rpm/
#
# See https://tuxrun.org/ for complete documentation.
#
# Please follow the additional instructions if the tests are related to FVP:
# https://tuxrun.org/run-fvp/
#

tuxrun --runtime podman --device qemu-arm64 --boot-args rw --kernel
https://storage.tuxsuite.com/public/linaro/lkft/builds/2UaRggcJ0lNsDMIbbFaiyz3Qwsi/Image.gz
--modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2UaRggcJ0lNsDMIbbFaiyz3Qwsi/modules.tar.xz
--rootfs https://storage.tuxboot.com/debian/bookworm/arm64/rootfs.ext4.xz
--parameters SHARD_INDEX=1 --parameters SKIPFILE=skipfile-lkft.yaml
--parameters SHARD_NUMBER=5 --parameters
KSELFTEST=https://storage.tuxsuite.com/public/linaro/lkft/builds/2UaRggcJ0lNsDMIbbFaiyz3Qwsi/kselftest.tar.xz
--image docker.io/linaro/tuxrun-dispatcher:v0.48.0 --tests
kselftest-net --timeouts boot=30 kselftest-net=30


--
Linaro LKFT
https://lkft.linaro.org
