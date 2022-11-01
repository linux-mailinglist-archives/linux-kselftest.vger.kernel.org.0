Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269F36147E7
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 11:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKAKsJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 06:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAKsJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 06:48:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5174A193E5
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 03:48:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d24so13198764pls.4
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Nov 2022 03:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TMxfFnQEzQ8AbsMFHJGkF0WYebtIumwrSeVhJx0ftUI=;
        b=UqNCRBe9TgKtGt2+WEXUrx+W0tS0e/IfA/QOOT+HS2ZcyjUxt7tItX0VNLUJeuwS82
         F0U7/pL0aUC2rZLIHu9Faf+fE9VVZWxFy8YZYspyY3TserZI2PzhqkSzcxIqLdyGmsFV
         cFjj+yxAwFl87zQ56vsUahVXHUZUkaPABqLDZOjr4HuJknaso3FzFqiWZQ4uHvT9XPg7
         g5dSbdxneGubPCenpXtPXmGr7JChDQHBYSKt1IpXCaQf+HsYP/Otn9NP961qMPTzwuoH
         LebOSHfm8irgvL6j3Vp+iuSWriYqFtolOTTt2lXTXa7xk2Os+nLrXHecam+mxsrI7CB+
         KUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMxfFnQEzQ8AbsMFHJGkF0WYebtIumwrSeVhJx0ftUI=;
        b=AAs5Xq42s2ADYvn9vEMOJ0c8QDeqHpziiYFcYe8O5OCEUPn6Tui2H5fis85QTtDFhx
         aGjKIBpmiNxJh0wQEaFw2Xv85AcM/jfCG3EXzCkYrOxe49LgrvEmwkstJA1LDeMGDKgL
         N/sr61izIo8xMvbvzj4MdtEZ9A/2UKF9uYyxzbdK08Jm2/WVdyxaev1fUr7cp87q2FfH
         JIMn/5xpiHYSAzu8tPBWIkETy/dijdQbBsMisQZp8vNmxKeUr4YYJCxwlqcJDx5vUuTA
         JYxOFRNBFyyuB/JIkLEWkwhH1AyVNWABXN5YdZ02Mo4l4e+XXeX8O9I4b1bEUoxFlqM5
         cuOA==
X-Gm-Message-State: ACrzQf3IHFA5o8YYMHp0gBQu/Wg7ZNsOwwjsnZeDA+ad4njBbcE7jSpW
        trU9spXBqKdBquq05cRVrP+x5ZIB6NljwEpLE/j8RQ==
X-Google-Smtp-Source: AMsMyM4QXwuQisJZcrtUtmStzzQ1dKTn2YwaMqyArI5euBjHzZ2nKC1dCA5XdgPaN/E2MUHBVQCg8vVsOA0krMCqZME=
X-Received: by 2002:a17:903:264b:b0:186:af7a:391d with SMTP id
 je11-20020a170903264b00b00186af7a391dmr18965064plb.19.1667299687554; Tue, 01
 Nov 2022 03:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221013121319.994170-1-vannapurve@google.com>
 <20221013121319.994170-5-vannapurve@google.com> <Y1Hhw40H58EmZ6lK@google.com>
In-Reply-To: <Y1Hhw40H58EmZ6lK@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Tue, 1 Nov 2022 16:17:55 +0530
Message-ID: <CAGtprH90U_gNGOxnOey3k=F8+HdC0zW+xk0ZxD4VNzaDey0sLw@mail.gmail.com>
Subject: Re: [V3 PATCH 4/4] KVM: selftests: x86: Precompute the cpu type
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 21, 2022 at 5:33 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Oct 13, 2022, Vishal Annapurve wrote:
> > Cache the vendor CPU type in a global variable so that multiple calls
> > to is_amd/intel_cpu() do not need to re-execute CPUID.
> >
> > Sync the global variable is_cpu_amd into the guest so the guest can also
> > avoid executing CPUID instruction.
> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > ---
> >  tools/testing/selftests/kvm/lib/x86_64/processor.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > index fa65e8142c16..f508e58346e9 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > @@ -19,6 +19,7 @@
> >  #define MAX_NR_CPUID_ENTRIES 100
> >
> >  vm_vaddr_t exception_handlers;
> > +static bool is_cpu_amd;
>
> This should probably have a "host" qualifier, e.g. is_host_cpu_amd.  More below.
>

Ack.

> >
> >  static void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent)
> >  {
> > @@ -1046,7 +1047,7 @@ static bool cpu_vendor_string_is(const char *vendor)
> >
> >  bool is_intel_cpu(void)
>
> It'll be more churn, but I think we should drop the wrappers in this patch so
> that we can visually audit all users.  There is technically a subtle functional
> change here, as previously executing is_intel_cpu() and is_amd_cpu() in the guest
> will consume the _guest_ CPUID, whereas with this change, the guest will now
> consume the _host_ CPUID.
>
> It just so happens that the existing user and the new user both want to query
> Intel vs. AMD for VMCALL vs. VMMCALL, i.e. care about the host even when checking
> from the guest.  It's extreme paranoia since I don't think there are any parallel
> series that are adding is_intel_cpu()/is_amd_cpu() users, not to mention that I
> don't think any selftests does cross-vendor virtualization, but on the other hand
> the paranoia doesn't cost much.
>

Ack. I think this patch should also be the part of a different series
which deals with executing hypercall according to the cpu type, there
is no immediate need for this change in this series.

Will incorporate your feedback in the next version of this patch.

> >  {
> > -     return cpu_vendor_string_is("GenuineIntel");
> > +     return !is_cpu_amd;
>
> Please keep the explicit "GenuineIntel" check, i.e. add is_host_cpu_intel.  KVM
> technically supports other vendors, e.g. Centaur and Zhaoxin for VMX, and Hygon
> for AMD, so it's not impossible that someone could run on Centuar or Zhaoxin and
> get a false positive.  Again, extreme paranoia, but doesn't cost much.
>

Ack, makes sense.

> >  }
> >
> >  /*
> > @@ -1054,7 +1055,7 @@ bool is_intel_cpu(void)
> >   */
> >  bool is_amd_cpu(void)
> >  {
> > -     return cpu_vendor_string_is("AuthenticAMD");
> > +     return is_cpu_amd;
> >  }
> >
> >  void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
> > @@ -1328,8 +1329,13 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
> >       return get_kvm_intel_param_bool("unrestricted_guest");
> >  }
> >
> > +void kvm_selftest_arch_init(void)
> > +{
> > +     is_cpu_amd = cpu_vendor_string_is("AuthenticAMD");
> > +}
> >
> >  void kvm_arch_vm_post_create(struct kvm_vm *vm)
> >  {
> >       vm_create_irqchip(vm);
> > +     sync_global_to_guest(vm, is_cpu_amd);
> >  }
> > --
> > 2.38.0.rc1.362.ged0d419d3c-goog
> >
