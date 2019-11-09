Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDE5F5C67
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2019 01:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbfKIAk6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Nov 2019 19:40:58 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36718 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730844AbfKIAkz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Nov 2019 19:40:55 -0500
Received: by mail-oi1-f195.google.com with SMTP id j7so6887221oib.3
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Nov 2019 16:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTO0G4yUHoQ2566+748dLq9N6XJTos6t1RKXW6iu8LY=;
        b=KpNhnpOOa3qcfcHYXInuUVl0BAw8G0yyb4KfBM4SGSMaep5qbx/BvvcVNeLHgEyBuC
         cgq33G3YWscje+Ru56drwaaKZWAW1jJUAjWmEKUtdcK57zh5NbvjHm+3gMGtJKviD2ZE
         eXNb93Lq1q5GlDhkbP+563K4M2Wsnp8rNd8djXnQNH9RDp4pkGqu/3Am8RgK5j1I69yy
         +Litcz+iepJW5TharNy4btNYoPFeDFV0Cc/xxio5krZ4aZT96fmk5Wby1hZdngw2JOkW
         o5P41KAZnj7z/2wPIG9444KEbw5XFqdx8u1iF2nN9H4eAqD31DOkMEzE+E0ZkYbZDdjQ
         1ldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTO0G4yUHoQ2566+748dLq9N6XJTos6t1RKXW6iu8LY=;
        b=O2TNnw4L5VA4dHwIOh6At5ZmKPvJe4ePNgfe+V5GBPY0WPND9q63E5oKM375nbxO7Q
         SqsJyLb1+e+ZnEPQ1FiB5/gsWjWuS/R2DI6qY7Z9lBUg0D0WTI3XKH4Rd1uNTNO2I1MF
         Y4HjWeRR/AhFF9RnIyZPkrGrMQa3h6vp1D9o/ztvwBfAnV4CCeB5F0NcIIQ+wYNblGKU
         UMmY5rsQSKGKe0sK+g2C6nJBh4FMam9Xdq/p9X6MGF3oIBtO6wWsQbZWAg2EoznCjrG+
         pKwkG19aKQNByffuQOMAHiZZBkShBIZUt430PJoROr8Y8wzS4XQy1HqAYNwPCp/ogLDS
         Kk6g==
X-Gm-Message-State: APjAAAV8f/OsZcID2etxc0OPVzZFXI630NtfhBX7/TDl1cH2+mxaBqb3
        H81saSgIFjnS/hlwAkk2TQphzEAdw3ehwW3scX5T0w==
X-Google-Smtp-Source: APXvYqzFG4ayJA9m/ZjeTPbIRTox5oAFY8AlkPBKYOaQszMhW9xvB2UIU21h0S1SiA5tbcofbulCmZpIu3gQ/Lkn4fE=
X-Received: by 2002:aca:1101:: with SMTP id 1mr12894333oir.103.1573260052966;
 Fri, 08 Nov 2019 16:40:52 -0800 (PST)
MIME-Version: 1.0
References: <20191030013701.39647-1-almasrymina@google.com>
 <20191030013701.39647-2-almasrymina@google.com> <9e10c273-f0ab-4173-570e-26c314b989fb@oracle.com>
 <CAHS8izMMK2cQMSmnteXA7YTFp2ZoZEm5kUwf8=+6nA+BC49XAQ@mail.gmail.com> <3f30658c-0e3d-7d5c-4de9-1526b9bac3ce@oracle.com>
In-Reply-To: <3f30658c-0e3d-7d5c-4de9-1526b9bac3ce@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 8 Nov 2019 16:40:42 -0800
Message-ID: <CAHS8izNgRZxJKgOfAkDAG9j_=TB=2v0hQyYpQQKCf8xb3rQkVg@mail.gmail.com>
Subject: Re: [PATCH v8 2/9] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 8, 2019 at 4:01 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/8/19 3:48 PM, Mina Almasry wrote:
> > On Thu, Nov 7, 2019 at 4:57 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> On 10/29/19 6:36 PM, Mina Almasry wrote:
> >>> @@ -22,27 +22,35 @@ struct hugetlb_cgroup;
> >>>   * Minimum page order trackable by hugetlb cgroup.
> >>>   * At least 3 pages are necessary for all the tracking information.
> >>>   */
> >>> -#define HUGETLB_CGROUP_MIN_ORDER     2
> >>> +#define HUGETLB_CGROUP_MIN_ORDER 3
> >>
> >> Correct me if misremembering, but I think the reson you changed this was
> >> so that you could use page[3].private.  Correct?
> >> In that case isn't page[3] the last page of an order 2 allocation?
> >> If my understanding is correct, then leave HUGETLB_CGROUP_MIN_ORDER as is
> >> and update the preceding comment to say that at least 4 pages are necessary.
> >>
> >
> > Yes, I just misunderstood what MIN_ORDER means. I'll revert the code change.
>
> But, do update the comment please.
>

