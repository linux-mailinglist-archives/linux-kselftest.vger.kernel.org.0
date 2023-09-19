Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5582F7A62FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 14:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjISMbt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 08:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjISMbs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 08:31:48 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907D612E;
        Tue, 19 Sep 2023 05:31:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so31874131fa.3;
        Tue, 19 Sep 2023 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695126698; x=1695731498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GBM/d/y+VGBE0QtQGNH7m+58oGIbKIKnFew37NqCiU=;
        b=JyertOL+ir2gfQ66tOjO1O9DDHkW92RdLVwX7+soWDnqsDsajIXIvbyGlts6WyyuJj
         qyIXFoEvDFKdW1UOkhnnw4OZEp8xy34ocO/+hWzbAnWsW4BZQPAXi2Qlyt1Xoi+vQjmB
         S2aL7TPnAcDje2M5bNTqIJ3yF7AgzcAAZqLTuI2/mTm1sg7pU1VQrLU1XTmumWqRFazr
         IRv/+aylbVrVk7xlU6RMO+k9T3it9nq9OFKJsKmJy6L+G/XSL4YjE4vK6DQcwXYLBv0Y
         m3sltJiXuVx74KzHk/Ro9F6QhdeNkziOmA8GOHNQV0xT2GYN42P8irYdxfAcJmiHe6lL
         0uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695126698; x=1695731498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GBM/d/y+VGBE0QtQGNH7m+58oGIbKIKnFew37NqCiU=;
        b=qn7HpCcKVCxFfrBxoVdUQGnHz3siOAAMfibk7HCh6ABXfcpMK6xqHF+Hh+oHojfTKN
         yQtLHzeS95ujWHpJZt6YDD4g+Lpe4GylJ/htWW/nuTDCX7p1T4qz8R6oXblyUckHK3Zf
         uJgJ7hhE5t2msnIVlmgFZdMHqI+L8LbcGhnZxun2+PI4mSORzprNta8GKTjP9wuj9gei
         bpE7rYBSBV2XvXyRNP5+FTIWoCp+7KiaRXVSm2crBv+ZJ6PW9c72s2f9n1P3lI5ZOgBy
         C09ViWol5cQ+D59sX98KOlJDbSC5/ddLrZDBc5h3seLPWw9mB6kb1qhVhe2OdWPyZXhH
         3I3w==
X-Gm-Message-State: AOJu0YysYInSLofkY5i9T8jSw4wktLjvi+H/7yViT/z2Fe3Ple72lsk3
        Xk2jeYYCtyijiupoGJLwucwojtPMb3weOnYCbI0=
X-Google-Smtp-Source: AGHT+IGXd+dYXM1AVPCXLIoZaJgafQpClyYxciXGYOEzNL6YfFx58N8P1T/gpM66ImYZIkwdubstj956rUzUSwfV7r8=
X-Received: by 2002:a2e:92d0:0:b0:2bf:645b:6afb with SMTP id
 k16-20020a2e92d0000000b002bf645b6afbmr10327268ljh.21.1695126698178; Tue, 19
 Sep 2023 05:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230903151328.2981432-1-joel@joelfernandes.org> <CA+bgdggjp-sYfgRHV18vnc53SoHUU4=0bQHUxvSN8LZFchVjtw@mail.gmail.com>
In-Reply-To: <CA+bgdggjp-sYfgRHV18vnc53SoHUU4=0bQHUxvSN8LZFchVjtw@mail.gmail.com>
From:   zhenyu zhang <zhenyzha12@gmail.com>
Date:   Tue, 19 Sep 2023 20:31:27 +0800
Message-ID: <CA+bgdghsqihD6DoraL29P0Te5N9H-w4JDsC=JKAn0ZqYaay8bA@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] Optimize mremap during mutual alignment within PMD
To:     joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>, gshan@redhat.com,
        david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sorry for the late update. After removing this patch, the issue still exist=
s.
And a kernel thread will be generated, which always triggers call trace on =
the
host and cannot be killed. causes host kernel damage.
So this is a upstream issue and has nothing to do with this patch.
This issue will be discussed elsewhere later.

Behavior is as expected for this patch.

on 64k host
[root@virt-mtsnow-02 mm]# ./mremap_test
# Test configs:
threshold_mb=3D4
pattern_seed=3D1695026632

