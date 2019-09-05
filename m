Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D46FAACBE
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2019 22:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbfIEUHn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Sep 2019 16:07:43 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34150 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733184AbfIEUHm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Sep 2019 16:07:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id g128so3033437oib.1
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Sep 2019 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6k7PZuJzGWrD6r0C7js2ghL9hn4vXg63+nMGa3lc03Q=;
        b=fEPR9+4FnJ/Wuh5lAs7l0q7dg8u+29rxGa1vObZGAYxHLXpMJmWtvQm0WI7yFHpbA9
         sotwZ5fvHtmhbOOjsGD4XdRWAE+6AYb3s0hVUcTs0ij1ac4cvAJs5swoW2m9fu57OadR
         o7BrkXPdVisi/74Qj4Up0mSJKh8d9sLEmWMfy0aV0iHYtAC5JGXFYDT9kmIBY8JKcNFQ
         WvzUvTWDjYTc+t0UA+BITLbIMNqKrTmCn661eeX0fPI9t70tskNE478AIBdUgubiXhlJ
         3kroS/4vY/n8ro+zwulHYVAcsEsu6RBGxZdPvkeg1EPaxxG7BNg55LP1WNtcedAtAJlo
         YeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6k7PZuJzGWrD6r0C7js2ghL9hn4vXg63+nMGa3lc03Q=;
        b=IQolg3F/ew/e4islYRgVsbXaIy/uD5A0LHPhtoju5PDHrDU4KyuOJA6Syaz7WAMHFE
         Jutqgt5KKEDlKhD9DqNRdKZ79S2tKAafBfzHeE2Qde3Ndu5jxnr6fSaewQYflFEU50Bw
         TUIHlI9xf0agrmqFPgyF1qaT88kdZKoj6qrBbOb8raPPXjyLTVFAqQaJiaD/L1D+UOE0
         w54aM1mrJNeNDsbRPerqsI2BR8G+rvIRA7z2Kw93a07RgZOv6uXnfmnerslrdQnk68G3
         fIKULF4CGhVwyD9HcmBoOGxK6W+oMZwV5aVDJdXWG1Waa9qhPDWJPmOwg43b62KLANaO
         JXZA==
X-Gm-Message-State: APjAAAUngQXn9Z142DxpycXlkZMUevKLnsWdiw6wq0b8oplQ7zyXKx96
        UW0CNno+t1DRvVAOr5cSvtDDselPXHzRtTepY/f/OA==
X-Google-Smtp-Source: APXvYqzyY+dI8j4oksYtUG/bs6k+iiXfYPjfr4iAtUt+sQklxzS+bW2yptWP0sznueZLxU0tmkvtO8vWY8nAzmtJJEY=
X-Received: by 2002:aca:da86:: with SMTP id r128mr4287079oig.103.1567714061086;
 Thu, 05 Sep 2019 13:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190826233240.11524-1-almasrymina@google.com>
 <20190828112340.GB7466@dhcp22.suse.cz> <CAHS8izPPhPoqh-J9LJ40NJUCbgTFS60oZNuDSHmgtMQiYw72RA@mail.gmail.com>
 <20190829071807.GR28313@dhcp22.suse.cz> <cb7ebcce-05c5-3384-5632-2bbac9995c15@oracle.com>
 <e7f91a50-5957-249c-8756-25ea87c77fc4@oracle.com>
