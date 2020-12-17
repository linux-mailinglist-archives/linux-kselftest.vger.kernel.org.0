Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221CD2DD63A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 18:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgLQR3b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 12:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729330AbgLQR3a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 12:29:30 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8C2C0617A7;
        Thu, 17 Dec 2020 09:28:50 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id q205so20304773oig.13;
        Thu, 17 Dec 2020 09:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZcIxHa95N4LovQ/B6AMqwtAFl8mnRc53Nbirnw11r50=;
        b=e1p8GzBoQCVqkpBiort9NEDOLtFOG3dNtDOxdQ2A0+4raTADN7kej3w9MvbPP3EZ+i
         bXoVhFaHvHz8pbA+DnMxFEm6ISRTnBYCrQTWHslM9wZMgGeSWRz4sKF1MspxFOKmd5N8
         zkhxMKzEYG0ieSX7nRK8aP7o1zi3c/mB3Q7JhdLD1PLUTSM/D1r5x9HMGsEE7QdcIAjd
         hRrd+8stIJqfd+Vn9dOACwgruNSQ7G9fAqxho+VDZqVTfmPuWF4bOwbZnKpg/kCc/Qu+
         CNbFW7TES4ofZB5b4bHs55YAeFcgyksMOXjTzG1GrU4R5ujqZ+g1+nWhWqaW2maAXq+o
         P4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZcIxHa95N4LovQ/B6AMqwtAFl8mnRc53Nbirnw11r50=;
        b=Q4iTeGC0JXrXPyxHo0OzE3ihFT0VXom8gZk079ON7EGuQElGfvOHKo/XNa+WGular2
         /rMnxvBKkaqf54ybMQlfbht7CU5c8JGFt1694dhC0jgB2ZORiTP3j3wYEzUh4SDx6wh3
         m7vREXHoKp4YBZcE9D3E5sTC1UKxBCuk99iIqRwc9NrR1lvLrEWIot4wq7DjZEuDR9/x
         TWF5bYLrAfWMn+NUCDoFG3WSLcHnPemaxkOU08wviuGvUjikZwR1rw9Hs4DRRCs4dTTN
         bK06v9+9nrBiY+Gc7bo/2CshhoBiwilMqbwTYoPv/hKs827qbZML0pyFexhjwyEabe5g
         Hxug==
X-Gm-Message-State: AOAM533sZFImtgp57NSBROf954xDbMUzZ4Jm5Moohf/mOkM09JU1CGZZ
        AgPCFYdKG2fuW0eYLei5WDY=
X-Google-Smtp-Source: ABdhPJyr+/QwL5NDeUQ8MUQSocj5W+U9Y5UMmShaQ1vbluEM/9IIf1Kq9FhfjsIkohBMfgN3/ffUcw==
X-Received: by 2002:aca:3145:: with SMTP id x66mr122419oix.29.1608226129792;
        Thu, 17 Dec 2020 09:28:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n13sm1323497otk.58.2020.12.17.09.28.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Dec 2020 09:28:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 17 Dec 2020 09:28:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@google.com, joelaf@google.com,
        lokeshgidra@google.com, kernel-team@android.com,
        kernel test robot <lkp@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Shuah Khan <shuah@kernel.org>,
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
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 3/5] mm: Speedup mremap on 1GB or larger regions
Message-ID: <20201217172847.GA89104@roeck-us.net>
References: <20201014005320.2233162-1-kaleshsingh@google.com>
 <20201014005320.2233162-4-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201014005320.2233162-4-kaleshsingh@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 14, 2020 at 12:53:08AM +0000, Kalesh Singh wrote:
> Android needs to move large memory regions for garbage collection.
> The GC requires moving physical pages of multi-gigabyte heap
> using mremap. During this move, the application threads have to
> be paused for correctness. It is critical to keep this pause as
> short as possible to avoid jitters during user interaction.
> 
> Optimize mremap for >= 1GB-sized regions by moving at the PUD/PGD
> level if the source and destination addresses are PUD-aligned.
> For CONFIG_PGTABLE_LEVELS == 3, moving at the PUD level in effect moves
> PGD entries, since the PUD entry is “folded back” onto the PGD entry.
> Add HAVE_MOVE_PUD so that architectures where moving at the PUD level
> isn't supported/tested can turn this off by not selecting the config.
> 
> Fix build test error from v1 of this series reported by
> kernel test robot in [1].
> 
> [1] https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/CKPGL4FH4NG7TGH2CVYX2UX76L25BTA3/
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

