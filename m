Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDB2415218
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Sep 2021 22:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbhIVU5J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Sep 2021 16:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbhIVU5A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Sep 2021 16:57:00 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AEEC061760
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Sep 2021 13:55:30 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i13so4250943ilm.4
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Sep 2021 13:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aW7ecSqbhvxt64O8aRVTZrLeEfv4TrofY/NqSmwmjHw=;
        b=DmJdXNCE0Nwcny13XuvXj5QJZWat2PFmP5CPAJfHFH7Q58HPTBwXGfOqlWV+8UWn6a
         0iSCRzDWeqahYzCSxROnGBaXNJEECxbay1jRcMai2r4ckP9VJc14nBtHIaOle3YrUGCX
         kTV5DcjeE9Mf0f7u1m+YhEDzqR7tDTXA8xgSB/di5CgOnuaOx5L3H7mO/CND50iDNq8x
         Yspu5AMci3sXRtVPdGZidivUlISiIWfEkrkILlfYOxK1WKJPzTqPIS32rT1PPKfL3l+T
         3L4U4Xj+1G636vd2t1gMi0qQJweUVmBXeaap/L4wvcgwPZ+qqYg6rn0+PUZ7Rl87Z8hH
         uI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aW7ecSqbhvxt64O8aRVTZrLeEfv4TrofY/NqSmwmjHw=;
        b=R5usWPpjARksx9reFdyHkH9TVDRJS/zsnFzhTRpawLNBZbMOt4kmbZNrYgp4RvA3H/
         QjB4NVea/Q3pr1VNHS1ZfwvaMCr3BHN8n//9Idij4OYlcHP5prflj20Fbj57RDXvmTn0
         +6kdq/O8wadb7i5+0wgBYqq0AmOd7UBcra68F0yw6RwxHSDVzNcgU4dRwK/eJELZRgbi
         j6HgH/nR26oKudkkU5VwDrZVgadFJ4oQOvESYzzC5uFIJ4tRqapEgZR3mYma1QsXmeCY
         q0a5SSKzEIkmptREL9ZcdiFzI8Q+jYETJedfa1Hun06Lt/nTn2weBrzhR/9evhr5JJfV
         CWMg==
X-Gm-Message-State: AOAM533eN14Zk//M51z6TYOKp6X/gJzQT2vzSHsjxKbc6hwu3QUHhUrC
        i7qOtQrFB6KV11+x8ib7V5yPCvTKHn/RIZ/5Yud09A==
X-Google-Smtp-Source: ABdhPJzJ6nlzdCA9XqAxn2VzCOP46m3faMrD4uuSH/bEsyFxe4U4fP2ZKPRkTcIZA3nHbrHwqw4kohVKUHsNhN2aFKQ=
X-Received: by 2002:a92:db0b:: with SMTP id b11mr774872iln.275.1632344129664;
 Wed, 22 Sep 2021 13:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210921163323.944352-1-axelrasmussen@google.com>
 <YUoaDr2wsW8wtk5Z@t490s> <CAJHvVcj68inRrpmw0pJq9qFc20JzG8+s7b31HkXQcsLcAJN_0Q@mail.gmail.com>
 <YUowr6phZU4v7dds@t490s> <CAJHvVcgz18qU9vjPimOhJ5YswfJnLN0tQGfsgjCh6M7ckvhfgA@mail.gmail.com>
 <YUp438W5p5VHL1Ch@t490s> <CAJHvVciZc0mpcw8OSPk71YsVzCTajY+ikymcD3+zBJKsZynYkg@mail.gmail.com>
 <YUtoyNic4Jxfv9f7@t490s>
In-Reply-To: <YUtoyNic4Jxfv9f7@t490s>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 22 Sep 2021 13:54:53 -0700
Message-ID: <CAJHvVcg6PRCK_JcYEhRqq2vPyypnc+ySOtLhtFf5GrcQjimsJQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] userfaultfd/selftests: fix feature support detection
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 22, 2021 at 10:33 AM Peter Xu <peterx@redhat.com> wrote:
>
> Hello, Axel,
>
> On Wed, Sep 22, 2021 at 10:04:03AM -0700, Axel Rasmussen wrote:
> > Thanks for discussing the design Peter. I have some ideas which might
> > make for a nicer v2; I'll massage the code a bit and see what I can
> > come up with.
>
> Sure thing.  Note again that as I don't have a strong opinion on that, feel
> free to keep it.  However if you provide v2, I'll read.
>
> [off-topic below]
>
> Another thing I probably have forgot but need your confirmation is, when you
> worked on uffd minor mode, did you explicitly disable thp, or is it allowed?

I gave a more detailed answer in the other thread, but: currently it
is allowed, but this was a bug / oversight on my part. :) THP collapse
can break the guarantees minor fault registration is trying to
provide.

I think your approach of checking the VMA flags *in
retract_page_tables specifically* is correct, and a similar thing
should be done for minor registered VMAs too.

>
> When I'm reworking the uffd-wp series, I noticed that commit e1e267c7928f
> ("khugepaged: skip collapse if uffd-wp detected", 2020-04-07) was actually
> awkward and not efficient, as we can simply lookup the vma flags for detecting
> uffd-wp enablement.  I'm preparing a patch for it to do it by checking vmas
> (and that patch will also pave the way for file-backed).
>
> Then I noticed we need similar thing for minor mode?
>
> I think the answer is yes, but I didn't see any code that explicitly handled
> thp for minor mode, do you remember?
>
> To be explicit, what if in mcontinue_atomic_pte() we get a shmem_getpage() call
> with a thp returned?  Will minor mode break?

Ah so this I am not quite as sure about.

The issue I was describing in the other thread was more about THP
collapse racing with UFFDIO_CONTINUE. E.g., collapsing after
registration has happened, but before faults have been resolved.

But there's another scenario: what if the collapse happened well
before registration happened? I *think* the existing code deals with
THPs correctly in that case, but then again I don't think our selftest
really covers this case, and it's not something I've tested in
production either (to work around the other bug, we currently
MADV_NOHUGEPAGE the area until after VM demand paging completes, and
the UFFD registration is removed), so I am not super confident this is
the case.

>
> I plan to post the khugepaged patch soon and I plan to cover minor mode too
> there, but I'm not sure whether that's enough, as the thp can be there from the
> 1st day I think, but I could have missed something.
>
> --
> Peter Xu
>
