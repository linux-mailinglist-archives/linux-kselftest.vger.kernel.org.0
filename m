Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1F5357295
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Apr 2021 19:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354471AbhDGRCw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Apr 2021 13:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348168AbhDGRCv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Apr 2021 13:02:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24183C061760
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Apr 2021 10:02:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id mh7so18890286ejb.12
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Apr 2021 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Kzd9qjSyiIdRGRv1a8I2BXMSMMM2iwJnwEEA8EXbPM4=;
        b=hCKUK9D6Mq3mk1dDNGhf9DKy+xAw1ANR6juhHoz/18vCd4oPkWUBa535QdvBtEU2Jh
         Dk666bxVbHjrfN4iqNHn2bFPQ0FcYJIbCfSj7JuBkTTlGUDIdJsFc41yiU+5ay0ywSSo
         Mehgr3aPS5Jusq32HxehQjPgct+2CnfINdlf+vnjxTxn8YECakIaiKUjFIB9dEjKYtCV
         OxJQ5hnVK2wyqDcfx0bqAt3XVJ5PVBNodY/zkadivmCJDU5FGxB6yBcqt3FzE8RYDcFx
         rdeJGoOEJKwP9rNJRQCT7cPrDE8hJmGEMc1bqCXhq9o/T87Sw//08iquvkSujs4XdTo9
         p4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Kzd9qjSyiIdRGRv1a8I2BXMSMMM2iwJnwEEA8EXbPM4=;
        b=mBoXCQ4Yh0chKXBSfWLmPrpAlSK8cwfXKYmWsmVuRLF0TuIc/JlNyfwAtgoi4EQKU7
         fwRrIJSf8LJUmGTkGre4ar2hXrZ3yqLVVg+r2W9l2N/jIPV1ac0NNus8z/c8+ne+AETp
         hG5E+el/8aOY4A9QAMskAkGH/YbEe2PzuRA34mPWixtP8wGz/7hGAI32BfZQsowO7DsV
         kvRMfRymDAWAQqP4AxTqyBMI8sNbTD1/+bnxrvka4eWqkildgGLgoZmYJ5ncBETto0nT
         dI85ZdrEo8dXQC0f9Dm2g3hWt9oTWIO5YPdCWcVdiVpydYE8T1RNc26RhkjDGdQnxwSW
         wE1g==
X-Gm-Message-State: AOAM531R62PkUjG6lAJQCCa0uoA8Pd3Uqg8/vDwxcISJNx3upQN+DCEQ
        j++Jj7Qqeri0PULydAu/f4q6mQUcScO9+IvRYNdSKg==
X-Google-Smtp-Source: ABdhPJxSDyGdttgjxAkz8ovQ4J2Wgwa/pH16H7lH0aV6WD9ECK/hk8B9BgdBBjlaZHva4mpl5A5Q7I7LPjGrLPuhIBo=
X-Received: by 2002:a17:907:2509:: with SMTP id y9mr4757730ejl.170.1617814958642;
 Wed, 07 Apr 2021 10:02:38 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 7 Apr 2021 22:32:26 +0530
Message-ID: <CA+G9fYsiRYaE+y44ApDkvPvbDCdiJ+nnCMhiiaPVsg6p8m4+1Q@mail.gmail.com>
Subject: [next] [arm64] [gpio] BUG: key has not been registered! DEBUG_LOCKS_WARN_ON:
To:     linux-gpio@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Colin King <colin.king@canonical.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While running kselftest recently added gpio gpio-sim.sh test case the following
warning was triggered on Linux next tag 20210330 tag running on arm64 juno
and hikey devices.

GOOD: next-20210326
BAD: next-20210330

This is still happening today on Linux next tag 20210407.

