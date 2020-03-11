Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 623FC181265
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 08:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgCKHwb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 03:52:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38165 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgCKHwb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 03:52:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id w1so1198801ljh.5
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Mar 2020 00:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OL34kr6b7JTbb1MQ43TrVAqLSZ/nro50ISzwyt4kVeo=;
        b=P8p0NuTI6Ati72RfbgQ6lL2Md8sNmfCq5FvEnYGQHHkQ8XqoMY1TCTDUjPrrxhHMJg
         r1RvBWtub64HsrW/BSh08NOtlmx/J6gxMepiKESyvbXawgFmGFESbDg0zKOMtKK7t0AB
         7rnYgykbam4b5NG+OtjKCD1GaCWU6orJtQ1t8MwB2wpk/DHorHQ7BB5PGVnb83TlUs2U
         qERtRRYU6qv4gl1pGgOFCXZZwraVoOpbzwb009qn2qOIl+u4GT4mCipCE0Yzx/LDb7eV
         85uAoegfmEPktTkt+Qp6p3t0Oy8ForbFjqoWsqbNAqlApRUMEoYiyQLNhPgzs6nPpd60
         aGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OL34kr6b7JTbb1MQ43TrVAqLSZ/nro50ISzwyt4kVeo=;
        b=iWWMZIQzxQVptGPWKLKnFy5eqjTz2/H1RnOXYAF1ti3vzECzGuiF82ZkzMsucGSGEH
         w1sWaK5sfGS52Znp5fRvcKk502j5s9pIkvZYqxicpmsnnzIE6zE/uPx3Ig/z9PC3nEzq
         VVU399v2AcIrS8U6LvgJSEckoG+b/NFVERe2o9CPqPH2CH8JgnqLEl8yvI8HEXzDLB3I
         OaY9iPjhCnC81mAHFUhK2Dv5sCUh6i0hjd1sIpLtx/gdCpcVMcCaNTtB5jcrh6AtmKYm
         LnOuoUuGxHgMcbY+5n40uJMJm6WS2uHHyJUmXj98eyM14JTYgHdbELqIFKnaCrI4cm8R
         DApQ==
X-Gm-Message-State: ANhLgQ3JkH79JGbUbNs4m4woyu7C6VTJ5T6pyevyJUJq0BHSBRx40Rxj
        2s3+FUlr90l6GwXpn1xn4Gzw2lkrrv5o5OlybP1Lx5XdtHDZtg==
X-Google-Smtp-Source: ADFU+vt8utAgxIICuVTvEgeo/cYPXD3JL0b57liRt3lgFXb5j7BBuyyNQVZpYnkep4nwyNaUlR7cpvQbIkxJmDW732Y=
X-Received: by 2002:a2e:2419:: with SMTP id k25mr1158121ljk.165.1583913148198;
 Wed, 11 Mar 2020 00:52:28 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 11 Mar 2020 13:22:16 +0530
Message-ID: <CA+G9fYusdfg7PMfC9Xce-xLT7NiyKSbgojpK35GOm=Pf9jXXrA@mail.gmail.com>
Subject: WARNING: at refcount.c:190 refcount_sub_and_test_checked+0xac/0xc8 -
 refcount_t: underflow; use-after-free.
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, tkjos@google.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, ardb@kernel.org,
        Kees Cook <keescook@chromium.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While running selftest binderfs_test on linux mainline the following
warning on arm64, arm, x86_64 and i386.

