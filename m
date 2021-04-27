Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E5F36CC49
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Apr 2021 22:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbhD0Uai (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Apr 2021 16:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbhD0Uah (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Apr 2021 16:30:37 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB04C06175F
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Apr 2021 13:29:52 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id l21so17692219iob.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Apr 2021 13:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WzJWSS3LQ6tF0DgK++1lrPiC81dYzxiPck8oPTQIuQM=;
        b=gbNFD7FoTA7n8IPPyw2KHOylIt8tzudj0Lpkdgu7mzsab/vYDoCX8VQ2+pW2PafQbp
         JxR1XGRxzePWZg0k/lL8HrzfJX1SnDe5TpFzpooVXmvhCVtquqkAHffLdiPX/s4G6iTl
         9ONp86hzSzE7P1p3W+LL5QOZ/CQ3Ze/kT8jGK0OwsPFtA9fF3Z8j93LJX1jAzWtovcFo
         wraUFwADLhrGc/ZRhKyMAE1vzcpZTFlKnS3wTfzLUX/OyuUTfXrJrtKvBZoyZWbDyJDM
         IGj8vWkjpL1dSCRy2ZHIBkB+wFNwbbCdZZCFIG8416YkWzweIhGhpxBxMpCiUWXMipAc
         5UdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzJWSS3LQ6tF0DgK++1lrPiC81dYzxiPck8oPTQIuQM=;
        b=SzNuovWHeFlR1cn6o3tbhv3SG5PZuBw9Ql2XewCv0Uj5BYqcKY9Lm6ecQwvlYqiIrY
         duegNlNM/FxhTRlYzmjDTIQHVI0M5H+csIt+1YfGeYCEk82axEvv8K0YlRUUJcnCW/cq
         ACfnMt9bn9VjqJAXQKkevsDgDugFJxA3IX4+IjKKBHkRfBWUlF9HI+jHeG9xA/C1xdXk
         aRHFck7gYyfDNCGfqjfaQSzeJ089jrafI509k6UqdnuVI9rJL8nF7SBXVX64NzAiO2GV
         F0dci2ImuLJI6aTEYoc0rk/lDfUvF2ox/lP66eCc3jo68/mKJiJgxOU5Bmckty7TPkKV
         dwFg==
X-Gm-Message-State: AOAM532pKz5Oho2JSP2uWLqOHdN/eHQ7/HY+oO1sjd740PU/XtRryy5o
        STFFuHYbS6NQ+GPQspj8Nc6knLGV82MaBVJ85PKOGw==
X-Google-Smtp-Source: ABdhPJz7iNqaf7JHZFiCQ426WqlOiaRzxCMbG8Vk0qKa7/LDNoylh0febweO3CgkD2dvFe5U0B95hMpS/QZFyMb3tpE=
X-Received: by 2002:a05:6638:3387:: with SMTP id h7mr12471126jav.96.1619555391579;
 Tue, 27 Apr 2021 13:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com>
 <20210420220804.486803-4-axelrasmussen@google.com> <alpine.LSU.2.11.2104261906390.2998@eggly.anvils>
 <20210427155414.GB6820@xz-x1> <CAJHvVciNrE_F0B0nu=Mib6LhcFhL8+qgO-yiKNsJuBjOMkn5+g@mail.gmail.com>
 <20210427180314.GD6820@xz-x1>
In-Reply-To: <20210427180314.GD6820@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 27 Apr 2021 13:29:14 -0700
Message-ID: <CAJHvVciMU=TDGxArtEQSq3n5DCLfYNWh7bVX_8dQL_dht4Q73w@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] userfaultfd/shmem: support UFFDIO_CONTINUE for shmem
To:     Peter Xu <peterx@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 27, 2021 at 11:03 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Apr 27, 2021 at 09:57:16AM -0700, Axel Rasmussen wrote:
> > I'd prefer to keep them separate, as they are not tiny patches (they
> > are roughly +200/-150 each). And, they really are quite independent -
> > at least in the sense that I can reorder them via rebase with no
> > conflicts, and the code builds at each commit in either orientation. I
> > think this implies they're easier to review separately, rather than
> > squashed.
> >
> > I don't have a strong feeling about the order. I slightly prefer
> > swapping them compared to this v4 series: first introduce minor
> > faults, then introduce CONTINUE.
> >
> > Since Peter also has no strong opinion, and Hugh it sounds like you
> > prefer it the other way around, I'll swap them as we had in some
> > previous version of this series: first introduce minor faults, then
> > introduce CONTINUE.
>
> Yes I have no strong opinion, but that's probably the least I prefer. :-)
>
> Because you'll declare UFFD_FEATURE_MINOR_SHMEM and enable this feature without
> the feature being completely implemented (without UFFDIO_CONTINUE, it's not
> complete since no one will be able to resolve that minor fault).
>
> Not a big deal anyway, but since we're at it... Basically I think three things
> to do for minor shmem support:
>
>   (1) UFFDIO_CONTINUE (resolving path)
>   (2) Handle fault path for shmem minor fault (faulting path)
>   (3) Enablement of UFFD_FEATURE_MINOR_SHMEM (from which point, user can detect
>       and enable it)
>
> I have no preference on how you'd like to merge these steps (right now you did
> 1 first, then 2+3 later; or as Hugh suggested do 1+2+3 together), but I'd still
> hope item 3 should always be the last, if possible...

In that case, I'll split the patch which adds the faulting path in
two: add the faulting path hook and registration mode, and then in a
separate commit advertise the feature flag as available.

Then I'll order them like so, which I think is the order Hugh finds
more natural:
1. MInor fault registration / faulting path
2. CONTINUE ioctl to resolve the faults
3. Advertise the feature as supported

Sound okay?

>
> Thanks,
>
> --
> Peter Xu
>
