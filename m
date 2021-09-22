Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F49F41537A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Sep 2021 00:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbhIVWbv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Sep 2021 18:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238297AbhIVWbv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Sep 2021 18:31:51 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DA3C061756
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Sep 2021 15:30:20 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id s20so5581011ioa.4
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Sep 2021 15:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZVmQQIFn/AGiG5dhWv6Igf7NGcQ53Z5OL98C9qRWHKg=;
        b=JP1y2Rel5ayOpQ1MHdxi2P0JuzTzGjrDWiOHJw6RnGpgetZIjkudo5xs+TCZAyg8Q0
         8jsq6SgQn62e28sJRzegap15Pnl3Db1UV7hYg7klWkFxjtlx4yoKU/qihIGuRE0yI9bG
         PZ0ZE+rOjgz+qC1mbLna3jW5oNOcvcfTRUPVJUQ+7ZL0KOsE5QLdwShlPYXbedcJHJ8/
         pG87g7s04hpigyN1r/Y6BvO9HGaKBcJWy0Tqm65d4GRcXPOlT2IBey9pgQfckb9B2TGG
         e4pnvpNAkPLg/TYHAorbMUd477HGoctYswpc0YsJlT8Rv3X9nhKdJ8X8S03mKupCV61e
         RuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZVmQQIFn/AGiG5dhWv6Igf7NGcQ53Z5OL98C9qRWHKg=;
        b=wJf7f9xGGyZ26JsDtCcCgkZ4euc5tgE2FrygicfTmxrS+a9znQei0p2SWvIMFGzL6M
         0vIix5VFU5lyBhfjJw7V2tZLrSYBzJLNCwVRMilr/cdZZYWrGm0o5VdOLsRyBASzOYIG
         oXLLVhqqwskYTNMDQCylABkW3dUIJW2FRgISs4fx1oy4FLyi5RnwvvZnMi02g/vdrdZX
         nuC2BBguFr8TXaLmHO8LqBdRHSdqrQQH9TXLDIpD85tOPMhavG3uIbzdriBKFVuKranU
         CyZL+6NijdWA9EczmBVdHnBwA8i+Igyd8tw7jD7qw+va7leyIE8eZbUJY2alLMGyu9r7
         aRSg==
X-Gm-Message-State: AOAM532HhvoddqPbugC8Qfpsq0Id9a68onUdiJ6ZPapHhFE6bCGx+ChL
        VvN7Ia4XizoosY4BN/IYNgLmH17hiUHdzzl+VGVhPg==
X-Google-Smtp-Source: ABdhPJxKU5KnplQiK3wJ89dgP2Z6r6YkDM6wqIouxA5E+GzMS6P4D6NNbrETbSLxCx5gPHjIjiIP6whaMvYs6GgW/z0=
X-Received: by 2002:a5d:950d:: with SMTP id d13mr1142651iom.138.1632349819768;
 Wed, 22 Sep 2021 15:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210921163323.944352-1-axelrasmussen@google.com>
 <YUoaDr2wsW8wtk5Z@t490s> <CAJHvVcj68inRrpmw0pJq9qFc20JzG8+s7b31HkXQcsLcAJN_0Q@mail.gmail.com>
 <YUowr6phZU4v7dds@t490s> <CAJHvVcgz18qU9vjPimOhJ5YswfJnLN0tQGfsgjCh6M7ckvhfgA@mail.gmail.com>
 <YUp438W5p5VHL1Ch@t490s> <CAJHvVciZc0mpcw8OSPk71YsVzCTajY+ikymcD3+zBJKsZynYkg@mail.gmail.com>
 <YUtoyNic4Jxfv9f7@t490s> <CAJHvVcg6PRCK_JcYEhRqq2vPyypnc+ySOtLhtFf5GrcQjimsJQ@mail.gmail.com>
 <YUulep3+YADkwlUu@t490s>
