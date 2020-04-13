Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A661A6C5B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Apr 2020 21:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbgDMTLM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Apr 2020 15:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387833AbgDMTLK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Apr 2020 15:11:10 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADE9C0A3BE2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Apr 2020 12:11:09 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q19so9858956ljp.9
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Apr 2020 12:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6E2riI0IkGg5so6kNR5+vB2edM7YCdJ1N8SPMSw1Rls=;
        b=XzT+Tn3YvT1AQjdm78IDRMzVvhk4NDthYi+/Lqg1BSrpe1J2codCQUWF2PpRIN4NBZ
         +sdUGpQ3OFbDDLs0pL/+sGVWwq/YdTamVw4NSJLDU1HAucbLoByS//8WCTcFh8V8Xgm1
         58wOeU2Udneup6TbUeesldE5RO2QtsYSomLNfnzAUXKOT4g8C2AMw3mDf/6fE9cKVcIf
         4TDRylZKaeC/8rUp24x90Z4/g9oxnL9SjZ0F9heF5c+ESQBXwfZNCnkKFXXRsOW2eWUt
         Yg7l0B39oFSp1zFbv6ccE1k67Actv6fNEPeC/SMlG5SFU4yiu9/czW4adhZCx0a1A6ot
         jkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6E2riI0IkGg5so6kNR5+vB2edM7YCdJ1N8SPMSw1Rls=;
        b=nK1qFZZ2SmcSUvIy9F7byi2UCdGcD+M6xLnFojeu1eKhz2I9jNtoerpNIiZObHWfoK
         kndtqjTwDzLUq9Nys+l5T1e5a+iie5xfDoQWN2z3bS1vKXoGjBjrj4OfiyWtTPGxZa1/
         SjgXnlvCoy9OYoptPagaF7hP7xVB4KunoGihlGRLiM5dLsPT4/QpxpgDa7bWys6k6NNJ
         E8zhH5VQ5vbrDu8NZ8rJe/ORfuAdqznN7gBp1ALef3s4eG3G3DGYcFbUVJRyLwlnxG0p
         U0KkzqRMfsbuOYwL42qDktRiFT0Py6hDgBNSanGu6uZRFEJh7zuyoJ8YJ4+0XRmQjVrm
         L/1A==
X-Gm-Message-State: AGi0PuaYRRMQL9ceAmeDtUZDyIoDuYTXWidV5q7ZF3zkgmXOrWMdTy62
        wlz42XUmbD4y3aSq1o3/2oefS4pwWdlRWaNxdSz75Q==
X-Google-Smtp-Source: APiQypLRXBI8I/e2KzJ1ZDb82h9Ivoa4sRuew1gA2hWgrB5j5s+vEJa59w61i92eBkb5VIZ/gRRMiNJoFbM6D8YP+xQ=
X-Received: by 2002:a2e:8999:: with SMTP id c25mr2260602lji.73.1586805068126;
 Mon, 13 Apr 2020 12:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvRZ9eCE29FjXkv1dQfrdGO3uWp4Tvkip5Z_jsgjVJeAQ@mail.gmail.com>
 <CAHp75VfhKoLtWkLHUyzg6m=rx833qiCVimWJVKU13qrX+aJz-Q@mail.gmail.com>
 <CAFd5g45GbSX1BkuaH=8639ESHi-MCGkpFhEZZpycm9=jQb93rg@mail.gmail.com>
 <CAFd5g47aaE+tGeHPrQmhfi6_nrvi1K4DvtRodh=zN21-uiQ1DQ@mail.gmail.com>
 <20200305223350.GA2852@mara.localdomain> <20200306120525.GC68079@kuha.fi.intel.com>
 <CAFd5g45c9L4BBRNtxtQf_NFr2bR6Wgt9uOHW86gzb6Ozeb0SBA@mail.gmail.com>
 <CAFd5g45cdygYfxGoCkk710tLXFADeLNb+6w-=vhkDMLP9OM7bw@mail.gmail.com>
 <20200310111837.GA1368052@kuha.fi.intel.com> <CAFd5g452sDMZToU+FDa-Odbkd_t1708gcRMAZQG+U4LnV=Xqgw@mail.gmail.com>
 <CA+G9fYuwv+TEhgi46pjs2-GCe0mmMHyki9nAokvGCEA2syK5Dg@mail.gmail.com> <CAFd5g46Bwd8HS9-xjHLh_rB59Nfw8iAnM6aFe0QPcveewDUT6g@mail.gmail.com>
