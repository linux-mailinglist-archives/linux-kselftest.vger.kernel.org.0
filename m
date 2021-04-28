Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7E236DCE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 18:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240872AbhD1QYY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Apr 2021 12:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239947AbhD1QYY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Apr 2021 12:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619627018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AH7csi7wwzGg18f+fG+VSfsyVRHxjn8kIlDKQiqjMRA=;
        b=GlXUVqVwG7uj2baqqhtssiXhLfEiSx5YXhA7jqQ7zeOmfE71xQPbfcZ2fUtlpsWloRz/nt
        mlxav3oA28NMUO+EY5NzhGphMVoDRwrw2yngZzLZxH1A/4+gU+pJpSTKwp1pGJgkjf95vf
        aXH87m5hEHEIFXpHIGe4lwwJd8XDbuA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-LiRZlIW8PO-KvmxpukJxIg-1; Wed, 28 Apr 2021 12:23:36 -0400
X-MC-Unique: LiRZlIW8PO-KvmxpukJxIg-1
Received: by mail-qt1-f199.google.com with SMTP id p8-20020a05622a0488b02901bab8dfa0c5so5785700qtx.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Apr 2021 09:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AH7csi7wwzGg18f+fG+VSfsyVRHxjn8kIlDKQiqjMRA=;
        b=pQ4rOLAqwxgyfmIUe1e3e8eVHaxSjR3YudsFp22zjFC6LpBgUy00P1klBQIy5N6Sm8
         rB/sGMwWM4TkYCvHdbqUh9gNbJZ7VwIru7fsNexs6VF6Js/2baymc/H8ZFOrGHoIW1qb
         iLXJnXI5jWFuqSN2hKt8u/K75hKePnEz7gBiGfhZbywPg9Vl/g7VBB2osmySsbZs+9Kh
         8OKyyP1pkwGHJ9SY2Nvlf3IvaHKrhpC1Xcha7s5ORHmhiPl8/oxV52HI68YKyKsvzsLM
         plPERQcwS+FJ14K//3DfEmCFNyNjwExKs0tklJWM7cn3hXjJdPjieKCb2HmeX4lTWKtk
         COZg==
X-Gm-Message-State: AOAM533b3U3sY1vOa/KPU4Am6usj8K7B/3UFjjYDoI2AxZ4CE9lyQz0d
        jVJIZQpRMMBvUIwcV0vgP8NtHopbn6Y9aIvfkbiq77b2uGW19rwhUAWMKMrFM+mTJYXfsm86LCj
        7gr7K0YDmWeengB0XsP8myM8c6wMy
X-Received: by 2002:a0c:ec0f:: with SMTP id y15mr14227322qvo.9.1619627015687;
        Wed, 28 Apr 2021 09:23:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxbTtNlW1BwVWHBPqrKcGOZYJKpqLvm889MXyWSVHOhrT+49N36LmGWoLkkG+ECXaA21Ximg==
X-Received: by 2002:a0c:ec0f:: with SMTP id y15mr14227282qvo.9.1619627015284;
        Wed, 28 Apr 2021 09:23:35 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id h8sm333557qtp.47.2021.04.28.09.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 09:23:34 -0700 (PDT)
Date:   Wed, 28 Apr 2021 12:23:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v5 06/10] userfaultfd/shmem: modify
 shmem_mcopy_atomic_pte to use install_pte()
Message-ID: <20210428162332.GE6584@xz-x1>
References: <20210427225244.4326-1-axelrasmussen@google.com>
 <20210427225244.4326-7-axelrasmussen@google.com>
 <alpine.LSU.2.11.2104271704110.7111@eggly.anvils>
 <20210428155638.GD6584@xz-x1>
 <CAJHvVcg6mt-FH0vn3ZApYU1tdtyu_8pgGtnKxrX5m2OjiCeApw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcg6mt-FH0vn3ZApYU1tdtyu_8pgGtnKxrX5m2OjiCeApw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 28, 2021 at 08:59:53AM -0700, Axel Rasmussen wrote:
> On Wed, Apr 28, 2021 at 8:56 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Apr 27, 2021 at 05:58:16PM -0700, Hugh Dickins wrote:
> > > On Tue, 27 Apr 2021, Axel Rasmussen wrote:
> > >
> > > > In a previous commit, we added the mcopy_atomic_install_pte() helper.
> > > > This helper does the job of setting up PTEs for an existing page, to map
> > > > it into a given VMA. It deals with both the anon and shmem cases, as
> > > > well as the shared and private cases.
> > > >
> > > > In other words, shmem_mcopy_atomic_pte() duplicates a case it already
> > > > handles. So, expose it, and let shmem_mcopy_atomic_pte() use it
> > > > directly, to reduce code duplication.
> > > >
> > > > This requires that we refactor shmem_mcopy_atomic_pte() a bit:
> > > >
> > > > Instead of doing accounting (shmem_recalc_inode() et al) part-way
> > > > through the PTE setup, do it afterward. This frees up
> > > > mcopy_atomic_install_pte() from having to care about this accounting,
> > > > and means we don't need to e.g. shmem_uncharge() in the error path.
> > > >
> > > > A side effect is this switches shmem_mcopy_atomic_pte() to use
> > > > lru_cache_add_inactive_or_unevictable() instead of just lru_cache_add().
> > > > This wrapper does some extra accounting in an exceptional case, if
> > > > appropriate, so it's actually the more correct thing to use.
> > > >
> > > > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > >
> > > Not quite. Two things.
> > >
> > > One, in this version, delete_from_page_cache(page) has vanished
> > > from the particular error path which needs it.
> >
> > Agreed.  I also spotted that the set_page_dirty() seems to have been overlooked
> > when reusing mcopy_atomic_install_pte(), which afaiu should be move into the
> > helper.
> 
> I think this is covered: we explicitly call SetPageDirty() just before
> returning in shmem_mcopy_atomic_pte(). If I remember correctly from a
> couple of revisions ago, we consciously put it here instead of in the
> helper because it resulted in simpler code (error handling in
> particular, I think?), and not all callers of the new helper need it.

Indeed, yes that looks okay.

> 
> >
> > >
> > > Two, and I think this predates your changes (so needs a separate
> > > fix patch first, for backport to stable? a user with bad intentions
> > > might be able to trigger the BUG), in pondering the new error paths
> > > and that /* don't free the page */ one in particular, isn't it the
> > > case that the shmem_inode_acct_block() on entry might succeed the
> > > first time, but atomic copy fail so -ENOENT, then something else
> > > fill up the tmpfs before the retry comes in, so that retry then
> > > fail with -ENOMEM, and hit the BUG_ON(page) in __mcopy_atomic()?
> > >
> > > (As I understand it, the shmem_inode_unacct_blocks() has to be
> > > done before returning, because the caller may be unable to retry.)
> > >
> > > What the right fix is rather depends on other uses of __mcopy_atomic():
> > > if they obviously cannot hit that BUG_ON(page), you may prefer to leave
> > > it in, and fix it here where shmem_inode_acct_block() fails. Or you may
> > > prefer instead to delete that "else BUG_ON(page);" - looks as if that
> > > would end up doing the right thing.  Peter may have a preference.
> >
> > To me, the BUG_ON(page) wanted to guarantee mfill_atomic_pte() should have
> > consumed the page properly when possible.  Removing the BUG_ON() looks good
> > already, it will just stop covering the case when e.g. ret==0.
> >
> > So maybe slightly better to release the page when shmem_inode_acct_block()
> > fails (so as to still keep some guard on the page)?
> 
> This second issue, I will take some more time to investigate. :)

No worry - take your time. :)

-- 
Peter Xu

