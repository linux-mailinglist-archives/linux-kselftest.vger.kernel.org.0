Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA160280D90
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 08:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgJBGkF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 02:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgJBGkF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 02:40:05 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD3EC0613E3
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Oct 2020 23:40:05 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v8so449759iom.6
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Oct 2020 23:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dkXqqJWGGMD3nsu1nDQF0uD51+pRQERPlmfOf0TOTVo=;
        b=iEkjLRgNkKYJWF7CEttuAu/tYQ0VOufE98KsN+GWMxJUGzWnlC8BFuPq5RorTIVtcD
         GUz8TA+zytLWsfeghAYOXm16ewnEmWroldRiJLLUqkIpye0v5gLc92/DzuUZ3RjoC0o2
         Mj+49Kak5eFgPvzj1HZE10GW3MIpMKwWStTYAIBc5xjjTuGryaebrLfyq7fyZMgbCj47
         vGPoiwmHKo51+C3S2BZQ8GMGQnX0K9vkbvsbvttctT9yFjFAGrDlrgwhFItqqdUsZcp5
         OTWfLuNUXiQ3QREEwcpptRzqqqoO27EicyYNmoZAuoCjFFGOVcH49Su7CdhioMsK8LU0
         824A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkXqqJWGGMD3nsu1nDQF0uD51+pRQERPlmfOf0TOTVo=;
        b=M5QxjbVOmDG4nvft7XLSlF4sAYn3MiHgMHsflxJSAyyuV6dsAHMyNw0oHpWVRH7u3M
         qOc7euGd1SpoC6jqFuvrxAmOmDtzz0JyOfMBfA0O2iWc/hQKpqvfFYxs2NGO6QNQJ8cj
         vMKQOTz/Gzc3kcpbv6PXyUzR4HJcf8HCnheekLjPfmOcHdYG5UC/My4zZNxZmzZCzdke
         wuEZd2g9eEdQ7I72P6wWjf5k/UTBbV5ZIsJTrE5yYR/wcA+0ZRhhUceiCQS75A4cIAHG
         YgWuU7/AlJyT6S/1P4K7/D0RHX9fabzA+Vcw89qjD5cfFtmDYv0R4tHMtPW2ieeTfl6G
         xMOQ==
X-Gm-Message-State: AOAM531PNV2itFFBztFMNc26GTIQOImN+tsybhnpxz3/U96kdmwkr2bI
        kQiS8CIbpU2DLHJ54VIcdKk25Gifq7eUjLhn84WkbQ==
X-Google-Smtp-Source: ABdhPJyqoA6lgzrhsEk2OHis7Bv3fG52DoLRoDsNnGgjUwRYYdWQzQoYWkvJKagd5Spw6QnrhKVAa3MxJgaS9zAd4r8=
X-Received: by 2002:a6b:590c:: with SMTP id n12mr935815iob.25.1601620804015;
 Thu, 01 Oct 2020 23:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200930222130.4175584-1-kaleshsingh@google.com>
 <20200930223207.5xepuvu6wr6xw5bb@black.fi.intel.com> <CA+EESO5ABYANQuynOs57UGYMcOaMjKN9TQdv4T2PObY5ng_1nw@mail.gmail.com>
 <20201001122706.jp2zr23a43hfomyg@black.fi.intel.com> <CAC_TJvd0ZM59XR0GYNcqYLK8fM=TkU+R6S7NuSx_-BN_mopksg@mail.gmail.com>
 <CA+EESO6Wyeht1GrboyZ5vW4E-DvjbWn=uOQM3ugAG=bRKMuigw@mail.gmail.com> <20201002053547.7roe7b4mpamw4uk2@black.fi.intel.com>
