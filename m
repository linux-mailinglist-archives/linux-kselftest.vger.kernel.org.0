Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C563486D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Mar 2021 03:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhCYCLq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Mar 2021 22:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbhCYCLS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Mar 2021 22:11:18 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC6CC06174A
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Mar 2021 19:11:07 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n198so430192iod.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Mar 2021 19:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hKoU5fbuXR6tau309P7NjH2acT/oE9AD++ForKsP118=;
        b=L6mTCCBB85LiB8VWBpY+r4pzgusBb9O8UZ9QYRk1b6K7QueXG496kakAaG10e1UCY7
         G4+O+FiVEO7OPZ0UnULXwYpY9cjZytqOXn10UCh3TIKsHMof2pt0/gv+BRYEHYRIZhuL
         VKC8W6uRHKbey5z7BJAjhhufaHLfdp24kaxORkaB+ORc+u5cZ2NLEh/qk93tigPyW2TW
         cbDbUugkkBTAa0gkw+0BAgHr08NmAYrrO2ZZtL32Agel39xQtV1KmEJ+WCzuNqR+KgMT
         zOTQF68izOPF7Lr0QCE4qk7UWuQc4C0P08qHrN0fMSQ7rGRbDkns+IEicn1PzAkDdN1U
         PUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKoU5fbuXR6tau309P7NjH2acT/oE9AD++ForKsP118=;
        b=Ob2HLiAT7l3M9qRvAxXL4ZzsgCt9r4+p87kcCjlZVJ8fLsQm86/Dujy/XNDFXs7Cqu
         2XpmnuQBRgHnxxkkt973BolGPzq/2gxA0Eu6DG+/JDerj696mxqZi/2nlUSQyj0rTuOi
         0tF7NcuDw42dbUd+9YexhENIbdi5NST+nk/FIF9Q9QWlIIcT+JhU3Lu1HWYzrQhWXLPz
         Vc9K8AFm4aQV4NkSudEsItM47g8RQ9WxIvBQM2ygUgXRhFH+BvecxJtvQPnqVT4ucLYc
         6yu/Hd0l/lFCwE98Frre74Fho8cUVE+4bpQsQs+AugYFFxv05ebMDylkmeCNVVp7Vj9M
         z1PA==
X-Gm-Message-State: AOAM533LaY5JM4F+tfobEzFLHJ2KfZKfbTavQhOtuObVjDdpl2M/eGA8
        cl1LDWwUPUueQGoFVndDYe8aK8SW+GDkW6fLJ4ePDA==
X-Google-Smtp-Source: ABdhPJw9HtJcSWrg+GZkl1jPh232CLRkZRVhbTjpqVDsmNw9HWIy1/84ORisKJGDaiFNa1GUibJG1iyhbj2Vjwhjx78=
X-Received: by 2002:a5e:8610:: with SMTP id z16mr4488908ioj.57.1616638260820;
 Wed, 24 Mar 2021 19:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210322204836.1650221-1-axelrasmussen@google.com>
 <20210324162027.cc723b545ff62b1ad6f5223e@linux-foundation.org> <20210325005234.GG219069@xz-x1>
In-Reply-To: <20210325005234.GG219069@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 24 Mar 2021 19:10:24 -0700
Message-ID: <CAJHvVch7kH8JqbakfPgurfEMOGobw5LsEnbfmyT6HB+=cjgHCA@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd/shmem: fix minor fault page leak
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Wang Qing <wangqing@vivo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 24, 2021 at 5:52 PM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Andrew,
>
> On Wed, Mar 24, 2021 at 04:20:27PM -0700, Andrew Morton wrote:
> > On Mon, 22 Mar 2021 13:48:35 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:
> >
> > > This fix is analogous to Peter Xu's fix for hugetlb [0]. If we don't
> > > put_page() after getting the page out of the page cache, we leak the
> > > reference.
> > >
> > > The fix can be verified by checking /proc/meminfo and running the
> > > userfaultfd selftest in shmem mode. Without the fix, we see MemFree /
> > > MemAvailable steadily decreasing with each run of the test. With the
> > > fix, memory is correctly freed after the test program exits.
> > >
> > > Fixes: 00da60b9d0a0 ("userfaultfd: support minor fault handling for shmem")
> >
> > Confused.  The affected code:
> >
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -1831,6 +1831,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> > >
> > >     if (page && vma && userfaultfd_minor(vma)) {
> > >             unlock_page(page);
> > > +           put_page(page);
> > >             *fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
> > >             return 0;
> > >     }
> >
> > Is added by Peter's "page && vma && userfaultfd_minor".  I assume that
> > "Fixes:" is incorrect?
> >
>
> It seems to me the commit is correct as pointed to in "Fixes", but I do have a
> different commit ID here:
>
>     commit 63c826b1372c4930f89b8a55092699fa7f0d6f4e
>     Author: Axel Rasmussen <axelrasmussen@google.com>
>     Date:   Thu Mar 18 10:20:43 2021 -0400
>
>     userfaultfd: support minor fault handling for shmem
>
> Axel, did you fetched the commit ID from your local tree, perhaps?  Since I
> should have fetched from hnaz/linux-mm and I can see Andrew's sign-off too.
>
> Thanks,
>
> --
> Peter Xu
>

Ah, this is the SHA I see when I "git log --grep linux-next/akpm"
(where my repo's linux-next remote is [1]):

commit 00da60b9d0a03818c36a2fe862578309c27006ad
Author: Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu Mar 18 17:01:51 2021 +1100

    userfaultfd: support minor fault handling for shmem

This is the commit that this new patch fixes. I'll admit I'm a bit
unsure which tree the "Fixes:" tag is meant to refer to before the
commits make it into Linus' tree, if I should look up the commit
another way just let me know. :) And, sorry for the confusion.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
