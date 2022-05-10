Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252965225E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 22:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiEJUxu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 16:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiEJUxt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 16:53:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13D721E326;
        Tue, 10 May 2022 13:53:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4F7C221BC9;
        Tue, 10 May 2022 20:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652216027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oLOHdpuCYzAccJ6ajaHotiOG99qDB43cAS4y17f1Oec=;
        b=mDJpnWdLo/vamrPVU9LuFUdyYMMMU2py1rUwVE/l5ixKrRbwJ7ncUbVlbywXkEfQ/VKoGI
        i8yYR6YctJu+b+ooPUYbEvYemkKMlTqe45XeHTn/s5TnCUrMCNNDbvinQGQzFQhem7fjKV
        I3dTbizO+oqVAStb3iNU29aTuXgFDko=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C98972C141;
        Tue, 10 May 2022 20:53:46 +0000 (UTC)
Date:   Tue, 10 May 2022 22:53:43 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, shuah@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH 2/3] mm: drop oom code from exit_mmap
Message-ID: <YnrQ11iou9bwN9tY@dhcp22.suse.cz>
References: <20220510030014.3842475-1-surenb@google.com>
 <20220510030014.3842475-2-surenb@google.com>
 <YnpjNyrdqT/QxBPI@dhcp22.suse.cz>
 <CAJuCfpEt9SSrELZzfmcqJ7JL_nEzWGz-YE9GRUZTjU5unqQjQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEt9SSrELZzfmcqJ7JL_nEzWGz-YE9GRUZTjU5unqQjQg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 10-05-22 09:31:50, Suren Baghdasaryan wrote:
> On Tue, May 10, 2022 at 6:06 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 09-05-22 20:00:13, Suren Baghdasaryan wrote:
> > > With the oom-killer being able to operate on locked pages, exit_mmap
> > > does not need to ensure that oom_reap_task_mm is done before it can
> > > proceed. Instead it can rely on mmap_lock write lock to prevent
> > > oom-killer from operating on the vma tree while it's freeing page
> > > tables. exit_mmap can hold mmap_lock read lock when unmapping vmas
> > > and then take mmap_lock write lock before freeing page tables.
> >
> > The changelog is rather light on nasty details which might be good but
> > for the sake of our future us let's be more verbose so that we do not
> > have to reinvent the prior history each time we are looking into this
> > code. I would go with something like this instead:
> > "
> > The primary reason to invoke the oom reaper from the exit_mmap path used
> > to be a prevention of an excessive oom killing if the oom victim exit
> > races with the oom reaper (see 212925802454 ("mm: oom: let oom_reap_task
> > and exit_mmap run concurrently") for more details. The invocation has
> > moved around since then because of the interaction with the munlock
> > logic but the underlying reason has remained the same (see 27ae357fa82b
> > ("mm, oom: fix concurrent munlock and oom reaper unmap, v3").
> >
> > Munlock code is no longer a problem since a213e5cf71cb ("mm/munlock:
> > delete munlock_vma_pages_all(), allow oomreap") and there shouldn't be
> > any blocking operation before the memory is unmapped by exit_mmap so
> > the oom reaper invocation can be dropped. The unmapping part can be done
> > with the non-exclusive mmap_sem and the exclusive one is only required
> > when page tables are freed.
> >
> > Remove the oom_reaper from exit_mmap which will make the code easier to
> > read. This is really unlikely to make any observable difference although
> > some microbenchmarks could benefit from one less branch that needs to be
> > evaluated even though it almost never is true.
> > "
> 
> Looks great! Thanks for collecting all the history. Will update the description.

Please make sure you double check the story. This is mostly my
recollection and brief reading through the said commits. I might
misremember here and there.
-- 
Michal Hocko
SUSE Labs