[  329.383391] refcount_t: underflow; use-after-free.
[  329.391025] WARNING: CPU: 0 PID: 2604 at
/usr/src/kernel/lib/refcount.c:28 refcount_warn_saturate+0xd4/0x150
[  329.403319] Modules linked in: cls_bpf sch_fq algif_hash af_alg
rfkill tda998x drm_kms_helper drm crct10dif_ce fuse
[  329.413828] CPU: 0 PID: 2604 Comm: binderfs_test Not tainted 5.6.0-rc5 #1
[  329.420640] Hardware name: ARM Juno development board (r2) (DT)
[  329.426584] pstate: 40000005 (nZcv daif -PAN -UAO)
[  329.431402] pc : refcount_warn_saturate+0xd4/0x150
[  329.436216] lr : refcount_warn_saturate+0xd4/0x150
[  329.441026] sp : ffff800013d03a70
[  329.444356] x29: ffff800013d03a70 x28: ffff00092c3f8000
[  329.449694] x27: 0000000000000000 x26: ffff80001236f000
[  329.455033] x25: ffff800012656000 x24: 0000000000000001
[  329.460371] x23: ffff800012656f76 x22: ffff80001265b2c0
[  329.465709] x21: ffff000929035c00 x20: ffff00095cd8ce00
[  329.471048] x19: ffff80001261c848 x18: ffffffffffffffff
[  329.476386] x17: 0000000000000000 x16: 0000000000000000
[  329.481724] x15: ffff80001236fa88 x14: ffff800093d03767
[  329.487062] x13: ffff800013d03775 x12: ffff80001239e000
[  329.492400] x11: 0000000005f5e0ff x10: ffff800013d03700
[  329.497738] x9 : ffff8000126ddc68 x8 : 0000000000000028
[  329.503076] x7 : ffff800010190a5c x6 : ffff00097ef0b428
[  329.508414] x5 : ffff00097ef0b428 x4 : ffff00092c3f8000
[  329.513752] x3 : ffff800012370000 x2 : 0000000000000000
[  329.519090] x1 : 295161095161e100 x0 : 0000000000000000
[  329.524429] Call trace:
[  329.526894]  refcount_warn_saturate+0xd4/0x150
[  329.531362]  binderfs_evict_inode+0xcc/0xe8
[  329.535567]  evict+0xa8/0x188
[  329.538552]  iput+0x278/0x318
[  329.541537]  dentry_unlink_inode+0x154/0x170
[  329.545827]  __dentry_kill+0xc4/0x1d8
[  329.549509]  shrink_dentry_list+0xf4/0x210
[  329.553625]  shrink_dcache_parent+0x124/0x210
[  329.558002]  do_one_tree+0x20/0x50
[  329.561423]  shrink_dcache_for_umount+0x30/0x98
[  329.565975]  generic_shutdown_super+0x2c/0xf8
[  329.570354]  kill_anon_super+0x24/0x48
[  329.574122]  kill_litter_super+0x2c/0x38
[  329.578065]  binderfs_kill_super+0x24/0x48
[  329.582182]  deactivate_locked_super+0x74/0xa0
[  329.586647]  deactivate_super+0x8c/0x98
[  329.590502]  cleanup_mnt+0xd8/0x130
[  329.594008]  __cleanup_mnt+0x20/0x30
[  329.597605]  task_work_run+0x90/0x150
[  329.601287]  do_notify_resume+0x130/0x498
[  329.605317]  work_pending+0x8/0x14
[  329.608736] irq event stamp: 1612
[  329.612072] hardirqs last  enabled at (1611): [<ffff800010190bf4>]
console_unlock+0x514/0x5d8
[  329.620631] hardirqs last disabled at (1612): [<ffff8000100a904c>]
debug_exception_enter+0xac/0xe8
[  329.629622] softirqs last  enabled at (1608): [<ffff8000100818bc>]
__do_softirq+0x4c4/0x578
[  329.638005] softirqs last disabled at (1561): [<ffff80001010b6ac>]
irq_exit+0x144/0x150
[  329.646035] ---[ end trace bac6584738d9306f ]---

Metadata:
---------------
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  git describe: v5.6-rc5
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-mainline/2518/config

Full test log,
https://lkft.validation.linaro.org/scheduler/job/1273667#L6591
https://lkft.validation.linaro.org/scheduler/job/1273569#L6222
https://lkft.validation.linaro.org/scheduler/job/1273548#L6126
https://lkft.validation.linaro.org/scheduler/job/1273596#L4687

-- 
Linaro LKFT
https://lkft.linaro.org
