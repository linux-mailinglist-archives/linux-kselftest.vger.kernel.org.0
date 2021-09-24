Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C727A417C51
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Sep 2021 22:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347021AbhIXUYH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Sep 2021 16:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345900AbhIXUYG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Sep 2021 16:24:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E45C061571
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Sep 2021 13:22:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i24so14935197wrc.9
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Sep 2021 13:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P6UjX46EgO1JdvaA1S99BM8bVjWyLM+0KRRhsNVfqrc=;
        b=hNilYYi9DfGN1Dx6/MtN058s8ZQ30CNP0PCqpqvXCmeNiuOhFNazMI2RkNfZif6nAu
         rGIBi3W2uxP6WNpia+1cWs6TX03mE6nmeXC+3L1ns31tp1llFuebuAA/v7XkUejdwrwh
         V845bcchNr9ZOJjCFBOLaVkMIQCvhHcHNVA0BWSfr3cb4pSvlkXIrj0zYGbj6eBeE3Pt
         zGHYlYYrUxJJNdVUDPgyAaFeOV7d6ouoZgJXW5xwoMszebmsbXDdOg4LAWDzhss5Tnm2
         r1TtraxcgioXJZ3Y+EpqAFcp2mmQi0NNeJNQ+tXpLR/y+DgFSipRMQNc/YZLV9BYxfj9
         ye/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6UjX46EgO1JdvaA1S99BM8bVjWyLM+0KRRhsNVfqrc=;
        b=Hfcd4Z+Ie8HQd2k8v4JLNh6n8QWdpzwx3IWO5jptY26WqFgkbkycUpuYPeLCEu0Dcr
         snrB/VxNCSKsQuCf1sBs12EAOxKZOQqyNm/duiGLcB8xYgCrmka8cGm4buhicXd2fWLG
         6sj2jnxCqevZhG21N6gc9IgRDWzQ2PWKokZuxNwx27/n/AHXuR9Fr+51Tr8efeRdcnXb
         CvX6UFzgMgjc8TBE85FXpJ4wA0QBZoFUMmzkpMM0VmTTWaibnjBPNsT5OGlJMc9R3aK0
         I2xdw7Fj0ngL73ZbQV9A/ZHs2TRza2926W1O0ebijL4rel+3MfDiPswuNEsHIp66dMxm
         AzvQ==
X-Gm-Message-State: AOAM5306vpzNRlKeVssD/ijbZ8TFREF9KuTtg5HMN04EJ5dLlvnV9Qxq
        5cK8WLSmuE28UNR/6vnRxqkuFzxvfBJZr+MgahYhPw==
X-Google-Smtp-Source: ABdhPJwmZTsxjXTVscp7BYpW00OnOGQJJcYUcorRFaAk4dC1Hn0zxo5UNELpTtJfZBek6h0ROSX+WX77q3jllKbjarY=
X-Received: by 2002:adf:f48e:: with SMTP id l14mr13662271wro.109.1632514951618;
 Fri, 24 Sep 2021 13:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJHvVcgz18qU9vjPimOhJ5YswfJnLN0tQGfsgjCh6M7ckvhfgA@mail.gmail.com>
 <YUp438W5p5VHL1Ch@t490s> <CAJHvVciZc0mpcw8OSPk71YsVzCTajY+ikymcD3+zBJKsZynYkg@mail.gmail.com>
 <YUtoyNic4Jxfv9f7@t490s> <CAJHvVcg6PRCK_JcYEhRqq2vPyypnc+ySOtLhtFf5GrcQjimsJQ@mail.gmail.com>
 <YUulep3+YADkwlUu@t490s> <CAJHvVcijQdS_hfUnasz7BhhQeiHmNu=C5j8xfX=uWsfVO9-+Eg@mail.gmail.com>
 <YUvBEXV1Qs5wC+Jc@t490s> <CADrL8HUhV9ag6n3=MT2pNhtfrp8xH1Y-9zgispubzLy0ye6frw@mail.gmail.com>
 <CAPcxDJ6E3c2gcnJ8pDeQidf-yHDP7S=Knah_b3hy+FL1kOObqA@mail.gmail.com> <YU4wgSmStmkxxSt5@t490s>
