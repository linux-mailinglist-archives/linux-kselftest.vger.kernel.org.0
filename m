Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620912A3759
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Nov 2020 00:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgKBX4T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Nov 2020 18:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgKBX4S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Nov 2020 18:56:18 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289D9C061A48
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Nov 2020 15:56:17 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id v18so14607064ilg.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Nov 2020 15:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sm6IgOnNa9rL1k7HvPRAgo27kLP+0TFF8lJM9YiGNEE=;
        b=JjIGdVg4BedDJfsejEBRa5XaLRTxlj+0HTZf8vHXjaHwnaK6d6DlDpN7oh/kPuOCrE
         I9XnqbIjiasVevs7L+Kc1TSeRKw/Vw2hVgy5OUFhZ46V7AZJe2iEE2idaIu4+qt944qr
         oH+JsD8otVJfRER7bTcZBWuvLnhKYbGnjlTPaotYlLKdMzskd9uruDoyhCodY00giq3C
         1fUpzKtxgey4EvsfjBjEpOedYGxq5pX29kCBAS8wdR0iwXI89dtqlrnbFriOLBAS6jln
         oLbh6eVYNiteWIcG9GEfUOE23M2borTG7AEIcdLwz56i6EcVOTeJlxpjP0/8yxYnthH8
         NgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sm6IgOnNa9rL1k7HvPRAgo27kLP+0TFF8lJM9YiGNEE=;
        b=FRHpe3sVkVp9x/P3YzrUb7vngMYtaiPrhU0rgvUjWMgZKq4x/QBDvyT2Drc1zzQ5I6
         yGq7vnNOKWVfWBs2MvbLB4ZJI4S0nsT9nLU2FHjl8BkOtjcJT8wRATivAQ80stB4jFWq
         dNGsk/BjaXf6ZItqv4CEhNyayJSTySMuYzCt3K7sosZ+tR4arWOIN2fel3sqzowuIkc8
         hZtL2zaQBmcBIrZSmPaQeza87ZvZvou9Vb1XFb1SRZRpyRVOlp83m6yO4Mqe02ASRn80
         67bb8NFekTDCTv13SFw0FbecC5efY2hKBqnYQ0CLjOq4L4zUgPFKn+/Z+iwFd5LEeQhL
         Tfvw==
X-Gm-Message-State: AOAM531VLT2Qe3bz89/3qnT/i2SBDPALMiENyO1TI4CWYWur25PcsEt2
        E3vhonsE9O6OACUWcFju8UpUE+KiL2hH9RIGJOocJA==
X-Google-Smtp-Source: ABdhPJzESLbH7IukdhE0c2SHbORU9TpNho3M4x3JfTHxS9TfRoXoEvRSn7ylxG3eRUy0O71zPgLYcvCv5HMn+sWX9NU=
X-Received: by 2002:a05:6e02:bcb:: with SMTP id c11mr12280324ilu.285.1604361376007;
 Mon, 02 Nov 2020 15:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20201027233733.1484855-1-bgardon@google.com> <20201027233733.1484855-6-bgardon@google.com>
 <20201102222102.GE20600@xz-x1>
In-Reply-To: <20201102222102.GE20600@xz-x1>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 2 Nov 2020 15:56:05 -0800
Message-ID: <CANgfPd_sLtqFb3sdpBpd6FWLV4MWKHXH8TSzDbPthzVSQPMJ+A@mail.gmail.com>
Subject: Re: [PATCH 5/5] KVM: selftests: Introduce the dirty log perf test
To:     Peter Xu <peterx@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 2, 2020 at 2:21 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 27, 2020 at 04:37:33PM -0700, Ben Gardon wrote:
> > The dirty log perf test will time verious dirty logging operations
> > (enabling dirty logging, dirtying memory, getting the dirty log,
> > clearing the dirty log, and disabling dirty logging) in order to
> > quantify dirty logging performance. This test can be used to inform
> > future performance improvements to KVM's dirty logging infrastructure.
>
> One thing to mention is that there're a few patches in the kvm dirty ring
> series that reworked the dirty log test quite a bit (to add similar test for
> dirty ring).  For example:
>
>   https://lore.kernel.org/kvm/20201023183358.50607-11-peterx@redhat.com/
>
> Just a FYI if we're going to use separate test programs.  Merging this tests
> should benefit in many ways, of course (e.g., dirty ring may directly runnable
> with the perf tests too; so we can manually enable this "perf mode" as a new
> parameter in dirty_log_test, if possible?), however I don't know how hard -
> maybe there's some good reason to keep them separate...

Absolutely, we definitely need a performance test for both modes. I'll
take a look at the patch you linked and see what it would take to
support dirty ring in this test.
Do you think that should be done in this series, or would it make
sense to add as a follow up?

>
> [...]
>
> > +static void run_test(enum vm_guest_mode mode, unsigned long iterations,
> > +                  uint64_t phys_offset, int vcpus,
> > +                  uint64_t vcpu_memory_bytes, int wr_fract)
> > +{
>
> [...]
>
> > +     /* Start the iterations */
> > +     iteration = 0;
> > +     host_quit = false;
> > +
> > +     clock_gettime(CLOCK_MONOTONIC, &start);
> > +     for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
> > +             pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
> > +                            &perf_test_args.vcpu_args[vcpu_id]);
> > +     }
> > +
> > +     /* Allow the vCPU to populate memory */
> > +     pr_debug("Starting iteration %lu - Populating\n", iteration);
> > +     while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id]) != iteration)
> > +             pr_debug("Waiting for vcpu_last_completed_iteration == %lu\n",
> > +                     iteration);
>
> Isn't array vcpu_last_completed_iteration[] initialized to all zeros?  If so, I
> feel like this "while" won't run as expected to wait for populating mem.

I think you are totally right. The array should be initialized to -1,
which I realize isn't a uint and unsigned integer overflow is bad, so
the array should be converted to ints too.
I suppose I didn't catch this because it would just make the
populating pass 0 look really short and pass 1 really long. I remember
seeing that behavior but not realizing that it was caused by a test
bug. I will correct this, thank you for pointing that out.

>
> The flooding pr_debug() seems a bit scary too if the mem size is huge..  How
> about a pr_debug() after the loop (so if we don't see that it means it hanged)?

I don't think the number of messages on pr_debug will be proportional
to the size of memory, but rather the product of iterations and vCPUs.
That said, that's still a lot of messages.
My assumption was that if you've gone to the trouble to turn on debug
logging, it's easier to comment log lines out than add them, but I'm
also happy to just move this to a single message after the loop.

>
> (There's another similar pr_debug() after this point too within a loop)
>
> Thanks,
>
> --
> Peter Xu
>
