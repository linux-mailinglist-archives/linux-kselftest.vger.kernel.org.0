Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF496C0BCA
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 09:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCTIKd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 04:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjCTIKc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 04:10:32 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2397816AD3
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Mar 2023 01:10:25 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id 187so9694661vsq.10
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Mar 2023 01:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679299824;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XyruMyeoD+hrWXP8aDdbCTVKCXuiXs+daA9a2pDM12k=;
        b=ynVAXvIGlNpjGEyh/kYClKuTqQkEgSZ7zHbBrLpI5ZkIL4ORHXlZJ3796YVEzCXM+g
         xDsDx5pbHCaW3oN2YULIE00GbTeZMcO9294GxPxRiydvYbAwp23bzz+y0LpdGuxKXbhY
         b8YEj9mvGS8qhVFk46FQ1mkpkWsTZsXCSYkDHiAiBVdUx+6uP+bXVALGtgSRuWE8QhFU
         X8KIR337W/H+9FX57g2JpCakwic8on7BhmnY24l60LgopVr9rgR+meJ/lQc7TVrBQUzH
         s3biSp3b4YgNeb/T6TG0K7tJBI6Y/OLiS72ygEF5BOOcyS/U9urQxMAaKgq8i0ZJgtdV
         Ij/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679299824;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyruMyeoD+hrWXP8aDdbCTVKCXuiXs+daA9a2pDM12k=;
        b=AM98765xa0iPWHhR8xfDAGXzE9isrBjYHdc5IvLxdyCkmepEZy2p9LCGE0KMVCmhbr
         nLRfzsB5EdSf9qPvJEZ2/5cDgV3aw/gDIdeY/WgCh/T3/k3b+UDu9lHh4IO/usH6SpFs
         9ssPKOwCk/QppabN8b+IgqBhcwBLPi+tTnHROatI675KqSITDhjV99foml79gkq/Gdsc
         zM2vsIu6hgLgviUmmLWPK30dqppdMpovmtPl23k9YF2rW290dVRuXDa0+ZxygrIjMuRP
         Fkft15IhMBj0O4HkDNjI2xOswUkbJJ1rm9bopNBKjYplk6VSpJ+0X3K0xd1atIfTlE8w
         MeTQ==
X-Gm-Message-State: AO0yUKWW/LZEusbAxAXX5MAi0Ot289d5Nxztwr8Tg+liXl9cR8rtkb7W
        840letY+ZrS6XKrS86ZjeesW9opzCywF+/QW/AYhxw==
X-Google-Smtp-Source: AK7set8eaj+BB0+NPpCjh6wmE7Sdv1oJ2Y69yRfbA/3vCmoCvkwdIZBtg50RWciS9RvhwDbSwZGM3gsqSgFSmaahUKE=
X-Received: by 2002:a67:c19d:0:b0:425:f1d7:79f7 with SMTP id
 h29-20020a67c19d000000b00425f1d779f7mr3493910vsj.1.1679299823993; Mon, 20 Mar
 2023 01:10:23 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 20 Mar 2023 13:40:13 +0530
Message-ID: <CA+G9fYstgoa7jsO9rTmdDR4ZDUFQXdDqax8SongkOCZxFmX3Og@mail.gmail.com>
Subject: selftests: arm64: list of test failures
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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

selftests: arm64 below list of test cases fails on Linux next and
Linux mainline builds with clang-16 and gcc-12 kernel booted on
recently configured tuxrun qemu-arm64 (v7.2) enabled with MTE=on.

Am I missing anything on test configs / environment ?

List of selftests: arm64 test failures,
 - not ok 38 selftests: arm64: check_buffer_fill # exit=1
 - not ok 39 selftests: arm64: check_child_memory # exit=1
 - not ok 41 selftests: arm64: check_ksm_options # exit=1
 - not ok 42 selftests: arm64: check_mmap_options # exit=1
 - not ok 44 selftests: arm64: check_tags_inclusion # exit=1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
--------
[    0.000000] Linux version 6.3.0-rc3-next-20230320 (tuxmake@tuxmake)
(Debian clang version 16.0.0
(++20230314094206+fce3e75e01ba-1~exp1~20230314094258.55), Debian LLD
16.0.0) #1 SMP PREEMPT @1679285968
..
[    0.000000] CPU features: detected: Memory Tagging Extension
..