In-Reply-To: <20201002053547.7roe7b4mpamw4uk2@black.fi.intel.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Thu, 1 Oct 2020 23:39:53 -0700
Message-ID: <CA+EESO5P1P4_Mb_7q0E9Y9uv6f9wK4kTALqCOKsc36k+E4p-5Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] Speed up mremap on large regions
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>, Jia He <justin.he@arm.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        SeongJae Park <sjpark@amazon.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 1, 2020 at 10:36 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Thu, Oct 01, 2020 at 05:09:02PM -0700, Lokesh Gidra wrote:
> > On Thu, Oct 1, 2020 at 9:00 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> > >
> > > On Thu, Oct 1, 2020 at 8:27 AM Kirill A. Shutemov
> > > <kirill.shutemov@linux.intel.com> wrote:
> > > >
> > > > On Wed, Sep 30, 2020 at 03:42:17PM -0700, Lokesh Gidra wrote:
> > > > > On Wed, Sep 30, 2020 at 3:32 PM Kirill A. Shutemov
> > > > > <kirill.shutemov@linux.intel.com> wrote:
> > > > > >
> > > > > > On Wed, Sep 30, 2020 at 10:21:17PM +0000, Kalesh Singh wrote:
> > > > > > > mremap time can be optimized by moving entries at the PMD/PUD level if
> > > > > > > the source and destination addresses are PMD/PUD-aligned and
> > > > > > > PMD/PUD-sized. Enable moving at the PMD and PUD levels on arm64 and
> > > > > > > x86. Other architectures where this type of move is supported and known to
> > > > > > > be safe can also opt-in to these optimizations by enabling HAVE_MOVE_PMD
> > > > > > > and HAVE_MOVE_PUD.
> > > > > > >
> > > > > > > Observed Performance Improvements for remapping a PUD-aligned 1GB-sized
> > > > > > > region on x86 and arm64:
> > > > > > >
> > > > > > >     - HAVE_MOVE_PMD is already enabled on x86 : N/A
> > > > > > >     - Enabling HAVE_MOVE_PUD on x86   : ~13x speed up
> > > > > > >
> > > > > > >     - Enabling HAVE_MOVE_PMD on arm64 : ~ 8x speed up
> > > > > > >     - Enabling HAVE_MOVE_PUD on arm64 : ~19x speed up
> > > > > > >
> > > > > > >           Altogether, HAVE_MOVE_PMD and HAVE_MOVE_PUD
> > > > > > >           give a total of ~150x speed up on arm64.
> > > > > >
> > > > > > Is there a *real* workload that benefit from HAVE_MOVE_PUD?
> > > > > >
> > > > > We have a Java garbage collector under development which requires
> > > > > moving physical pages of multi-gigabyte heap using mremap. During this
> > > > > move, the application threads have to be paused for correctness. It is
> > > > > critical to keep this pause as short as possible to avoid jitters
> > > > > during user interaction. This is where HAVE_MOVE_PUD will greatly
> > > > > help.
> > > >
> > > > Any chance to quantify the effect of mremap() with and without
> > > > HAVE_MOVE_PUD?
> > > >
> > > > I doubt it's a major contributor to the GC pause. I expect you need to
> > > > move tens of gigs to get sizable effect. And if your GC routinely moves
> > > > tens of gigs, maybe problem somewhere else?
> > > >
> > > > I'm asking for numbers, because increase in complexity comes with cost.
> > > > If it doesn't provide an substantial benefit to a real workload
> > > > maintaining the code forever doesn't make sense.
> > >
> > mremap is indeed the biggest contributor to the GC pause. It has to
> > take place in what is typically known as a 'stop-the-world' pause,
> > wherein all application threads are paused. During this pause the GC
> > thread flips the GC roots (threads' stacks, globals etc.), and then
> > resumes threads along with concurrent compaction of the heap.This
> > GC-root flip differs depending on which compaction algorithm is being
> > used.
> >
> > In our case it involves updating object references in threads' stacks
> > and remapping java heap to a different location. The threads' stacks
> > can be handled in parallel with the mremap. Therefore, the dominant
> > factor is indeed the cost of mremap. From patches 2 and 4, it is clear
> > that remapping 1GB without this optimization will take ~9ms on arm64.
> >
> > Although this mremap has to happen only once every GC cycle, and the
> > typical size is also not going to be more than a GB or 2, pausing
> > application threads for ~9ms is guaranteed to cause jitters. OTOH,
> > with this optimization, mremap is reduced to ~60us, which is a totally
> > acceptable pause time.
> >
> > Unfortunately, implementation of the new GC algorithm hasn't yet
> > reached the point where I can quantify the effect of this
> > optimization. But I can confirm that without this optimization the new
> > GC will not be approved.
>
> IIUC, the 9ms -> 90us improvement attributed to combination HAVE_MOVE_PMD
> and HAVE_MOVE_PUD, right? I expect HAVE_MOVE_PMD to be reasonable for some
> workloads, but marginal benefit of HAVE_MOVE_PUD is in doubt. Do you see
> it's useful for your workload?
>
Yes, 9ms -> 90us is when both are combined. The past experience has
been that even ~1ms long stop-the-world pause is prone to cause
jitters. HAVE_MOVE_PMD takes us only this far. So HAVE_MOVE_PUD is
required to bring the mremap cost to acceptable level.

Ideally, I was hoping that the functionality of HAVE_MOVE_PMD can be
extended to all levels of the hierarchical page table, and in the
process simplify the implementation. But unfortunately, that doesn't
seem to be possible from patch 3.

> --
>  Kirill A. Shutemov
