Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA9F1166B9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2020 01:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgBUA2P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Feb 2020 19:28:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbgBUA2P (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Feb 2020 19:28:15 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E0E0206DB;
        Fri, 21 Feb 2020 00:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582244894;
        bh=iy0LlJf0YHN6ZiB0CWT2PCAoHpieaL2qiC0LKqJ6REI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qXQ/8DH62yQvvP+ax4QYdXSpzMD5FkJ2DlWZDkJKgFg8dybzdwDhQwZsD9md/tPjD
         17v/H6SMbm/TbAi6jT0/0YUTYrsQ/O8vp5l8HO5qA7JxT2e5ID4FhAYVuQonqCfxC3
         t5P3D5LiwKfs4u2qShYXa40c00d9UCQ4ULRHbxyA=
Date:   Thu, 20 Feb 2020 16:28:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation
 counter
Message-Id: <20200220162813.aea8a14fe050473b73440323@linux-foundation.org>
In-Reply-To: <CAHS8izN_FJektipBwiLsCO8ysMTM7k=CR_k3OV7+_y0ZbrGw+A@mail.gmail.com>
References: <20200211213128.73302-1-almasrymina@google.com>
        <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
        <CAHS8izPUFQWq3PzhhRzp7u11173_-cmRkNuQWEswS51Xz6ZM0Q@mail.gmail.com>
        <20200219130648.83e6810848774c6fd649c445@linux-foundation.org>
        <CAHS8izN_FJektipBwiLsCO8ysMTM7k=CR_k3OV7+_y0ZbrGw+A@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 20 Feb 2020 11:22:58 -0800 Mina Almasry <almasrymina@google.com> wrote:

> On Wed, Feb 19, 2020 at 1:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 19 Feb 2020 11:05:41 -0800 Mina Almasry <almasrymina@google.com> wrote:
> >
> > > On Tue, Feb 11, 2020 at 3:19 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Tue, 11 Feb 2020 13:31:20 -0800 Mina Almasry <almasrymina@google.com> wrote:
> > > >
> > > > > These counters will track hugetlb reservations rather than hugetlb
> > > > > memory faulted in. This patch only adds the counter, following patches
> > > > > add the charging and uncharging of the counter.
> > > >
> > > > We're still pretty thin on review here, but as it's v12 and Mike
> > > > appears to be signed up to look at this work, I'll add them to -next to
> > > > help move things forward.
> > > >
> > >
> > > Hi Andrew,
> > >
> > > Since the patches were merged into -next there have been build fixes
> > > and test fixes and some review comments. Would you like me to submit
> > > *new* patches to address these, or would you like me to squash the
> > > fixes into my existing patch series and submit another iteration of
> > > the patch series?
> >
> > What you did worked OK ;)
> >
> > Please check the end result next time I release a kernel.
> 
> Thanks Andrew! Things definitely moved along after the patchseries got
> into -next :D
> 
> By my count I think all my patches outside of the tests patch have
> been acked or reviewed. When you have a chance I have a couple of
> questions:
> 
> 1. For the non-tests patch, anything pending on those preventing
> eventual submission to linus's tree?
> 2. For the tests patch, I only have a Tested-by from Sandipan. Is that
> good enough? If the worst comes to worst and I don't get a review on
> that patch I would rather (if possible) that 'tests' patch can be
> dropped while I nag folks for a review, rather than block submission
> of the entire patch series. I ask because it's been out for review for
> some time and it's the one I got least discussion on so I'm not sure
> I'll have a review by the time it's needed.
> 

It all looks pretty good and I expect we can get everything into
5.7-rc1, unless some issues pop up.

It's unclear to me whether
http://lkml.kernel.org/r/CAHS8izOTipknnYaKz=FdzL-7yW-Z61ck1yPnYWixyMSJuTUYLQ@mail.gmail.com
was going to result in an update?


