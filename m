Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEDD6A253C
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 00:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBXX4L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 18:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBXX4K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 18:56:10 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B664988A
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 15:56:09 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s18so544707pgq.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 15:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=roI2102NVn8tZj8AT0mqQAS15kZ5FO9em57hIeDNwj0=;
        b=QB5cj7QKPC4eETDdYpgWnv3fyPKxoD9KZMEpY6QM0fHRGhMhDE4uxjfcIAoTovvyd6
         h+ff9uW223/aV2TtJYDG4H6O5DdJAERUpY6e/VUR8g2Xbvv7rG6lSk2Zft5rgHL4mPqi
         nnEugeB85k/jI5MnwhOTyqWPfmvxztT6Aj8C4yKN8OcWw4L+GP1tAnKhiSLAKgq49Co4
         GljDwHscPWZ7fNKEpdlUBZ4r2+JKDNTJ4H/B3enW9G2Cw5JmeLX1Ftn3pzzBDR1u9A3t
         Ihqm3IYqgD5EuUqKgbBYpq6HyScjibA9/wo5+/onFYXHUBFrrgKD/WYgI0F2XJrs76+B
         wnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roI2102NVn8tZj8AT0mqQAS15kZ5FO9em57hIeDNwj0=;
        b=kxoFfWj6zrRhf4npmVVMShcpr/QS3f2jP2bYhbbBHQAPvpmRLk1WIA3+q8fK4UaTCY
         hzxCSX0HzVoA6Jra8y5UyUe2jMZlTsIO202fQErh33vnPJ1l36u1OfMV0ZtHaYCG12ds
         qh4FA2JSIC37ewvjZo7jHpckRlz16u8MpG9l88rtRMnkuoU+NLgMAvjBrCO5mPpd5oeb
         qVTv642bHRM5al5IdzmnXHSNiXEhxF0viGYCtZjnTTSBG4Fqf5tiUujNCSjSN1QWiqM8
         ecMLX8i1gbVfh7um76k64Y27cb8eMh8VZrzRateATJ3Vho5rvDcEZdEZS3Oxc6PCFtg6
         QrSQ==
X-Gm-Message-State: AO0yUKX7x/mGu5gf5QONhxxrLEKtR0Uh1+H8zB+m2XuOFj0Ti4Bo5wmw
        eYMPuDeAcVqnkEqnt5VKfUhJZg==
X-Google-Smtp-Source: AK7set91H8uZuErh0/LuDjee/awTv2DYiHBWv4zGyaBtHG2f3acLLiXNiqNVrCCS2NWZB/r598n+iw==
X-Received: by 2002:aa7:9ed2:0:b0:5e3:2f9b:b5e8 with SMTP id r18-20020aa79ed2000000b005e32f9bb5e8mr3480281pfq.4.1677282968888;
        Fri, 24 Feb 2023 15:56:08 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id s25-20020a63af59000000b004f1cb6ffe81sm45530pgo.64.2023.02.24.15.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 15:56:08 -0800 (PST)
Date:   Fri, 24 Feb 2023 23:56:04 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Chao Gao <chao.gao@intel.com>
Subject: Re: [PATCH v3 01/13] x86/fpu/xstate: Avoid getting xstate address of
 init_fpstate if fpstate contains the component
Message-ID: <Y/lOlBWTNgROPl0P@google.com>
References: <20230221163655.920289-1-mizhang@google.com>
 <20230221163655.920289-2-mizhang@google.com>
 <e91b9172-8a2e-e299-a84f-1e9331c51cb7@intel.com>
 <87ilfum6xh.ffs@tglx>
 <CAL715WKLQxxeyFqiKbKsUmQ8bZf2f=rwADyKj1ftgROA+dhpXg@mail.gmail.com>
 <ea9d7394-73dd-23c0-ea05-d0ec4fcebb55@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea9d7394-73dd-23c0-ea05-d0ec4fcebb55@intel.com>
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