1..19
# mremap failed: Invalid argument
ok 1 # XFAIL mremap - Source and Destination Regions Overlapping
Expected mremap failure
# mremap failed: Invalid argument
ok 2 # XFAIL mremap - Destination Address Misaligned (1KB-aligned)
Expected mremap failure
# Failed to map source region: Invalid argument
ok 3 # XFAIL mremap - Source Address Misaligned (1KB-aligned)
Expected mremap failure
ok 4 8KB mremap - Source PTE-aligned, Destination PTE-aligned
mremap time:         5480ns
ok 5 2MB mremap - Source 1MB-aligned, Destination PTE-aligned
mremap time:         8560ns
ok 6 2MB mremap - Source 1MB-aligned, Destination 1MB-aligned
mremap time:         8721ns
ok 7 4MB mremap - Source PMD-aligned, Destination PTE-aligned
mremap time:        13240ns
ok 8 4MB mremap - Source PMD-aligned, Destination 1MB-aligned
mremap time:        13120ns
ok 9 4MB mremap - Source PMD-aligned, Destination PMD-aligned
mremap time:        13120ns
ok 10 2GB mremap - Source PUD-aligned, Destination PTE-aligned
ok 11 2GB mremap - Source PUD-aligned, Destination 1MB-aligned
ok 12 2GB mremap - Source PUD-aligned, Destination PMD-aligned
ok 13 2GB mremap - Source PUD-aligned, Destination PUD-aligned
ok 14 5MB mremap - Source 1MB-aligned, Destination 1MB-aligned
ok 15 5MB mremap - Source 1MB-aligned, Dest 1MB-aligned with 40MB Preamble
ok 16 mremap expand merge
ok 17 mremap expand merge offset
ok 18 mremap mremap move within range
ok 19 mremap move 1mb from start at 1MB+256KB aligned src
# Totals: pass:16 fail:0 xfail:3 xpass:0 skip:0 error:0



on 4k guest/ 64k host
[root@localhost mm]# ./mremap_test
# Test configs:
threshold_mb=3D4
pattern_seed=3D1695026539

1..19
# mremap failed: Invalid argument
ok 1 # XFAIL mremap - Source and Destination Regions Overlapping
Expected mremap failure
# mremap failed: Invalid argument
ok 2 # XFAIL mremap - Destination Address Misaligned (1KB-aligned)
Expected mremap failure
# Failed to map source region: Invalid argument
ok 3 # XFAIL mremap - Source Address Misaligned (1KB-aligned)
Expected mremap failure
ok 4 8KB mremap - Source PTE-aligned, Destination PTE-aligned
mremap time:         6080ns
ok 5 2MB mremap - Source 1MB-aligned, Destination PTE-aligned
mremap time:        98800ns
ok 6 2MB mremap - Source 1MB-aligned, Destination 1MB-aligned
mremap time:        54680ns
ok 7 4MB mremap - Source PMD-aligned, Destination PTE-aligned
mremap time:       193360ns
ok 8 4MB mremap - Source PMD-aligned, Destination 1MB-aligned
mremap time:       192440ns
ok 9 4MB mremap - Source PMD-aligned, Destination PMD-aligned
mremap time:         6400ns
ok 10 2GB mremap - Source PUD-aligned, Destination PTE-aligned
ok 11 2GB mremap - Source PUD-aligned, Destination 1MB-aligned
ok 12 2GB mremap - Source PUD-aligned, Destination PMD-aligned
ok 13 2GB mremap - Source PUD-aligned, Destination PUD-aligned
ok 14 5MB mremap - Source 1MB-aligned, Destination 1MB-aligned
ok 15 5MB mremap - Source 1MB-aligned, Dest 1MB-aligned with 40MB Preamble
ok 16 mremap expand merge
ok 17 mremap expand merge offset
ok 18 mremap mremap move within range
ok 19 mremap move 1mb from start at 1MB+256KB aligned src
# Totals: pass:16 fail:0 xfail:3 xpass:0 skip:0 error:0


Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>

