Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0953E38993E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 May 2021 00:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhESWZW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 18:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhESWZV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 18:25:21 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8B3C061760
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 15:24:00 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id t11so14581676iol.9
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 15:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rx88tQCGOYDOoqf7VThCQ35Bbq6JUkOg6xay93bQ/Kw=;
        b=cJtsAIQZTYB8JoeFmcaGZ/bFe0qN7YpY0zWnmqZxm/fcSJsCbDpYZ/XWiiLdDT5uKF
         Ne4jDon7qeLtRdpXjMMvc739xZhmuiu89fQtnXT6wuAlsf4FY7EQrC58GQCFgv69IRz9
         KKROjdz+cb7D/GzNvjHnp/vC6P+hZAxGx2UmSWUBVTzfHX4QLTbqGvtIa2BL4kHUmD+J
         +eKK7pMHTGWfF46J26oIgrQ0qNrrH8fzUXcsBZeNK0iJofJl11mpUfGX4yYwLrcaqIh7
         g4MoWKy7ohVlfyeYda+uyOfvXbcYqN8HcCQUOx4OK/St8oYthwgtO0BoYrZgHoaD9SSD
         T3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rx88tQCGOYDOoqf7VThCQ35Bbq6JUkOg6xay93bQ/Kw=;
        b=kgRaQWcn9ZwGHBTgraU/013JrUfFvQiCLBoTYy+mjkcPNsjk/0sjXZxypKTwl2AnSP
         jgFZhj3m6O7cdxGKhhfdoChmAoz53y3x1Dt0zmwM1ilXgyeObja7JrUP1Qz5/45u1SMG
         1h3hkNNH0mXYo5DoHWM5CvR0I2fhiniMU1rlNsgCTnstGfcBy1xCOivIc9r/X+4vr108
         /4B/TewqXpKsywxzab5Ifj12dVRROUEqkPawAHDO8Qfvrzm5UNewjoUhLVAY1SpKNrzZ
         HilrJtC7W9bHrxLSWMVa2MbvoKLApOgwy8tnT1D51FGlLb+cBFzIYjeR2tAYS4wFPu6d
         R3NQ==
X-Gm-Message-State: AOAM532pKGQIo2I/FSALdiImim5JmnYfil3v8Q0wVbHCu7g/FW64a5i6
        V/LpJvoqaJ/SD7jSepFOzWdcDokFSOnebLlWdGZ7Mg==
X-Google-Smtp-Source: ABdhPJwB07EuXP9IYQmcXFl+VPdTAyhI/bnkPf9ED6KUVfUM8W7xcExjG7mz8GGf9CQIdJd8bSFBIlAyCytCSAH4MqM=
X-Received: by 2002:a05:6602:3427:: with SMTP id n39mr2079015ioz.157.1621463039499;
 Wed, 19 May 2021 15:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com>
 <20210519200339.829146-3-axelrasmussen@google.com> <CANgfPd-dF+vWafBC5DsNhf5C0M12+LxRQLhsBM=CzOKTsep+og@mail.gmail.com>
 <CAJHvVcizVoAs+-wOXeO7bc=8c2G3oEC4KSVyPm5E9Z6YMCsvaw@mail.gmail.com>
In-Reply-To: <CAJHvVcizVoAs+-wOXeO7bc=8c2G3oEC4KSVyPm5E9Z6YMCsvaw@mail.gmail.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 19 May 2021 15:23:49 -0700
Message-ID: <CANgfPd-GzkFFps4+zRCy6bUn5zA8UTBw97wAvAMkOdKKfxYQEA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] KVM: selftests: simplify setup_demand_paging
 error handling
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 19, 2021 at 3:14 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> On Wed, May 19, 2021 at 2:45 PM Ben Gardon <bgardon@google.com> wrote:
> >
> > On Wed, May 19, 2021 at 1:03 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
> > >
> > > A small cleanup. Our caller writes:
> > >
> > >   r = setup_demand_paging(...);
> > >   if (r < 0) exit(-r);
> > >
> > > Since we're just going to exit anyway, instead of returning an error we
> > > can just re-use TEST_ASSERT. This makes the caller simpler, as well as
> > > the function itself - no need to write our branches, etc.
> > >
> > > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> > > ---
> > >  .../selftests/kvm/demand_paging_test.c        | 51 +++++++------------
> > >  1 file changed, 19 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> > > index 9398ba6ef023..601a1df24dd2 100644
> > > --- a/tools/testing/selftests/kvm/demand_paging_test.c
> > > +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> > > @@ -9,6 +9,8 @@
> > >
> > >  #define _GNU_SOURCE /* for pipe2 */
> > >
> > > +#include <inttypes.h>
> > > +#include <stdint.h>
> >
> > Why do the includes need to change in this commit? Is it for the PRIu64 below?
>
> Right, I didn't actually try compiling without these, but inttypes.h
> defines PRIu64 and stdint.h defines uint64_t. In general I tend to
> prefer including things like this because we're using their
> definitions directly, even if we might be picking them up transiently
> some other way.

