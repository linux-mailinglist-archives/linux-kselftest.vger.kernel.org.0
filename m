Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78D3415372E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2020 19:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBESDy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Feb 2020 13:03:54 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34688 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgBESDx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Feb 2020 13:03:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so2812030otf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Feb 2020 10:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4JPeEjt7Um0jnncW2xGqU+AjtbYUDQIukn/RWGYtPE=;
        b=isUzJGTJ7f76WNj3ErRloIg+GCY6ppfYFibDbF7cYNcvcP7bRHDvBg3vVrVP41nXLs
         PD07PYxEOZQqCqG5IRE3GMbWwxGcKU2rsq68DZFR+ZvP1u/m722XWWDvErZR8seAUPJF
         lJmXNrqQKx1WThrxpU0zdZL9f3fX+c3NgvQ4MzjTE+A0k3mY8hGMgUZlOpIlYwIx9S5m
         axn1qNLQiFWRnKUgyVGwi1JRtg65lw+dXxeoT8i0E4wMdPHM/G6wLJZZno+wp2aYotgQ
         VdIXRU1IW2haNgXyxDNJLYTdTXdiBOsc/mHm/TjJWbphWVF8x+egXGz5JFiSyCeALgTl
         /q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4JPeEjt7Um0jnncW2xGqU+AjtbYUDQIukn/RWGYtPE=;
        b=N5WU6hH2dEnYrtXCcYCtph4LJjcoFIncLACme/0atfgCgZd2/TkwxBQOYkX3rTOz8M
         Gb+uOO12DLx5Yix82rvM9/Ih/YQWBLFMe01n/w2rX/+FQcAZ1YuS/7V14sw+tnHv8ag8
         lUOHXu7yp5rceeVIy3BPuhZiei8hFk0weHCCtKxkXSmhOAVQFNrNcnawkPrxMQPTmVIz
         6YILY+uoj6T/Y/sfFiKwI831JexnLKyO5lHi9ufkdtkgcIatAJSD6Syhv6LT5R+zUEKQ
         Tq5rcYGwyBXtKq9andnPI2d/sCg83XFnLTd0SSYvvA7o6/odFTXeQCbW7gBCDZM4bU7P
         3NQg==
X-Gm-Message-State: APjAAAW2N7AJXfgWduKXSvwImaUvxtc5QeCEIFkBIxk2oZJYLP1WGDa5
        7Uav6eVvfkABmC4MOe6BVK9JbjO15z+MKN8Lnws1uQ==
X-Google-Smtp-Source: APXvYqwI4QpMD2okSaeJYZlKQ7m3M3grdUPeMaD894f6WIxa4tidzyKzzE/ch4oi3Il/9yMS+FGDxJwZn2N+Plr21gI=
X-Received: by 2002:a9d:2028:: with SMTP id n37mr28112037ota.127.1580925831217;
 Wed, 05 Feb 2020 10:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-8-almasrymina@google.com> <0fa5d77c-d115-1e30-cb17-d6a48c916922@linux.ibm.com>
 <CAHS8izPobKi_w8R4pTt_UyfxzBJJYuNUw+Z6hgFfvZ1Xma__YA@mail.gmail.com>
 <CAHS8izNmSYumXpYXT1d8tAm36=-BRjXqdCDjLB6UNMwn5xhPZg@mail.gmail.com> <a980c9f7-2759-45a7-1add-89a390b79b39@linux.ibm.com>
In-Reply-To: <a980c9f7-2759-45a7-1add-89a390b79b39@linux.ibm.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 5 Feb 2020 10:03:40 -0800
Message-ID: <CAHS8izNZ+_UMEDjFXxMN9ig7QFEoJn_jLqxRTKOG7CFPvbDedg@mail.gmail.com>
Subject: Re: [PATCH v11 8/9] hugetlb_cgroup: Add hugetlb_cgroup reservation tests
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 5, 2020 at 4:42 AM Sandipan Das <sandipan@linux.ibm.com> wrote:
>
> Hi,
>
> On 05/02/20 4:03 am, Mina Almasry wrote:
> > On Tue, Feb 4, 2020 at 12:36 PM Mina Almasry <almasrymina@google.com> wrote:
> >>
> >> So the problem in this log seems to be that this log line is missing:
> >>     echo Waiting for hugetlb memory to reach size $size.
> >>
> >> The way the test works is that it starts a process that writes the
> >> hugetlb memory, then it *should* wait until the memory is written,
> >> then it should record the cgroup accounting and kill the process. It
> >> seems from your log that the wait doesn't happen, so the test
> >> continues before the background process has had time to write the
> >> memory properly. Essentially wait_for_hugetlb_memory_to_get_written()
> >> never gets called in your log.
> >>
> >> Can you try this additional attached diff on top of your changes? I
> >> attached the diff and pasted the same here, hopefully one works for
> >> you:
> >> ...
> >
> > I got my hands on a machine with 16MB default hugepage size and
> > charge_reserved_hugetlb.sh passes now after my changes. Please let me
> > know if you still run into issues.
> >
>
> With your updates, the tests are passing. Ran the tests on a ppc64 system
> that uses radix MMU (2MB hugepages) and everything passed there as well.
>

Thanks, please consider reviewing the next iteration of the patch then.

> - Sandipan
>