On Mon, Sep 18, 2023 at 11:35=E2=80=AFPM zhenyu zhang <zhenyzha12@gmail.com=
> wrote:
>
> With 4k guest and 64k host, on aarch64(Ampere's Altra Max CPU) hit Call t=
race:
>     Steps:
>     1) System setup hugepages on host.
>        # echo 50 > /proc/sys/vm/nr_hugepages
>     2) Mount this hugepage to /mnt/kvm_hugepage.
>        # mount -t hugetlbfs -o pagesize=3D524288K none /mnt/kvm_hugepage
>     3) HugePages didn't leak when using non-existent mem-path.
>        # cd /home/kar/workspace/avocado-vt/virttest; mkdir -p /mnt/tmp
>     4) Run memory heavy stress inside guest.
>        # /usr/libexec/qemu-kvm \
>          ...
>          -m 25600 \
>          -object '{"size": 26843545600, "mem-path": "/mnt/tmp", "id":
> "mem-machine_mem", "qom-type": "memory-backend-file"}'  \
>          -smp 60,maxcpus=3D60,cores=3D30,threads=3D1,clusters=3D1,sockets=
=3D2  \
>        login guest:
>        # nohup stress --vm 50 --vm-bytes 256M --timeout 30s >
> /dev/null & ------> hit Call trace
>
> On guest kernel:
> 2023-09-18 07:54:03: [   76.592706] CPU: 23 PID: 254 Comm:
> kworker/23:1 Kdump: loaded Not tainted 6.6.0-rc2-zhenyzha_4k+ #3
> 2023-09-18 07:54:03: [   76.593782] Hardware name: QEMU KVM Virtual
> Machine, BIOS edk2-20230524-3.el9 05/24/2023
> 2023-09-18 07:54:03: [   76.594641] Workqueue: rcu_gp wait_rcu_exp_gp
> 2023-09-18 07:54:03: [   76.595248] pstate: 80400005 (Nzcv daif +PAN
> -UAO -TCO -DIT -SSBS BTYPE=3D--)
> 2023-09-18 07:54:03: [   76.596025] pc : smp_call_function_single+0xe4/0x=
1e8
> 2023-09-18 07:54:03: [   76.596833] lr :
> __sync_rcu_exp_select_node_cpus+0x27c/0x428
> 2023-09-18 07:54:03: [   76.597534] sp : ffff800084a0bc60
> 2023-09-18 07:54:03: [   76.598078] x29: ffff800084a0bc60 x28:
> ffff0003fdad9440 x27: 0000000000000001
> 2023-09-18 07:54:03: [   76.598874] x26: ffff800081a541b0 x25:
> ffff800081e0af40 x24: ffff0000c425ed80
> 2023-09-18 07:54:03: [   76.599817] x23: 0000000000000004 x22:
> ffff800081532fa0 x21: 0000000000000ffe
> 2023-09-18 07:54:03: [   76.600621] x20: ffff800081537440 x19:
> ffff800084a0bca0 x18: 0000000000000001
> 2023-09-18 07:54:03: [   76.601420] x17: 0000000000000000 x16:
> ffff800080f352e8 x15: 0000ffff97d02fff
> 2023-09-18 07:54:03: [   76.602212] x14: 0000000000000000 x13:
> 0000000000000030 x12: 0101010101010101
> 2023-09-18 07:54:03: [   76.603158] x11: ffff800081532fa0 x10:
> 0000000000000001 x9 : ffff80008014c714
> 2023-09-18 07:54:03: [   76.603963] x8 : ffff800081e03130 x7 :
> ffff800081521008 x6 : ffff80008014e070
> 2023-09-18 07:54:03: [   76.604759] x5 : 0000000000000000 x4 :
> ffff0003fda34c88 x3 : 0000000000000001
> 2023-09-18 07:54:03: [   76.605703] x2 : 0000000000000000 x1 :
> ffff0003fda34c80 x0 : 000000000000001c
> 2023-09-18 07:54:03: [   76.606507] Call trace:
> 2023-09-18 07:54:03: [   76.606990]  smp_call_function_single+0xe4/0x1e8
> 2023-09-18 07:54:03: [   76.607617]  __sync_rcu_exp_select_node_cpus+0x27=
c/0x428
> 2023-09-18 07:54:03: [   76.608290]  sync_rcu_exp_select_cpus+0x164/0x2e0
> 2023-09-18 07:54:03: [   76.608963]  wait_rcu_exp_gp+0x1c/0x38
> 2023-09-18 07:54:03: [   76.609563]  process_one_work+0x174/0x3c8
> 2023-09-18 07:54:03: [   76.610181]  worker_thread+0x2c8/0x3e0
> 2023-09-18 07:54:03: [   76.610776]  kthread+0x100/0x110
> 2023-09-18 07:54:03: [   76.611330]  ret_from_fork+0x10/0x20
> 2023-09-18 07:54:15: [   88.396191] rcu: INFO: rcu_preempt detected
> stalls on CPUs/tasks:
> 2023-09-18 07:54:15: [   88.397195] rcu: 11-...0: (18 ticks this GP)
> idle=3D79ec/1/0x4000000000000000 softirq=3D577/579 fqs=3D1215
> 2023-09-18 07:54:15: [   88.398244] rcu: 25-...0: (1 GPs behind)
> idle=3D599c/1/0x4000000000000000 softirq=3D300/301 fqs=3D1215
> 2023-09-18 07:54:15: [   88.399254] rcu: 33-...0: (36 ticks this GP)
> idle=3De454/1/0x4000000000000000 softirq=3D717/719 fqs=3D1216
> 2023-09-18 07:54:15: [   88.400275] rcu: (detected by 19, t=3D6006
> jiffies, g=3D1173, q=3D61327 ncpus=3D38)
> 2023-09-18 07:54:15: [   88.401135] Task dump for CPU 11:
> 2023-09-18 07:54:15: [   88.401711] task:stress          state:R
> running task     stack:0     pid:3182  ppid:3178   flags:0x00000202
> 2023-09-18 07:54:15: [   88.402794] Call trace:
> 2023-09-18 07:54:15: [   88.403312]  __switch_to+0xc8/0x110
> 2023-09-18 07:54:15: [   88.403915]  do_page_fault+0x198/0x4e0
> 2023-09-18 07:54:15: [   88.404533]  do_translation_fault+0x38/0x68
> 2023-09-18 07:54:15: [   88.405169]  do_mem_abort+0x48/0xa0
> 2023-09-18 07:54:15: [   88.405771]  el0_da+0x4c/0x180
> 2023-09-18 07:54:15: [   88.406337]  el0t_64_sync_handler+0xdc/0x150
> 2023-09-18 07:54:15: [   88.406991]  el0t_64_sync+0x17c/0x180
> 2023-09-18 07:54:15: [   88.407601] Task dump for CPU 25:
> 2023-09-18 07:54:15: [   88.408182] task:stress          state:R
> running task     stack:0     pid:3200  ppid:3178   flags:0x00000203
> 2023-09-18 07:54:15: [   88.409258] Call trace:
> 2023-09-18 07:54:15: [   88.409769]  __switch_to+0xc8/0x110
> 2023-09-18 07:54:15: [   88.410339]  0x440dc0
> 2023-09-18 07:54:15: [   88.410816] Task dump for CPU 33:
> 2023-09-18 07:54:15: [   88.411362] task:stress          state:R
> running task     stack:0     pid:3191  ppid:3178   flags:0x00000203
> 2023-09-18 07:54:15: [   88.412403] Call trace:
> 2023-09-18 07:54:15: [   88.412866]  __switch_to+0xc8/0x110
> 2023-09-18 07:54:15: [   88.413405]  __memcg_kmem_charge_page+0x270/0x2c0
> 2023-09-18 07:54:15: [   88.414033]  __alloc_pages+0x100/0x278
> 2023-09-18 07:54:15: [   88.414585]  memcg_stock+0x0/0x58
>
> On host kernel:
> 173242 Sep 18 08:57:51 virt-mtsnow-02 kernel: ------------[ cut here
> ]------------
> 173243 Sep 18 08:57:51 virt-mtsnow-02 systemd-journald[15184]: Missed
> 52 kernel messages
> 173244 Sep 18 08:57:51 virt-mtsnow-02 kernel: do_cow_fault+0xf0/0x300
> 173245 Sep 18 08:57:51 virt-mtsnow-02 systemd-journald[15184]: Missed
> 162 kernel messages
> 173246 Sep 18 08:57:51 virt-mtsnow-02 kernel: CPU: 14 PID: 11294 Comm:
> qemu-kvm Tainted: G        W          6.6.0-rc2-zhenyzha-64k+ #1
> 173247 Sep 18 08:57:51 virt-mtsnow-02 systemd-journald[15184]: Missed
> 226 kernel messages
> 173248 Sep 18 08:57:51 virt-mtsnow-02 kernel: x21: 0000000000000000
> 173249 Sep 18 08:57:51 virt-mtsnow-02 systemd-journald[15184]: Missed
> 120 kernel messages
> 173250 Sep 18 08:57:51 virt-mtsnow-02 kernel: __do_fault+0x40/0x210
> 173251 Sep 18 08:57:51 virt-mtsnow-02 systemd-journald[15184]: Missed
> 39 kernel messages
> 173252 Sep 18 08:57:51 virt-mtsnow-02 kernel: do_el0_svc+0xb4/0xd0
> 173253 Sep 18 08:57:51 virt-mtsnow-02 systemd-journald[15184]: Missed
> 325 kernel messages
> 173254 Sep 18 08:57:51 virt-mtsnow-02 kernel: get_user_pages_unlocked+0xc=
4/0x3b8
> 173255 Sep 18 08:57:51 virt-mtsnow-02 systemd-journald[15184]: Missed
> 255 kernel messages
> 173256 Sep 18 08:57:51 virt-mtsnow-02 kernel: pci_hyperv_intf
> i2c_designware_core
> 173257 Sep 18 08:57:51 virt-mtsnow-02 systemd-journald[15184]: Missed
> 87 kernel messages
> 173258 Sep 18 08:57:51 virt-mtsnow-02 kernel: xfs_filemap_fault+0x54/0x68=
 [xfs]
