Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2D82A383A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Nov 2020 02:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgKCBMR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Nov 2020 20:12:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbgKCBMN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Nov 2020 20:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604365931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BIQqt8sy3D4SBKygoMGq5DX8VM2JmS46P1ucpudMMkQ=;
        b=ddyU+K56J7pK1B1qUcJa0dQT8AnFR7CT7YTmgRaFabY+CaCgMlcYYSXlnBYXsP4sS9w10j
        npZCAF3ixOwOuTgAMTZet40x8DsKx/IMjIUcv9loXSA7OsBCwkPoZbfUtngabCKvwD1pIJ
        KgGnrWXdQQxwYsJe2g2p+1oJWM6QAGo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-jhxghnz8NVicWoA7vnfy7Q-1; Mon, 02 Nov 2020 20:12:08 -0500
X-MC-Unique: jhxghnz8NVicWoA7vnfy7Q-1
Received: by mail-qk1-f197.google.com with SMTP id f9so9896925qkg.13
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Nov 2020 17:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BIQqt8sy3D4SBKygoMGq5DX8VM2JmS46P1ucpudMMkQ=;
        b=flMIUgNhoXdNyRuckfEZgwR1q2ObGqaPb5yweLG9ERNelBrSC9mXJs6xizPYERTxjS
         ogduR4hfAgqhQpthG/KIAc81BjN6nc/zo3AP6ZVlkAm0CEKKDJH/QCw0oDsVyW3oQPNb
         acFUMy+eLg5JFTJ5pjlV+lPMMaCqn+dim2i1IedLyy3h7TV4BsGZEFH64Z92NJWtv+jV
         zd0+3SsvqGbp9MJurRP7q9pSLcuHv2cRwHHy0ATh30ZWLGuSrbQsIkvDgYlUHZbhq3dw
         tRIXihz0sxBJbnnrT3AHk0YrddhrejpVXt1fZE8Ejx+U+FIQJ1ajFOK2rL/aG2hP4Oyl
         9DRQ==
X-Gm-Message-State: AOAM531HbHEl1UjdQyF1nXsiXjHFKz+IVkBTDKJZcK4y1MsR9mQ0w6w2
        +tk1uUb8H3tPq21bZUzE9UaBMhc/3jMTsQ4W2qwGNCdhT4bUXnOTOtbC30CIBb6P+a1dapnxQdg
        hNei2Y5c2wD6kg/SVnUuSlEBwn+49
X-Received: by 2002:ad4:4f22:: with SMTP id fc2mr25550423qvb.28.1604365927694;
        Mon, 02 Nov 2020 17:12:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwtPTOUVNm53qFylPxDEyAuwGzAdDrhN23MCjKtCSTr6szC0zgS/0j4Pu4nLY0KHi0zKQVtow==
X-Received: by 2002:ad4:4f22:: with SMTP id fc2mr25550400qvb.28.1604365927367;
        Mon, 02 Nov 2020 17:12:07 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
        by smtp.gmail.com with ESMTPSA id t18sm5014797qtr.1.2020.11.02.17.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 17:12:06 -0800 (PST)
Date:   Mon, 2 Nov 2020 20:12:05 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: [PATCH 5/5] KVM: selftests: Introduce the dirty log perf test
Message-ID: <20201103011205.GG20600@xz-x1>
References: <20201027233733.1484855-1-bgardon@google.com>
 <20201027233733.1484855-6-bgardon@google.com>
 <20201102222102.GE20600@xz-x1>
 <CANgfPd_sLtqFb3sdpBpd6FWLV4MWKHXH8TSzDbPthzVSQPMJ+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANgfPd_sLtqFb3sdpBpd6FWLV4MWKHXH8TSzDbPthzVSQPMJ+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 02, 2020 at 03:56:05PM -0800, Ben Gardon wrote:
> On Mon, Nov 2, 2020 at 2:21 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Oct 27, 2020 at 04:37:33PM -0700, Ben Gardon wrote:
> > > The dirty log perf test will time verious dirty logging operations
> > > (enabling dirty logging, dirtying memory, getting the dirty log,
> > > clearing the dirty log, and disabling dirty logging) in order to
> > > quantify dirty logging performance. This test can be used to inform
> > > future performance improvements to KVM's dirty logging infrastructure.
> >
> > One thing to mention is that there're a few patches in the kvm dirty ring
> > series that reworked the dirty log test quite a bit (to add similar test for
> > dirty ring).  For example:
> >
> >   https://lore.kernel.org/kvm/20201023183358.50607-11-peterx@redhat.com/
> >
> > Just a FYI if we're going to use separate test programs.  Merging this tests
> > should benefit in many ways, of course (e.g., dirty ring may directly runnable
> > with the perf tests too; so we can manually enable this "perf mode" as a new
> > parameter in dirty_log_test, if possible?), however I don't know how hard -
> > maybe there's some good reason to keep them separate...
> 
> Absolutely, we definitely need a performance test for both modes. I'll
> take a look at the patch you linked and see what it would take to
> support dirty ring in this test.

That would be highly appreciated.

> Do you think that should be done in this series, or would it make
> sense to add as a follow up?

To me I slightly lean toward working upon those patches, since we should
potentially share quite some code there (e.g., the clear dirty log cleanup
seems necessary, or not easy to add the dirty ring tests anyway).  But current
one is still ok to me at least as initial version - we should always be more
tolerant for test cases, aren't we? :)

So maybe we can wait for a 3rd opinion before you change the direction.

> 
> >
> > [...]
> >
> > > +static void run_test(enum vm_guest_mode mode, unsigned long iterations,
> > > +                  uint64_t phys_offset, int vcpus,
> > > +                  uint64_t vcpu_memory_bytes, int wr_fract)
> > > +{
> >
> > [...]
> >
> > > +     /* Start the iterations */
> > > +     iteration = 0;
> > > +     host_quit = false;
> > > +
> > > +     clock_gettime(CLOCK_MONOTONIC, &start);
> > > +     for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
> > > +             pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
> > > +                            &perf_test_args.vcpu_args[vcpu_id]);
> > > +     }
> > > +
> > > +     /* Allow the vCPU to populate memory */
> > > +     pr_debug("Starting iteration %lu - Populating\n", iteration);
> > > +     while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id]) != iteration)
> > > +             pr_debug("Waiting for vcpu_last_completed_iteration == %lu\n",
> > > +                     iteration);
> >
> > Isn't array vcpu_last_completed_iteration[] initialized to all zeros?  If so, I
> > feel like this "while" won't run as expected to wait for populating mem.
> 
> I think you are totally right. The array should be initialized to -1,
> which I realize isn't a uint and unsigned integer overflow is bad, so
> the array should be converted to ints too.
> I suppose I didn't catch this because it would just make the
> populating pass 0 look really short and pass 1 really long. I remember
> seeing that behavior but not realizing that it was caused by a test
> bug. I will correct this, thank you for pointing that out.
> 
> >
> > The flooding pr_debug() seems a bit scary too if the mem size is huge..  How
> > about a pr_debug() after the loop (so if we don't see that it means it hanged)?
> 
> I don't think the number of messages on pr_debug will be proportional
> to the size of memory, but rather the product of iterations and vCPUs.
> That said, that's still a lot of messages.

The guest code dirties all pages, and that process is proportional to the size
of memory, no?

Btw since you mentioned vcpus - I also feel like above chunk should be put into
the for loop above...

> My assumption was that if you've gone to the trouble to turn on debug
> logging, it's easier to comment log lines out than add them, but I'm
> also happy to just move this to a single message after the loop.

Yah that's subjective too - feel free to keep whatever you prefer.  In all
cases, hopefully I won't even need to enable pr_debug at all. :)

-- 
Peter Xu