On Wed, Feb 22, 2023, Chang S. Bae wrote:
> On 2/22/2023 10:40 AM, Mingwei Zhang wrote:
> > > > We have this [1]:
> > > > 
> > > >        if (fpu_state_size_dynamic())
> > > >                mask &= (header.xfeatures | xinit->header.xcomp_bv);
> > > > 
> > > > If header.xfeatures[18] = 0 then mask[18] = 0 because
> > > > xinit->header.xcomp_bv[18] = 0. Then, it won't hit that code. So, I'm
> > > > confused about the problem that you described here.
> > > 
> > > Read the suggested changelog I wrote in my reply to Mingwei.
> > > 
> > > TLDR:
> > > 
> > >          xsave.header.xfeatures[18] = 1
> > >          xinit.header.xfeatures[18] = 0
> > >      ->  mask[18] = 1
> > >      ->  __raw_xsave_addr(xsave, 18)     <- Success
> > >      ->  __raw_xsave_addr(xinit, 18)     <- WARN
> 
> Oh, sigh.. This should be caught last time.
> 
> Hmm, then since we store init state for legacy ones [1], unless it is too
> aggressive, perhaps the loop can be simplified like this:
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 714166cc25f2..2dac6f5f3ade 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1118,21 +1118,13 @@ void __copy_xstate_to_uabi_buf(struct membuf to,
> struct fpstate *fpstate,
>         zerofrom = offsetof(struct xregs_state, extended_state_area);
> 
>         /*
> -        * The ptrace buffer is in non-compacted XSAVE format.  In
> -        * non-compacted format disabled features still occupy state space,
> -        * but there is no state to copy from in the compacted
> -        * init_fpstate. The gap tracking will zero these states.
> +        * Indicate which states to copy from fpstate. When not present in
> +        * fpstate, those extended states are either initialized or
> +        * disabled. They are also known to have an all zeros init state.
> +        * Thus, remove them from 'mask' to zero those features in the user
> +        * buffer instead of retrieving them from init_fpstate.
>          */
> -       mask = fpstate->user_xfeatures;

Do we need to change this line and the comments? I don't see any of
these was relevant to this issue. The original code semantic is to
traverse all user_xfeatures, if it is available in fpstate, copy it from
there; otherwise, copy it from init_fpstate. We do not assume the
component in init_fpstate (but not in fpstate) are all zeros, do we? If
it is safe to assume that, then it might be ok. But at least in this
patch, I want to keep the original semantics as is without the
assumption.
> -
> -       /*
> -        * Dynamic features are not present in init_fpstate. When they are
> -        * in an all zeros init state, remove those from 'mask' to zero
> -        * those features in the user buffer instead of retrieving them
> -        * from init_fpstate.
> -        */
> -       if (fpu_state_size_dynamic())
> -               mask &= (header.xfeatures | xinit->header.xcomp_bv);
> +       mask = header.xfeatures;

Same here. Let's not adding this optimization in this patch.

>
>         for_each_extended_xfeature(i, mask) {
>                 /*
> @@ -1151,9 +1143,8 @@ void __copy_xstate_to_uabi_buf(struct membuf to,
> struct fpstate *fpstate,
>                         pkru.pkru = pkru_val;
>                         membuf_write(&to, &pkru, sizeof(pkru));
>                 } else {
> -                       copy_feature(header.xfeatures & BIT_ULL(i), &to,
> +                       membuf_write(&to,
>                                      __raw_xsave_addr(xsave, i),
> -                                    __raw_xsave_addr(xinit, i),
>                                      xstate_sizes[i]);
>                 }
>                 /*
> 
> > Chang: to reproduce this issue, you can simply run the amx_test in the
> > kvm selftest directory.
> 
> Yeah, I was able to reproduce it with this ptrace test:
> 
> diff --git a/tools/testing/selftests/x86/amx.c
> b/tools/testing/selftests/x86/amx.c
> index 625e42901237..ae02bc81846d 100644
> --- a/tools/testing/selftests/x86/amx.c
> +++ b/tools/testing/selftests/x86/amx.c
> @@ -14,8 +14,10 @@
>  #include <sys/auxv.h>
>  #include <sys/mman.h>
>  #include <sys/shm.h>
> +#include <sys/ptrace.h>
>  #include <sys/syscall.h>
>  #include <sys/wait.h>
> +#include <sys/uio.h>
> 
>  #include "../kselftest.h" /* For __cpuid_count() */
> 
> @@ -826,6 +828,76 @@ static void test_context_switch(void)
>         free(finfo);
>  }
> 
> +/* Ptrace test */
> +
> +static bool inject_tiledata(pid_t target)
> +{
> +       struct xsave_buffer *xbuf;
> +       struct iovec iov;
> +
> +       xbuf = alloc_xbuf();
> +       if (!xbuf)
> +               fatal_error("unable to allocate XSAVE buffer");
> +
> +       load_rand_tiledata(xbuf);
> +
> +       memcpy(&stashed_xsave->bytes[xtiledata.xbuf_offset],
> +              &xbuf->bytes[xtiledata.xbuf_offset],
> +              xtiledata.size);
> +
> +       iov.iov_base = xbuf;
> +       iov.iov_len = xbuf_size;
> +
> +       if (ptrace(PTRACE_SETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
> +               fatal_error("PTRACE_SETREGSET");
> +
> +       if (ptrace(PTRACE_GETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
> +               err(1, "PTRACE_GETREGSET");
> +
> +       if (!memcmp(&stashed_xsave->bytes[xtiledata.xbuf_offset],
> +                   &xbuf->bytes[xtiledata.xbuf_offset],
> +                   xtiledata.size))
> +               return true;
> +       else
> +               return false;
> +}
> +
> +static void test_ptrace(void)
> +{
> +       pid_t child;
> +       int status;
> +
> +       child = fork();
> +       if (child < 0) {
> +               err(1, "fork");
> +       } else if (!child) {
> +               if (ptrace(PTRACE_TRACEME, 0, NULL, NULL))
> +                       err(1, "PTRACE_TRACEME");
> +
> +               /* Use the state to expand the kernel buffer */
> +               load_rand_tiledata(stashed_xsave);
> +
> +               raise(SIGTRAP);
> +               _exit(0);
> +       }
> +
> +       do {
> +               wait(&status);
> +       } while (WSTOPSIG(status) != SIGTRAP);
> +
> +       printf("\tInject tile data via ptrace()\n");
> +
> +       if (inject_tiledata(child))
> +               printf("[OK]\tTile data was written on ptracee.\n");
> +       else
> +               printf("[FAIL]\tTile data was not written on ptracee.\n");
> +
> +       ptrace(PTRACE_DETACH, child, NULL, NULL);
> +       wait(&status);
> +       if (!WIFEXITED(status) || WEXITSTATUS(status))
> +               err(1, "ptrace test");
> +}
> +
>  int main(void)
>  {
>         /* Check hardware availability at first */
> @@ -846,6 +918,8 @@ int main(void)
>         ctxtswtest_config.num_threads = 5;
>         test_context_switch();
> 
> +       test_ptrace();
> +
>         clearhandler(SIGILL);
>         free_stashed_xsave();
> 
> Thanks,
> Chang
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/xstate.c#n386
> 

Nice one. Yeah both ptrace and KVM are calling this function so the above
code would also be enough to trigger the bug.


Thanks.
-Mingwei