In-Reply-To: <e7f91a50-5957-249c-8756-25ea87c77fc4@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 5 Sep 2019 13:07:30 -0700
Message-ID: <CAHS8izMCA9+sY+dxHxuFgANCLD2oNznPqGYvi1+C2xOkv=7EYw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] hugetlb_cgroup: Add hugetlb_cgroup reservation limits
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@kernel.org>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 3, 2019 at 4:46 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 9/3/19 10:57 AM, Mike Kravetz wrote:
> > On 8/29/19 12:18 AM, Michal Hocko wrote:
> >> [Cc cgroups maintainers]
> >>
> >> On Wed 28-08-19 10:58:00, Mina Almasry wrote:
> >>> On Wed, Aug 28, 2019 at 4:23 AM Michal Hocko <mhocko@kernel.org> wrote:
> >>>>
> >>>> On Mon 26-08-19 16:32:34, Mina Almasry wrote:
> >>>>>  mm/hugetlb.c                                  | 493 ++++++++++++------
> >>>>>  mm/hugetlb_cgroup.c                           | 187 +++++--
> >>>>
> >>>> This is a lot of changes to an already subtle code which hugetlb
> >>>> reservations undoubly are.
> >>>
> >>> For what it's worth, I think this patch series is a net decrease in
> >>> the complexity of the reservation code, especially the region_*
> >>> functions, which is where a lot of the complexity lies. I removed the
> >>> race between region_del and region_{add|chg}, refactored the main
> >>> logic into smaller code, moved common code to helpers and deleted the
> >>> duplicates, and finally added lots of comments to the hard to
> >>> understand pieces. I hope that when folks review the changes they will
> >>> see that! :)
> >>
> >> Post those improvements as standalone patches and sell them as
> >> improvements. We can talk about the net additional complexity of the
> >> controller much easier then.
> >
> > All such changes appear to be in patch 4 of this series.  The commit message
> > says "region_add() and region_chg() are heavily refactored to in this commit
> > to make the code easier to understand and remove duplication.".  However, the
> > modifications were also added to accommodate the new cgroup reservation
> > accounting.  I think it would be helpful to explain why the existing code does
> > not work with the new accounting.  For example, one change is because
> > "existing code coalesces resv_map entries for shared mappings.  new cgroup
> > accounting requires that resv_map entries be kept separate for proper
> > uncharging."
> >
> > I am starting to review the changes, but it would help if there was a high
> > level description.  I also like Michal's idea of calling out the region_*
> > changes separately.  If not a standalone patch, at least the first patch of
> > the series.  This new code will be exercised even if cgroup reservation
> > accounting not enabled, so it is very important than no subtle regressions
> > be introduced.
>
> While looking at the region_* changes, I started thinking about this no
> coalesce change for shared mappings which I think is necessary.  Am I
> mistaken, or is this a requirement?
>

No coalesce is a requirement, yes. The idea is that task A can reseve
range [0-1], and task B can reserve range [1-2]. We want the code to
put in 2 regions:

1. [0-1], with cgroup information that points to task A's cgroup.
2. [1-2], with cgroup information that points to task B's cgroup.

If coalescing is happening, then you end up with one region [0-2] with
cgroup information for one of those cgroups, and someone gets
uncharged wrong when the reservation is freed.

Technically we can still coalesce if the cgroup information is the
same and I can do that, but the region_* code becomes more
complicated, and you mentioned on an earlier patchset that you were
concerned with how complicated the region_* functions are as is.

> If it is a requirement, then think about some of the possible scenarios
> such as:
> - There is a hugetlbfs file of size 10 huge pages.
> - Task A has reservations for pages at offset 1 3 5 7 and 9
> - Task B then mmaps the entire file which should result in reservations
>   at 0 2 4 6 and 8.
> - region_chg will return 5, but will also need to allocate 5 resv_map
>   entries for the subsequent region_add which can not fail.  Correct?
>   The code does not appear to handle this.
>

I thought the code did handle this. region_chg calls
allocate_enough_cache_for_range_and_lock(), which in this scenario
will put 5 entries in resv_map->region_cache. region_add will use
these 5 region_cache entries to do its business.

I'll add a test in my suite to test this case to make sure.

> BTW, this series will BUG when running libhugetlbfs test suite.  It will
> hit this in resv_map_release().
>
>         VM_BUG_ON(resv_map->adds_in_progress);
>

Sorry about that, I've been having trouble running the libhugetlbfs
tests, but I'm still on it. I'll get to the bottom of this by next
patch series.

> --
> Mike Kravetz
