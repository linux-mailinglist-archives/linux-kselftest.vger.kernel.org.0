Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803223154DC
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 18:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhBIRT0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 12:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhBIRTY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 12:19:24 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBAAC061756
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Feb 2021 09:18:44 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id u20so19556599iot.9
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Feb 2021 09:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUtnzAW46dlZiTOiwqO9uCdRWksCkXtHA4sUKlf1iCA=;
        b=mPGpo9TqUVCxuvsIWZXrYrqbXhuqiZq4/bgvFH8ETfoC2cwS70d9kNXKaa/2ycZ8Le
         uGL/hKxZtc6ngGicBNMeisLGHgorEunI3Vjzy3q8yFjX3LGq+595QxFtPFoqqE+6Q50+
         v6NQApSLIfutLGyuvNhgDhcX8dJUIuVmGBTCnhABsgfj3ezGTVmwE7U4BBCmhEsIBd1j
         2rDoNUGKb2DDJ7VQ9Ve4rBhO+ucSyHWN04kGaQUYkFWHJNDzbedAZDmJfz8gKFd1q5Xt
         ymQY579V9yr3YpEHKROPs/8D5XBXvAz9ksqH71y8prOYXRi/qMzDNM0792csQnSYnq0T
         EmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUtnzAW46dlZiTOiwqO9uCdRWksCkXtHA4sUKlf1iCA=;
        b=PoH1I1eLj1SHO0W7PqGQ9JKp6TS8krT90YvfxnCsEN1vs4qP4gz4eYDkw1+Zws3Z+J
         D/lcQEhbeB5bkjumzkYz3vjZGzvux8RXgHINCGIiZkyVCW4vJuMUhIuuYLEMaFZvC11Z
         jmYgE051xVlsbgAcGwphcwOdC34a7nokIgWyWEBOjYYCKyMGsuv1tntcrSvbyIAxJ3ch
         EIvgypegL8aztaZswTf+A2xFcYTm1XV9jQ3tMMzqTvWeGp7PmySKeCp5f0Fc+oVKPlkE
         URK8wVvmG5qX5E16v8sEFwEFFsNAgBToPmvepbVWQm169eiWJDoFx8noMCrPkZVq4TjX
         OoJw==
X-Gm-Message-State: AOAM530mw43YVh+gj1fMYWCOPmOvo77TevyA1hDx/qVGTFcLuNbkZ1Je
        BL/K4ucWQFBdHuxf3FVtHfVQxni1yQYoXYRbwG6d0Q==
X-Google-Smtp-Source: ABdhPJweX41NuF64dCG1UI2nZGXXPZbi/LX4Sk0uxFDI+uTUx216zKSbRDPPiBcLSCyClF/rNTVuNKB74fH+EByTb+U=
X-Received: by 2002:a05:6602:2e8c:: with SMTP id m12mr20049870iow.19.1612891123762;
 Tue, 09 Feb 2021 09:18:43 -0800 (PST)
MIME-Version: 1.0
References: <20210208090841.333724-1-wangyanan55@huawei.com>
 <20210208090841.333724-2-wangyanan55@huawei.com> <CANgfPd967wgLk0tb6mNaWsaAa9Tn0LyecEZ_4-e+nKoa-HkCBg@mail.gmail.com>
 <c9c1207f-09ae-e601-5789-bd39ceb4071e@huawei.com>
In-Reply-To: <c9c1207f-09ae-e601-5789-bd39ceb4071e@huawei.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 9 Feb 2021 09:18:32 -0800
Message-ID: <CANgfPd_u2uGmt645e9mLbBcTOV1mQ_iXjq8h7WwCDKETZJ9GJg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] KVM: selftests: Add a macro to get string of vm_mem_backing_src_type
To:     "wangyanan (Y)" <wangyanan55@huawei.com>
Cc:     kvm <kvm@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        wanghaibin.wang@huawei.com, yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 9, 2021 at 3:21 AM wangyanan (Y) <wangyanan55@huawei.com> wrote:
>
>
> On 2021/2/9 2:13, Ben Gardon wrote:
> > On Mon, Feb 8, 2021 at 1:08 AM Yanan Wang <wangyanan55@huawei.com> wrote:
> >> Add a macro to get string of the backing source memory type, so that
> >> application can add choices for source types in the help() function,
> >> and users can specify which type to use for testing.
> > Coincidentally, I sent out a change last week to do the same thing:
> > "KVM: selftests: Add backing src parameter to dirty_log_perf_test"
> > (https://lkml.org/lkml/2021/2/2/1430)
> > Whichever way this ends up being implemented, I'm happy to see others
> > interested in testing different backing source types too.
>
> Thanks Ben! I have a little question here.
>
> Can we just present three IDs (0/1/2) but not strings for users to
> choose which backing_src_type to use like the way of guest modes,

That would be fine with me. The string names are easier for me to read
than an ID number (especially if you were to add additional options
e.g. 1G hugetlb or file backed  / shared memory) but it's mostly an
aesthetic preference, so I don't have strong feelings either way.

>
> which I think can make cmdlines more consise and easier to print. And is
> it better to make a universal API to get backing_src_strings
>
> like Sean have suggested, so that the API can be used elsewhere ?

Definitely. This should be as easy as possible to incorporate into all
selftests.

>
> >> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> >> ---
> >>   tools/testing/selftests/kvm/include/kvm_util.h | 3 +++
> >>   tools/testing/selftests/kvm/lib/kvm_util.c     | 8 ++++++++
> >>   2 files changed, 11 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> >> index 5cbb861525ed..f5fc29dc9ee6 100644
> >> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> >> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> >> @@ -69,7 +69,9 @@ enum vm_guest_mode {
> >>   #define PTES_PER_MIN_PAGE      ptes_per_page(MIN_PAGE_SIZE)
> >>
> >>   #define vm_guest_mode_string(m) vm_guest_mode_string[m]
> >> +#define vm_mem_backing_src_type_string(s) vm_mem_backing_src_type_string[s]
> >>   extern const char * const vm_guest_mode_string[];
> >> +extern const char * const vm_mem_backing_src_type_string[];
> >>
> >>   struct vm_guest_mode_params {
> >>          unsigned int pa_bits;
> >> @@ -83,6 +85,7 @@ enum vm_mem_backing_src_type {
> >>          VM_MEM_SRC_ANONYMOUS,
> >>          VM_MEM_SRC_ANONYMOUS_THP,
> >>          VM_MEM_SRC_ANONYMOUS_HUGETLB,
> >> +       NUM_VM_BACKING_SRC_TYPES,
> >>   };
> >>
> >>   int kvm_check_cap(long cap);
> >> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> >> index fa5a90e6c6f0..a9b651c7f866 100644
> >> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> >> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> >> @@ -165,6 +165,14 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
> >>   _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
> >>                 "Missing new mode params?");
> >>
> >> +const char * const vm_mem_backing_src_type_string[] = {
> >> +       "VM_MEM_SRC_ANONYMOUS        ",
> >> +       "VM_MEM_SRC_ANONYMOUS_THP    ",
> >> +       "VM_MEM_SRC_ANONYMOUS_HUGETLB",
> >> +};
> >> +_Static_assert(sizeof(vm_mem_backing_src_type_string)/sizeof(char *) == NUM_VM_BACKING_SRC_TYPES,
> >> +              "Missing new source type strings?");
> >> +
> >>   /*
> >>    * VM Create
> >>    *
> >> --
> >> 2.23.0
> >>
> > .
