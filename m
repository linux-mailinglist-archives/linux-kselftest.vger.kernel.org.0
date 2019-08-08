Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37DB886C5C
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2019 23:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404169AbfHHV3L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Aug 2019 17:29:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38441 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403798AbfHHV3L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Aug 2019 17:29:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id d17so124701042oth.5
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Aug 2019 14:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DzaZFkNgePDlVaXLESVKlCNNCGSeU4vRw8is94V5UdA=;
        b=KalgEU890W2v3tdxmH2d7QO3pSxS/bg4+84+pquKaYaO7PNVW3CsGLHZm1QndUrNeZ
         Kes6GlrYRGfs39qNLpaAgPALwmTqr8BKMMDL5YAXSUayczbCfJxZvC8USF5mL1RKr9Sa
         eRAaFlqu14/WjkMYqOYUArE0eXX4bUHL0XyNPJl7FJW+2B2PgpuY+2Wdnir2QC1oGtI0
         dQ41Y0PXBN3BlV82y7AA5w0ORAvn6hNVFoAThakwZ8ytbFoZkjLxwp4YHOk8JYbHk2BI
         hbfDika9QTq8x7qLymoedawkBjxAXrS54uUhsJGvcAM/+Jd3EOiC5gLCctXcL7jWI7Du
         +VHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzaZFkNgePDlVaXLESVKlCNNCGSeU4vRw8is94V5UdA=;
        b=kEbXmcCAtddA8WvCs1wlqHJcUMj+ztP1dQrc7sd+GtfIWcwNTHBwgciqcFjOZJKs+u
         GJMZ34PUp3uuCfg0Oms7p1z/UG7RVy+3g1zx7OJkGyFjYXwyLLJZHZL0NHIYPZI+bqSg
         ongM5Z8vAos2eQHyjZL1CXwtF6g1U00DSf5e2zK0wye3mdd0oVSMtks8urTuUtaWovkm
         RBSM+KQkmw6WzD/e40bfdHZ7liIA+888c5Lrjr/PvEPagkobJm55O3HQ/CUVYPzvVtDq
         5hUWl4bRH3lgXsKVXHJmlfxHLV8L4kshuzmI1HZRYqSHtpGc/iO8vKAgZrW7BYknHVjQ
         hqVg==
X-Gm-Message-State: APjAAAUYLUA4QeUG+V3EWbjX67QGItIEctugJCzmCghJA3/gWuA++hgU
        W2qjnxSzs79Z09gKroOAAzvq/2lpXWDBOCZMDHXdZA==
X-Google-Smtp-Source: APXvYqzoPupi/hlxnLQxtV5HHOP2zFDbWqQf5PEzMQj2ePkR0PAEk3t0ZRroKEvH5zKdgxYIRQ3cyRsINwSRUJIJevY=
X-Received: by 2002:aca:39c4:: with SMTP id g187mr4300457oia.8.1565299749633;
 Thu, 08 Aug 2019 14:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190808194002.226688-1-almasrymina@google.com> <528b37c6-3e7a-c6fc-a322-beecb89011a5@kernel.org>
