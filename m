Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD293280D17
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 07:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgJBFgB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 01:36:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:56826 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgJBFgB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 01:36:01 -0400
IronPort-SDR: D2Rz482NaQhH5ZRjNh1xWcX+A/mfikJ3BnVNt9Y+T5RM+Ht6Ned8HksMLwpn9yZAi2WZvY+AN5
 BfLuFAMbK/ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="162999080"
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="162999080"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 22:36:00 -0700
IronPort-SDR: 6jbjLfWQqsr8aAjCtPX3bOqRuP0w7ep6Pn0NOrfCvkw3J64sV+Kxqz7ve4t9XBDwiBnZPS2cyw
 1gHeBPuottrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="515784545"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 01 Oct 2020 22:35:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 3AFB4CB; Fri,  2 Oct 2020 08:35:47 +0300 (EEST)
Date:   Fri, 2 Oct 2020 08:35:47 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
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
Subject: Re: [PATCH 0/5] Speed up mremap on large regions
Message-ID: <20201002053547.7roe7b4mpamw4uk2@black.fi.intel.com>
References: <20200930222130.4175584-1-kaleshsingh@google.com>
 <20200930223207.5xepuvu6wr6xw5bb@black.fi.intel.com>
 <CA+EESO5ABYANQuynOs57UGYMcOaMjKN9TQdv4T2PObY5ng_1nw@mail.gmail.com>
 <20201001122706.jp2zr23a43hfomyg@black.fi.intel.com>
 <CAC_TJvd0ZM59XR0GYNcqYLK8fM=TkU+R6S7NuSx_-BN_mopksg@mail.gmail.com>
 <CA+EESO6Wyeht1GrboyZ5vW4E-DvjbWn=uOQM3ugAG=bRKMuigw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EESO6Wyeht1GrboyZ5vW4E-DvjbWn=uOQM3ugAG=bRKMuigw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 01, 2020 at 05:09:02PM -0700, Lokesh Gidra wrote:
> On Thu, Oct 1, 2020 at 9:00 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > On Thu, Oct 1, 2020 at 8:27 AM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > On Wed, Sep 30, 2020 at 03:42:17PM -0700, Lokesh Gidra wrote:
> > > > On Wed, Sep 30, 2020 at 3:32 PM Kirill A. Shutemov
> > > > <kirill.shutemov@linux.intel.com> wrote:
> > > > >
> > > > > On Wed, Sep 30, 2020 at 10:21:17PM +0000, Kalesh Singh wrote:
> > > > > > mremap time can be optimized by moving entries at the PMD/PUD level if
> > > > > > the source and destination addresses are PMD/PUD-aligned and
> > > > > > PMD/PUD-sized. Enable moving at the PMD and PUD levels on arm64 and
> > > > > > x86. Other architectures where this type of move is supported and known to
> > > > > > be safe can also opt-in to these optimizations by enabling HAVE_MOVE_PMD
> > > > > > and HAVE_MOVE_PUD.
> > > > > >
> > > > > > Observed Performance Improvements for remapping a PUD-aligned 1GB-sized
> > > > > > region on x86 and arm64:
> > > > > >
> > > > > >     - HAVE_MOVE_PMD is already enabled on x86 : N/A
> > > > > >     - Enabling HAVE_MOVE_PUD on x86   : ~13x speed up
> > > > > >
> > > > > >     - Enabling HAVE_MOVE_PMD on arm64 : ~ 8x speed up
> > > > > >     - Enabling HAVE_MOVE_PUD on arm64 : ~19x speed up
> > > > > >
> > > > > >           Altogether, HAVE_MOVE_PMD and HAVE_MOVE_PUD
> > > > > >           give a total of ~150x speed up on arm64.
> > > > >
> > > > > Is there a *real* workload that benefit from HAVE_MOVE_PUD?
> > > > >
> > > > We have a Java garbage collector under development which requires
> > > > moving physical pages of multi-gigabyte heap using mremap. During this
> > > > move, the application threads have to be paused for correctness. It is
> > > > critical to keep this pause as short as possible to avoid jitters
> > > > during user interaction. This is where HAVE_MOVE_PUD will greatly
> > > > help.
> > >
> > > Any chance to quantify the effect of mremap() with and without
> > > HAVE_MOVE_PUD?
> > >
> > > I doubt it's a major contributor to the GC pause. I expect you need to
> > > move tens of gigs to get sizable effect. And if your GC routinely moves
> > > tens of gigs, maybe problem somewhere else?
> > >
> > > I'm asking for numbers, because increase in complexity comes with cost.
> > > If it doesn't provide an substantial benefit to a real workload
> > > maintaining the code forever doesn't make sense.
> >
> mremap is indeed the biggest contributor to the GC pause. It has to
> take place in what is typically known as a 'stop-the-world' pause,
> wherein all application threads are paused. During this pause the GC
> thread flips the GC roots (threads' stacks, globals etc.), and then
> resumes threads along with concurrent compaction of the heap.This
> GC-root flip differs depending on which compaction algorithm is being
> used.
> 
> In our case it involves updating object references in threads' stacks
> and remapping java heap to a different location. The threads' stacks
> can be handled in parallel with the mremap. Therefore, the dominant
> factor is indeed the cost of mremap. From patches 2 and 4, it is clear
> that remapping 1GB without this optimization will take ~9ms on arm64.
> 
> Although this mremap has to happen only once every GC cycle, and the
> typical size is also not going to be more than a GB or 2, pausing
> application threads for ~9ms is guaranteed to cause jitters. OTOH,
> with this optimization, mremap is reduced to ~60us, which is a totally
> acceptable pause time.
> 
> Unfortunately, implementation of the new GC algorithm hasn't yet
> reached the point where I can quantify the effect of this
> optimization. But I can confirm that without this optimization the new
> GC will not be approved.

IIUC, the 9ms -> 90us improvement attributed to combination HAVE_MOVE_PMD
and HAVE_MOVE_PUD, right? I expect HAVE_MOVE_PMD to be reasonable for some
workloads, but marginal benefit of HAVE_MOVE_PUD is in doubt. Do you see
it's useful for your workload?

-- 
 Kirill A. Shutemov
