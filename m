Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A3035A83F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Apr 2021 23:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhDIVSq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Apr 2021 17:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233687AbhDIVSo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Apr 2021 17:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618003110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6LfDPLi5E0po8MV65N/nBXOnSa/U1n1bpGd2B6Y5zrs=;
        b=NRUYHVmUtz8LtV/t20xv8pZinua3Qj27hbFHYz5ZX7bdHw47gkT2zk4hTd7J9nw7x2bQzU
        mlA820Wp7u17ys4+f4YU8IcljoU0yIRra8KbxoS5pJ2scFT4O3DSkZX8eBzKeg8H+H7H4j
        5IxJclONL+pDcpDQ4MxKuMvavfooo0g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-1oF3Unc8ONylwEy8c8fTYw-1; Fri, 09 Apr 2021 17:18:28 -0400
X-MC-Unique: 1oF3Unc8ONylwEy8c8fTYw-1
Received: by mail-qv1-f69.google.com with SMTP id e10so3979560qvr.17
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Apr 2021 14:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6LfDPLi5E0po8MV65N/nBXOnSa/U1n1bpGd2B6Y5zrs=;
        b=Nq3ATe/2Al2/+G+bD32fp+p4D3qN/BCsr8NAEOgLXEL4C5ACdK0yA5mlynw9TlNYt1
         LUGwRf/DH2AarT2syO8ErFmXWFqCp2ClwYQwIR+pfnPOwLDMEYWgWwsxm7rkeFQo/wip
         amuw7qt8TbUq+F5y/USSUANCW2jsJscslgthy9KNxtY5DjpRBajcbdeA+BJNmv/32hok
         BFIXsN4X3ANKR20tPS1WLSHhYMssyA1ZzepLTuLoxAFniOGHEFPZe7V3EdEpk7BGAe4x
         dajs6x6mmjYxPTYHPZf8LQZU6gpH15sFmqlVwx6oNno4/2OSldInVvF1OsNPIaMiOHW1
         UpTA==
X-Gm-Message-State: AOAM5316zN6cLknoTQP5PigDFUM6fPQOwshteW6XSwIAmfjw/CdP7dxU
        ckEAuElES0I70oLl9yLSA6sb9D3+4DZPPlLpJNAy1n8mFkn08bCl4fV/XxCYnLyrN+/cBZGlQrN
        uXFxphwzB2DB608LBi94XA35GIniU
X-Received: by 2002:a05:620a:1369:: with SMTP id d9mr16206727qkl.378.1618003107935;
        Fri, 09 Apr 2021 14:18:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWcW26HNQ/4u/a9UUVswHcCgm4mQgj1l0Ik4tAPemu5I9vnvbu6buq/FCs5OPNi83I6zujbQ==
X-Received: by 2002:a05:620a:1369:: with SMTP id d9mr16206687qkl.378.1618003107587;
        Fri, 09 Apr 2021 14:18:27 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id d68sm2628359qkf.93.2021.04.09.14.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 14:18:26 -0700 (PDT)
Date:   Fri, 9 Apr 2021 17:18:24 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 0/9] userfaultfd: add minor fault handling for shmem
Message-ID: <20210409211824.GH792100@xz-x1>
References: <20210408234327.624367-1-axelrasmussen@google.com>
 <20210408220440.aab59f2f06beb840c22377b3@linux-foundation.org>
 <CAJHvVcj84fcuh0vXtHdEPoV+DrFDSXjUg1fO+oLFCOaxWBH13w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcj84fcuh0vXtHdEPoV+DrFDSXjUg1fO+oLFCOaxWBH13w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 09, 2021 at 10:03:53AM -0700, Axel Rasmussen wrote:
> On Thu, Apr 8, 2021 at 10:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu,  8 Apr 2021 16:43:18 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:
> >
> > > The idea is that it will apply cleanly to akpm's tree, *replacing* the following
> > > patches (i.e., drop these first, and then apply this series):
> > >
> > > userfaultfd-support-minor-fault-handling-for-shmem.patch
> > > userfaultfd-support-minor-fault-handling-for-shmem-fix.patch
> > > userfaultfd-support-minor-fault-handling-for-shmem-fix-2.patch
> > > userfaultfd-support-minor-fault-handling-for-shmem-fix-3.patch
> > > userfaultfd-support-minor-fault-handling-for-shmem-fix-4.patch
> > > userfaultfd-selftests-use-memfd_create-for-shmem-test-type.patch
> > > userfaultfd-selftests-create-alias-mappings-in-the-shmem-test.patch
> > > userfaultfd-selftests-reinitialize-test-context-in-each-test.patch
> > > userfaultfd-selftests-exercise-minor-fault-handling-shmem-support.patch
> >
> > Well.  the problem is,
> >
> > > +     if (area_alias == MAP_FAILED)
> > > +             err("mmap of memfd alias failed");
> >
> > `err' doesn't exist until eleventy patches later, in Peter's
> > "userfaultfd/selftests: unify error handling".  I got tired of (and
> > lost confidence in) replacing "err(...)" with "fprintf(stderr, ...);
> > exit(1)" everywhere then fixing up the fallout when Peter's patch came
> > along.  Shudder.
> 
> Oof - sorry about that!
> 
> >
> > Sorry, all this material pretty clearly isn't going to make 5.12
> > (potentially nine days hence), so I shall drop all the userfaultfd
> > patches.  Let's take a fresh run at all of this after -rc1.
> 
> That's okay, my understanding was already that it certainly wouldn't
> be in the 5.12 release, but that we might be ready in time for 5.13.
> 
> >
> >
> > I have tentatively retained the first series:
> >
> > userfaultfd-add-minor-fault-registration-mode.patch
> > userfaultfd-add-minor-fault-registration-mode-fix.patch
> > userfaultfd-disable-huge-pmd-sharing-for-minor-registered-vmas.patch
> > userfaultfd-hugetlbfs-only-compile-uffd-helpers-if-config-enabled.patch
> > userfaultfd-add-uffdio_continue-ioctl.patch
> > userfaultfd-update-documentation-to-describe-minor-fault-handling.patch
> > userfaultfd-selftests-add-test-exercising-minor-fault-handling.patch
> >
> > but I don't believe they have had much testing standalone, without the
> > other userfaultfd patches present.  So I don't think it's smart to
> > upstream these in this cycle.  Or I could drop them so you and Peter
> > can have a clean shot at redoing the whole thing.  Please let me know.
> 
> From my perspective, both Peter's error handling and the hugetlbfs
> minor faulting patches are ready to go. (Peter's most importantly; we
> should establish that as a base, and put all the burden on resolving
> conflicts with it on us instead of you :).)
> 
> My memory was that Peter's patch was applied before my shmem series,
> but it seems I was mistaken. So, maybe the best thing to do is to have
> Peter send a version of it based on your tree, without the shmem
> series? And then I'll resolve any conflicts in my tree?
> 
> It's true that we haven't tested the hugetlbfs minor faults patch
> extensively *with the shmem one also applied*, but it has had more
> thorough review than the shmem one at this point (e.g. by Mike
> Kravetz), and they're rather separate code paths (I'd be surprised if
> one breaks the other).

Yes I think the hugetlb part should have got more review done.  IMHO it's a
matter of whether Mike would still like to do a more thorough review, or seems
okay to keep them.

I can repost the selftest series later if needed, as long as I figured which is
the suitable base commit.  Those selftest patches are definitely not urgent for
this release, so we can wait for the next release.

Thanks,

-- 
Peter Xu