Makes sense to me.

>
> >
> > >  #include <stdio.h>
> > >  #include <stdlib.h>
> > >  #include <time.h>
> > > @@ -198,42 +200,32 @@ static void *uffd_handler_thread_fn(void *arg)
> > >         return NULL;
> > >  }
> > >
> > > -static int setup_demand_paging(struct kvm_vm *vm,
> > > -                              pthread_t *uffd_handler_thread, int pipefd,
> > > -                              useconds_t uffd_delay,
> > > -                              struct uffd_handler_args *uffd_args,
> > > -                              void *hva, uint64_t len)
> > > +static void setup_demand_paging(struct kvm_vm *vm,
> > > +                               pthread_t *uffd_handler_thread, int pipefd,
> > > +                               useconds_t uffd_delay,
> > > +                               struct uffd_handler_args *uffd_args,
> > > +                               void *hva, uint64_t len)
> > >  {
> > >         int uffd;
> > >         struct uffdio_api uffdio_api;
> > >         struct uffdio_register uffdio_register;
> > >
> > >         uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> > > -       if (uffd == -1) {
> > > -               pr_info("uffd creation failed\n");
> > > -               return -1;
> > > -       }
> > > +       TEST_ASSERT(uffd >= 0, "uffd creation failed, errno: %d", errno);
> > >
> > >         uffdio_api.api = UFFD_API;
> > >         uffdio_api.features = 0;
> > > -       if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1) {
> > > -               pr_info("ioctl uffdio_api failed\n");
> > > -               return -1;
> > > -       }
> > > +       TEST_ASSERT(ioctl(uffd, UFFDIO_API, &uffdio_api) != -1,
> > > +                   "ioctl UFFDIO_API failed: %" PRIu64,
> > > +                   (uint64_t)uffdio_api.api);
> > >
> > >         uffdio_register.range.start = (uint64_t)hva;
> > >         uffdio_register.range.len = len;
> > >         uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> > > -       if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
> > > -               pr_info("ioctl uffdio_register failed\n");
> > > -               return -1;
> > > -       }
> > > -
> > > -       if ((uffdio_register.ioctls & UFFD_API_RANGE_IOCTLS) !=
> > > -                       UFFD_API_RANGE_IOCTLS) {
> > > -               pr_info("unexpected userfaultfd ioctl set\n");
> > > -               return -1;
> > > -       }
> > > +       TEST_ASSERT(ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) != -1,
> > > +                   "ioctl UFFDIO_REGISTER failed");
> > > +       TEST_ASSERT((uffdio_register.ioctls & UFFD_API_RANGE_IOCTLS) ==
> > > +                   UFFD_API_RANGE_IOCTLS, "unexpected userfaultfd ioctl set");
> > >
> > >         uffd_args->uffd = uffd;
> > >         uffd_args->pipefd = pipefd;
> > > @@ -243,8 +235,6 @@ static int setup_demand_paging(struct kvm_vm *vm,
> > >
> > >         PER_VCPU_DEBUG("Created uffd thread for HVA range [%p, %p)\n",
> > >                        hva, hva + len);
> > > -
> > > -       return 0;
> > >  }
> > >
> > >  struct test_params {
> > > @@ -321,13 +311,10 @@ static void run_test(enum vm_guest_mode mode, void *arg)
> > >                                   O_CLOEXEC | O_NONBLOCK);
> > >                         TEST_ASSERT(!r, "Failed to set up pipefd");
> > >
> > > -                       r = setup_demand_paging(vm,
> > > -                                               &uffd_handler_threads[vcpu_id],
> > > -                                               pipefds[vcpu_id * 2],
> > > -                                               p->uffd_delay, &uffd_args[vcpu_id],
> > > -                                               vcpu_hva, vcpu_mem_size);
> > > -                       if (r < 0)
> > > -                               exit(-r);
> > > +                       setup_demand_paging(vm, &uffd_handler_threads[vcpu_id],
> > > +                                           pipefds[vcpu_id * 2], p->uffd_delay,
> > > +                                           &uffd_args[vcpu_id], vcpu_hva,
> > > +                                           vcpu_mem_size);
> > >                 }
> > >         }
> > >
> > > --
> > > 2.31.1.751.gd2f1c929bd-goog
> > >