> 173259 Sep 18 08:57:51 virt-mtsnow-02 systemd-journald[15184]: Missed
> 248 kernel messages
> 173260 Sep 18 08:57:51 virt-mtsnow-02 kernel: pci_hyperv_intf
> 173261 Sep 18 08:57:51 virt-mtsnow-02 systemd-journald[15184]: Missed
> 69 kernel messages
> 173262 Sep 18 08:57:51 virt-mtsnow-02 kernel: Hardware name: GIGABYTE
> R152-P31-00/MP32-AR1-00, BIOS F18v (SCP: 1.08.20211002) 12/01/2021
> 173263 Sep 18 08:57:51 virt-mtsnow-02 systemd-journald[15184]: Missed
> 297 kernel messages
> 173264 Sep 18 08:57:51 virt-mtsnow-02 kernel: __filemap_add_folio+0x33c/0=
x4e0
> 173265 Sep 18 08:57:51 virt-mtsnow-02 systemd-journald[15184]: Missed
> 12 kernel messages
> 173266 Sep 18 08:57:51 virt-mtsnow-02 kernel: x26: 0000000000000001
> 173267 Sep 18 08:57:51 virt-mtsnow-02 systemd-journald[15184]: Missed
> 74 kernel messages
>
> [ 5456.588346] ------------[ cut here ]------------
> [ 5456.588358]  x10: 000000000000000a
> [ 5456.588365]  dm_mod
> [ 5456.588372]  nft_compat
> [ 5456.588374] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
> F18v (SCP: 1.08.20211002) 12/01/2021
> [ 5456.588417]  fat
> [ 5456.588421]  x16: 000000009872d4d0
> [ 5456.588430]  ipmi_msghandler arm_cmn
> [ 5456.588439]  x10: 000000000000000a
> [ 5456.588414]  __xfs_filemap_fault+0x60/0x3c0 [xfs]
> [ 5456.588454] x5 : 0000000000000028
> [ 5456.588460]  nvme_core
> [ 5456.588474]  pci_hyperv_intf
> [ 5456.588482] ------------[ cut here ]------------
> [ 5456.588488]  page_cache_async_ra+0x64/0xa8
> [ 5456.588491]  filemap_fault+0x238/0xaa8
> [ 5456.588506]  nf_defrag_ipv4 nf_tables
> [ 5456.588514]  nfs_acl
> [ 5456.588518]  x22: ffffffc202880000
> [ 5456.588525]  netfs
> [ 5456.588527]  stp
>
> [ 5456.588539]  acpi_ipmi
> [ 5456.588546]  x10: 000000000000000a
> [ 5456.588554]  x7 : ffff07ffa0a67210
> [ 5456.588562]  get_user_pages_unlocked+0xc4/0x3b8
> [ 5456.588567]  __gfn_to_pfn_memslot+0xa4/0xf8
> [ 5456.588575]  xas_split_alloc+0xf8/0x128
> [ 5456.588581]  sha1_ce
> [ 5456.588588]  i2c_algo_bit
> [ 5456.588592]  page_cache_async_ra+0x64/0xa8
>
>
> Using @gshan@redhat.com 's patch:KVM: arm64: Fix soft-lockup on
> relaxing PTE permission
> Still hit Call trace:
> 2023-09-18 10:56:20: [   57.494201] watchdog: BUG: soft lockup -
> CPU#58 stuck for 22s! [gsd-power:4858]
> 2023-09-18 10:56:20: [   57.495674] Modules linked in: nft_fib_inet
> nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink qrtr
> vfat fat fuse xfs libcrc32c virtio_gpu virtio_dma_buf drm_shmem_helper
> nvme_tcp drm_kms_helper nvme_fabrics nvme_core nvme_common sg drm
> crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce virtio_net
> net_failover virtio_scsi failover virtio_mmio dm_multipath dm_mirror
> dm_region_hash dm_log dm_mod be2iscsi cxgb4i cxgb4 tls libcxgbi
> libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi
> scsi_transport_iscsi
> 2023-09-18 10:56:20: [   57.501871] CPU: 58 PID: 4858 Comm: gsd-power
> Kdump: loaded Not tainted 6.6.0-rc2-zhenyzha_4k+ #3
> 2023-09-18 10:56:20: [   57.502719] Hardware name: QEMU KVM Virtual
> Machine, BIOS edk2-20230524-3.el9 05/24/2023
> 2023-09-18 10:56:20: [   57.503540] pstate: 20400005 (nzCv daif +PAN
> -UAO -TCO -DIT -SSBS BTYPE=3D--)
> 2023-09-18 10:56:20: [   57.504612] pc : smp_call_function_many_cond+0x16=
c/0x618
> 2023-09-18 10:56:20: [   57.505425] lr : smp_call_function_many_cond+0x18=
8/0x618
> 2023-09-18 10:56:20: [   57.505974] sp : ffff8000870f38f0
> 2023-09-18 10:56:20: [   57.506370] x29: ffff8000870f38f0 x28:
> 000000000000003c x27: ffff00063c5dcaa0
> 2023-09-18 10:56:20: [   57.507041] x26: 000000000000003c x25:
> 000000000000003b x24: ffff00063c5b6848
> 2023-09-18 10:56:20: [   57.507812] x23: 0000000000000000 x22:
> ffff00063c5b6848 x21: ffff800081a541b0
> 2023-09-18 10:56:20: [   57.508513] x20: ffff00063c5b6840 x19:
> ffff800081a4f840 x18: 0000000000000014
> 2023-09-18 10:56:20: [   57.509247] x17: 00000000fd875552 x16:
> 0000000044ca0210 x15: 000000005df1120b
> 2023-09-18 10:56:20: [   57.509947] x14: 00000000ac15cb21 x13:
> 00000000b7ff1817 x12: 0000000006d3918c
> 2023-09-18 10:56:20: [   57.510645] x11: 00000000ba65fdab x10:
> 00000000f60c2b88 x9 : ffff80008061a9dc
> 2023-09-18 10:56:20: [   57.511264] x8 : ffff00063c5b6a50 x7 :
> 0000000000000000 x6 : 0000000001000000
> 2023-09-18 10:56:20: [   57.511817] x5 : 000000000000003c x4 :
> 0000000000000007 x3 : ffff00063bf28aa8
> 2023-09-18 10:56:20: [   57.512415] x2 : 0000000000000000 x1 :
> 0000000000000011 x0 : 0000000000000007
> 2023-09-18 10:56:20: [   57.513092] Call trace:
> 2023-09-18 10:56:20: [   57.515105]  smp_call_function_many_cond+0x16c/0x=
618
> 2023-09-18 10:56:20: [   57.515684]  kick_all_cpus_sync+0x48/0x80
> 2023-09-18 10:56:20: [   57.516039]  flush_icache_range+0x40/0x60
> 2023-09-18 10:56:20: [   57.516413]  bpf_int_jit_compile+0x1ac/0x5f8
> 2023-09-18 10:56:20: [   57.516821]  bpf_prog_select_runtime+0xd4/0x110
> 2023-09-18 10:56:20: [   57.517279]  bpf_prepare_filter+0x1e8/0x220
> 2023-09-18 10:56:20: [   57.517727]  __get_filter+0xdc/0x180
> 2023-09-18 10:56:20: [   57.518231]  sk_attach_filter+0x1c/0xb0
> 2023-09-18 10:56:20: [   57.518605]  sk_setsockopt+0x9dc/0x1230
> 2023-09-18 10:56:20: [   57.518909]  sock_setsockopt+0x18/0x28
> 2023-09-18 10:56:20: [   57.519177]  __sys_setsockopt+0x164/0x190
> 2023-09-18 10:56:20: [   57.519501]  __arm64_sys_setsockopt+0x2c/0x40
> 2023-09-18 10:56:20: [   57.519911]  invoke_syscall.constprop.0+0x7c/0xd0
> 2023-09-18 10:56:20: [   57.520345]  do_el0_svc+0xb4/0xd0
> 2023-09-18 10:56:20: [   57.520670]  el0_svc+0x50/0x228
> 2023-09-18 10:56:20: [   57.521331]  el0t_64_sync_handler+0x134/0x150
> 2023-09-18 10:56:20: [   57.521758]  el0t_64_sync+0x17c/0x180
> 2023-09-18 10:56:23: [   60.724199] watchdog: BUG: soft lockup -
> CPU#28 stuck for 26s! [(fwupd):5108]
>
> [ 6253.928601] CPU: 64 PID: 18885 Comm: qemu-kvm Kdump: loaded
> Tainted: G        W          6.6.0-rc1-zhenyzha_64k+ #2
> [ 6253.939021] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
> F31n (SCP: 2.10.20220810) 09/30/2022
> [ 6253.948312] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [ 6253.955262] pc : xas_split_alloc+0xf8/0x128
> [ 6253.959432] lr : __filemap_add_folio+0x33c/0x4e0
> [ 6253.964037] sp : ffff80008b10f210
> [ 6253.967338] x29: ffff80008b10f210 x28: ffffba8c43708c00 x27: 000000000=
0000001
> [ 6253.974461] x26: 0000000000000001 x25: ffffffffffffc005 x24: 000000000=
0000000
> [ 6253.981583] x23: ffff80008b10f2c0 x22: 00000a36da000101 x21: 000000000=
0000000
> [ 6253.988706] x20: ffffffc203be2a00 x19: 000000000000000d x18: 000000000=
0000014
> [ 6253.995828] x17: 00000000be237f61 x16: 000000001baa68cc x15: ffffba8c4=
29a5944
> [ 6254.002950] x14: ffffba8c429b57bc x13: ffffba8c429a5944 x12: ffffba8c4=
29b57bc
> [ 6254.010073] x11: ffffba8c4297160c x10: ffffba8c4365d414 x9 : ffffba8c4=
365857c
> [ 6254.017195] x8 : ffff80008b10f210 x7 : ffff07ffa1304900 x6 : ffff80008=
b10f210
> [ 6254.024317] x5 : 000000000000000e x4 : 0000000000000000 x3 : 000000000=
0012c40
> [ 6254.031439] x2 : 000000000000000d x1 : 000000000000000c x0 : 000000000=
0000000
> [ 6254.038562] Call trace:
> [ 6254.040995]  xas_split_alloc+0xf8/0x128
> [ 6254.044818]  __filemap_add_folio+0x33c/0x4e0
> [ 6254.049076]  filemap_add_folio+0x48/0xd0
> [ 6254.052986]  page_cache_ra_unbounded+0xf0/0x1f0
> [ 6254.057504]  page_cache_ra_order+0x8c/0x310
> [ 6254.061675]  filemap_fault+0x67c/0xaa8
> [ 6254.065412]  __xfs_filemap_fault+0x60/0x3c0 [xfs]
> [ 6254.070163]  xfs_filemap_fault+0x54/0x68 [xfs]
> [ 6254.074651]  __do_fault+0x40/0x210
> [ 6254.078040]  do_cow_fault+0xf0/0x300
> [ 6254.081602]  do_pte_missing+0x140/0x238
> [ 6254.085426]  handle_pte_fault+0x100/0x160
> [ 6254.089423]  __handle_mm_fault+0x100/0x310
> [ 6254.093506]  handle_mm_fault+0x6c/0x270
> [ 6254.097330]  faultin_page+0x70/0x128
> [ 6254.100893]  __get_user_pages+0xc8/0x2d8
> [ 6254.104802]  get_user_pages_unlocked+0xc4/0x3b8
> [ 6254.109320]  hva_to_pfn+0xf8/0x468
> [ 6254.112709]  __gfn_to_pfn_memslot+0xa4/0xf8
> [ 6254.116879]  user_mem_abort+0x174/0x7e8
> [ 6254.120702]  kvm_handle_guest_abort+0x2dc/0x450
> [ 6254.125220]  handle_exit+0x70/0x1c8
> [ 6254.128696]  kvm_arch_vcpu_ioctl_run+0x224/0x5b8
> [ 6254.133300]  kvm_vcpu_ioctl+0x28c/0x9d0
> [ 6254.137123]  __arm64_sys_ioctl+0xa8/0xf0
> [ 6254.141033]  invoke_syscall.constprop.0+0x7c/0xd0
> [ 6254.145725]  do_el0_svc+0xb4/0xd0
> [ 6254.149028]  el0_svc+0x50/0x228
> [ 6254.152157]  el0t_64_sync_handler+0x134/0x150
> [ 6254.156501]  el0t_64_sync+0x17c/0x180
> [ 6254.160151] ---[ end trace 0000000000000000 ]---
> [ 6254.164766] ------------[ cut here ]------------
> [ 6254.169370] WARNING: CPU: 64 PID: 18885 at lib/xarray.c:1010
> xas_split_alloc+0xf8/0x128
> [ 6254.177361] Modules linked in: loop isofs cdrom vhost_net vhost
> vhost_iotlb tap tun bluetooth tls nfsv3 rpcsec_gss_krb5 nfsv4
> dns_resolver nfs fscache netfs rpcrdma rdma_cm iw_cm ib_cm ib_core
> xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4
> nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 nf_tables nfnetlink bridge stp llc rfkill vfat fat ast
> drm_shmem_helper drm_kms_helper acpi_ipmi ipmi_ssif arm_spe_pmu
> ipmi_devintf ipmi_msghandler arm_cmn arm_dmc620_pmu arm_dsu_pmu
> cppc_cpufreq drm fuse nfsd auth_rpcgss nfs_acl lockd grace sunrpc xfs
> libcrc32c crct10dif_ce ghash_ce igb sha2_ce sha256_arm64 sha1_ce
> sbsa_gwdt i2c_designware_platform i2c_algo_bit i2c_designware_core
> xgene_hwmon sg dm_mirror dm_region_hash dm_log dm_mod
>
>
> Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
>
> On Mon, Sep 4, 2023 at 1:20=E2=80=AFAM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > Hello!
> >
> > Here is v6 of the mremap start address optimization / fix for exec warn=
ing.
> > Should be hopefully final now and only 2/7 and 6/7 need a tag. Thanks a=
 lot to
