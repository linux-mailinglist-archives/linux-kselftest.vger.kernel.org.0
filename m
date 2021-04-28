Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177EF36DC87
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 17:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbhD1P5d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Apr 2021 11:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240308AbhD1P53 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Apr 2021 11:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619625404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NAIQJbaFQ/18mbKkoum13vKuadvSUXUDgwqjg93SH3A=;
        b=GBlHVrPSHTaGu7Zi4fPyIqCCC2RIctCNLKUYXyAY5E2ULh2slgM1YMZuhuTIjdw8tNjCSU
        18hV74JgAEoYPdnjsDaDUpXRIbTZBsINwaWOFGpd5Kys/ye6b0lhZ7J4C0iL9yExA+YEz6
        h7N5wP8X6KrOLqw+8jfEmGKD7KNjXpU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-PlifOx1PPmWw2vtZQzA1WQ-1; Wed, 28 Apr 2021 11:56:41 -0400
X-MC-Unique: PlifOx1PPmWw2vtZQzA1WQ-1
Received: by mail-qt1-f199.google.com with SMTP id 7-20020ac857070000b02901ba5c36e1b2so16380949qtw.21
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Apr 2021 08:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NAIQJbaFQ/18mbKkoum13vKuadvSUXUDgwqjg93SH3A=;
        b=r21mryeR5Nugx6URSGgvAsdNzhgljJwX8/+z49OZOeBLV5SbVjcDY9tfFQCNUfoqQc
         3l60QU3nKuBvdq/M4nRmXmCFweKRpl/QVOoA2A2lY2b93fdCpyeBtoHxnKif2QF/2OBn
         /efpANjj63NubsAvy1y42A9xx+pOF+L4DWThthEUgXchwQQeODlq3E88sSuAYYrfIWTs
         tI1nE45wcC14b8Tr2eE0JDoQsbK1XCVda8H8iCZ8yBMhCyrLpMzC61KzLJX53h6m1SW/
         ckK5bwdZyjcJVHucVTO7w4mGRu3f4cyh8DQTo2X/tI7/FCmzod00bJzA1mkVwmSA9lJA
         TAcg==
X-Gm-Message-State: AOAM532iv+ZQ1wiy0ctro0CQBg+w/JYTwhB546j9RsTWDU2netKXOn81
        M9buaLaN5XKnz15036zTmDnWR+bMKVPmtcnvbr4umWhCGCpapBF8mhz9TEP+5l+BZjsm2aDH6jy
        TNfHJVEqHh+J0hvQ4XznF6iGCzzSw
X-Received: by 2002:a05:622a:1186:: with SMTP id m6mr26871399qtk.319.1619625400930;
        Wed, 28 Apr 2021 08:56:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8q5uYN6y3jHP6JWTobRGbCN9ooFKd/mXamvT7dYQYBwarL/ZsSzBJJw8wuAZWoA83r9zr4A==
X-Received: by 2002:a05:622a:1186:: with SMTP id m6mr26871356qtk.319.1619625400589;
        Wed, 28 Apr 2021 08:56:40 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id e10sm83701qka.56.2021.04.28.08.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 08:56:39 -0700 (PDT)
Date:   Wed, 28 Apr 2021 11:56:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
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
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 06/10] userfaultfd/shmem: modify
 shmem_mcopy_atomic_pte to use install_pte()
Message-ID: <20210428155638.GD6584@xz-x1>
References: <20210427225244.4326-1-axelrasmussen@google.com>
 <20210427225244.4326-7-axelrasmussen@google.com>
 <alpine.LSU.2.11.2104271704110.7111@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2104271704110.7111@eggly.anvils>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 27, 2021 at 05:58:16PM -0700, Hugh Dickins wrote:
> On Tue, 27 Apr 2021, Axel Rasmussen wrote:
> 
> > In a previous commit, we added the mcopy_atomic_install_pte() helper.
> > This helper does the job of setting up PTEs for an existing page, to map
> > it into a given VMA. It deals with both the anon and shmem cases, as
> > well as the shared and private cases.
> > 
> > In other words, shmem_mcopy_atomic_pte() duplicates a case it already
> > handles. So, expose it, and let shmem_mcopy_atomic_pte() use it
> > directly, to reduce code duplication.
> > 
> > This requires that we refactor shmem_mcopy_atomic_pte() a bit:
> > 
> > Instead of doing accounting (shmem_recalc_inode() et al) part-way
> > through the PTE setup, do it afterward. This frees up
> > mcopy_atomic_install_pte() from having to care about this accounting,
> > and means we don't need to e.g. shmem_uncharge() in the error path.
> > 
> > A side effect is this switches shmem_mcopy_atomic_pte() to use
> > lru_cache_add_inactive_or_unevictable() instead of just lru_cache_add().
> > This wrapper does some extra accounting in an exceptional case, if
> > appropriate, so it's actually the more correct thing to use.
> > 
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> 
> Not quite. Two things.
> 
> One, in this version, delete_from_page_cache(page) has vanished
> from the particular error path which needs it.

Agreed.  I also spotted that the set_page_dirty() seems to have been overlooked
when reusing mcopy_atomic_install_pte(), which afaiu should be move into the
helper.

> 
> Two, and I think this predates your changes (so needs a separate
> fix patch first, for backport to stable? a user with bad intentions
> might be able to trigger the BUG), in pondering the new error paths
> and that /* don't free the page */ one in particular, isn't it the
> case that the shmem_inode_acct_block() on entry might succeed the
> first time, but atomic copy fail so -ENOENT, then something else
> fill up the tmpfs before the retry comes in, so that retry then
> fail with -ENOMEM, and hit the BUG_ON(page) in __mcopy_atomic()?
> 
> (As I understand it, the shmem_inode_unacct_blocks() has to be
> done before returning, because the caller may be unable to retry.)
> 
> What the right fix is rather depends on other uses of __mcopy_atomic():
> if they obviously cannot hit that BUG_ON(page), you may prefer to leave
> it in, and fix it here where shmem_inode_acct_block() fails. Or you may
> prefer instead to delete that "else BUG_ON(page);" - looks as if that
> would end up doing the right thing.  Peter may have a preference.

To me, the BUG_ON(page) wanted to guarantee mfill_atomic_pte() should have
consumed the page properly when possible.  Removing the BUG_ON() looks good
already, it will just stop covering the case when e.g. ret==0.

So maybe slightly better to release the page when shmem_inode_acct_block()
fails (so as to still keep some guard on the page)?

Thanks,

-- 
Peter Xu

