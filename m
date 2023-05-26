Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688307127B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 15:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242855AbjEZNik (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 09:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjEZNij (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 09:38:39 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7572D8;
        Fri, 26 May 2023 06:38:35 -0700 (PDT)
X-QQ-mid: bizesmtp66t1685108306txlguqb4
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 26 May 2023 21:38:25 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: D6RqbDSxuq6HnLLie3EOSagOrtQovMoO/c1ZDojJdhdkswrEDfVNTEkUj0kwK
        lL0kA4K1R0ac0uzzRVCeWqKdDuUszTc4QMmQRhfY8GatL4fQhlXKCss68nOUn67913VG7mF
        6g0HwKkHxQbjKdBP54BZX7IWEOVmxqArgAquJLmDkN1gUtxJqb7Mce1XtwBLxjaz223a1/8
        lS2USjspSMnYcZQnJIa0lk4R5fYl+toH0r3XL3iA4dTRmsd3GrqAa59N6NJVYnO6jDGNJBJ
        49it71G2yoeckv05RPq+XKAm7C8YmMGi60Q4daIC6bDhHCF+7SBMDMh5n5YtbJc/yQkih32
        /kS05+mflHkytfSp5XZIYkQSCbpz6BzQTLpwWlBxrf/qCseFCT7OU/GrpJgCQiAHbfVrYaT
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10011161400852395735
From:   Zhangjin Wu <falcon@tinylab.org>
To:     conor.dooley@microchip.com
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de,
        w@1wt.eu
Subject: Re: [PATCH 06/13] selftests/nolibc: allow specify a bios for qemu
Date:   Fri, 26 May 2023 21:38:25 +0800
Message-Id: <20230526133825.198100-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230526-clover-litter-1f41398cd820@wendy>
References: <20230526-clover-litter-1f41398cd820@wendy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Conor.

> 
> On Fri, May 26, 2023 at 06:25:18PM +0800, Zhangjin Wu wrote:
> 
> > > On 2023-05-25 01:52:29+0800, Zhangjin Wu wrote:
> > > > riscv qemu has a builtin bios (opensbi), but it may not match the latest
> > > > kernel and some old versions may hang during boot, let's allow user pass
> > > > a newer version to qemu via the -bios option.
> > >
> > > Nitpick:
> > >
> > > This seems very specific and hopefully only necessary temporarily.
> > >
> >
> > RISC-V is such a new ISA and the Spec (especially the SBI) changes very
> > frequently ;-)
> 
> Huh. Could you please expand on which versions of QEMU will hang while
> booting an upstream or stable kernel? Which kernels would be good to
> know too.
> 

As the cover letter listed (in the Environment section), the softwares we
used are:

    // higher qemu version is better, latest version is v8.0.0+
    $ qemu-system-riscv64  --version
    QEMU emulator version 4.2.1 (Debian 1:4.2-3ubuntu6.18)
    Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

    // opensbi version, higher is better, must match kernel version and qemu version
    // rv64: used version is 1.2, latest is 1.2
    $ head -2 /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.out | tail -1
    OpenSBI v1.2-116-g7919530
    // rv32: used version is v0.9, latest is 1.2
    $ head -2 /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.out | tail -1
    OpenSBI v0.9-152-g754d511

The kernel version is the one this patchset based on (Willy's nolibc
repo), it is v6.4-rc1.

qemu v4.2.1 is the one systematically installed (/usr/bin) from the
qemu-system-misc package and used to test this patchset in my Ubuntu
20.04 based test docker image.

Just installed a v7.0.0 qemu from ppa:canonical-server/server-backports,
there is no default opensbi, and re-checked, there is one prebuilt
opensbi for rv64, but still no prebuilt opensbi for rv32.

    $ sudo add-apt-repository ppa:canonical-server/server-backports
    $ sudo apt install qemu-system-misc

    $ sudo apt install opensbi
    $ dpkg -S opensbi | grep -E "fw_*bin|elf"
    qemu-system-data: /usr/share/qemu/opensbi-riscv64-generic-fw_dynamic.elf
    opensbi: /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_dynamic.elf
    opensbi: /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf

    $ qemu-system-riscv32 -display none -no-reboot -kernel build/riscv32/virt/linux/v6.4-rc1/arch/riscv/boot/Image -serial stdio -M virt -append "console=ttyS0 panic=-1"
    qemu-system-riscv32: Unable to load the RISC-V firmware "opensbi-riscv32-generic-fw_dynamic.bin"

I used the one built myself, If not want to build such opensbi manually,
we can download one (1.2 currently) from qemu source code:

    https://gitlab.com/qemu-project/qemu/-/blob/master/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin

Then, we can use it like this:

    $ qemu-system-riscv32 -display none -no-reboot -kernel build/riscv32/virt/linux/v6.4-rc1/arch/riscv/boot/Image -serial stdio -M virt -append "console=ttyS0 panic=-1" -bios /path/to/opensbi-riscv32-generic-fw_dynamic.bin

Will append this extra info in the commit message of the coming new
revision of this patch, thanks a lot.

The hang issue I mentioned may be using one of my older prebuilt version of
opensbi, I can not find which one it exactly is, so, please ignore that info,
will update that description too.

Btw, something not about this patch: qemu v8.0.0 seems not boot non-mmu
v6.3, both sides have issues, not dig into it carefully, so, not report
it yet.

Thanks,
Zhangjin

> Thanks,
> Conor.