I thought I reported it, but maybe I didn't. This patch causes all
'parisc' qemu emulations to fail. Typical log:

Freeing unused kernel memory: 604K
Write protected read-only-after-init data: 2k
rodata_test: end of .rodata is not page size aligned
Run /sbin/init as init process
process '/bin/busybox' started with executable stack
Failed to execute /sbin/init (error -12)

Reverting this patch fixes the problem.

Bisect log from linux-next below. The patch (and thus the problem)
are now in mainline Linux.

Guenter

---
# bad: [7bba37a1591369e2e506d599b8f5d7d0516b2dbc] Add linux-next specific files for 20201214
# good: [0477e92881850d44910a7e94fc2c46f96faa131f] Linux 5.10-rc7
git bisect start 'HEAD' 'v5.10-rc7'
# good: [fe5c40ab90a1f82ba97294637eaf875cfdd7a05f] Merge remote-tracking branch 'nand/nand/next'
git bisect good fe5c40ab90a1f82ba97294637eaf875cfdd7a05f
# good: [674a0d6de8bd290671f7dff405205871a70300b3] Merge remote-tracking branch 'spi/for-next'
git bisect good 674a0d6de8bd290671f7dff405205871a70300b3
# good: [8623dae312f73a2ea3230b1c648d3004cfc224ce] Merge remote-tracking branch 'vfio/next'
git bisect good 8623dae312f73a2ea3230b1c648d3004cfc224ce
# good: [dd26635f54bcd8e5d4e875a209f82a0423ba9c08] Merge remote-tracking branch 'gpio/for-next'
git bisect good dd26635f54bcd8e5d4e875a209f82a0423ba9c08
# good: [86e9c9a734889fe437442e0a35eb4c61d319cb47] Merge remote-tracking branch 'memblock/for-next'
git bisect good 86e9c9a734889fe437442e0a35eb4c61d319cb47
# bad: [3452331fda80b1cb5e121e6718ca6c07264382b2] userfaultfd: add user-mode only option to unprivileged_userfaultfd sysctl knob
git bisect bad 3452331fda80b1cb5e121e6718ca6c07264382b2
# bad: [19f468d54fcffc3f98b71e3e12ff23726767d953] mremap: don't allow MREMAP_DONTUNMAP on special_mappings and aio
git bisect bad 19f468d54fcffc3f98b71e3e12ff23726767d953
# good: [d89f3ababcac54493a4cb0582c61eb5f426b44e3] mm: remove pagevec_lookup_range_nr_tag()
git bisect good d89f3ababcac54493a4cb0582c61eb5f426b44e3
# good: [eba8373dcb40d30952f31d5fc0cff56b78f46273] mm/mlock: remove __munlock_isolate_lru_page()
git bisect good eba8373dcb40d30952f31d5fc0cff56b78f46273
# good: [8831d3f3564beba0f3f1b5291c88b35725bc45c9] xen/unpopulated-alloc: consolidate pgmap manipulation
git bisect good 8831d3f3564beba0f3f1b5291c88b35725bc45c9
# bad: [b8d53d70851821d8a2040ddca3aa6ee88fc8aaec] mm/page_vma_mapped.c: add colon to fix kernel-doc markups error for check_pte
git bisect bad b8d53d70851821d8a2040ddca3aa6ee88fc8aaec
# bad: [e77846c3da1862faa25c08e186a62b03e98c862f] x86: mremap speedup - Enable HAVE_MOVE_PUD
git bisect bad e77846c3da1862faa25c08e186a62b03e98c862f
# bad: [72ad8951bac1c559ea1b691a0b035fb339e4d71d] mm: speedup mremap on 1GB or larger regions
git bisect bad 72ad8951bac1c559ea1b691a0b035fb339e4d71d
# good: [fa94bfe31609787501a1ff8d7659ade5734ec4e5] kselftests: vm: add mremap tests
git bisect good fa94bfe31609787501a1ff8d7659ade5734ec4e5
# first bad commit: [72ad8951bac1c559ea1b691a0b035fb339e4d71d] mm: speedup mremap on 1GB or larger regions