# selftests: arm64: check_buffer_fill
# 1..20
# not ok 1 Check buffer correctness by byte with sync err mode and mmap memory
# not ok 2 Check buffer correctness by byte with async err mode and mmap memory
# not ok 3 Check buffer correctness by byte with sync err mode and
mmap/mprotect memory
# not ok 4 Check buffer correctness by byte with async err mode and
mmap/mprotect memory
# not ok 5 Check buffer write underflow by byte with sync mode and mmap memory
# not ok 6 Check buffer write underflow by byte with async mode and mmap memory
# ok 7 Check buffer write underflow by byte with tag check fault
ignore and mmap memory
# ok 8 Check buffer write underflow by byte with sync mode and mmap memory
# ok 9 Check buffer write underflow by byte with async mode and mmap memory
# ok 10 Check buffer write underflow by byte with tag check fault
ignore and mmap memory
# not ok 11 Check buffer write overflow by byte with sync mode and mmap memory
# not ok 12 Check buffer write overflow by byte with async mode and mmap memory
# ok 13 Check buffer write overflow by byte with tag fault ignore mode
and mmap memory
# not ok 14 Check buffer write correctness by block with sync mode and
mmap memory
# not ok 15 Check buffer write correctness by block with async mode
and mmap memory
# ok 16 Check buffer write correctness by block with tag fault ignore
and mmap memory
# ok 17 Check initial tags with private mapping, sync error mode and mmap memory
# ok 18 Check initial tags with private mapping, sync error mode and
mmap/mprotect memory
# ok 19 Check initial tags with shared mapping, sync error mode and mmap memory
# ok 20 Check initial tags with shared mapping, sync error mode and
mmap/mprotect memory
# # Totals: pass:10 fail:10 xfail:0 xpass:0 skip:0 error:0
not ok 38 selftests: arm64: check_buffer_fill # exit=1


# selftests: arm64: check_child_memory
# 1..12
# not ok 1 Check child anonymous memory with private mapping, precise
mode and mmap memory
# not ok 2 Check child anonymous memory with shared mapping, precise
mode and mmap memory
# not ok 3 Check child anonymous memory with private mapping,
imprecise mode and mmap memory
# not ok 4 Check child anonymous memory with shared mapping, imprecise
mode and mmap memory
# not ok 5 Check child anonymous memory with private mapping, precise
mode and mmap/mprotect memory
# not ok 6 Check child anonymous memory with shared mapping, precise
mode and mmap/mprotect memory
# not ok 7 Check child file memory with private mapping, precise mode
and mmap memory
# not ok 8 Check child file memory with shared mapping, precise mode
and mmap memory
# not ok 9 Check child file memory with private mapping, imprecise
mode and mmap memory
# not ok 10 Check child file memory with shared mapping, imprecise
mode and mmap memory
# not ok 11 Check child file memory with private mapping, precise mode
and mmap/mprotect memory
# not ok 12 Check child file memory with shared mapping, precise mode
and mmap/mprotect memory
# # Totals: pass:0 fail:12 xfail:0 xpass:0 skip:0 error:0
not ok 39 selftests: arm64: check_child_memory # exit=1

# selftests: arm64: check_ksm_options
# 1..4
# # Invalid MTE synchronous exception caught!
not ok 41 selftests: arm64: check_ksm_options # exit=1