# selftests: gpio: gpio-sim.sh
# 1. chip_name and dev_name attributes
# 1.1. Chip name is communicated to user
[  143.081193] BUG: key ffff000800eba398 has not been registered!
[  143.087326] ------------[ cut here ]------------
[  143.091987] DEBUG_LOCKS_WARN_ON(1)
[  143.092005] WARNING: CPU: 1 PID: 1821 at
/usr/src/kernel/kernel/locking/lockdep.c:4688
lockdep_init_map_type+0xf0/0x298
[  143.106223] Modules linked in: gpio_sim rfkill tda998x cec
drm_kms_helper drm crct10dif_ce fuse [last unloaded: gpio_mockup]
[  143.117495] CPU: 1 PID: 1821 Comm: mv Not tainted 5.12.0-rc5-next-20210330 #1
[  143.124645] Hardware name: ARM Juno development board (r2) (DT)
[  143.130572] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
[  143.136589] pc : lockdep_init_map_type+0xf0/0x298
[  143.141302] lr : lockdep_init_map_type+0xf0/0x298
[  143.146014] sp : ffff800013fb3560
[  143.149330] x29: ffff800013fb3560 x28: 00000000ffffee4b
[  143.154655] x27: 00000000000011b4 x26: 0000000000001000
[  143.159979] x25: ffff000800eba380 x24: 0000000000000000
[  143.165303] x23: 0000000000000000 x22: 0000000000000000
[  143.170626] x21: ffff80001382b000 x20: ffff000800eba398
[  143.175949] x19: ffff000827ac32a8 x18: ffffffffffffffff
[  143.181273] x17: 0000000000000000 x16: 0000000000000000
[  143.186595] x15: ffff800012900a88 x14: ffff800093fb3167
[  143.191918] x13: ffff800013fb3175 x12: 000000000000a0ec
[  143.197241] x11: 0000000005f5e0ff x10: ffff800013fb30c0
[  143.202565] x9 : ffff800013fb3560 x8 : 4e5241575f534b43
[  143.207888] x7 : ffff800012989ad8 x6 : ffff800013fb3180
[  143.213211] x5 : 0000000000000001 x4 : 0000000000000001
[  143.218534] x3 : ffff800012901000 x2 : 0000000000000000
[  143.223856] x1 : b4b7acac5f71bc00 x0 : 0000000000000000
[  143.229180] Call trace:
[  143.231625]  lockdep_init_map_type+0xf0/0x298
[  143.235989]  __kernfs_create_file+0xa8/0x1d0
[  143.240268]  sysfs_add_file_mode_ns+0xa8/0x1f8
[  143.244718]  internal_create_group+0x118/0x420
[  143.249169]  sysfs_create_group+0x2c/0x38
[  143.253185]  gpio_sim_probe+0x358/0x3c0 [gpio_sim]
[  143.257995]  platform_probe+0x6c/0xd8
[  143.261663]  really_probe+0x16c/0x508
[  143.265332]  driver_probe_device+0x104/0x178
[  143.269610]  __device_attach_driver+0xa4/0x130
[  143.274062]  bus_for_each_drv+0x78/0xd8
[  143.277903]  __device_attach+0xf0/0x178
[  143.281745]  device_initial_probe+0x24/0x30
[  143.285935]  bus_probe_device+0xa0/0xa8
[  143.289776]  device_add+0x424/0x810
[  143.293270]  platform_device_add+0x12c/0x2c0
[  143.297545]  platform_device_register_full+0x124/0x150
[  143.302692]  gpio_sim_config_commit_item+0x160/0x1e0 [gpio_sim]
[  143.308628]  configfs_rename+0x1dc/0x220
[  143.312557]  vfs_rename+0x394/0x960
[  143.316051]  do_renameat2+0x408/0x4c0
[  143.319718]  __arm64_sys_renameat+0x5c/0x70
[  143.323908]  el0_svc_common+0x7c/0x158
[  143.327665]  do_el0_svc+0x38/0x90
[  143.330985]  el0_svc+0x20/0x30
[  143.334045]  el0_sync_handler+0x8c/0xb0
[  143.337886]  el0_sync+0x13c/0x140
[  143.341204] irq event stamp: 5607
[  143.344520] hardirqs last  enabled at (5607): [<ffff800011462dd8>]
_raw_spin_unlock_irq+0x48/0x90
[  143.353410] hardirqs last disabled at (5606): [<ffff8000114586c4>]
__schedule+0x364/0x950
[  143.361605] softirqs last  enabled at (5602): [<ffff800010010958>]
__do_softirq+0x510/0x63c
[  143.369971] softirqs last disabled at (5577): [<ffff8000100a7474>]
irq_exit+0x1b4/0x1c0
[  143.377992] ---[ end trace bc3c86ef609281aa ]---
# 1.2. chip_name returns 'none' if the chip is still pending

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git describe: next-20210330
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/juno/lkft/linux-next/995/config

https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210407/testrun/4306292/suite/linux-log-parser/test/check-kernel-bug-2485709/log

Full test log link,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210330/testrun/4268728/suite/linux-log-parser/test/check-kernel-bug-2463256/log

git log --oneline next-20210326..next-20210330  -- tools/testing/selftests/gpio/
9d940ab72645 selftests: gpio: add test cases for gpio-sim
8a4cb2823240 selftests: gpio: add a helper for reading GPIO line names
ab1dbed6f4e8 selftests: gpio: provide a helper for reading chip info

--
Linaro LKFT
https://lkft.linaro.org
