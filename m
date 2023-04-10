Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD566DC4F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Apr 2023 11:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDJJQ5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Apr 2023 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjDJJQz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Apr 2023 05:16:55 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA9B1A4
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 02:16:54 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id ba16so2931152uab.4
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681118213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V0N2613pKQCAL9iN6z4rVK3cSRr5vURUZo3s2wt46N0=;
        b=tA3Ep3a9rR3yyVebRfsMovHLrPAK9u2+vpAAk+hkocRWd2QSGN8327+jchQXINtRKQ
         PQf9doLpbbJYCeEz9DkSLbrgF30UcULPcRmUFd2rh1C20Gg8/y8bI6U0+7dA4+3Io3eo
         ZwI/UkqTzXwSc8oFVD0OFzlYfZsR5sxiEqEH+wsA8GByx/56ugja2fvdFpDcT30WPY99
         im0JWODQSSJgMc5PKKdjandlE4fFQHCZHEaX0BIhuYryqXlw1w6p6u2PvMQoCAuUFsbE
         yI6kOhMf817Eyw8lfNUQyVrdxDqDhsxe0s8IceUqJ7EqFAiq2EuuDVWo969434/Yt6bN
         AJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681118213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0N2613pKQCAL9iN6z4rVK3cSRr5vURUZo3s2wt46N0=;
        b=uLCwafF00u27rN++epElJr9OVG/OX1+PMBlf6GRaUyfVgczTfODIXnktZwAxRL0NRb
         LKAiDiYKPmL7orttoMicL3/w7UC5H5TU4zUX/VHUVg2K7uKO0j+H7/dBhN2mwZP96Rcl
         hDc26SIMmV/zLGRWBv+bYmrgR0lqWg9UKjsVC2SIzL3fSpn/OIA+uP/+reTQm/Ja3vgG
         slSZYLQFlAvpaFidniyJEJRL5+bPFeaAzdxKHccL5UJchmtSS8nwy2OKGP7oGzGdaHpg
         IMxDgr7F123bpgxzVv/9SbEOc3K5w24hTkTJm3P5HxYyzZJwlyQfamhu3f4R0iSqLMHy
         H4Rg==
X-Gm-Message-State: AAQBX9dKaSMVs2Ogo01Rd0n8fR9Pk55nt6vmfUfV8ksKWQ9C/hW1nxnc
        IFdkvA6GDoX+sHbEBI08KTvpG2Xap+3xb5/eJGn4Tw==
X-Google-Smtp-Source: AKy350bKBcnWH4Hp69Mt7Cjb50/39FiDV0xEAscrOKWyxOWbHlaJoMMkrFK8FZZLH2HsFkOnC0rWcfFdqMA2zez+xjA=
X-Received: by 2002:a1f:270e:0:b0:43b:e059:987f with SMTP id
 n14-20020a1f270e000000b0043be059987fmr5467809vkn.0.1681118213114; Mon, 10 Apr
 2023 02:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv94gx8+-JMzbmQaue3q3y6QdBmsGUCdD-26X5XavL3Ag@mail.gmail.com>
 <ZAocZRZh4FQRH3lc@smile.fi.intel.com>
In-Reply-To: <ZAocZRZh4FQRH3lc@smile.fi.intel.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 10 Apr 2023 14:46:42 +0530
Message-ID: <CA+G9fYsOttth+k3Ki8LK_ZiayvXa0bAg-DmQAaFHZeEyR=6Lrw@mail.gmail.com>
Subject: Re: selftests: gpio: crash on arm64
To:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pengfei Xu <pengfei.xu@intel.com>, yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 9 Mar 2023 at 23:20, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 09, 2023 at 09:33:29PM +0530, Naresh Kamboju wrote:
> > Following kernel warnings and crash notices on arm64 Rpi4 device while
> > running selftests: gpio on Linux mainline 6.3.0-rc1 kernel and Linux next.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ...
>
> > [   61.177432]  *** DEADLOCK ***
> > [   61.177432]
> > [   61.177434] 3 locks held by modprobe/510:
> > [   61.177436] #0: ffff000040000698 (&n->list_lock){-.-.}-{2:2}, at:
> > get_partial_node.part.0 (mm/slub.c:2271)
> > [   61.177448] #1: ffff80000b227f18 (console_lock){+.+.}-{0:0}, at:
> > vprintk_emit (kernel/printk/printk.c:1936 kernel/printk/printk.c:2315)
> > [   61.177460] #2: ffff80000b228388 (console_srcu){....}-{0:0}, at:
> > console_flush_all (include/linux/srcu.h:200 kernel/printk/printk.c:290
> > kernel/printk/printk.c:2934)
>
> How is it related to the GPIO?
> Can you bisect if it's a regression somewhere?