In-Reply-To: <YU4wgSmStmkxxSt5@t490s>
From:   Jue Wang <juew@google.com>
Date:   Fri, 24 Sep 2021 13:22:19 -0700
Message-ID: <CAPcxDJ41OrRk5AyYK+3XtMB17ycuw3g3PR4njrZQfXnbQtsZfA@mail.gmail.com>
Subject: Re: [PATCH 1/3] userfaultfd/selftests: fix feature support detection
To:     Peter Xu <peterx@redhat.com>
Cc:     James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 24, 2021 at 1:09 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Sep 22, 2021 at 10:43:40PM -0700, Jue Wang wrote:
>
> [...]
>
> > > > Could I know what's the workaround?  Normally if the workaround works solidly,
> > > > then there's less need to introduce a kernel interface for that.  Otherwise I'm
> > > > glad to look into such a formal proposal.
> > >
> > > The workaround is, for the region that you want to zap, run through
> > > this sequence of syscalls: mumap, mmap, and re-register with
> > > userfaultfd if it was registered before. If we're using tmpfs, we can
> > > use madvise(DONTNEED) instead, but this is kind of an abuse of the
> > > API. I don't think there's a guarantee that the PTEs will get zapped,
> > > but currently they will always get zapped if we're using tmpfs. I
> > > really like the idea of adding a new madvise() mode that is guaranteed
> > > to zap the PTEs.
>
> I see.
>
> > >
> > > >
> > > > > It's also useful for memory poisoning, I think, if the host
> > > > > decides some page(s) are "bad" and wants to intercept any future guest
> > > > > accesses to those page(s).
> > > >
> > > > Curious: isn't hwpoison information come from MCEs; or say, host kernel side?
> > > > Then I thought the host kernel will have full control of it already.
> > > >
> > > > Or there's other way that the host can try to detect some pages are going to be
> > > > rotten?  So the userspace can do something before the kernel handles those
> > > > exceptions?
> > >
> > > Here's a general idea of how we would like to use userfaultfd to support MPR:
> > >
> > > If a guest accesses a poisoned page for the first time, we will get an
> > > MCE through the host kernel and send an MCE to the guest. The guest
> > > will now no longer be able to access this page, and we have to enforce
> > > this. After a live migration, the pages that were poisoned before
> > > probably won't still be poisoned (from the host's perspective), so we
> > > can't rely on the host kernel's MCE handling path. This is where
> > > userfaultfd and this new madvise mode come in: we can just
> > > madvise(MADV_ZAP) the poisoned page(s) on the target during a
> > > migration. Now all accesses will be routed to the VMM and we can
> > > inject an MCE. We don't *need* the new madvise mode, as we can also
> > > use fallocate(PUNCH_HOLE) (works for tmpfs and hugetlbfs), but it
> > > would be more convenient if we didn't have to use fallocate.
> > >
> > > Jue Wang can provide more context here, so I've cc'd him. There may be
> > > some things I'm wrong about, so Jue feel free to correct me.
> > >
> > James is right.
> >
> > The page is marked PG_HWPoison in the source VM host's kernel. The need
> > of intercepting guest accesses to it exist on the target VM host, where
> > the same physical page is no longer poisoned.
> >
> > On the target host, the hypervisor needs to intercept all guest accesses
> > to pages poisoned from the source VM host.
>
> Thanks for these information, James, Jue, Axel.  I'm not familiar with memory
> failures yet, so please bare with me with a few naive questions.
>
> So now I can undertand that hw-poisonsed pages on src host do not mean these
> pages will be hw-poisoned on dest host too, but I may have missed the reason on
> why dest host needs to trap it with pgtable removed.
>
> AFAIU after pages got hw-poisoned on src, and after vmm injects MCEs into the
> guest, the guest shouldn't be accessing these pages any more, am I right?  Then

This is also our hope for the guest to behave but there is no guarantee on
guest behavior.

The goal here is to have the hypervisor provide consistent behavior
aligned to native
hardware, i.e., a guest page with "memory errors" stay persistently in
that state
no matter on source or target.

> after migration completes, IIUC the guest shouldn't be accessing these pages
> too.  My current understanding is, instead of trapping these pages on dest, we
> should just (somehow, which I have no real idea...) un-hw-poison these pages
> after migration because these pages are very possibly normal pages there.  When
> there's real hw-poisoned pages reported on dst host, we should re-inject MCE
> errors to guest with another set of pages.
>
> Could you tell me where did I miss?
>
> Thanks,
>
> --
> Peter Xu
>