Will do.

> <snip>
> >>> @@ -85,18 +89,32 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
> >>>       int idx;
> >>>
> >>>       for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
> >>> -             struct page_counter *counter = &h_cgroup->hugepage[idx];
> >>>               struct page_counter *parent = NULL;
> >>
> >> Should we perhaps rename 'parent' to 'fault_parent' to be consistent?
> >
> > Yes that makes sense; will do.
> >
> >> That makes me think if perhaps the naming in the previous patch should
> >> be more explicit.  Make the existing names explicitly contin 'fault' as
> >> the new names contain 'reservation'.
> >> Just a thought.
> >>
> >
> > You mean change the names of the actual user-facing files? I'm all for
> > better names but that would break existing users that read/write the
> > hugetlb_cgroup.2MB.usage_in_bytes/limit_in_bytes users, and so I would
> > assume is a no-go.
> >
>
> I was thinking about internal variables/definitions such as:
>
> +enum {
> + /* Tracks hugetlb memory faulted in. */
> + HUGETLB_RES_USAGE,
> + /* Tracks hugetlb memory reserved. */
> + HUGETLB_RES_RESERVATION_USAGE,
> + /* Limit for hugetlb memory faulted in. */
> + HUGETLB_RES_LIMIT,
> + /* Limit for hugetlb memory reserved. */
> + HUGETLB_RES_RESERVATION_LIMIT,
> + /* Max usage for hugetlb memory faulted in. */
> + HUGETLB_RES_MAX_USAGE,
> + /* Max usage for hugetlb memory reserved. */
> + HUGETLB_RES_RESERVATION_MAX_USAGE,
> + /* Faulted memory accounting fail count. */
> + HUGETLB_RES_FAILCNT,
> + /* Reserved memory accounting fail count. */
> + HUGETLB_RES_RESERVATION_FAILCNT,
> + HUGETLB_RES_NULL,
> + HUGETLB_RES_MAX,
> +};
>
> But, I guess the existing definitions (such as HUGETLB_RES_LIMIT) correspond
> closely to the externally visible name.  In that case, you should leave them
> as is and ignore my comment.
>
> <ship>
> >>> @@ -126,6 +144,26 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
> >>>       kfree(h_cgroup);
> >>>  }
> >>>
> >>> +static void hugetlb_cgroup_move_parent_reservation(int idx,
> >>> +                                                struct hugetlb_cgroup *h_cg)
> >>> +{
> >>> +     struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);
> >>> +
> >>> +     /* Move the reservation counters. */
> >>> +     if (!parent_hugetlb_cgroup(h_cg)) {
> >>> +             parent = root_h_cgroup;
> >>> +             /* root has no limit */
> >>> +             page_counter_charge(
> >>> +                     &root_h_cgroup->reserved_hugepage[idx],
> >>> +                     page_counter_read(
> >>> +                             hugetlb_cgroup_get_counter(h_cg, idx, true)));
> >>> +     }
> >>> +
> >>> +     /* Take the pages off the local counter */
> >>> +     page_counter_cancel(
> >>> +             hugetlb_cgroup_get_counter(h_cg, idx, true),
> >>> +             page_counter_read(hugetlb_cgroup_get_counter(h_cg, idx, true)));
> >>> +}
> >>
> >> I know next to nothing about cgroups and am just comparing this to the
> >> existing hugetlb_cgroup_move_parent() routine.  hugetlb_cgroup_move_parent
> >> updates the cgroup pointer in each page being moved.  Do we need to do
> >> something similar for reservations being moved (move pointer in reservation)?
> >>
> >
> > Oh, good catch. Yes I need to be doing that. I should probably
> > consolidate those routines so the code doesn't miss things like this.
>
> This might get a bit ugly/complicated?  Seems like you will need to examine
> all hugetlbfs inodes and vma's mapping those inodes.
>

Hmm yes on closer look it does seem like this is not straightforward.
I'll write a test that does this reparenting so I can start running
into the issue and poke for solutions. Off the top of my head, I think
maybe we can just not reparent the hugetlb reservations - the
hugetlb_cgroup stays alive until all its memory is uncharged. That
shouldn't be too bad. Today, I think memcg doesn't reparent memory
when it gets offlined.

I'll poke at this a bit and come back with suggestions, you may want
to hold off reviewing the rest of the patches until then.

> --
> Mike Kravetz
