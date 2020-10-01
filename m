Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31C27FEEE
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 14:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbgJAM1S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Oct 2020 08:27:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:20541 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731888AbgJAM1S (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Oct 2020 08:27:18 -0400
IronPort-SDR: g/53jGtHPBQB5gPvsLQUW2a6d5n+sYmYXR+9Dyg4pHxe8fmmMNqHKM8oNWX+YIiqLCDpjGJnKM
 02CWRCCWJ0CA==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="160112729"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="160112729"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 05:27:17 -0700
IronPort-SDR: vYQlnFQDsSeVVFoJ8EgOROs7Pwdn8XJOQwxW3/B9d3MJcpTWEEUP/POGl82D5k9JxBIIN2EbId
 3+0Q3exN2QZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="514699410"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 01 Oct 2020 05:27:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 31B46327; Thu,  1 Oct 2020 15:27:06 +0300 (EEST)
Date:   Thu, 1 Oct 2020 15:27:06 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/5] Speed up mremap on large regions
Message-ID: <20201001122706.jp2zr23a43hfomyg@black.fi.intel.com>
References: <20200930222130.4175584-1-kaleshsingh@google.com>
 <20200930223207.5xepuvu6wr6xw5bb@black.fi.intel.com>
 <CA+EESO5ABYANQuynOs57UGYMcOaMjKN9TQdv4T2PObY5ng_1nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EESO5ABYANQuynOs57UGYMcOaMjKN9TQdv4T2PObY5ng_1nw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 30, 2020 at 03:42:17PM -0700, Lokesh Gidra wrote:
> On Wed, Sep 30, 2020 at 3:32 PM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Wed, Sep 30, 2020 at 10:21:17PM +0000, Kalesh Singh wrote:
> > > mremap time can be optimized by moving entries at the PMD/PUD level if
> > > the source and destination addresses are PMD/PUD-aligned and
> > > PMD/PUD-sized. Enable moving at the PMD and PUD levels on arm64 and
> > > x86. Other architectures where this type of move is supported and known to
> > > be safe can also opt-in to these optimizations by enabling HAVE_MOVE_PMD
> > > and HAVE_MOVE_PUD.
> > >
> > > Observed Performance Improvements for remapping a PUD-aligned 1GB-sized
> > > region on x86 and arm64:
> > >
> > >     - HAVE_MOVE_PMD is already enabled on x86 : N/A
> > >     - Enabling HAVE_MOVE_PUD on x86   : ~13x speed up
> > >
> > >     - Enabling HAVE_MOVE_PMD on arm64 : ~ 8x speed up
> > >     - Enabling HAVE_MOVE_PUD on arm64 : ~19x speed up
> > >
> > >           Altogether, HAVE_MOVE_PMD and HAVE_MOVE_PUD
> > >           give a total of ~150x speed up on arm64.
> >
> > Is there a *real* workload that benefit from HAVE_MOVE_PUD?
> >
> We have a Java garbage collector under development which requires
> moving physical pages of multi-gigabyte heap using mremap. During this
> move, the application threads have to be paused for correctness. It is
> critical to keep this pause as short as possible to avoid jitters
> during user interaction. This is where HAVE_MOVE_PUD will greatly
> help.

Any chance to quantify the effect of mremap() with and without
HAVE_MOVE_PUD?

I doubt it's a major contributor to the GC pause. I expect you need to
move tens of gigs to get sizable effect. And if your GC routinely moves
tens of gigs, maybe problem somewhere else?

I'm asking for numbers, because increase in complexity comes with cost.
If it doesn't provide an substantial benefit to a real workload
maintaining the code forever doesn't make sense.

-- 
 Kirill A. Shutemov
