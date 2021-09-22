Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0697415311
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Sep 2021 23:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbhIVVx3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Sep 2021 17:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238066AbhIVVx2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Sep 2021 17:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632347518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rYJ9XhtNZb7A4dQeqrhtvVfcVr5NXd1mHuE3OMC2z7c=;
        b=QKv8vqENFYjgXtuVmB8FLQRmh2+ms/+RBwVJ8WhfsMjJA/rmDYGJFcZ6fBQAiWTOjKX8pg
        9L/n468WVv6sZEbfyA0uSCUFbGuC4/5cGvE0EO/77SGQEw4aqzYrNNrDTu2ihGjmmW6+KO
        ZhqHLIVoFTDeqnhADcVk//OAskwcsWo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-qR6opTRXMQeYjuAeYGM4XA-1; Wed, 22 Sep 2021 17:51:57 -0400
X-MC-Unique: qR6opTRXMQeYjuAeYGM4XA-1
Received: by mail-qk1-f200.google.com with SMTP id c27-20020a05620a165b00b003d3817c7c23so12761584qko.16
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Sep 2021 14:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rYJ9XhtNZb7A4dQeqrhtvVfcVr5NXd1mHuE3OMC2z7c=;
        b=04kw3Y811HzmhTwLsdk3FFhqsUc65erUHqJ0uXG6yy9Z3FUETdQz2bSKjlGb9fOmth
         IhxoCpi4drMeM2ntEI3/WcJAgmAOY3DX5wL8HghMMrwKyoVLqs9LMTUOn8i2/xOfLFet
         qx+k3Y94k//iI7DfEH+QfFxdKRnE7XWzxw9I7wE1m6jpftVkQcMSAhSLgVzx/StQY4b2
         I1MKFxBSpq1BgT5FajbfNUz9/iLwteg5v55evq4HVMUXVYDLOaFLbR2o5lgqTmjT8ivK
         JsFg+bgrR83qKUEyqUdaYP/fHRaMaBnQRiRCdPLHgFu6tP1cCgDHEv0ASKoZCmDBpVzL
         UX4w==
X-Gm-Message-State: AOAM530zUh8QBfxaN/Yy5V++bUsZDYfoIfea/PxnlCpEgigmpyEhw+RZ
        dIY4q0L8/qFwRXAH9zpR/yVsA8xQzGnfCovlAyVebSvxmV1sX7hI8PyvS0O6ZvHeri6L9eJHXD1
        5ZJ0aI4F9P+YkI9prLNVpBrjs+xBd
X-Received: by 2002:a0c:f58b:: with SMTP id k11mr1146253qvm.66.1632347516593;
        Wed, 22 Sep 2021 14:51:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2vehWnx2IYD6qD1pTYUcyYrhr0SdnzxB6e0brzMk0zVjUL48IEuBmj1CjOE805HOCWLgE9g==
X-Received: by 2002:a0c:f58b:: with SMTP id k11mr1146239qvm.66.1632347516309;
        Wed, 22 Sep 2021 14:51:56 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id l13sm2742962qkp.97.2021.09.22.14.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:51:55 -0700 (PDT)
Date:   Wed, 22 Sep 2021 17:51:54 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] userfaultfd/selftests: fix feature support detection
Message-ID: <YUulep3+YADkwlUu@t490s>
References: <20210921163323.944352-1-axelrasmussen@google.com>
 <YUoaDr2wsW8wtk5Z@t490s>
 <CAJHvVcj68inRrpmw0pJq9qFc20JzG8+s7b31HkXQcsLcAJN_0Q@mail.gmail.com>
 <YUowr6phZU4v7dds@t490s>
 <CAJHvVcgz18qU9vjPimOhJ5YswfJnLN0tQGfsgjCh6M7ckvhfgA@mail.gmail.com>
 <YUp438W5p5VHL1Ch@t490s>
 <CAJHvVciZc0mpcw8OSPk71YsVzCTajY+ikymcD3+zBJKsZynYkg@mail.gmail.com>
 <YUtoyNic4Jxfv9f7@t490s>
 <CAJHvVcg6PRCK_JcYEhRqq2vPyypnc+ySOtLhtFf5GrcQjimsJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcg6PRCK_JcYEhRqq2vPyypnc+ySOtLhtFf5GrcQjimsJQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 22, 2021 at 01:54:53PM -0700, Axel Rasmussen wrote:
> On Wed, Sep 22, 2021 at 10:33 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > Hello, Axel,
> >
> > On Wed, Sep 22, 2021 at 10:04:03AM -0700, Axel Rasmussen wrote:
> > > Thanks for discussing the design Peter. I have some ideas which might
> > > make for a nicer v2; I'll massage the code a bit and see what I can
> > > come up with.
> >
> > Sure thing.  Note again that as I don't have a strong opinion on that, feel
> > free to keep it.  However if you provide v2, I'll read.
> >
> > [off-topic below]
> >
> > Another thing I probably have forgot but need your confirmation is, when you
> > worked on uffd minor mode, did you explicitly disable thp, or is it allowed?
> 
> I gave a more detailed answer in the other thread, but: currently it
> is allowed, but this was a bug / oversight on my part. :) THP collapse
> can break the guarantees minor fault registration is trying to
> provide.

I've replied there:

https://lore.kernel.org/linux-mm/YUueOUfoamxOvEyO@t490s/

We can try to keep the discussion unified there regarding this.

> But there's another scenario: what if the collapse happened well
> before registration happened?

Maybe yes, but my understanding of the current uffd-minor scenario tells me
that this is fine too.  Meanwhile I actually have another idea regarding minor
mode, please continue reading.

Firstly, let me try to re-cap on how minor mode is used in your production
systems: I believe there should have two processes A and B, if A is the main
process, B could be the migration process.  B migrates pages in the background,
while A so far should have been stopped and never ran.  When we want to start
A, we should register A with uffd-minor upon the whole range (note: I think so
far A does not have any pgtable mapped within uffd-minor range).  Then any page
access of A should kick B and asking "whether it is the latest page", if yes
then UFFDIO_CONTINUE, if no then B modifies the page, plus UFFDIO_CONTINUE
afterwards.  Am I right above?

So if that's the case, then A should have no page table at all.

Then, is that a problem if the shmem file that A maps contains huge thps?  I
think no - because UFFDIO_CONTINUE will only install small pages.

Let me know if I'm understanding it right above; I'll be happy to be corrected.

Actually besides this scenario, I'm also thinking of another scenario of using
minor fault in a single process - that's mostly what QEMU is doing right now,
as QEMU has the vcpu threads and migration thread sharing a single mm/pgtable.
So I think it'll be great to have a new madvise(MADV_ZAP) which will tear down
all the file-backed memory pgtables of a specific range.  I think it'll suite
perfectly for the minor fault use case, and it can be used for other things
too.  Let me know what you think about this idea, and whether that'll help in
your case too (e.g., if you worry a current process A mapped huge shmem thp
somewhere, we can use madvise(MADV_ZAP) to drop it).

> I *think* the existing code deals with THPs correctly in that case, but then
> again I don't think our selftest really covers this case, and it's not
> something I've tested in production either (to work around the other bug, we
> currently MADV_NOHUGEPAGE the area until after VM demand paging completes,
> and the UFFD registration is removed), so I am not super confident this is
> the case.

In all cases, enhancing the test program will always be welcomed.

Thanks,

-- 
Peter Xu