> > Lorenzo and Linus for the detailed reviews.
> >
> > Description of patches
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > These patches optimizes the start addresses in move_page_tables() and t=
ests the
> > changes. It addresses a warning [1] that occurs due to a downward, over=
lapping
> > move on a mutually-aligned offset within a PMD during exec. By initiati=
ng the
> > copy process at the PMD level when such alignment is present, we can pr=
event
> > this warning and speed up the copying process at the same time. Linus T=
orvalds
> > suggested this idea. Check the individual patches for more details.
> > [1] https://lore.kernel.org/all/ZB2GTBD%2FLWTrkOiO@dhcp22.suse.cz/
> >
> > History of patches:
> > v5->v6:
> > 1. Reworking the stack case a bit more and tested it (should be final n=
ow).
> > 2. Other small nits.
> >
> > v4->v5:
> > 1. Rebased on mainline.
> > 2. Several improvement suggestions from Lorenzo.
> >
> > v3->v4:
> > 1. Care to be taken to move purely within a VMA, in other words this ch=
eck
> >    in call_align_down():
> >     if (vma->vm_start !=3D addr_masked)
> >             return false;
> >
> >     As an example of why this is needed:
> >     Consider the following range which is 2MB aligned and is
> >     a part of a larger 10MB range which is not shown. Each
> >     character is 256KB below making the source and destination
> >     2MB each. The lower case letters are moved (s to d) and the
> >     upper case letters are not moved.
> >
> >     |DDDDddddSSSSssss|
> >
> >     If we align down 'ssss' to start from the 'SSSS', we will end up de=
stroying
> >     SSSS. The above if statement prevents that and I verified it.
> >
> >     I also added a test for this in the last patch.
> >
> > 2. Handle the stack case separately. We do not care about #1 for stack =
movement
> >    because the 'SSSS' does not matter during this move. Further we need=
 to do this
