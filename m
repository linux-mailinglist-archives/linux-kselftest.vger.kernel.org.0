Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA6A2DD820
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 19:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgLQSQr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 13:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbgLQSQq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 13:16:46 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC08C0617A7
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:16:06 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v3so15572555plz.13
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n7ny5iw2j1Q3lsbSqEJ2a5WFoaKvdtqDb/7iy7kz+xE=;
        b=ZQZgYK0Y+YMnQ6ftN0OBpFSUepPpcNy86zWIyPfUOQcWdr3ndfXN6wrbZcpmVQCi/p
         tY9R0qvLH5ayp0PPjafD2cWNNqdQdqfAJkxKJ8Xj5l6hpLgWu+Sb7p8xYFRQdEa7RxgH
         ZM3PCDwc2Zv4i+2NWif6gUzjpypaHo15YsZDjdwYLg5wOtOR1WVbzXugyGPFqipxCKt8
         KVDeTTuO42ciIrzZu8zkMmInNpJlkAM1R2Lyma8Gnn0XzeM9VDGteWjXUCTg/u+FJSzY
         9pvupkwlGX1uNZEPaC3e49QCcJ3Lli00wMgfY77k7Mn+xYlFHhZ+hmaxMqlfj6yxl6Mi
         ex3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n7ny5iw2j1Q3lsbSqEJ2a5WFoaKvdtqDb/7iy7kz+xE=;
        b=ogiQ6w385gLLy3At7z3twRINSu/Xrr7QL+jEAk6CNcSMP0WPrIm3ebdEE7TbCNkbOV
         Lf8ypeVVyWc/Ge9oUO5ArgIsFYKCEDYwKWcXRa+cB3KIqCfVE7CfPEdfE7yY4teGqzYu
         ekkaQKMu0da7onZQNMV/4qV+yleTC0Gu94wUrSjd7wQbs7I23cZIkKR0opVKPuKzcH6s
         pn5JTCfbRAB9+Ln6sk9Gdn6NRfmKA2oIr2/8MZtYf2Gfg6GGwM2dLvVwDuK07dTR5dkU
         J1q8eFKmmvi6D84UoLV5FvoMMgNAkefvDob+Wt3jx5Km496WTLDQx+k0qFJ45V7+jDez
         mQVw==
X-Gm-Message-State: AOAM530vuzYlzeiS/+hfk+wcTmwQjSdXs2Ir3Jpc0VzOw1GD1OJuiar0
        5az6JQkZsaSb8SkwXco15ePh3HrMLZ0/XtjdlvrNIg==
X-Google-Smtp-Source: ABdhPJzBY0I9BHVc4SPprGLbshrbcvUE7SOZADMC1nPg24hjyeHW3NFHXqt8z3hqkeh3/tIZfdQszXiWV3oUYjyjmgU=
X-Received: by 2002:a17:90b:16cd:: with SMTP id iy13mr427087pjb.182.1608228965614;
 Thu, 17 Dec 2020 10:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20201014005320.2233162-1-kaleshsingh@google.com>
 <20201014005320.2233162-4-kaleshsingh@google.com> <20201217172847.GA89104@roeck-us.net>
In-Reply-To: <20201217172847.GA89104@roeck-us.net>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 17 Dec 2020 13:15:54 -0500
Message-ID: <CAC_TJvenGcLUnNE2sG4yBfcp_Aw3mg+cXWN2-nRyzj09bznMyQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] mm: Speedup mremap on 1GB or larger regions
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        kernel test robot <lkp@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Jia He <justin.he@arm.com>, John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Mina Almasry <almasrymina@google.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 17, 2020 at 12:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Oct 14, 2020 at 12:53:08AM +0000, Kalesh Singh wrote:
> > Android needs to move large memory regions for garbage collection.
> > The GC requires moving physical pages of multi-gigabyte heap
> > using mremap. During this move, the application threads have to
> > be paused for correctness. It is critical to keep this pause as
> > short as possible to avoid jitters during user interaction.
> >
> > Optimize mremap for >=3D 1GB-sized regions by moving at the PUD/PGD
> > level if the source and destination addresses are PUD-aligned.
> > For CONFIG_PGTABLE_LEVELS =3D=3D 3, moving at the PUD level in effect m=
oves
> > PGD entries, since the PUD entry is =E2=80=9Cfolded back=E2=80=9D onto =
the PGD entry.
> > Add HAVE_MOVE_PUD so that architectures where moving at the PUD level
> > isn't supported/tested can turn this off by not selecting the config.
> >
> > Fix build test error from v1 of this series reported by
> > kernel test robot in [1].
> >
> > [1] https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread=
/CKPGL4FH4NG7TGH2CVYX2UX76L25BTA3/
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
>
> I thought I reported it, but maybe I didn't. This patch causes all
> 'parisc' qemu emulations to fail. Typical log:
>
> Freeing unused kernel memory: 604K
> Write protected read-only-after-init data: 2k
> rodata_test: end of .rodata is not page size aligned
> Run /sbin/init as init process
> process '/bin/busybox' started with executable stack
> Failed to execute /sbin/init (error -12)
>
> Reverting this patch fixes the problem.
>
> Bisect log from linux-next below. The patch (and thus the problem)
> are now in mainline Linux.

