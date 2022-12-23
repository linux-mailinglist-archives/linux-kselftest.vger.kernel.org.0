Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54CC654B3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 03:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbiLWCpy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 21:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbiLWCpw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 21:45:52 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DDD658D
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 18:45:51 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id pe2so1822079qkn.1
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 18:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4UrofSbdl+C6A9lzo2rqAxbwXxwbQHhboDQcCP08AVs=;
        b=Lpnix6oNDWoFZvxMmSBUPh6xB8tC770ufiXs3ME+XJXtqOaqF8fH/SsAmU65Vnm4WV
         /jTX/kqPMnTqYCSrVArd6OkeglyxX6Wd3AbhqDkpT2MumPg1me+7c7RxQNGWbgu/0atk
         MfW5mntF4iCmFJEb35ElYo4w1rTiSRuU0wOo6CB5KJnDw/xa9PAxPaVjNucWQtDI970p
         EY5zkdmzK0R4zQYpDkJvDNgeWm7DaFTvdt+9sF1r3AnXu3YkhfkuZHua3S4/k2ON5Tgs
         fmAvrEDow1rMeAbYcxYn2+lnQEoRwLItIHKMlzsFU1l1331UiUig6gl4o2u/Pv95kPWE
         RgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UrofSbdl+C6A9lzo2rqAxbwXxwbQHhboDQcCP08AVs=;
        b=DgLgB2VcLM14Qdf64dXaDPbcOZJG56W1AcbeArjM4BrARs5J1ozNJeTs9a3o09NuOy
         p3+1SLP/sTi3bbjQb7MCoAJuxbh3euHAcK+PPxK4CJzCGX0sWPqMWFD8b1zXI7pS92N7
         Gt6/JFvKwHYYRRO6CpakQfNKtnN2vw3BFSytKGGwOpSzXK2cZvlCWsryWMSmTvID6z0f
         FVE0PGKpGJy1IwA5tBXPyJ+j0gVovv70tzpBqz99uQEAT6J5os2704Sed67GBIgFfECU
         tSWJZRJL30WUaRQBbMuUSN+ClUlxIdM/r+YprDtAFxO9lZ5FkES3lzz6DJa/E1GALB2f
         onKw==
X-Gm-Message-State: AFqh2koNRluzLtYggluReaXCxkyo9rwQYOPJqwlEJ2GiKqNfxG4XCD1L
        Gel7JhbnsRCOfDwXOhmojcllrps5+FRcW+uqxv7UeA==
X-Google-Smtp-Source: AMrXdXtfbv6l9qwrsUSdfL8YJpaujUMQbBBunctVhWPsQQWQaCujiZNfoHhnWrXcOYIWaF+l1phoI+i4xOBXO+ZRYfs=
X-Received: by 2002:a05:620a:5311:b0:702:5666:b931 with SMTP id
 oo17-20020a05620a531100b007025666b931mr397291qkn.245.1671763550398; Thu, 22
 Dec 2022 18:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20221222230458.3828342-1-vannapurve@google.com>
 <20221222230458.3828342-2-vannapurve@google.com> <Y6T1S8GSuwf08StX@google.com>
In-Reply-To: <Y6T1S8GSuwf08StX@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Thu, 22 Dec 2022 18:45:39 -0800
Message-ID: <CAGtprH-cZZDEfer9TCd7RwNGS9gCxQYWpPD8cDNvxwLqyvQgXQ@mail.gmail.com>
Subject: Re: [V3 PATCH 1/2] KVM: selftests: x86: Cache the cpu vendor type
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com,
        pgonda@google.com, andrew.jones@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 22, 2022 at 4:24 PM Sean Christopherson <seanjc@google.com> wrote:
>
> ...
> Though that's likely a moot point since manually checking the chunks (multiple
> times!) is rather heinous.  Just store the CPUID output into an array and then
> use strncmp() to check the vendor.  Performance isn't a priority for this code.
>
>   static void cache_cpu_vendor(void)
>   {
>         uint32_t ign, vendor[3];
>         static bool cached;
>
>         if (cached)
>                 return;
>
>         cpuid(0, &ign, &vendor[0], &vendor[2], &vendor[1]);
>
>         is_cpu_vendor_intel = !strncmp((char *)vendor, "GenuineIntel", 12);
>         is_cpu_vendor_amd = !strncmp((char *)vendor, "AuthenticAMD", 12);
>
>         cached = true;
>   }

