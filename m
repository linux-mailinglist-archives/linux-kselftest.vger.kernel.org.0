Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5226413AA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Sep 2021 21:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhIUTWw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Sep 2021 15:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230497AbhIUTWw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Sep 2021 15:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632252083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yTp5nZl5FP2S4p5cUtShACrTS3ff7K6W1gpGjotFl+0=;
        b=hQEZlwL5PmCQuKg4paMVJ58K6/Mhiw3Hg/BKRpejj5EpRBx1BJ5xtAQ+gVZScaUAlqYwAR
        1zyzl7gd7+YQsDtpD6edzE9zMkZvvHbSqJv8DJrOShkEM6zqnbSohz23G6xja5Zndm9RF9
        eaWH8xfhwjit6Sd/f9InuRtW/FOQURs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-KdZ-LZijNr6-dscGQy1idg-1; Tue, 21 Sep 2021 15:21:21 -0400
X-MC-Unique: KdZ-LZijNr6-dscGQy1idg-1
Received: by mail-qk1-f198.google.com with SMTP id s18-20020a05620a255200b00433885d4fa7so2577475qko.4
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Sep 2021 12:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yTp5nZl5FP2S4p5cUtShACrTS3ff7K6W1gpGjotFl+0=;
        b=o7dUUUSVauqfnV9Ve1XAErR7zL0Yz0aMOm9Sn6Lu898dEeL9PxnA6g2f6s3sBXmeIa
         T/6IsOvf7okipYk48430h/1w/ZkorlIvXHyNrx3YielvsMOmyNTsu7ArcqXK7WTVgmoB
         WSVyfE0Iziw+1eYZWBx4fVdBk+bGuKY3MEK2Y8r2BoIJh8OiFjz3adJS6FBMxm7i/pU9
         9HHaIMv4/QrvmegY6BccYuphTZgU8ghlJq4YOdXlPs6yEmI48A/5aeLuMnQXYU18mboN
         IPlXKQ3xteOGYfAuldU1TlBnAkb+GNw2LfCg98Y0zYk1NvLpn9pIIR9ZPlcatfD0I/DZ
         63og==
X-Gm-Message-State: AOAM533SWfFvY3nkMeF0Hg3BWYRhPfGK/Lgqr7ev3UKnieOOLEpn8pW9
        qU/iO2Cxv/vkcUneCBfv+VglWyevyIluFVOZSBM0ieqHrOagE0jWHgnyxmtmCysjuRtzHB2GDzH
        Mv/cusMFWpiNW0QXHkzfNF9tfmVSP
X-Received: by 2002:a0c:b391:: with SMTP id t17mr8884814qve.35.1632252081319;
        Tue, 21 Sep 2021 12:21:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCxg/1fWoiiV7evbw5NzE0whd7BvYgpUL/aAEXYfn2sAz+T6HT6pVp513PoQzhTVefWS6UXA==
X-Received: by 2002:a0c:b391:: with SMTP id t17mr8884784qve.35.1632252081010;
        Tue, 21 Sep 2021 12:21:21 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id a9sm14623542qkk.82.2021.09.21.12.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 12:21:20 -0700 (PDT)
Date:   Tue, 21 Sep 2021 15:21:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] userfaultfd/selftests: fix feature support detection
Message-ID: <YUowr6phZU4v7dds@t490s>
References: <20210921163323.944352-1-axelrasmussen@google.com>
 <YUoaDr2wsW8wtk5Z@t490s>
 <CAJHvVcj68inRrpmw0pJq9qFc20JzG8+s7b31HkXQcsLcAJN_0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcj68inRrpmw0pJq9qFc20JzG8+s7b31HkXQcsLcAJN_0Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 21, 2021 at 11:26:14AM -0700, Axel Rasmussen wrote:
> On Tue, Sep 21, 2021 at 10:44 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > Hi, Axel,
> >
> > On Tue, Sep 21, 2021 at 09:33:21AM -0700, Axel Rasmussen wrote:
> > > diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> > > index 10ab56c2484a..2366caf90435 100644
> > > --- a/tools/testing/selftests/vm/userfaultfd.c
> > > +++ b/tools/testing/selftests/vm/userfaultfd.c
> > > @@ -79,10 +79,6 @@ static int test_type;
> > >  #define ALARM_INTERVAL_SECS 10
> > >  static volatile bool test_uffdio_copy_eexist = true;
> > >  static volatile bool test_uffdio_zeropage_eexist = true;
> > > -/* Whether to test uffd write-protection */
> > > -static bool test_uffdio_wp = false;
> > > -/* Whether to test uffd minor faults */
> > > -static bool test_uffdio_minor = false;
> >
> > IMHO it's not a fault to have these variables; they're still the fastest way to
> > do branching.  It's just that in some cases we should set them to "false"
> > rather than "true", am I right?
> >
> > How about we just set them properly in set_test_type?  Say, we can fetch the
> > feature bits in set_test_type rather than assuming it's only related to the
> > type of memory.
> 
> We could do that, but it would require opening a userfaultfd, issuing
> a UFFDIO_API ioctl, and getting the feature bits in set_test_type. And
> then I guess just closing the UFFD again, as we aren't yet setting up
> for any particular test. To me, it seemed "messier" than this
> approach.
> 
> Another thing to consider is, for the next patch we don't just want to
> know "does this kernel support $FEATURE in general?" but also "is
> $FEATURE supported for this particular memory region I've
> registered?", and we can't have a single global answer to that.

Could I ask why?  For each run, the memory type doesn't change, isn't it?  Then
I think the capability it should support is a constant?

Btw, note that "open an uffd, detect features, close uffd quickly" during setup
phase is totally fine to me just for probing the capabilities, and instead of
thinking it being messy I see it a very clean approach..

> It seemed a bit cleaner to me to write the code as if I was dealing with that
> case, and then re-use the infrastructure I'd built for patch 2/3.

I didn't comment on patch 2, but I had the same confusion - aren't all these
information constant after we settle the hardware, the kernel and the memory
type to test?

> 
> Basically, I didn't initially have a goal of getting rid of these
> variables, but it ended up being the cleanest way (IMHO).
> 
> Just trying to explain the thinking. :) In the end, I think it's a
> stylistic choice and don't feel super strongly about it, either way
> could work. So, I can change it if you or others do feel strongly.

I have no strong opinion as long as the code works (which I trust you on :).
We can keep it in Andrew's queue unless you do feel the other way is better.

Thanks,

-- 
Peter Xu

