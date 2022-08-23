Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B40059D71D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349484AbiHWJbk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 05:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350672AbiHWJal (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 05:30:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF15992F62;
        Tue, 23 Aug 2022 01:37:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D650D20F15;
        Tue, 23 Aug 2022 08:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661243775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQ02uGY4LaDgfuC0EhK53ZvKSS1XQwJHJ3fflLYmAjg=;
        b=cFE5YYpE9evSSKSJipAkRPfcz4A+d9gBKDJiEO/9R3S8iyIw0VuSlrAuELwxRULshwDWtf
        y4B7TJLPyl0RvCl65sLFFLblBcZw4v6lI0KigGg0mFZXDeVi99q3aSc7CHZw+G1jpvbDcg
        j9widh2Ih6uLGUegCaae2cVUgj40qRA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3E6713A89;
        Tue, 23 Aug 2022 08:36:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qJIaL3+RBGPnWQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 23 Aug 2022 08:36:15 +0000
Date:   Tue, 23 Aug 2022 10:36:15 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>, brauner@kernel.org,
        Christoph Hellwig <hch@infradead.org>, oleg@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, shuah@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH RESEND v2 2/2] mm: delete unused MMF_OOM_VICTIM flag
Message-ID: <YwSRf3LZ7gXwWaNN@dhcp22.suse.cz>
References: <20220531223100.510392-1-surenb@google.com>
 <20220531223100.510392-2-surenb@google.com>
 <20220822152119.96d40c884078229ee3e6b25e@linux-foundation.org>
 <CAOUHufbysRjhX_AiFirjvWCR129t4_bELd1wFQG+fBsZpzhgYw@mail.gmail.com>
 <20220822154822.366a9e4527b748cf99d98637@linux-foundation.org>
 <CAOUHufa1zc3fMWsyyz1uB6_gsgVPk1Hw_T31WzWK58QVgsQSAQ@mail.gmail.com>
 <20220822161603.9e19edfe2daaea3bf591910a@linux-foundation.org>
 <CAOUHufbyWwkOAJTD4G82sLcwE_33Yy=s4Q+gGBujwXvEBZ8iqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufbyWwkOAJTD4G82sLcwE_33Yy=s4Q+gGBujwXvEBZ8iqA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 22-08-22 17:20:17, Yu Zhao wrote:
> On Mon, Aug 22, 2022 at 5:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Mon, 22 Aug 2022 16:59:29 -0600 Yu Zhao <yuzhao@google.com> wrote:
> >
> > > > > @@ -4109,7 +4109,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned
> > > > > long start, unsigned long end,
> > > > >
> > > > >                 walk_pmd_range(&val, addr, next, args);
> > > > >
> > > > > -               if (mm_is_oom_victim(args->mm))
> > > > > +               if (test_bit(MMF_OOM_REAP_QUEUED, &args->mm->flags))
> > > > >                         return 1;
> > > > >
> > > > >                 /* a racy check to curtail the waiting time */
> > > >
> > > > Oh.  Why?  What does this change do?
> > >
> > > The MMF_OOM_REAP_QUEUED flag is similar to the deleted MMF_OOM_VICTIM
> > > flag, but it's set at a later stage during an OOM kill.
> > >
> > > When either is set, the OOM reaper is probably already freeing the
> > > memory of this mm_struct, or at least it's going to. So there is no
> > > need to dwell on it in the reclaim path, hence not about correctness.
> >
> > Thanks.  That sounds worthy of some code comments?
> 
> Will do. Thanks.

I would rather not see this abuse. You cannot really make any
assumptions about oom_reaper and how quickly it is going to free the
memory. If this is really worth it (and I have to say I doubt it) then
it should be a separate patch with numbers justifying it.

-- 
Michal Hocko
SUSE Labs
