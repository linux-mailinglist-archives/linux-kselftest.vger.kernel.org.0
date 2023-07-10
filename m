Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A3874D4B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 13:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjGJLld (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 07:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGJLld (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 07:41:33 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BADF2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jul 2023 04:41:30 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-78f208ebf29so1329227241.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jul 2023 04:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688989290; x=1691581290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBSfg7DyDEyJCLblTJgvv+RYDN9cRBsU1n+qtNDqWLA=;
        b=CyCLfa/IHUucQEO/FxBPgJu5lL1Srkip48mXmtbCeFO2s+2HXlBCjmkWS8ufXf/Nsd
         Ma+inpsG6aqEbOJOuPMS1oYFnx2/WtQlAAc5DUdRyHX5l6E/ZG+BEGr9Te8BhqdigkN9
         JYpTQ0KxlMPamzAkoFomQ0djJPSzlO0r+FO5OJMgKpl9Q1eBB3U8VhCk9w/aqxmOWVqD
         hPT9QzgHPSECK+2YX5VyDmx9BawSBjx+M7Q7O5VKWazuGRdRNr+2FN3aDxTADxHuSfGS
         /md3jnUaMvGyrPUSsV7xlBVrJ6o/z4A0L45LoLoM/OZCmtztlhI7pFLJ32S+oYPL9YJQ
         0Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688989290; x=1691581290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBSfg7DyDEyJCLblTJgvv+RYDN9cRBsU1n+qtNDqWLA=;
        b=W/k4K6V4l3uFX6CGdy4nVtlqX/bmUdsh91n+KgLI5yHRa1fHi6aV5ieeBavDPwOCGQ
         aalPCf4jWZuHzpW9IebMQKkzInldizGBf3EbBHLOrGvvhIJzZ8R7xbACN0MrCxtrmVE0
         0mW8yIYaPTP30GH589TDkGpPVawSJxPWI/ftyqKWfB1cZIBqSDBszKDYETN/8sYdapGs
         7UuEsqp8pt2FXNfe06AwIEmbbnPzoObwaQmORugXXLFvOHT6TMVfGkv1AWpdIbZHG0Od
         CxsV7Qp5TgBjzcTeGPQ4RnPrGcZ5g5dSzMyd/S07+jezCz9c8wjPVllOlbvnJwJAZ2CG
         lJuA==
X-Gm-Message-State: ABy/qLY93ISrSdudCC9Us2sW0ZlTpvW+pMD/HkwYJML+Fwn5CiGzKLlI
        Ufn0Y+RHOV5MjIUsNtzi2an+17urjeeAZhDgbtHy1w==
X-Google-Smtp-Source: APBJJlHu5SkZgE2RAVpgS80j3Okn8U0orO9I/l7mJY1EEBs1AB0ouo2acaLPDuObYeL+PwxdON2O0qx7Gyy3NUTnacw=
X-Received: by 2002:a67:f9da:0:b0:445:bd3:5b3a with SMTP id
 c26-20020a67f9da000000b004450bd35b3amr4632827vsq.4.1688989289666; Mon, 10 Jul
 2023 04:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230709203826.141774942@linuxfoundation.org>
In-Reply-To: <20230709203826.141774942@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 10 Jul 2023 17:11:18 +0530
Message-ID: <CA+G9fYtEr-=GbcXNDYo3XOkwR+uYgehVoDjsP0pFLUpZ_AZcyg@mail.gmail.com>
Subject: Re: [PATCH 6.4 0/6] 6.4.3-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Qingfang DENG <qingfang.deng@siflower.com.cn>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
        Masahide NAKAMURA <nakam@linux-ipv6.org>,
        Ville Nuorvala <vnuorval@tcs.hut.fi>,
        Netdev <netdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 10 Jul 2023 at 02:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.4.3 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 11 Jul 2023 20:38:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.4.3-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h



Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


NOTE:
Following two issues are not specific to this round of review,
We have been noticing on stable-rc 6.4.1-rc1 release with
kselftest merge configs builds testing selftests: net tests.

1)
While running selftests: net: pmtu.sh on arm64 ARM juno-r2, qemu-arm64
and Raspberry Pi 4 Model B following kernel crash reported.

# selftests: net: pmtu.sh
# TEST: ipv4: PMTU exceptions                                         [ OK =
]
# TEST: ipv4: PMTU exceptions - nexthop objects                       [ OK =
]
# TEST: ipv6: PMTU exceptions                                         [FAIL=
]
#   PMTU exception wasn't created after exceeding MTU
# TEST: ipv6: PMTU exceptions - nexthop objects                       [FAIL=
]
#   PMTU exception wasn't created after exceeding MTU
# TEST: ICMPv4 with DSCP and ECN: PMTU exceptions                     [ OK =
]
# TEST: ICMPv4 with DSCP and ECN: PMTU exceptions - nexthop objects   [ OK =
]
# TEST: UDPv4 with DSCP and ECN: PMTU exceptions                      [ OK =
]
# TEST: UDPv4 with DSCP and ECN: PMTU exceptions - nexthop objects    [ OK =
]
# TEST: IPv4 over vxlan4: PMTU exceptions                             [ OK =
]
# TEST: IPv4 over vxlan4: PMTU exceptions - nexthop objects           [ OK =
]
# TEST: IPv6 over vxlan4: PMTU exceptions                             [FAIL=
]
#   PMTU exception wasn't created after exceeding link layer MTU on
vxlan interface
# TEST: IPv6 over vxlan4: PMTU exceptions - nexthop objects           [FAIL=
]
#   PMTU exception wasn't created after exceeding link layer MTU on
vxlan interface
# TEST: IPv4 over vxlan6: PMTU exceptions                             [ OK =
]
[  226.478625] Unable to handle kernel paging request at virtual
address ffff800974529000
[  226.486721] Mem abort info:
[  226.489534]   ESR =3D 0x0000000096000005
[  226.493304]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  226.498643]   SET =3D 0, FnV =3D 0
[  226.501716]   EA =3D 0, S1PTW =3D 0
[  226.504876]   FSC =3D 0x05: level 1 translation fault
[  226.509778] Data abort info:
[  226.512675]   ISV =3D 0, ISS =3D 0x00000005
[  226.516531]   CM =3D 0, WnR =3D 0
[  226.519518] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000827210=
00
[  226.526249] [ffff800974529000] pgd=3D10000009fffff003,
p4d=3D10000009fffff003, pud=3D0000000000000000
[  226.535343] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
[  226.541633] Modules linked in: act_csum libcrc32c act_pedit
cls_flower sch_prio bpfilter ip_tables x_tables veth macvtap tap tun
cfg80211 bluetooth rfkill tda998x hdlcd cec drm_dma_helper
onboard_usb_hub drm_kms_helper crct10dif_ce sch_fq_codel fuse drm
[last unloaded: test_blackhole_dev]
[  226.567412] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.3-rc2 #1
[  226.573614] Hardware name: ARM Juno development board (r2) (DT)
[  226.579549] pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  226.586534] pc : percpu_counter_add_batch+0x40/0x148
[  226.591529] lr : percpu_counter_add_batch+0x124/0x148
[  226.596603] sp : ffff800008003dc0
[  226.599926] x29: ffff800008003dc0 x28: ffff80000b282040 x27: ffff8000081=
99b00
[  226.607101] x26: ffff800008199ab4 x25: 0000000000000000 x24: ffff80000b3=
18888
[  226.614275] x23: ffff80000b274b80 x22: 0000000000000020 x21: 00000000000=
00000
[  226.621449] x20: ffffffffffffffff x19: ffff00082892d740 x18: 00000000000=
00000
[  226.628623] x17: ffff800974529000 x16: 0000000000000000 x15: 00000000000=
001da
[  226.635796] x14: 0000000000000400 x13: ffff8009745ce000 x12: 00000000000=
00000
[  226.642969] x11: ffff80000a7cac24 x10: 0000000000000000 x9 : ffff8000094=
984cc
[  226.650143] x8 : ffff800008003cd8 x7 : 0000000000000000 x6 : 00000000000=
00101
[  226.657317] x5 : 0000000000000000 x4 : ffff800008003da0 x3 : 00000000000=
00000
[  226.664489] x2 : 0000000100000101 x1 : ffff800974529000 x0 : 00000000000=
00000
[  226.671663] Call trace:
[  226.674116]  percpu_counter_add_batch+0x40/0x148
[  226.678756]  dst_destroy+0x18c/0x240
[  226.682351]  dst_destroy_rcu+0x24/0x40
[  226.686118]  rcu_core+0x464/0xe80
[  226.689453]  rcu_core_si+0x18/0x30
[  226.692872]  __do_softirq+0x130/0x4f4
[  226.696549]  ____do_softirq+0x18/0x30
[  226.700228]  call_on_irq_stack+0x24/0x58
[  226.704167]  do_softirq_own_stack+0x24/0x38
[  226.708367]  __irq_exit_rcu+0x17c/0x1b0
[  226.712220]  irq_exit_rcu+0x18/0x48
[  226.715723]  el1_interrupt+0x38/0x68
[  226.719314]  el1h_64_irq_handler+0x18/0x28
[  226.723426]  el1h_64_irq+0x64/0x68
[  226.726841]  cpuidle_enter_state+0x148/0x5b0
[  226.731129]  cpuidle_enter+0x40/0x60
[  226.734723]  do_idle+0x22c/0x2b8
[  226.737970]  cpu_startup_entry+0x30/0x40
[  226.741912]  rest_init+0x114/0x1c0
[  226.745329]  arch_call_rest_init+0x18/0x20
[  226.749444]  start_kernel+0x5e0/0x6f8
[  226.753121]  __primary_switched+0xbc/0xd0
[  226.757152] Code: 927902b9 36380775 d538d081 f9402e60 (b8616817)
[  226.763268] ---[ end trace 0000000000000000 ]---
[  226.767898] Kernel panic - not syncing: Oops: Fatal exception in interru=
pt
[  226.774790] SMP: stopping secondary CPUs
[  226.778932] Kernel Offset: disabled
[  226.782428] CPU features: 0x800004,18780800,0000421b
[  226.787408] Memory Limit: none
[  226.790479] ---[ end Kernel panic - not syncing: Oops: Fatal
exception in interrupt ]---


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.=
4.1-22-g3e37df3ffd9a/testrun/18251735/suite/log-parser-test/test/check-kern=
el-oops/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.=
4.1-22-g3e37df3ffd9a/testrun/18251735/suite/log-parser-test/tests/
 - https://lkft.validation.linaro.org/scheduler/job/6578667#L4613
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2SLr5Fizk6DFnf66n=
xHoLw4mw5n/