In-Reply-To: <528b37c6-3e7a-c6fc-a322-beecb89011a5@kernel.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 8 Aug 2019 14:28:58 -0700
Message-ID: <CAHS8izPosKtqr3nJYEKz-jjG9iuTq_TPqE7yyN+2OQ5Gx8qUGw@mail.gmail.com>
Subject: Re: [RFC PATCH] hugetlbfs: Add hugetlb_cgroup reservation limits
To:     shuah <shuah@kernel.org>
Cc:     mike.kravetz@oracle.com, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 8, 2019 at 1:23 PM shuah <shuah@kernel.org> wrote:
>
> On 8/8/19 1:40 PM, Mina Almasry wrote:
> > Problem:
> > Currently tasks attempting to allocate more hugetlb memory than is available get
> > a failure at mmap/shmget time. This is thanks to Hugetlbfs Reservations [1].
> > However, if a task attempts to allocate hugetlb memory only more than its
> > hugetlb_cgroup limit allows, the kernel will allow the mmap/shmget call,
> > but will SIGBUS the task when it attempts to fault the memory in.
> >
> > We have developers interested in using hugetlb_cgroups, and they have expressed
> > dissatisfaction regarding this behavior. We'd like to improve this
> > behavior such that tasks violating the hugetlb_cgroup limits get an error on
> > mmap/shmget time, rather than getting SIGBUS'd when they try to fault
> > the excess memory in.
> >
> > The underlying problem is that today's hugetlb_cgroup accounting happens
> > at hugetlb memory *fault* time, rather than at *reservation* time.
> > Thus, enforcing the hugetlb_cgroup limit only happens at fault time, and
> > the offending task gets SIGBUS'd.
> >
> > Proposed Solution:
> > A new page counter named hugetlb.xMB.reservation_[limit|usage]_in_bytes. This
> > counter has slightly different semantics than
> > hugetlb.xMB.[limit|usage]_in_bytes:
> >
> > - While usage_in_bytes tracks all *faulted* hugetlb memory,
> > reservation_usage_in_bytes tracks all *reserved* hugetlb memory.
> >
> > - If a task attempts to reserve more memory than limit_in_bytes allows,
> > the kernel will allow it to do so. But if a task attempts to reserve
> > more memory than reservation_limit_in_bytes, the kernel will fail this
> > reservation.
> >
> > This proposal is implemented in this patch, with tests to verify
> > functionality and show the usage.
> >
> > Alternatives considered:
> > 1. A new cgroup, instead of only a new page_counter attached to
> >     the existing hugetlb_cgroup. Adding a new cgroup seemed like a lot of code
> >     duplication with hugetlb_cgroup. Keeping hugetlb related page counters under
> >     hugetlb_cgroup seemed cleaner as well.
> >
> > 2. Instead of adding a new counter, we considered adding a sysctl that modifies
> >     the behavior of hugetlb.xMB.[limit|usage]_in_bytes, to do accounting at
> >     reservation time rather than fault time. Adding a new page_counter seems
> >     better as userspace could, if it wants, choose to enforce different cgroups
> >     differently: one via limit_in_bytes, and another via
> >     reservation_limit_in_bytes. This could be very useful if you're
> >     transitioning how hugetlb memory is partitioned on your system one
> >     cgroup at a time, for example. Also, someone may find usage for both
> >     limit_in_bytes and reservation_limit_in_bytes concurrently, and this
> >     approach gives them the option to do so.
> >
> > Caveats:
> > 1. This support is implemented for cgroups-v1. I have not tried
> >     hugetlb_cgroups with cgroups v2, and AFAICT it's not supported yet.
> >     This is largely because we use cgroups-v1 for now. If required, I
> >     can add hugetlb_cgroup support to cgroups v2 in this patch or
> >     a follow up.
> > 2. Most complicated bit of this patch I believe is: where to store the
> >     pointer to the hugetlb_cgroup to uncharge at unreservation time?
> >     Normally the cgroup pointers hang off the struct page. But, with
> >     hugetlb_cgroup reservations, one task can reserve a specific page and another
> >     task may fault it in (I believe), so storing the pointer in struct
> >     page is not appropriate. Proposed approach here is to store the pointer in
> >     the resv_map. See patch for details.
> >
> > [1]: https://www.kernel.org/doc/html/latest/vm/hugetlbfs_reserv.html
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > ---
> >   include/linux/hugetlb.h                       |  10 +-
> >   include/linux/hugetlb_cgroup.h                |  19 +-
> >   mm/hugetlb.c                                  | 256 ++++++++--
> >   mm/hugetlb_cgroup.c                           | 153 +++++-
>
> Is there a reason why all these changes are in a single patch?
> I can see these split in at least 2 or 3 patches with the test
> as a separate patch.
>

Only because I was expecting feedback on the approach and alternative
approaches before an in-detail review. But, no problem; I'll break it
into smaller patches now.
> Makes it lot easier to review.
>
> thanks,
> -- Shuah
