Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D951411E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 20:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgAQTex (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 14:34:53 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42274 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgAQTew (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 14:34:52 -0500
Received: by mail-oi1-f193.google.com with SMTP id 18so23207049oin.9
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2020 11:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnbjoT0j5ag9BS3W7d99gmYHDerGz9fZIduxI8d9DlM=;
        b=TT8zNjpuzdDlDWtxUF3ROPfakHa88TVeTCCzR5vCXgxUY7gnjtDdV908bvnyE5y4oV
         QU36Uh70B8zBcLbEC5WsV9OQuSgknaM4MnZ+6jDRyDTKzq1HngpAdAAs3mElPkgX1Ngs
         w8RxWNVZZmLjGd/pbBFQ57NF0JHpuxd7a1wSLqAAJwqSwurny5s+HaCNXAxlSd2TrGbE
         I0HJnlRsjj6jLQu5Cu7qeoUYEz1c4KM83fzEb63Qt4ALXNdDhAqG60fYhmckugqonIpN
         Q31HLAuMmqxdrdOBjnJmAuE2XH93asNdBTd9rXjxonqLYa1bomCyyydoau0rPmn4pocx
         0aNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnbjoT0j5ag9BS3W7d99gmYHDerGz9fZIduxI8d9DlM=;
        b=TQhmfClr9qkPgR0tBd0f/Vu2xOqIYM2lnpixi9X0nHOIore92zbbvgkY6T1/Hie44L
         iR2FkIQdXGklG5zsz/Qj2usmKI+dG0itpThC5QiD34mXfuIT1wHpz3IE50fvWVnKKnWL
         X8WQosrQvJQ3Y+kBVwaaffhmSLVko85pqrHPcv/lGhXzV7r6s/zIPWVHiqhkJGvMLzF1
         Kxj8f5/YHmLcJkGF3TDRiarHnCB8uXEF28C7UUK7zE1peyEJ/9bma2srutANChFz7O6E
         GR+BWXtqT3QXhF8+JpZz9T3wiwmQK+hVtQTf3Ks9RWx4r3cx/e98uUAVMc/YpXu/s5ex
         reLw==
X-Gm-Message-State: APjAAAXWY4AwxaCdg3FdFRLEVaSZVkzKI1vzytsw4HgU/8L3jDR0mJss
        mGIPKlOJ/il3/Wy7wfrucH8N8VoTQVOEi07c+KVEYg==
X-Google-Smtp-Source: APXvYqxLvi0jqyJq4c6XDMG40T2xm371zP61sFys+Wn5Kv1PErBnDGHtInooR+MBkC+FWhdeiq5hF2mMsauFR8qAt28=
X-Received: by 2002:aca:ed57:: with SMTP id l84mr4713560oih.8.1579289689665;
 Fri, 17 Jan 2020 11:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20200115012651.228058-1-almasrymina@google.com>
 <20200115012651.228058-2-almasrymina@google.com> <7e1d2c5f-3b07-4d16-9e1b-bd89d25e7fb3@oracle.com>
In-Reply-To: <7e1d2c5f-3b07-4d16-9e1b-bd89d25e7fb3@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 17 Jan 2020 11:34:38 -0800
Message-ID: <CAHS8izMRrOOMV3v3gEuFHcX-YfQ5YOywGFu+K4-9zMXrAGFYbQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/8] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, shuah <shuah@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 17, 2020 at 11:26 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/14/20 5:26 PM, Mina Almasry wrote:
> > Augments hugetlb_cgroup_charge_cgroup to be able to charge hugetlb
> > usage or hugetlb reservation counter.
> >
> > Adds a new interface to uncharge a hugetlb_cgroup counter via
> > hugetlb_cgroup_uncharge_counter.
> >
> > Integrates the counter with hugetlb_cgroup, via hugetlb_cgroup_init,
> > hugetlb_cgroup_have_usage, and hugetlb_cgroup_css_offline.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > Changes in v10:
> > - Added missing VM_BUG_ON
>
> Thanks for addressing my comments.
> I see that patch 8 was updated to address David's comments.  I will also
> review patch 8 later.
>
> I am again requesting that someone with more cgroup experience comment on
> this patch.  I do not have enough experience to determine if the code to
> not reparent/zombie cgroup is correct.
>

Thank you very much for your continued reviews and I'm sorry I'm
having so much trouble getting anyone with cgroup experience to look
deeply into this. My guess is that it's not very active feature and
the patchseries is long and complex so folks are not interested.
Nevertheless I'm continually poking David and Shakeel and they will
hopefully continue to look into this.

FWIW, I have a test for repartenting/counting zombies and the tests at
least don't uncover any problems.

> For now,
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> while waiting for cgroup comments.
>
> --
> Mike Kravetz