And

2)
While running selftests: net: vrf-xfrm-tests.sh on arm64 Raspberry Pi 4 Mod=
el B
and arm64 Qualcomm Technologies APQ 8016 SBC devices.

# selftests: net: vrf-xfrm-tests.sh

#
# No qdisc on VRF device
# TEST: IPv6 no xfrm policy                                           [ OK =
]
# Cannot open netlink socket: Protocol not supported
[ 3310.312970] audit: type=3D1334 audit(1651171022.511:197): prog-id=3D59 o=
p=3DLOAD
# TEST: IPv4 xfrm policy based on address                             [ OK =
]
# TEST: IPv6 xfrm policy based on address                             [ OK =
]
# Cannot open netlink socket: Protocol not supported
# TEST: IPv6 xfrm policy with VRF in selector                         [ OK =
]
# TEST: IPv4 xfrm policy with xfrm device                             [FAIL=
]
# TEST: IPv6 xfrm policy with xfrm device                             [FAIL=
]
#
# netem qdisc on VRF device
# Cannot open netlink socket: Protocol not supported
...
[ 3326.099841]
[ 3326.108605] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 3326.117159] WARNING: suspicious RCU usage
[ 3326.125672] 6.4.3-rc2 #1 Not tainted
[ 3326.134070] -----------------------------
[ 3326.142459] include/net/neighbour.h:302 suspicious
rcu_dereference_check() usage!
[ 3326.150984]
[ 3326.150984] other info that might help us debug this:
[ 3326.150984]
[ 3326.175738]
[ 3326.175738] rcu_scheduler_active =3D 2, debug_locks =3D 1
[ 3326.192048] 2 locks held by ping/19436:
[ 3326.200354]  #0: ffff00000bce3570 (sk_lock-AF_INET){+.+.}-{0:0},
at: raw_sendmsg+0x25c/0xf18
[ 3326.208962]  #1: ffff80000b397b98 (rcu_read_lock_bh){....}-{1:2},
at: vrf_finish_output+0x70/0x8d0
[ 3326.217663]
[ 3326.217663] stack backtrace:
[ 3326.234476] CPU: 1 PID: 19436 Comm: ping Not tainted 6.4.3-rc2 #1
[ 3326.243032] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[ 3326.251626] Call trace:
[ 3326.260137]  dump_backtrace+0xa0/0x128
[ 3326.268713]  show_stack+0x30/0x48
[ 3326.277235]  dump_stack_lvl+0x90/0xb0
[ 3326.285718]  dump_stack+0x18/0x28
[ 3326.294123]  lockdep_rcu_suspicious+0x16c/0x230
[ 3326.302589]  vrf_finish_output+0x664/0x8d0
[ 3326.311049]  vrf_output+0x104/0x410
[ 3326.319488]  ip_send_skb+0x60/0x128
[ 3326.327928]  ip_push_pending_frames+0x44/0x70
[ 3326.336395]  raw_sendmsg+0x584/0xf18
[ 3326.344815]  inet_sendmsg+0x50/0x88
[ 3326.353251]  __sys_sendto+0xfc/0x198
[ 3326.361650]  __arm64_sys_sendto+0x34/0x50
[ 3326.369890]  invoke_syscall+0x8c/0x120
[ 3326.377899]  el0_svc_common.constprop.0+0x104/0x130
[ 3326.385824]  do_el0_svc+0x44/0xb8
[ 3326.393644]  el0_svc+0x40/0xa8
[ 3326.401277]  el0t_64_sync_handler+0xbc/0x138
[ 3326.408721]  el0t_64_sync+0x190/0x198
[ 3326.416111]
[ 3326.423395] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 3326.430605] WARNING: suspicious RCU usage
[ 3326.437613] 6.4.3-rc2 #1 Not tainted
[ 3326.444481] -----------------------------
[ 3326.451275] include/net/neighbour.h:307 suspicious
rcu_dereference_check() usage!
[ 3326.458148]
[ 3326.458148] other info that might help us debug this:
[ 3326.458148]
[ 3326.477416]
[ 3326.477416] rcu_scheduler_active =3D 2, debug_locks =3D 1
[ 3326.489637] 2 locks held by ping/19436:
[ 3326.495704]  #0: ffff00000bce3570 (sk_lock-AF_INET){+.+.}-{0:0},
at: raw_sendmsg+0x25c/0xf18
[ 3326.501817]  #1: ffff80000b397b98 (rcu_read_lock_bh){....}-{1:2},
at: vrf_finish_output+0x70/0x8d0
[ 3326.509274]
[ 3326.509274] stack backtrace:
[ 3326.523226] CPU: 1 PID: 19436 Comm: ping Not tainted 6.4.3-rc2 #1
[ 3326.528565] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[ 3326.533774] Call trace:
[ 3326.540093]  dump_backtrace+0xa0/0x128
[ 3326.545130]  show_stack+0x30/0x48
[ 3326.550107]  dump_stack_lvl+0x90/0xb0
[ 3326.554925]  dump_stack+0x18/0x28
[ 3326.559493]  lockdep_rcu_suspicious+0x16c/0x230
[ 3326.563974]  vrf_finish_output+0x618/0x8d0
[ 3326.568383]  vrf_output+0x104/0x410
[ 3326.572598]  ip_send_skb+0x60/0x128
[ 3326.576589]  ip_push_pending_frames+0x44/0x70
[ 3326.580477]  raw_sendmsg+0x584/0xf18
[ 3326.584239]  inet_sendmsg+0x50/0x88
[ 3326.587983]  __sys_sendto+0xfc/0x198
[ 3326.591723]  __arm64_sys_sendto+0x34/0x50
[ 3326.595464]  invoke_syscall+0x8c/0x120
[ 3326.599199]  el0_svc_common.constprop.0+0x104/0x130
[ 3326.602929]  do_el0_svc+0x44/0xb8
[ 3326.606753]  el0_svc+0x40/0xa8
[ 3326.610378]  el0t_64_sync_handler+0xbc/0x138
[ 3326.614029]  el0t_64_sync+0x190/0x198
# TEST: IPv4 no xfrm policy                                           [ OK =
]

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.=
4.1-22-g3e37df3ffd9a/testrun/18251800/suite/log-parser-test/test/check-kern=
el-warning/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.=
4.1-22-g3e37df3ffd9a/testrun/18251800/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.=
4.1-22-g3e37df3ffd9a/testrun/18251384/suite/log-parser-test/tests/


 metadata:
  git_ref: linux-6.4.y
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
  git_sha: 3e37df3ffd9a648c9f88f6bbca158e43d5077bef
  git_describe: v6.4.1-22-g3e37df3ffd9a
  kernel_version: 6.4.3-rc2
  kernel-config:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2SLr5Fizk6DFnf66=
nxHoLw4mw5n/config
  artifact-location:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2SLr5Fizk6DFnf66=
nxHoLw4mw5n/
  toolchain: gcc-11


## Build
* kernel: 6.4.3-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.4.y
* git commit: 3e37df3ffd9a648c9f88f6bbca158e43d5077bef
* git describe: v6.4.1-22-g3e37df3ffd9a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4.1=
-22-g3e37df3ffd9a

## Test Regressions (compared to v6.4.1)

## Metric Regressions (compared to v6.4.1)

## Test Fixes (compared to v6.4.1)

## Metric Fixes (compared to v6.4.1)

## Test result summary
total: 173253, pass: 148435, fail: 2272, skip: 22546, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 145 passed, 0 failed
* arm64: 54 total, 53 passed, 1 failed
* i386: 41 total, 41 passed, 0 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 25 passed, 1 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

## Test suites summary
* boot
* fwts
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-exec
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
