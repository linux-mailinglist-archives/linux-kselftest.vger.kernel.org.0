Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FBB280361
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 18:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbgJAQAH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Oct 2020 12:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732119AbgJAQAH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Oct 2020 12:00:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF24C0613E2
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Oct 2020 09:00:06 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so4919500pfn.9
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Oct 2020 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tP2dMg1iUwJzmq0vUogTLB9VpnaKWbxkOw0rS14MEAY=;
        b=DyMVRpMvDrJEc7kSshu7rW7AlqroyCIaxTDZ9EMt9YvbwBwXyDaoKE6fZpl0O+0HcZ
         FSlXvAvgdOGhlHS6xV23L8iC6pyW5qjvaI4uYMEHcRIij3YSAO4aK9LvOUeYcnf2ZjLl
         1uAwbfAa70Ej2z6wcAIYQ9wxjLv6b7K9hkVeVWW8qUq+p7D30nprbmv70XvmIGay+xZw
         WOBeDohWMLktNIK62U0HpXI281xL//XJYYVe6PnDGApbmnhl2d8VJ952m2i8LQyrhlf9
         /CBhiffEnYZwoCDtSyJeWg3ly9SnLhgVGQauu1JG/OPpH7Z/Tjxrng6gvoipDkYsJZMG
         pOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tP2dMg1iUwJzmq0vUogTLB9VpnaKWbxkOw0rS14MEAY=;
        b=JF4fywDrw12YxfIfBARrOsp2+HZbYsPDHcpOp8922hqYC7xGcxBRX8z0Qct/Ss0iPd
         lQFPXnfOlBzZzf4G/M+xbpz12Y5kzwJcXESAp5jLmaePklSVMkttjyIGa+67OWLLo/Zk
         ktC4ieFfK0lMzwwahW2Fd8hJkltp1ZtOxHT58ZiY6uXdNIDXK2c0n04zE/lrBQAZ+UHa
         P/mpOFlxT9RN9kD/PwwpJsorslzc34cBceJBmMcLMahBj+BtnALdHKF7Y9JwcXrmOg/v
         XFiiRpTrwiWbkLqf0wJ2PjiY1vim/WIROwGUC37au7x6th9TGUdHW+Su1GIxQkoNL59O
         WSvQ==
X-Gm-Message-State: AOAM530LnTxBWCdBqdhqgfYqDrffn1xWJhmGWz2lQELDeaxdcIKpExNG
        DBkcoUA2Eqh5w1Lp0PjJGwbBIvA6qGWD3XZHfONZew==
X-Google-Smtp-Source: ABdhPJwlN5650AFlb8kwX/it/lrlk/RuhAcIRQLhSEsh+o04Dv5aTuiH3aYg0Hlib9CD5zO1Qo4rDUKW5Cf5xtTRDKU=
X-Received: by 2002:a62:3541:0:b029:13f:ebd9:ad5c with SMTP id
 c62-20020a6235410000b029013febd9ad5cmr8127487pfa.30.1601568005449; Thu, 01
 Oct 2020 09:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200930222130.4175584-1-kaleshsingh@google.com>
 <20200930223207.5xepuvu6wr6xw5bb@black.fi.intel.com> <CA+EESO5ABYANQuynOs57UGYMcOaMjKN9TQdv4T2PObY5ng_1nw@mail.gmail.com>
 <20201001122706.jp2zr23a43hfomyg@black.fi.intel.com>
In-Reply-To: <20201001122706.jp2zr23a43hfomyg@black.fi.intel.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 1 Oct 2020 11:59:54 -0400
Message-ID: <CAC_TJvd0ZM59XR0GYNcqYLK8fM=TkU+R6S7NuSx_-BN_mopksg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Speed up mremap on large regions
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
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

On Thu, Oct 1, 2020 at 8:27 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Wed, Sep 30, 2020 at 03:42:17PM -0700, Lokesh Gidra wrote:
> > On Wed, Sep 30, 2020 at 3:32 PM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > On Wed, Sep 30, 2020 at 10:21:17PM +0000, Kalesh Singh wrote:
> > > > mremap time can be optimized by moving entries at the PMD/PUD level if
> > > > the source and destination addresses are PMD/PUD-aligned and
> > > > PMD/PUD-sized. Enable moving at the PMD and PUD levels on arm64 and
> > > > x86. Other architectures where this type of move is supported and known to
> > > > be safe can also opt-in to these optimizations by enabling HAVE_MOVE_PMD
> > > > and HAVE_MOVE_PUD.
> > > >
> > > > Observed Performance Improvements for remapping a PUD-aligned 1GB-sized
> > > > region on x86 and arm64:
> > > >
> > > >     - HAVE_MOVE_PMD is already enabled on x86 : N/A
> > > >     - Enabling HAVE_MOVE_PUD on x86   : ~13x speed up
> > > >
> > > >     - Enabling HAVE_MOVE_PMD on arm64 : ~ 8x speed up
> > > >     - Enabling HAVE_MOVE_PUD on arm64 : ~19x speed up
> > > >
> > > >           Altogether, HAVE_MOVE_PMD and HAVE_MOVE_PUD
> > > >           give a total of ~150x speed up on arm64.
> > >
> > > Is there a *real* workload that benefit from HAVE_MOVE_PUD?
> > >
> > We have a Java garbage collector under development which requires
> > moving physical pages of multi-gigabyte heap using mremap. During this
> > move, the application threads have to be paused for correctness. It is
> > critical to keep this pause as short as possible to avoid jitters
> > during user interaction. This is where HAVE_MOVE_PUD will greatly
> > help.
>
> Any chance to quantify the effect of mremap() with and without
> HAVE_MOVE_PUD?
>
> I doubt it's a major contributor to the GC pause. I expect you need to
> move tens of gigs to get sizable effect. And if your GC routinely moves
> tens of gigs, maybe problem somewhere else?
>
> I'm asking for numbers, because increase in complexity comes with cost.
> If it doesn't provide an substantial benefit to a real workload
> maintaining the code forever doesn't make sense.

Lokesh on this thread would be better able to answer this. I'll let
him weigh in here.
Thanks, Kalesh
>
> --
>  Kirill A. Shutemov
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