The following crash on Linux mainline and next was noticed while running
selftest gpio on arm64. And this is a kselftest-merge config build.
Which means it has a large set of test configs enabled.

Anders performed bisection on this problem.
The bisection have been poing to this commit log,
  first bad commit: [24c94060fc9b4e0f19e6e018869db46db21d6bc7]
    gpiolib: ensure that fwnode is properly set


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Anders Roxell <anders.roxell@linaro.org>

Crash log:
# 2.  Module load error tests
# 2.1 gpio overflow
[   88.796755] =============================================================================
[   88.806704] BUG kmalloc-512 (Not tainted): Poison overwritten
[   88.812482] -----------------------------------------------------------------------------
[   88.812482]
[   88.822170] 0xe38-0xe47 @offset=28216. First byte 0x6a instead of 0x6b
[   88.830994] Allocated in swnode_register+0x40/0x218 age=828 cpu=2 pid=565
[   88.837830]  __kmem_cache_alloc_node+0x11c/0x320
[   88.842480]  kmalloc_trace+0x54/0xa8
[   88.846083]  swnode_register+0x40/0x218
[   88.849947]  fwnode_create_software_node+0xcc/0x1a0
[   88.854856]  0xffff8000018c71cc
[   88.858029]  0xffff8000018c73b0
[   88.861197]  do_one_initcall+0x80/0x320
[   88.865062]  do_init_module+0x50/0x210
[   88.868843]  load_module+0x201c/0x2260
[   88.872622]  __do_sys_finit_module+0xb0/0x138
[   88.877010]  __arm64_sys_finit_module+0x2c/0x48
[   88.881572]  invoke_syscall+0x8c/0x120
[   88.885352]  el0_svc_common.constprop.0+0x104/0x130
[   88.890263]  do_el0_svc+0x44/0xb8
[   88.893606]  el0_svc+0x48/0xb8
[   88.896686]  el0t_64_sync_handler+0xbc/0x138
[   88.900984] Freed in software_node_release+0xdc/0x108 age=34 cpu=1 pid=683
[   88.907899]  __kmem_cache_free+0x2a4/0x2e0
[   88.912024]  kfree+0xc0/0x1a0
[   88.915015]  software_node_release+0xdc/0x108
[   88.919402]  kobject_put+0xb0/0x220
[   88.922919]  software_node_notify_remove+0x98/0xe8
[   88.927741]  device_del+0x184/0x380
[   88.931259]  platform_device_del.part.0+0x24/0xa8
[   88.935995]  platform_device_unregister+0x30/0x50
[   88.940730]  0xffff8000018a1dd4
[   88.943898]  __arm64_sys_delete_module+0x184/0x328
[   88.948722]  invoke_syscall+0x8c/0x120
[   88.952502]  el0_svc_common.constprop.0+0x104/0x130
[   88.957413]  do_el0_svc+0x44/0xb8
[   88.960757]  el0_svc+0x48/0xb8
[   88.963834]  el0t_64_sync_handler+0xbc/0x138
[   88.968132]  el0t_64_sync+0x190/0x198
[   88.971820] Slab 0xfffffc00209d0800 objects=21 used=7
fp=0xffff000827423200
flags=0xbfffc0000010200(slab|head|node=0|zone=2|lastcpupid=0xffff)
[   88.984653] Object 0xe00 @offset=28160 fp=0xffff000827423200
[   88.984653]
[   88.992953] Redzone   <Trim>
[   89.002470] Redzone   <Trim>
[   89.011986] Redzone   <Trim>
...
[   89.278435] Redzone   <Trim>
[   89.287951] Redzone   <Trim>
[   89.297468] Object    <Trim>
[   89.306984] Object    <Trim>
[   89.316500] Object    <Trim>
...
[   89.592465] Object
[   89.601981] Redzone
[   89.610801] Padding
[   89.620317] Padding


Details test and crash log:
  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc6/testrun/16155019/suite/log-parser-test/test/check-kernel-exception/log
  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc6/testrun/16155019/suite/log-parser-test/tests/
  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc6/testrun/16155157/suite/log-parser-test/tests/

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
  git_describe: v6.3-rc6
  kernel_version: 6.3.0-rc6
  kernel-config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2OCXLSEmqxrg13KKFGzypngoE3K/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/832195018
  artifact-location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2OCXLSEmqxrg13KKFGzypngoE3K/
  toolchain: gcc-11
  email-notification: ''
  build_name: gcc-11-lkftconfig-kselftest



--
Linaro LKFT
https://lkft.linaro.org

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
