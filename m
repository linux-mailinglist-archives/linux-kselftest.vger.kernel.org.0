Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8869F8F76A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2019 01:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387425AbfHOXJL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Aug 2019 19:09:11 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38132 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfHOXJK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Aug 2019 19:09:10 -0400
Received: by mail-oi1-f193.google.com with SMTP id p124so3484323oig.5
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2019 16:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pubd6f1tcZHifquOcrj8xQglVw6DCxjyDkP+6D1UxS0=;
        b=JkRFzeRfQlWs+Pyjcat2Ssn+D8XoJ1Uow7Ah+iXZrqxiUrkwD5e301ji+FAnkgr3Mi
         zQyExXAXO0ueRB6RKdinbV4d+uew/w3RGB1LZBzLVeWxJU1P+s7GT8dtzEEfX1l490DR
         5RRcWZMODHPXuCDS97ebyvj1t4/x10SAdNswXg5uL1xvkwb/77E/VvebPuUbzUAp8mcW
         aLfr2eozWfE9Hz1Szd5c8U8Whe5ZubXfCrM+YBMFJxGap3xnbKhQgHjzjQPnn+klku5l
         VVvGmdO7O1JLyLjJFvUB4dACVRZaZImub65FzL/miuQuE4GIHHIO8W0NT4Y7VsAstxOL
         5Ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pubd6f1tcZHifquOcrj8xQglVw6DCxjyDkP+6D1UxS0=;
        b=HsG43yPERzrSagAYveXzkHThXLPjUKQruJ+Xfu18AF0wie8SwLmcAzL5ql8eN2bgAo
         yEfvPDAkPRcPbK7Dbgn0la5we/no3frfxkExGC4eJZ4srM+adnyrOBReD15YoejK1Uwd
         b7QQnSNRZmoYLTRJnguyZ988mmdmkmQ9DhOrtdScoIRlz0bgC90FwHMj/jo1MRkeUtCy
         C/wakhybJnx67uVAEMc+pFFkK+MKRKOPxyt7I2YoUxDm8Vo5AEQImZNck3KGeAClVjmY
         j5vhw0RsJHLU80GV1kBm0t2elWW6LgrZ2UT8D3znymlmcwfLI8wlEgz6eWj2mmbQ7a6Y
         3lpg==
X-Gm-Message-State: APjAAAVeURupsIU3flIHCr0LzY6qUXHbhln3HGJndNy0mkLfaegrdtYT
        lNFGLRpFG8nJ80yI1iC1iKROGMIsO3Td/5QpEg4o0Q==
X-Google-Smtp-Source: APXvYqxN0uUAEJhEjtJzjXxnKNYpPNiK/F/NzefhYeJ0Iv6GCu8lETSML8m0YWqPezXLufCngXQA/Okrum/me97k7VQ=
X-Received: by 2002:aca:cfcb:: with SMTP id f194mr3347602oig.103.1565910549591;
 Thu, 15 Aug 2019 16:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190808231340.53601-1-almasrymina@google.com>
 <20190808231340.53601-5-almasrymina@google.com> <47cfc50d-bea3-0247-247e-888d2942f134@oracle.com>
In-Reply-To: <47cfc50d-bea3-0247-247e-888d2942f134@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 15 Aug 2019 16:08:57 -0700
Message-ID: <CAHS8izNAZLQnHi6qXiO_efgSs1x2NOXKOKy7rZf+oF-8+hq=YQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] hugetlb_cgroup: Add accounting for shared mappings
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 13, 2019 at 4:54 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 8/8/19 4:13 PM, Mina Almasry wrote:
> > For shared mappings, the pointer to the hugetlb_cgroup to uncharge lives
> > in the resv_map entries, in file_region->reservation_counter.
> >
> > When a file_region entry is added to the resv_map via region_add, we
> > also charge the appropriate hugetlb_cgroup and put the pointer to that
> > in file_region->reservation_counter. This is slightly delicate since we
> > need to not modify the resv_map until we know that charging the
> > reservation has succeeded. If charging doesn't succeed, we report the
> > error to the caller, so that the kernel fails the reservation.
>
> I wish we did not need to modify these region_() routines as they are
> already difficult to understand.  However, I see no other way with the
> desired semantics.
>
> > On region_del, which is when the hugetlb memory is unreserved, we delete
> > the file_region entry in the resv_map, but also uncharge the
> > file_region->reservation_counter.
> >
> > ---
> >  mm/hugetlb.c | 208 +++++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 170 insertions(+), 38 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 235996aef6618..d76e3137110ab 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -242,8 +242,72 @@ struct file_region {
> >       struct list_head link;
> >       long from;
> >       long to;
> > +#ifdef CONFIG_CGROUP_HUGETLB
> > +     /*
> > +      * On shared mappings, each reserved region appears as a struct
> > +      * file_region in resv_map. These fields hold the info needed to
> > +      * uncharge each reservation.
> > +      */
> > +     struct page_counter *reservation_counter;
> > +     unsigned long pages_per_hpage;
> > +#endif
> >  };
> >
> > +/* Must be called with resv->lock held. Calling this with dry_run == true will
> > + * count the number of pages added but will not modify the linked list.
> > + */
> > +static long consume_regions_we_overlap_with(struct file_region *rg,
> > +             struct list_head *head, long f, long *t,
> > +             struct hugetlb_cgroup *h_cg,
> > +             struct hstate *h,
> > +             bool dry_run)
> > +{
> > +     long add = 0;
> > +     struct file_region *trg = NULL, *nrg = NULL;
> > +
> > +     /* Consume any regions we now overlap with. */
> > +     nrg = rg;
> > +     list_for_each_entry_safe(rg, trg, rg->link.prev, link) {
> > +             if (&rg->link == head)
> > +                     break;
> > +             if (rg->from > *t)
> > +                     break;
> > +
> > +             /* If this area reaches higher then extend our area to
> > +              * include it completely.  If this is not the first area
> > +              * which we intend to reuse, free it.
> > +              */
> > +             if (rg->to > *t)
> > +                     *t = rg->to;
> > +             if (rg != nrg) {
> > +                     /* Decrement return value by the deleted range.
> > +                      * Another range will span this area so that by
> > +                      * end of routine add will be >= zero
> > +                      */
> > +                     add -= (rg->to - rg->from);
> > +                     if (!dry_run) {
> > +                             list_del(&rg->link);
> > +                             kfree(rg);
>
> Is it possible that the region struct we are deleting pointed to
> a reservation_counter?  Perhaps even for another cgroup?
> Just concerned with the way regions are coalesced that we may be
> deleting counters.
>

Yep, that needs to be handled I think. Thanks for catching!


> --
> Mike Kravetz