In-Reply-To: <YUulep3+YADkwlUu@t490s>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 22 Sep 2021 15:29:42 -0700
Message-ID: <CAJHvVcijQdS_hfUnasz7BhhQeiHmNu=C5j8xfX=uWsfVO9-+Eg@mail.gmail.com>
Subject: Re: [PATCH 1/3] userfaultfd/selftests: fix feature support detection
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 22, 2021 at 2:52 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Sep 22, 2021 at 01:54:53PM -0700, Axel Rasmussen wrote:
> > On Wed, Sep 22, 2021 at 10:33 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > Hello, Axel,
> > >
> > > On Wed, Sep 22, 2021 at 10:04:03AM -0700, Axel Rasmussen wrote:
> > > > Thanks for discussing the design Peter. I have some ideas which might
> > > > make for a nicer v2; I'll massage the code a bit and see what I can
> > > > come up with.
> > >
> > > Sure thing.  Note again that as I don't have a strong opinion on that, feel
> > > free to keep it.  However if you provide v2, I'll read.
> > >
> > > [off-topic below]
> > >
> > > Another thing I probably have forgot but need your confirmation is, when you
> > > worked on uffd minor mode, did you explicitly disable thp, or is it allowed?
> >
> > I gave a more detailed answer in the other thread, but: currently it
> > is allowed, but this was a bug / oversight on my part. :) THP collapse
> > can break the guarantees minor fault registration is trying to
> > provide.
>
> I've replied there:
>
> https://lore.kernel.org/linux-mm/YUueOUfoamxOvEyO@t490s/
>
> We can try to keep the discussion unified there regarding this.
>
> > But there's another scenario: what if the collapse happened well
> > before registration happened?
>
> Maybe yes, but my understanding of the current uffd-minor scenario tells me
> that this is fine too.  Meanwhile I actually have another idea regarding minor
> mode, please continue reading.
>
> Firstly, let me try to re-cap on how minor mode is used in your production
> systems: I believe there should have two processes A and B, if A is the main
> process, B could be the migration process.  B migrates pages in the background,
> while A so far should have been stopped and never ran.  When we want to start
> A, we should register A with uffd-minor upon the whole range (note: I think so
> far A does not have any pgtable mapped within uffd-minor range).  Then any page
> access of A should kick B and asking "whether it is the latest page", if yes
> then UFFDIO_CONTINUE, if no then B modifies the page, plus UFFDIO_CONTINUE
> afterwards.  Am I right above?
>
> So if that's the case, then A should have no page table at all.
>
> Then, is that a problem if the shmem file that A maps contains huge thps?  I
> think no - because UFFDIO_CONTINUE will only install small pages.
>
> Let me know if I'm understanding it right above; I'll be happy to be corrected.

Right, except that our use case is even more similar to QEMU: the code
doing UFFDIO_CONTINUE / demand paging, and the code running the vCPUs,
are in the same process (same mm) - just different threads.

>
> Actually besides this scenario, I'm also thinking of another scenario of using
> minor fault in a single process - that's mostly what QEMU is doing right now,
> as QEMU has the vcpu threads and migration thread sharing a single mm/pgtable.
> So I think it'll be great to have a new madvise(MADV_ZAP) which will tear down
> all the file-backed memory pgtables of a specific range.  I think it'll suite
> perfectly for the minor fault use case, and it can be used for other things
> too.  Let me know what you think about this idea, and whether that'll help in
> your case too (e.g., if you worry a current process A mapped huge shmem thp
> somewhere, we can use madvise(MADV_ZAP) to drop it).

Yes, this would be convenient for our implementation too. :) There are
workarounds if the feature doesn't exist, but it would be nice to
have. It's also useful for memory poisoning, I think, if the host
decides some page(s) are "bad" and wants to intercept any future guest
accesses to those page(s).

>
> > I *think* the existing code deals with THPs correctly in that case, but then
> > again I don't think our selftest really covers this case, and it's not
> > something I've tested in production either (to work around the other bug, we
> > currently MADV_NOHUGEPAGE the area until after VM demand paging completes,
> > and the UFFD registration is removed), so I am not super confident this is
> > the case.
>
> In all cases, enhancing the test program will always be welcomed.
>
> Thanks,
>
> --
> Peter Xu
>
