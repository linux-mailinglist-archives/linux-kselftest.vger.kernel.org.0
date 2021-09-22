Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBD4414EB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Sep 2021 19:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhIVRGK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Sep 2021 13:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbhIVRGK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Sep 2021 13:06:10 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114D9C061756
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Sep 2021 10:04:40 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id b6so3575904ilv.0
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Sep 2021 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Ux03cG5hBPJ9MQ2bUemW8lwVWLAct1mE8axUh1mK6k=;
        b=Z6U/J9MOXmwaNV+2zF5ntuLypdkphil3PjK5ro65TRqO89DHh8u1ndKkc8KqLah1rV
         v99nt+Du+gWUFK0sn9LyHdJiRBylTtBEBq6YeeXbLq4yaXDOUH1CLuZeqNoiFSjbnB4I
         mr8TRJoZ+L1Jol1L2QB1qQqlkv1/Y6CoiYPjicVRS3m8qBWdhjEIR2WJzya1A39m1blW
         ++icpE8GBziVH0LzlbpOdDup4TVgTz8adYh6IxwQ88C2YONiBD0QLxo4ZQalU17Bx4bd
         30O6XguWTD14tRIKez+dPQyOOihhIiUVm6bue5FEKlUHLcoaHDlzdgqHoaZ3bFGlD5mo
         EDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Ux03cG5hBPJ9MQ2bUemW8lwVWLAct1mE8axUh1mK6k=;
        b=YINh0n139xAgkuJOXfOofgMIAsm1BHR/ST3uPQ5H0x6F3Y9h3rwHoAX6LiZRVx5LjJ
         m/VtgDTqWuMs2kdNLEg7XSwMnbod3yR9zkYBjudhyCQY17tr0Sjqr1xj/G7BJWHhgewD
         NU0I8Us4dTV58Bn87BwmmL8oDslCbqbRpBOZlLgQaa0FcwBWIIQ9EdzHips9GGLgsa3S
         +2dxJl7Kadr/bqpNbRJ0p3lccXCVPe5E12o7loq7ad3eNf/Jdw5nUpfI1sTnJPemSJgP
         Iphsmgf2IxHVhzEnKADJ82/q7PDz+LrU6MzOo9j+GYcl08Efe02JKy/i6frxL7BHz/Dh
         aHig==
X-Gm-Message-State: AOAM532DR+Znd7Fb4fT62EsRhzfcQqHN2L7C2I6IMvtCB2qtrLLY5RGD
        uRegy81/Dd2zSuDVa0JQQ3mboZhFZTJQSq2wM3rNJQ==
X-Google-Smtp-Source: ABdhPJz+KAJcw9lPLpGejjDEw4hAk3C/8Z8dhpkjFErjgU4n2XhzvH7ncUcXbpu1TUH9G56ERqUMbzU2TyTdwYMDTlQ=
X-Received: by 2002:a92:db0b:: with SMTP id b11mr48933iln.275.1632330279236;
 Wed, 22 Sep 2021 10:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210921163323.944352-1-axelrasmussen@google.com>
 <YUoaDr2wsW8wtk5Z@t490s> <CAJHvVcj68inRrpmw0pJq9qFc20JzG8+s7b31HkXQcsLcAJN_0Q@mail.gmail.com>
 <YUowr6phZU4v7dds@t490s> <CAJHvVcgz18qU9vjPimOhJ5YswfJnLN0tQGfsgjCh6M7ckvhfgA@mail.gmail.com>
 <YUp438W5p5VHL1Ch@t490s>
In-Reply-To: <YUp438W5p5VHL1Ch@t490s>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 22 Sep 2021 10:04:03 -0700
Message-ID: <CAJHvVciZc0mpcw8OSPk71YsVzCTajY+ikymcD3+zBJKsZynYkg@mail.gmail.com>
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

Thanks for discussing the design Peter. I have some ideas which might
make for a nicer v2; I'll massage the code a bit and see what I can
come up with.

On Tue, Sep 21, 2021 at 5:29 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Sep 21, 2021 at 01:31:12PM -0700, Axel Rasmussen wrote:
> > Ah, it has to do with us asserting the list of expected ioctls. The
> > kernel changes the list of ioctls it reports in response to a
> > UFFDIO_REGISTER, depending on the particular kind of vma being
> > registered, **as well as what mode(s) it is being registered with**.
> >
> > So for example, consider the hugetlb_shared test. When registering,
> > the kernel might set the UFFDIO_CONTINUE bit or not, depending on
> > whether we registered with the MINOR mode bit set in particular.
>
> I can understand your point, but the "capability set" of the kernel is still
> the same.  In this case we should have UFFDIO_CONTINUE capability for
> hugetlb_shared test globally, as long as the kernel supports it, irrelevant of
> what test case we're going to have.
>
> Then in the test, if we don't register with MINOR mode, IMHO we should just
> mask out the expected_ioctls with UFFDIO_CONTINUE because it does not make
> sense to request UFFDIO_CONTINUE if we will never use it in the test.

Right, this is how it was before. I didn't love how the base set
included everything, and then each test is responsible for removing
the things it isn't testing. It seems reversed: why not just have each
test compute the set of things it *is* testing?

>
> In other words, having a "uffd_features" global variable and having it changing
> all the time during tests is odd to me, but I agree it's not a big deal. :)

100% agree with this. From my perspective this is tech debt since:

8ba6e86408 userfaultfd/selftests: reinitialize test context in each test

It used to be that we just had one global context (variables like
uffd, count_verify, area_src, area_dst, etc). But this had the problem
where some previous test can mutate the context, breaking or affecting
following tests. After 8ba6e86408, we clear and reinitialize all these
variables for each test, but they're still global. I think it would be
cleaner if these instead were in a struct, which each test initialized
and then destroyed within its own scope. If we were to do such a
refactor, I would put uffd_features in that struct too - it should be
private to a test, since it's a property we get from the uffd.

But, I wasn't sure it was worth the churn to do something like this.

>
> --
> Peter Xu
>