Hi Guenter,

Thanks for reporting. We enabled this on x86 and arm64. Investigating
what the root cause is now.

Kalesh
>
> Guenter
>
> ---
> # bad: [7bba37a1591369e2e506d599b8f5d7d0516b2dbc] Add linux-next specific=
 files for 20201214
> # good: [0477e92881850d44910a7e94fc2c46f96faa131f] Linux 5.10-rc7
> git bisect start 'HEAD' 'v5.10-rc7'
> # good: [fe5c40ab90a1f82ba97294637eaf875cfdd7a05f] Merge remote-tracking =
branch 'nand/nand/next'
> git bisect good fe5c40ab90a1f82ba97294637eaf875cfdd7a05f
> # good: [674a0d6de8bd290671f7dff405205871a70300b3] Merge remote-tracking =
branch 'spi/for-next'
> git bisect good 674a0d6de8bd290671f7dff405205871a70300b3
> # good: [8623dae312f73a2ea3230b1c648d3004cfc224ce] Merge remote-tracking =
branch 'vfio/next'
> git bisect good 8623dae312f73a2ea3230b1c648d3004cfc224ce
> # good: [dd26635f54bcd8e5d4e875a209f82a0423ba9c08] Merge remote-tracking =
branch 'gpio/for-next'
> git bisect good dd26635f54bcd8e5d4e875a209f82a0423ba9c08
> # good: [86e9c9a734889fe437442e0a35eb4c61d319cb47] Merge remote-tracking =
branch 'memblock/for-next'
> git bisect good 86e9c9a734889fe437442e0a35eb4c61d319cb47
> # bad: [3452331fda80b1cb5e121e6718ca6c07264382b2] userfaultfd: add user-m=
ode only option to unprivileged_userfaultfd sysctl knob
> git bisect bad 3452331fda80b1cb5e121e6718ca6c07264382b2
> # bad: [19f468d54fcffc3f98b71e3e12ff23726767d953] mremap: don't allow MRE=
MAP_DONTUNMAP on special_mappings and aio
> git bisect bad 19f468d54fcffc3f98b71e3e12ff23726767d953
> # good: [d89f3ababcac54493a4cb0582c61eb5f426b44e3] mm: remove pagevec_loo=
kup_range_nr_tag()
> git bisect good d89f3ababcac54493a4cb0582c61eb5f426b44e3
> # good: [eba8373dcb40d30952f31d5fc0cff56b78f46273] mm/mlock: remove __mun=
lock_isolate_lru_page()
> git bisect good eba8373dcb40d30952f31d5fc0cff56b78f46273
> # good: [8831d3f3564beba0f3f1b5291c88b35725bc45c9] xen/unpopulated-alloc:=
 consolidate pgmap manipulation
> git bisect good 8831d3f3564beba0f3f1b5291c88b35725bc45c9
> # bad: [b8d53d70851821d8a2040ddca3aa6ee88fc8aaec] mm/page_vma_mapped.c: a=
dd colon to fix kernel-doc markups error for check_pte
> git bisect bad b8d53d70851821d8a2040ddca3aa6ee88fc8aaec
> # bad: [e77846c3da1862faa25c08e186a62b03e98c862f] x86: mremap speedup - E=
nable HAVE_MOVE_PUD
> git bisect bad e77846c3da1862faa25c08e186a62b03e98c862f
> # bad: [72ad8951bac1c559ea1b691a0b035fb339e4d71d] mm: speedup mremap on 1=
GB or larger regions
> git bisect bad 72ad8951bac1c559ea1b691a0b035fb339e4d71d
> # good: [fa94bfe31609787501a1ff8d7659ade5734ec4e5] kselftests: vm: add mr=
emap tests
> git bisect good fa94bfe31609787501a1ff8d7659ade5734ec4e5
> # first bad commit: [72ad8951bac1c559ea1b691a0b035fb339e4d71d] mm: speedu=
p mremap on 1GB or larger regions
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
