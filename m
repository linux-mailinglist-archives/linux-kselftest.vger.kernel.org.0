Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DD85AF81F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 00:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiIFWsn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 18:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiIFWsm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 18:48:42 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668B498D2F
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Sep 2022 15:48:39 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w63so3432383pgb.7
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Sep 2022 15:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rOiaJADgh36Nl6+5Yk+6tnFh6F6MctRkw6enAUS/Q0w=;
        b=ZhLxHhf2O9zAE4iA4AOa/6Q9ENPkNae9PE/ZvK3k/PGxPwMvQihxpKAkubttgODLPG
         bwl/xZ5+PDffT1iOA9X92UKsRr2bQ3THjV0lI33kStevsvpNCzUG/qZTfqP3u2rvMMWN
         s42gp1sF1l8uqOCBqMnylL3u2V2oVCDHYsHGTF8Lii0flrr6dmv3+nr/tD9i+Ysrx5io
         g/yWz5FR2+4fgfyYSHpDFFeP0mElBOBaK9Hv9Q6rpGNqyL1jaaDTuUTQL34KDMO8mTPZ
         95K9TSvV4pu7/ANiQQS23gosV1q+B5KhuQJrhA47j02xo06UUW9lpHEbGTbjlmMzRPpd
         3RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rOiaJADgh36Nl6+5Yk+6tnFh6F6MctRkw6enAUS/Q0w=;
        b=4C+rDcs6hgy1A4J7oHGr1IMuFkZj+fpmrLmkVj2RuMqVLj70b7bhNksw2B5BLYp4c0
         i94kyGK8MQyseUjtegAYnkoDFm/PLTqZQYmimMNd7e4BmV3RsUGTGyLMS+1EK4SXA2fa
         cEyo7IZilbJU2TJpQAmF2Eq6VfmZPLqPEtXHGhNcayrNiz2cVxsgGIp3tbmSxmmpsA71
         tYgxXm94kXEVL6c9HHuTAI0n4H1T2aWYmxwhSkZeSKOCkYxYOzVoRBWBeAfbcTx1L3LY
         EdSY5Ix3vjTmy0nENLXdUHsibjfKWVjEtge5QfiRIbtHZWOSN+JiMlc0iJMowkcrBthH
         iUZg==
X-Gm-Message-State: ACgBeo2Otd6N40c5AlE9MbIzl9PSW/T4vpMXVrThADJESlSpTvj/JUWq
        i9bTVhxfwYEs153yLRAmCBDHkdRfF8ccAWo+me9K2g==
X-Google-Smtp-Source: AA6agR6ayjA9kHK8UdphQGfYeNZk6AAcj3QEos1OjluB4ADy4xnwjM60v2A3WubD/z3eD+tOWC+JWY1i6uVzqV5Re2o=
X-Received: by 2002:a62:e91a:0:b0:537:e307:fab0 with SMTP id
 j26-20020a62e91a000000b00537e307fab0mr885302pfh.37.1662504518627; Tue, 06 Sep
 2022 15:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220819174659.2427983-1-vannapurve@google.com>
 <20220819174659.2427983-5-vannapurve@google.com> <Ywa9T+jKUpaHLu/l@google.com>
In-Reply-To: <Ywa9T+jKUpaHLu/l@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Tue, 6 Sep 2022 15:48:27 -0700
Message-ID: <CAGtprH9zVDP4ur2mStDVAPU3M1MmvdgFQz7uTh6hAWjRL0Xbcw@mail.gmail.com>
Subject: Re: [RFC V3 PATCH 4/6] selftests: kvm: x86: Execute hypercall as per
 the cpu
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86 <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        dave.hansen@linux.intel.com, "H . Peter Anvin" <hpa@zytor.com>,
        shuah <shuah@kernel.org>, yang.zhong@intel.com,
        drjones@redhat.com, Ricardo Koller <ricarkol@google.com>,
        Aaron Lewis <aaronlewis@google.com>, wei.w.wang@intel.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Quentin Perret <qperret@google.com>,
        Steven Price <steven.price@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marc Orr <marcorr@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Peter Gonda <pgonda@google.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>,
        Austin Diviness <diviness@google.com>, maz@kernel.org,
        David Matlack <dmatlack@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        maciej.szmigiero@oracle.com, Mingwei Zhang <mizhang@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 24, 2022 at 5:07 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Fri, Aug 19, 2022, Vishal Annapurve wrote:
> > Add support for executing vmmcall/vmcall instruction on amd/intel cpus.
> > In general kvm patches the instruction according to the cpu
> > implementation at runtime. While executing selftest vms from private
> > memory KVM will not be able to update the private memory of the guest.
> >
> > Hypercall parameters are fixed to explicitly populate hypercall number
> > in eax. Otherwise inlined function calls to kvm_hypercall would call
> > vmmcall/vmcall instruction without updating eax with hypercall number.
>
> Can you send a seperate non-RFC series to clean up the selftests mess?  kvm_hypercall()
> isn't the only culprit.
>
>   git grep \"vmcall | wc -l
>   16
>
> I'm pretty sure things work only because of KVM's dubious behavior of patching
> VMCALL/VMMCALL by default.
>
> Note, svm_vmcall_test.c intentionally uses the wrong instructions and shouldn't
> be converted.  Actually, we can and should just delete that test, it's superseded
> by the wonderfully named fix_hypercall_test.
>
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > ---
> >  .../testing/selftests/kvm/lib/x86_64/processor.c  | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > index 53b115876417..09d757a0b148 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > @@ -1254,10 +1254,21 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
> >                      uint64_t a3)
> >  {
> >       uint64_t r;
> > +     static bool is_cpu_checked;
> > +     static bool is_cpu_amd;
> >
> > -     asm volatile("vmcall"
> > +     if (!is_cpu_checked)
> > +             is_cpu_amd = is_amd_cpu();
>
> This can be done using a single int, e.g.
>
>         static bool is_cpu_amd = -1;
>
>         if (is_cpu_amd < 0)
>                 is_cpu_amd = is_amd_cpu();
>
> Although... what if we declare main() in lib/kvm_util.c (or maybe a dedicated
> file?) and rename all tests to use __main()?  Then add an arch hook to do global
> initialization and avoid the "did we check CPUID?!?!?" altogether.
>
> That would allow us to dedup all of the hilarious copy paste:
>
>         /* Tell stdout not to buffer its content */
>         setbuf(stdout, NULL);
>
> and we could turn is_amd_cpu() and is_intel_cpu() into bools.
>
> E.g.
>
> int main(int argc, char *argv[])
> {
>         /* Tell stdout not to buffer its content */
>         setbuf(stdout, NULL);
>
>         kvm_arch_main();
>
>         return __main(argc, argv);
> }
>
> void kvm_arch_main(void)
> {
>         is_cpu_amd = cpu_vendor_string_is("AuthenticAMD");
>         is_cpu_intel = cpu_vendor_string_is("AuthenticAMD");
> }
>
>
> And then we just need macro magic to emit the right VMCALL/VMMCALL instruction.

Thanks Sean for the feedback here. I have posted a separate series
addressing your comments:
https://lore.kernel.org/all/20220903012849.938069-4-vannapurve@google.com/T/

Regards,
Vishal