You probably mean to suggest using memcmp here since this section will
get executed from the guest context (which may not have access to
strncmp). Makes sense to structure the implementation this way as I
get more comfortable using string_override.c.

>
> That said, I like the v2 approach a lot more, we just need to better name the
> host variables to make it very clear that the info being cached is the _host_
> vendor, and then provide separate helpers that bypass caching (though I don't
> think there would be any users?), again with better names.
>
> The confidential VM use case, and really kvm_hypercall() in general, cares about
> the host vendor, i.e. which hypercall instruction won't fault.  Actually, even
> fix_hypercall_test is in the same boat.
>

Ok, I misunderstood the earlier discussion [1] about using host cpuid
to check the vendor type instead of the guest cpuid being problematic.
If all the current and foreseeable users would be ok with native
hypercall using host cpuid then I will fall back to approach in V2.

[1] https://lore.kernel.org/lkml/Y1Hhw40H58EmZ6lK@google.com/

> I don't like auto-caching the guest info because unlike the host (assuming no
> shenanigans in a nested setup), the guest vendor string can be changed.  I don't
> think it's likely that we'll have a test that wants to muck with the vendor string
> on the fly, but it's not impossible, e.g. fix_hypercall_test dances pretty close
> to that.
>
> The independent guest vs. host caching in this version is also very subtle, though
> that can be solved with comments.
>
> E.g. first make is_intel_cpu() and is_amd_cpu() wrappers to non-caching helpers
> that use "this_cpu_..." naming to match other selftests code.  Then rename
> is_intel_cpu() and is_amd_cpu() to is_{intel,amd}_host(), with a blurb in the
> changelog calling out that fix_hypercall_test wants the host vendor and also passes
> through the host CPUID vendor.  And then do the precomputation stuff like in v2.
>
> E.g. for step #1
>
> ---
>  .../selftests/kvm/include/x86_64/processor.h  | 22 +++++++++++++++++++
>  .../selftests/kvm/lib/x86_64/processor.c      | 13 ++---------
>  2 files changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index b1a31de7108a..34523a876336 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -554,6 +554,28 @@ static inline uint32_t this_cpu_model(void)
>         return x86_model(this_cpu_fms());
>  }
>
> +static inline bool this_cpu_vendor_string_is(const char *vendor)
> +{
> +       const uint32_t *chunk = (const uint32_t *)vendor;
> +       uint32_t eax, ebx, ecx, edx;
> +
> +       cpuid(0, &eax, &ebx, &ecx, &edx);
> +       return (ebx == chunk[0] && edx == chunk[1] && ecx == chunk[2]);
> +}
> +
> +static inline bool this_cpu_is_intel(void)
> +{
> +       return this_cpu_vendor_string_is("GenuineIntel");
> +}
> +
> +/*
> + * Exclude early K5 samples with a vendor string of "AMDisbetter!"
> + */
> +static inline bool this_cpu_is_amd(void)
> +{
> +       return this_cpu_vendor_string_is("AuthenticAMD");
> +}
> +
>  static inline uint32_t __this_cpu_has(uint32_t function, uint32_t index,
>                                       uint8_t reg, uint8_t lo, uint8_t hi)
>  {
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index c4d368d56cfe..fae1a8a81652 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1006,18 +1006,9 @@ void kvm_x86_state_cleanup(struct kvm_x86_state *state)
>         free(state);
>  }
>
> -static bool cpu_vendor_string_is(const char *vendor)
> -{
> -       const uint32_t *chunk = (const uint32_t *)vendor;
> -       uint32_t eax, ebx, ecx, edx;
> -
> -       cpuid(0, &eax, &ebx, &ecx, &edx);
> -       return (ebx == chunk[0] && edx == chunk[1] && ecx == chunk[2]);
> -}
> -
>  bool is_intel_cpu(void)
>  {
> -       return cpu_vendor_string_is("GenuineIntel");
> +       return this_cpu_is_intel();
>  }
>
>  /*
> @@ -1025,7 +1016,7 @@ bool is_intel_cpu(void)
>   */
>  bool is_amd_cpu(void)
>  {
> -       return cpu_vendor_string_is("AuthenticAMD");
> +       return this_cpu_is_amd();
>  }
>
>  void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
>
> base-commit: d70e740240a298d0ff54d26f48f2fb034e3cb172
> --
>

Ack.
