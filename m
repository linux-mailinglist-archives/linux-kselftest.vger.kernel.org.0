Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D12C59CBFF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 01:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiHVXQI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 19:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiHVXQI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 19:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BE63DF1D;
        Mon, 22 Aug 2022 16:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42E3161380;
        Mon, 22 Aug 2022 23:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D602CC433D7;
        Mon, 22 Aug 2022 23:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661210164;
        bh=+30wtA6kUnNmkh32zjo0SGqqgiEX2WoQWMpGybtQXM8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pih6fV6Lq0yTYwgRO8tsGs3T3mhEF9XfpXMpZvjEnkVIwrlZttxYQ4lNpRhPRtT8Z
         MWHqevlIVR1QIwwd/5inWQ/2ZENw6zOUssx8JrXA+JHI8bFWCsiOWHcPsFTn0nhuH5
         pCwJGypOrW7EJ77t/O8SbxYYPg9I+wr3y8QyTH0I=
Date:   Mon, 22 Aug 2022 16:16:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>, brauner@kernel.org,
        hch@infradead.org, oleg@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, shuah@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH RESEND v2 2/2] mm: delete unused MMF_OOM_VICTIM flag
Message-Id: <20220822161603.9e19edfe2daaea3bf591910a@linux-foundation.org>
In-Reply-To: <CAOUHufa1zc3fMWsyyz1uB6_gsgVPk1Hw_T31WzWK58QVgsQSAQ@mail.gmail.com>
References: <20220531223100.510392-1-surenb@google.com>
        <20220531223100.510392-2-surenb@google.com>
        <20220822152119.96d40c884078229ee3e6b25e@linux-foundation.org>
        <CAOUHufbysRjhX_AiFirjvWCR129t4_bELd1wFQG+fBsZpzhgYw@mail.gmail.com>
        <20220822154822.366a9e4527b748cf99d98637@linux-foundation.org>
        <CAOUHufa1zc3fMWsyyz1uB6_gsgVPk1Hw_T31WzWK58QVgsQSAQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 22 Aug 2022 16:59:29 -0600 Yu Zhao <yuzhao@google.com> wrote:

> > > @@ -4109,7 +4109,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned
> > > long start, unsigned long end,
> > >
> > >                 walk_pmd_range(&val, addr, next, args);
> > >
> > > -               if (mm_is_oom_victim(args->mm))
> > > +               if (test_bit(MMF_OOM_REAP_QUEUED, &args->mm->flags))
> > >                         return 1;
> > >
> > >                 /* a racy check to curtail the waiting time */
> >
> > Oh.  Why?  What does this change do?
> 
> The MMF_OOM_REAP_QUEUED flag is similar to the deleted MMF_OOM_VICTIM
> flag, but it's set at a later stage during an OOM kill.
> 
> When either is set, the OOM reaper is probably already freeing the
> memory of this mm_struct, or at least it's going to. So there is no
> need to dwell on it in the reclaim path, hence not about correctness.

Thanks.  That sounds worthy of some code comments?
