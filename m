Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06239162ECE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2020 19:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgBRSlK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Feb 2020 13:41:10 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43931 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgBRSlK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Feb 2020 13:41:10 -0500
Received: by mail-qk1-f196.google.com with SMTP id p7so20511077qkh.10
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2020 10:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4oAqcu9BwDpPKcExc1FRw4p4ak/gNbofDesTw+TDNrw=;
        b=Vk5cfYQ5q/TgaB4CkQkA26YYOoWTr/ajOpC8SHfg/BoGoOEFEH9UZyubYufuzZmJA3
         rhDqTSRdXsoOJ14IjRNWWDtVWaHpuvITVc+xTBKD2A8Aa+70C6xjel6e70RAJUGJBota
         eG4qzjRI2rHp6qlwmGucc6fzieBWudjIpwc6gkBjQrMQCGWVzas44Ip4HWDrdF1vhZ8Q
         4E/RQxQe9Io0dX38RHdNrcSg+ZqRYos8elgZSgFB/ksSmymtz/x62SexX9COx6gItr9K
         P6DWw6Ka/+UNC9LyO1G6YKsZgvxxb9MwSFIky0IY8yKXn5wfhR6hHKOq2SvXxy4RC76C
         70PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4oAqcu9BwDpPKcExc1FRw4p4ak/gNbofDesTw+TDNrw=;
        b=Hnszldh9hwn/TcVGbg3eK5SHRXyYKtIGZnBudbOxgNrfQY46mPHBj+AR4UsXKUekeN
         xFLqXMYcG9ABY6wEqxlZ2yoOvy3LV4gQdE9luR5qyXLH0SigCXZibHqQFs013OJ3H/Tg
         ZINrXZClf7dUS8watiZfzZVA+rnnM3iMCFiW1eaMESnWIuRYb92N9/HPLseNBGHXCIUl
         IJ3M+f/ZbxvWtqX8XtzdtlUJ1dOPQz/zWn2LaT4KVwOWKQ3LoHXmrf9bIg5LqfSW1nM5
         VqOHiE9gblsytQKG0gRE5xPE7C0SZKWSuK+i95U01+JvqcU5U9K37YuFVF1vtzqaxVF/
         rhMw==
X-Gm-Message-State: APjAAAVba4pBQn5tT5F+B2S3acRMxB9tWkX/ESMo1kfuYcs8nH0JzYMp
        hFdF6E7iaz6QgfHG+KSQzN2/Kg==
X-Google-Smtp-Source: APXvYqzxWiZt+3ngXyZGnptYtuoY+TYQ6QazdJYugNuylb1Tgw/B7EDz1YFa0vjVnsTagJIm1QuYUA==
X-Received: by 2002:a37:6308:: with SMTP id x8mr20048203qkb.381.1582051269217;
        Tue, 18 Feb 2020 10:41:09 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m23sm2219557qtp.6.2020.02.18.10.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 10:41:08 -0800 (PST)
Message-ID: <1582051267.7365.96.camel@lca.pw>
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation
 counter
From:   Qian Cai <cai@lca.pw>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Date:   Tue, 18 Feb 2020 13:41:07 -0500
In-Reply-To: <CAHS8izO5=vKs-v9v=Di3hQXBD41+_YpYarXn1yZu9YE6SR-i6Q@mail.gmail.com>
References: <20200211213128.73302-1-almasrymina@google.com>
         <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
         <1582035660.7365.90.camel@lca.pw>
         <CAHS8izO5=vKs-v9v=Di3hQXBD41+_YpYarXn1yZu9YE6SR-i6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2020-02-18 at 10:35 -0800, Mina Almasry wrote:
> On Tue, Feb 18, 2020 at 6:21 AM Qian Cai <cai@lca.pw> wrote:
> > 
> > On Tue, 2020-02-11 at 15:19 -0800, Andrew Morton wrote:
> > > On Tue, 11 Feb 2020 13:31:20 -0800 Mina Almasry <almasrymina@google.com> wrote:
> > > 
> > > > These counters will track hugetlb reservations rather than hugetlb
> > > > memory faulted in. This patch only adds the counter, following patches
> > > > add the charging and uncharging of the counter.
> > > 
> > > We're still pretty thin on review here, but as it's v12 and Mike
> > > appears to be signed up to look at this work, I'll add them to -next to
> > > help move things forward.
> > > 
> > 
> > Reverted the whole series on the top of next-20200217 fixed a crash below (I
> > don't see anything in next-20200218 would make any differences).
> > 
> > [ 7933.691114][T35046] LTP: starting hugemmap06
> > [ 7933.806377][T14355] ------------[ cut here ]------------
> > [ 7933.806541][T14355] kernel BUG at mm/hugetlb.c:490!
> > VM_BUG_ON(t - f <= 1);
> > [ 7933.806562][T14355] Oops: Exception in kernel mode, sig: 5 [#1]
> > [ 7933.806573][T14355] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256
> > DEBUG_PAGEALLOC NUMA PowerNV
> > [ 7933.806594][T14355] Modules linked in: kvm_hv kvm brd ext4 crc16 mbcache jbd2
> > loop ip_tables x_tables xfs sd_mod bnx2x ahci mdio libahci tg3 libata libphy
> > firmware_class dm_mirror dm_region_hash dm_log dm_mod [last unloaded:
> > binfmt_misc]
> > [ 7933.806651][T14355] CPU: 54 PID: 14355 Comm: hugemmap06 Tainted:
> > G           O      5.6.0-rc2-next-20200217 #1
> > [ 7933.806674][T14355] NIP:  c00000000040d22c LR: c00000000040d210 CTR:
> > 0000000000000000
> > [ 7933.806696][T14355] REGS: c0000014b71ef660 TRAP: 0700   Tainted:
> > G           O       (5.6.0-rc2-next-20200217)
> > [ 7933.806727][T14355] MSR:  900000000282b033
> > <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 22022228  XER: 00000000
> > [ 7933.806772][T14355] CFAR: c00000000040cbec IRQMASK: 0
> > [ 7933.806772][T14355] GPR00: c00000000040d210 c0000014b71ef8f0 c000000001657000
> > 0000000000000001
> > [ 7933.806772][T14355] GPR04: 0000000000000012 0000000000000013 0000000000000000
> > 0000000000000000
> > [ 7933.806772][T14355] GPR08: 0000000000000002 0000000000000002 0000000000000001
> > 0000000000000036
> > [ 7933.806772][T14355] GPR12: 0000000022022222 c000001ffffd3d00 00007fffad670000
> > 00007fffa4bc0000
> > [ 7933.806772][T14355] GPR16: 0000000000000000 c000000001567178 c0000014b71efa50
> > 0000000000000000
> > [ 7933.806772][T14355] GPR20: 0000000000000000 0000000000000013 0000000000000012
> > 0000000000000001
> > [ 7933.806772][T14355] GPR24: c0000019f74cd270 5deadbeef0000100 5deadbeef0000122
> > c0000019f74cd2c0
> > [ 7933.806772][T14355] GPR28: 0000000000000001 c0000019f74cd268 c0000014b71ef918
> > 0000000000000001
> > [ 7933.806961][T14355] NIP [c00000000040d22c] region_add+0x11c/0x3a0
> > [ 7933.806980][T14355] LR [c00000000040d210] region_add+0x100/0x3a0
> > [ 7933.807008][T14355] Call Trace:
> > [ 7933.807024][T14355] [c0000014b71ef8f0] [c00000000040d210]
> > region_add+0x100/0x3a0 (unreliable)
> > [ 7933.807056][T14355] [c0000014b71ef9b0] [c00000000040e0c8]
> > __vma_reservation_common+0x148/0x210
> > __vma_reservation_common at mm/hugetlb.c:2150
> > [ 7933.807087][T14355] [c0000014b71efa20] [c0000000004132a0]
> > alloc_huge_page+0x350/0x830
> > alloc_huge_page at mm/hugetlb.c:2359
> > [ 7933.807100][T14355] [c0000014b71efad0] [c0000000004168f8]
> > hugetlb_no_page+0x158/0xcb0
> > [ 7933.807113][T14355] [c0000014b71efc20] [c000000000417bc8]
> > hugetlb_fault+0x678/0xb30
> > [ 7933.807136][T14355] [c0000014b71efcd0] [c0000000003b1de4]
> > handle_mm_fault+0x444/0x450
> > [ 7933.807158][T14355] [c0000014b71efd20] [c000000000070b1c]
> > __do_page_fault+0x2bc/0xfd0
> > [ 7933.807181][T14355] [c0000014b71efe20] [c00000000000aa88]
> > handle_page_fault+0x10/0x30
> > [ 7933.807201][T14355] Instruction dump:
> > [ 7933.807209][T14355] 38c00000 7ea5ab78 7ec4b378 7fa3eb78 4bfff80d e9210020
> > e91d0050 e95d0068
> > [ 7933.807232][T14355] 7d3c4850 7d294214 7faa4800 409c0238 <0b170000> 7f03c378
> > 4858c005 60000000
> > [ 7933.807267][T14355] ---[ end trace 7560275de5f409f8 ]---
> > [ 7933.905258][T14355]
> > [ 7934.905339][T14355] Kernel panic - not syncing: Fatal exception
> 
> Hi Qian,
> 
> Yes this VM_BUG_ON was added by a patch in the series ("hugetlb:
> disable region_add file_region coalescing") so it's definitely related
> to the series. I'm taking a look at why this VM_BUG_ON fires. Can you
> confirm you reproduce this by running hugemmap06 from the ltp on a
> powerpc machine? Can I maybe have your config?

Yes, reproduced on both powerpc and x86. Configs are in,

https://github.com/cailca/linux-mm