> >    to prevent the stack move warning.
> >
> >     if (!for_stack && vma->vm_start <=3D addr_masked)
> >             return false;
> >
> > v2->v3:
> > 1. Masked address was stored in int, fixed it to unsigned long to avoid=
 truncation.
> > 2. We now handle moves happening purely within a VMA, a new test is add=
ed to handle this.
> > 3. More code comments.
> >
> > v1->v2:
> > 1. Trigger the optimization for mremaps smaller than a PMD. I tested by=
 tracing
> > that it works correctly.
> >
> > 2. Fix issue with bogus return value found by Linus if we broke out of =
the
> > above loop for the first PMD itself.
> >
> > v1: Initial RFC.
> >
> > Joel Fernandes (1):
> > selftests: mm: Add a test for moving from an offset from start of
> > mapping
> >
> > Joel Fernandes (Google) (6):
> > mm/mremap: Optimize the start addresses in move_page_tables()
> > mm/mremap: Allow moves within the same VMA for stack moves
> > selftests: mm: Fix failure case when new remap region was not found
> > selftests: mm: Add a test for mutually aligned moves > PMD size
> > selftests: mm: Add a test for remapping to area immediately after
> > existing mapping
> > selftests: mm: Add a test for remapping within a range
> >
> > fs/exec.c                                |   2 +-
> > include/linux/mm.h                       |   2 +-
> > mm/mremap.c                              |  73 +++++-
> > tools/testing/selftests/mm/mremap_test.c | 301 +++++++++++++++++++----
> > 4 files changed, 329 insertions(+), 49 deletions(-)
> >
> > --
> > 2.42.0.283.g2d96d420d3-goog
> >