# selftests: arm64: check_mmap_options
# 1..22
# ok 1 Check anonymous memory with private mapping, sync error mode,
mmap memory and tag check off
# ok 2 Check file memory with private mapping, sync error mode,
mmap/mprotect memory and tag check off
# ok 3 Check anonymous memory with private mapping, no error mode,
mmap memory and tag check off
# ok 4 Check file memory with private mapping, no error mode,
mmap/mprotect memory and tag check off
# not ok 5 Check anonymous memory with private mapping, sync error
mode, mmap memory and tag check on
# not ok 6 Check anonymous memory with private mapping, sync error
mode, mmap/mprotect memory and tag check on
# not ok 7 Check anonymous memory with shared mapping, sync error
mode, mmap memory and tag check on
# not ok 8 Check anonymous memory with shared mapping, sync error
mode, mmap/mprotect memory and tag check on
# not ok 9 Check anonymous memory with private mapping, async error
mode, mmap memory and tag check on
# not ok 10 Check anonymous memory with private mapping, async error
mode, mmap/mprotect memory and tag check on
# not ok 11 Check anonymous memory with shared mapping, async error
mode, mmap memory and tag check on
# not ok 12 Check anonymous memory with shared mapping, async error
mode, mmap/mprotect memory and tag check on
# not ok 13 Check file memory with private mapping, sync error mode,
mmap memory and tag check on
# not ok 14 Check file memory with private mapping, sync error mode,
mmap/mprotect memory and tag check on
# not ok 15 Check file memory with shared mapping, sync error mode,
mmap memory and tag check on
# not ok 16 Check file memory with shared mapping, sync error mode,
mmap/mprotect memory and tag check on
# not ok 17 Check file memory with private mapping, async error mode,
mmap memory and tag check on
# not ok 18 Check file memory with private mapping, async error mode,
mmap/mprotect memory and tag check on
# not ok 19 Check file memory with shared mapping, async error mode,
mmap memory and tag check on
# not ok 20 Check file memory with shared mapping, async error mode,
mmap/mprotect memory and tag check on
# not ok 21 Check clear PROT_MTE flags with private mapping, sync
error mode and mmap memory
# not ok 22 Check clear PROT_MTE flags with private mapping and sync
error mode and mmap/mprotect memory
# # Totals: pass:4 fail:18 xfail:0 xpass:0 skip:0 error:0
not ok 42 selftests: arm64: check_mmap_options # exit=1

# selftests: arm64: check_tags_inclusion
# 1..4
# # Unexpected fault recorded for 0xb00ffff97724000-0xb00ffff97724050 in mode 1
# not ok 1 Check an included tag value with sync mode
# # Unexpected fault recorded for 0xc00ffff97724000-0xc00ffff97724050 in mode 1
# not ok 2 Check different included tags value with sync mode
# ok 3 Check none included tags value with sync mode
# # Unexpected fault recorded for 0xc00ffff97724000-0xc00ffff97724050 in mode 1
# not ok 4 Check all included tags value with sync mode
# # Totals: pass:1 fail:3 xfail:0 xpass:0 skip:0 error:0
not ok 44 selftests: arm64: check_tags_inclusion # exit=1


steps to reproduce:
-------

# To install tuxrun on your system globally:
# sudo pip3 install -U tuxrun==0.38.1
#
# See https://tuxrun.org/ for complete documentation.

tuxrun  \
 --runtime podman  \
 --device qemu-arm64  \
 --boot-args rw  \
 --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2NGM7Z86D9eB4UfDbhPFzJ0q6qa/Image.gz
 \
 --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2NGM7Z86D9eB4UfDbhPFzJ0q6qa/modules.tar.xz
 \
 --rootfs https://storage.tuxboot.com/debian/bookworm/arm64/rootfs.ext4.xz  \
 --parameters SKIPFILE=skipfile-lkft.yaml  \
 --parameters KSELFTEST=https://storage.tuxsuite.com/public/linaro/lkft/builds/2NGM7Z86D9eB4UfDbhPFzJ0q6qa/kselftest.tar.xz
 \
 --image docker.io/lavasoftware/lava-dispatcher:2023.01.0020.gc1598238f  \
 --tests kselftest-arm64  \
 --timeouts boot=30 kselftest-arm64=60


Boot command:
......
/usr/bin/qemu-system-aarch64  \
 -cpu max,pauth-impdef=on  \
 -machine virt,gic-version=3,mte=on  \
 -nographic  \
 -nic none  \
 -m 4G  \
 -monitor none  \
 -no-reboot  \
 -smp 2  \
 -kernel Image  \
 -append \"console=ttyAMA0,115200 rootwait root=/dev/vda debug verbose
console_msg_format=syslog rw earlycon\"  \
 -drive file=/debian_bookworm_arm64_rootfs.ext4,if=none,format=raw,id=hd0  \
 -device virtio-blk-device,drive=hd0


Test log links,
Linux next:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230320/testrun/15730813/suite/kselftest-arm64/test/arm64_check_buffer_fill/log
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230320/testrun/15730813/suite/kselftest-arm64/test/arm64_check_buffer_fill/details/
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230320/testrun/15731016/suite/kselftest-arm64/test/arm64_check_buffer_fill/details/
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230320/testrun/15731016/suite/kselftest-arm64/test/arm64_check_buffer_fill/log

mainline:
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc3/testrun/15724690/suite/kselftest-arm64/test/arm64_check_buffer_fill/details/
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc3/testrun/15724690/suite/kselftest-arm64/test/arm64_check_buffer_fill/log


--
Linaro LKFT
https://lkft.linaro.org
