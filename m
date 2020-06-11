Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5DB1F6687
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jun 2020 13:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgFKLVt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 07:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgFKLVt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 07:21:49 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FB6C08C5C1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 04:21:48 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id r9so1977928ual.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 04:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=v6K8dYPLePc9zSArtvdVIRTLGMXpLZeo+ahECM1Djk4=;
        b=AOyWVe6f6+MQnh2h8ilSdTXrY9yoGMRBirxq3WSnrYPBgz45x91oq8WsDEPVHlwgeK
         NMIDVATn0SibktoTOfj/M+xtFwDxqQnJnVtxKsK1DNeOyX2C4WIL9+8d3L/yxPPTX4AL
         pLRbZlXm/PPKW5jiwtuHm1z1gJKoFPABzJNA3yhXGxcEY5ulRltKkitGPjwFihzog6bd
         /RZyd5cBB8LZpt7Yyz3FSmoKJT0ZADVf4B56s54sY1ms6LdNzL9RAAb8vO4+zxZ3/1X+
         ncE0s8nTRajkiwgLzwVs2j0Yt+AADmRRrvItx9eKq5Syrx589n/zbCEAQIl0qsUEld9t
         syYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=v6K8dYPLePc9zSArtvdVIRTLGMXpLZeo+ahECM1Djk4=;
        b=EnZBTmxvwFomh6xgV9NEVeczCWR0Adp4I72hKeSu/xwobBkeaXksYmAb/P0D5F7TzL
         u+YYB2ld4HKPQHPjHlafeU3ufEXlAp17jaiSUyO6MbTlRzidQ5qYRALxqRzOwnNmLn2G
         vVV+728Ii0HAyEtHDYaSDElQ+RXPNAN1ca7sBMlT2wDsyRcZFe/GOVDWnIoVia8/asXH
         HegzPuixoiOgV/aUKMZAscG0t4TSL1YBPOlgKQCG2r8jBiZEaOOlch7KVSpVtTLC9Tpk
         3ih4WAzG+oFvnbcrmqzPNyaUkhXXOWcA4d6cbQgjsma1dK6HBP2meoVzjopzF4P5ru1p
         +cdg==
X-Gm-Message-State: AOAM531PnK+IfABrq7ruTZmud/ELp2hYL/t2vl6ghqyyMoJ62Lys6FI+
        tfIEunhgx04Sv3qBn4Vr9F1Nb8UTwNx9+AyLXSBM3jL2zLM=
X-Google-Smtp-Source: ABdhPJwu9vMBmPn032USnmrHu+3NmkP/8T4EEEOzHFR9WGaOUHnM4xlxSk6WLzG3xp6VpvrSM+vJRANNKZhayAhDWXo=
X-Received: by 2002:ab0:186d:: with SMTP id j45mr6032407uag.104.1591874507350;
 Thu, 11 Jun 2020 04:21:47 -0700 (PDT)
MIME-Version: 1.0
From:   Akira Shibakawa <arabishi900@gmail.com>
Date:   Thu, 11 Jun 2020 20:21:35 +0900
Message-ID: <CAE84iWVZt1N=dRzKENeSsBP0V2ka+_gEyfkrVx_8pO9x2tnBFA@mail.gmail.com>
Subject: selftests: test stops at step_after_suspend_test
To:     linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, I tried to run kselftest but it stops with logs below.

----------------------------
# ./run_kselftest.sh
[  126.214906] kselftest: Running tests in android
TAP version 13
# selftests: android: run.sh
1..1
# ./run.sh: line 3: ./ion_test.sh: not found
not ok 1 selftests: android: run.sh # exit=127
[  126.351342] kselftest: Running tests in breakpoints
TAP version 13
# selftests: breakpoints: step_after_suspend_test
1..2
[  126.464495] PM: suspend entry (s2idle)
[  126.496441] Filesystems sync: 0.031 seconds
[  126.499299] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  126.501161] OOM killer disabled.
[  126.501293] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[  126.503018] printk: Suspending console(s) (use no_console_suspend to debug)
----------------------------

I used kernel 5.6.15 stable on qemu(x86_64) and used kselftest from same source.
I built kernel adding configurations below to be able to mount
kselftest directory on host.

----------------------------
CONFIG_NET_9P=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
CONFIG_VIRTIO_PCI=y
CONFIG_FUSE_FS=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_9P_FS=y
CONFIG_VIRTIO_FS=y
CONFIG_9P_FS_POSIX_ACL=y
CONFIG_CRYPTO_ENGINE=m
CONFIG_9P_FS_SECURITY=y
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_GDB_SCRIPTS=y
CONFIG_DEBUG_INFO=y
 ----------------------------

Then, I boot kernel with rootfs geterated by buildroot like this.

 ----------------------------
qemu-system-x86_64 -kernel arch/x86/boot/bzImage -boot c -m 2049M -hda
../buildroot/output/images/rootfs.ext4 -append \
"root=/dev/sda rw console=ttyS0,115200 acpi=off nokaslr" -serial
mon:stdio -display none \
-virtfs local,path=/home/arabishi/work/kselftest/kselftest,mount_tag=host0,security_model=passthrough,id=host0
 ----------------------------

What should I do ?