In-Reply-To: <CAFd5g46Bwd8HS9-xjHLh_rB59Nfw8iAnM6aFe0QPcveewDUT6g@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 14 Apr 2020 00:40:54 +0530
Message-ID: <CA+G9fYtjE+GTjiMHmyVy7my_GBxjkhWHkgD9Bk-PbVECrqJ3jg@mail.gmail.com>
Subject: Re: BUG: kernel NULL pointer dereference, address: 00 - ida_free+0x76/0x140
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> > > I did already let Greg know when he emailed us on backporting the
> > > patch to stable, and he acked saying he removed them. So as long as
> > > these are not in the queue for 5.6 (it is not in Linus' tree yet), we
> > > should be good.
> >
> > The reported bug is still noticed on Linux mainline master branch
> > The Kernel BUG noticed on x86_64 and i386 running selftest on Linux
> > mainline kernel 5.6.0.
>
> Oh sorry, I thought that this patch was dropped from the maintainer's
> for-next branch.
>
> Heikki, what do you think about my suggestion of having kobject
> deallocate its children?
>
> In the meantime, are people cool with the patch that Heikki proposed
> as a temporary mitigation? I think my solution might be a bit more
> involved. If I don't hear anything back, I will send out Heikki's
> suggestion as a patch.

This reported problem still noticed on 5.7.0-rc1

Test crash log:
-------------------
[  281.822463] BUG: kernel NULL pointer dereference, address: 00000000
[  281.829543] #PF: supervisor read access in kernel mode
[  281.834680] #PF: error_code(0x0000) - not-present page
[  281.839820] *pde = 00000000
[  281.842706] Oops: 0000 [#1] SMP
[  281.845852] CPU: 1 PID: 3998 Comm: modprobe Tainted: G        W
    5.7.0-rc1 #1
[  281.853590] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  281.861063] EIP: ida_free+0x61/0x130
[  281.864641] Code: 00 c7 45 e8 00 00 00 00 c7 45 ec 00 00 00 00 0f
88 c4 00 00 00 89 d3 e8 0d 8e 87 00 89 c7 8d 45 d8 e8 93 1e 01 00 a8
01 75 3f <0f> a3 30 72 72 8b 45 d8 89 fa e8 e0 8f 87 00 53 68 08 ab fd
de e8
[  281.883395] EAX: 00000000 EBX: 00000000 ECX: e422d8c0 EDX: 00000000
[  281.889672] ESI: 00000000 EDI: 00000246 EBP: e5d63cdc ESP: e5d63cb0
[  281.895935] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010046
[  281.902720] CR0: 80050033 CR2: 00000000 CR3: 1db85000 CR4: 003406d0
[  281.908978] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  281.915243] DR6: fffe0ff0 DR7: 00000400
[  281.919073] Call Trace:
[  281.921521]  software_node_release+0x21/0x80
[  281.925792]  kobject_put+0xa8/0x1c0
[  281.929284]  kobject_del+0x40/0x60
[  281.932680]  kobject_put+0x92/0x1c0
[  281.936165]  fwnode_remove_software_node+0x30/0x50
[  281.940957]  software_node_unregister_nodes+0x2b/0x50
[  281.946002]  test_printf_init+0xe00/0x1d29 [test_printf]
[  281.951320]  ? fs_reclaim_acquire.part.121+0x5/0x30
[  281.956202]  ? test_hashed+0x54/0x54 [test_printf]
[  281.960985]  ? test_hashed+0x54/0x54 [test_printf]
[  281.965770]  do_one_initcall+0x54/0x2e0
[  281.969639]  ? rcu_read_lock_sched_held+0x47/0x70
[  281.974366]  ? kmem_cache_alloc_trace+0x285/0x2b0
[  281.979063]  ? do_init_module+0x21/0x1f7
[  281.982982]  ? do_init_module+0x21/0x1f7
[  281.986899]  do_init_module+0x50/0x1f7
[  281.990659]  load_module+0x1e32/0x2540
[  281.994410]  __ia32_sys_finit_module+0x8f/0xe0
[  281.998854]  do_fast_syscall_32+0x7f/0x330
[  282.002949]  entry_SYSENTER_32+0xaa/0x102
[  282.006952] EIP: 0xb7f07ce1
[  282.009742] Code: 5e 5d c3 8d b6 00 00 00 00 b8 40 42 0f 00 eb c1
8b 04 24 c3 8b 1c 24 c3 8b 34 24 c3 8b 3c 24 c3 90 51 52 55 89 e5 0f
34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
8d 76
[  282.028480] EAX: ffffffda EBX: 00000005 ECX: 0806233a EDX: 00000000
[  282.034739] ESI: 099fe840 EDI: 099fe570 EBP: 099fe700 ESP: bf97146c
[  282.040994] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[  282.047776] Modules linked in: test_printf(+) cls_bpf sch_fq 8021q
sch_ingress veth algif_hash x86_pkg_temp_thermal fuse [last unloaded:
gpio_mockup]
[  282.061155] CR2: 0000000000000000
[  282.064472] ---[ end trace 09f43fd7981266c9 ]---
[  282.069084] EIP: ida_free+0x61/0x130

https://lkft.validation.linaro.org/scheduler/job/1362555#L7962

- Naresh
